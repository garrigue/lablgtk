(* $Id$ *)

open StdLabels
open MoreLabels

let caml_keywords = ["type","kind"; "class","classe"; "list", "liste"]
let caml_modules = ["List", "Liste"]

let camlize id =
  let b = Buffer.create (String.length id + 4) in
  for i = 0 to String.length id - 1 do
    if id.[i] >= 'A' && id.[i] <= 'Z' then begin
      if i > 0 then Buffer.add_char b '_';
      Buffer.add_char b (Char.lowercase id.[i])
    end
    else if id.[i] = '-' then Buffer.add_char b '_'
    else Buffer.add_char b id.[i]
  done;
  let s = Buffer.contents b in
  try List.assoc s caml_keywords with Not_found -> s

let camlizeM s =
  try List.assoc s caml_modules with Not_found -> s

let check_suffix s suff =
  let len1 = String.length s and len2 = String.length suff in
  len1 > len2 && String.sub s (len1-len2) len2 = suff

(* Arity of a caml type. Doesn't handle object types... *)
let arity s =
  let parens = ref 0 and arity = ref 0 in
  for i = 0 to String.length s - 1 do
    if s.[i] = '(' || s.[i] = '[' then incr parens else
    if s.[i] = ')' || s.[i] = ']' then decr parens else
    if !parens = 0 && s.[i] = '-' && s.[i+1] = '>' then incr arity
  done;
  if !parens <> 0 then failwith ("bad type : " ^ s);
  !arity

let conversions = Hashtbl.create 17

let enums = [
  "Gtk", "GtkEnums",
  [ "Justification"; "ArrowType"; "ShadowType"; "ResizeMode";
    "ReliefStyle"; "ImageType"; "WindowType"; "WindowPosition";
    "ButtonsType"; "MessageType"; "ButtonBoxStyle"; "PositionType";
    "Orientation"; "ToolbarStyle"; "IconSize"; "PolicyType";
    "CornerType"; "SelectionMode"; "SortType"; "WrapMode";
    "SpinButtonUpdatePolicy"; "UpdateType"; "ProgressBarStyle";
    "ProgressBarOrientation"; "CellRendererMode";
    "TreeViewColumnSizing"; "SortType"; "TextDirection";
    (* in signals *)
    "MovementStep"; "ScrollType"; "MenuDirectionType"; "DeleteType";
    "StateType";
    (* for canvas *)
    "AnchorType"; "DirectionType"; 
  ];
  "Gdk", "GdkEnums",
  [ "ExtensionMode"; "WindowTypeHint"; "EventMask";
    (* for canvas *)
    "CapStyle"; "JoinStyle"; "LineStyle"];
  "Pango", "PangoEnums",
  [ "Stretch"; "Style"; "Underline"; "Variant"; ]
]

(* These types must be registered with g_boxed_register! *)
let boxeds = [
  "Gdk", ["Color"; "Font";];
  "Pango", ["FontDescription";];
  "Gtk", ["IconSet";"TextIter";"TreePath"; "TreeIter";];
]

let classes = [
  "Gdk", [ "Image"; "Pixmap"; "Bitmap"; "Screen"; ];
  "Gtk", [ "Style"; "TreeStore"; ]
]

let specials = [
  "GtkWidget", "GObj.conv_widget";
  "GtkWidget_opt", "GObj.conv_widget_option";
  "GtkAdjustment", "GData.conv_adjustment";
  "GtkAdjustment_opt", "GData.conv_adjustment_option";
]

let add_pointer conv gtk name =
  Hashtbl.add conversions gtk
    (Printf.sprintf "(%s : %s data_conv)" conv name);
  Hashtbl.add conversions (gtk ^ "_opt")
    (Printf.sprintf "(%s_option : %s option data_conv)" conv name)

let add_object = add_pointer "gobject"
let add_boxed = add_pointer "unsafe_boxed"

let () =
  List.iter ~f:(fun t -> Hashtbl.add conversions ("g"^t) t)
    [ "boolean"; "char"; "uchar"; "int"; "uint"; "long"; "ulong";
      "int32"; "uint32"; "int64"; "uint64"; "float"; "double" ];
  List.iter ~f:(fun (gtype,conv) -> Hashtbl.add conversions gtype conv)
    [ "gchararray", "string";
      "gchararray_opt", "string_option";
      "string", "string"; "bool", "boolean"; "int", "int";
    ];
  List.iter enums ~f:(fun (pre, modu, l) ->
    List.iter l ~f:
      begin fun name ->
        Hashtbl.add conversions (pre ^ name)
          (Printf.sprintf "%s.%s_conv" modu (camlize name))
      end);
  List.iter boxeds ~f:(fun (pre, l) ->
    List.iter l ~f:(fun name -> add_boxed (pre^name) (pre^"."^camlize name)));
  List.iter classes ~f:(fun (pre,l) ->
    List.iter l ~f:(fun t -> add_object (pre^t) (pre^"."^camlize t)))

open Genlex

let lexer = make_lexer ["{"; "}"; ":"; "/"; "("; ")";"->";"method";"signal"]

let rec star ?(acc=[]) p = parser
    [< x = p ; s >] -> star ~acc:(x::acc) p s
  | [< >] -> List.rev acc

let may_token tok s =
  if Stream.peek s = Some tok then Stream.junk s

let ident = parser [< ' Ident id >] -> id

let string = parser [< ' String s >] -> s

let may_string def = parser
    [< ' String s >] -> s
  | [< >] -> def

let may_name s = parser
    [< ' Kwd"("; ' Ident id; ' Kwd")" >] -> id
  | [< >] -> (camlize s)

let next_attr = parser
    [< ' Kwd"/"; ' Ident id; ids = star ~acc:[id] ident >] ->
      String.concat ~sep:"" ids

let attributes =
  ["Read";"Write";"Construct";"ConstructOnly";"NoSet";"Set";
   "NoWrap";"Wrap";"NoGet";"VSet";"NoVSet"]

let return_type types = parser
    [< ' Kwd"->"; ' Ident ret >] -> `Types (types, ret)
  | [< >] -> `Types (types, "")

let marshaller = parser
  | [< ' String s >] -> `Function s
  | [< ' Kwd":"; types = star ident; s >] -> return_type types s
  | [< >] -> `Types ([], "")

let may_type = parser
  | [< ' Kwd":"; ' String s >] -> s
  | [< >] -> "unit"

let field = parser
    [< ' String name; mlname = may_name name; ' Ident gtype; ' Kwd":";
       ' Ident attr0; attrs = star ~acc:[attr0] next_attr >] ->
         if List.exists attrs ~f:(fun x -> not (List.mem x attributes))
         then raise (Stream.Error "bad attribute");
         `Prop (name, mlname, gtype, attrs)
  | [< ' Kwd"method"; ' Ident name; ty = may_type >] ->
      `Method (name, ty)
  | [< ' Kwd"signal"; ' Ident name; m = marshaller >] ->
      `Signal (name, m)

let split_fields l =
  List.fold_right l ~init:([],[],[]) ~f:
    (fun field (props,meths,sigs) -> match field with
      `Prop p   -> (p::props,meths,sigs)
    | `Method m -> (props,m::meths,sigs)
    | `Signal s -> (props,meths,s::sigs))

let verb_braces = ref 0

let rec verbatim buf = parser
  | [< ''}' ; s >] ->
      if !verb_braces = 0 then Buffer.contents buf else begin
        decr verb_braces; Buffer.add_char buf '}'; verbatim buf s;
      end
  | [< ''{'; s >] ->
      Buffer.add_char buf '{'; incr verb_braces; verbatim buf s
  | [< ''\\' ; 'c ; s >] ->
      if c <> '}' && c <> '{' then Buffer.add_char buf '\\';
      Buffer.add_char buf c; verbatim buf s
  | [< 'c ; s >] -> Buffer.add_char buf c; verbatim buf s

let read_pair = parser
  | [< ' Ident cls ; data = may_string (camlize cls) >] -> (cls,data)

let qualifier = parser
  | [< ' Ident id ; data = may_string "" >] -> (id,data)

let prefix = ref ""
let tagprefix = ref ""
let use = ref ""
let decls = ref []
let headers = ref []
let checks = ref false
let class_qualifiers = ["abstract";"hv";"set";"wrap";"wrapset";"vset";"tag"]


let process_phrase ~chars = parser
    [< ' Ident"class"; ' Ident name; gtk_name = may_string (!prefix ^ name);
       attrs = star qualifier; ' Kwd":"; ' Ident parent;
       ' Kwd"{"; fields = star field; ' Kwd"}" >] ->
         if List.exists attrs ~f:
             (fun (x,_) -> not (List.mem x class_qualifiers))
         then raise (Stream.Error "bad qualifier");
         let props, meths, sigs = split_fields fields in
         decls := (name, gtk_name, attrs, props, meths, sigs) :: !decls
  | [< ' Ident"header"; ' Kwd"{" >] ->
      let h = verbatim (Buffer.create 1000) chars in
      headers := !headers @ [h]
  | [< ' Ident"prefix"; ' String id >] ->
      prefix := id
  | [< ' Ident"tagprefix"; ' String id >] ->
      tagprefix := id
  | [< ' Ident"use"; ' String id >] ->
      use := id
  | [< ' Ident"conversions"; pre1 = may_string ""; pre2 = may_string pre1;
       ' Kwd"{"; l = star read_pair; ' Kwd"}" >] ->
      List.iter l ~f:(fun (k,d) ->
        Hashtbl.add conversions (pre1^k) (if pre2="" then d else pre2^"."^d))
  | [< ' Ident"classes"; ' Kwd"{"; l = star read_pair; ' Kwd"}" >] ->
      List.iter l ~f:(fun (k,d) -> add_object k d)
  | [< ' Ident"boxed"; ' Kwd"{"; l = star read_pair; ' Kwd"}" >] ->
      List.iter l ~f:(fun (k,d) -> add_boxed k d)
  | [< ' _ >] ->
      raise (Stream.Error "")
  | [< >] ->
      raise End_of_file

let all_props = Hashtbl.create 137
let all_pnames = Hashtbl.create 137

let process_file f =
  let base = Filename.chop_extension f in
  let baseM = String.capitalize base in
  prefix := baseM;
  (* Input *)
  headers := [];
  let ic = open_in f in
  let chars = Stream.of_channel ic in
  let s = lexer chars in
  begin try while true do process_phrase ~chars s done with
    End_of_file -> ()
  | Stream.Error _ | Stream.Failure ->
      Printf.eprintf "Parse error in file `%s' before char %d\n"
        f (Stream.count chars);
      exit 2
  | exn ->
      Printf.eprintf "Exception %s in file `%s' before char %d\n"
        (Printexc.to_string exn) f (Stream.count chars);
      exit 2
  end;
  (* Preproccess *)
  let decls = List.rev !decls in
  List.iter decls ~f:
    (fun (name, gtk_name, _, _, _, _) ->
      add_object gtk_name (baseM ^ "." ^ camlize name ^ " obj"));
  (* Output modules *)
  let oc = open_out (base ^ "Props.ml") in
  let ppf = Format.formatter_of_out_channel oc in
  let out fmt = Format.fprintf ppf fmt in
  List.iter !headers ~f:(fun s -> out "%s@." s);
  let decls =
    List.map decls ~f:
      begin fun (name, gtk_name, attrs, props, meths, sigs) ->
        (name, gtk_name, attrs,
         List.filter props ~f:
           begin fun (name,_,gtype,_) ->
             try ignore (Hashtbl.find conversions gtype);
               try
                 let count, _ = Hashtbl.find all_props (name,gtype) in
                 incr count;
                 true
               with Not_found ->
                 Hashtbl.add all_props (name,gtype) (ref 1, ref ""); true
             with Not_found ->
               prerr_endline ("Warning: no conversion for type " ^ gtype);
               false
           end,
         meths,
         List.filter sigs ~f:
           begin function
           | _, `Function _ -> true
           | _, `Types(l, ret) ->
               List.for_all (if ret = "" then l else ret::l) ~f:
                 (fun ty ->
                   if Hashtbl.mem conversions ty then true else
                   (prerr_endline ("Warning: no conversion for type " ^ ty);
                    false))
           end)
      end in
  let defprop ~name ~mlname ~gtype ~tag =
    let conv = Hashtbl.find conversions gtype in
    out "@ @[<hv2>let %s " mlname;
    if tag <> "gtk" then out ": ([>`%s],_) property " tag;
    out "=@ @[<hov1>{name=\"%s\";@ conv=%s}@]@]" name conv
  in
  let shared_props =
    Hashtbl.fold all_props ~init:[] ~f:
      begin fun ~key:(name,gtype) ~data:(count,rpname) acc ->
        if !count <= 1 then acc else
        let pname = camlize name in
        let pname =
          if Hashtbl.mem all_pnames pname then pname ^ "_" ^ gtype
          else (Hashtbl.add all_pnames pname (); pname) in
        rpname := "Shared." ^ pname;
        (pname,name,gtype) :: acc
      end
  in
  if shared_props <> [] then begin
    out "@[<hv2>module Shared = struct";
    List.iter (List.sort compare shared_props) ~f:
      (fun (pname,name,gtype) ->
        defprop ~name ~mlname:pname ~gtype ~tag:"gtk");
    out "@]\nend\n@.";
  end;
  (* Redefining saves space in bytecode! *)
  out "let may_cons = Property.may_cons\n";
  out "let may_cons_opt = Property.may_cons_opt\n@.";
  let may_cons_props props =
    if props <> [] then begin
      out "@ @[<hv2>let pl = ";
      List.iter props ~f:
        begin fun (name,mlname,gtype,_) ->
          let op =
            if check_suffix gtype "_opt" then "may_cons_opt" else "may_cons"
          in
          out "(@;<0>%s P.%s %s " op (camlize name) mlname;
        end;
      out "pl";
      for k = 1 to List.length props do out ")" done;
      out " in@]"
    end
  in
  List.iter decls ~f:
    begin fun (name, gtk_class, attrs, props, meths, sigs) ->
      out "@[<hv2>module %s = struct" (camlizeM name);
      out "@ @[<hv2>let cast w : %s.%s obj =@ try_cast w \"%s\"@]"
        baseM (camlize name) gtk_class;
      let tag =
        try List.assoc "tag" attrs
        with Not_found -> !tagprefix ^ String.lowercase name
      in
      if props <> [] then begin
        out "@ @[<hv2>module P = struct";
        List.iter props ~f:
          begin fun (name, _, gtype, attrs) ->
            let count, rpname = Hashtbl.find all_props (name,gtype) in
            if !count > 1 then begin
              out "@ let %s : ([>`%s],_) property = %s"
                (camlize name) tag !rpname
            end else
              defprop ~name ~mlname:(camlize name) ~gtype ~tag
          end;
        out "@]@ end"
      end;
      if sigs <> [] then begin
        out "@ @[<hv2>module S = struct@ open GtkSignal";
        List.iter sigs ~f:
          begin fun (name,marshaller) ->
            out "@ @[<hv2>let %s =" (camlize name);
            out "@ @[<hv1>{name=\"%s\"; classe=`%s; marshaller=@;<0>"
              name tag;
            begin match marshaller with
            | `Function s -> out "%s" s
            | `Types ([], "") -> out "marshal_unit" 
            | `Types ([], ret) ->
                out "marshal0_ret ~ret:%s" (Hashtbl.find conversions ret)
            | `Types (l, ret) ->
                out "(fun f -> @[<hov2>marshal%d" (List.length l);
                if ret <> "" then
                  out "_ret@ ~ret:%s" (Hashtbl.find conversions ret);
                List.iter l ~f:
                  (fun ty -> out "@ %s" (Hashtbl.find conversions ty));
                out "@ \"%s::%s\" f@])" gtk_class name;
            end;
            out "}@]@]";
          end;
        out "@]@ end";
      end;
      if not (List.mem_assoc "abstract" attrs) then begin
        let cprops = List.filter props ~f:(fun (_,_,_,a) ->
          List.mem "ConstructOnly" a && not (List.mem "NoSet" a)) in
        out "@ @[<hv2>let create";
        List.iter cprops ~f:(fun (_,name,_,_) -> out " ?%s" name);
        if List.mem_assoc "hv" attrs then begin
          out " (dir : Gtk.Tags.orientation) pl";
          out " : %s.%s obj =" baseM (camlize name);
          may_cons_props cprops;
          out "@ @[<hov2>Object.make";
          out "@ (if dir = `HORIZONTAL then \"%sH%s\" else \"%sV%s\")@  pl"
            !prefix name !prefix name;
          out "@]@]";
        end else begin
          out " pl : %s.%s obj =" baseM (camlize name);
          may_cons_props cprops;
          out "@ Object.make \"%s\" pl@]" gtk_class;
        end
      end;
      List.iter meths ~f:
        begin fun (name, typ) ->
          out "@ @[<hov2>external %s :" name;
          out "@ @[<hv>[>`%s] obj ->@ %s@]" tag typ;
          let cname = camlize ("ml" ^ gtk_class) ^ "_" ^ name in
          out "@ = \"";
          if arity typ > 4 then out "%s_bc\" \"" cname;
          out "%s\"@]" cname;
        end;
      let set_props =
        let set = List.mem_assoc "set" attrs in
        List.filter props ~f:
          (fun (_,_,_,a) ->
            (set || List.mem "Set" a) && List.mem "Write" a &&
            not (List.mem "ConstructOnly" a || List.mem "NoSet" a))
      in
      if set_props <> [] then begin
        let props = set_props in
        out "@ @[<hv2>@[<hov4>let make_params ~cont pl";
        List.iter props ~f:(fun (_,name,_,_) -> out "@ ?%s" name);
        out " =@]";
        may_cons_props props;
        out "@ cont pl@]";
      end;
      if !checks && (props <> [] || sigs <> []) then begin
        if List.mem_assoc "abstract" attrs then 
          out "@ @[<hv2>let check w ="
        else begin
          out "@ @[<hv2>let check () =";
          out "@ let w = create%s [] in"
            (if List.mem_assoc "hv" attrs then " `HORIZONTAL" else "");
        end;
        if props <> [] then out "@ let c p = Property.check w p in";
        if sigs <> [] then begin
          out "@ let closure = Closure.create ignore in";
          out "@ let s name = GtkSignal.connect_by_name";
          out " w ~name ~closure ~after:false in";
        end;
        out "@ @[<hov>";
        List.iter props ~f:
          (fun (name,_,gtype,attrs) ->
            if List.mem "Read" attrs then out "c P.%s;@ " (camlize name));
        List.iter sigs ~f:(fun (name,_) -> out "s %s;@ " name);
        out "()@]";
      end;
      out "@]@.end\n@."
    end;
  close_out oc;
  (* Output classes *)
  let oc = open_out ("o" ^ baseM ^ "Props.ml") in
  let ppf = Format.formatter_of_out_channel oc in
  let out fmt = Format.fprintf ppf fmt in
  out "@[<hv>open Gobject@ open GtkProps@ ";
  (* Redefining saves space in bytecode! *)
  out "@ let set = set@ let get = get@ let param = param@ ";
  let oprop ~name ~gtype ppf pname =
    try
      let conv = List.assoc gtype specials in
      Format.fprintf ppf "{%s.P.%s with conv=%s}"
        (camlizeM name) (camlize pname) conv
    with Not_found ->
      Format.fprintf ppf "%s.P.%s" (camlizeM name) (camlize pname)
  in
  List.iter decls ~f:
    begin fun (name, gtk_class, attrs, props, meths, sigs) ->
      let wrap = List.mem_assoc "wrap" attrs in
      let wrapset = wrap || List.mem_assoc "wrapset" attrs in
      let wr_props =
        List.filter props ~f:
          (fun (_,_,_,set) ->
            let has = List.mem ~set in
            (wrapset || has "Wrap" || has "WrapSet") && has "Write" &&
            not (has "ConstructOnly" || has "NoWrap" || has "WrapGet"))
      and rd_props =
        List.filter props ~f:
          (fun (_,_,_,set) ->
            let has = List.mem ~set in
            (wrap || has "Wrap" || has "WrapGet") && has "Read" &&
            not (has "NoWrap" || has "WrapSet"))
      in
      if wr_props <> [] || rd_props <> [] then begin
        out "@ @[<hv2>class virtual %s_props = object (self)" (camlize name);
        List.iter wr_props ~f:(fun (pname,mlname,gtype,_) ->
          out "@ @[<hv2>method set_%s =@ set %a self#obj@]"
            mlname (oprop ~name ~gtype) pname);
        List.iter rd_props ~f:(fun (pname,mlname,gtype,_) ->
          out "@ @[<hv2>method %s =@ get %a self#obj@]"
            mlname (oprop ~name ~gtype) pname);
        out "@]@ end@ "
      end;
      let vset = List.mem_assoc "vset" attrs in
      let vprops =
        List.filter props ~f:
          (fun (_,_,_,set) ->
            let has = List.mem ~set in
            (vset || has "VSet") && has "Write" &&
            not (has "ConstructOnly" || has "NoVSet"))
      in
      if vprops <> [] then begin
        out "@ @[<hv2>let %s_param = function" (camlize name);
        List.iter vprops ~f:(fun (pname,mlname,gtype,_) ->
          out "@ @[<hv4>| `%s p ->@ param %a p@]"
            (String.uppercase mlname) (oprop ~name ~gtype) pname);
        out "@]@ ";
      end;
    end;
  out "@.";
  close_out oc

let main () =
  Arg.parse
    [ "-checks", Arg.Set checks, "generate code for checks"]
    process_file "usage: propcc file.props ..."

let () = Printexc.print main ()

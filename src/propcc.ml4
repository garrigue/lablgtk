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
    (* for canvas *)
    "AnchorType"; "DirectionType"; 
  ];
  "Gdk", "GdkEnums",
  [ "ExtensionMode"; "WindowTypeHint";
    (* for canvas *)
    "CapStyle"; "JoinStyle"; "LineStyle"];
  "Pango", "PangoEnums",
  [ "Stretch"; "Style"; "Underline"; "Variant"; ]
]

let flags = [
  "Gdk", "GdkEnums", ["EventMask"]
]

let pointers = [
  "Gdk", ["Color"; "Font"; ];
  "Pango", ["FontDescription";];
]

let classes = [
  "Gdk", [ "Image"; "Pixmap"; "Bitmap"; "Screen"; ];
  "Gtk", [ "Style"; "TreeStore"; "Widget"; ]
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
let add_unsafe = add_pointer "unsafe_pointer"

let () =
  List.iter ~f:(fun t -> Hashtbl.add conversions ("g"^t) t)
    [ "boolean"; "char"; "uchar"; "int"; "uint"; "long"; "ulong";
      "int32"; "uint32"; "int64"; "uint64"; "float"; "double" ];
  List.iter ~f:(fun (gtype,conv) -> Hashtbl.add conversions gtype conv)
    [ "gchararray", "string";
      "gchararray_opt", "string_option";
    ];
  List.iter (enums @ flags) ~f:(fun (pre, _, l) ->
    List.iter l ~f:
      begin fun name ->
        Hashtbl.add conversions (pre ^ name) ("Conv." ^camlize name)
      end);
  List.iter pointers ~f:(fun (pre, l) ->
    List.iter l ~f:(fun name -> add_unsafe (pre^name) (pre^"."^camlize name)));
  List.iter classes ~f:(fun (pre,l) ->
    List.iter l ~f:(fun t -> add_object (pre^t) (pre^"."^camlize t)))

open Genlex

let lexer = make_lexer ["{"; "}"; ":"; "/"; "("; ")"]

let rec star ?(acc=[]) p = parser
    [< x = p ; s >] -> star ~acc:(x::acc) p s
  | [< >] -> List.rev acc

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

let prop = parser
    [< ' String name; mlname = may_name name; ' Ident gtype; ' Kwd":";
       ' Ident attr0; attrs = star ~acc:[attr0] next_attr >] ->
         if List.exists attrs ~f:(fun x -> not (List.mem x attributes))
         then raise (Stream.Error "bad attribute");
         (name, mlname, gtype, attrs)

let rec verbatim buf = parser
    [< ''}' >] -> Buffer.contents buf
  | [< ''\\' ; 'c ; s >] -> Buffer.add_char buf c; verbatim buf s
  | [< 'c ; s >] -> Buffer.add_char buf c; verbatim buf s

let rec read_pairs = parser
    [< ' Kwd"}" >] -> []
  | [< ' Ident cls ; data = may_string (camlize cls) ; s >] ->
      (cls,data) :: read_pairs s

let prefix = ref ""
let use = ref ""
let decls = ref []
let headers = ref []
let checks = ref false
let class_qualifiers = ["abstract";"hv";"set";"wrap";"wrapset";"vset"]

let process_phrase ~chars = parser
    [< ' Ident"class"; ' Ident name;
       gtk_name = may_string (!prefix ^ name);
       attrs = star ident; ' Kwd":"; ' Ident parent;
       ' Kwd"{"; props = star prop; ' Kwd"}" >] ->
         if List.exists attrs ~f:(fun x -> not (List.mem x class_qualifiers))
         then raise (Stream.Error "bad qualifier");
         decls := (name, gtk_name, attrs, props) :: !decls
  | [< ' Ident"header"; ' Kwd"{" >] ->
      let h = verbatim (Buffer.create 1000) chars in
      headers := !headers @ [h]
  | [< ' Ident"prefix"; ' Ident id >] ->
      prefix := id
  | [< ' Ident"use"; ' Ident id >] ->
      use := id
  | [< ' Ident"conversions"; pre1 = may_string ""; pre2 = may_string pre1;
       ' Kwd"{"; l = read_pairs >] ->
      List.iter l ~f:(fun (k,d) ->
        Hashtbl.add conversions (pre1^k) (if pre2="" then d else pre2^"."^d))
  | [< ' Ident"classes"; ' Kwd"{"; l = read_pairs >] ->
      List.iter l ~f:(fun (k,d) -> add_object k d)
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
    (fun (name, gtk_name, _, _) ->
      add_object gtk_name (!prefix ^ "." ^ camlize name ^ " obj"));
  (* Output modules *)
  let oc = open_out (base ^ "Props.ml") in
  let ppf = Format.formatter_of_out_channel oc in
  let out fmt = Format.fprintf ppf fmt in
  List.iter !headers ~f:(fun s -> out "%s@." s);
  if enums <> [] && !use = "" then begin
    out "@[<hv2>module Conv = struct";
    List.iter ["enum", enums; "flags", flags] ~f:
      begin fun (conv,defs) ->
        List.iter defs ~f:(fun (pre, tables, l) ->
          List.iter l ~f:
            begin fun s ->
              out "@ let %s = %s %s.%s"
                (camlize s) conv tables (camlize s)
            end)
      end;
    out "@]@.end\n@.";
  end;
  let decls =
    List.map decls ~f:
      begin fun (name, gtk_name, attrs, props) ->
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
    begin fun (name, gtk_name, attrs, props) ->
      out "@[<hv2>module %s = struct" (camlizeM name);
      out "@ @[<hv2>let cast w : %s.%s obj =@ try_cast w \"%s%s\"@]"
        !prefix (camlize name) !prefix name;
      if props <> [] then begin
        out "@ @[<hv2>module P = struct";
        let tag = String.lowercase name in
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
      if not (List.mem "abstract" attrs) then begin
        let cprops = List.filter props ~f:(fun (_,_,_,a) ->
          List.mem "ConstructOnly" a && not (List.mem "NoSet" a)) in
        out "@ @[<hv2>let create";
        List.iter cprops ~f:(fun (_,name,_,_) -> out " ?%s" name);
        if List.mem "hv" attrs then begin
          out " (dir : Gtk.Tags.orientation) pl";
          out " : %s.%s obj =" !prefix (camlize name);
          may_cons_props cprops;
          out "@ @[<hov2>Object.make";
          out "@ (if dir = `HORIZONTAL then \"%sH%s\" else \"%sV%s\")@  pl"
            !prefix name !prefix name;
          out "@]@]";
        end else begin
          out " pl : %s.%s obj =" !prefix (camlize name);
          may_cons_props cprops;
          out "@ Object.make \"%s%s\" pl@]" !prefix name;
        end
      end;
      let set_props =
        let set = List.mem "set" attrs in
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
      if !checks then begin
        if List.mem "abstract" attrs then 
          out "@ @[<hv2>let check w ="
        else begin
          out "@ @[<hv2>let check () =";
          out "@ let w = create%s [] in"
            (if List.mem "hv" attrs then " `HORIZONTAL" else "");
        end;
        out "@ let c p = Property.check w p in";
        out "@ @[<hov>";
        List.iter props ~f:
          (fun (name,_,gtype,attrs) ->
            if List.mem "Read" attrs then out "c P.%s;@ " (camlize name));
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
    begin fun (name, gtk_name, attrs, props) ->
      let wrap = List.mem "wrap" attrs in
      let wrapset = wrap || List.mem "wrapset" attrs in
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
      let vset = List.mem "vset" attrs in
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

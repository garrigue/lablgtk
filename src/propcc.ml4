(* $Id$ *)

open StdLabels

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
    "TreeViewColumnSizing"; "SortType";
  ];
  "Gdk", "GdkEnums",
  [ "ExtensionMode"; "WindowTypeHint" ];
  "Pango", "PangoEnums",
  [ "Stretch"; "Style"; "Underline"; "Variant"; ]
]

let flags = [
  "Gdk", "GdkEnums", ["EventMask"]
]

let pointers = [
  "GdkColor", "Gdk.color";
  "GdkFont", "Gdk.font";
  "PangoFontDescription", "Pango.font_description";
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

let all_classes =
  [ "GdkPixbuf", "GdkPixbuf.pixbuf";
    "GtkTreeModel", "Gtk.tree_model obj";
  ] @
  List.fold_right classes ~init:[] ~f:
    (fun (pre,l) acc ->
      List.map l ~f:(fun t -> pre^t, pre^"."^camlize t) @ acc)

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
      "int64"; "uint64"; "float"; "double" ];
  List.iter ~f:(fun (gtype,conv) -> Hashtbl.add conversions gtype conv)
    [ "gchararray", "string";
      "gchararray_opt", "string_option";
      "GtkStock", "GtkStock.conv";
    ];
  List.iter (enums @ flags) ~f:(fun (pre, _, l) ->
    List.iter l ~f:
      begin fun name ->
        Hashtbl.add conversions (pre ^ name) ("Conv." ^camlize name)
      end);
  List.iter pointers ~f:(fun (gtk,mltype) -> add_unsafe gtk mltype);
  List.iter all_classes ~f:(fun (gtk,name) -> add_object gtk name)

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
   "NoWrap";"Wrap";"NoGet"]

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

let prefix = ref ""
let decls = ref []
let headers = ref []
let checks = ref false
let class_qualifiers = ["abstract";"hv";"set";"wrap";"wrapset"]

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
  | [< >] ->
      raise End_of_file

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
      add_object gtk_name (baseM ^ "." ^ camlize name ^ " obj"));
  (* Output modules *)
  let oc = open_out (base ^ "Props.ml") in
  let ppf = Format.formatter_of_out_channel oc in
  let out fmt = Format.fprintf ppf fmt in
  List.iter !headers ~f:(fun s -> out "%s\n" s);
  if enums <> [] then begin
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
           begin fun (_,_,gtype,_) ->
             try ignore (Hashtbl.find conversions gtype); true
             with Not_found ->
               prerr_endline ("Warning: no conversion for type " ^ gtype);
               false
           end)
      end in
  let may_cons_props props =
    if props <> [] then begin
      out "@ @[<hv2>let pl = ";
      List.iter props ~f:
        begin fun (_,name,gtype,_) ->
          let op =
            if check_suffix gtype "_opt" then "may_cons_opt" else "may_cons"
          in
          out "(@;Property.%s P.%s %s " op name name;
        end;
      out "pl";
      for k = 1 to List.length props do out ")" done;
      out " in@]"
    end
  in
  List.iter decls ~f:
    begin fun (name, gtk_name, attrs, props) ->
      out "@[<hv2>module %s = struct" (camlizeM name);
      out "@ let cast w : %s.%s obj = try_cast w \"%s%s\""
        baseM (camlize name) baseM name;
      if props <> [] then begin
        out "@ @[<hv2>module P = struct";
        let tag = String.lowercase name in
        List.iter props ~f:
          begin fun (name, mlname, gtype, attrs) ->
            let conv = Hashtbl.find conversions gtype in
            out "@ @[<hv2>let %s =" mlname;
            out "@ @[<hov1>{name=\"%s\";@ classe=`%s;@ conv=%s}@]@]"
              name tag conv
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
          out " : %s.%s obj =" baseM (camlize name);
          may_cons_props cprops;
          out "@ @[<hov2>Object.make";
          out "@ (if dir = `HORIZONTAL then \"%sH%s\" else \"%sV%s\")@  pl"
            baseM name baseM name;
          out "@]@]";
        end else begin
          out " pl : %s.%s obj =" baseM (camlize name);
          may_cons_props cprops;
          out "@ Object.make \"%s%s\" pl@]" baseM name;
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
          (fun (_,name,gtype,attrs) ->
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
  let oprop ~name ~gtype ppf pname =
    try
      let conv = List.assoc gtype specials in
      Format.fprintf ppf "{%s.P.%s with conv=%s}" (camlizeM name) pname conv
    with Not_found ->
      Format.fprintf ppf "%s.P.%s" (camlizeM name) pname
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
        List.iter wr_props ~f:(fun (_,pname,gtype,_) ->
          out "@ method set_%s = set %a self#obj"
            pname (oprop ~name ~gtype) pname);
        List.iter rd_props ~f:(fun (_,pname,gtype,_) ->
          out "@ method %s = get %a self#obj"
            pname (oprop ~name ~gtype) pname);
        out "@]@ end@ "
      end
    end;
  out "@.";
  close_out oc

let main () =
  Arg.parse
    [ "-checks", Arg.Set checks, "generate code for checks"]
    process_file "usage: propcc file.props ..."

let () = Printexc.print main ()
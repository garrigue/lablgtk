(* $Id$ *)

open StdLabels

let caml_keywords = ["type","kind"; "class","classe"]

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

let check_suffix s suff =
  let len1 = String.length s and len2 = String.length suff in
  len1 > len2 && String.sub s (len1-len2) len2 = suff

let conversions = Hashtbl.create 17

let enums = [
  "Gtk", "GtkEnums",
  [ "Justification"; "ArrowType"; "ShadowType"; "ResizeMode";
    "ReliefStyle"; "ImageType"; "WindowType"; "WindowPosition" ];
  "Gdk", "GdkEnums",
  [ "ExtensionMode"; "WindowTypeHint" ]
]

let flags = [
  "Gdk", "GdkEnums", ["EventMask"]
]

let classes = [
  "GdkImage", "Gdk.image";
  "GdkPixmap", "Gdk.pixmap";
  "GdkPixbuf", "GdkPixbuf.pixbuf";
  "GdkScreen", "Gdk.screen";
  "GtkStyle", "Gtk.style"
]

let add_object gtk name =
  Hashtbl.add conversions gtk
    (Printf.sprintf "(gobject : %s data_conv)" name);
  Hashtbl.add conversions (gtk ^ "_opt")
    (Printf.sprintf "(gobject_option : %s option data_conv)" name)

let () =
  List.iter ~f:(fun t -> Hashtbl.add conversions ("g"^t) t)
    [ "boolean"; "char"; "uchar"; "int"; "uint"; "long"; "ulong";
      "int64"; "uint64"; "float"; "double" ];
  List.iter ~f:(fun (gtype,conv) -> Hashtbl.add conversions gtype conv)
    [ "gchararray", "string";
      "gchararray_opt", "string_option" ];
  List.iter (enums @ flags) ~f:(fun (pre, _, l) ->
    List.iter l ~f:
      begin fun name ->
        Hashtbl.add conversions (pre ^ name) ("Conv." ^camlize name)
      end);
  List.iter classes ~f:(fun (gtk,name) -> add_object gtk name)

open Genlex

let lexer = make_lexer ["{"; "}"; ":"; "/"]

let rec star ?(acc=[]) p = parser
    [< x = p ; s >] -> star ~acc:(x::acc) p s
  | [< >] -> List.rev acc

let ident = parser [< ' Ident id >] -> id

let may_string def = parser
    [< ' String s >] -> s
  | [< >] -> def

let next_attr = parser
    [< ' Kwd"/"; ' Ident id; ids = star ~acc:[id] ident >] ->
      String.concat ~sep:"" ids

let normalize s =
  for i = 0 to String.length s - 1 do
    if s.[i] = '-' then s.[i] <- '_'
  done

let attributes = ["Read";"Write";"Construct";"ConstructOnly";"NoSet"]

let prop = parser
    [< ' String name; ' Ident gtype; ' Kwd":";
       ' Ident attr0; attrs = star ~acc:[attr0] next_attr >] ->
         normalize name;
         if List.exists attrs ~f:(fun x -> not (List.mem x attributes))
         then raise (Stream.Error "bad attribute");
         (name, gtype, attrs)

let prefix = ref "Gtk"
let decls = ref []
let checks = ref false

let process_phrase = parser
    [< ' Ident"class"; ' Ident name; gtk_name = may_string (!prefix ^ name);
       attrs = star ident; ' Kwd"{"; props = star prop; ' Kwd"}" >] ->
         if List.exists attrs ~f:
             (fun x -> not (List.mem x ["noset"]))
         then raise (Stream.Error "bad qualifier");
         decls := (name, gtk_name, attrs, props) :: !decls
  | [< ' Ident"prefix"; ' String s >] ->
      prefix := s
  | [< >] ->
      raise End_of_file

let header = [
  "open Gobject";
  "open Data\n";
  "module PObject = struct";
  "  let cast w : [`gtk] obj = try_cast w \"GtkObject\"";
  "  external _ref_and_sink : [>`gtk] obj -> unit";
  "    = \"ml_gtk_object_ref_and_sink\"";
  "  let make ~classe params =";
  "    let obj = Gobject.make ~classe params in _ref_and_sink obj;";
  "    obj";
  "end\n";
]


let process_file f =
  let out = Format.printf in
  let ic = open_in f in
  let chars = Stream.of_channel ic in
  let s = lexer chars in
  begin try while true do process_phrase s done with
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
  let decls = List.rev !decls in
  List.iter decls ~f:
    (fun (name, gtk_name, _, _) ->
      add_object gtk_name ("Gtk." ^ camlize name ^ " obj"));
  List.iter header ~f:(fun s -> out "%s\n" s);
  if enums <> [] then begin
    out "module Conv = struct\n";
    List.iter ["enum", enums; "flags", flags] ~f:
      begin fun (conv,defs) ->
        List.iter defs ~f:(fun (pre, tables, l) ->
          List.iter l ~f:
            begin fun s ->
              out "  let %s = %s %s.%s\n"
                (camlize s) conv tables (camlize s)
            end)
      end;
    out "end\n@.";
  end;
  List.iter decls ~f:
    begin fun (name, gtk_name, attrs, props) ->
      if props = [] then () else
      let tag = String.lowercase name in
      out "@[<hv2>module P%s = struct" name;
      let props =
        List.filter props ~f:
          begin fun (_,gtype,_) ->
            try ignore (Hashtbl.find conversions gtype); true
            with Not_found ->
              prerr_endline ("Warning: no conversion for type " ^ gtype);
              false
          end
      in
      List.iter props ~f:
        begin fun (name, gtype, attrs) ->
          let conv = Hashtbl.find conversions gtype in
          out "@ @[<hv2>let %s =" (camlize name);
          out "@ @[<hov1>{name=\"%s\";@ classe=`%s;@ conv=%s}@]@]"
            name tag conv
        end;
      if not (List.mem "noset" attrs) then begin
        let props =
          List.filter props ~f:
            (fun (_,_,a) ->
              List.mem "Write" a &&
              not (List.mem "ConstructOnly" a || List.mem "NoSet" a)) in
        if List.length props < 2 then () else
        let props = List.map props ~f:(fun (a,b,c) -> (a,camlize b,c)) in
        let i = ref 0 in
        out "@ @[<hv2>@[<hov4>let make_params ~cont";
        List.iter props ~f:(fun (name,_,_) -> incr i; out "@ ?%s:x%d" name !i);
        out " =@]";
        out "@ cont ";
        i := 0;
        List.iter props ~f:
          begin fun (name,gtype,_) ->
            let op =
              if check_suffix gtype "_opt" then "may_cons_opt" else "may_cons"
            in incr i;
            out "(@ Property.%s %s x%d " op name !i;
          end;
        out "[]";
        for k = 1 to !i do out ")" done;
        out "@]";
      end;
      if !checks then begin
        out "@ @[<hv2>let check w =";
        out "@ let c p = Gobject.Property.check w p in";
        out "@ @[<hov>";
        List.iter props ~f:
          (fun (name,gtype,attrs) ->
            if List.mem "Read" attrs then out "c %s;@ " (camlize name));
        out "()@]";
      end;
      out "@]@.end\n@."
    end

let main () =
  Arg.parse ["-checks", Arg.Set checks, "generate code for checks"]
    process_file "usage: propcc file.props ..."

let () = Printexc.print main ()

(* $Id$ *)

open StdLabels

let conversions = Hashtbl.create 17

let camlize id =
  let b = Buffer.create (String.length id + 4) in
  for i = 0 to String.length id - 1 do
    if id.[i] >= 'A' && id.[i] <= 'Z' then begin
      if i > 0 then Buffer.add_char b '_';
      Buffer.add_char b (Char.lowercase id.[i])
    end
    else Buffer.add_char b id.[i]
  done;
  Buffer.contents b

let enums =
    [ "Justification"; "ArrowType"; "ShadowType"; "ResizeMode"; "ReliefStyle" ]

let () =
  List.iter ~f:(fun t -> Hashtbl.add conversions ("g"^t) t)
    [ "boolean"; "char"; "uchar"; "int"; "uint"; "long"; "ulong";
      "int64"; "uint64"; "float"; "double" ];
  List.iter ~f:(fun (gtype,conv) -> Hashtbl.add conversions gtype conv)
    [ "gchararray", "string";
      "gchararray_option", "string_option" ];
  List.iter enums
    ~f:(fun name -> Hashtbl.add conversions ("Gtk" ^ name) (camlize name))

open Genlex

let lexer = make_lexer ["{"; "}"; ":"; "/"]

let rec star ?(acc=[]) p = parser
    [< x = p ; s >] -> star ~acc:(x::acc) p s
  | [< >] -> List.rev acc

let ident = parser [< ' Ident id >] -> id

let may_string def = parser
    [< ' String s >] -> s
  | [< >] -> def

let next_attr = parser [< ' Kwd"/"; ' Ident id >] -> id

let normalize s =
  for i = 0 to String.length s - 1 do
    if s.[i] = '-' then s.[i] <- '_'
  done

let prop = parser
    [< ' String name; ' Ident gtype; ' Kwd":";
       ' Ident attr0; attrs = star ~acc:[attr0] next_attr >] ->
         normalize name;
         if List.exists attrs ~f:
             (fun x ->
               not (List.mem x ["Read";"Write";"Construct";"ConstructOnly"]))
         then raise (Stream.Error "bad attribute");
         (name, gtype, attrs)

let prefix = ref "Gtk"
let decls = ref []

let process_phrase = parser
    [< ' Ident"class"; ' Ident name; gtk_name = may_string (!prefix ^ name);
       attrs = star ident; ' Kwd"{"; props = star prop; ' Kwd"}" >] ->
         if List.exists attrs ~f:(fun x -> not (List.mem x ["noset"]))
         then raise (Stream.Error "bad qualifier");
         decls := (name, gtk_name, attrs, props) :: !decls
  | [< ' Ident"prefix"; ' String s >] ->
      prefix := s
  | [< >] ->
      raise End_of_file

let process_file f =
  prerr_endline ("processing " ^ f);
  let out = Printf.printf in
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
    begin fun (name, gtk_name, _, _) ->
      Hashtbl.add conversions gtk_name
        (Printf.sprintf "(gobject : Gtk.%s obj data_conv)"
           (camlize name));
      Hashtbl.add conversions (gtk_name ^ "_opt")
        (Printf.sprintf "(gobject_option : Gtk.%s obj option data_conv)"
           (camlize name));
    end;
  List.iter enums ~f:
    begin fun s ->
      out "let %s = Gobject.Data.enum GtkEnums.%s\n" (camlize s) (camlize s)
    end;
  List.iter decls ~f:
    begin fun (name, gtk_name, attrs, props) ->
      if props = [] then () else
      let tag = String.lowercase name in
      out "module P%s = struct\n" name;
      out "  open Gobject\n";
      out "  open Data\n";
      List.iter props ~f:
        begin fun (name, gtype, attrs) ->
          try
            let conv = Hashtbl.find conversions gtype in
            out "  let %s = {name=\"%s\";classe=`%s;conv=%s}\n"
              name name tag conv
          with Not_found ->
            prerr_endline ("Warning: no conversion for type " ^ gtype)
        end;
      out "end\n"
    end

let main () =
  Arg.parse [] process_file "usage: propcc file.props ..."

let () = Printexc.print main ()

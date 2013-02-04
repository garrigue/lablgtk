
(** Parsing XML + convenient functions. *)

type name = string
type attribute = string * string

let map_ns = function
| "http://www.gtk.org/introspection/core/1.0" -> ""
| "http://www.gtk.org/introspection/c/1.0" -> "c:"
| "http://www.gtk.org/introspection/glib/1.0" -> "glib:"
| "http://www.w3.org/2001/XInclude" -> "xi:"
| "" -> ""
| "http://www.w3.org/XML/1998/namespace" -> "xmlns"
| "http://www.w3.org/2000/xmlns/" -> "xmlns"
| s ->
  prerr_endline ("Namespace: "^s);
  s

let name_of_xmlm_name (pref,s) =
  match map_ns pref with
  | "" -> s
  | "xmlns" when s = "xmlns" -> "xmlns"
  | "xmlns" -> "xmlns:"^s
  | p -> p^s
;;

let atts_of_xmlm_atts =
  List.map (fun (name, v) -> (name_of_xmlm_name name, v))
;;

type tree =
    E of name * attribute list * tree list
  | D of string

exception Error of string
let error msg = raise (Error msg)

let xml_of_source s_source source =
 try
    let ns s = Some s in
    let input = Xmlm.make_input  ~strip: false ~ns ~enc: (Some `UTF_8) source in
    let el (tag, atts) childs =
      E
        (name_of_xmlm_name tag,
         atts_of_xmlm_atts atts,
         childs)
    in
    let data d = D d in
    let (_, tree) = Xmlm.input_doc_tree ~el ~data input in
    tree
  with
    Xmlm.Error ((line, col), err) ->
      let msg = Printf.sprintf "%sLine %d, column %d: %s"
        s_source line col (Xmlm.error_message err)
      in
      error msg
  | Invalid_argument e ->
      let msg = Printf.sprintf "%sInvalid_argumen(%s)" s_source e in
      error msg

let xml_of_file file =
  let ic = open_in file in
  try
    let xml = xml_of_source
      (Printf.sprintf "File %S, " file) (`Channel ic)
    in
    close_in ic;
    xml
  with
    e ->
      close_in ic;
      raise e
;;

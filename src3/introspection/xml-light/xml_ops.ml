open Xml
open Printf

let parse = XmlParser.parse

let default_parser = XmlParser.make()

let pos source =
  let line, lstart, min, max = Xml_lexer.pos source in
  {
   eline = line;
   eline_start = lstart;
   emin = min;
   emax = max;
  }

let parse_in ch = parse default_parser (XmlParser.SChannel ch)
let parse_string str = parse default_parser (XmlParser.SString str)

let parse_file f =
  let p = XmlParser.make() in
  let path = Filename.dirname f in
  XmlParser.resolve p (fun file -> 
    let name = (match path with "." -> file | _ -> path ^ "/" ^ file) in
    Dtd_ops.check (Dtd_ops.parse_file name)
		      );
  parse p (XmlParser.SFile f)

let error_msg = function
  | UnterminatedComment -> "Unterminated comment"
  | UnterminatedString -> "Unterminated string"
  | UnterminatedEntity -> "Unterminated entity"
  | IdentExpected -> "Ident expected"
  | CloseExpected -> "Element close expected"
  | NodeExpected -> "Xml node expected"
  | AttributeNameExpected -> "Attribute name expected"
  | AttributeValueExpected -> "Attribute value expected"
  | EndOfTagExpected tag -> sprintf "End of tag expected : '%s'" tag
  | EOFExpected -> "End of file expected"

let error (msg,pos) =
  if pos.emin = pos.emax then
    sprintf "%s line %d character %d"
      (error_msg msg) pos.eline (pos.emin - pos.eline_start)
  else
    sprintf "%s line %d characters %d-%d"
      (error_msg msg) pos.eline (pos.emin - pos.eline_start)
      (pos.emax - pos.eline_start)
      
let line e = e.eline

let range e = 
  e.emin - e.eline_start , e.emax - e.eline_start

let abs_range e =
  e.emin , e.emax

let tag = function
  | Element (tag,_,_) -> tag
  | x -> raise (Not_element x)

let pcdata = function 
  | PCData text -> text
  | x -> raise (Not_pcdata x)

let attribs = function 
  | Element (_,attr,_) -> attr
  | x -> raise (Not_element x)

let attrib x att =
  match x with
  | Element (_,attr,_) ->
      (try
	let att = String.lowercase att in
	snd (List.find (fun (n,_) -> String.lowercase n = att) attr)
      with
	Not_found ->
	  raise (No_attribute att))
  | x ->
      raise (Not_element x)

let children = function
  | Element (_,_,clist) -> clist
  | x -> raise (Not_element x)

(*let enum = function
  | Element (_,_,clist) -> List.to_enum clist
  | x -> raise (Not_element x)
 *)

let iter f = function
  | Element (_,_,clist) -> List.iter f clist
  | x -> raise (Not_element x)

let map f = function
  | Element (_,_,clist) -> List.map f clist
  | x -> raise (Not_element x)

let fold f v = function
  | Element (_,_,clist) -> List.fold_left f v clist
  | x -> raise (Not_element x)

let tmp = Buffer.create 200

let buffer_pcdata text =
  let l = String.length text in
  for p = 0 to l-1 do 
    match text.[p] with
    | '>' -> Buffer.add_string tmp "&gt;"
    | '<' -> Buffer.add_string tmp "&lt;"
    | '&' ->
	if p < l-1 && text.[p+1] = '#' then
	  Buffer.add_char tmp '&'
	else
	  Buffer.add_string tmp "&amp;"
    | '\'' -> Buffer.add_string tmp "&apos;"
    | '"' -> Buffer.add_string tmp "&quot;"
    | c -> Buffer.add_char tmp c
  done

let buffer_attr (n,v) =
  Buffer.add_char tmp ' ';
  Buffer.add_string tmp n;
  Buffer.add_string tmp "=\"";
  let l = String.length v in
  for p = 0 to l-1 do
    match v.[p] with
    | '\\' -> Buffer.add_string tmp "\\\\"
    | '"' -> Buffer.add_string tmp "\\\""
    | c -> Buffer.add_char tmp c
  done;
  Buffer.add_char tmp '"'

let to_string x = 
  let pcdata = ref false in
  let rec loop = function
    | Element (tag,alist,[]) ->
	Buffer.add_char tmp '<';
	Buffer.add_string tmp tag;
	List.iter buffer_attr alist;
	Buffer.add_string tmp "/>";
	pcdata := false;
    | Element (tag,alist,l) ->
	Buffer.add_char tmp '<';
	Buffer.add_string tmp tag;
	List.iter buffer_attr alist;
	Buffer.add_char tmp '>';
	pcdata := false;
	List.iter loop l;
	Buffer.add_string tmp "</";
	Buffer.add_string tmp tag;
	Buffer.add_char tmp '>';
	pcdata := false;
    | PCData text ->
	if !pcdata then Buffer.add_char tmp ' ';
	buffer_pcdata text;
	pcdata := true;
  in
  Buffer.reset tmp;
  loop x;
  let s = Buffer.contents tmp in
  Buffer.reset tmp;
  s

let to_string_fmt x =
  let rec loop ?(newl=false) tab = function
    | Element (tag,alist,[]) ->
	Buffer.add_string tmp tab;
	Buffer.add_char tmp '<';
	Buffer.add_string tmp tag;
	List.iter buffer_attr alist;
	Buffer.add_string tmp "/>";
	if newl then Buffer.add_char tmp '\n';
    | Element (tag,alist,[PCData text]) ->
	Buffer.add_string tmp tab;
	Buffer.add_char tmp '<';
	Buffer.add_string tmp tag;
	List.iter buffer_attr alist;
	Buffer.add_string tmp ">";
	buffer_pcdata text;
	Buffer.add_string tmp "</";
	Buffer.add_string tmp tag;
	Buffer.add_char tmp '>';
	if newl then Buffer.add_char tmp '\n';
    | Element (tag,alist,l) ->
	Buffer.add_string tmp tab;
	Buffer.add_char tmp '<';
	Buffer.add_string tmp tag;
	List.iter buffer_attr alist;
	Buffer.add_string tmp ">\n";
	List.iter (loop ~newl:true (tab^"  ")) l;
	Buffer.add_string tmp tab;
	Buffer.add_string tmp "</";
	Buffer.add_string tmp tag;
	Buffer.add_char tmp '>';
	if newl then Buffer.add_char tmp '\n';
    | PCData text ->
	buffer_pcdata text;
	if newl then Buffer.add_char tmp '\n';
  in
  Buffer.reset tmp;
  loop "" x;
  let s = Buffer.contents tmp in
  Buffer.reset tmp;
  s

;;
XmlParser._raises (fun x p -> Error (x, pos p))
  (fun f -> File_not_found f)
  (fun x p -> Dtd.Parse_error (x, pos p));;
Dtd_ops._raises (fun f -> File_not_found f);;

(* $Id$ *)

(* Compile a list of variant tags into CPP defines *) 

(* hash_variant, from ctype.ml *)

let hash_variant s =
  let accu = ref 0 in
  for i = 0 to String.length s - 1 do
    accu := 223 * !accu + Char.code s.[i]
  done;
  (* reduce to 31 bits *)
  accu := !accu land (1 lsl 31 - 1);
  (* make it signed for 64 bits architectures *)
  if !accu > 0x3FFFFFFF then !accu - (1 lsl 31) else !accu

open Genlex

let lexer = make_lexer ["type"; "exception"; "="; "["; "]"]

let exn_name = ref "invalid_argument"

let may_string = parser
    [< ' String s >] -> s
  | [< >] -> ""

let rec ident_list = parser
    [< ' Ident x; trans = may_string; s >] -> (x, trans) :: ident_list s
  | [< >] -> []

open Printf

let declaration = parser
    [< ' Kwd "type"; ' Ident name; ' Kwd "=";
       prefix = may_string; ' Kwd "[";
       tags = ident_list; ' Kwd "]"; suffix = may_string >] ->
    let ctag tag trans =
      if trans <> "" then trans else
      let tag =
	if tag.[0] = '_' then
	  String.sub tag pos:1 len:(String.length tag -1)
	else tag
      in
      match
	if prefix = "" then None, ""
	else
	  Some (prefix.[String.length prefix - 1]), 
	  String.sub prefix pos:0 len:(String.length prefix - 1)
      with
	Some '#', prefix ->
	  prefix ^ String.uncapitalize tag ^ suffix
      |	Some '^', prefix ->
	  prefix ^ String.uppercase tag ^ suffix
      |	_ ->
	  prefix ^ tag ^ suffix
    and cname =
      String.capitalize name
    in
    let tags =
      Sort.list tags
	order:(fun (tag1,_) (tag2,_) -> hash_variant tag1 < hash_variant tag2)
    in
    printf "/* %s : conversion table */\n" name;
    printf "lookup_info ml_table_%s[] = {\n" name;
    printf "  { 0, %d },\n" (List.length tags);
    List.iter tags f:
      begin fun (tag,trans) ->
	printf "  { MLTAG_%s, %s },\n" tag (ctag tag trans)
      end;
    printf "};\n\n";
    printf "#define Val_%s(data) ml_lookup_from_c (ml_table_%s, data)\n"
      name name;
    printf "#define %s_val(key) ml_lookup_to_c (ml_table_%s, key)\n\n"
      cname name;
  | [< 'Kwd"exception"; 'Ident name >] ->
      exn_name := name
  | [< >] -> raise End_of_file

let main () =
  let s = lexer (Stream.of_channel stdin) in
  try
    while true do declaration s done
  with End_of_file -> ()

let _ = Printexc.print main ()

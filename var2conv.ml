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
    printf "/* %s : ML to C */\n" name;
    printf "long %s_val (value tag) {\n" cname;
    printf "  switch (tag) {\n";
    List.iter tags fun:
      (fun (tag,trans) ->
	printf "  case MLTAG_%s: return %s;\n" tag (ctag tag trans));
    printf "  }\n";
    printf "  ml_raise_gtk(\"%s_val : unknown tag\");\n" cname;
    printf "}\n\n";
    printf "/* %s : C to ML */\n" name;
    printf "value Val_%s (long tag) {\n" name;
    printf "  switch (tag) {\n";
    List.iter tags fun:
      (fun (tag, trans) ->
	printf "  case %s: return MLTAG_%s;\n" (ctag tag trans) tag);
    printf "  }\n";
    printf "  %s(\"Val_%s : unknown tag\");\n" !exn_name name;
    printf "}\n\n"
  | [< 'Kwd"exception"; 'Ident name >] ->
      exn_name := name
  | [< >] -> raise End_of_file

let main () =
  let s = lexer (Stream.of_channel stdin) in
  try
    while true do declaration s done
  with End_of_file -> ()

let _ = Printexc.print main ()

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

let lexer = make_lexer ["type"; "="; "["; "]"]

let main () =
  let s = lexer (Stream.of_channel stdin) in
  let tags = Hashtbl.create size:57 in
  try while true do match s with parser
      [< ' Ident tag >] ->
	let hash = hash_variant tag in
	begin try
	  let tag' = Hashtbl.find key:hash tags in
	  if tag <> tag' then
	    failwith (String.concat sep:" " ["Doublon tag:";tag;"and";tag'])
	with Not_found ->
	  Hashtbl.add key:hash data:tag tags;
	  print_string "#define MLTAG_";
	  print_string tag;
	  print_string "\tVal_int(";
	  print_int hash;
	  print_string ")\n"
	end
    | [< ' Kwd "type"; ' Ident _; ' Kwd "=" >] -> ()
    | [< ' (String _ | Kwd("["|"]")) >] -> ()
    | [< >] -> raise End_of_file
  done with End_of_file -> ()

let _ = Printexc.print main ()

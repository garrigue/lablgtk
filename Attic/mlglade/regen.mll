
{

  open Lexing
  open Printf

  let buf = Buffer.create 1024

  let eds = ref ([] : (string * string) list)

  let extract_tag s = String.sub s 9 (String.length s - 12)

}

let begin_edit = "(* BEGIN " [^ '\n']* " *)"
let end_edit   = "(* END " [^ '\n']* " *)"

rule scan = parse
  | begin_edit  
      { let tag = extract_tag (lexeme lexbuf) in
	Buffer.clear buf;
	let s = scan_edition lexbuf in
	eds := (tag,s) :: !eds;
	scan lexbuf }
  | eof 
      { () }
  | _   
      { scan lexbuf }

and scan_edition = parse
  | end_edit
      { Buffer.contents buf }
  | eof 
      { Buffer.contents buf }
  | _   
      { Buffer.add_string buf (lexeme lexbuf); scan_edition lexbuf }

{

  let output_block tag s ch =
    fprintf ch "(* BEGIN %s *)" tag;
    fprintf ch "%s" s;
    fprintf ch "(* END %s *)\n" tag

  let scan_file file = 
    let c = open_in file in
    let lb = from_channel c in
    eds := [];
    scan lb;
    close_in c;
    List.rev !eds

  type regeneration_function = (string * string) list -> out_channel -> unit

  type generation_function = string -> unit

  let generate f file =
    let eds = 
      if Sys.file_exists file then begin
	let l = scan_file file in
	Sys.rename file (file ^ ".bak");
	l
      end else
	[]
    in
    let c = open_out file in
    f eds c;
    close_out c
    
}

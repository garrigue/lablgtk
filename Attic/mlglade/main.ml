open Pc                         (* parser combinators for cmd line *)
open Error			(* error handling *)
open Xml			(* XML abstract syntax *)

(* [fopen] opens stdin when filename is None and the named file
 * otherwise.
 *)

let fopen optFileName =
    match optFileName with
    | None          -> stdin
    | Some(name)    -> try open_in name with
                       Sys_error msg -> error msg


(*
 * [read]
 * parses an input channel [in_chan] and returns the semantic value.
 *)

let read in_chan =
    let position (line,col) = "arround line "
                            ^ (string_of_int line)
                            ^ ", column "
                            ^ (string_of_int col) in

    let lexbuf              = Lexing.from_channel in_chan in
    try
      Xmlscan.init();                           (* reset line counter *)
      Xmlparse.document Xmlscan.scan lexbuf     (* start parsing      *)
    with exn ->
        let pos = position (Xmlscan.position lexbuf) in
        begin match exn with
          | Parsing.Parse_error   -> error ("syntax error " ^ pos)
          | Error msg             -> error ("syntax error " ^ pos ^ ": " ^ msg)
          | Sys_error msg         -> error ("I/O error: " ^ msg)
          | _                     -> raise exn
        end


(*
 * [print] reads and pretty prints an named XML file or reads from
 * stdin when there is no file name.
 *)

let print optfile =
  let linelen   = 80                in
  let in_chan   = fopen optfile     in
  let doc       = read in_chan      in
  Glade.process_doc optfile stdout doc;
  close_in in_chan


(* combinator parser for command line - uses parser combinators
 * form the [Pc] module.
 * 
 * -help
 * -version
 * -syntax
 *)
                    
type cmd =        | CMDhelp                                               
                  | CMDversion                                  
                  | CMDprint        of  string option                   

let cmd_help      = literal "-help"         --> return CMDhelp
let cmd_version   = literal "-version"      --> return CMDversion
let cmd_print     = opt (literal "-print") 
                    **> (opt any)           --> (fun file -> CMDprint file)

let cmdline       = (cmd_version ||| cmd_help ||| cmd_print) **< eof 

(*
 * usage
 *)

let usage this =
  Printf.eprintf "%s command line options (order does matter):\n" this;
  Printf.eprintf "\t -help                             (this to stderr)\n";
  Printf.eprintf "\t -print [file]                     (parse and pretty print)\n"

(* version
 *)
 
let version () =
    Printf.printf 
    	"%s version %s (c) 2001 Benjamin Monate <monate@lri.fr>\n" 
	This.name 
	This.version

(*
 * main - process command line and start working
 * When something goes wrong the individual subcommands are expected
 * to exit with a return status different from 0. Otherwise they
 * return and we exit with 0 from here.
 *)

let main () =
    let argv        = Array.to_list Sys.argv in
    let this        = Filename.basename (List.hd argv) in
    let args        = List.tl argv in
    let (cmd,_)     = try cmdline args with Pc.Error msg -> 
                         Printf.eprintf "%s command line syntax: %s\n"
                            this msg;
                         usage this;
                         exit 1
    in try
            ( match cmd with
            | CMDhelp               -> usage this
            | CMDprint(infile)      -> print infile
	    | CMDversion	    -> version ()
            );
            exit 0
       with 
            Error(msg)  -> Printf.eprintf "%s: %s\n" this msg;
            exit 1


let _ = main ()

(* -*- indented-text -*- --------------------------------------------


    Copyright (c) 1999 Christian Lindig <lindig@ips.cs.tu-bs.de>. All
    rights reserved. See COPYING for details.
   $Id$

   ------------------------------------------------------------------ *)

{
  open Xmlparse				(* tokens are defined here *)
  open Error				(* error defined here *)
  open Xmlstate
  open Lc                               (* lexer combinators *)
  
  (* little helpers *)

  let pos   = Lexing.lexeme_start
  let last  = Lexing.lexeme_end
  let get   = Lexing.lexeme
  
  (* simple minded definitions for line counting. Whenever we
   * we scan a newline we call newline().
   *)

  let line         = ref 1
  let startOfLine  = ref 0

  let init () =
    line          := 1;
    startOfLine   := 0;
    setContext DataContext

  let newline lexbuf =
    line := !line + 1;
    startOfLine := Lexing.lexeme_start lexbuf

  (* actual (line, column) position *)
  let position lexbuf = (!line,Lexing.lexeme_start lexbuf - !startOfLine)

  (* handling of keywords *)

  let keywords = Hashtbl.create 127
  let keyword s = Hashtbl.find keywords s
  let _ = Array.iter (fun (x,y) -> Hashtbl.add keywords x y)
    [|
	("xml",         XMLNAME);
        ("version",     VERSION);
        ("standalone",  STANDALONE);
        ("encoding",    ENCODING);
        ("system",      SYSTEM);
        ("public",      PUBLIC);
        
    |]

  (* store for string constants *)

  let strconst      = ref ""
  let storeStr s    = strconst := s
  let getStr ()     = !strconst

  (* substring extraction from lexemes using lexer combinators
   * from the [Lc] module
   *)

  let is_ws c           = c = ' ' || c = '\t' || c = '\r' || c = '\n'
  let alpha             = satisfy  (fun c -> not (is_ws c))
  let pi_prefix         = str "<?" *** saveStr (some alpha)
  let elem_prefix       = chr '<'*** opt (chr '/')  *** saveStr (some alpha)
  let pi_extract str    = match scan str pi_prefix with
                          | _,[w]   -> w
                          | _,_     -> assert false
  let elem_extract str  = match scan str elem_prefix with
                          | _,[w]   -> w
                          | _,_     -> assert false
}

(* regexp declarations *)

let     ws      = [' ' '\t' '\r']
let     nl      = '\n'
let     ident   = ['a'-'z' 'A'-'Z' '_' ':'] 
                  ['a'-'z' 'A'-'Z' '0'-'9' '.' '-' '_' ':']*
let     xml     = ['x' 'X']['m' 'M']['l' 'L']

(* ------------------------------------------------------------------
   different lexers - the active lexer is controlled by
   the parser!
   ------------------------------------------------------------------ *)

(* inside <element  ... /> *)
rule element = parse
      eof			{ EOF }
   
   (* whitespace and newlines *)
   | '\n'			{ newline lexbuf;
                                  element lexbuf }
   | ws	+                       { element lexbuf }		

   | ident                      { NAME (get lexbuf) }

   | '='			{ EQ    }
   | '"'			{ storeStr ""; string1 lexbuf }
   | '\''			{ storeStr ""; string2 lexbuf }
   | '>'			{ CLOSE }   
   | "/>"                       { SLASHCLOSE }

   (* everything else is illegal *)
   | _				{ error "illegal character" }

(* outside of <element ... />, i.e. we scan raw text *)
and data = parse
   | eof			{ EOF }
   | [^ '<' '\n' ] * nl         { newline lexbuf; CHUNK (get lexbuf)    }
   | [^ '<' '\n' ] *            {                 CHUNK (get lexbuf)    }
   | "<?xml" ws+        	{ XMLOPEN                               }
   | "<?xml" nl         	{ newline lexbuf; XMLOPEN               }
   | '<'  ident 	        { OPEN(elem_extract (get lexbuf))       }
   | "</" ident                 { OPENSLASH(elem_extract (get lexbuf))  }
   | "<?" ident ws+	        { PIOPEN(pi_extract (get lexbuf))       }
   | "<?" ident nl	        { newline lexbuf; 
                                  PIOPEN(pi_extract (get lexbuf))       }
   | "<!--"			{ comment lexbuf                        }
   | "<!DOCTYPE" ws+            { DTDOPEN                               }
   | "<!DOCTYPE" nl             { newline lexbuf; DTDOPEN               }
   
   | _				{ error ("illegal character `"
                                         ^ (get lexbuf) ^ "'" ) 
                                }

(* inside <? .. ?> *)
and pi = parse
   | '\n'			{ newline lexbuf; pi lexbuf }
   | "?>"			{ PICLOSE }
   | ws +                       { pi lexbuf }
   | [^ '?' '\n']+              { WORD(get lexbuf) }
   | '?'	                { WORD(get lexbuf) }

   | eof			{ error "unterminated <?YYY .. ?> "}
   | _				{ error "illegal char in <?YYY .. ?>"}

(* inside <?xml ... ?> *)
and decl = parse
   | '\n'			{ newline lexbuf; 
                                  decl lexbuf }
   | ws +                       { decl lexbuf }
   | "?>"			{ XMLCLOSE }
   | ">"                        { DTDCLOSE }
   | '='                        { EQ }
   | ident                      { let s = get lexbuf in
				      try  keyword (String.lowercase s) 
                                      with Not_found -> NAME(s)
				}
   | '\''                       { string2 lexbuf }
   | '"'                        { string1 lexbuf }

   | eof			{ error "unterminated declaration "}
   | _				{ error "illegal char declaration "}

and string1 = parse
   | [^ '"' '\n']+              { storeStr (get lexbuf);
                                  string1 lexbuf
                                }
   | '"'		        { STRING(getStr())              }
   | eof			{ error "unterminated string"   }
   | nl			        { error "newline in string is unsupported"}
   | _				{ error "illegal char in string"}

and string2 = parse
   | [^ '\'' '\n']+             { storeStr (get lexbuf);
                                  string2 lexbuf 
                                }
   | '\''	                { STRING(getStr())              }
   | eof			{ error "unterminated string"   }
   | nl			        { error "newline in string is unsupported"}
   | _				{ error "illegal char in string"}

and comment = parse   
     '\n'			{ newline lexbuf; comment lexbuf }
   | [^ '-' '\n']+ | '-'	{ comment lexbuf }
   | "-->"			{ COMMENT }
   | eof			{ error "unterminated comment"}
   | _				{ error "illegal char in comment"}

(* From the outside the scanner is always invoced through [scan]
 * which will respect the currently active context 
 *)

{
let scan buffer =
    match getContext() with
    | DataContext	    -> data     buffer
    | ElementContext        -> element  buffer
    | DeclContext           -> decl     buffer
    | PiContext             -> pi       buffer
}


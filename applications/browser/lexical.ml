(* $Id$ *)

open Parser

type tags = [`none|`control|`define|`structure|`char|`infix|`label|`uident]

let colors : (tags * GdkObj.color) list Lazy.t =
  lazy
    (List.map fun:(fun (tag,col) -> tag, `COLOR (Gdk.Color.alloc (`NAME col)))
       [ `control, "blue";
	 `define, "forestgreen";
	 `structure, "purple";
	 `char, "gray40";
	 `infix, "indianred4";
	 `label, "brown";
	 `uident, "midnightblue";
         `none, "black" ])

let tag ?:start[=0] ?end:pend (tw : GEdit.text) =
  let pend = Misc.default tw#length pend in
  let colors = Lazy.force colors in
  tw#freeze ();
  let position = tw#position
  and text = tw#get_chars :start end:pend in
  let replace start:pstart end:pend :tag =
    if pend > pstart then begin
      tw#delete_text start:(start+pstart) end:(start+pend);
      tw#set_point (start+pstart);
      tw#insert foreground:(List.assoc key:tag colors)
	(String.sub text pos:pstart len:(pend-pstart));
    end
  and next_lf = ref (-1) in
  let colorize start:rstart end:rend :tag =
    let rstart = ref rstart in
    while !rstart < rend do
      if !next_lf < !rstart then begin
	try next_lf := String.index_from text char:'\n' pos:!rstart
	with Not_found -> next_lf := pend-start
      end;
      replace start:!rstart end:(min !next_lf rend) :tag;
      rstart := !next_lf + 1
    done
  in
  let buffer = Lexing.from_string text
  and last = ref 0
  in
  try
    while true do
    let tag =
      match Lexer.token buffer with
        AMPERAMPER
      | AMPERSAND
      | BARBAR
      | DO | DONE
      | DOWNTO
      | ELSE
      | FOR
      | IF
      |	LAZY
      | MATCH
      | OR
      | THEN
      | TO
      | TRY
      | WHEN
      | WHILE
      | WITH
          -> `control
      | AND
      | AS
      | BAR
      | CLASS
      | CONSTRAINT
      | EXCEPTION
      | EXTERNAL
      | FUN
      | FUNCTION
      | FUNCTOR
      | IN
      | INHERIT
      |	INITIALIZER
      | LET
      | METHOD
      | MODULE
      | MUTABLE
      | NEW
      | OF
      | PARSER
      | PRIVATE
      | REC
      | TYPE
      | VAL
      | VIRTUAL
      	  -> `define
      | BEGIN
      | END
      | INCLUDE
      |	OBJECT
      | OPEN
      | SIG
      | STRUCT
          -> `structure
      | CHAR _
      | STRING _
      	  -> `char
      | BACKQUOTE
      | INFIXOP1 _
      | INFIXOP2 _
      | INFIXOP3 _
      | INFIXOP4 _
      | PREFIXOP _
      |	QUESTION2
      | SHARP
      	  -> `infix
      | LABEL _
      | LABELID _
      | QUESTION
      	  -> `label
      | UIDENT _ -> `uident
      | EOF -> raise End_of_file
      | _ -> `none
    in
    if tag <> `none then begin
      colorize tag:`none start:!last end:(Lexing.lexeme_start buffer);
      colorize :tag start:(Lexing.lexeme_start buffer)
	end:(Lexing.lexeme_end buffer);
      last := Lexing.lexeme_end buffer
    end
    done
  with exn ->
    colorize tag:`none start:!last end:(pend-start);
    tw#thaw ();
    tw#set_position position;
    tw#set_point position;
    match exn with
      End_of_file | Lexer.Error _ -> ()
    | _ -> raise exn

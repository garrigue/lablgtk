(* $Id$ *)

open Parser

type tags = [none control define structure char infix label uident]

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

let tag (tw : GEdit.text) ?:start [< 0 >] ?end:pend [< tw#length >] =
  let colors = Lazy.force colors in
  let black = List.assoc `none in:colors in
  tw#freeze ();
  let position = tw#position in
  tw#set_point start;
  let text = tw#get_chars :start end:pend in
  let buffer = Lexing.from_string text
  and last = ref 0
  and insert start:pstart end:pend :tag =
    if pend - pstart > 0 then begin
      let rstart = ref pstart in
      try while true do
	let mid = String.index_from text char:'\n' pos:!rstart in
	if mid > pend then raise Not_found;
	if mid > !rstart then begin
	  tw#delete_text start:(start + !rstart) end:(start+mid);
	  tw#insert foreground:(List.assoc tag in:colors)
	    (String.sub text pos:!rstart len:(mid - !rstart));
	end;
	rstart := mid+1;
	tw#set_point !rstart
      done with Not_found ->
	if pend > !rstart then begin
	  tw#delete_text start:(start + !rstart) end:(start+pend);
	  tw#insert foreground:(List.assoc tag in:colors)
	    (String.sub text pos:!rstart len:(pend - !rstart))
	end
    end
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
      |	QUESTION3
      | SHARP
      	  -> `infix
      | LABEL _
      | QUESTION
      	  -> `label
      | UIDENT _ -> `uident
      | EOF -> raise End_of_file
      | _ -> `none
    in
    if tag <> `none then begin
      insert tag:`none start:!last end:(Lexing.lexeme_start buffer);
      insert :tag start:(Lexing.lexeme_start buffer)
	end:(Lexing.lexeme_end buffer);
      last := Lexing.lexeme_end buffer
    end
    done
  with exn ->
    insert tag:`none start:!last end:pend;
    tw#thaw ();
    tw#set_position position;
    match exn with
      End_of_file | Lexer.Error _ -> ()
    | _ -> raise exn

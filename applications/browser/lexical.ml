(* $Id$ *)

open Parser

type tags = [`none|`control|`define|`structure|`char|`infix|`label|`uident]

let colors : (tags * GDraw.color) list Lazy.t =
  lazy
    (List.map ~f:(fun (tag,col) -> tag, `COLOR (GDraw.color (`NAME col)))
       [ `control, "blue";
	 `define, "forestgreen";
	 `structure, "purple";
	 `char, "gray40";
	 `infix, "indianred4";
	 `label, "brown";
	 `uident, "midnightblue";
         `none, "black" ])

let tag ?(start=0) ?stop:pend (tw : GEdit.text) =
  let pend = Gaux.default tw#length ~opt:pend in
  let colors = Lazy.force colors in
  tw#freeze ();
  let position = tw#position
  and text = tw#get_chars ~start ~stop:pend in
  let replace ~start:pstart ~stop:pend ~tag =
    if pend > pstart then begin
      tw#delete_text ~start:(start+pstart) ~stop:(start+pend);
      tw#set_point (start+pstart);
      tw#insert ~foreground:(List.assoc tag colors)
	(String.sub text ~pos:pstart ~len:(pend-pstart));
    end
  and next_lf = ref (-1) in
  let colorize ~start:rstart ~stop:rend ~tag =
    let rstart = ref rstart in
    while !rstart < rend do
      if !next_lf < !rstart then begin
	try next_lf := String.index_from text !rstart '\n'
	with Not_found -> next_lf := pend-start
      end;
      replace ~start:!rstart ~stop:(min !next_lf rend) ~tag;
      rstart := !next_lf + 1
    done
  in
  let buffer = Lexing.from_string text
  and last = ref (EOF, 0, 0)
  and last_pos = ref 0 in
  try
    while true do
    let token = Lexer.token buffer
    and start = Lexing.lexeme_start buffer
    and stop = Lexing.lexeme_end buffer in
    let tag =
      match token with
        AMPERAMPER
      | AMPERSAND
      | BARBAR
      | DO | DONE
      | DOWNTO
      | ELSE
      | FOR
      | IF
      | LAZY
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
      | INITIALIZER
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
      | OBJECT
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
      | QUESTION2
      | SHARP
          -> `infix
      | LABEL _
      | OPTLABEL _
      | QUESTION
      | TILDE
          -> `label
      | UIDENT _ -> `uident
      | LIDENT _ ->
          begin match !last with
            (QUESTION | TILDE), _, _ -> `label
          | _ -> `none
          end
      | COLON ->
          begin match !last with
            LIDENT _, lstart, lstop when lstop = start ->
              colorize ~tag:`none ~start:!last_pos ~stop:lstart;
              colorize ~tag:`label ~start:lstart ~stop;
              last_pos := stop;
              `none
          | _ -> `none
          end
      | EOF -> raise End_of_file
      | _ -> `none
    in
    if tag <> `none then begin
      colorize ~tag:`none ~start:!last_pos ~stop:start;
      colorize ~tag ~start ~stop;
      last_pos := stop
    end;
    last := (token, start, stop)
    done
  with exn ->
    colorize ~tag:`none ~start:!last_pos ~stop:(pend-start);
    tw#thaw ();
    tw#set_position position;
    tw#set_point position;
    match exn with
      End_of_file | Lexer.Error _ -> ()
    | _ -> raise exn

(* $Id$ *)

open StdLabels
open Parser
open Lexing

let tags =
  ["control"; "define"; "structure"; "char";
   "infix"; "label"; "uident"]
and colors =
    ["blue"; "forestgreen"; "purple"; "gray40";
     "indianred4"; "saddlebrown"; "midnightblue"]

let init_tags (tb : GText.buffer) =
  List.iter2 tags colors ~f:
  begin fun tag col ->
    ignore (tb#create_tag ~name:tag [`FOREGROUND col])
  end;
  tb#create_tag ~name:"error" [`FOREGROUND "red"; `WEIGHT `BOLD];
  ()

let line_starts s =
  let len = String.length s in
  let rec next_line ~accu pos =
    if pos >= len then accu else
    let res = try 1 + String.index_from s pos '\n' with Not_found -> 0 in
    if res = 0 then accu else
    next_line ~accu:(res :: accu) res
  in
  next_line ~accu:[0] 0

let rec line_offset ~lines pos =
  match lines with [] -> invalid_arg "Lexical.line_num"
  | last :: prev ->
      if pos >= last then (List.length prev, pos - last)
      else line_offset ~lines:prev pos

let tpos ~(start : GText.iter) ~lines pos =
  let l, c = line_offset ~lines pos in
  if l = 0 then
    start#set_line_index (c + start#line_index)
  else
    (start#forward_lines l)#set_line_index c

let tag ?start ?stop (tb : GText.buffer) =
  let start = Gaux.default tb#start_iter ~opt:start
  and stop = Gaux.default tb#end_iter ~opt:stop in
  (* Printf.printf "tagging: %d-%d\n" start#offset stop#offset;
     flush stdout; *)
  let text = tb#get_text ~start ~stop () in
  let lines = line_starts text in
  let tpos = tpos ~start ~lines in
  let buffer = Lexing.from_string text in
  tb#remove_all_tags ~start ~stop;
  let last = ref (EOF, 0, 0) in
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
          -> "control"
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
      | PRIVATE
      | REC
      | TYPE
      | VAL
      | VIRTUAL
          -> "define"
      | BEGIN
      | END
      | INCLUDE
      | OBJECT
      | OPEN
      | SIG
      | STRUCT
          -> "structure"
      | CHAR _
      | STRING _
          -> "char"
      | BACKQUOTE
      | INFIXOP1 _
      | INFIXOP2 _
      | INFIXOP3 _
      | INFIXOP4 _
      | PREFIXOP _
      | SHARP
          -> "infix"
      | LABEL _
      | OPTLABEL _
      | QUESTION
      | TILDE
          -> "label"
      | UIDENT _ -> "uident"
      | LIDENT _ ->
          begin match !last with
            (QUESTION | TILDE), _, _ -> "label"
          | _ -> ""
          end
      | COLON ->
          begin match !last with
            LIDENT _, lstart, lstop ->
              if lstop = start then
                tb#apply_tag_by_name "label"
                  ~start:(tpos lstart) ~stop:(tpos stop);
              ""
          | _ -> ""
          end
      | EOF -> raise End_of_file
      | _ -> ""
    in
    if tag <> "" then begin
      (* Printf.printf "%d-%d: %s\n" start.pos_cnum stop.pos_cnum tag;
         flush stdout; *)
      tb#apply_tag_by_name tag ~start:(tpos start) ~stop:(tpos stop);
    end;
    last := (token, start, stop)
    done
  with
    End_of_file -> ()
  | Lexer.Error _ -> ()

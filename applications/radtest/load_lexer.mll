{
open Load_parser
} 

rule token = parse
  [ ' ' '\t' '\n']+     { token lexbuf }
| "<window"             { WINDOW_START }
| "</window>"           { WINDOW_END }
| "name"                { NAME }
|  '='                  { EQUAL }
|  '>'                  { SUP }

| "<" ['A'-'Z' 'a'-'z' '0'-'9' '_']+
  {
    let l = Lexing.lexeme lexbuf in
    let s = String.sub l ~pos:1 ~len:(String.length l - 1) in
    WIDGET_START s
  }

| "</" ['A'-'Z' 'a'-'z' '0'-'9' '_']+ '>'
  {
    let l = Lexing.lexeme lexbuf in
    let s = String.sub l ~pos:2 ~len:(String.length l - 3) in
    WIDGET_END s
  }

| '"' [^ '"']* '"'
  {
    let l = Lexing.lexeme lexbuf in
    let s = String.sub l ~pos:1 ~len:(String.length l - 2) in
    IDENT s
  }

| '\'' [^ '\'']* '\''
  {
    let l = Lexing.lexeme lexbuf in
    let s = String.sub l ~pos:1 ~len:(String.length l - 2) in
    IDENT s
  }

| ['A'-'Z' 'a'-'z' '0'-'9' '_' '.']+
  {
    let s = Lexing.lexeme lexbuf in IDENT s
  }

| eof               { EOF }

{
type token =
  | Ident of string
  | String of string
  | Type
  | Equal
  | Lbracket
  | Rbracket
  | Grave
  | Bar
  | EOF

let token_pp ppf = function
  | Ident s    -> Format.fprintf ppf "%s" s
  | String s   -> Format.fprintf ppf "%S" s
  | Type       -> Format.fprintf ppf "type"
  | Equal      -> Format.fprintf ppf "="
  | Lbracket   -> Format.fprintf ppf "["
  | Rbracket   -> Format.fprintf ppf "]"
  | Grave      -> Format.fprintf ppf "`"
  | Bar        -> Format.fprintf ppf "|"
  | EOF        -> Format.fprintf ppf "<EOF>"

let string_buffer = Buffer.create 100
}

let ident_start = ['A'-'Z' 'a'-'z' '_']
let ident_body  = ['A'-'Z' 'a'-'z' '_' '0'-'9']

rule next_token = parse
  | [' ' '\t' '\r' '\n']     { next_token lexbuf }
  | '='                      { Equal }
  | '['                      { Lbracket }
  | ']'                      { Rbracket }
  | '`'                      { Grave }
  | '|'                      { Bar }
  | "type"                   { Type }
  | ident_start ident_body* as str { Ident str }
  | '"'                      {
      Buffer.clear string_buffer;
      string lexbuf;
      let str = Buffer.contents string_buffer in
      String str
    }
  | "(*"                     { comment 1 lexbuf }
  | eof                      { EOF }

and string  = parse
  | '"'                      { () }
  | eof                      { failwith "unfinished string" }
  | _ as c                   { Buffer.add_char string_buffer c; string lexbuf }

and comment nesting = parse
  | "(*"                     { comment (nesting + 1) lexbuf }
  | "*)"                     {
      let nesting = nesting - 1 in
      if nesting = 0 then
        next_token lexbuf
      else
        comment nesting lexbuf
    }
  | _                        { comment nesting lexbuf }


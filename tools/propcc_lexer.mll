{
type token =
  | Ident of string
  | String of string
  | Verbatim of string
  | Colon
  | Slash
  | Lparen
  | Rparen
  | Left_arrow
  | Method
  | Signal
  | EOF

let token_pp ppf = function
  | Ident s    -> Format.fprintf ppf "%s" s
  | String s   -> Format.fprintf ppf "%S" s
  | Verbatim s -> Format.fprintf ppf "{%s}" s
  | Colon      -> Format.fprintf ppf ":"
  | Slash      -> Format.fprintf ppf "/"
  | Lparen     -> Format.fprintf ppf "("
  | Rparen     -> Format.fprintf ppf ")"
  | Left_arrow -> Format.fprintf ppf "->"
  | Method     -> Format.fprintf ppf "method"
  | Signal     -> Format.fprintf ppf "signal"
  | EOF        -> Format.fprintf ppf "<EOF>"

let string_buffer = Buffer.create 100
}

let ident_start = ['A'-'Z' 'a'-'z' '_']
let ident_body  = ['A'-'Z' 'a'-'z' '_' '0'-'9']

rule next_token = parse
  | [' ' '\t' '\r' '\n']     { next_token lexbuf }
  | ':'                      { Colon }
  | '('                      { Lparen }
  | ')'                      { Rparen }
  | '/'                      { Slash }
  | "->"                     { Left_arrow }
  | "method"                 { Method }
  | "signal"                 { Signal }
  | ident_start ident_body* as str { Ident str }
  | '"'                      {
      Buffer.clear string_buffer;
      string lexbuf;
      let str = Buffer.contents string_buffer in
      String str
    }
  | "(*"                     { comment 1 lexbuf }
  | '{'                      { verbatim (Buffer.create 256) 1 lexbuf }
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

and verbatim buffer nesting = parse
  | '{'                      { Buffer.add_char buffer '{'; verbatim buffer (nesting + 1) lexbuf }
  | '}'                      {
      let nesting = nesting - 1 in
      if nesting == 0 then
        Verbatim (Buffer.contents buffer)
      else begin
        Buffer.add_char buffer '}';
        verbatim buffer nesting lexbuf
      end
    }
  | _ as c                   { Buffer.add_char buffer c; verbatim buffer nesting lexbuf }



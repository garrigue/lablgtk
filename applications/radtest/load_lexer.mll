{
open Load_parser
} 

rule token = parse
  [ ' ' '\t' '\n']+     { token lexbuf }
| "<WINDOW>"       { WINDOW }
| "</WINDOW>"      { ENDWINDOW }
| "<CHILD>"        { CHILD}
| "</CHILD>"       { ENDCHILD}
| "<PROPERTY>"     { PROPERTY }
| "<CLASS>"        { CLASS }
| "</PROPERTY>"    { token lexbuf }
| ['A'-'Z' 'a'-'z' '0'-'9' '_']+ { IDENT(Lexing.lexeme lexbuf)}
| eof               { EOF }

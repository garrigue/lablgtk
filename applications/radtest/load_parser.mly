%{
open Utils
%}

%token EOF NAME EQUAL SUP WINDOW_START WINDOW_END
%token <string> WIDGET_START WIDGET_END IDENT

%type <string> window_start
%type <string * string> property widget_start
%type <(string * string) list> property_list
%type <Utils.yywidget_tree> widget window
%type <Utils.yywidget_tree list> children window_list project

%start project
%start window
%start widget

%%

project : window_list EOF        { List.rev $1 }

window_list :                    { [] }
            | window_list window { $2 :: $1 }
; 

window : window_start property_list children WINDOW_END 
  { 
    Node (("window", $1, List.rev $2), $3)
  } 
;

window_start : WINDOW_START NAME EQUAL IDENT SUP   { $4 }
;

children  :                  { [] }
	  | children widget   { $2 :: $1 }
;

widget : widget_start property_list children WIDGET_END
  { 
    let classe, name = $1 in
    if classe <> $4 then raise Parsing.Parse_error;
    Node ((classe, name, List.rev $2), $3)
  } 
;

widget_start  : WIDGET_START NAME EQUAL IDENT SUP   { $1, $4 }
;

property_list :                         { [] }
              | property_list property  { $2 :: $1 }
;

property      : IDENT EQUAL IDENT       { $1, $3 }
;


%{
open Utils
%}

%token NAME EQUAL SUP
%token <string> WIDGET_START WIDGET_END IDENT

%type <string * string> property widget_start
%type <(string * string) list> property_list
%type <Utils.yywidget_tree> widget
%type <Utils.yywidget_tree list> children

%start widget

%%

children  :                  { [] }
	  | children widget   { $2 :: $1 }
;

widget : widget_start property_list children WIDGET_END
  { 
    let classe, name = $1 in
    if classe <> $4 then raise Parsing.Parse_error;
    Node ((classe, name, $2), $3)
  } 
;

widget_start  : WIDGET_START NAME EQUAL IDENT SUP   { $1, $4 }
;

property_list :                         { [] }
              | property_list property  { $2 :: $1 }
;

property      : IDENT EQUAL IDENT       { $1, $3 }
;


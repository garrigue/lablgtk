%{
open GWindow
open Utils
open Treew

let rec add_children (t : tiwidget0) (Node (child, children)) =
  let classe, name, property_list = child in
  let tc = t#add_child_with_name classe name in
  List.iter (List.rev children) fun:(fun c -> add_children tc c);
  List.iter property_list fun:(fun (n,v) -> tc#set_property n v)

%}

%token EOF NAME EQUAL SUP WINDOW_START WINDOW_END
%token <string> WIDGET_START WIDGET_END IDENT

%type <string> window_start
%type <string * string> property widget_start
%type <(string * string) list> property_list
%type <GWindow.window * Treew.tiwidget0> window
%type <(GWindow.window * Treew.tiwidget0) list> window_list project
%type <yywidget_tree> widget
%type <yywidget_tree list> children

%start project

%%

project : window_list EOF        { List.rev $1 }

window_list :                    { [] }
            | window_list window { $2 :: $1 }
; 

window : window_start property_list children WINDOW_END 
  { 
    let wt = new window_and_tree name:$1 in
    let w = wt#tree_window and t = wt#tiwin in
    List.iter $2 fun:(fun (n,v) -> t#set_property n v);
    begin match $3 with
    | [] -> ()
    | [ ch ] -> add_children t ch
    | _ -> raise Parsing.Parse_error
    end;
    w,t
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


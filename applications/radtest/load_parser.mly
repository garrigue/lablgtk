%{
open GWindow
open Treew
%}

%token CHILD ENDCHILD ENDWINDOW PROPERTY WINDOW CLASS EOF
%token <string> IDENT
%start project
%type <(GWindow.window * Treew.tiwrapper0) list> window_list project
%type <GWindow.window * Treew.tiwrapper0> window
%type <GWindow.window * tiwrapper0 list> wp1 wp2

%%
project : window_list EOF        { List.rev $1 }

window_list :                    { [] }
            | window_list window { $2 :: $1 }
; 
window : wp1 ENDWINDOW { fst $1, (List.hd (snd $1)) }
;

wp2 : wp1 CLASS IDENT IDENT
         { let classe=$3 and name = $4 in
           let ch = (List.hd (snd $1))#add_child_with_name classe name in
	   fst $1, ch :: (snd $1) }

    | wp2 PROPERTY IDENT IDENT { let name = $3 and  values = $4 in
                   (List.hd (snd $1))#tiw#set_property name values; $1 }

    | WINDOW IDENT
           { let w,t = new_window name:$2 in w, [t;t] }
;

wp1 : wp2 CHILD { $1 }
    | wp1 ENDCHILD { fst $1, List.tl (snd $1) }
;


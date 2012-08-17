(* lablgtk2 -thread testthread.ml *)

open GtkThread;;

let w = sync (GWindow.window ~show:true) ();;
let b = sync (GButton.button ~label:"Hello" ~packing:w#add) ();;
b#connect#clicked (fun () -> prerr_endline "Hello");;
for i = 1 to 100 do sync b#set_label (string_of_int i) done;;

(**************************************************************************)
(*    Lablgtk - Examples                                                  *)
(*                                                                        *)
(*    This code is in the public domain.                                  *)
(*    You may freely copy parts of it in your application.                *)
(*                                                                        *)
(**************************************************************************)

(* $Id$ *)

let main () =
  ignore (GMain.init ());
  let window = GWindow.window 
    ~border_width:10
    ~width:300 ~height:200 () in
  ignore (window#connect#destroy ~callback:GMain.quit);

  let root_layout = GPack.vbox ~spacing:10 ~packing:window#add () in
  
  let switcher = GPack.stack_switcher ~packing:root_layout#add () in
  let stack = GPack.stack ~packing:root_layout#add () in
  (* switcher#set_stack stack; *)

  window#show ();
  GMain.main ()

let _ = main ()

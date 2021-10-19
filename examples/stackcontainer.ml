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
  
  let stack = GPack.stack ~packing:window#add () in
  stack#set_transition_type `SLIDE_UP; (* default transition *)
  
  let button = GButton.button ~label:"Button 1" 
  ~packing:(fun w -> stack#add_named w "button") () in
  
  let layout = GPack.vbox ~spacing:10 ~packing:(fun w -> 
    stack#add_named w "button2") () in
  let button2 = GButton.button ~label:"Button 2" ~packing:layout#add () in
  let _info_label = GMisc.label ~text:"This is the second pane" ~packing:layout#add () in
  
  ignore (button#connect#clicked ~callback:(fun () -> 
    stack#set_visible_child_full "button2" `SLIDE_LEFT;
    stack#set_transition_duration 1000; (* set to 1 second after first click *)));

  ignore (button2#connect#clicked ~callback:(fun () -> 
    stack#set_visible_child (button :> GObj.widget)));
    
  window#show ();
  GMain.main ()

let _ = main ()

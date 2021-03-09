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

  let root_layout = GPack.box `VERTICAL ~spacing:10 ~homogeneous:false ~packing:window#add () in
  
  let switcher = GPack.stack_switcher () in
  let stack = GPack.stack ~transition_type:`SLIDE_LEFT_RIGHT () in
  switcher#set_stack stack#as_stack;

  root_layout#pack ~expand:false ~fill:false switcher#coerce;
  root_layout#pack ~expand:true ~fill:true stack#coerce;
  switcher#set_halign `CENTER;
  
  let checkbox = GButton.check_button ~label:"Item"
    ~packing:(fun w -> stack#add_titled w "frame1" "Check button") () in

  let label = GMisc.label ~text:"A label"
    ~packing:(fun w -> stack#add_titled w "frame2" "Label") () in

  let entry = GEdit.entry ~placeholder_text:"Type here"
    ~packing:(fun w -> stack#add_titled w "frame3" "Form") () in
  
  window#show ();
  GMain.main ()

let _ = main ()

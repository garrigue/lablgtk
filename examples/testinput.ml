(* $Id$ *)

open GMain

let main () =
  let window = GWindow.window () in
  window#misc#set_name "Test input";
  window#connect#destroy callback:Main.quit;

  let vbox = GPack.vbox packing:window#add () in

  let drawing_area =
    GMisc.drawing_area width:200 height:200 packing:vbox#add () in

  drawing_area#connect#event#key_press callback:
    begin fun ev ->
      let key = GdkEvent.Key.keyval ev in
      if key >= 32 && key < 256 then
	Printf.printf "I got a %c\n" (Char.chr key)
      else
	print_string "I got another key\n";
      flush stdout;
      true
    end;

  drawing_area#add_events
    [`EXPOSURE;`LEAVE_NOTIFY;`BUTTON_PRESS;
     `POINTER_MOTION;`POINTER_MOTION_HINT;`PROXIMITY_OUT];
  drawing_area#misc#set_extension_events `ALL;
  drawing_area#misc#set_can_focus true;
  drawing_area#misc#grab_focus ();

  GButton.button label:"Input Dialog" packing:(vbox#pack expand:false) ();

  let button =
    GButton.button label:"Quit" packing:(vbox#pack expand:false) () in

  button#connect#clicked callback:window#destroy;

  window#show ();
  Main.main ()

let _ = main ()

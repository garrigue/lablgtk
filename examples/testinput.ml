(* $Id$ *)

open GMain

let main () =
  let window = new GWindow.window in
  window#misc#set name:"Test input";
  window#connect#destroy callback:Main.quit;

  let vbox = new GPack.box `VERTICAL packing:window#add in

  let drawing_area =
    new GMisc.drawing_area width:200 height:200 packing:vbox#add in

  drawing_area#event#connect#key_press callback:
    begin fun ev ->
      let key = Gdk.Event.Key.keyval ev in
      if key >= 32 && key < 256 then
	Printf.printf "I got a %c\n" (Char.chr key)
      else
	print_string "I got another key\n";
      flush stdout;
      true
    end;

  drawing_area#event#add
    [`EXPOSURE;`LEAVE_NOTIFY;`BUTTON_PRESS;`KEY_PRESS;
     `POINTER_MOTION;`POINTER_MOTION_HINT;`PROXIMITY_OUT];
  drawing_area#event#set_extensions `ALL;
  drawing_area#misc#set can_focus:true;
  drawing_area#misc#grab_focus ();

  let button =
    new GButton.button label:"Input Dialog" packing:(vbox#pack expand:false) in

  let button =
    new GButton.button label:"Quit" packing:(vbox#pack expand:false) in

  button#connect#clicked callback:window#destroy;

  window#show ();
  Main.main ()

let _ = main ()

(* $Id$ *)

open GMain

let _ =
  let window = new GWindow.window in
  window#connect#destroy callback:Main.quit;

  let text = new GEdit.text editable:true packing:window#add in
  text#connect#event#button_press callback:
    begin fun ev ->
      Gdk.Event.Button.button ev = 3 &&
      Gdk.Event.get_type ev = `BUTTON_PRESS &&
      begin
	let pos = text#position in
	Gdk.Event.Button.set_button ev 1;
	text#misc#event ev;
	Printf.printf "Position is %d.\n" text#position;
	flush stdout;
	text#set_position pos;
	true
      end
    end;
  window#show ();
  Main.main ()

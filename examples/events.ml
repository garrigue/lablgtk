(* $Id$ *)

open GMain

let _ =
  let window = GWindow.window () in
  window#connect#destroy callback:Main.quit;

  let text = GEdit.text editable:true packing:window#add () in
  text#connect#event#button_press callback:
    begin fun ev ->
      GdkEvent.Button.button ev = 3 &&
      GdkEvent.get_type ev = `BUTTON_PRESS &&
      begin
	let pos = text#position in
	GdkEvent.Button.set_button ev 1;
	text#misc#event (GdkEvent.coerce ev);
	Printf.printf "Position is %d.\n" text#position;
	flush stdout;
	text#set_position pos;
	true
      end
    end;
  window#show ();
  Main.main ()

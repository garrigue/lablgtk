(* $Id$ *)

(* This is a direct translation to Gtk2.
   This is actually meaningless, as the new text widget lets you
   obtain an iterator from coordinates, but this just demonstrates
   the use of [#event#send]. *)
(* Old comment by Benjamin:
   I cannot translate this program directly to Gtk 2. The event generation
   causes segfault and starts some drag-n-drop op. 
   The default signal for left button has probably changed.*)
(* I don't see segfaults, just Gtk-criticals. Seems the default handler
   for button 3 is still called, and I see no way to disable that.
   But this is not really relevant to [#event#send]. *)

open GMain

let _ =
  let window = GWindow.window ~width:200 ~height:200 () in
  window#connect#destroy ~callback:Main.quit;

  let text = GText.view ~packing:window#add () in
  let buffer = text#buffer in
  text#event#connect#button_press ~callback:
    begin fun ev ->
      GdkEvent.Button.button ev = 3 &&
      GdkEvent.get_type ev = `BUTTON_PRESS &&
      begin
	let pos = buffer#get_iter_at_mark `INSERT in
	GdkEvent.Button.set_button ev 1;
	text#event#send (ev :> GdkEvent.any);
	Printf.printf "Position is %d.\n" pos#offset;
	flush stdout;
	buffer#move_mark `INSERT ~where:pos;
        GtkSignal.stop_emit ();
	true
      end
    end;
  window#show ();
  Main.main ()

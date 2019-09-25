(**************************************************************************)
(*    Lablgtk - Examples                                                  *)
(*                                                                        *)
(*    This code is in the public domain.                                  *)
(*    You may freely copy parts of it in your application.                *)
(*                                                                        *)
(**************************************************************************)

(* $Id$ *)

(* See comments in events.ml *)

let _ =
  GMain.init ();
  let window = GWindow.window () in
  window#connect#destroy ~callback:GMain.quit;

  let text = GText.view ~width:200 ~height:100 ~packing:window#add () in
  text#event#connect#button_press ~callback:
    begin fun ev ->
      GdkEvent.Button.button ev = 3 &&
      GdkEvent.get_type ev = `BUTTON_PRESS &&
      begin
	let win = match text#get_window `WIDGET with
	  | None -> assert false
	  | Some w -> w
	in
	let x,y = Gdk.Window.get_pointer_location win in
	let b_x,b_y = text#window_to_buffer_coords ~tag:`WIDGET ~x ~y in
	let clicked_pos = text#get_iter_at_location ~x:b_x ~y:b_y in
	Printf.printf "Position is %d.\n" clicked_pos#offset;
	flush stdout;
	true;
      end
    end;
  window#show ();
  GMain.main ()

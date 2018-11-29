(**************************************************************************)
(*    Lablgtk - Examples                                                  *)
(*                                                                        *)
(*    This code is in the public domain.                                  *)
(*    You may freely copy parts of it in your application.                *)
(*                                                                        *)
(**************************************************************************)

(* $Id$ *)

open GMain

let window = GWindow.window ()
let area = GMisc.drawing_area ~packing:window#add ()

let w = area#misc#realize (); area#misc#window
let drawing = new GDraw.drawable w

let redraw _ =
  drawing#polygon ~filled:true
    [ 10,100; 35,35; 100,10; 165,35; 190,100;
      165,165; 100,190; 35,165; 10,100 ];
  false

let _ =
  window#connect#destroy ~callback:Main.quit;
  area#event#connect#expose ~callback:redraw;
  window#show ();
  Main.main ()

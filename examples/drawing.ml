(* $Id$ *)

open GdkObj
open GMain

(* let id = Thread.create GtkThread.main () *)
let window = GWindow.window show:true ()

let w = window#misc#window
let drawing = new drawing w

let _ =
  window#connect#destroy callback:Main.quit;
  window#connect#after#event#expose callback:
    begin fun _ ->
      drawing#polygon filled:true
	[ 10,100; 35,35; 100,10; 165,35; 190,100;
	  165,165; 100,190; 35,165; 10,100 ];
      false
    end;
  (* Thread.join id *)
  Main.main ()

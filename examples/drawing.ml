(* $Id$ *)

open Gdk
open Gtk
open GtkObj

(* let id = Thread.create GtkThread.main () *)
let window = new_window `TOPLEVEL
let w = window#show (); window#misc#window
let gc = GC.create w

let _ =
  window#connect#destroy callback:Main.quit;
  window#connect#event#expose callback:
    begin fun _ ->
      Draw.polygon w gc filled:true
	[ 10,100; 35,35; 100,10; 165,35; 190,100;
	  165,165; 100,190; 35,165; 10,100 ];
      false
    end;
  (* Thread.join id *)
  Main.main ()

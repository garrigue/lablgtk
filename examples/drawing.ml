(* $Id$ *)

open Gtk
open Gdk

(* let id = Thread.create GtkThread.main () *)
let top = Window.create `TOPLEVEL
let _ = Widget.show top
let w = Widget.window top
let gc = GC.create w

let _ =
  Signal.connect top sig:Object.Sig.destroy cb:Main.quit;
  Signal.connect top sig:Signal.Event.expose cb:
    begin fun _ ->
      Draw.polygon w gc filled:true
	[ 10,100; 35,35; 100,10; 165,35; 190,100;
	  165,165; 100,190; 35,165; 10,100 ];
      false
    end;
  (* Thread.join id *)
  Main.main ()

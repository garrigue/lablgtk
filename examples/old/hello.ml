(* $Id$ *)

open GtkBase
open GtkButton
open GtkWindow
open GtkMain

let window = Window.create `TOPLEVEL

let button = Button.create label:"Hello World"

let main () =
  GtkSignal.connect sig:Widget.Signals.Event.delete window
    callback:(fun _ -> prerr_endline "Delete event occured"; true);
  GtkSignal.connect sig:Object.Signals.destroy window callback:Main.quit;
  Container.set_border_width window 10;
  GtkSignal.connect sig:Button.Signals.clicked button
    callback:(fun () -> prerr_endline "Hello World"; Object.destroy window);
  Container.add window button;
  Widget.show_all window;
  Main.main ()

let _ = Printexc.print main ()

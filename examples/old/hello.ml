(* $Id$ *)

open Gtk

let window = Window.create `TOPLEVEL

let button = Button.create label:"Hello World"

let main () =
  Signal.connect sig:Event.Signals.delete window
    callback:(fun _ -> prerr_endline "Delete event occured"; true);
  Signal.connect sig:Object.Signals.destroy window callback:Main.quit;
  Window.set window border_width:10;
  Signal.connect sig:Button.Signals.clicked button
    callback:(fun () -> prerr_endline "Hello World"; Object.destroy window);
  Container.add window button;
  Widget.show_all window;
  Main.main ()

let _ = Printexc.print main ()

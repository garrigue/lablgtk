(* $Id$ *)

open Gtk

let window = Window.create `TOPLEVEL

let button = Button.create_with_label "Hello World"

let main () =
  Signal.connect window sig:Signal.Event.delete
    cb:(fun _ -> prerr_endline "Delete event occured"; true);
  Signal.connect window sig:Object.Sig.destroy cb:Main.quit;
  Container.border_width window 10;
  Signal.connect button sig:Button.Sig.clicked
    cb:(fun () -> prerr_endline "Hello World");
  Signal.connect button sig:Button.Sig.clicked
    cb:(fun () -> Object.destroy window);
  Container.add window button;
  Widget.show_all window;
  Main.main ()

let _ = Printexc.print main ()

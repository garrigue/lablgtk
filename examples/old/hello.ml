(* $Id$ *)

open Gtk

let window = Window.create `TOPLEVEL

let button = Button.create_with_label "Hello World"

let main () =
  Signal.connect window sig:Signal.delete_event
    cb:(fun _ -> prerr_endline "Delete event occured"; Signal.break ());
  Signal.connect window sig:Signal.destroy cb:Main.quit;
  Container.border_width window 10;
  Signal.connect button sig:Signal.clicked
    cb:(fun () -> prerr_endline "Hello World");
  Signal.connect button sig:Signal.clicked
    cb:(fun () -> Widget.destroy window);
  Container.add window button;
  Widget.show_all window;
  Main.main ()

let _ = Printexc.print main ()

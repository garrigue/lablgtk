(* $Id$ *)

open Gtk

let _ =
  Main.init Sys.argv

let window = Window.create `TOPLEVEL

let button = Button.create_with_label "Hello World"

let _ =
  Signal.connect window sig:Signal.delete_event
    cb:(fun () -> print_endline "Delete event occured"; true);
  Signal.connect window sig:Signal.destroy cb:Main.quit;
  Container.border_width window 10;
  Signal.connect button sig:Signal.clicked
    cb:(fun () -> print_endline "Hello World");
  Signal.connect button sig:Signal.clicked
    cb:(fun () -> Widget.destroy window);
  Container.add window button

let rec loop () =
  Main.iteration_do true; (flush stdout; loop ())

let _ =
  Widget.show_all window;
  loop ()


(* $Id$ *)

open Gtk

let window = Window.create `TOPLEVEL

let button = Button.create label:"Hello World"

let main () =
  Event.Connect.delete window
    cb:(fun _ -> prerr_endline "Delete event occured"; true);
  Window.Connect.destroy window cb:Main.quit;
  Window.set window border_width:10;
  Button.Connect.clicked button
    cb:(fun () -> prerr_endline "Hello World"; Object.destroy window);
  Window.add window button;
  Window.show_all window;
  Main.main ()

let _ = Printexc.print main ()

(* $Id$ *)

#load "gtkObj.cmo"

open Gtk
open GtkObj

let window = new_window `TOPLEVEL

let button = new_button label:"Hello World"

let main () =
  window#connect#event#delete 
    cb:(fun _ -> prerr_endline "Delete event occured"; Signal.break ());
  window#connect#destroy cb:Main.quit;
  window#border_width 10;
  button#connect#clicked cb:(fun () -> prerr_endline "Hello World");
  button#connect#clicked cb:(fun () -> window#destroy);
  window#add button;
  window#show_all;
  Main.main ()

let _ = Printexc.print main ()

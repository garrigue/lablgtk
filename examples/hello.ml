(* $Id$ *)

#load "gtkObj.cmo"

open Gtk
open GtkObj

let window = new_window `TOPLEVEL

let button = new_button label:"Hello World"

let main () =
  window#connect#event#delete 
    callback:(fun _ -> prerr_endline "Delete event occured"; true);
  window#connect#destroy callback:Main.quit;
  window#set border_width: 10;
  button#connect#clicked callback:(fun () -> prerr_endline "Hello World");
  button#connect#clicked callback:window#destroy;
  window#add button;
  window#show_all ();
  Main.main ()

let _ = Printexc.print main ()

(* $Id$ *)

open GMain

let window = new GWindow.window `TOPLEVEL border_width: 10

let button = new GButton.button label:"Hello World" packing: window#add

let main () =
  window#connect#event#delete 
    callback:(fun _ -> prerr_endline "Delete event occured"; true);
  window#connect#destroy callback:Main.quit;
  button#connect#clicked callback:(fun () -> prerr_endline "Hello World");
  button#connect#clicked callback:window#destroy;
  window#show_all ();
  Main.main ()

let _ = Printexc.print main ()

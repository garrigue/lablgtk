(* $Id$ *)

open GtkObj
open Printf

let enter_callback (entry : entry) =
  printf "Entry contents: %s\n" entry#text;
  flush stdout

let entry_toggle_editable (button : #toggle_button) (entry : #entry) =
  entry#set_editable button#active

let entry_toggle_visibility (button : #toggle_button) (entry : #entry) =
  entry#set_visibility button#active

let main () =

  let window =
    new_window `TOPLEVEL title: "GTK Entry" width: 200 height: 100 in
  window#connect#destroy callback:Main.quit;

  let vbox = new_box `VERTICAL packing: window#add in

  let entry = new_entry max_length: 50 packing: vbox#add in
  entry#connect#activate callback:(fun () -> enter_callback entry);
  entry#set_text "Hello";
  entry#append_text " world";
  entry#select_region start:0 end:entry#text_length;

  let hbox = new_box `HORIZONTAL packing: vbox#add in

  let check =
    new_check_button label: "Editable" active: true packing: hbox#pack in
  check#connect#toggled callback:(fun () -> entry_toggle_editable check entry);

  let check =
    new_check_button label: "Visible" active: true packing: hbox#pack in
  check#connect#toggled
    callback:(fun () -> entry_toggle_visibility check entry);

  let button = new_button label: "Close" packing: vbox#pack in
  button#connect#clicked callback:window#destroy;
  button#grab_default ();

  window#show_all ();

  Main.main ()

let _ = main ()

(* $Id$ *)

open Gtk
open GtkObj
open Printf

let enter_callback (entry : entry) =
  printf "Entry contents: %s\n" entry#text;
  flush stdout

let entry_toggle_editable (button : toggle_button) (entry : entry) =
  entry#set editable:button#active

let entry_toggle_visibility (button : toggle_button) (entry : entry) =
  entry#set visibility:button#active

let main () =

  let window = new_window `TOPLEVEL in
  window#set title:"GTK Entry" width:200 height:100;
  window#connect#destroy callback:Main.quit;

  let vbox = new_box `VERTICAL in
  window#add vbox;

  let entry = new_entry max_length: 50 in
  entry#connect#activate callback:(fun () -> enter_callback entry);
  entry#set_text "Hello";
  entry#append_text " world";
  entry#select_region start:0 end:entry#text_length;
  vbox#pack entry;

  let hbox = new_box `HORIZONTAL in
  vbox#add hbox;

  let check = new_check_button label:"Editable" in
  hbox#pack check;
  check#connect#toggled callback:(fun () -> entry_toggle_editable check entry);
  check#set state:true;

  let check = new_check_button label:"Visible" in
  hbox#pack check;
  check#connect#toggled
    callback:(fun () -> entry_toggle_visibility check entry);
  check#set state:true;

  let button = new_button label:"Close" in
  button#connect#clicked callback:Main.quit;
  vbox#pack button;
  button#set can_default:true;
  button#grab_default ();

  window#show_all ();

  Main.main ()

let _ = main ()

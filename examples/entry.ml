(* $Id$ *)

open Gtk
open Printf

let enter_callback entry =
  printf "Entry contents: %s\n" (Entry.get_text entry);
  flush stdout

let entry_toggle_editable button entry =
  Entry.set entry editable:(ToggleButton.active button)

let entry_toggle_visibility button entry =
  Entry.set entry visibility:(ToggleButton.active button)

let main () =

  let window = Window.create `TOPLEVEL in
  Widget.set window width:200 height:100;
  Window.set_title window "GTK Entry";
  Window.Connect.destroy window cb:Main.quit;

  let vbox = Box.create `VERTICAL in
  Window.add window vbox;

  let entry = Entry.create_with_max_length 50 in
  Entry.Connect.activate entry
    cb:(fun () -> enter_callback entry);
  Entry.set entry text:"Hello";
  Entry.append_text entry " world";
  Entry.select_region entry start:0 end:(Entry.text_length entry);
  Box.pack vbox entry;

  let hbox = Box.create `HORIZONTAL in
  Box.add vbox hbox;

  let check = ToggleButton.create `check label:"Editable" in
  Box.pack hbox check;
  ToggleButton.Connect.toggled check
    cb:(fun () -> entry_toggle_editable check entry);
  ToggleButton.set check state:true;

  let check = ToggleButton.create `check label:"Visible" in
  Box.pack hbox check;
  ToggleButton.Connect.toggled check
    cb:(fun () -> entry_toggle_visibility check entry);
  ToggleButton.set check state:true;

  let button = Button.create_with_label "Close" in
  Button.Connect.clicked button cb:Main.quit;
  Box.pack vbox button;
  Widget.set button can_default:true;
  Widget.grab_default button;

  Window.show_all window;

  Main.main ()

let _ = main ()

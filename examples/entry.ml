(**************************************************************************)
(*    Lablgtk - Examples                                                  *)
(*                                                                        *)
(*    This code is in the public domain.                                  *)
(*    You may freely copy parts of it in your application.                *)
(*                                                                        *)
(**************************************************************************)

(* $Id$ *)

open Printf

let enter_callback entry =
  printf "Entry contents: %s\n" entry#text;
  flush stdout

let entry_toggle_editable button entry =
  entry#set_editable button#active

let entry_toggle_visibility button entry =
  entry#set_visibility button#active

let main () =
  GMain.init ();
  let window =
    GWindow.window ~title: "GTK Entry" ~width: 200 ~height: 100 () in
  window#connect#destroy ~callback:GMain.quit;

  let vbox = GPack.vbox ~packing: window#add () in

  let entry = GEdit.entry ~max_length: 50 ~packing: vbox#add () in
  entry#connect#activate ~callback:(fun () -> enter_callback entry);
  entry#set_text "Hello";
  (* Appending text now requires getting the underlying buffer, and
   * entry#buffer is not exposed in the bindings yet *)
  (*entry#append_text " world";*)
  entry#select_region ~start:0 ~stop:entry#text_length;

  let hbox = GPack.hbox ~packing: vbox#add () in

  let check = GButton.check_button ~label: "Editable" ~active: true
      ~packing: hbox#add () in
  check#connect#toggled
    ~callback:(fun () -> entry_toggle_editable check entry);

  let check =
    GButton.check_button ~label:"Visible" ~active:true ~packing:hbox#add () in
  check#connect#toggled
    ~callback:(fun () -> entry_toggle_visibility check entry);

  let button = GButton.button ~label: "Close" ~packing: vbox#add () in
  button#connect#clicked ~callback:window#destroy;
  button#grab_default ();

  window#show ();

  GMain.main ()

let _ = main ()

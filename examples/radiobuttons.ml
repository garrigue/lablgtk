(* $Id$ *)

open Gtk
open GtkObj

let main () =

  let window = new_window `TOPLEVEL in
  window#connect#destroy callback:Main.quit;
  window#set title: "radio buttons" border_width: 0;

  let box1 = new_box `VERTICAL in
  window#add box1;

  let box2 = new_box `VERTICAL spacing:10 in
  box2#set border_width: 10;
  box1#pack box2;

  let button1 = new_radio_button label:"button1" in
  box2#pack button1;

  let button2 = new_radio_button group:button1#group label:"button2" in
  button2#set state:true;
  box2#pack button2;

  let button3 = new_radio_button group:button1#group label:"button3" in
  box2#pack button3;

  let separator = new_separator `HORIZONTAL in
  box1#pack separator expand:false;
  
  let box3 = new_box `VERTICAL spacing:10 in
  box3#set border_width: 10;
  box1#pack box3 expand:false;

  let button = new_button label: "close" in
  button#connect#clicked callback:Main.quit;
  box3#pack button;
  button#set can_default:true;
  button#grab_default ();

  window#show_all ();

  Main.main ()

let _ = main ()

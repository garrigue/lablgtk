(* $Id$ *)

open Gtk
open GtkObj

let main () =
  let window = new_dialog () in
  window#connect#destroy callback:Main.quit;
  window#set title: "dialog" border_width: 10;
  window#widget_ops#set width: 300 height: 300;

  let scrolled_window = new_scrolled_window () in
  scrolled_window#set border_width: 10;
  scrolled_window#set_policy horizontal: `AUTOMATIC vertical: `ALWAYS;
  window#vbox#pack scrolled_window;
  scrolled_window#show ();

  let table = new_table rows:10 columns:10 in
  table#set row_spacings: 10 col_spacings: 10;

  scrolled_window#add table;
  table#show ();

  for i = 0 to 9 do
    for j = 0 to 9 do
      let label = Printf.sprintf "button (%d,%d)\n" i j in
      let button = new_toggle_button :label in
      table#attach button left: i top: j;
      button#show ()
    done
  done;

  let button = new_button label: "close" in
  button#connect#clicked callback: Main.quit;
  (* GTK_WIDGET_SET_FLAGS(button, GTK_CAN_DEFAULT) is as follows *)
  button#widget_ops#set can_default:true;
  window#action_area#pack button;
  button#widget_ops#grab_default ();
  button#show ();
  window#show ();
  Main.main ()

let _ = main ()
    

(* $Id$ *)

#load "gtkObj.cmo"

open Gtk
open GtkObj

let rec fix fun:f :eq x =
  let x' = f x in
  if eq x x' then x
  else fix fun:f :eq x'

let eq_float x y = abs_float (x -. y) < 1e-13

let _ =
  let top = new_window `TOPLEVEL in
  top#connect#destroy callback:Main.quit;
  let vbox = new_box `VERTICAL in
  top#add vbox;
  let entry = new_entry max_length:20 in
  let tips = new_tooltips () in
  tips#set_tip entry text:"Initial value for fix-point";
  let result = new_entry max_length:20 in
  result#set editable:false;
  vbox#pack entry;
  vbox#pack result;

  entry#connect#activate callback:
    begin fun () ->
      let x = try float_of_string entry#text with _ -> 0.0 in
      entry#set text:(string_of_float (cos x));
      let res = fix fun:cos eq:eq_float x in
      result#set text:(string_of_float res)
    end;
  top#show_all ();
  Main.main ()

(* $Id$ *)

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
  let vbox = new_box `VERTICAL packing: top#add in
  let entry = new_entry max_length: 20 packing: vbox#pack in
  let tips = new_tooltips () in
  tips#set_tip entry text:"Initial value for fix-point";
  let result = new_entry max_length: 20 editable: false packing: vbox#pack in

  entry#connect#activate callback:
    begin fun () ->
      let x = try float_of_string entry#text with _ -> 0.0 in
      entry#set_text (string_of_float (cos x));
      let res = fix fun:cos eq:eq_float x in
      result#set_text (string_of_float res)
    end;
  top#show_all ();
  Main.main ()

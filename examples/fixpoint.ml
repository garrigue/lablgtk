(**************************************************************************)
(*    Lablgtk - Examples                                                  *)
(*                                                                        *)
(*    This code is in the public domain.                                  *)
(*    You may freely copy parts of it in your application.                *)
(*                                                                        *)
(**************************************************************************)

(* $Id$ *)

let rec fix ~f ~eq x =
  let x' = f x in
  if eq x x' then x
  else fix ~f ~eq x'

let eq_float x y = abs_float (x -. y) < 1e-13

let _ =
  let _ = GMain.init () in
  let top = GWindow.window ~resizable: false () in
  top#connect#destroy ~callback:GMain.quit;
  let vbox = GPack.vbox ~packing: top#add () in
  let label = GMisc.label ~text: "Fixed point of cos(x)" ~packing: vbox#add () in
  let entry = GEdit.entry ~max_length: 20 ~packing: vbox#add () in
  entry#set_tooltip_text "Initial value for fix-point";
  let result =
    GEdit.entry ~max_length: 20 ~editable: false ~packing: vbox#add () in

  entry#connect#activate ~callback:
    begin fun () ->
      let x = try float_of_string entry#text with _ -> 0.0 in
      entry#set_text (string_of_float (cos x));
      let res = fix ~f:cos ~eq:eq_float x in
      result#set_text (string_of_float res)
    end;
  top#show ();
  GMain.main ()

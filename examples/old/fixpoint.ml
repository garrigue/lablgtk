(* $Id$ *)

open GtkData
open GtkBase
open GtkPack
open GtkWindow
open GtkEdit
open GtkMain

let rec fix fun:f :eq x =
  let x' = f x in
  if eq x x' then x
  else fix fun:f :eq x'

let eq_float x y = abs_float (x -. y) < 1e-13

let _ =
  let top = Window.create `TOPLEVEL in
  GtkSignal.connect sig:Object.Signals.destroy top callback:Main.quit;
  let hbox = Box.create `VERTICAL in
  Container.add top hbox;
  let entry = Entry.create () in
  Entry.set entry max_length:20;
  let tips = Tooltips.create () in
  Tooltips.set_tip tips entry text:"Initial value for fix-point";
  let result = Entry.create () in
  Entry.set result max_length:20 editable:false;
  Box.pack hbox entry;
  Box.pack hbox result;

  GtkSignal.connect sig:Editable.Signals.activate entry callback:
    begin fun () ->
      let x = try float_of_string (Entry.get_text entry) with _ -> 0.0 in
      Entry.set entry text:(string_of_float (cos x));
      let res = fix fun:cos eq:eq_float x in
      Entry.set result text:(string_of_float res)
    end;
  Widget.show_all top;
  Main.main ()

(* $Id$ *)

open Misc
open GObj

class multibox :rows :columns ?:row_view [< rows >] ?:col_view [< columns >]
    ?:packing ?:show =
  let sw =
    new GFrame.scrolled_window hpolicy:`AUTOMATIC vpolicy:`AUTOMATIC
      ?:show ?:packing in
  let vp = new GFrame.viewport shadow_type:`NONE packing:sw#add in
  let table = new GPack.table :columns :rows homogeneous:true packing:vp#add in
  let buttons =
    Array.init len:columns
      fun:(fun left -> Array.init len:rows
	  fun:(fun top ->
	    new GButton.button packing:(table#attach :top :left)))
  in
  object (self)
    inherit widget sw#as_widget
    method cell :col :row = buttons.(col).(row)
    initializer
      let id = ref None in
      id := Some
	  (sw#connect#event#expose after:true callback:
	     begin fun _ ->
	       may !id fun:sw#connect#disconnect;
	       let height = table#misc#allocation.height * row_view / rows
	       and width = table#misc#allocation.width * col_view / columns in
	       vp#misc#set_size :height :width;
	       false
	     end);
      table#focus#set_vadjustment vp#vadjustment
  end

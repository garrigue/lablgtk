(* $Id$ *)

open Misc
open Gtk
open GtkData
open GObj

class data_signals obj ?:after = object
  inherit gtkobj_signals obj ?:after
  method disconnect = GtkSignal.connect sig:Data.Signals.disconnect obj ?:after
end

class adjustment_signals obj ?:after = object
  inherit data_signals obj ?:after
  method changed = GtkSignal.connect sig:Adjustment.Signals.changed obj ?:after
  method value_changed =
    GtkSignal.connect sig:Adjustment.Signals.value_changed obj ?:after
end

class adjustment_wrapper obj = object
  inherit gtkobj obj
  method as_adjustment : Gtk.adjustment obj = obj
  method connect = new adjustment_signals ?obj
  method set_value = Adjustment.set_value obj
  method clamp_page = Adjustment.clamp_page obj
  method value = Adjustment.get_value obj
end

class adjustment :value :lower :upper :step_incr :page_incr :page_size =
  let w =
    Adjustment.create :value :lower :upper :step_incr :page_incr :page_size in
  adjustment_wrapper w

class tooltips_wrapper obj = object
  inherit gtkobj (obj : tooltips obj)
  method connect = new data_signals ?obj
  method enable () = Tooltips.enable obj
  method disable () = Tooltips.disable obj
  method set_tip : 'b . (#is_widget as 'b) -> _ =
    fun w -> Tooltips.set_tip ?obj ?w#as_widget
  method set = Tooltips.set ?obj
end

class tooltips ?:delay ?:foreground ?:background =
  let w = Tooltips.create () in
  let () = Tooltips.setter w cont:null_cont ?:delay ?:foreground ?:background
  in tooltips_wrapper w

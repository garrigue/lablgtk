(* $Id$ *)

open Misc
open Gtk
open GtkData
open GObj

class data_signals obj = object
  inherit gtkobj_signals obj
  method disconnect_data =
    GtkSignal.connect sig:Data.Signals.disconnect obj
end

class adjustment_signals obj = object
  inherit data_signals obj
  method changed = GtkSignal.connect sig:Adjustment.Signals.changed obj
  method value_changed =
    GtkSignal.connect sig:Adjustment.Signals.value_changed obj
end

class adjustment_wrapper obj = object
  inherit gtkobj obj
  method as_adjustment : Gtk.adjustment obj = obj
  method connect = new adjustment_signals ?obj
  method set_value = Adjustment.set_value obj
  method clamp_page = Adjustment.clamp_page obj
  method lower = Adjustment.get_lower obj
  method upper = Adjustment.get_upper obj
  method value = Adjustment.get_value obj
  method step_increment = Adjustment.get_step_increment obj
  method page_increment = Adjustment.get_page_increment obj
  method page_size = Adjustment.get_page_size obj
end

class adjustment ?:value [< 0. >] ?:lower [< 0. >] ?:upper [< 100. >]
    ?:step_incr [< 1. >] ?:page_incr [< 10. >] ?:page_size [< 10. >] =
  let w =
    Adjustment.create :value :lower :upper :step_incr :page_incr :page_size in
  adjustment_wrapper w

let adjustment_option = function None -> None
  | Some (adj : adjustment) -> Some adj#as_adjustment

let set_tooltips obj ?:delay ?:foreground ?:background =
  Tooltips.set obj ?:delay
    ?foreground:(may_map foreground fun:GdkObj.color)
    ?background:(may_map background fun:GdkObj.color)

class tooltips_wrapper obj = object
  inherit gtkobj (obj : tooltips obj)
  method connect = new data_signals ?obj
  method enable () = Tooltips.enable obj
  method disable () = Tooltips.disable obj
  method set_tip : 'b . (#is_widget as 'b) -> _ =
    fun w -> Tooltips.set_tip ?obj ?w#as_widget
  method set = set_tooltips ?obj

end

class tooltips ?:delay ?:foreground ?:background =
  let w = Tooltips.create () in
  let () = set_tooltips w ?:delay ?:foreground ?:background
  in tooltips_wrapper w

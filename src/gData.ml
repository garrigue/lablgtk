(* $Id$ *)

open Gaux
open Gtk
open GtkData
open GObj

class data_signals obj = object
  inherit gtkobj_signals obj
  method disconnect_data =
    GtkSignal.connect ~sgn:Data.Signals.disconnect obj ~after
end

class adjustment_signals obj = object
  inherit data_signals obj
  method changed = GtkSignal.connect ~sgn:Adjustment.Signals.changed obj ~after
  method value_changed =
    GtkSignal.connect ~sgn:Adjustment.Signals.value_changed obj ~after
end

class adjustment obj = object
  inherit gtkobj obj
  method as_adjustment : Gtk.adjustment obj = obj
  method connect = new adjustment_signals obj
  method set_value = Adjustment.set_value obj
  method clamp_page = Adjustment.clamp_page obj
  method lower = Adjustment.get_lower obj
  method upper = Adjustment.get_upper obj
  method value = Adjustment.get_value obj
  method step_increment = Adjustment.get_step_increment obj
  method page_increment = Adjustment.get_page_increment obj
  method page_size = Adjustment.get_page_size obj
  method set_bounds = Adjustment.set_bounds obj
end

let adjustment ?(value=0.) ?(lower=0.) ?(upper=100.)
    ?(step_incr=1.) ?(page_incr=10.) ?(page_size=10.) () =
  let w =
    Adjustment.create ~value ~lower ~upper ~step_incr ~page_incr ~page_size in
  new adjustment w

let as_adjustment (adj : adjustment) = adj#as_adjustment

class tooltips obj = object
  inherit gtkobj (obj : Gtk.tooltips obj)
  method as_tooltips = obj
  method connect = new data_signals obj
  method enable () = Tooltips.enable obj
  method disable () = Tooltips.disable obj
  method set_tip ?text ?privat w =
    Tooltips.set_tip obj (as_widget w) ?text ?privat
  method set_delay = Tooltips.set_delay obj
end

let tooltips ?delay () =
  let tt = Tooltips.create () in
  may delay ~f:(Tooltips.set_delay tt);
  new tooltips tt




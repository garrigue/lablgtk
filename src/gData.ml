(* $Id$ *)

open Gaux
open Gobject
open Gtk
open GtkBase
open GtkData
open GObj

class adjustment_signals obj = object
  inherit gtkobj_signals obj
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

let wrap_adjustment w = new adjustment (unsafe_cast w)
let unwrap_adjustment w = unsafe_cast w#as_adjustment
let conv_adjustment_option =
  { kind = `OBJECT;
    proj = (function `OBJECT c -> may_map ~f:wrap_adjustment c
           | _ -> failwith "GObj.get_object");
    inj = (fun c -> `OBJECT (may_map ~f:unwrap_adjustment c)) }
let conv_adjustment =
  { kind = `OBJECT;
    proj = (function `OBJECT (Some c) -> wrap_adjustment c
           | `OBJECT None -> raise Gpointer.Null
           | _ -> failwith "GObj.get_object");
    inj = (fun c -> `OBJECT (Some (unwrap_adjustment c))) }

class tooltips obj = object
  inherit gtkobj (obj : Gtk.tooltips obj)
  method as_tooltips = obj
  method connect = new gtkobj_signals obj
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

class clipboard clip = object (self)
  method private clip = Lazy.force clip
  method clear () = Clipboard.clear self#clip
  method set_text = Clipboard.set_text self#clip
  method text = Clipboard.wait_for_text self#clip
  method get_contents ~target =
    new GObj.selection_data (Clipboard.wait_for_contents self#clip ~target)
end

let clipboard selection =
  new clipboard (lazy (Clipboard.get selection))

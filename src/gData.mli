(* $Id$ *)

open Gtk

class adjustment_signals :
  'a obj ->
  object
    inherit GObj.gtkobj_signals
    constraint 'a = [> adjustment]
    val obj : 'a obj
    method changed : callback:(unit -> unit) -> GtkSignal.id
    method value_changed : callback:(unit -> unit) -> GtkSignal.id
  end

class adjustment : Gtk.adjustment obj ->
  object
    inherit GObj.gtkobj
    val obj : Gtk.adjustment obj
    method as_adjustment : Gtk.adjustment obj
    method clamp_page : lower:float -> upper:float -> unit
    method connect : adjustment_signals
    method set_value : float -> unit
    method lower : float
    method upper : float
    method value : float
    method step_increment : float
    method page_increment : float
    method page_size : float
    method set_bounds :
      ?lower:float -> ?upper:float -> ?step_incr:float ->
      ?page_incr:float -> ?page_size:float -> unit -> unit
  end
val adjustment :
  ?value:float ->
  ?lower:float ->
  ?upper:float ->
  ?step_incr:float ->
  ?page_incr:float -> ?page_size:float -> unit -> adjustment

val as_adjustment : adjustment -> Gtk.adjustment obj
val conv_adjustment : adjustment Gobject.data_conv
val conv_adjustment_option : adjustment option Gobject.data_conv

class tooltips :
  Gtk.tooltips obj ->
  object
    inherit GObj.gtkobj
    val obj : Gtk.tooltips obj
    method as_tooltips : Gtk.tooltips obj
    method connect : GObj.gtkobj_signals
    method disable : unit -> unit
    method enable : unit -> unit
    method set_delay : int -> unit
    method set_tip : ?text:string -> ?privat:string -> GObj.widget -> unit
  end
val tooltips : ?delay:int -> unit -> tooltips

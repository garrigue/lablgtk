(* $Id$ *)

open Gtk

class data_signals :
  'a obj ->
  object
    inherit GObj.gtkobj_signals
    constraint 'a = [>`data]
    val obj : 'a obj
    method disconnect_data : callback:(unit -> unit) -> GtkSignal.id
  end

class adjustment_signals :
  'a obj ->
  object
    inherit data_signals
    constraint 'a = [>`adjustment|`data]
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
  end
val adjustment :
  ?value:float ->
  ?lower:float ->
  ?upper:float ->
  ?step_incr:float ->
  ?page_incr:float -> ?page_size:float -> unit -> adjustment

val as_adjustment : adjustment -> Gtk.adjustment obj

class tooltips :
  Gtk.tooltips obj ->
  object
    inherit GObj.gtkobj
    val obj : Gtk.tooltips obj
    method as_tooltips : Gtk.tooltips obj
    method connect : data_signals
    method disable : unit -> unit
    method enable : unit -> unit
    method set_delay : int -> unit
    method set_foreground : GdkObj.color -> unit
    method set_background : GdkObj.color -> unit
    method set_tip : ?text:string -> ?private:string -> GObj.widget -> unit
  end
val tooltips :
  ?delay:int ->
  ?foreground:GdkObj.color -> ?background:GdkObj.color -> unit -> tooltips

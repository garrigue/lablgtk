(* $Id$ *)

open Gtk

class data_signals :
  'a[> data] obj ->
  object
    inherit GObj.gtkobj_signals
    val obj : 'a obj
    method disconnect_data :
	callback:(unit -> unit) -> ?after:bool -> GtkSignal.id
  end

class adjustment_signals :
  'a[> adjustment data] obj ->
  object
    inherit data_signals
    val obj : 'a obj
    method changed : callback:(unit -> unit) -> ?after:bool -> GtkSignal.id
    method value_changed :
	callback:(unit -> unit) -> ?after:bool -> GtkSignal.id
  end

class adjustment :
  ?value:float ->
  ?lower:float ->
  ?upper:float ->
  ?step_incr:float -> ?page_incr:float -> ?page_size:float ->
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
class adjustment_wrapper : Gtk.adjustment obj -> adjustment

class tooltips :
  ?delay:int -> ?foreground:GdkObj.color -> ?background:GdkObj.color ->
  object
    inherit GObj.gtkobj
    val obj : Gtk.tooltips obj
    method connect : data_signals
    method disable : unit -> unit
    method enable : unit -> unit
    method set :
      ?delay:int ->
      ?foreground:GdkObj.color -> ?background:GdkObj.color -> unit
    method set_tip : #GObj.is_widget -> ?text:string -> ?private:string -> unit
  end
class tooltips_wrapper : Gtk.tooltips obj -> tooltips

val adjustment_option : adjustment option -> Gtk.adjustment obj option

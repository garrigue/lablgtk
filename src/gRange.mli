(* $Id$ *)

open Gtk
open GObj

class progress_bar : Gtk.progress_bar obj ->
  object
    inherit widget_full
    val obj : Gtk.progress_bar Gtk.obj
    method adjustment : GData.adjustment
    method event : GObj.event_ops
    method pulse : unit -> unit
    method set_adjustment : GData.adjustment -> unit
    method set_fraction : float -> unit
    method set_orientation : Tags.progress_bar_orientation -> unit
    method set_pulse_step : float -> unit
    method set_text : string -> unit
    method fraction : float
    method orientation : Tags.progress_bar_orientation
    method pulse_step : float
    method text : string
  end

val progress_bar :
  ?orientation:Tags.progress_bar_orientation ->
  ?pulse_step:float ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> progress_bar

class range_signals : [> Gtk.range] obj ->
  object
    inherit widget_signals
    method adjust_bounds : callback:(float -> unit) -> GtkSignal.id
    method move_slider : callback:(Tags.scroll_type -> unit) -> GtkSignal.id
    method value_changed : callback:(unit -> unit) -> GtkSignal.id
  end

class range : ([> Gtk.range] as 'a) obj ->
  object
    inherit widget
    val obj : 'a obj
    method connect : range_signals
    method set_adjustment : GData.adjustment -> unit
    method set_inverted : bool -> unit
    method set_update_policy : Tags.update_type -> unit
    method adjustment : GData.adjustment
    method inverted : bool
    method update_policy : Tags.update_type
  end

class scale : Gtk.scale obj ->
  object
    inherit range
    val obj : Gtk.scale obj
    method set_digits : int -> unit
    method set_draw_value : bool -> unit
    method set_value_pos : Tags.position -> unit
    method digits : int
    method draw_value : bool
    method value_pos : Tags.position
  end
val scale :
  Tags.orientation ->
  ?adjustment:GData.adjustment ->
  ?digits:int ->
  ?draw_value:bool ->
  ?value_pos:Tags.position ->
  ?inverted:bool ->
  ?update_policy:Tags.update_type ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> scale

class scrollbar : Gtk.scrollbar obj ->
  object
    inherit range
    val obj : Gtk.scrollbar obj
    method event : event_ops
  end
val scrollbar :
  Tags.orientation ->
  ?adjustment:GData.adjustment ->
  ?inverted:bool ->
  ?update_policy:Tags.update_type ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> scrollbar

class ruler :
  ([> Gtk.ruler] as 'a) Gtk.obj ->
  object
    inherit widget_full
    val obj : 'a Gtk.obj
    method set_metric : Tags.metric_type -> unit
    method set_lower : float -> unit
    method set_max_size : float -> unit
    method set_metric : Gtk.Tags.metric_type -> unit
    method set_position : float -> unit
    method set_upper : float -> unit
    method lower : float
    method max_size : float
    method position : float
    method upper : float
  end
val ruler :
  Tags.orientation ->
  ?metric:Tags.metric_type ->
  ?lower:float ->
  ?upper:float ->
  ?max_size:float ->
  ?position:float ->
  ?packing:(GObj.widget -> unit) -> ?show:bool -> unit -> ruler

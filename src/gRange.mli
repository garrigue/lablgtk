(* $Id$ *)

open Gtk
open GObj

class progress_bar : Gtk.progress_bar obj ->
object
  inherit widget_full
  constraint 'a = Gtk.progress_bar
  val obj : 'a obj
method event : GObj.event_ops
  method pulse : unit -> unit
  method set_text : string -> unit
  method set_fraction : float -> unit
  method set_pulse_step : float -> unit
  method set_orientation : Tags.progress_bar_orientation -> unit
  method get_text : string
  method get_fraction : float
  method get_pulse_step : float
  method get_orientation : Tags.progress_bar_orientation

end

val progress_bar :
  ?text:string -> 
  ?fraction:float ->
  ?pulse_step:float ->
  ?orientation:Tags.progress_bar_orientation ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> progress_bar

class range : 'a obj ->
  object
    inherit widget_full
    constraint 'a = [> Gtk.range]
    val obj : 'a obj
    method adjustment : GData.adjustment
    method set_adjustment : GData.adjustment -> unit
    method set_update_policy : Tags.update_type -> unit
  end

class scale : Gtk.scale obj ->
  object
    inherit range
    val obj : Gtk.scale obj
    method set_digits : int -> unit
    method set_draw_value : bool -> unit
    method set_value_pos : Tags.position -> unit
  end
val scale :
  Tags.orientation ->
  ?adjustment:GData.adjustment ->
  ?digits:int ->
  ?draw_value:bool ->
  ?value_pos:Tags.position ->
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
  ?update_policy:Tags.update_type ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> scrollbar

class ruler :
  ([> Gtk.ruler] as 'a) Gtk.obj ->
  object
    inherit widget_full
    val obj : 'a Gtk.obj
    method lower : float
    method max_size : float
    method position : float
    method set_metric : Tags.metric_type -> unit
    method set_range :
      ?lower:float ->
      ?upper:float -> ?position:float -> ?max_size:float -> unit -> unit
    method upper : float
  end
val ruler :
  Tags.orientation ->
  ?metric:Tags.metric_type ->
  ?lower:float ->
  ?upper:float ->
  ?position:float ->
  ?max_size:float ->
  ?packing:(GObj.widget -> unit) -> ?show:bool -> unit -> ruler

(* $Id$ *)

open Gtk
open GObj

class progress : 'a obj ->
  object
    inherit widget_full
    constraint 'a = [>`progress|`widget]
    val obj : 'a obj
    method adjustment : GData.adjustment
    method configure : current:float -> min:float -> max:float -> unit
    method current_text : string
    method percentage : float
    method set_activity_mode : bool -> unit
    method set_adjustment : GData.adjustment -> unit
    method set_format_string : string -> unit
    method set_percentage : float -> unit
    method set_show_text : bool -> unit
    method set_text_alignment : ?x:float -> ?y:float -> unit -> unit
    method set_value : float -> unit
    method value : float
  end

class progress_bar : Gtk.progress_bar obj ->
  object
    inherit progress
    val obj : Gtk.progress_bar obj
    method add_events : Gdk.Tags.event_mask list -> unit
    method set_activity_blocks : int -> unit
    method set_activity_step : int -> unit
    method set_bar_style : [`CONTINUOUS|`DISCRETE] -> unit
    method set_discrete_blocks : int -> unit
    method set_orientation : Tags.progress_bar_orientation -> unit
  end
val progress_bar :
  ?adjustment:GData.adjustment ->
  ?bar_style:[`CONTINUOUS|`DISCRETE] ->
  ?discrete_blocks:int ->
  ?activity_step:int ->
  ?activity_blocks:int ->
  ?value:float ->
  ?percentage:float ->
  ?activity_mode:bool ->
  ?show_text:bool ->
  ?format_string:string ->
  ?text_xalign:float ->
  ?text_yalign:float ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> progress_bar

class range : 'a obj ->
  object
    inherit widget_full
    constraint 'a = [>`range|`widget]
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
    method add_events : Gdk.Tags.event_mask list -> unit
  end
val scrollbar :
  Tags.orientation ->
  ?adjustment:GData.adjustment ->
  ?update_policy:Tags.update_type ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> scrollbar

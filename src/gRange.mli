(* $Id$ *)

open Gtk

class progress :
  'a[> progress widget] Gtk.obj ->
  object
    inherit GObj.widget_wrapper
    val obj : 'a Gtk.obj
    method adjustment : GData.adjustment
    method configure : current:float -> min:float -> max:float -> unit
    method current_text : string
    method percentage : float
    method set_activity_mode : bool -> unit
    method set_adjustment : GData.adjustment -> unit
    method set_format_string : string -> unit
    method set_percentage : float -> unit
    method set_show_text : bool -> unit
    method set_text_alignment : ?x:float -> ?y:float -> unit
    method set_value : float -> unit
    method value : float
  end

class progress_bar :
  ?adjustment:GData.adjustment ->
  ?bar_style:[CONTINUOUS DISCRETE] ->
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
  ?packing:(progress_bar -> unit) ->
  ?show:bool ->
  object
    inherit progress
    val obj : Gtk.progress_bar Gtk.obj
    method add_events : Gdk.Tags.event_mask list -> unit
    method set_activity_blocks : int -> unit
    method set_activity_step : int -> unit
    method set_bar_style : [CONTINUOUS DISCRETE] -> unit
    method set_discrete_blocks : int -> unit
    method set_orientation : Tags.progress_bar_orientation -> unit
  end
class progress_bar_wrapper : Gtk.progress_bar obj -> progress_bar

class range :
  'a[> range widget] obj ->
  object
    inherit GObj.widget_wrapper
    val obj : 'a obj
    method adjustment : GData.adjustment
    method set_adjustment : GData.adjustment -> unit
    method set_update_policy : Tags.update_type -> unit
  end

class scale :
  Tags.orientation ->
  ?adjustment:GData.adjustment ->
  ?digits:int ->
  ?draw_value:bool ->
  ?value_pos:Tags.position ->
  ?packing:(scale -> unit) -> ?show:bool ->
  object
    inherit range
    val obj : Gtk.scale obj
    method set_digits : int -> unit
    method set_draw_value : bool -> unit
    method set_value_pos : Tags.position -> unit
  end
class scale_wrapper : Gtk.scale obj -> scale

class scrollbar :
  Tags.orientation ->
  ?adjustment:GData.adjustment ->
  ?update_policy:Tags.update_type ->
  ?packing:(scrollbar -> unit) -> ?show:bool ->
  object
    inherit range
    val obj : Gtk.scrollbar obj
    method add_events : Gdk.Tags.event_mask list -> unit
  end
class scrollbar_wrapper : Gtk.scrollbar obj -> scrollbar

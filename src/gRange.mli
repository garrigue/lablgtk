(* $Id$ *)

open Gtk

class progress_bar :
  ?packing:(progress_bar -> unit) -> ?show:bool ->
  object
    inherit GObj.widget_wrapper
    val obj : Gtk.progress_bar obj
    method add_events : Gdk.Tags.event_mask list -> unit
    method percentage : float
    method update : float -> unit
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

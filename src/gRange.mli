(* $Id$ *)

open Gtk

class progress_bar :
  ?packing:(progress_bar -> unit) ->
  object
    inherit GObj.widget_wrapper
    val obj : ProgressBar.t obj
    method percentage : float
    method update : float -> unit
  end
class progress_bar_wrapper : ProgressBar.t obj -> progress_bar

class range :
  'a[> range widget] obj ->
  object
    inherit GObj.widget_wrapper
    val obj : 'a obj
    method adjustment : GData.adjustment_wrapper
    method set_adjustment : GData.adjustment -> unit
    method set_update_policy : Tags.update_type -> unit
  end

class scrollbar :
  Tags.orientation ->
  ?adjustment:[> adjustment] obj ->
  ?update_policy:Tags.update_type ->
  ?packing:(scrollbar -> unit) ->
  object
    inherit range
    val obj : Scrollbar.t obj
  end
class scrollbar_wrapper : Scrollbar.t obj -> scrollbar

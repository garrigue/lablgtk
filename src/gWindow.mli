(* $Id$ *)

open Gtk

class window_skel :
  'a[> container widget window] obj ->
  object
    inherit GContainer.container
    val obj : 'a obj
    method add_events : Gdk.Tags.event_mask list -> unit
    method activate_default : unit -> unit
    method activate_focus : unit -> unit
    method add_accel_group : accel_group -> unit
    method as_window : window obj
    method set_default_size : width:int -> height:int -> unit
    method set_modal : bool -> unit
    method set_allow_shrink : bool -> unit
    method set_allow_grow : bool -> unit
    method set_auto_shrink : bool -> unit
    method set_position : Tags.window_position -> unit
    method set_transient_for : #GObj.is_window -> unit
    method set_title : string -> unit
    method set_wm_name : string -> unit
    method set_wm_class : string -> unit
  end

class window :
  ?type:Tags.window_type ->
  ?title:string ->
  ?wm_name:string ->
  ?wm_class:string ->
  ?position:Tags.window_position ->
  ?allow_shrink:bool ->
  ?allow_grow:bool ->
  ?auto_shrink:bool ->
  ?modal:bool ->
  ?x:int ->
  ?y:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(window -> unit) -> ?show:bool ->
  object
    inherit window_skel
    val obj : Gtk.window obj
    method connect : ?after:bool -> GContainer.container_signals
  end
class window_wrapper : ([> window]) obj -> window

class dialog :
  ?title:string ->
  ?wm_name:string ->
  ?wm_class:string ->
  ?position:Tags.window_position ->
  ?allow_shrink:bool ->
  ?allow_grow:bool ->
  ?auto_shrink:bool ->
  ?modal:bool ->
  ?x:int ->
  ?y:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(dialog -> unit) -> ?show:bool ->
  object
    inherit window
    val obj : Gtk.dialog obj
    method action_area : GPack.box
    method vbox : GPack.box
  end
class dialog_wrapper : ([> dialog]) obj -> dialog

class color_selection_dialog :
  ?title:string ->
  ?wm_name:string ->
  ?wm_class:string ->
  ?position:Tags.window_position ->
  ?allow_shrink:bool ->
  ?allow_grow:bool ->
  ?auto_shrink:bool ->
  ?modal:bool ->
  ?x:int ->
  ?y:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(color_selection_dialog -> unit) -> ?show:bool ->
  object
    inherit window
    val obj : Gtk.color_selection_dialog obj
    method cancel_button : GButton.button
    method colorsel : GMisc.color_selection
    method help_button : GButton.button
    method ok_button : GButton.button
  end
class color_selection_dialog_wrapper :
  Gtk.color_selection_dialog obj -> color_selection_dialog

class file_selection :
  ?title:string ->
  ?filename:string ->
  ?fileop_buttons:bool ->
  ?wm_name:string ->
  ?wm_class:string ->
  ?position:Tags.window_position ->
  ?allow_shrink:bool ->
  ?allow_grow:bool ->
  ?auto_shrink:bool ->
  ?modal:bool ->
  ?x:int ->
  ?y:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(file_selection -> unit) -> ?show:bool ->
  object
    inherit window
    val obj : Gtk.file_selection obj
    method cancel_button : GButton.button
    method get_filename : string
    method help_button : GButton.button
    method ok_button : GButton.button
    method set_filename : string -> unit
    method set_fileop_buttons : bool -> unit
  end
class file_selection_wrapper : Gtk.file_selection obj -> file_selection

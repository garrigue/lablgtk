(* $Id$ *)

open Gtk

class window_skel :
  'a[> container widget window] obj ->
  object
    inherit GContainer.container
    val obj : 'a obj
    method activate_default : unit -> unit
    method activate_focus : unit -> unit
    method add_accel_group : AccelGroup.t -> unit
    method as_window : Window.t obj
    method set_default_size : width:int -> height:int -> unit
    method set_modal : bool -> unit
    method set_policy :
      ?allow_shrink:bool -> ?allow_grow:bool -> ?auto_shrink:bool -> unit
    method set_position : Tags.window_position -> unit
    method set_transient_for : #GObj.is_window -> unit
    method set_wm : ?title:string -> ?name:string -> ?class:string -> unit
    method show_all : unit -> unit
  end

class window :
  Tags.window_type ->
  ?title:string ->
  ?wmclass_name:string ->
  ?wmclass_class:string ->
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
  ?packing:(window -> unit) ->
  object
    inherit window_skel
    val obj : Window.t obj
    method connect : ?after:bool -> GContainer.container_signals
  end
class window_wrapper : ([> window]) obj -> window

class dialog :
  ?title:string ->
  ?wmclass_name:string ->
  ?wmclass_class:string ->
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
  ?packing:(dialog -> unit) ->
  object
    inherit window_wrapper
    val obj : Dialog.t obj
    method action_area : GPack.box
    method vbox : GPack.box
  end
class dialog_wrapper : ([> dialog]) obj -> dialog

class color_selection_dialog :
  title:string ->
  ?wmclass_name:string ->
  ?wmclass_class:string ->
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
  ?packing:(color_selection_dialog -> unit) ->
  object
    inherit window_wrapper
    val obj : ColorSelection.dialog obj
    method cancel_button : GButton.button
    method colorsel : GMisc.color_selection
    method help_button : GButton.button
    method ok_button : GButton.button
  end
class color_selection_dialog_wrapper :
  ColorSelection.dialog obj -> color_selection_dialog

class file_selection :
  title:string ->
  ?filename:string ->
  ?fileop_buttons:bool ->
  ?wmclass_name:string ->
  ?wmclass_class:string ->
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
  ?packing:(file_selection -> unit) ->
  object
    inherit window_wrapper
    val obj : FileSelection.t obj
    method cancel_button : GButton.button
    method get_filename : string
    method help_button : GButton.button
    method hide_fileop_buttons : unit -> unit
    method ok_button : GButton.button
    method set_filename : string -> unit
    method show_fileop_buttons : unit -> unit
  end
class file_selection_wrapper : FileSelection.t obj -> file_selection

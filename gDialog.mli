(* $Id$ *)

open Gtk
open GObj

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
    inherit GWin.window_skel
    val obj : Dialog.t obj
    method action_area : GPack.box
    method connect : ?after:bool -> GCont.container_signals
    method vbox : GPack.box
  end
class dialog_wrapper : ([> dialog]) obj -> dialog

class color_selection :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(color_selection -> unit) ->
  object
    inherit GPack.box_skel
    val obj : ColorSelection.t obj
    method connect : ?after:bool -> GCont.container_signals
    method get_color : ColorSelection.color
    method set_color :
      red:float -> green:float -> blue:float -> ?opacity:float -> unit
    method set_update_policy : Tags.update_type -> unit
    method set_opacity : bool -> unit
  end
class color_selection_wrapper : ([> colorsel] obj) -> color_selection

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
    inherit GWin.window_skel
    val obj : ColorSelection.dialog obj
    method cancel_button : GButton.button_wrapper
    method colorsel : color_selection_wrapper
    method connect : ?after:bool -> GCont.container_signals
    method help_button : GButton.button_wrapper
    method ok_button : GButton.button_wrapper
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
    inherit GWin.window_skel
    val obj : FileSelection.t obj
    method cancel_button : GButton.button_wrapper
    method connect : ?after:bool -> GCont.container_signals
    method get_filename : string
    method help_button : GButton.button_wrapper
    method hide_fileop_buttons : unit -> unit
    method ok_button : GButton.button_wrapper
    method set_filename : string -> unit
    method show_fileop_buttons : unit -> unit
  end
class file_selection_wrapper : FileSelection.t obj -> file_selection

(* $Id$ *)

open Gtk

class type is_window = object
  method as_window : Window.t obj
end

class window_skel :
  'a[> container widget window] obj ->
  object
    inherit GCont.container
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
    method set_transient_for : #is_window -> unit
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
    method connect : ?after:bool -> GCont.container_signals
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
    inherit window_skel
    val obj : Dialog.t obj
    method action_area : GBox.box
    method connect : ?after:bool -> GCont.container_signals
    method vbox : GBox.box
  end
class dialog_wrapper : ([> dialog]) obj -> dialog

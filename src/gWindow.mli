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

class scrolled_window :
  ?hscrollbar_policy:Tags.policy_type ->
  ?vscrollbar_policy:Tags.policy_type ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(scrolled_window -> unit) ->
  object
    inherit GCont.container_wrapper
    val obj : ScrolledWindow.t obj
    method add_with_viewport : #GObj.is_widget -> unit
    method hadjustment : GData.adjustment_wrapper
    method set_policy :
      ?hscrollbar:Tags.policy_type ->
      ?vscrollbar:Tags.policy_type -> unit
    method vadjustment : GData.adjustment_wrapper
  end

class event_box :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(event_box -> unit) ->
  object
    inherit GCont.container_wrapper
    val obj : EventBox.t obj
  end

class handle_box_signals :
  'a[> container handlebox widget] obj -> ?after:bool ->
  object
    inherit GCont.container_signals
    val obj : 'a obj
    method child_attached :
      callback:(Widget.t obj -> unit) -> Signal.id
    method child_detached :
      callback:(Widget.t obj -> unit) -> Signal.id
  end

class handle_box :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(handle_box -> unit) ->
  object
    inherit GCont.container
    val obj : HandleBox.t obj
    method connect : ?after:bool -> handle_box_signals
    method set_handle_position : Tags.position -> unit
    method set_shadow_type : Tags.shadow_type -> unit
    method set_snap_edge : Tags.position -> unit
  end
class handle_box_wrapper : HandleBox.t obj -> handle_box

class frame_skel :
  'a[> container frame widget] obj ->
  object
    inherit GCont.container
    val obj : 'a obj
    method set_label : ?string -> ?xalign:clampf -> ?yalign:clampf -> unit
    method set_shadow_type : Tags.shadow_type -> unit
  end

class frame :
  ?label:string ->
  ?label_xalign:clampf ->
  ?label_yalign:clampf ->
  ?shadow_type:Tags.shadow_type ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(frame -> unit) ->
  object
    inherit frame_skel
    val obj : Frame.t obj
    method connect : ?after:bool -> GCont.container_signals
  end
class frame_wrapper : ([> frame]) obj -> frame

class aspect_frame :
  ?label:string ->
  ?xalign:clampf ->
  ?yalign:clampf ->
  ?ratio:float ->
  ?obey_child:bool ->
  ?label_xalign:clampf ->
  ?label_yalign:clampf ->
  ?shadow_type:Tags.shadow_type ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(aspect_frame -> unit) ->
  object
    inherit frame_skel
    val obj : AspectFrame.t obj
    method connect : ?after:bool -> GCont.container_signals
    method set_aspect :
      ?xalign:clampf ->
      ?yalign:clampf -> ?ratio:clampf -> ?obey_child:bool -> unit
  end
class aspect_frame_wrapper : AspectFrame.t obj -> aspect_frame

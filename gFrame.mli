(* $Id$ *)

open Gtk

class scrolled_window :
  ?hscrollbar_policy:Tags.policy_type ->
  ?vscrollbar_policy:Tags.policy_type ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(scrolled_window -> unit) ->
  object
    inherit GContainer.container_wrapper
    val obj : ScrolledWindow.t obj
    method add_with_viewport : #GObj.is_widget -> unit
    method hadjustment : GData.adjustment
    method set_policy :
      ?hscrollbar:Tags.policy_type ->
      ?vscrollbar:Tags.policy_type -> unit
    method vadjustment : GData.adjustment
  end

class event_box :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(event_box -> unit) ->
  object
    inherit GContainer.container_wrapper
    val obj : EventBox.t obj
  end

class handle_box_signals :
  'a[> container handlebox widget] obj -> ?after:bool ->
  object
    inherit GContainer.container_signals
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
    inherit GContainer.container
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
    inherit GContainer.container
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
    method connect : ?after:bool -> GContainer.container_signals
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
    method connect : ?after:bool -> GContainer.container_signals
    method set_aspect :
      ?xalign:clampf ->
      ?yalign:clampf -> ?ratio:clampf -> ?obey_child:bool -> unit
  end
class aspect_frame_wrapper : AspectFrame.t obj -> aspect_frame

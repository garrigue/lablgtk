(* $Id$ *)

open Gtk

class scrolled_window :
  ?hadjustment:GData.adjustment ->
  ?vadjustment:GData.adjustment ->
  ?hpolicy:Gtk.Tags.policy_type ->
  ?vpolicy:Gtk.Tags.policy_type ->
  ?placement:Gtk.Tags.corner_type ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(scrolled_window -> unit) -> ?show:bool ->
  object
    inherit GContainer.container_wrapper
    val obj : Gtk.scrolled_window Gtk.obj
    method add_with_viewport : #GObj.is_widget -> unit
    method hadjustment : GData.adjustment_wrapper
    method set_scrolled :
      ?hadjustment:GData.adjustment ->
      ?vadjustment:GData.adjustment ->
      ?hpolicy:Gtk.Tags.policy_type ->
      ?vpolicy:Gtk.Tags.policy_type ->
      ?placement:Gtk.Tags.corner_type -> unit
    method vadjustment : GData.adjustment_wrapper
  end
class scrolled_window_wrapper : Gtk.scrolled_window obj -> scrolled_window

class event_box :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(event_box -> unit) -> ?show:bool ->
  object
    inherit GContainer.container_wrapper
    val obj : Gtk.event_box obj
    method add_events : Gdk.Tags.event_mask list -> unit
  end
class event_box_wrapper : Gtk.event_box obj -> event_box

class handle_box_signals :
  'a[> container handlebox widget] obj -> ?after:bool ->
  object
    inherit GContainer.container_signals
    val obj : 'a obj
    method child_attached :
      callback:(Gtk.widget obj -> unit) -> GtkSignal.id
    method child_detached :
      callback:(Gtk.widget obj -> unit) -> GtkSignal.id
  end

class handle_box :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(handle_box -> unit) -> ?show:bool ->
  object
    inherit GContainer.container
    val obj : Gtk.handle_box obj
    method add_events : Gdk.Tags.event_mask list -> unit
    method connect : ?after:bool -> handle_box_signals
    method set_handle_position : Tags.position -> unit
    method set_shadow_type : Tags.shadow_type -> unit
    method set_snap_edge : Tags.position -> unit
  end
class handle_box_wrapper : Gtk.handle_box obj -> handle_box

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
  ?packing:(frame -> unit) -> ?show:bool ->
  object
    inherit frame_skel
    val obj : Gtk.frame obj
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
  ?packing:(aspect_frame -> unit) -> ?show:bool ->
  object
    inherit frame_skel
    val obj : Gtk.aspect_frame obj
    method connect : ?after:bool -> GContainer.container_signals
    method set_aspect :
      ?xalign:clampf ->
      ?yalign:clampf -> ?ratio:clampf -> ?obey_child:bool -> unit
  end
class aspect_frame_wrapper : Gtk.aspect_frame obj -> aspect_frame

class viewport :
  ?hadjustment:GData.adjustment ->
  ?vadjustment:GData.adjustment ->
  ?shadow_type:Tags.shadow_type ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(viewport -> unit) -> ?show:bool ->
  object
    inherit GContainer.container_wrapper
    val obj : Gtk.viewport obj
    method hadjustment : GData.adjustment
    method set_viewport :
      ?hadjustment:GData.adjustment ->
      ?vadjustment:GData.adjustment ->
      ?shadow_type:Tags.shadow_type -> unit
    method vadjustment : GData.adjustment
  end
class viewport_wrapper : Gtk.viewport obj -> viewport

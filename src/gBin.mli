(* $Id$ *)

open Gtk
open GObj
open GContainer

class scrolled_window : Gtk.scrolled_window obj ->
  object
    inherit container_full
    val obj : Gtk.scrolled_window obj
    method add_with_viewport : widget -> unit
    method hadjustment : GData.adjustment
    method set_hadjustment : GData.adjustment -> unit
    method set_hpolicy : Tags.policy_type -> unit
    method set_placement : Tags.corner_type -> unit
    method set_vadjustment : GData.adjustment -> unit
    method set_vpolicy : Tags.policy_type -> unit
    method vadjustment : GData.adjustment
  end
val scrolled_window :
  ?hadjustment:GData.adjustment ->
  ?vadjustment:GData.adjustment ->
  ?hpolicy:Tags.policy_type ->
  ?vpolicy:Tags.policy_type ->
  ?placement:Tags.corner_type ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> scrolled_window

class event_box : Gtk.event_box obj ->
  object
    inherit container_full
    val obj : Gtk.event_box obj
    method event : event_ops
  end
val event_box :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> event_box

class handle_box_signals : 'a obj ->
  object
    inherit container_signals
    constraint 'a = [>`handlebox|`container|`widget]
    val obj : 'a obj
    method child_attached : callback:(widget -> unit) -> GtkSignal.id
    method child_detached : callback:(widget -> unit) -> GtkSignal.id
  end

class handle_box : Gtk.handle_box obj ->
  object
    inherit container
    val obj : Gtk.handle_box obj
    method event : event_ops
    method connect : handle_box_signals
    method set_handle_position : Tags.position -> unit
    method set_shadow_type : Tags.shadow_type -> unit
    method set_snap_edge : Tags.position -> unit
  end
val handle_box :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> handle_box

class frame_skel : 'a obj ->
  object
    inherit container
    constraint 'a = [>`frame|`container|`widget]
    val obj : 'a obj
    method set_label : string -> unit
    method set_label_align : ?x:clampf -> ?y:clampf -> unit -> unit
    method set_shadow_type : Tags.shadow_type -> unit
  end
class frame : Gtk.frame obj ->
  object
    inherit frame_skel
    val obj : Gtk.frame obj
    method connect : GContainer.container_signals
  end
val frame :
  ?label:string ->
  ?label_xalign:clampf ->
  ?label_yalign:clampf ->
  ?shadow_type:Tags.shadow_type ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> frame

class aspect_frame : Gtk.aspect_frame obj ->
  object
    inherit frame
    val obj : Gtk.aspect_frame obj
    method set_alignment : ?x:clampf -> ?y:clampf -> unit -> unit
    method set_obey_child : bool -> unit
    method set_ratio : clampf -> unit
  end
val aspect_frame :
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
  ?packing:(widget -> unit) -> ?show:bool -> unit -> aspect_frame

class viewport : Gtk.viewport obj ->
  object
    inherit container_full
    val obj : Gtk.viewport obj
    method event : event_ops
    method hadjustment : GData.adjustment
    method set_hadjustment : GData.adjustment -> unit
    method set_shadow_type : Gtk.Tags.shadow_type -> unit
    method set_vadjustment : GData.adjustment -> unit
    method vadjustment : GData.adjustment
  end
val viewport :
  ?hadjustment:GData.adjustment ->
  ?vadjustment:GData.adjustment ->
  ?shadow_type:Tags.shadow_type ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> viewport

class alignment : Gtk.alignment obj ->
  object
    inherit container_full
    val obj : Gtk.alignment obj
    method set_alignment : ?x:Gtk.clampf -> ?y:Gtk.clampf -> unit -> unit
    method set_scale : ?x:Gtk.clampf -> ?y:Gtk.clampf -> unit -> unit
  end
val alignment :
  ?x:Gtk.clampf ->
  ?y:Gtk.clampf ->
  ?xscale:Gtk.clampf ->
  ?yscale:Gtk.clampf ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> alignment
val alignment_cast : < as_widget : 'a obj; .. > -> alignment

class socket : Gtk.socket obj ->
  object
    inherit container_full
    val obj : Gtk.socket obj
    method steal : Gdk.xid -> unit
    method xwindow : Gdk.xid
  end

val socket :
  ?border_width:int -> ?width:int -> ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> socket

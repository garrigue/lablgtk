(* $Id$ *)

open Gtk
open GObj
open GContainer

class box_skel :
  'a obj ->
  object
    inherit container
    constraint 'a = [>`box|`container|`widget]
    val obj : 'a obj
    method pack :
      ?from:Tags.pack_type ->
      ?expand:bool -> ?fill:bool -> ?padding:int -> widget -> unit
    method reorder_child : widget -> pos:int -> unit
    method set_child_packing :
      ?from:Tags.pack_type ->
      ?expand:bool -> ?fill:bool -> ?padding:int -> widget -> unit
    method set_homogeneous : bool -> unit
    method set_spacing : int -> unit
  end
class box :
  'a obj ->
  object
    inherit box_skel
    constraint 'a = [>`box|`container|`widget]
    val obj : 'a obj
    method connect : GContainer.container_signals
  end

val box :
  Tags.orientation ->
  ?homogeneous:bool ->
  ?spacing:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int -> ?packing:(widget -> unit) -> ?show:bool -> unit -> box
val vbox :
  ?homogeneous:bool ->
  ?spacing:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int -> ?packing:(widget -> unit) -> ?show:bool -> unit -> box
val hbox :
  ?homogeneous:bool ->
  ?spacing:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int -> ?packing:(widget -> unit) -> ?show:bool -> unit -> box

class button_box :
  Gtk.button_box obj ->
  object
    inherit container_full
    val obj : Gtk.button_box obj
    method pack :
      ?from:Tags.pack_type ->
      ?expand:bool -> ?fill:bool -> ?padding:int -> widget -> unit
    method reorder_child : widget -> pos:int -> unit
    method set_child_ipadding : ?x:int -> ?y:int -> unit -> unit
    method set_child_packing :
      ?from:Tags.pack_type ->
      ?expand:bool -> ?fill:bool -> ?padding:int -> widget -> unit
    method set_child_size : ?width:int -> ?height:int -> unit -> unit
    method set_homogeneous : bool -> unit
    method set_layout : GtkPack.BBox.bbox_style -> unit
    method set_spacing : int -> unit
  end
val button_box :
  Tags.orientation ->
  ?spacing:int ->
  ?child_width:int ->
  ?child_height:int ->
  ?child_ipadx:int ->
  ?child_ipady:int ->
  ?layout:GtkPack.BBox.bbox_style ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> button_box

class table :
  Gtk.table obj ->
  object
    inherit container_full
    val obj : Gtk.table obj
    method attach :
      left:int ->
      top:int ->
      ?right:int ->
      ?bottom:int ->
      ?expand:Tags.expand_type ->
      ?fill:Tags.expand_type ->
      ?shrink:Tags.expand_type ->
      ?xpadding:int -> ?ypadding:int -> widget -> unit
    method set_col_spacing : int -> int -> unit
    method set_col_spacings : int -> unit
    method set_homogeneous : bool -> unit
    method set_row_spacing : int -> int -> unit
    method set_row_spacings : int -> unit
  end
val table :
  rows:int ->
  columns:int ->
  ?homogeneous:bool ->
  ?row_spacings:int ->
  ?col_spacings:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> table

class fixed :
  Gtk.fixed obj ->
  object
    inherit container_full
    val obj : Gtk.fixed obj
    method add_events : Gdk.Tags.event_mask list -> unit
    method move : widget -> x:int -> y:int -> unit
    method put : widget -> x:int -> y:int -> unit
  end
val fixed :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> fixed

class layout :
  Gtk.layout obj ->
  object
    inherit container_full
    val obj : Gtk.layout obj
    method add_events : Gdk.Tags.event_mask list -> unit
    method freeze : unit -> unit
    method hadjustment : GData.adjustment
    method height : int
    method move : widget -> x:int -> y:int -> unit
    method put : widget -> x:int -> y:int -> unit
    method set_hadjustment : GData.adjustment -> unit
    method set_height : int -> unit
    method set_vadjustment : GData.adjustment -> unit
    method set_width : int -> unit
    method thaw : unit -> unit
    method vadjustment : GData.adjustment
    method width : int
  end
val layout :
  ?hadjustment:GData.adjustment ->
  ?vadjustment:GData.adjustment ->
  ?layout_width:int ->
  ?layout_height:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> layout

class packer :
  Gtk.packer obj ->
  object
    inherit container_full
    val obj : Gtk.packer obj
    method pack :
      ?side:Tags.side_type ->
      ?anchor:Tags.anchor_type ->
      ?expand:bool ->
      ?fill:Tags.expand_type ->
      ?border_width:int ->
      ?pad_x:int ->
      ?pad_y:int -> ?i_pad_x:int -> ?i_pad_y:int -> widget -> unit
    method reorder_child : widget -> pos:int -> unit
    method set_child_packing :
      ?side:Tags.side_type ->
      ?anchor:Tags.anchor_type ->
      ?expand:bool ->
      ?fill:Tags.expand_type ->
      ?border_width:int ->
      ?pad_x:int ->
      ?pad_y:int -> ?i_pad_x:int -> ?i_pad_y:int -> widget -> unit
    method set_defaults :
      ?border_width:int ->
      ?pad_x:int ->
      ?pad_y:int -> ?i_pad_x:int -> ?i_pad_y:int -> unit -> unit
    method set_spacing : int -> unit
  end
val packer :
  ?spacing:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> packer

class paned :
  Gtk.paned obj ->
  object
    inherit container_full
    val obj : Gtk.paned obj
    method add1 : widget -> unit
    method add2 : widget -> unit
    method add_events : Gdk.Tags.event_mask list -> unit
    method set_gutter_size : int -> unit
    method set_handle_size : int -> unit
  end
val paned :
  Tags.orientation ->
  ?handle_size:int ->
  ?gutter_size:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> paned

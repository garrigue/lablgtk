(* $Id$ *)

open Gtk
open GObj
open GContainer

class box_skel :
  'a[> box container widget] obj ->
  object
    inherit container
    val obj : 'a obj
    method pack :
      #is_widget ->
      ?from:Tags.pack_type ->
      ?expand:bool -> ?fill:bool -> ?padding:int -> unit
    method set_child_packing :
      #is_widget ->
      ?expand:bool ->
      ?fill:bool -> ?padding:int -> ?from:Tags.pack_type -> unit
    method set_packing : ?homogeneous:bool -> ?spacing:int -> unit
  end

class box :
  Tags.orientation ->
  ?homogeneous:bool ->
  ?spacing:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(box -> unit) -> ?show:bool ->
  object
    inherit box_skel
    val obj : Gtk.box obj
    method connect : ?after:bool -> container_signals
  end
class box_wrapper : ([> box] obj) -> box

class button_box :
  Tags.orientation ->
  ?spacing:int ->
  ?child_width:int ->
  ?child_height:int ->
  ?child_ipadx:int ->
  ?child_ipady:int ->
  ?layout:Tags.button_box_style ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(button_box -> unit) -> ?show:bool ->
  object
    inherit box_skel
    val obj : Gtk.button_box obj
    method connect : ?after:bool -> container_signals
    method set_child_packing :
      #is_widget ->
      ?expand:bool ->
      ?fill:bool -> ?padding:int -> ?from:Tags.pack_type -> unit
    method set_child_size : width:int -> height:int -> unit
    method set_layout : Tags.button_box_style -> unit
    method set_spacing : int -> unit
  end
class button_box_wrapper : ([> bbox] obj) -> button_box

class table :
  rows:int ->
  columns:int ->
  ?homogeneous:bool ->
  ?row_spacings:int ->
  ?col_spacings:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(table -> unit) -> ?show:bool ->
  object
    inherit container_wrapper
    val obj : Gtk.table obj
    method attach :
      #GObj.is_widget ->
      left:int ->
      top:int ->
      ?right:int ->
      ?bottom:int ->
      ?expand:Tags.expand_type ->
      ?fill:Tags.expand_type ->
      ?shrink:Tags.expand_type -> ?xpadding:int -> ?ypadding:int -> unit
    method set_packing :
      ?row_spacings:int -> ?col_spacings:int -> ?homogeneous:bool -> unit
  end
class table_wrapper : Gtk.table obj -> table

class fixed :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(fixed -> unit) -> ?show:bool ->
  object
    inherit container_wrapper
    val obj : Gtk.fixed obj
    method add_events : Gdk.Tags.event_mask list -> unit
    method move : #GObj.is_widget -> x:int -> y:int -> unit
    method put : #GObj.is_widget -> x:int -> y:int -> unit
  end
class fixed_wrapper : Gtk.fixed obj -> fixed

class layout :
  ?hadjustment:GData.adjustment ->
  ?vadjustment:GData.adjustment ->
  ?layout_width:int ->
  ?layout_height:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(layout -> unit) -> ?show:bool ->
  object
    inherit container_wrapper
    val obj : Gtk.layout obj
    method add_events : Gdk.Tags.event_mask list -> unit
    method freeze : unit -> unit
    method hadjustment : GData.adjustment
    method height : int
    method move : #GObj.is_widget -> x:int -> y:int -> unit
    method put : #GObj.is_widget -> x:int -> y:int -> unit
    method set_layout :
      ?hadjustment:GData.adjustment ->
      ?vadjustment:GData.adjustment -> ?width:int -> ?height:int -> unit
    method thaw : unit -> unit
    method vadjustment : GData.adjustment
    method width : int
  end

class packer :
  ?spacing:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(packer -> unit) -> ?show:bool ->
  object
    inherit GContainer.container_wrapper
    val obj : Gtk.packer obj
    method pack :
      #GObj.is_widget ->
      ?side:Tags.side_type ->
      ?anchor:Tags.anchor_type ->
      ?expand:bool ->
      ?fill:Tags.expand_type ->
      ?border_width:int ->
      ?pad_x:int -> ?pad_y:int -> ?i_pad_x:int -> ?i_pad_y:int -> unit
    method reorder_child : #GObj.is_widget -> pos:int -> unit
    method set_child_packing :
      #GObj.is_widget ->
      ?side:Tags.side_type ->
      ?anchor:Tags.anchor_type ->
      ?expand:bool ->
      ?fill:Tags.expand_type ->
      ?border_width:int ->
      ?pad_x:int -> ?pad_y:int -> ?i_pad_x:int -> ?i_pad_y:int -> unit
    method set_defaults :
      ?border_width:int ->
      ?pad_x:int -> ?pad_y:int -> ?i_pad_x:int -> ?i_pad_y:int -> unit
    method set_spacing : int -> unit
  end
class packer_wrapper : Gtk.packer obj -> packer

class paned :
  Tags.orientation ->
  ?handle_size:int ->
  ?gutter_size:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(paned -> unit) -> ?show:bool ->
  object
    inherit GContainer.container_wrapper
    val obj : Gtk.paned obj
    method add1 : #GObj.is_widget -> unit
    method add2 : #GObj.is_widget -> unit
    method add_events : Gdk.Tags.event_mask list -> unit
    method set_paned : ?handle_size:int -> ?gutter_size:int -> unit
  end
class paned_wrapper : Gtk.paned obj -> paned

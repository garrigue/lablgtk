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
    method event : GObj.event_ops
    method move : #GObj.is_widget -> x:int -> y:int -> unit
    method put : #GObj.is_widget -> x:int -> y:int -> unit
  end
class fixed_wrapper : Gtk.fixed obj -> fixed

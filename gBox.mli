(* $Id$ *)

open Gtk
open GObj
open GCont

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
  ([> box] obj) ->
  object
    inherit box_skel
    val obj : Box.t obj
    method connect : ?after:bool -> container_signals
  end

class hbox :
  ?homogeneous:bool ->
  ?spacing:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(box -> unit) -> box

class vbox :
  ?homogeneous:bool ->
  ?spacing:int ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(box -> unit) -> box

class button_box :
  ([> bbox] obj) ->
  object
    inherit box_skel
    val obj : BBox.t obj
    method connect : ?after:bool -> container_signals
    method set_child_packing :
      #is_widget ->
      ?expand:bool ->
      ?fill:bool -> ?padding:int -> ?from:Tags.pack_type -> unit
    method set_child_size : width:int -> height:int -> unit
    method set_layout : BBox.bbox_style -> unit
    method set_spacing : int -> unit
  end

class hbutton_box :
  ?spacing:int ->
  ?child_width:int ->
  ?child_height:int ->
  ?child_ipadx:int ->
  ?child_ipady:int ->
  ?layout:BBox.bbox_style ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(button_box -> unit) -> button_box

class vbutton_box :
  ?spacing:int ->
  ?child_width:int ->
  ?child_height:int ->
  ?child_ipadx:int ->
  ?child_ipady:int ->
  ?layout:BBox.bbox_style ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(button_box -> unit) -> button_box

class color_selection :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(color_selection -> unit) ->
  object
    inherit box_skel
    val obj : ColorSelection.t obj
    method connect : ?after:bool -> container_signals
    method get_color : ColorSelection.color
    method set_color :
      red:float -> green:float -> blue:float -> ?opacity:float -> unit
    method set_update_policy : Tags.update_type -> unit
    method set_opacity : bool -> unit
  end

class color_selection_wrapper : ([> colorsel] obj) -> color_selection

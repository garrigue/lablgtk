(* $Id$ *)

open Gtk

class pixmap :
  #GdkObj.pixmap ->
  ?xalign:float ->
  ?yalign:float ->
  ?xpad:int ->
  ?ypad:int ->
  ?width:int -> ?height:int ->
  ?packing:(pixmap -> unit) -> ?show:bool ->
  object
    inherit GMisc.misc
    val obj : Gtk.pixmap obj
    method connect : GObj.widget_signals
    method pixmap : GdkObj.pixmap
    method set_pixmap : #GdkObj.pixmap -> unit
  end
class pixmap_wrapper : Gtk.pixmap obj -> pixmap

class pixdraw :
  parent:#GObj.widget ->
  width:int ->
  height:int -> GdkObj.pixmap

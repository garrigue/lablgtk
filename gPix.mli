(* $Id$ *)

open Gtk

class pixmap :
  Gdk.pixmap ->
  ?mask:Gdk.bitmap ->
  ?xalign:float ->
  ?yalign:float ->
  ?xpad:int ->
  ?ypad:int ->
  ?packing:(pixmap -> unit) ->
  object
    inherit GMisc.misc
    val obj : Gtk.pixmap obj
    method connect : ?after:bool -> GObj.widget_signals
    method mask : Gdk.bitmap
    method pixmap : Gdk.pixmap
    method set : ?pixmap:Gdk.pixmap -> ?mask:Gdk.bitmap -> unit
  end
class pixmap_wrapper : Gtk.pixmap obj -> pixmap

class pixdraw :
  parent:#GObj.widget ->
  width:int ->
  height:int ->
  object
    inherit [[pixmap]] GdkObj.drawing
    val mask : [bitmap] GdkObj.drawing
    method mask : [bitmap] GdkObj.drawing
    method new_pixmap : pixmap
    method raw : [pixmap] Gdk.drawable
  end
val set_pixmap : #pixmap -> #pixdraw -> unit

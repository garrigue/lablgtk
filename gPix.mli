(* $Id$ *)

open Gtk
open GObj

class pixmap : Gtk.pixmap Gtk.obj ->
  object
    inherit GMisc.misc
    val obj : Gtk.pixmap Gtk.obj
    method connect : GObj.widget_signals
    method pixmap : GdkObj.pixmap
    method set_pixmap : GdkObj.pixmap -> unit
  end
val pixmap :
  #GdkObj.pixmap ->
  ?xalign:float ->
  ?yalign:float ->
  ?xpad:int ->
  ?ypad:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(GObj.widget -> unit) -> ?show:bool -> unit -> pixmap

class pixdraw :
  window:#GObj.widget ->
  width:int -> height:int -> ?mask:bool -> unit -> GdkObj.pixmap

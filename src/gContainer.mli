(* $Id$ *)

open Gtk
open GObj

class focus :
  'a obj ->
  object
    constraint 'a = [>`container]
    val obj : 'a obj
    method circulate : Tags.direction_type -> bool
    method set : widget option -> unit
    method set_hadjustment : GData.adjustment option -> unit
    method set_vadjustment : GData.adjustment option -> unit
  end

class container :
  'a obj ->
  object
    inherit widget
    constraint 'a = [>`container|`widget]
    val obj : 'a obj
    method add : widget -> unit
    method children : widget list
    method remove : widget -> unit
    method focus : focus
    method set_border_width : int -> unit
  end

class container_signals :
  'a obj ->
  object
    inherit widget_signals
    constraint 'a = [>`container|`widget]
    val obj : 'a obj
    method add : callback:(widget -> unit) -> GtkSignal.id
    method remove : callback:(widget -> unit) -> GtkSignal.id
  end

class container_full :
  'a obj ->
  object
    inherit container
    constraint 'a = [>`container|`widget]
    val obj : 'a obj
    method connect : container_signals
  end

val cast_container : widget -> container_full
(* may raise [Gtk.Cannot_cast "GtkContainer"] *)

class socket :
  Gtk.socket obj ->
  object
    inherit container_full
    val obj : Gtk.socket obj
    method steal : Gdk.xid -> unit
    method xwindow : Gdk.xid
  end

val socket :
  ?border_width:int -> ?width:int -> ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> socket

class virtual ['a] item_container :
  'c obj ->
  object
    constraint 'a = < as_item : [>`widget] obj; .. >
    constraint 'c = [>`container|`widget]
    inherit widget
    val obj : 'c obj
    method add : 'a -> unit
    method append : 'a -> unit
    method children : 'a list
    method virtual insert : 'a -> pos:int -> unit
    method prepend : 'a -> unit
    method remove : 'a -> unit
    method focus : focus
    method set_border_width : int -> unit
    method private virtual wrap : Gtk.widget obj -> 'a
  end

class item_signals :
  'a obj ->
  object
    inherit container_signals
    constraint 'a = [>`container|`item|`widget]
    val obj : 'a obj
    method deselect : callback:(unit -> unit) -> GtkSignal.id
    method select : callback:(unit -> unit) -> GtkSignal.id
    method toggle : callback:(unit -> unit) -> GtkSignal.id
  end

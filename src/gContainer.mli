(* $Id$ *)

open Gtk
open GObj

class focus :
  'a obj ->
  object
    constraint 'a = [> `container]
    val obj : 'a obj
    (* method circulate : Tags.direction_type -> bool *)
    method set : widget option -> unit
    method set_hadjustment : GData.adjustment option -> unit
    method set_vadjustment : GData.adjustment option -> unit
  end

class container : ([> Gtk.container] as 'a) obj ->
  object
    inherit widget
    val obj : 'a obj
    method add : widget -> unit
    method children : widget list
    method remove : widget -> unit
    method focus : focus
    method set_border_width : int -> unit
    method set_resize_mode : Tags.resize_mode -> unit
    method border_width : int
    method resize_mode : Tags.resize_mode
  end

class ['a] container_impl :([> Gtk.container] as 'a) obj ->
  object
    inherit container
    inherit ['a] objvar
  end

class type container_signals =
  object
    inherit widget_signals
    method add : callback:(widget -> unit) -> GtkSignal.id
    method remove : callback:(widget -> unit) -> GtkSignal.id
  end

class container_signals_impl : ([> Gtk.container] as 'a) obj ->
  object
    inherit ['a] gobject_signals
    inherit container_signals
  end

class container_full : ([> Gtk.container] as 'a) obj ->
  object
    inherit container
    val obj : 'a obj
    method connect : container_signals
  end

val cast_container : widget -> container_full
(* may raise [Gtk.Cannot_cast "GtkContainer"] *)

val pack_container :
  create:([> Gtk.container] Gobject.param list -> (#GObj.widget as 'a)) ->
  [> Gtk.container] Gobject.param list ->
  ?border_width:int ->
  ?width:int ->
  ?height:int -> ?packing:(GObj.widget -> unit) -> ?show:bool -> unit -> 'a
  (* utility function *)

class virtual ['a] item_container : ([> Gtk.container] as 'c) obj ->
  object
    constraint 'a = < as_item : [>`widget] obj; .. >
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
    method set_resize_mode : Tags.resize_mode -> unit
    method border_width : int
    method resize_mode : Tags.resize_mode
    method private virtual wrap : Gtk.widget obj -> 'a
  end

class item_signals : [> Gtk.item] obj ->
  object
    inherit container_signals
    method deselect : callback:(unit -> unit) -> GtkSignal.id
    method select : callback:(unit -> unit) -> GtkSignal.id
    method toggle : callback:(unit -> unit) -> GtkSignal.id
  end

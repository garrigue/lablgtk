(* $Id$ *)

open Gtk
open GObj

class focus :
  'a[> container] obj ->
  object
    val obj : 'a obj
    method circulate : Tags.direction_type -> bool
    method set : ?#is_widget -> unit
    method set_hadjustment : ?GData.adjustment -> unit
    method set_vadjustment : ?GData.adjustment -> unit
  end

class container :
  'a[> container widget] obj ->
  object
    inherit widget
    val obj : 'a obj
    method add : #is_widget -> unit
    method children : widget_wrapper list
    method remove : #is_widget -> unit
    method focus : focus
    method set_border_width : int -> unit
  end

class container_signals :
  'a[> container widget] obj ->
  object
    inherit widget_signals
    val obj : 'a obj
    method add :
	callback:(widget_wrapper -> unit) -> ?after:bool -> GtkSignal.id
    method parent_set :
	callback:(widget_wrapper option -> unit) ->
	?after:bool -> GtkSignal.id
    method remove :
	callback:(widget_wrapper -> unit) -> ?after:bool -> GtkSignal.id
  end

class container_wrapper :
  'a[> container widget] obj ->
  object
    inherit container
    val obj : 'a obj
    method connect : container_signals
  end

class virtual ['a, 'b] item_container :
  'c[> container widget] obj ->
  object
    constraint 'a = [> item widget]
    inherit widget
    val obj : 'c obj
    method add : 'a #is_item -> unit
    method append : 'a #is_item -> unit
    method children : 'b list
    method virtual insert : 'a #is_item -> pos:int -> unit
    method prepend : 'a #is_item -> unit
    method remove : 'a #is_item -> unit
    method focus : focus
    method set_border_width : int -> unit
    method private virtual wrap : Gtk.widget obj -> 'b
  end

class item_signals :
  'a[> container item widget] obj ->
  object
    inherit container_signals
    val obj : 'a obj
    method deselect : callback:(unit -> unit) -> ?after:bool -> GtkSignal.id
    method select : callback:(unit -> unit) -> ?after:bool -> GtkSignal.id
    method toggle : callback:(unit -> unit) -> ?after:bool -> GtkSignal.id
  end

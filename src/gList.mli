(* $Id$ *)

open Gtk

class list_item :
  ?label:string ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(list_item -> unit) ->
  object
    inherit GContainer.container
    val obj : Gtk.list_item obj
    method as_item : Gtk.list_item obj
    method connect : ?after:bool -> GContainer.item_signals
    method deselect : unit -> unit
    method select : unit -> unit
    method toggle : unit -> unit
  end
class list_item_wrapper : Gtk.list_item obj -> list_item

class liste :
  ?selection_mode:Tags.selection_mode ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(liste -> unit) ->
  object
    inherit [Gtk.list_item,list_item] GContainer.item_container
    val obj : Gtk.liste obj
    method child_position : Gtk.list_item #GObj.is_item -> int
    method clear_items : start:int -> end:int -> unit
    method insert : Gtk.list_item #GObj.is_item -> pos:int -> unit
    method select_item : pos:int -> unit
    method unselect_item : pos:int -> unit
    method private wrap : Gtk.widget obj -> list_item
  end
class liste_wrapper : Gtk.liste obj -> liste


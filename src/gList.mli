(* $Id$ *)

open Gtk

class list_item :
  ?label:string ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(list_item -> unit) ->
  object
    inherit GCont.container
    val obj : ListItem.t obj
    method as_item : ListItem.t obj
    method connect : ?after:bool -> GCont.item_signals
    method deselect : unit -> unit
    method select : unit -> unit
    method toggle : unit -> unit
  end
class list_item_wrapper : ListItem.t obj -> list_item

class liste :
  ?selection_mode:Tags.selection_mode ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(liste -> unit) ->
  object
    inherit [ListItem.t,list_item] GCont.item_container
    val obj : GtkList.t obj
    method child_position : ListItem.t #GObj.is_item -> int
    method clear_items : start:int -> end:int -> unit
    method insert : ListItem.t #GObj.is_item -> pos:int -> unit
    method select_item : pos:int -> unit
    method unselect_item : pos:int -> unit
    method private wrap : Widget.t obj -> list_item
  end
class liste_wrapper : GtkList.t obj -> liste


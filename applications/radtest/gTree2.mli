(* $Id$ *)

open Gtk
open GObj
open GContainer

class tree_item_signals : 'a obj ->
  object
    inherit item_signals
    constraint 'a = [>`treeitem|`container|`item|`widget]
    val obj : 'a obj
    method collapse : callback:(unit -> unit) -> GtkSignal.id
    method expand : callback:(unit -> unit) -> GtkSignal.id
  end

class tree_item : Gtk.tree_item obj ->
  object
    inherit GContainer.container
    val obj : Gtk.tree_item obj
    method event : event_ops
    method as_item : Gtk.tree_item obj
    method collapse : unit -> unit
    method connect : tree_item_signals
    method expand : unit -> unit
    method remove_subtree : unit -> unit
    method set_subtree : tree -> unit
    method subtree : tree
  end

and tree_signals : 'a obj ->
  object
    inherit container_signals
    constraint 'a = [>`tree|`container|`widget]
    val obj : 'a obj
    method select_child : callback:(tree_item -> unit) -> GtkSignal.id
    method selection_changed : callback:(unit -> unit) -> GtkSignal.id
    method unselect_child : callback:(tree_item -> unit) -> GtkSignal.id
  end

and tree : Gtk.tree obj ->
  object
    inherit [tree_item] item_container
    val obj : Gtk.tree obj
    method event : event_ops
    method as_tree : Gtk.tree obj
    method child_position : tree_item -> int
    method clear_items : start:int -> stop:int -> unit
    method connect : tree_signals
    method insert : tree_item -> pos:int -> unit
    method item_up : pos:int -> unit
    method remove_items : tree_item list -> unit
    method select_item : pos:int -> unit
    method selection : tree_item list
(*    method set_selection_mode : Tags.selection_mode -> unit *)
    method set_view_lines : bool -> unit
(*    method set_view_mode : [`LINE|`ITEM] -> unit *)
    method unselect_item : pos:int -> unit
    method private wrap : Gtk.widget obj -> tree_item
  end

val tree_item :
  ?label:string ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(tree_item -> unit) -> ?show:bool -> unit -> tree_item

val tree :
  ?selection_mode:Tags.selection_mode ->
  ?view_mode:[`LINE|`ITEM] ->
  ?view_lines:bool ->
  ?border_width:int ->
  ?width:int ->
  ?height:int -> ?packing:(GObj.widget -> unit) -> ?show:bool -> unit -> tree

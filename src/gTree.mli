(* $Id$ *)

open Gtk

class tree_item_signals :
  'a[> container item treeitem widget] obj -> ?after:bool ->
  object
    inherit GContainer.item_signals
    val obj : 'a obj
    method collapse : callback:(unit -> unit) -> Signal.id
    method expand : callback:(unit -> unit) -> Signal.id
  end

class tree_item :
  ?label:string ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(tree_item -> unit) ->
  object
    inherit GContainer.container
    val obj : TreeItem.t obj
    method as_item : TreeItem.t obj
    method collapse : unit -> unit
    method connect : ?after:bool -> tree_item_signals
    method expand : unit -> unit
    method remove_subtree : unit -> unit
    method set_subtree : #GObj.is_tree -> unit
    method subtree : tree
  end

and tree_signals :
  'a[> container tree widget] obj -> ?after:bool ->
  object
    inherit GContainer.container_signals
    val obj : 'a obj
    method selection_changed : callback:(unit -> unit) -> Signal.id
    method select_child : callback:(tree_item -> unit) -> Gtk.Signal.id
    method unselect_child : callback:(tree_item -> unit) -> Gtk.Signal.id
  end

and tree :
  ?selection_mode:Tags.selection_mode ->
  ?view_mode:[ITEM LINE] ->
  ?view_lines:bool ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(tree -> unit) ->
  object
    inherit [TreeItem.t, tree_item] GContainer.item_container
    val obj : Tree.t obj
    method as_tree : Tree.t obj
    method child_position : TreeItem.t #GObj.is_item -> int
    method clear_items : start:int -> end:int -> unit
    method connect : ?after:bool -> tree_signals
    method insert : TreeItem.t #GObj.is_item -> pos:int -> unit
    method prepend : TreeItem.t #GObj.is_item -> unit
    method remove_items : tree_item list -> unit
    method select_item : pos:int -> unit
    method unselect_item : pos:int -> unit
    method selection : tree_item list
    method set_selection_mode : Gtk.Tags.selection_mode -> unit
    method set_view_lines : bool -> unit
    method set_view_mode : [ITEM LINE] -> unit
    method private wrap : Widget.t obj -> tree_item
  end

class tree_item_wrapper : ([> treeitem] obj) -> tree_item

class tree_wrapper : ([> tree] obj) -> tree

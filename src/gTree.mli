(* $Id$ *)

open Gtk

class item_signals :
  'a[> container item treeitem widget] obj -> ?after:bool ->
  object
    inherit GCont.item_signals
    val obj : 'a obj
    method collapse : callback:(unit -> unit) -> Signal.id
    method expand : callback:(unit -> unit) -> Signal.id
  end

class item :
  ?label:string ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(item -> unit) ->
  object
    inherit GCont.container
    val obj : TreeItem.t obj
    method as_item : TreeItem.t obj
    method collapse : unit -> unit
    method connect : ?after:bool -> item_signals
    method expand : unit -> unit
    method remove_subtree : unit -> unit
    method set_subtree : #GObj.is_tree -> unit
    method subtree : tree
  end

and tree_signals :
  'a[> container tree widget] obj -> ?after:bool ->
  object
    inherit GCont.container_signals
    val obj : 'a obj
    method selection_changed : callback:(unit -> unit) -> Signal.id
    method select_child : callback:(item -> unit) -> Gtk.Signal.id
    method unselect_child : callback:(item -> unit) -> Gtk.Signal.id
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
    inherit [TreeItem.t, item] GCont.item_container
    val obj : Tree.t obj
    method as_tree : Tree.t obj
    method child_position : TreeItem.t #GObj.is_item -> unit
    method clear_items : start:int -> end:int -> unit
    method connect : ?after:bool -> tree_signals
    method insert : TreeItem.t #GObj.is_item -> pos:int -> unit
    method prepend : TreeItem.t #GObj.is_item -> unit
    method select_item : pos:int -> unit
    method unselect_item : pos:int -> unit
    method private wrap : Widget.t obj -> item
  end

class item_wrapper : ([> treeitem] obj) -> item

class tree_wrapper : ([> tree] obj) -> tree

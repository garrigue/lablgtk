(* $Id$ *)

open Gtk

class tree_item_signals :
  'a[> container item treeitem widget] obj ->
  object
    inherit GContainer.item_signals
    val obj : 'a obj
    method collapse : callback:(unit -> unit) -> ?after:bool -> GtkSignal.id
    method expand : callback:(unit -> unit) -> ?after:bool -> GtkSignal.id
  end

class tree_item :
  ?label:string ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(tree_item -> unit) -> ?show:bool ->
  object
    inherit GContainer.container
    val obj : Gtk.tree_item obj
    method add_events : Gdk.Tags.event_mask list -> unit
    method as_item : Gtk.tree_item obj
    method collapse : unit -> unit
    method connect : tree_item_signals
    method expand : unit -> unit
    method remove_subtree : unit -> unit
    method set_subtree : #GObj.is_tree -> unit
    method subtree : tree
  end

and tree_signals :
  'a[> container tree widget] obj ->
  object
    inherit GContainer.container_signals
    val obj : 'a obj
    method selection_changed :
	callback:(unit -> unit) -> ?after:bool -> GtkSignal.id
    method select_child :
	callback:(tree_item -> unit) -> ?after:bool -> GtkSignal.id
    method unselect_child :
	callback:(tree_item -> unit) -> ?after:bool -> GtkSignal.id
  end

and tree :
  ?selection_mode:Tags.selection_mode ->
  ?view_mode:[ITEM LINE] ->
  ?view_lines:bool ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(tree -> unit) -> ?show:bool ->
  object
    inherit [Gtk.tree_item, tree_item] GContainer.item_container
    val obj : Gtk.tree obj
    method add_events : Gdk.Tags.event_mask list -> unit
    method as_tree : Gtk.tree obj
    method child_position : Gtk.tree_item #GObj.is_item -> int
    method clear_items : start:int -> end:int -> unit
    method connect : tree_signals
    method insert : Gtk.tree_item #GObj.is_item -> pos:int -> unit
    method remove_items : tree_item list -> unit
    method select_item : pos:int -> unit
    method unselect_item : pos:int -> unit
    method selection : tree_item list
    method set_selection_mode : Gtk.Tags.selection_mode -> unit
    method set_view_lines : bool -> unit
    method set_view_mode : [ITEM LINE] -> unit
    method private wrap : Gtk.widget obj -> tree_item
  end

class tree_item_wrapper : Gtk.tree_item obj -> tree_item

class tree_wrapper : ([> tree] obj) -> tree

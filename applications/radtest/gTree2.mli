(* $Id$ *)

open Gtk

class tree_item2_signals :
  'a[> container item treeitem widget] obj -> ?after:bool ->
  object
    inherit GContainer.item_signals
    val obj : 'a obj
    method collapse : callback:(unit -> unit) -> GtkSignal.id
    method expand : callback:(unit -> unit) -> GtkSignal.id
  end

class tree_item2 :
  ?label:string ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(tree_item2 -> unit) -> ?show:bool ->
  object
    inherit GContainer.container
    val obj : Gtk.tree_item obj
    method add_events : Gdk.Tags.event_mask list -> unit
    method as_item : Gtk.tree_item obj
    method collapse : unit -> unit
    method connect : ?after:bool -> tree_item2_signals
    method expand : unit -> unit
    method remove_subtree : unit -> unit
    method set_subtree : #GObj.is_tree -> unit
    method subtree : tree2
  end

and tree2_signals :
  'a[> container tree widget] obj -> ?after:bool ->
  object
    inherit GContainer.container_signals
    val obj : 'a obj
    method selection_changed : callback:(unit -> unit) -> GtkSignal.id
    method select_child : callback:(tree_item2 -> unit) -> GtkSignal.id
    method unselect_child : callback:(tree_item2 -> unit) -> GtkSignal.id
  end

and tree2 :
  ?view_lines:bool ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(tree2 -> unit) -> ?show:bool ->
  object
    inherit [Gtk.tree_item, tree_item2] GContainer.item_container
    val obj : Gtk.tree obj
    method add_events : Gdk.Tags.event_mask list -> unit
    method as_tree : Gtk.tree obj
    method child_position : Gtk.tree_item #GObj.is_item -> int
    method clear_items : start:int -> end:int -> unit
    method connect : ?after:bool -> tree2_signals
    method insert : Gtk.tree_item #GObj.is_item -> pos:int -> unit
    method remove_items : tree_item2 list -> unit
    method select_child : Gtk.tree_item #GObj.is_item -> unit
    method select_item : pos:int -> unit
    method unselect_child : Gtk.tree_item #GObj.is_item -> unit
    method unselect_item : pos:int -> unit
    method selection : tree_item2 list
    method children2 : tree_item2 list
(*    method set_selection_mode : Gtk.Tags.selection_mode -> unit *)
    method set_view_lines : bool -> unit
(*    method set_view_mode : [ITEM LINE] -> unit *)
    method private wrap : Gtk.widget obj -> tree_item2
    method item_up : pos:int -> unit
    method select_next_child : Gtk.tree_item #GObj.is_item -> bool -> unit
    method select_prev_child : Gtk.tree_item #GObj.is_item -> unit
  end

class tree_item2_wrapper : Gtk.tree_item obj -> tree_item2

class tree2_wrapper : ([> tree] obj) -> tree2

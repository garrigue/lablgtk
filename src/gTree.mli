(* $Id$ *)

open Gtk
open GObj
open GContainer

class tree_item_signals : 'a Gtk.obj ->
  object
    inherit item_signals
    constraint 'a = [>`treeitem|`container|`item|`widget]
    val obj : 'a Gtk.obj
    method collapse : callback:(unit -> unit) -> GtkSignal.id
    method expand : callback:(unit -> unit) -> GtkSignal.id
  end

class tree_item : Gtk.tree_item Gtk.obj ->
  object
    val obj : Gtk.tree_item Gtk.obj
    method add : GObj.widget -> unit
    method add_events : Gdk.Tags.event_mask list -> unit
    method as_item : Gtk.tree_item Gtk.obj
    method as_widget : Gtk.widget Gtk.obj
    method children : GObj.widget_full list
    method coerce : GObj.widget
    method collapse : unit -> unit
    method connect : tree_item_signals
    method destroy : unit -> unit
    method drag : GObj.widget_drag
    method expand : unit -> unit
    method focus : GContainer.focus
    method get_id : int
    method get_type : Gtk.gtk_type
    method misc : GObj.widget_misc
    method remove : GObj.widget -> unit
    method remove_subtree : unit -> unit
    method set_border_width : int -> unit
    method set_subtree : tree -> unit
    method subtree : tree
  end

and tree_signals : 'a Gtk.obj ->
  object
    inherit container_signals
    constraint 'a = [>`tree|`container|`widget]
    val obj : 'a Gtk.obj
    method select_child : callback:(tree_item -> unit) -> GtkSignal.id
    method selection_changed : callback:(unit -> unit) -> GtkSignal.id
    method unselect_child : callback:(tree_item -> unit) -> GtkSignal.id
  end

and tree : Gtk.tree Gtk.obj ->
  object
    val obj : Gtk.tree Gtk.obj
    method add : tree_item -> unit
    method add_events : Gdk.Tags.event_mask list -> unit
    method append : tree_item -> unit
    method as_tree : Gtk.tree Gtk.obj
    method as_widget : Gtk.widget Gtk.obj
    method child_position : tree_item -> int
    method children : tree_item list
    method clear_items : start:int -> end:int -> unit
    method coerce : GObj.widget
    method connect : tree_signals
    method destroy : unit -> unit
    method drag : GObj.widget_drag
    method focus : GContainer.focus
    method get_id : int
    method get_type : Gtk.gtk_type
    method insert : tree_item -> pos:int -> unit
    method misc : GObj.widget_misc
    method prepend : tree_item -> unit
    method remove : tree_item -> unit
    method remove_items : tree_item list -> unit
    method select_item : pos:int -> unit
    method selection : tree_item list
    method set_border_width : int -> unit
    method set_selection_mode : Gtk.Tags.selection_mode -> unit
    method set_view_lines : bool -> unit
    method set_view_mode : [`LINE|`ITEM] -> unit
    method unselect_item : pos:int -> unit
    method private wrap : Gtk.widget Gtk.obj -> tree_item
  end

val tree_item :
  ?label:string ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(tree_item -> unit) -> ?show:bool -> unit -> tree_item

val tree :
  ?selection_mode:Gtk.Tags.selection_mode ->
  ?view_mode:[`LINE|`ITEM] ->
  ?view_lines:bool ->
  ?border_width:int ->
  ?width:int ->
  ?height:int -> ?packing:(GObj.widget -> unit) -> ?show:bool -> unit -> tree

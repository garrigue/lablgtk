(* $Id$ *)

open Gtk
open GObj
open GContainer

class tree_item_signals : 'a obj ->
  object
    inherit item_signals
    constraint 'a = [> tree_item]
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
    method subtree : tree option
  end

and tree_signals : Gtk.tree obj ->
  object
    inherit container_signals
    val obj : Gtk.tree obj
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
    method remove_items : tree_item list -> unit
    method select_item : pos:int -> unit
    method selection : tree_item list
    method set_selection_mode : Tags.selection_mode -> unit
    method set_view_lines : bool -> unit
    method set_view_mode : [`LINE|`ITEM] -> unit
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
  ?height:int -> ?packing:(widget -> unit) -> ?show:bool -> unit -> tree


module Data :
  sig
    type kind =
      [ `BOOLEAN
      | `BOXED
      | `CHAR
      | `DOUBLE
      | `ENUM
      | `FLAGS
      | `FLOAT
      | `INT
      | `INT64
      | `LONG
      | `OBJECT
      | `POINTER
      | `STRING
      | `UCHAR
      | `UINT
      | `UINT64
      | `ULONG]
    type 'a conv = {
      kind : kind;
      proj : Gobject.data_get -> 'a;
      inj : 'a -> unit Gobject.data_set;
    } 
    val boolean : bool conv
    val char : char conv
    val uchar : char conv
    val int : int conv
    val uint : int conv
    val long : int conv
    val ulong : int conv
    val enum : int conv
    val flags : int conv
    val int64 : int64 conv
    val uint64 : int64 conv
    val float : float conv
    val double : float conv
    val string : string conv
    val string_option : string option conv
    val pointer : Gpointer.boxed option conv
    val boxed : Gpointer.boxed option conv
    val gobject : 'a Gobject.obj option conv
    val of_value : 'a conv -> Gobject.g_value -> 'a
    val to_value : 'a conv -> 'a -> Gobject.g_value
  end

type 'a column =
    {index: int; conv: 'a Data.conv; creator: int}

class column_list :
  object
    method add : 'a Data.conv -> 'a column
    method id : int
    method kinds : Data.kind list
    method lock : unit -> unit
  end

class model_signals : ([> `treemodel] as 'b) obj ->
  object ('a)
    inherit gobject_signals
    val obj : 'b obj
    method row_changed :
      callback:(tree_path -> tree_iter -> unit) -> GtkSignal.id
    method row_deleted : callback:(tree_path -> unit) -> GtkSignal.id
    method row_has_child_toggled :
      callback:(tree_path -> tree_iter -> unit) -> GtkSignal.id
    method row_inserted :
      callback:(tree_path -> tree_iter -> unit) -> GtkSignal.id
    method rows_reordered :
      callback:(tree_path -> tree_iter -> unit) -> GtkSignal.id
  end

class model : ([> `treemodel] obj as 'a) -> id:int ->
  object
    val obj : 'a
    val id : int
    method as_model : Gtk.tree_model Gtk.obj
    method coerce : model
    method connect : model_signals
    method get : row:Gtk.tree_iter -> column:'b column -> 'b
    method get_column_type : int -> Gobject.g_type
    method get_iter : Gtk.tree_path -> Gtk.tree_iter
    method get_path : Gtk.tree_iter -> Gtk.tree_path
    method iter_children : ?nth:int -> Gtk.tree_iter -> Gtk.tree_iter
    method iter_next : Gtk.tree_iter -> bool
    method iter_parent : Gtk.tree_iter -> Gtk.tree_iter
    method misc : gobject_ops
    method n_columns : int
  end

class tree_store : Gtk.tree_store -> id:int ->
  object
    inherit model
    val obj : Gtk.tree_store
    method append : ?parent:tree_iter -> unit -> tree_iter
    method clear : unit -> unit
    method insert : ?parent:tree_iter -> int -> tree_iter
    method insert_after : ?parent:tree_iter -> tree_iter -> tree_iter
    method insert_before : ?parent:tree_iter -> tree_iter -> tree_iter
    method is_ancestor : iter:tree_iter -> descendant:tree_iter -> bool
    method iter_depth : tree_iter -> int
    method iter_is_valid : tree_iter -> bool
    method move_after : iter:tree_iter -> pos:tree_iter -> bool
    method move_before : iter:tree_iter -> pos:tree_iter -> bool
    method prepend : ?parent:tree_iter -> unit -> tree_iter
    method remove : tree_iter -> bool
    method set : row:tree_iter -> column:'a column -> 'a -> unit
    method swap : tree_iter -> tree_iter -> bool
  end
val tree_store : column_list -> tree_store

class list_store : Gtk.list_store -> id:int ->
  object
    inherit model
    val obj : Gtk.list_store
    method append : unit -> tree_iter
    method clear : unit -> unit
    method insert : int -> tree_iter
    method insert_after : tree_iter -> tree_iter
    method insert_before : tree_iter -> tree_iter
    method iter_is_valid : tree_iter -> bool
    method move_after : iter:tree_iter -> pos:tree_iter -> bool
    method move_before : iter:tree_iter -> pos:tree_iter -> bool
    method prepend : unit -> tree_iter
    method remove : tree_iter -> bool
    method set : row:tree_iter -> column:'a column -> 'a -> unit
    method swap : tree_iter -> tree_iter -> bool
  end
val list_store : column_list -> list_store

class selection_signals : tree_selection ->
  object
    inherit gobject_signals
    val obj : Gtk.tree_selection
    method changed : callback:(unit -> unit) -> GtkSignal.id
  end
class selection :
  Gtk.tree_selection ->
  object
    val obj : Gtk.tree_selection
    method connect : selection_signals
    method misc : gobject_ops
    method count_selected_rows : int
    method get_mode : Gtk.Tags.selection_mode
    method get_selected_rows : Gtk.tree_path list
    method iter_is_selected : Gtk.tree_iter -> bool
    method path_is_selected : Gtk.tree_path -> bool
    method select_all : unit
    method select_iter : Gtk.tree_iter -> unit
    method select_path : Gtk.tree_path -> unit
    method select_range : Gtk.tree_path -> Gtk.tree_path -> unit
    method set_mode : Gtk.Tags.selection_mode -> unit
    method set_select_function : (Gtk.tree_path -> bool -> bool) -> unit
    method unselect_all : unit
    method unselect_iter : Gtk.tree_iter -> unit
    method unselect_path : Gtk.tree_path -> unit
    method unselect_range : Gtk.tree_path -> Gtk.tree_path -> unit
  end

class view_column_signals : ([> `gtk | `treeviewcolumn] as 'b) Gtk.obj ->
  object ('a)
    inherit gtkobj_signals
    val obj : 'b Gtk.obj
    method clicked : callback:(unit -> unit) -> GtkSignal.id
  end
class view_column : tree_view_column obj ->
  object
    inherit gtkobj
    val obj : tree_view_column obj
    method as_column : tree_view_column obj
    method connect : view_column_signals
    method misc : gobject_ops
    method add_attribute : [>`cellrenderer] obj -> string -> 'a column -> unit
    method pack :
      ?expand:bool -> ?from:[ `END | `START] -> [>`cellrenderer] obj -> unit
    method set_title : string -> unit
  end
val view_column :
  ?title:string ->
  ?renderer:([>`cellrenderer] obj * (string * 'a column) list) ->
  unit -> view_column

class view_signals : ([> tree_view] as 'b) obj ->
  object ('a)
    inherit GContainer.container_signals
    val obj : 'b obj
    method columns_changed : callback:(unit -> unit) -> GtkSignal.id
    method cursor_changed : callback:(unit -> unit) -> GtkSignal.id
    method expand_collapse_cursor_row :
      callback:(logical:bool -> expand:bool -> all:bool -> bool) ->
      GtkSignal.id
    method move_cursor :
      callback:(Gtk.Tags.movement_step -> int -> bool) -> GtkSignal.id
    method row_activated :
      callback:(tree_iter -> Gtk.tree_view_column obj -> unit) ->
      GtkSignal.id
    method row_collapsed :
      callback:(tree_iter -> tree_path -> unit) -> GtkSignal.id
    method row_expanded :
      callback:(tree_iter -> tree_path -> unit) -> GtkSignal.id
    method select_all : callback:(unit -> bool) -> GtkSignal.id
    method select_cursor_parent : callback:(unit -> bool) -> GtkSignal.id
    method select_cursor_row :
      callback:(start_editing:bool -> bool) -> GtkSignal.id
    method set_scroll_adjustments :
      callback:(Gtk.adjustment obj option ->
                Gtk.adjustment obj option -> unit) ->
      GtkSignal.id
    method start_interactive_search : callback:(unit -> bool) -> GtkSignal.id
    method test_collapse_row : callback:(unit -> bool) -> GtkSignal.id
    method test_expand_row :
      callback:(tree_iter -> tree_path -> bool) -> GtkSignal.id
    method toggle_cursor_row : callback:(unit -> bool) -> GtkSignal.id
    method unselect_all : callback:(unit -> bool) -> GtkSignal.id
  end

class view : ([> tree_view] as 'a) obj ->
  object
    inherit GContainer.container
    val obj : 'a obj
    method connect : view_signals
    method append_column : view_column -> int
    method selection : selection
  end
val view :
  ?model:#model ->
  ?border_width:int -> ?width:int -> ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> view

val cell_renderer_text : unit -> cell_renderer_text obj

(* $Id$ *)

open Gobject
open Gtk
open GObj
open GContainer

(** Tree and list widgets
   @gtkdoc gtk TreeWidget *)


(** {3 Obsolete GtkTree/GtkTreeItem framework} *)

(** @gtkdoc gtk GtkTreeItem
    @deprecated use {!GTree.view} instead *)
class tree_item_signals : tree_item obj ->
  object
    inherit GContainer.item_signals
    method collapse : callback:(unit -> unit) -> GtkSignal.id
    method expand : callback:(unit -> unit) -> GtkSignal.id
  end

(** @gtkdoc gtk GtkTreeItem
    @deprecated use {!GTree.view} instead *)
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

(** @gtkdoc gtk GtkTree 
    @deprecated use {!GTree.view} instead *)
and tree_signals : Gtk.tree obj ->
  object
    inherit GContainer.container_signals
    val obj : Gtk.tree obj
    method select_child : callback:(tree_item -> unit) -> GtkSignal.id
    method selection_changed : callback:(unit -> unit) -> GtkSignal.id
    method unselect_child : callback:(tree_item -> unit) -> GtkSignal.id
  end

(** @gtkdoc gtk GtkTree 
    @deprecated use {!GTree.view} instead *)
and tree : Gtk.tree obj ->
  object
    inherit [tree_item] GContainer.item_container
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

(** @gtkdoc gtk GtkTreeItem
    @deprecated use {!GTree.view} instead *)
val tree_item :
  ?label:string ->
  ?packing:(tree_item -> unit) -> ?show:bool -> unit -> tree_item

(** @gtkdoc gtk GtkTree 
    @deprecated use {!GTree.view} instead *)
val tree :
  ?selection_mode:Tags.selection_mode ->
  ?view_mode:[`LINE|`ITEM] ->
  ?view_lines:bool ->
  ?border_width:int ->
  ?width:int ->
  ?height:int -> ?packing:(widget -> unit) -> ?show:bool -> unit -> tree


(** {3 New GtkTreeView/Model framework} *)

type 'a column = {index: int; conv: 'a data_conv; creator: int}

class column_list :
  object
    method add : 'a data_conv -> 'a column
    method id : int
    method kinds : fundamental_type list
    method lock : unit -> unit
  end

class row_reference : Gtk.row_reference -> model:[> `treemodel ] obj ->
  object
    method as_ref : Gtk.row_reference
    method iter : tree_iter
    method path : tree_path
    method valid : bool
  end

(** {4 Models} *)

(** @gtkdoc gtk GtkTreeModel *)
class model_signals : [> `treemodel] obj ->
  object ('a)
    method after : 'a
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

val model_ids : (int,int) Hashtbl.t

(** @gtkdoc gtk GtkTreeModel *)
class model : ([> `treemodel] as 'a) obj ->
  object
    val obj : 'a obj
    val id : int
    method as_model : Gtk.tree_model
    method coerce : model
    method connect : model_signals
    method get : row:tree_iter -> column:'b column -> 'b
    method get_column_type : int -> Gobject.g_type
    method get_iter : tree_path -> tree_iter
    method get_path : tree_iter -> tree_path
    method get_row_reference : tree_path -> row_reference
    method iter_children : ?nth:int -> tree_iter -> tree_iter
    method iter_next : tree_iter -> bool
    method iter_parent : tree_iter -> tree_iter
    method misc : gobject_ops
    method n_columns : int
  end

(** @gtkdoc gtk GtkTreeStore *)
class tree_store : Gtk.tree_store ->
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

(** @gtkdoc gtk GtkTreeStore *)
val tree_store : column_list -> tree_store

(** @gtkdoc gtk GtkListStore *)
class list_store : Gtk.list_store ->
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

(** @gtkdoc gtk GtkListStore *)
val list_store : column_list -> list_store

module Path : sig
  val create : int list -> Gtk.tree_path
  val copy : Gtk.tree_path -> Gtk.tree_path
  val get_indices : Gtk.tree_path -> int array
  val from_string : string -> Gtk.tree_path
  val to_string : Gtk.tree_path -> string
  val get_depth : Gtk.tree_path -> int
  val is_ancestor : Gtk.tree_path -> Gtk.tree_path -> bool
  (* Mutating functions *)
  val append_index : Gtk.tree_path -> int -> unit
  val prepend_index : Gtk.tree_path -> int -> unit
  val next : Gtk.tree_path -> unit
  val prev : Gtk.tree_path -> unit
  val up : Gtk.tree_path -> bool
  val down : Gtk.tree_path -> unit
end

(** {4 Selection} *)

(** @gtkdoc gtk GtkTreeSelection *)
class selection_signals : tree_selection ->
  object ('a)
    method after : 'a
    method changed : callback:(unit -> unit) -> GtkSignal.id
  end

(** The selection object for {!GTree.view}
   @gtkdoc gtk GtkTreeSelection *)
class selection :
  Gtk.tree_selection ->
  object
    val obj : Gtk.tree_selection
    method connect : selection_signals
    method misc : gobject_ops
    method count_selected_rows : int
    method get_mode : Tags.selection_mode
    method get_selected_rows : tree_path list
    method iter_is_selected : tree_iter -> bool
    method path_is_selected : tree_path -> bool
    method select_all : unit -> unit
    method select_iter : tree_iter -> unit
    method select_path : tree_path -> unit
    method select_range : tree_path -> tree_path -> unit
    method set_mode : Tags.selection_mode -> unit
    method set_select_function : (tree_path -> bool -> bool) -> unit
    method unselect_all : unit -> unit
    method unselect_iter : tree_iter -> unit
    method unselect_path : tree_path -> unit
    method unselect_range : tree_path -> tree_path -> unit
  end

(** {4 Views} *)

class type cell_renderer = object
  method as_renderer : Gtk.cell_renderer obj
end

(** @gtkdoc gtk GtkTreeViewColumn *)
class view_column_signals : [> `gtk | `treeviewcolumn] obj ->
  object
    inherit GObj.gtkobj_signals
    method clicked : callback:(unit -> unit) -> GtkSignal.id
  end

(** A visible column in a {!GTree.view} widget
   @gtkdoc gtk GtkTreeViewColumn *)
class view_column : tree_view_column obj ->
  object
    inherit GObj.gtkobj
    val obj : tree_view_column obj
    method as_column : Gtk.tree_view_column obj
    method misc : GObj.gobject_ops
    method add_attribute : #cell_renderer -> string -> 'a column -> unit
    method alignment : float
    method clickable : bool
    method connect : view_column_signals
    method fixed_width : int
    method max_width : int
    method min_width : int
    method pack :
      ?expand:bool -> ?from:[ `END | `START ] -> #cell_renderer -> unit
    method reorderable : bool
    method resizable : bool
    method set_alignment : float -> unit
    method set_clickable : bool -> unit
    method set_fixed_width : int -> unit
    method set_max_width : int -> unit
    method set_min_width : int -> unit
    method set_reorderable : bool -> unit
    method set_resizable : bool -> unit
    method set_sizing : Tags.tree_view_column_sizing -> unit
    method set_sort_column_id : int -> unit
    method set_sort_indicator : bool -> unit
    method set_sort_order : Tags.sort_type -> unit
    method set_title : string -> unit
    method set_visible : bool -> unit
    method set_widget : widget option -> unit
    method sizing : Tags.tree_view_column_sizing
    method sort_indicator : bool
    method sort_order : Tags.sort_type
    method title : string
    method visible : bool
    method widget : widget option
    method width : int
  end

(** @gtkdoc gtk GtkTreeViewColumn *)
val view_column :
  ?title:string ->
  ?renderer:(#cell_renderer * (string * 'a column) list) ->
  unit -> view_column

(** @gtkdoc gtk GtkTreeView *)
class view_signals : [> tree_view] obj ->
  object ('a)
    inherit GContainer.container_signals
    method columns_changed : callback:(unit -> unit) -> GtkSignal.id
    method cursor_changed : callback:(unit -> unit) -> GtkSignal.id
    method expand_collapse_cursor_row :
      callback:(logical:bool -> expand:bool -> all:bool -> bool) ->
      GtkSignal.id
    method move_cursor :
      callback:(Tags.movement_step -> int -> bool) -> GtkSignal.id
    method row_activated :
      callback:(tree_path -> view_column -> unit) -> GtkSignal.id
    method row_collapsed :
      callback:(tree_iter -> tree_path -> unit) -> GtkSignal.id
    method row_expanded :
      callback:(tree_iter -> tree_path -> unit) -> GtkSignal.id
    method select_all : callback:(unit -> bool) -> GtkSignal.id
    method select_cursor_parent : callback:(unit -> bool) -> GtkSignal.id
    method select_cursor_row :
      callback:(start_editing:bool -> bool) -> GtkSignal.id
    method set_scroll_adjustments :
      callback:(GData.adjustment option -> GData.adjustment option -> unit) ->
      GtkSignal.id
    method start_interactive_search : callback:(unit -> bool) -> GtkSignal.id
    method test_collapse_row :
      callback:(tree_iter -> tree_path -> bool) -> GtkSignal.id
    method test_expand_row :
      callback:(tree_iter -> tree_path -> bool) -> GtkSignal.id
    method toggle_cursor_row : callback:(unit -> bool) -> GtkSignal.id
    method unselect_all : callback:(unit -> bool) -> GtkSignal.id
  end

(** A widget for displaying both trees and lists
   @gtkdoc gtk GtkTreeView *)
class view : tree_view obj ->
  object
    inherit GContainer.container
    val obj : tree_view obj
    method connect : view_signals
    method append_column : view_column -> int
    method collapse_all : unit -> unit
    method collapse_row : tree_path -> unit
    method enable_search : bool
    method event : GObj.event_ops
    method expand_all : unit -> unit
    method expand_row : ?all:bool -> tree_path -> unit
    method expander_column : view_column option
    method get_column : int -> view_column
    method get_cursor : unit -> tree_path option * tree_view_column option
    method get_path_at_pos :
      x:int -> y:int -> (tree_path * tree_view_column obj * int * int) option
    method hadjustment : GData.adjustment
    method headers_visible : bool
    method insert_column : view_column -> int -> int
    method model : model
    method move_column : view_column -> after:view_column -> int
    method remove_column : view_column -> int
    method reorderable : bool
    method row_activated : tree_path -> view_column -> unit
    method row_expanded : tree_path -> bool
    method rules_hint : bool
    method scroll_to_cell :
      ?align:float * float -> tree_path -> view_column -> unit
    method scroll_to_point : int -> int -> unit
    method search_column : int
    method selection : selection
    method set_cursor :
      ?cell:#cell_renderer ->
      ?edit:bool -> tree_path -> view_column -> unit
    method set_enable_search : bool -> unit
    method set_expander_column : view_column option -> unit
    method set_hadjustment : GData.adjustment -> unit
    method set_headers_clickable : bool -> unit
    method set_headers_visible : bool -> unit
    method set_model : model option -> unit
    method set_reorderable : bool -> unit
    method set_rules_hint : bool -> unit
    method set_search_column : int -> unit
    method set_vadjustment : GData.adjustment -> unit
    method vadjustment : GData.adjustment
  end

(** @gtkdoc gtk GtkTreeView *)
val view :
  ?model:#model ->
  ?hadjustment:GData.adjustment ->
  ?vadjustment:GData.adjustment ->
  ?enable_search:bool ->
  ?headers_clickable:bool ->
  ?headers_visible:bool ->
  ?reorderable:bool ->
  ?rules_hint:bool ->
  ?search_column:int ->
  ?border_width:int -> ?width:int -> ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> view

(** {4 Cell Renderers} *)

type cell_properties =
  [ `CELL_BACKGROUND of string
  | `CELL_BACKGROUND_GDK of Gdk.color
  | `CELL_BACKGROUND_SET of bool
  | `HEIGHT of int
  | `IS_EXPANDED of bool
  | `IS_EXPANDER of bool
  | `MODE of Tags.cell_renderer_mode
  | `VISIBLE of bool
  | `WIDTH of int
  | `XALIGN of float
  | `XPAD of int
  | `YALIGN of float
  | `YPAD of int ]
type cell_properties_pixbuf =
  [ cell_properties
  | `PIXBUF of GdkPixbuf.pixbuf
  | `PIXBUF_EXPANDER_CLOSED of GdkPixbuf.pixbuf
  | `PIXBUF_EXPANDER_OPEN of GdkPixbuf.pixbuf
  | `STOCK_DETAIL of string
  | `STOCK_ID of string
  | `STOCK_SIZE of Tags.icon_size ] 
type cell_properties_text =
  [ cell_properties
  | `BACKGROUND of string
  | `BACKGROUND_GDK of Gdk.color
  | `BACKGROUND_SET of bool
  | `EDITABLE of bool
  | `FAMILY of string
  | `FONT of string
  | `FONT_DESC of Pango.font_description
  | `FOREGROUND of string
  | `FOREGROUND_GDK of Gdk.color
  | `FOREGROUND_SET of bool
  | `MARKUP of string
  | `RISE of int
  | `SCALE of Pango.Tags.scale
  | `SIZE of int
  | `SIZE_POINTS of float
  | `STRETCH of Pango.Tags.stretch
  | `STRIKETHROUGH of bool
  | `STYLE of Pango.Tags.style
  | `TEXT of string
  | `UNDERLINE of Pango.Tags.underline
  | `VARIANT of Pango.Tags.variant
  | `WEIGHT of Pango.Tags.weight ]
type cell_properties_toggle =
  [ cell_properties
  | `ACTIVATABLE of bool
  | `ACTIVE of bool
  | `INCONSISTENT of bool
  | `RADIO of bool ]

(** @gtkdoc gtk GtkCellRenderer *)
class type ['a, 'b] cell_renderer_skel =
  object
    inherit GObj.gtkobj
    val obj : 'a obj
    method as_renderer : Gtk.cell_renderer obj
    method get_property : ('a, 'c) property -> 'c
    method set_properties : 'b list -> unit
  end

(** @gtkdoc gtk GtkCellRenderer *)
class virtual ['a, 'b] cell_renderer_impl : ([>Gtk.cell_renderer] as 'a) obj ->
  object
    inherit ['a,'b] cell_renderer_skel
    method private virtual param : 'b -> 'a param
  end

(** @gtkdoc gtk GtkCellRendererPixbuf *)
class cell_renderer_pixbuf : Gtk.cell_renderer_pixbuf obj ->
  object
    inherit[Gtk.cell_renderer_pixbuf,cell_properties_pixbuf] cell_renderer_skel
    method connect : GObj.gtkobj_signals_impl
  end

(** @gtkdoc gtk GtkCellRendererText *)
class cell_renderer_text_signals : Gtk.cell_renderer_text obj ->
  object
    inherit GObj.gtkobj_signals
    method edited : callback:(Gtk.tree_path -> string -> unit) -> GtkSignal.id
  end

(** @gtkdoc gtk GtkCellRendererText *)
class cell_renderer_text : Gtk.cell_renderer_text obj ->
  object
    inherit [Gtk.cell_renderer_text,cell_properties_text] cell_renderer_skel
    method connect : cell_renderer_text_signals
    method set_fixed_height_from_font : int -> unit
  end

(** @gtkdoc gtk GtkCellRendererToggle *)
class cell_renderer_toggle_signals :  Gtk.cell_renderer_toggle obj ->
  object
    inherit GObj.gtkobj_signals
    method toggled : callback:(Gtk.tree_path -> unit) -> GtkSignal.id
  end

(** @gtkdoc gtk GtkCellRendererToggle *)
class cell_renderer_toggle : Gtk.cell_renderer_toggle obj ->
  object
    inherit[Gtk.cell_renderer_toggle,cell_properties_toggle] cell_renderer_skel
    method connect : cell_renderer_toggle_signals
  end

(** @gtkdoc gtk GtkCellRendererPixbuf *)
val cell_renderer_pixbuf : cell_properties_pixbuf list -> cell_renderer_pixbuf

(** @gtkdoc gtk GtkCellRendererText *)
val cell_renderer_text : cell_properties_text list -> cell_renderer_text

(** @gtkdoc gtk GtkCellRendererToggle *)
val cell_renderer_toggle : cell_properties_toggle list -> cell_renderer_toggle

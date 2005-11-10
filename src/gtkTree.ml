(* $Id$ *)

open Gaux
open Gtk
open Tags
open GtkTreeProps
open GtkBase

external _gtktree_init : unit -> unit = "ml_gtktree_init"
let () = _gtktree_init ()

module TreePath = struct
  external create_ : unit -> tree_path = "ml_gtk_tree_path_new"
  external from_string : string -> tree_path
    = "ml_gtk_tree_path_new_from_string"
  external to_string : tree_path -> string = "ml_gtk_tree_path_to_string"
  external append_index : tree_path -> int -> unit
    = "ml_gtk_tree_path_append_index"
  let create l =
    let p = create_ () in List.iter (append_index p) l; p
  external prepend_index : tree_path -> int -> unit
    = "ml_gtk_tree_path_prepend_index"
  external get_depth : tree_path -> int
    = "ml_gtk_tree_path_get_depth"
  external get_indices : tree_path -> int array
    = "ml_gtk_tree_path_get_indices"
  external copy : tree_path -> tree_path = "ml_gtk_tree_path_copy"
  external next : tree_path -> unit = "ml_gtk_tree_path_next"
  external prev : tree_path -> bool = "ml_gtk_tree_path_prev"
  external up : tree_path -> bool = "ml_gtk_tree_path_up"
  external down : tree_path -> unit = "ml_gtk_tree_path_down"
  external is_ancestor : tree_path -> tree_path -> bool
    = "ml_gtk_tree_path_is_ancestor"
  open Gobject
  open Data
  let () =
    Internal.tree_path_string :=
      {kind=`STRING; inj=(fun x -> string.inj (to_string x));
       proj=(fun x -> from_string (string.proj x))}
end

module RowReference = struct
  external create : [>`treemodel] obj -> tree_path -> row_reference
    = "ml_gtk_tree_row_reference_new"
  external get_path : row_reference -> tree_path
    = "ml_gtk_tree_row_reference_get_path"
  external valid : row_reference -> bool
    = "ml_gtk_tree_row_reference_valid"
end

module TreeModel = struct
  let cast w : tree_model obj = Object.try_cast w "GtkTreeModel"
  external get_flags : [>`treemodel] obj -> GtkEnums.tree_model_flags list
    = "ml_gtk_tree_model_get_flags"
  external get_n_columns : [>`treemodel] obj -> int
    = "ml_gtk_tree_model_get_n_columns"
  external get_column_type : [>`treemodel] obj -> int -> Gobject.g_type
    = "ml_gtk_tree_model_get_column_type"
  external alloc_iter : unit -> tree_iter = "ml_alloc_GtkTreeIter"
  external copy_iter : tree_iter -> tree_iter = "ml_gtk_tree_iter_copy"
  external get_iter : [>`treemodel] obj -> tree_iter -> tree_path -> bool
    = "ml_gtk_tree_model_get_iter"
  let get_iter m p =
    let i = alloc_iter () in
    if get_iter m i p then i else failwith "GtkTree.TreeModel.get_iter"
  external get_path : [>`treemodel] obj -> tree_iter -> tree_path
    = "ml_gtk_tree_model_get_path"
  external get_value :
    [>`treemodel] obj -> row:tree_iter -> column:int -> Gobject.g_value -> unit
    = "ml_gtk_tree_model_get_value"
  external _get_iter_first : [>`treemodel] obj -> tree_iter -> bool
    = "ml_gtk_tree_model_get_iter_first"
  let get_iter_first m =
    let i = alloc_iter () in
    if _get_iter_first m i then Some i else None
  external iter_next : [>`treemodel] obj -> tree_iter -> bool
    = "ml_gtk_tree_model_iter_next"
  external iter_has_child : [>`treemodel] obj -> tree_iter -> bool
    = "ml_gtk_tree_model_iter_has_child"
  external iter_n_children : [>`treemodel] obj -> tree_iter option -> int
    = "ml_gtk_tree_model_iter_n_children"
  external iter_nth_child : [>`treemodel] obj -> tree_iter -> parent:tree_iter option -> int -> bool
    = "ml_gtk_tree_model_iter_nth_child"
  let iter_children m ?(nth=0) p =
    let i = alloc_iter () in
    if iter_nth_child m i p nth then i
    else invalid_arg "GtkTree.TreeModel.iter_children"
  external iter_parent :
    [>`treemodel] obj -> tree_iter -> child:tree_iter -> bool
    = "ml_gtk_tree_model_iter_parent"
  let iter_parent m child =
    let i = alloc_iter () in
    if iter_parent m i ~child then Some i else None
  external foreach : [>`treemodel] obj -> (tree_path -> tree_iter -> bool) -> unit
    = "ml_gtk_tree_model_foreach"
  external row_changed : [>`treemodel] obj -> tree_path -> tree_iter -> unit
    = "ml_gtk_tree_model_row_changed"
end

module TreeStore = struct
  open TreeModel
  let cast w : tree_store = Object.try_cast w "GtkTreeStore"
  external create : Gobject.g_type array -> tree_store
    = "ml_gtk_tree_store_newv"
  external set_value :
    tree_store -> row:tree_iter -> column:int -> Gobject.g_value -> unit
    = "ml_gtk_tree_store_set_value"
  external remove : tree_store -> tree_iter -> bool
    = "ml_gtk_tree_store_remove"
  external insert :
    tree_store -> iter:tree_iter -> ?parent:tree_iter -> int -> unit
    = "ml_gtk_tree_store_insert"
  let insert st ?parent pos =
    let iter = alloc_iter () in insert st ~iter ?parent pos; iter
  external insert_before :
    tree_store -> iter:tree_iter -> ?parent:tree_iter -> tree_iter -> unit
    = "ml_gtk_tree_store_insert_before"
  let insert_before st ?parent pos =
    let iter = alloc_iter () in insert_before st ~iter ?parent pos; iter
  external insert_after :
    tree_store -> iter:tree_iter -> ?parent:tree_iter -> tree_iter -> unit
    = "ml_gtk_tree_store_insert_after"
  let insert_after st ?parent pos =
    let iter = alloc_iter () in insert_after st ~iter ?parent pos; iter
  external append : tree_store -> iter:tree_iter -> ?parent:tree_iter -> unit
    = "ml_gtk_tree_store_append"
  let append st ?parent () =
    let iter = alloc_iter () in append st ~iter ?parent; iter
  external prepend : tree_store -> iter:tree_iter -> ?parent:tree_iter -> unit
    = "ml_gtk_tree_store_prepend"
  let prepend st ?parent () =
    let iter = alloc_iter () in prepend st ~iter ?parent; iter
  external is_ancestor :
    tree_store -> iter:tree_iter -> descendant:tree_iter -> bool
    = "ml_gtk_tree_store_is_ancestor"
  external iter_depth : tree_store -> tree_iter -> int
    = "ml_gtk_tree_store_iter_depth"
  external clear : tree_store -> unit
    = "ml_gtk_tree_store_clear"
  external iter_is_valid : tree_store -> tree_iter -> bool
    = "ml_gtk_tree_store_iter_is_valid"
  external swap : tree_store -> tree_iter -> tree_iter -> bool
    = "ml_gtk_tree_store_swap"
  external move_before : tree_store -> iter:tree_iter -> pos:tree_iter -> bool
    = "ml_gtk_tree_store_move_before"
  external move_after : tree_store -> iter:tree_iter -> pos:tree_iter -> bool
    = "ml_gtk_tree_store_move_after"
end

module ListStore = struct
  open TreeModel
  let cast w : list_store = Object.try_cast w "GtkListStore"
  external create : Gobject.g_type array -> list_store
    = "ml_gtk_list_store_newv"
  external set_value :
    list_store -> row:tree_iter -> column:int -> Gobject.g_value -> unit
    = "ml_gtk_list_store_set_value"
  external remove : list_store -> tree_iter -> bool
    = "ml_gtk_list_store_remove"
  external insert : list_store -> iter:tree_iter -> int -> unit
    = "ml_gtk_list_store_insert"
  let insert st pos =
    let iter = alloc_iter () in insert st ~iter pos; iter
  external insert_before : list_store -> iter:tree_iter -> tree_iter -> unit
    = "ml_gtk_list_store_insert_before"
  let insert_before st pos =
    let iter = alloc_iter () in insert_before st ~iter pos; iter
  external insert_after : list_store -> iter:tree_iter -> tree_iter -> unit
    = "ml_gtk_list_store_insert_after"
  let insert_after st pos =
    let iter = alloc_iter () in insert_after st ~iter pos; iter
  external append : list_store -> iter:tree_iter -> unit
    = "ml_gtk_list_store_append"
  let append st () =
    let iter = alloc_iter () in append st ~iter; iter
  external prepend : list_store -> iter:tree_iter -> unit
    = "ml_gtk_list_store_prepend"
  let prepend st () =
    let iter = alloc_iter () in prepend st ~iter; iter
  external clear : list_store -> unit
    = "ml_gtk_list_store_clear"
  external iter_is_valid : list_store -> tree_iter -> bool
    = "ml_gtk_list_store_iter_is_valid"
  external swap : list_store -> tree_iter -> tree_iter -> bool
    = "ml_gtk_list_store_swap"
  external move_before : list_store -> iter:tree_iter -> pos:tree_iter -> bool
    = "ml_gtk_list_store_move_before"
  external move_after : list_store -> iter:tree_iter -> pos:tree_iter -> bool
    = "ml_gtk_list_store_move_after"
end

module TreeSelection = struct
  include TreeSelection
  external set_mode : tree_selection -> selection_mode -> unit
    = "ml_gtk_tree_selection_set_mode"
  external get_mode : tree_selection -> selection_mode
    = "ml_gtk_tree_selection_get_mode"
  external set_select_function :
    tree_selection -> (tree_path -> bool -> bool) -> unit
    = "ml_gtk_tree_selection_set_select_function"
  external selected_foreach : tree_selection -> (tree_path -> unit) -> unit
    = "ml_gtk_tree_selection_selected_foreach"
  let get_selected_rows s =
    let l = ref [] in selected_foreach s (fun p -> l := p :: !l);
    List.rev !l
  external count_selected_rows : tree_selection -> int
    = "ml_gtk_tree_selection_count_selected_rows"
  external select_path : tree_selection -> tree_path -> unit
    = "ml_gtk_tree_selection_select_path"
  external path_is_selected : tree_selection -> tree_path -> bool
    = "ml_gtk_tree_selection_path_is_selected"
  external unselect_path : tree_selection -> tree_path -> unit
    = "ml_gtk_tree_selection_unselect_path"
  external select_iter : tree_selection -> tree_iter -> unit
    = "ml_gtk_tree_selection_select_iter"
  external unselect_iter : tree_selection -> tree_iter -> unit
    = "ml_gtk_tree_selection_unselect_iter"
  external iter_is_selected : tree_selection -> tree_iter -> bool
    = "ml_gtk_tree_selection_iter_is_selected"
  external select_all : tree_selection -> unit
    = "ml_gtk_tree_selection_select_all"
  external unselect_all : tree_selection -> unit
    = "ml_gtk_tree_selection_unselect_all"
  external select_range : tree_selection -> tree_path -> tree_path -> unit
    = "ml_gtk_tree_selection_select_range"
  external unselect_range : tree_selection -> tree_path -> tree_path -> unit
    = "ml_gtk_tree_selection_unselect_range"
end

module TreeViewColumn = struct
  include TreeViewColumn
  external clear : 
    [>`treeviewcolumn] obj -> unit
    = "ml_gtk_tree_view_column_clear"
  external pack_start :
    [>`treeviewcolumn] obj -> [>`cellrenderer] obj -> bool -> unit
    = "ml_gtk_tree_view_column_pack_start"
  external pack_end :
    [>`treeviewcolumn] obj -> [>`cellrenderer] obj -> bool -> unit
    = "ml_gtk_tree_view_column_pack_end"
  external clear_attributes : 
    [>`treeviewcolumn] obj -> [>`cellrenderer] obj -> unit
    = "ml_gtk_tree_view_column_clear_attributes"
  let pack obj ?(expand=true) ?(from:[`START|`END]=`START) crr =
    (if from = `START then pack_start else pack_end)
      obj crr expand
  external add_attribute :
    [>`treeviewcolumn] obj -> [>`cellrenderer] obj -> string -> int -> unit
    = "ml_gtk_tree_view_column_add_attribute"
  external set_sort_column_id : [>`treeviewcolumn] obj -> int -> unit	
    = "ml_gtk_tree_view_column_set_sort_column_id"      
  external get_sort_column_id : [>`treeviewcolumn] obj -> int
    = "ml_gtk_tree_view_column_get_sort_column_id"
  external set_cell_data_func : 
    [>`treeviewcolumn] obj -> [>`cellrenderer] obj -> 
    ([`treemodel] obj -> tree_iter -> unit) option -> unit = "ml_gtk_tree_view_column_set_cell_data_func"
end

module TreeView = struct
  include TreeView
  external get_selection : [>`treeview] obj -> tree_selection
    = "ml_gtk_tree_view_get_selection"
  external columns_autosize : [>`treeview] obj -> unit
    = "ml_gtk_tree_view_columns_autosize"
  external append_column : [>`treeview] obj -> [>`treeviewcolumn] obj -> int
    = "ml_gtk_tree_view_append_column"
  external remove_column : [>`treeview] obj -> [>`treeviewcolumn] obj -> int
    = "ml_gtk_tree_view_remove_column"
  external insert_column :
    [>`treeview] obj -> [>`treeviewcolumn] obj -> int -> int
    = "ml_gtk_tree_view_insert_column"
  external get_column : [>`treeview] obj -> int -> tree_view_column obj
    = "ml_gtk_tree_view_get_column"
  external move_column_after :
    [>`treeview] obj -> [>`treeviewcolumn] obj -> [>`treeviewcolumn] obj -> int
    = "ml_gtk_tree_view_move_column_after"
  external scroll_to_point : [>`treeview] obj -> int -> int -> unit
    = "ml_gtk_tree_view_scroll_to_point"
  external scroll_to_cell :
    [>`treeview] obj -> tree_path -> [>`treeviewcolumn] obj ->
    ?align:(float * float) -> unit
    = "ml_gtk_tree_view_scroll_to_cell"
  let scroll_to_cell v ?align = scroll_to_cell v ?align
  external row_activated :
    [>`treeview] obj -> tree_path -> [>`treeviewcolumn] obj -> unit
    = "ml_gtk_tree_view_row_activated"
  external expand_all : [>`treeview] obj -> unit
    = "ml_gtk_tree_view_expand_all"
  external collapse_all : [>`treeview] obj -> unit
    = "ml_gtk_tree_view_collapse_all"
  external expand_row :
    [>`treeview] obj -> tree_path -> all:bool -> unit
    = "ml_gtk_tree_view_expand_row"
  external expand_to_path :
    [>`treeview] obj -> tree_path -> unit
    = "ml_gtk_tree_view_expand_to_path"
  external collapse_row : [>`treeview] obj -> tree_path -> unit
    = "ml_gtk_tree_view_collapse_row"
  external row_expanded : [>`treeview] obj -> tree_path -> bool
    = "ml_gtk_tree_view_row_expanded"
  external set_cursor :
    [>`treeview] obj ->
    tree_path -> [>`treeviewcolumn] obj -> edit:bool -> unit
    = "ml_gtk_tree_view_set_cursor"
  external set_cursor_on_cell :
    [>`treeview] obj -> tree_path ->
    [>`treeviewcolumn] obj -> [>`cellrenderer] obj -> edit:bool -> unit
    = "ml_gtk_tree_view_set_cursor_on_cell"
  external get_cursor :
    [>`treeview] obj -> tree_path option * tree_view_column obj option
    = "ml_gtk_tree_view_get_cursor"
  external get_path_at_pos :
    [>`treeview] obj -> x:int -> y:int ->
    (tree_path * tree_view_column obj * int * int) option
    = "ml_gtk_tree_view_get_path_at_pos"
  external set_row_separator_func :
    [>`treeview] obj ->
    (Gtk.tree_model -> Gtk.tree_iter -> bool) option -> unit
    = "ml_gtk_tree_view_set_row_separator_func"
end

module CellRenderer = CellRenderer

module CellRendererPixbuf = CellRendererPixbuf

module CellRendererText = CellRendererText

module CellRendererToggle = CellRendererToggle

module CellRendererProgress = CellRendererProgress

module CellRendererCombo = CellRendererCombo

module CellLayout = struct
  include GtkTreeProps.CellLayout
  let pack layout 
    ?(expand=false) ?from:( dir = (`START : pack_type)) renderer =
    (match dir with `START -> pack_start | `END -> pack_end)
      layout renderer ~expand
end

module TreeModelSort = TreeModelSort

module TreeSortable = TreeSortable

module TreeModelFilter = TreeModelFilter

module IconView = IconView

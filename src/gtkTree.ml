(* $Id$ *)

open Gaux
open Gtk
open Tags
open GtkBase

module TreeItem = struct
  let cast w : tree_item obj = Object.try_cast w "GtkTreeItem"
  external create : unit -> tree_item obj = "ml_gtk_tree_item_new"
  external create_with_label : string -> tree_item obj
      = "ml_gtk_tree_item_new_with_label"
  let create ?label () =
    match label with None -> create ()
    | Some label -> create_with_label label
  external set_subtree : [>`treeitem] obj -> [>`widget] obj -> unit
      = "ml_gtk_tree_item_set_subtree"
  external remove_subtree : [>`treeitem] obj -> unit
      = "ml_gtk_tree_item_remove_subtree"
  external expand : [>`treeitem] obj -> unit
      = "ml_gtk_tree_item_expand"
  external collapse : [>`treeitem] obj -> unit
      = "ml_gtk_tree_item_collapse"
  external subtree : [>`treeitem] obj -> tree obj
      = "ml_GTK_TREE_ITEM_SUBTREE"
  module Signals = struct
    open GtkSignal
    let expand =
      { name = "expand"; classe = `treeitem; marshaller = marshal_unit }
    let collapse =
      { name = "collapse"; classe = `treeitem; marshaller = marshal_unit }
  end
end

module Tree = struct
  let cast w : tree obj = Object.try_cast w "GtkTree"
  external create : unit -> tree obj = "ml_gtk_tree_new"
  external insert : [>`tree] obj -> [>`treeitem] obj -> pos:int -> unit
      = "ml_gtk_tree_insert"
  external remove_items : [>`tree] obj -> [>`treeitem] obj list -> unit
      = "ml_gtk_tree_remove_items"
  external clear_items : [>`tree] obj -> start:int -> stop:int -> unit
      = "ml_gtk_tree_clear_items"
  external select_item : [>`tree] obj -> pos:int -> unit
      = "ml_gtk_tree_select_item"
  external unselect_item : [>`tree] obj -> pos:int -> unit
      = "ml_gtk_tree_unselect_item"
  external child_position : [>`tree] obj -> [>`treeitem] obj -> int
      = "ml_gtk_tree_child_position"
  external set_selection_mode : [>`tree] obj -> selection_mode -> unit
      = "ml_gtk_tree_set_selection_mode"
  external set_view_mode : [>`tree] obj -> [`LINE|`ITEM] -> unit
      = "ml_gtk_tree_set_view_mode"
  external set_view_lines : [>`tree] obj -> bool -> unit
      = "ml_gtk_tree_set_view_lines"
  external selection : [>`tree] obj -> tree_item obj list =
    "ml_gtk_tree_selection"
  let set ?selection_mode ?view_mode ?view_lines w =
    let may_set f = may ~f:(f w) in
    may_set set_selection_mode selection_mode;
    may_set set_view_mode view_mode;
    may_set set_view_lines view_lines
  module Signals = struct
    open GtkSignal
    let selection_changed =
      { name = "selection_changed"; classe = `tree; marshaller = marshal_unit }
    let select_child =
      { name = "select_child"; classe = `tree;
        marshaller = Widget.Signals.marshal }
    let unselect_child =
      { name = "unselect_child"; classe = `tree;
        marshaller = Widget.Signals.marshal }
  end
end

module TreePath = struct
  external create_ : unit -> tree_path = "ml_gtk_tree_path_new"
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
  external prev : tree_path -> unit = "ml_gtk_tree_path_prev"
  external up : tree_path -> bool = "ml_gtk_tree_path_up"
  external down : tree_path -> unit = "ml_gtk_tree_path_down"
  external is_ancestor : tree_path -> tree_path -> bool
    = "ml_gtk_tree_path_is_ancestor"
end

module RowReference = struct
  external create : tree_model obj -> tree_path -> row_reference
    = "ml_gtk_tree_row_reference_new"
  external get_path : row_reference -> tree_path
    = "ml_gtk_tree_row_reference_get_path"
  external valid : row_reference -> bool
    = "ml_gtk_tree_row_reference_valid"
end

module TreeModel = struct
  let cast w : tree_model obj = Object.try_cast w "GtkTreeModel"
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
  external iter_next : [>`treemodel] obj -> tree_iter -> bool
    = "ml_gtk_tree_model_iter_next"
  external iter_children :
    [>`treemodel] obj -> tree_iter -> parent:tree_iter -> bool
    = "ml_gtk_tree_model_iter_children"
  let iter_children m parent =
    let i = alloc_iter () in
    if iter_children m i ~parent then i
    else failwith "GtkTree.TreeModel.iter_children"
  external iter_n_children : [>`treemodel] obj -> tree_iter -> int
    = "ml_gtk_tree_model_iter_n_children"
  let iter_nth_child m p n =
    if n < 0 || n >= iter_n_children m p then
      failwith "GtkTree.TreeModel.iter_nth_child";
    let it = iter_children m p in
    for i = 1 to n do iter_next m it done;
    it
  external iter_parent :
    [>`treemodel] obj -> tree_iter -> child:tree_iter -> bool
    = "ml_gtk_tree_model_iter_children"
  let iter_parent m child =
    let i = alloc_iter () in
    if iter_parent m i ~child then i
    else failwith "GtkTree.TreeModel.iter_parent"
  module Signals = struct
    open GtkSignal
    external extract_iter : Gpointer.boxed -> tree_iter
      = "ml_gtk_tree_iter_copy"
    external extract_path : Gpointer.boxed -> tree_path
      = "ml_gtk_tree_path_copy"
    let marshal_path_iter f _ = function
      | `POINTER(Some p) :: `POINTER(Some i) :: _ ->
          f (extract_path p) (extract_iter i)
      |	_ -> invalid_arg "GtkTree.TreeModel.Signals.marshal_path_iter"
    let marshal_path f _ = function
      | `POINTER(Some p) :: _ -> f (extract_path p)
      |	_ -> invalid_arg "GtkTree.TreeModel.Signals.marshal_path"
    let row_changed =
      { name = "row-changed"; classe = `treemodel;
        marshaller = marshal_path_iter }
    let row_inserted =
      { name = "row-inserted"; classe = `treemodel;
        marshaller = marshal_path_iter }
    let row_has_child_toggled =
      { name = "row-has-child-toggled"; classe = `treemodel;
        marshaller = marshal_path_iter }
    let row_deleted =
      { name = "row-deleted"; classe = `treemodel;
        marshaller = marshal_path }
    let rows_reordered =
      { name = "rows-reordered"; classe = `treemodel;
        marshaller = marshal_path_iter }
  end
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
  let cast w : tree_selection = Object.try_cast w "GtkTreeSelection"
  external set_mode : tree_selection -> selection_mode -> unit
    = "ml_gtk_tree_selection_set_mode"
  external get_mode : tree_selection -> selection_mode
    = "ml_gtk_tree_selection_get_mode"
  external set_select_function :
    tree_selection -> (tree_path -> bool -> bool) -> unit
    = "ml_gtk_tree_selection_set_select_function"
  external get_selected_rows : tree_selection -> tree_path list
    = "ml_gtk_tree_selection_get_selected_rows"
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
  module Signals = struct
    open GtkSignal
    let changed = { name = "changed"; classe = `treeselection;
                    marshaller = marshal_unit }
  end
end

module TreeView = struct
  let cast w : tree_view obj = Object.try_cast w "GtkTreeView"
  external create : unit -> tree_view obj = "ml_gtk_tree_view_new"
  external create_with_model : tree_model obj -> tree_view obj
    = "ml_gtk_tree_view_new_with_model"
  let create ?model () =
    match model with None -> create ()
    | Some model -> create_with_model model
  external append_column : [>`treeview] obj -> [>`treeviewcolumn] obj -> int
    = "ml_gtk_tree_view_append_column"
  external get_selection : [>`treeview] obj -> tree_selection
    = "ml_gtk_tree_view_get_selection"
end

module TreeViewColumn = struct
  let cast w : tree_view_column obj = Object.try_cast w "GtkTreeViewColumn"
  external create : unit -> tree_view_column obj
    = "ml_gtk_tree_view_column_new"
  external pack_start :
    [>`treeviewcolumn] obj -> [>`cellrenderer] obj -> bool -> unit
    = "ml_gtk_tree_view_column_pack_start"
  external pack_end :
    [>`treeviewcolumn] obj -> [>`cellrenderer] obj -> bool -> unit
    = "ml_gtk_tree_view_column_pack_end"
  let pack obj ?(expand=true) ?(from:[`START|`END]=`START) crr =
    (if from = `START then pack_start else pack_end)
      obj crr expand
  external add_attribute :
    [>`treeviewcolumn] obj -> [>`cellrenderer] obj -> string -> int -> unit
    = "ml_gtk_tree_view_column_add_attribute"
  external set_title : [>`treeviewcolumn] obj -> string -> unit
    = "ml_gtk_tree_view_column_set_title"
end

module CellRenderer = struct
  let cast w : cell_renderer obj = Object.try_cast w "GtkCellRenderer"
end

module CellRendererText = struct
  let cast w : cell_renderer_text obj = Object.try_cast w "GtkCellRendererText"
  external create : unit -> cell_renderer_text obj
    = "ml_gtk_cell_renderer_text_new"
end

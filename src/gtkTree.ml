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

module Tables = struct
  open Gpointer
  external get_tables_ :
    unit -> tree_view_column_sizing variant_table
            * sort_type variant_table
            * cell_renderer_mode variant_table
    = "ml_gtk_tree_get_tables"
  let sizing, sort, renderer_mode = get_tables_ ()
  open Gobject.Data
  let conv_sort = enum sort
  let conv_sizing = enum sizing
  let conv_renderer_mode = enum renderer_mode
end

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
    [>`treeview] obj -> tree_path option * tree_view_column option
    = "ml_gtk_tree_view_get_cursor"
  module Properties = struct
    open Gobject
    open Gobject.Data
    let enable_search = {name="enable_search"; classe=`treeview; conv=boolean}
    let expander_column : (_,tree_view_column obj option) property =
      {name="expander_column"; classe=`treeview; conv=gobject}
    let hadjustment : (_,adjustment obj option) property =
      {name="hadjustment"; classe=`treeview; conv=gobject}
    let headers_clickable =
      {name="headers_clickable"; classe=`treeview; conv=boolean}
    let headers_visible =
      {name="headers_visible"; classe=`treeview; conv=boolean}
    let model : (_,tree_model obj option) property =
      {name="vadjustment"; classe=`treeview; conv=gobject}
    let reorderable = {name="reorderable"; classe=`treeview; conv=boolean}
    let rules_hint = {name="rules_hint"; classe=`treeview; conv=boolean}
    let search_column = {name="search_column"; classe=`treeview; conv=int}
    let vadjustment : (_,adjustment obj option) property =
      {name="vadjustment"; classe=`treeview; conv=gobject}
  end
  module Signals = struct
    open GtkSignal
    let return = Gobject.Closure.set_result
    let columns_changed =
      { name = "columns-changed"; classe = `treeview;
        marshaller = marshal_unit }
    let cursor_changed =
      { name = "cursor-changed"; classe = `treeview;
        marshaller = marshal_unit }
    let marshal_expand_bool3 f argv = function
      | `BOOL logical :: `BOOL expand :: `BOOL all :: _ ->
          return argv (`BOOL (f ~logical ~expand ~all))
      | _ -> failwith "GtkTree.TreeView.Signals.expand_collapse_cursor_row"
    let expand_collapse_cursor_row =
      { name = "expand_collapse_cursor_row"; classe = `treeview;
        marshaller = marshal_expand_bool3 }
    external extract_movement_step : int -> Gtk.Tags.movement_step
      = "ml_Val_movement_step"
    let marshal_move_cursor f argv = function
      | `INT step :: `INT n :: _ ->
          return argv (`BOOL (f (extract_movement_step step) n))
      | _ -> failwith "GtkTree.TreeView.Signals.move_cursor"
    let move_cursor =
      { name = "move_cursor"; classe = `treeview;
        marshaller = marshal_move_cursor }
    let marshal_row_activated f _ = function
      | `POINTER(Some i) :: `OBJECT(Some c) :: _ ->
          f (TreeModel.Signals.extract_iter i)
            (Gobject.unsafe_cast c : tree_view_column obj)
      | _ -> failwith "GtkTree.TreeView.Signals.row_activated"
    let row_activated =
      { name = "row_activated"; classe = `treeview;
        marshaller = marshal_row_activated }
    let marshal_iter_path f _ = function
      | `POINTER(Some i) :: `POINTER(Some p) :: _ ->
          f (TreeModel.Signals.extract_iter i)
            (TreeModel.Signals.extract_path p)
      |	_ -> invalid_arg "GtkTree.TreeView.Signals.marshal_iter_path"
    let row_collapsed =
      { name = "row_collapsed"; classe = `treeview;
        marshaller = marshal_iter_path }
    let row_expanded =
      { name = "row_expanded"; classe = `treeview;
        marshaller = marshal_iter_path }
    let marshal_ret_bool f argv _ = return argv (`BOOL (f ()))
    let select_all =
      { name = "select_all"; classe = `treeview;
        marshaller = marshal_ret_bool }
    let select_cursor_parent =
      { name = "select_cursor_parent"; classe = `treeview;
        marshaller = marshal_ret_bool }
    let marshal_select_cursor_row f argv = function
      | `BOOL start_editing :: _ ->
          return argv (`BOOL (f ~start_editing))
      | _ -> failwith "GtkTree.TreeView.Signals.select_cursor_row"
    let select_cursor_row =
      { name = "select_cursor_row"; classe = `treeview;
        marshaller = marshal_select_cursor_row }
    let marshal_adjustments f _ = function
      | `OBJECT a :: `OBJECT b :: _ ->
          f (may_map Gobject.unsafe_cast a : adjustment obj option)
            (may_map Gobject.unsafe_cast b : adjustment obj option)
      | _ -> failwith "GtkTree.TreeView.Signals.set_scroll_adjustments"
    let set_scroll_adjustments =
      { name = "set_scroll_adjustments"; classe = `treeview;
        marshaller = marshal_adjustments }
    let start_interactive_search =
      { name = "start_interactive_search"; classe = `treeview;
        marshaller = marshal_ret_bool }
    let test_collapse_row =
      { name = "test_collapse_row"; classe = `treeview;
        marshaller = marshal_ret_bool }
    let marshal_expand_row f argv = function
      | `POINTER(Some i) :: `POINTER(Some p) :: _ ->
          return argv (`BOOL (f (TreeModel.Signals.extract_iter i)
                                (TreeModel.Signals.extract_path p)))
      |	_ -> invalid_arg "GtkTree.TreeView.Signals.marshal_expand_row"
    let test_expand_row =
      { name = "test_expand_row"; classe = `treeview;
        marshaller = marshal_expand_row }
    let toggle_cursor_row =
      { name = "toggle_cursor_row"; classe = `treeview;
        marshaller = marshal_ret_bool }
    let unselect_all =
      { name = "unselect_all"; classe = `treeview;
        marshaller = marshal_ret_bool }
  end
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
  let classe = `treeviewcolumn
  module Properties = struct
    open Gobject
    open Gobject.Data
    let alignment = {name="alignment"; classe=classe; conv=float}
    let clickable = {name="clickable"; classe=classe; conv=boolean}
    let fixed_width = {name="fixed_width"; classe=classe; conv=int}
    let max_width = {name="max_width"; classe=classe; conv=int}
    let min_width = {name="min_width"; classe=classe; conv=int}
    let reorderable = {name="reorderable"; classe=classe; conv=boolean}
    let resizable = {name="resizable"; classe=classe; conv=boolean}
    let sizing = {name="sizing"; classe=classe; conv=Tables.conv_sizing}
    let sort_indicator = {name="sort_indicator"; classe=classe; conv=boolean}
    let sort_order = {name="sort_order"; classe=classe; conv=Tables.conv_sort}
    let title = {name="title"; classe=classe; conv=string}
    let visible = {name="visible"; classe=classe; conv=boolean}
    let widget = {name="widget"; classe=classe;
                  conv=(gobject : widget obj option conv)}
    let width = {name="width"; classe=classe; conv=int}
  end
  module Signals = struct
    open GtkSignal
    let clicked = { name = "clicked"; classe = classe;
                    marshaller = marshal_unit }
  end
end

module CellRenderer = struct
  let cast w : cell_renderer obj = Object.try_cast w "GtkCellRenderer"
  let classe = `cellrenderer
  module Properties = struct
    open Gobject
    open Gobject.Data
    let cell_background =
      {name="cell_background"; classe=classe; conv=string}
    (* let cell_background_gdk =
      {name="cell_background_gdk"; classe=classe; conv=GdkColor} *)
    let cell_background_set =
      {name="cell_background_set"; classe=classe; conv=boolean}
    let height = {name="height"; classe=classe; conv=int}
    let is_expanded = {name="is_expanded"; classe=classe; conv=boolean}
    let is_expander = {name="is_expander"; classe=classe; conv=boolean}
    let mode = {name="mode"; classe=classe; conv=Tables.conv_renderer_mode}
    let visible = {name="visible"; classe=classe; conv=boolean}
    let width = {name="width"; classe=classe; conv=int}
    let xalign = {name="xalign"; classe=classe; conv=float}
    let xpad = {name="xpad"; classe=classe; conv=uint}
    let yalign = {name="yalign"; classe=classe; conv=float}
    let ypad = {name="ypad"; classe=classe; conv=uint}
  end
end

module CellRendererPixbuf = struct
  let cast w : cell_renderer_pixbuf obj =
    Object.try_cast w "GtkCellRendererPixbuf"
  external create : unit -> cell_renderer_pixbuf obj
    = "ml_gtk_cell_renderer_pixbuf_new"
end

module CellRendererText = struct
  let cast w : cell_renderer_text obj = Object.try_cast w "GtkCellRendererText"
  external create : unit -> cell_renderer_text obj
    = "ml_gtk_cell_renderer_text_new"
  external set_fixed_height_from_font : cell_renderer_text obj -> int -> unit
    = "ml_gtk_cell_renderer_text_set_fixed_height_from_font"
  module Signals = struct
    open GtkSignal
    let marshal_edited f _ = function
        `STRING(Some path) :: `STRING(Some text) :: _ ->
          f (TreePath.from_string path) text
      | _ -> failwith "GtkTree.CellRendererText.Signals.marshal_edited"
    let edited = { name = "edited"; classe = `cellrenderertext;
                   marshaller = marshal_edited }
  end
(*
  let classe = `cellrenderertext
  open Gobject
  open Gobject.Data
  let attributes = {name="attributes"; classe=classe; conv=PangoAttrList}
  let background = {name="background"; classe=classe; conv=string}
  let background_gdk = {name="background_gdk"; classe=classe; conv=dkColor}
  let background_set = {name="background_set"; classe=classe; conv=boolean}
  let editable = {name="editable"; classe=classe; conv=boolean}
  let editable_set = {name="editable_set"; classe=classe; conv=boolean}
  let family = {name="family"; classe=classe; conv=chararray}
  let family_set = {name="family_set"; classe=classe; conv=boolean}
  let font = {name="font"; classe=classe; conv=chararray}
  let font_desc = {name="font_desc"; classe=classe; conv=angoFontDescription}
  let foreground = {name="foreground"; classe=classe; conv=chararray}
  let foreground_gdk = {name="foreground_gdk"; classe=classe; conv=dkColor}
  let foreground_set = {name="foreground_set"; classe=classe; conv=boolean}
  let markup = {name="markup"; classe=classe; conv=chararray}
  let rise = {name="rise"; classe=classe; conv=int}
  let rise_set = {name="rise_set"; classe=classe; conv=boolean}
  let scale = {name="scale"; classe=classe; conv=double}
  let scale_set = {name="scale_set"; classe=classe; conv=boolean}
  let size = {name="size"; classe=classe; conv=int}
  let size_points = {name="size_points"; classe=classe; conv=double}
  let size_set = {name="size_set"; classe=classe; conv=boolean}
  let stretch = {name="stretch"; classe=classe; conv=angoStretch}
  let stretch_set = {name="stretch_set"; classe=classe; conv=boolean}
  let strikethrough = {name="strikethrough"; classe=classe; conv=boolean}
  let strikethrough_set =
    {name="strikethrough_set"; classe=classe; conv=boolean}
  let style = {name="style"; classe=classe; conv=angoStyle}
  let style_set = {name="style_set"; classe=classe; conv=boolean}
  let text = {name="text"; classe=classe; conv=chararray}
  let underline = {name="underline"; classe=classe; conv=angoUnderline}
  let underline_set = {name="underline_set"; classe=classe; conv=boolean}
  let variant = {name="variant"; classe=classe; conv=angoVariant}
  let variant_set = {name="variant_set"; classe=classe; conv=boolean}
  let weight = {name="weight"; classe=classe; conv=int}
  let weight_set = {name="weight_set"; classe=classe; conv=boolean}
*)
end

module CellRendererToggle = struct
  let cast w : cell_renderer_toggle obj =
    Object.try_cast w "GtkCellRendererToggle"
  external create : unit -> cell_renderer_toggle obj
    = "ml_gtk_cell_renderer_toggle_new"
  let classe = `cellrenderertoggle
  module Signals = struct
    open GtkSignal
    let marshal_toggled f _ = function
        `STRING(Some path) :: _ ->
          f (TreePath.from_string path)
      | _ -> failwith "GtkTree.CellRendererToggle.Signals.marshal_toggled"
    let toggled = { name = "toggled"; classe = classe;
                    marshaller = marshal_toggled }
  end
(*
  open Gobject
  open Gobject.Data
  let activatable = {name="activatable"; classe=classe; conv=boolean}
  let active = {name="active"; classe=classe; conv=boolean}
  let inconsistent = {name="inconsistent"; classe=classe; conv=boolean}
  let radio = {name="radio"; classe=classe; conv=boolean}
*)
end

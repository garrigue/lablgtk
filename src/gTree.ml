(* $Id$ *)

open StdLabels
open Gaux
open Gobject
open Gtk
open GtkBase
open GtkTree
open OGtkProps
open GObj
open GContainer

(* Obsolete GtkTree/GtkTreeItem framework *)

class tree_item_signals obj = object
  inherit item_signals obj
  method expand = GtkSignal.connect obj ~sgn:TreeItem.Signals.expand ~after
  method collapse = GtkSignal.connect obj ~sgn:TreeItem.Signals.collapse ~after
end

class tree_item obj = object
  inherit container obj
  method event = new GObj.event_ops obj
  method as_item : Gtk.tree_item obj = obj
  method connect = new tree_item_signals obj
  method set_subtree (w : tree) = TreeItem.set_subtree obj w#as_tree
  method remove_subtree () = TreeItem.remove_subtree obj
  method expand () = TreeItem.expand obj
  method collapse () = TreeItem.collapse obj
  method subtree =
    try Some(new tree (TreeItem.subtree obj)) with Gpointer.Null -> None
end

and tree_signals obj = object
  inherit container_signals obj
  method selection_changed =
    GtkSignal.connect obj ~sgn:Tree.Signals.selection_changed ~after
  method select_child ~callback =
    GtkSignal.connect obj ~sgn:Tree.Signals.select_child ~after
      ~callback:(fun w -> callback (new tree_item (TreeItem.cast w))) 
  method unselect_child ~callback =
    GtkSignal.connect obj ~sgn:Tree.Signals.unselect_child ~after
      ~callback:(fun w -> callback (new tree_item (TreeItem.cast w))) 
end

and tree obj = object (self)
  inherit [tree_item] item_container obj
  method event = new GObj.event_ops obj
  method as_tree = (obj :> Gtk.tree obj)
  method insert w ~pos = Tree.insert obj w#as_item ~pos
  method connect = new tree_signals obj
  method clear_items = Tree.clear_items obj
  method select_item = Tree.select_item obj
  method unselect_item = Tree.unselect_item obj
  method child_position (w : tree_item) = Tree.child_position obj w#as_item
  method remove_items items =
    Tree.remove_items obj
      (List.map ~f:(fun (t : tree_item) -> t#as_item) items)
  method set_selection_mode = Tree.set_selection_mode obj
  method set_view_mode = Tree.set_view_mode obj
  method set_view_lines = Tree.set_view_lines obj
  method selection =
    List.map ~f:(fun w -> self#wrap (w :> Gtk.widget obj)) (Tree.selection obj)
  method private wrap w =
    new tree_item (TreeItem.cast w)
end

let tree_item ?label ?packing ?show () =
  let w = TreeItem.create ?label () in
  let self = new tree_item w in
  may packing ~f:(fun f -> (f self : unit));
  if show <> Some false then self#misc#show ();
  self

let tree ?selection_mode ?view_mode ?view_lines =
  GContainer.pack_container [] ~create:(fun p ->
    let w = Tree.create p in
    Tree.set w ?selection_mode ?view_mode ?view_lines;
    new tree w)

(* New GtkTreeView/Model framework *)

open Gobject
type 'a column = {index: int; conv: 'a data_conv; creator: int}

class column_list = object (self)
  val mutable index = 0
  val mutable kinds = []
  val mutable locked = false
  method kinds = List.rev kinds
  method add : 'a. 'a data_conv -> 'a column = fun conv ->
    if locked then failwith "GTree.column_list#add";
    let n = index in
    kinds <- Data.get_fundamental conv :: kinds;
    index <- index + 1;
    {index = n; conv = conv; creator = Oo.id self}
  method id = Oo.id self
  method lock () = locked <- true
end

class model_signals obj = object
  inherit gobject_signals obj
  method row_changed =
    GtkSignal.connect obj ~sgn:TreeModel.Signals.row_changed ~after
  method row_inserted =
    GtkSignal.connect obj ~sgn:TreeModel.Signals.row_inserted ~after
  method row_has_child_toggled =
    GtkSignal.connect obj ~sgn:TreeModel.Signals.row_has_child_toggled ~after
  method row_deleted =
    GtkSignal.connect obj ~sgn:TreeModel.Signals.row_deleted ~after
  method rows_reordered =
    GtkSignal.connect obj ~sgn:TreeModel.Signals.rows_reordered ~after
end

let model_ids = Hashtbl.create 7

class model obj = object (self)
  val id =
    try Hashtbl.find model_ids (Gobject.get_oid obj) with Not_found -> 0
  val obj = obj
  method as_model = (obj :> tree_model obj)
  method coerce = (self :> model)
  method misc = new gobject_ops obj
  method connect = new model_signals obj
  method n_columns = TreeModel.get_n_columns obj
  method get_column_type = TreeModel.get_column_type obj
  method get_iter = TreeModel.get_iter obj
  method get_path = TreeModel.get_path obj
  method get : 'a. row:tree_iter -> column:'a column -> 'a =
    fun ~row ~column ->
      if column.creator <> id then invalid_arg "GTree.model#get: bad column";
      let v = Value.create_empty () in
      TreeModel.get_value obj ~row ~column:column.index v;
      Data.of_value column.conv v
  method iter_next = TreeModel.iter_next obj
  method iter_children ?(nth=0) p = TreeModel.iter_nth_child obj p nth
  method iter_parent = TreeModel.iter_parent obj
end

class tree_store obj = object
  inherit model obj
  method set : 'a. row:tree_iter -> column:'a column -> 'a -> unit =
    fun ~row ~column data ->
      if column.creator <> id then
        invalid_arg "GTree.tree_store#set: bad column";
      TreeStore.set_value obj ~row ~column:column.index
        (Data.to_value column.conv data)
  method remove = TreeStore.remove obj
  method insert = TreeStore.insert obj
  method insert_before = TreeStore.insert_before obj
  method insert_after = TreeStore.insert_after obj
  method append = TreeStore.append obj
  method prepend = TreeStore.prepend obj
  method is_ancestor = TreeStore.is_ancestor obj
  method iter_depth = TreeStore.iter_depth obj
  method clear () = TreeStore.clear obj
  method iter_is_valid = TreeStore.iter_is_valid obj
  method swap = TreeStore.swap obj
  method move_before = TreeStore.move_before obj
  method move_after = TreeStore.move_after obj
end

let tree_store (cols : column_list) =
  cols#lock ();
  let types =
    List.map Type.of_fundamental cols#kinds in
  let store = TreeStore.create (Array.of_list types) in
  Hashtbl.add model_ids(Gobject.get_oid store) cols#id;
  new tree_store store

class list_store obj = object
  inherit model obj
  method set : 'a. row:tree_iter -> column:'a column -> 'a -> unit =
    fun ~row ~column data ->
      if column.creator <> id then
        invalid_arg "GTree.list_store#set: bad column";
      ListStore.set_value obj ~row ~column:column.index
        (Data.to_value column.conv data)
  method remove = ListStore.remove obj
  method insert = ListStore.insert obj
  method insert_before = ListStore.insert_before obj
  method insert_after = ListStore.insert_after obj
  method append = ListStore.append obj
  method prepend = ListStore.prepend obj
  method clear () = ListStore.clear obj
  method iter_is_valid = ListStore.iter_is_valid obj
  method swap = ListStore.swap obj
  method move_before = ListStore.move_before obj
  method move_after = ListStore.move_after obj
end

let list_store (cols : column_list) =
  cols#lock ();
  let types =
    List.map Type.of_fundamental (cols#kinds :> fundamental_type list) in
  let store = ListStore.create (Array.of_list types) in
  Hashtbl.add model_ids (Gobject.get_oid store) cols#id;
  new list_store store

(*
open GTree.Data;;
let cols = new GTree.column_list ;;
let title = cols#add string;;
let author = cols#add string;;
let checked = cols#add boolean;;
let store = new GTree.tree_store cols;;
*)

class view_column_signals obj = object
  inherit gtkobj_signals obj
  method clicked =
    GtkSignal.connect obj ~sgn:TreeViewColumn.Signals.clicked ~after
end

module P = TreeViewColumn.P
class view_column (obj : tree_view_column obj) = object
  inherit GObj.gtkobj obj
  method private obj = obj
  inherit tree_view_column_props
  method as_column = obj
  method misc = new gobject_ops obj
  method connect = new view_column_signals obj
  method pack : 'a. ?expand:_ -> ?from:_ -> ([>`cellrenderer] as 'a) obj -> _ =
    TreeViewColumn.pack obj
  method add_attribute :
    'a 'b. ([>`cellrenderer] as 'a) obj -> string -> 'b column -> unit
    = fun crr attr col -> TreeViewColumn.add_attribute obj crr attr col.index
  method set_sort_column_id = TreeViewColumn.set_sort_column_id obj
end
let view_column ?title ?renderer () =
  let w = new view_column (TreeViewColumn.create []) in
  may title ~f:w#set_title;
  may renderer ~f:
    begin fun (crr, l) ->
      w#pack crr;
      List.iter l ~f:(fun (attr,col) -> w#add_attribute crr attr col)
    end;
  w

let as_column (col : view_column) = col#as_column

class selection_signals (obj : tree_selection) = object
  inherit gobject_signals obj
  method changed =
    GtkSignal.connect obj ~sgn:TreeSelection.Signals.changed ~after
end

class selection obj = object
  val obj = obj
  method connect = new selection_signals obj
  method misc = new gobject_ops obj
  method set_mode = TreeSelection.set_mode obj
  method get_mode = TreeSelection.get_mode obj
  method set_select_function = TreeSelection.set_select_function obj
  method get_selected_rows = TreeSelection.get_selected_rows obj
  method count_selected_rows = TreeSelection.count_selected_rows obj
  method select_path = TreeSelection.select_path obj
  method unselect_path = TreeSelection.unselect_path obj
  method path_is_selected = TreeSelection.path_is_selected obj
  method select_iter = TreeSelection.select_iter obj
  method unselect_iter = TreeSelection.unselect_iter obj
  method iter_is_selected = TreeSelection.iter_is_selected obj
  method select_all = TreeSelection.select_all obj
  method unselect_all = TreeSelection.unselect_all obj
  method select_range = TreeSelection.select_range obj
  method unselect_range = TreeSelection.unselect_range obj
end

class view_signals obj = object
  inherit GContainer.container_signals obj
  method set_scroll_adjustments ~callback =
    GtkSignal.connect obj ~sgn:TreeView.Signals.set_scroll_adjustments ~after
      ~callback:(fun h v -> callback (may_map (new GData.adjustment) h)
                                     (may_map (new GData.adjustment) v))
  method row_activated ~callback =
    GtkSignal.connect obj ~sgn:TreeView.Signals.row_activated ~after
      ~callback:(fun it vc -> callback it (new view_column vc))
  method test_expand_row =
    GtkSignal.connect obj ~sgn:TreeView.Signals.test_expand_row ~after
  method test_collapse_row =
    GtkSignal.connect obj ~sgn:TreeView.Signals.test_collapse_row ~after
  method row_expanded =
    GtkSignal.connect obj ~sgn:TreeView.Signals.row_expanded ~after
  method row_collapsed =
    GtkSignal.connect obj ~sgn:TreeView.Signals.row_collapsed ~after
  method columns_changed =
    GtkSignal.connect obj ~sgn:TreeView.Signals.columns_changed ~after
  method cursor_changed =
    GtkSignal.connect obj ~sgn:TreeView.Signals.cursor_changed ~after
  method move_cursor =
    GtkSignal.connect obj ~sgn:TreeView.Signals.move_cursor ~after
  method select_all =
    GtkSignal.connect obj ~sgn:TreeView.Signals.select_all ~after
  method unselect_all =
    GtkSignal.connect obj ~sgn:TreeView.Signals.unselect_all ~after
  method select_cursor_row =
    GtkSignal.connect obj ~sgn:TreeView.Signals.select_cursor_row ~after
  method toggle_cursor_row =
    GtkSignal.connect obj ~sgn:TreeView.Signals.toggle_cursor_row ~after
  method expand_collapse_cursor_row =
    GtkSignal.connect obj ~sgn:TreeView.Signals.expand_collapse_cursor_row
      ~after
  method select_cursor_parent =
    GtkSignal.connect obj ~sgn:TreeView.Signals.select_cursor_parent ~after
  method start_interactive_search =
    GtkSignal.connect obj ~sgn:TreeView.Signals.start_interactive_search ~after
end

open TreeView.P
class view obj = object
  inherit [Gtk.tree_view] GContainer.container_impl obj
  inherit tree_view_props
  method connect = new view_signals obj
  method selection = new selection (TreeView.get_selection obj)
  method expander_column = may_map (new view_column) (get expander_column obj)
  method set_expander_column c =
    set expander_column obj (may_map as_column c)
  method model = new model (Property.get_some obj model)
  method set_model m = set model obj (may_map (fun (m:model) -> m#as_model) m)
  method append_column col = TreeView.append_column obj (as_column col)
  method remove_column col = TreeView.remove_column obj (as_column col)
  method insert_column col = TreeView.insert_column obj (as_column col)
  method get_column n = new view_column (TreeView.get_column obj n)
  method move_column col ~after =
    TreeView.move_column_after obj (as_column col) (as_column after)
  method scroll_to_point = TreeView.scroll_to_point obj
  method scroll_to_cell ?align path col =
    TreeView.scroll_to_cell obj ?align path (as_column col)
  method row_activated path col =
    TreeView.row_activated obj path (as_column col)
  method expand_all () = TreeView.expand_all obj
  method collapse_all () = TreeView.collapse_all obj
  method expand_row ?(all=false) = TreeView.expand_row obj ~all
  method collapse_row = TreeView.collapse_row obj
  method row_expanded = TreeView.row_expanded obj
  method set_cursor : 'a. ?cell:([> `cellrenderer ] as 'a) Gtk.obj -> _ =
    fun ?cell ?(edit=false) row col ->
      match cell with
        None -> TreeView.set_cursor obj ~edit row (as_column col)
      | Some cell ->
          TreeView.set_cursor_on_cell obj ~edit row (as_column col) cell
  method get_cursor () = TreeView.get_cursor obj
  method get_path_at_pos = TreeView.get_path_at_pos obj
end
let view ?model ?hadjustment ?vadjustment =
  let model = may_map (fun m -> m#as_model) model in
  let hadjustment = may_map GData.as_adjustment hadjustment in
  let vadjustment = may_map GData.as_adjustment vadjustment in
  TreeView.make_params [] ?model ?hadjustment ?vadjustment ~cont:(
  GContainer.pack_container ~create:(fun p -> new view (TreeView.create p)))

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
type cell_properties_pixbuf_only =
  [ `PIXBUF of GdkPixbuf.pixbuf
  | `PIXBUF_EXPANDER_CLOSED of GdkPixbuf.pixbuf
  | `PIXBUF_EXPANDER_OPEN of GdkPixbuf.pixbuf
  | `STOCK_DETAIL of string
  | `STOCK_ID of string
  | `STOCK_SIZE of Gtk.Tags.icon_size ] 
type cell_properties_pixbuf = [ cell_properties | cell_properties_pixbuf_only ]
type cell_properties_text_only =
  [ `BACKGROUND of string
  | `BACKGROUND_GDK of Gdk.color
  | `BACKGROUND_SET of bool
  | `EDITABLE of bool
  | `EDITABLE_SET of bool
  | `FAMILY of string
  | `FAMILY_SET of bool
  | `FONT of string
  | `FONT_DESC of Pango.font_description
  | `FOREGROUND of string
  | `FOREGROUND_GDK of Gdk.color
  | `FOREGROUND_SET of bool
  | `MARKUP of string
  | `RISE of int
  | `RISE_SET of bool
  | `SCALE of float
  | `SCALE_SET of bool
  | `SIZE of int
  | `SIZE_POINTS of float
  | `SIZE_SET of bool
  | `STRETCH of PangoEnums.stretch
  | `STRETCH_SET of bool
  | `STRIKETHROUGH of bool
  | `STRIKETHROUGH_SET of bool
  | `STYLE of PangoEnums.style
  | `STYLE_SET of bool
  | `TEXT of string
  | `UNDERLINE of PangoEnums.underline
  | `UNDERLINE_SET of bool
  | `VARIANT of PangoEnums.variant
  | `VARIANT_SET of bool
  | `WEIGHT of int
  | `WEIGHT_SET of bool ]
type cell_properties_text = [ cell_properties | cell_properties_text_only ]
type cell_properties_toggle_only =
  [ `ACTIVATABLE of bool
  | `ACTIVE of bool
  | `INCONSISTENT of bool
  | `RADIO of bool ]
type cell_properties_toggle = [ cell_properties | cell_properties_toggle_only ]

let cell_renderer_pixbuf_param' = function
  | #cell_properties_pixbuf_only as x -> cell_renderer_pixbuf_param x
  | #cell_properties as x -> cell_renderer_param x
let cell_renderer_text_param' = function
  | #cell_properties as x -> cell_renderer_param x
  | #cell_properties_text_only as x -> cell_renderer_text_param x
let cell_renderer_toggle_param' = function
  | #cell_properties_toggle_only as x -> cell_renderer_toggle_param x
  | #cell_properties as x -> cell_renderer_param x

let cell_renderer_pixbuf l =
  CellRendererPixbuf.create (List.map cell_renderer_pixbuf_param' l)
let cell_renderer_text l =
  CellRendererText.create (List.map cell_renderer_text_param' l)
let cell_renderer_toggle l =
  CellRendererToggle.create (List.map cell_renderer_toggle_param' l)

let set_cell_properties o l =
  Gobject.set_params o (List.map cell_renderer_param l)
let set_pixbuf_properties o l =
  Gobject.set_params o (List.map cell_renderer_pixbuf_param' l)
let set_text_properties o l =
  Gobject.set_params o (List.map cell_renderer_text_param' l)
let set_toggle_properties o l =
  Gobject.set_params o (List.map cell_renderer_toggle_param' l)

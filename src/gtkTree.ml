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
(*
module CTree = struct
  type t
  type node =  [`ctree] obj * t
  let cast w : ctree obj = Object.try_cast w "GtkCTree"
  external create : cols:int -> treecol:int -> ctree obj = "ml_gtk_ctree_new"
  external insert_node :
      [>`ctree] obj -> ?parent:node -> ?sibling:node ->
      titles:optstring array ->
      spacing:int -> ?pclosed:Gdk.pixmap -> ?mclosed:Gdk.bitmap obj ->
      ?popened:Gdk.pixmap -> ?mopened:Gdk.bitmap obj ->
      is_leaf:bool -> expanded:bool -> node
      = "ml_gtk_ctree_insert_node_bc" "ml_gtk_ctree_insert_node"
  let insert_node'
      w ?parent ?sibling ?(spacing = 0) ?(is_leaf = true)
      ?(expanded = false)
      ?pclosed ?mclosed ?popened ?mopened titles =
    let len = GtkList.CList.get_columns w in
    if List.length titles > len then invalid_arg "CTree.insert_node";
    let arr = Array.create ~len None in
    List.fold_left titles ~acc:0
      ~f:(fun ~acc text -> arr.(acc) <- Some text; acc+1);
    insert_node w
      ?parent ?sibling ~titles:(Array.map ~f:optstring arr)
      ~spacing ~is_leaf ~expanded
      ?pclosed ?mclosed ?popened ?mopened 
  external node_set_row_data : [>`ctree] obj -> node:node -> Obj.t -> unit
      = "ml_gtk_ctree_node_set_row_data"
  external node_get_row_data : [>`ctree] obj -> node:node -> Obj.t
      = "ml_gtk_ctree_node_get_row_data"
  external set_indent : [>`ctree] obj -> int -> unit
      = "ml_gtk_ctree_set_indent"
  module Signals = struct
    open GtkSignal
    let marshal_select f argv =
      let node : node =
        match GtkArgv.get_pointer argv ~pos:0 with
          Some p -> Obj.magic p
        | None -> invalid_arg "GtkTree.CTree.Signals.marshal_select"
      in
      f ~node ~column:(GtkArgv.get_int argv ~pos:1)

    let tree_select_row : ([>`ctree],_) t =
      { name = "tree_select_row"; marshaller = marshal_select }
    let tree_unselect_row : ([>`ctree],_) t =
      { name = "tree_unselect_row"; marshaller = marshal_select }
  end
end
*)

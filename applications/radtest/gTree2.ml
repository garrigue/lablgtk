(* $Id$ *)

open Misc
open Gtk
open GtkBase
open GtkTree2
open GObj
open GContainer

class tree_item_signals obj = object
  inherit item_signals obj
  method expand = GtkSignal.connect obj ~sgn:TreeItem.Signals.expand ~after
  method collapse = GtkSignal.connect obj ~sgn:TreeItem.Signals.collapse ~after
end

class ['a] pre_tree_item ~wrapper obj = object
  inherit container obj
  method add_events = Widget.add_events obj
  method as_item : tree_item obj = obj
  method connect = new tree_item_signals obj
  method set_subtree (w : 'a) = TreeItem.set_subtree obj w#as_tree
  method remove_subtree () = TreeItem.remove_subtree obj
  method expand () = TreeItem.expand obj
  method collapse () = TreeItem.collapse obj
  method subtree : 'a = wrapper (TreeItem.subtree obj)
end

class ['a] pre_tree_signals obj ~wrapper = object
  inherit container_signals obj
  method selection_changed =
    GtkSignal.connect obj ~sgn:Tree.Signals.selection_changed ~after
  method select_child ~callback =
    GtkSignal.connect obj ~sgn:Tree.Signals.select_child ~after
      ~callback:(fun w -> callback (wrapper w : 'a)) 
  method unselect_child ~callback =
    GtkSignal.connect obj ~sgn:Tree.Signals.unselect_child ~after
      ~callback:(fun w -> callback (wrapper w : 'a)) 
end

class virtual ['a] pre_tree obj = object (self)
  inherit ['a] item_container obj
  method add_events = Widget.add_events obj
  method as_tree = Tree.coerce obj
  method insert w ~pos = Tree.insert obj w#as_item ~pos
  method connect = new pre_tree_signals obj ~wrapper:self#wrap
  method clear_items = Tree.clear_items obj
  method select_item = Tree.select_item obj
  method unselect_item = Tree.unselect_item obj
  method child_position (w : 'a) = Tree.child_position obj w#as_item
  method remove_items items =
    Tree.remove_items obj
      (List.map ~f:(fun (t : 'a) -> t#as_item) items)
  method set_selection_mode = Tree.set_selection_mode obj
  method set_view_mode = Tree.set_view_mode obj
  method set_view_lines = Tree.set_view_lines obj
  method selection =
    List.map ~f:(fun w -> self#wrap (Widget.coerce w)) (Tree.selection obj)
end

class tree obj = object (self)
  inherit [tree pre_tree_item] pre_tree obj
  method private wrap w =
    new pre_tree_item ~wrapper:(new tree) (TreeItem.cast w)
  method item_up ~pos =
    let l = self#children in
    if pos < 1 || pos > List.length l then invalid_arg "GTree2.tree#item_up";
    let node = List.nth l pos in
    self#remove node;
    self#insert ~pos:(pos-1) node
end

class tree_item obj =
  [tree] pre_tree_item ~wrapper:(new tree) (obj : Gtk.tree_item obj)

class tree_signals obj =
  [tree_item] pre_tree_signals obj
    ~wrapper:(fun w -> new tree_item (TreeItem.cast w))

let tree_item ?label ?border_width ?width ?height ?packing ?show () =
  let w = TreeItem.create ?label () in
  Container.set w ?border_width ?width ?height;
  let self = new tree_item w in
  may packing ~f:(fun f -> (f self : unit));
  if show <> Some false then self#misc#show ();
  self

let tree ?selection_mode ?view_mode ?view_lines
    ?border_width ?width ?height ?packing ?show () =
  let w = Tree.create () in
  Tree.set w ?selection_mode ?view_mode ?view_lines;
  Container.set w ?border_width ?width ?height;
  pack_return (new tree w) ~packing ~show

(* $Id$ *)

open Gaux
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
  method as_tree = Tree.coerce obj
  method insert w ~pos = Tree.insert obj w#as_item ~pos
  method connect = new tree_signals obj
  method clear_items = Tree.clear_items obj
  method select_item = Tree.select_item obj
  method unselect_item = Tree.unselect_item obj
  method child_position (w : tree_item) = Tree.child_position obj w#as_item
  method remove_items items =
    Tree.remove_items obj
      (List.map ~f:(fun (t : tree_item) -> t#as_item) items)
(*  method set_selection_mode = Tree.set_selection_mode obj
  method set_view_mode = Tree.set_view_mode obj *)
  method set_view_lines = Tree.set_view_lines obj
  method selection =
    List.map ~f:(fun w -> self#wrap (w :> Gtk.widget obj)) (Tree.selection obj)
  method item_up ~pos =
    Tree.item_up obj pos
  method private wrap w =
    new tree_item (TreeItem.cast w)
end

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

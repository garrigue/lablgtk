(* $Id$ *)

open Misc
open Gtk
open GtkBase
open GtkTree
open GObj
open GContainer

class tree_item_signals obj ?:after = object
  inherit item_signals obj ?:after
  method expand = GtkSignal.connect obj sig:TreeItem.Signals.expand ?:after
  method collapse = GtkSignal.connect obj sig:TreeItem.Signals.collapse ?:after
end

class ['a] pre_tree_item_wrapper :wrapper obj = object
  inherit container obj
  method add_events = Widget.add_events obj
  method as_item : tree_item obj = obj
  method connect = new tree_item_signals ?obj
  method set_subtree : 'b. (#is_tree as 'b) -> unit =
    fun w -> TreeItem.set_subtree obj w#as_tree
  method remove_subtree () = TreeItem.remove_subtree obj
  method expand () = TreeItem.expand obj
  method collapse () = TreeItem.collapse obj
  method subtree : 'a = wrapper (TreeItem.subtree obj)
end

class ['a] pre_tree_signals obj :wrapper ?:after = object
  inherit container_signals obj ?:after
  method selection_changed =
    GtkSignal.connect ?obj ?sig:Tree.Signals.selection_changed ?:after
  method select_child :callback =
    GtkSignal.connect obj sig:Tree.Signals.select_child ?:after
      callback:(fun w -> callback (wrapper w : 'a)) 
  method unselect_child :callback =
    GtkSignal.connect obj sig:Tree.Signals.unselect_child ?:after
      callback:(fun w -> callback (wrapper w : 'a)) 
end

class virtual ['a] pre_tree_wrapper obj = object (self)
  inherit [tree_item,'a] item_container obj
  method add_events = Widget.add_events obj
  method as_tree = Tree.coerce obj
  method insert w :pos =
    Tree.insert obj (w #as_item) :pos
  method connect = new pre_tree_signals ?obj ?wrapper:self#wrap
  method clear_items = Tree.clear_items obj
  method select_item = Tree.select_item obj
  method unselect_item = Tree.unselect_item obj
  method child_position : 'b. (tree_item #is_item as 'b) -> _ =
    fun w -> Tree.child_position obj w#as_item
  method remove_items (items : 'a list) =
    Tree.remove_items obj
      (List.map fun:(fun (t : _ #is_item) -> t #as_item) items)
  method set_selection_mode = Tree.set_selection_mode obj
  method set_view_mode = Tree.set_view_mode obj
  method set_view_lines = Tree.set_view_lines obj
  method selection =
    List.map fun:(fun w -> self#wrap (Widget.coerce w)) (Tree.selection obj)
end

class tree_wrapper' obj = object
  inherit [tree_wrapper' pre_tree_item_wrapper] pre_tree_wrapper obj
  method private wrap w =
    new pre_tree_item_wrapper wrapper:(new tree_wrapper') (TreeItem.cast w)
end

class tree_item_wrapper obj =
  [tree_wrapper'] pre_tree_item_wrapper wrapper:(new tree_wrapper')
    (obj : tree_item obj)

class tree_wrapper obj = object
  inherit [tree_item_wrapper] pre_tree_wrapper (Tree.coerce obj)
  method private wrap w = new tree_item_wrapper (TreeItem.cast w)
end

class tree_signals obj =
  [tree_item_wrapper] pre_tree_signals ?obj
    ?wrapper:(fun w -> new tree_item_wrapper (TreeItem.cast w))

class tree_item ?:label ?:border_width ?:width ?:height ?:packing ?:show =
  let w = TreeItem.create ?None ?:label in
  let () = Container.setter w cont:null_cont ?:border_width ?:width ?:height in
  object (self)
    inherit tree_item_wrapper w
    initializer pack_return :packing ?:show (self :> tree_item_wrapper)
  end

class tree ?:selection_mode ?:view_mode ?:view_lines
    ?:border_width ?:width ?:height ?:packing ?:show =
  let w = Tree.create () in
  let () =
    Tree.setter w cont:null_cont ?:selection_mode ?:view_mode ?:view_lines;
    Container.setter w cont:null_cont ?:border_width ?:width ?:height in
  object (self)
    inherit tree_wrapper w
    initializer pack_return :packing ?:show (self :> tree_wrapper)
  end


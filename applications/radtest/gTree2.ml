(* $Id$ *)

open Misc
open Gtk
open GtkBase
open GtkTree2
open GObj
open GContainer

class tree_item2_signals obj ?:after = object
  inherit item_signals obj ?:after
  method expand = GtkSignal.connect obj sig:TreeItem2.Signals.expand ?:after
  method collapse = GtkSignal.connect obj sig:TreeItem2.Signals.collapse ?:after
end

class ['a] pre_tree_item2_wrapper :wrapper obj = object
  inherit container obj
  method add_events = Widget.add_events obj
  method as_item : tree_item obj = obj
  method connect = new tree_item2_signals ?obj
  method set_subtree : 'b. (#is_tree as 'b) -> unit =
    fun w -> TreeItem2.set_subtree obj w#as_tree
  method remove_subtree () = TreeItem2.remove_subtree obj
  method expand () = TreeItem2.expand obj
  method collapse () = TreeItem2.collapse obj
  method subtree : 'a = wrapper (TreeItem2.subtree obj)
end

class ['a] pre_tree2_signals obj :wrapper ?:after = object
  inherit container_signals obj ?:after
  method selection_changed =
    GtkSignal.connect ?obj ?sig:Tree2.Signals.selection_changed ?:after
  method select_child :callback =
    GtkSignal.connect obj sig:Tree2.Signals.select_child ?:after
      callback:(fun w -> callback (wrapper w : 'a)) 
  method unselect_child :callback =
    GtkSignal.connect obj sig:Tree2.Signals.unselect_child ?:after
      callback:(fun w -> callback (wrapper w : 'a)) 
end

class virtual ['a] pre_tree2_wrapper obj = object (self)
  inherit [tree_item,'a] item_container obj
  method add_events = Widget.add_events obj
  method as_tree = Tree2.coerce obj
  method insert w :pos =
    Tree2.insert obj (w #as_item) :pos
  method connect = new pre_tree2_signals ?obj ?wrapper:self#wrap
  method clear_items = Tree2.clear_items obj
  method select_item = Tree2.select_item obj
  method unselect_item = Tree2.unselect_item obj
  method select_child : 'b. (tree_item #is_item as 'b) -> _ =
    fun w -> Tree2.select_child obj w#as_item
  method unselect_child : 'b. (tree_item #is_item as 'b) -> _ =
    fun w -> Tree2.unselect_child obj w#as_item
  method child_position : 'b. (tree_item #is_item as 'b) -> _ =
    fun w -> Tree2.child_position obj w#as_item
  method remove_items (items : 'a list) =
    Tree2.remove_items obj
      (List.map fun:(fun (t : _ #is_item) -> t #as_item) items)
  method set_selection_mode = Tree2.set_selection_mode obj
  method set_view_mode = Tree2.set_view_mode obj

  method set_view_lines = Tree2.set_view_lines obj
  method selection =
    List.map fun:(fun w -> self#wrap (Widget.coerce w)) (Tree2.selection obj)
  method children2 =
    List.map fun:(fun w -> self#wrap (Widget.coerce w)) (Tree2.children obj)
  method item_up = Tree2.item_up obj
  method select_next_child : 'b. (tree_item #is_item as 'b) -> _ =
    fun w -> Tree2.select_next_child obj w#as_item
  method select_prev_child : 'b. (tree_item #is_item as 'b) -> _ =
    fun w -> Tree2.select_prev_child obj w#as_item
end

class tree2_wrapper' obj = object
  inherit [tree2_wrapper' pre_tree_item2_wrapper] pre_tree2_wrapper obj
  method private wrap w =
    new pre_tree_item2_wrapper wrapper:(new tree2_wrapper') (TreeItem2.cast w)
end

class tree_item2_wrapper obj =
  [tree2_wrapper'] pre_tree_item2_wrapper wrapper:(new tree2_wrapper')
    (obj : tree_item obj)

class tree2_wrapper obj = object
  inherit [tree_item2_wrapper] pre_tree2_wrapper (Tree2.coerce obj)
  method private wrap w = new tree_item2_wrapper (TreeItem2.cast w)
end

class tree2_signals obj =
  [tree_item2_wrapper] pre_tree2_signals ?obj
    ?wrapper:(fun w -> new tree_item2_wrapper (TreeItem2.cast w))

class tree_item2 ?:label ?:border_width ?:width ?:height ?:packing ?:show =
  let w = TreeItem2.create ?None ?:label in
  let () = Container.set w ?:border_width ?:width ?:height in
  object (self)
    inherit tree_item2_wrapper w
    initializer pack_return :packing ?:show (self :> tree_item2_wrapper)
  end

class tree2  ?:selection_mode ?:view_mode ?:view_lines
    ?:border_width ?:width ?:height ?:packing ?:show =
  let w = Tree2.create () in
  let () =
    Tree2.setter w cont:null_cont ?:selection_mode ?:view_mode ?:view_lines;
    Container.set w ?:border_width ?:width ?:height in
  object (self)
    inherit tree2_wrapper w
    initializer pack_return :packing ?:show (self :> tree2_wrapper)
  end


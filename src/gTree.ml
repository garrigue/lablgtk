(* $Id$ *)

open Misc
open Gtk
open GUtil
open GObj
open GCont

class item_signals obj ?:after = object
  inherit GCont.item_signals obj ?:after
  method expand = Signal.connect obj sig:TreeItem.Signals.expand ?:after
  method collapse = Signal.connect obj sig:TreeItem.Signals.collapse ?:after
end

class item_wrapper obj = object
  inherit container obj
  method as_item : TreeItem.t obj = obj
  method connect = new item_signals ?obj
  method set_subtree : 'a. (#is_tree as 'a) -> unit =
    fun w -> TreeItem.set_subtree obj w#as_tree
  method remove_subtree () = TreeItem.remove_subtree obj
  method expand () = TreeItem.expand obj
  method collapse () = TreeItem.collapse obj
  method subtree = new tree_wrapper (TreeItem.subtree obj)
end

and tree_signals obj ?:after = object
  inherit container_signals obj ?:after
  method selection_changed =
    Signal.connect ?obj ?sig:Tree.Signals.selection_changed ?:after
(*
  method select_child 
     callback:((#is_widget as 'a) -> unit) -> ?after:bool -> Gtk.Signal.id
	  = fun :callback -> Signal.connect obj sig:Tree.Signals.select_child
	  callback:(fun w -> callback (w #as_widget))
  method unselect_child    = Signal.connect sig:Tree.Signals.unselect_child
*)
end

and tree_wrapper obj = object
  inherit [TreeItem.t,item_wrapper] item_container obj
  method private wrap w = new item_wrapper (TreeItem.cast w)
  method as_tree = Tree.coerce obj
  method insert w :pos =
    Tree.insert obj (w #as_item) :pos
  method connect = new tree_signals obj
  method clear_items = Tree.clear_items obj
  method select_item = Tree.select_item obj
  method unselect_item = Tree.unselect_item obj
  method child_position : 'a. (TreeItem.t #is_item as 'a) -> _ =
    fun w -> Tree.child_position obj w#as_item
end

class item ?:label ?:border_width ?:width ?:height ?:packing =
  let w = TreeItem.create ?None ?:label in
  let () = Container.setter w cont:null_cont ?:border_width ?:width ?:height in
  object (self)
    inherit item_wrapper w
    initializer pack_return :packing self
  end

class tree ?:selection_mode ?:view_mode ?:view_lines
    ?:border_width ?:width ?:height ?:packing =
  let w = Tree.create () in
  let () =
    Tree.setter w cont:null_cont ?:selection_mode ?:view_mode ?:view_lines;
    Container.setter w cont:null_cont ?:border_width ?:width ?:height in
  object (self)
    inherit tree_wrapper w
    initializer pack_return :packing self
  end

(* $Id$ *)

open Misc
open Gtk
open GUtil
open GObj
open GContainer

class list_item_wrapper obj = object
  inherit container (obj : ListItem.t obj)
  method as_item = obj
  method select () = Item.select obj
  method deselect () = Item.deselect obj
  method toggle () = Item.toggle obj
  method connect = new item_signals ?obj
end

class list_item ?:label ?:border_width ?:width ?:height ?:packing =
  let w = ListItem.create ?:label ?None in
  let () = Container.setter w cont:null_cont ?:border_width ?:width ?:height in
  object (self)
    inherit list_item_wrapper w
    initializer pack_return :packing (self :> list_item_wrapper)
  end

class liste_wrapper obj = object
  inherit [ListItem.t,list_item] item_container (obj : GtkList.t obj)
  method private wrap w = new list_item_wrapper (ListItem.cast w)
  method insert w = GtkList.insert_item obj w#as_item
  method clear_items = GtkList.clear_items obj
  method select_item = GtkList.select_item obj
  method unselect_item = GtkList.unselect_item obj
  method child_position : 'a. (ListItem.t #is_item as 'a) -> _ =
    fun w -> GtkList.child_position obj w#as_item
end

class liste ?:selection_mode ?:border_width ?:width ?:height ?:packing =
  let w = GtkList.create () in
  let () =
    may selection_mode fun:(GtkList.set_selection_mode w);
    Container.setter w cont:null_cont ?:border_width ?:width ?:height
  in
  object (self)
    inherit liste_wrapper w
    initializer pack_return :packing (self :> liste_wrapper)
  end

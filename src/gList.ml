(* $Id$ *)

open Misc
open Gtk
open GtkBase
open GtkList
open GUtil
open GObj
open GContainer

class list_item_wrapper obj = object
  inherit container (obj : list_item obj)
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
  inherit [Gtk.list_item,list_item] item_container (obj : Gtk.liste obj)
  method private wrap w = new list_item_wrapper (ListItem.cast w)
  method insert w = Liste.insert_item obj w#as_item
  method clear_items = Liste.clear_items obj
  method select_item = Liste.select_item obj
  method unselect_item = Liste.unselect_item obj
  method child_position : 'a. (Gtk.list_item #is_item as 'a) -> _ =
    fun w -> Liste.child_position obj w#as_item
end

class liste ?:selection_mode ?:border_width ?:width ?:height ?:packing =
  let w = Liste.create () in
  let () =
    may selection_mode fun:(Liste.set_selection_mode w);
    Container.setter w cont:null_cont ?:border_width ?:width ?:height
  in
  object (self)
    inherit liste_wrapper w
    initializer pack_return :packing (self :> liste_wrapper)
  end

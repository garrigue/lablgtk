(* $Id$ *)

open Misc
open Gtk
open GtkBase
open GtkList
open GObj
open GContainer

class list_item_wrapper obj = object
  inherit container (obj : list_item obj)
  method add_events = Widget.add_events obj
  method as_item = obj
  method select () = Item.select obj
  method deselect () = Item.deselect obj
  method toggle () = Item.toggle obj
  method connect = new item_signals ?obj
end

class list_item ?:label ?:border_width ?:width ?:height ?:packing ?:show =
  let w = ListItem.create ?:label ?None in
  let () = Container.set w ?:border_width ?:width ?:height in
  object (self)
    inherit list_item_wrapper w
    initializer pack_return :packing ?:show (self :> list_item_wrapper)
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

class liste ?:selection_mode ?:border_width ?:width ?:height ?:packing ?:show =
  let w = Liste.create () in
  let () =
    may selection_mode fun:(Liste.set_selection_mode w);
    Container.set w ?:border_width ?:width ?:height
  in
  object (self)
    inherit liste_wrapper w
    initializer pack_return :packing ?:show (self :> liste_wrapper)
  end

(* Cell lists *)

class clist_signals obj = object
  inherit container_signals obj
  method click_column =
    GtkSignal.connect sig:CList.Signals.click_column obj
  method select_row =
    GtkSignal.connect sig:CList.Signals.select_row obj
  method unselect_row =
    GtkSignal.connect sig:CList.Signals.unselect_row obj
end

class clist_wrapper obj = object (self)
  inherit widget (obj : clist obj)
  method set_border_width = Container.set_border_width obj
  method add_events = Widget.add_events obj
  method connect = new clist_signals ?obj
  method rows = CList.get_rows obj
  method columns = CList.get_columns obj
  method hadjustment = new GData.adjustment_wrapper (CList.get_hadjustment obj)
  method vadjustment = new GData.adjustment_wrapper (CList.get_vadjustment obj)
  method set_button_actions = CList.set_button_actions obj
  method freeze () = CList.freeze obj
  method thaw () = CList.thaw obj
  method column_title = CList.get_column_title obj
  method column_widget col =
    new widget_wrapper (CList.get_column_widget obj col)
  method columns_autosize () = CList.columns_autosize obj
  method optimal_column_width = CList.optimal_column_width obj
  method moveto row col ?:row_align [< 0. >] ?:col_align [< 0. >] =
    CList.moveto obj row col :row_align :col_align
  method row_is_visible = CList.row_is_visible obj
  method cell_type = CList.get_cell_type obj
  method cell_text = CList.get_text obj
  method cell_pixmap row col =
    let pm, mask = CList.get_pixmap obj row col in
    new GdkObj.pixmap pm ?:mask
  method row_selectable = CList.get_selectable obj
  method set_shift = CList.set_shift obj
  method insert :row texts =
    let texts = List.map texts fun:(fun x -> Some x) in
    CList.insert obj row :texts
  method append = self#insert row:self#rows
  method prepend = self#insert row:0
  method remove = CList.remove obj
  method select = CList.select obj
  method unselect = CList.unselect obj
  method clear () = CList.clear obj
  method get_row_column = CList.get_row_column obj
  method select_all () = CList.select_all obj
  method unselect_all () = CList.unselect_all obj
  method swap_rows = CList.swap_rows obj
  method row_move = CList.row_move obj
  method sort () = CList.sort obj
  method set_hadjustment (adj : GData.adjustment) =
    CList.set_hadjustment obj adj#as_adjustment
  method set_vadjustment (adj : GData.adjustment) =
    CList.set_vadjustment obj adj#as_adjustment
  method set_shadow_type = CList.set_shadow_type obj
  method set_button_actions = CList.set_button_actions obj
  method set_selection_mode = CList.set_selection_mode obj
  method set_reorderable = CList.set_reorderable obj
  method set_use_drag_icons = CList.set_use_drag_icons obj
  method set_row_height = CList.set_row_height obj
  method set_titles_show = CList.set_titles_show obj
  method set_titles_active = CList.set_titles_active obj
  method set_sort = CList.set_sort ?obj
  method set_column : 'b. int -> ?widget:(#is_widget as 'b) -> _ =
    fun col ?:widget ->
      CList.set_column ?obj ?col ?widget:(may_map widget fun:(#as_widget))
  method set_row = CList.set_row ?obj
  method set_cell :
      'c. int -> int -> ?text:string -> ?pixmap:(#GdkObj.pixmap as 'c) -> _ =
    fun row col ?:text ?:pixmap ?:spacing [< 0 >] ->
      match text, pixmap with
	_, None -> CList.set_text obj row col ?:text
      | None, Some pm ->
	  CList.set_pixmap obj row col pixmap:pm#pixmap ?mask:pm#mask
      |	Some text, Some pm ->
	  CList.set_pixtext obj row col
	    :text :spacing pixmap:pm#pixmap ?mask:pm#mask
end

class clist ?:columns [< 1 >] ?:titles ?:hadjustment ?:vadjustment
    ?:shadow_type ?:button_actions ?:selection_mode
    ?:reorderable ?:use_drag_icons ?:row_height
    ?:titles_show ?:titles_active ?:auto_sort ?:sort_column ?:sort_type
    ?:border_width ?:width ?:height ?:packing ?:show =
  let w =
    match titles with None -> CList.create cols:columns
    | Some titles -> CList.create_with_titles (Array.of_list titles)
  in
  let () =
    CList.set w 
      ?hadjustment:(GData.adjustment_option hadjustment)
      ?vadjustment:(GData.adjustment_option vadjustment)
      ?:shadow_type ?:button_actions ?:selection_mode ?:reorderable
      ?:use_drag_icons ?:row_height ?:titles_show ?:titles_active;
    CList.set_sort w ?auto:auto_sort ?column:sort_column ?type:sort_type;
    Container.set w ?:border_width ?:width ?:height
  in
  object (self)
    inherit clist_wrapper w
    initializer pack_return :packing ?:show (self :> clist_wrapper)
  end

(* $Id$ *)

open StdLabels
open Gaux
open Gtk
open GtkBase
open GtkList
open GObj
open GContainer

class list_item obj = object
  inherit container (obj : Gtk.list_item obj)
  method event = new GObj.event_ops obj
  method as_item = obj
  method select () = Item.select obj
  method deselect () = Item.deselect obj
  method toggle () = Item.toggle obj
  method connect = new item_signals obj
end

let list_item ?label ?border_width ?width ?height ?packing ?(show=true) () =
  let w = ListItem.create ?label () in
  Container.set w ?border_width ?width ?height;
  let item = new list_item w in
  may packing ~f:(fun f -> (f item : unit));
  if show then item#misc#show ();
  item

class liste_signals obj = object
  inherit container_signals (obj : Gtk.liste obj)
  method selection_changed =
    GtkSignal.connect obj ~sgn:Liste.Signals.selection_changed ~after
  method select_child ~callback =
    GtkSignal.connect obj ~sgn:Liste.Signals.select_child ~after
      ~callback:(fun w -> callback (new list_item (ListItem.cast w))) 
  method unselect_child ~callback =
    GtkSignal.connect obj ~sgn:Liste.Signals.unselect_child ~after
      ~callback:(fun w -> callback (new list_item (ListItem.cast w))) 
end

class liste obj = object
  inherit [list_item] item_container (obj : Gtk.liste obj)
  method private wrap w = new list_item (ListItem.cast w)
  method connect = new liste_signals obj
  method insert w = Liste.insert_item obj w#as_item
  method clear_items = Liste.clear_items obj
  method select_item = Liste.select_item obj
  method unselect_item = Liste.unselect_item obj
  method child_position (w : list_item) = Liste.child_position obj w#as_item
end

let liste ?selection_mode ?border_width ?width ?height
    ?packing ?show () =
  let w = Liste.create () in
  may selection_mode ~f:(Liste.set_selection_mode w);
  Container.set w ?border_width ?width ?height;
  pack_return (new liste w) ~packing ~show

(* Cell lists *)

class clist_signals obj = object
  inherit container_signals obj
  method click_column =
    GtkSignal.connect ~sgn:CList.Signals.click_column obj ~after
  method select_row =
    GtkSignal.connect ~sgn:CList.Signals.select_row obj ~after
  method unselect_row =
    GtkSignal.connect ~sgn:CList.Signals.unselect_row obj ~after
  method scroll_vertical =
    GtkSignal.connect ~sgn:CList.Signals.scroll_vertical obj ~after
  method scroll_horizontal =
    GtkSignal.connect ~sgn:CList.Signals.scroll_horizontal obj ~after
end

class ['a] clist obj = object (self)
  inherit widget (obj : Gtk.clist obj)
  method set_border_width = Container.set_border_width obj
  method event = new GObj.event_ops obj
  method connect = new clist_signals obj
  method rows = CList.get_rows obj
  method columns = CList.get_columns obj
  method focus_row = CList.get_focus_row obj
  method hadjustment = new GData.adjustment (CList.get_hadjustment obj)
  method vadjustment = new GData.adjustment (CList.get_vadjustment obj)
  method set_button_actions = CList.set_button_actions obj
  method freeze () = CList.freeze obj
  method thaw () = CList.thaw obj
  method column_title = CList.get_column_title obj
  method column_widget col =
    new widget (CList.get_column_widget obj col)
  method columns_autosize () = CList.columns_autosize obj
  method optimal_column_width = CList.optimal_column_width obj
  method moveto ?(row_align=0.) ?(col_align=0.) row col =
    CList.moveto obj row col ~row_align ~col_align
  method row_is_visible = CList.row_is_visible obj
  method cell_type = CList.get_cell_type obj
  method cell_text = CList.get_text obj
  method cell_pixmap row col =
    let pm, mask = CList.get_pixmap obj row col in
    may_map pm ~f:(fun x -> new GDraw.pixmap ?mask x)
  method cell_style  row col =
    try Some (new style (CList.get_cell_style obj row col))
    with Gpointer.Null -> None
  method row_selectable row = CList.get_selectable obj ~row
  method row_style row =
    try Some (new style (CList.get_row_style obj ~row))
    with Gpointer.Null -> None
  method set_shift = CList.set_shift obj
  method insert ~row texts =
    let texts = List.map texts ~f:(fun x -> Some x) in
    CList.insert obj ~row texts
  method append = self#insert ~row:self#rows
  method prepend = self#insert ~row:0
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
  method set_hadjustment adj =
    CList.set_hadjustment obj (GData.as_adjustment adj)
  method set_vadjustment adj =
    CList.set_vadjustment obj (GData.as_adjustment adj)
  method set_shadow_type = CList.set_shadow_type obj
  method set_button_actions = CList.set_button_actions obj
  method set_selection_mode = CList.set_selection_mode obj
  method set_reorderable = CList.set_reorderable obj
  method set_use_drag_icons = CList.set_use_drag_icons obj
  method set_row_height = CList.set_row_height obj
  method set_titles_show = CList.set_titles_show obj
  method set_titles_active = CList.set_titles_active obj
  method set_sort = CList.set_sort obj
  method set_column ?widget =
    CList.set_column obj ?widget:(may_map widget ~f:as_widget)
  method set_row ?foreground ?background ?selectable ?style =
    let color = may_map ~f:(fun c -> Gpointer.optboxed (GDraw.optcolor c))
    and style = may_map ~f:(fun (st : style) -> st#as_style) style in
    CList.set_row obj
      ?foreground:(color foreground) ?background:(color background)
      ?selectable ?style
  method set_cell ?text ?pixmap ?spacing ?style =
    let pixmap, mask =
      match pixmap with None -> None, None
      | Some (pm : GDraw.pixmap) -> Some pm#pixmap, pm#mask
    and style = may_map ~f:(fun (st : style) -> st#as_style) style in
    CList.set_cell obj ?text ?pixmap ?mask ?spacing ?style
  method set_row_data n ~data =
    CList.set_row_data obj ~row:n (Obj.repr (data : 'a))
  method get_row_data n : 'a = Obj.obj (CList.get_row_data obj ~row:n)
  method scroll_vertical =
    CList.Signals.emit_scroll obj ~sgn:CList.Signals.scroll_vertical
  method scroll_horizontal =
    CList.Signals.emit_scroll obj ~sgn:CList.Signals.scroll_horizontal
  method get_row_state row = CList.get_row_state obj row
end

let clist_poly ?(columns=1) ?titles ?hadjustment ?vadjustment
    ?shadow_type ?button_actions ?selection_mode
    ?reorderable ?use_drag_icons ?row_height
    ?titles_show ?titles_active ?auto_sort ?sort_column ?sort_type
    ?border_width ?width ?height ?packing ?show () =
  let w =
    match titles with None -> CList.create ~cols:columns
    | Some titles -> CList.create_with_titles (Array.of_list titles)
  in
  CList.set w 
    ?hadjustment:(may_map ~f:GData.as_adjustment hadjustment)
    ?vadjustment:(may_map ~f:GData.as_adjustment vadjustment)
    ?shadow_type ?button_actions ?selection_mode ?reorderable
    ?use_drag_icons ?row_height ?titles_show ?titles_active;
  CList.set_sort w ?auto:auto_sort ?column:sort_column ?dir:sort_type ();
  Container.set w ?border_width ?width ?height;
  pack_return (new clist w) ~packing ~show

let clist = clist_poly

(* $Id$ *)

open Misc
open Gtk
open Tags
open GtkBase

module ListItem = struct
  let cast w : list_item obj =
    if Object.is_a w "GtkListItem" then Obj.magic w
    else invalid_arg "Gtk.ListItem.cast"
  external create : unit -> list_item obj = "ml_gtk_list_item_new"
  external create_with_label : string -> list_item obj
      = "ml_gtk_list_item_new_with_label"
  let create ?:label ?(_ : unit option) =
    match label with None -> create ()
    | Some label -> create_with_label label
end

module Liste = struct
  let cast w : liste obj =
    if Object.is_a w "GtkList" then Obj.magic w
    else invalid_arg "Gtk.GtkList.cast"
  external create : unit -> liste obj = "ml_gtk_list_new"
  external insert_item :
      [> list] obj -> [> listitem] obj -> pos:int -> unit
      = "ml_gtk_list_insert_item"
  let insert_items l wl :pos =
    let wl = if pos < 0 then wl else List.rev wl in
    List.iter wl fun:(insert_item l :pos)
  let append_items l = insert_items l pos:(-1)
  let prepend_items l = insert_items l pos:0
  external clear_items : [> list] obj -> start:int -> end:int -> unit =
    "ml_gtk_list_clear_items"
  external select_item : [> list] obj -> pos:int -> unit
      = "ml_gtk_list_select_item"
  external unselect_item : [> list] obj -> pos:int -> unit
      = "ml_gtk_list_unselect_item"
  external select_child : [> list] obj -> [> listitem] obj -> unit
      = "ml_gtk_list_select_child"
  external unselect_child : [> list] obj -> [> listitem] obj -> unit
      = "ml_gtk_list_unselect_child"
  external child_position : [> list] obj -> [> listitem] obj -> int
      = "ml_gtk_list_child_position"
  external set_selection_mode : [> list] obj -> selection_mode -> unit
      = "ml_gtk_list_set_selection_mode"
  let setter w :cont ?:selection_mode =
    may selection_mode fun:(set_selection_mode w);
    cont w
  module Signals = struct
    open GtkSignal
    let selection_changed : ([> list],_) t =
      { name = "selection_changed"; marshaller = marshal_unit }
    let select_child : ([> list],_) t =
      { name = "select_child"; marshaller = Widget.Signals.marshal }
    let unselect_child : ([> list],_) t =
      { name = "unselect_child"; marshaller = Widget.Signals.marshal }
  end
end

module CList = struct
  let cast w : clist obj =
    if Object.is_a w "GtkCList" then Obj.magic w
    else invalid_arg "Gtk.CList.cast"
  external create : cols:int -> clist obj = "ml_gtk_clist_new"
  external create_with_titles : string array -> clist obj
      = "ml_gtk_clist_new_with_titles"
  external get_rows : [> clist] obj -> int = "ml_gtk_clist_get_rows"
  external get_columns : [> clist] obj -> int = "ml_gtk_clist_get_columns"
  external set_hadjustment : [> clist] obj -> [> adjustment] obj -> unit
      = "ml_gtk_clist_set_hadjustment"
  external set_vadjustment : [> clist] obj -> [> adjustment] obj -> unit
      = "ml_gtk_clist_set_vadjustment"
  external get_hadjustment : [> clist] obj -> adjustment obj
      = "ml_gtk_clist_get_hadjustment"
  external get_vadjustment : [> clist] obj -> adjustment obj
      = "ml_gtk_clist_get_vadjustment"
  external set_shadow_type : [> clist] obj -> shadow_type -> unit
      = "ml_gtk_clist_set_shadow_type"
  external set_selection_mode : [> clist] obj -> selection_mode -> unit
      = "ml_gtk_clist_set_selection_mode"
  external set_reorderable : [> clist] obj -> bool -> unit
      = "ml_gtk_clist_set_reorderable"
  external set_use_drag_icons : [> clist] obj -> bool -> unit
      = "ml_gtk_clist_set_use_drag_icons"
  external set_button_actions :
      [> clist] obj -> int -> button_action list -> unit
      = "ml_gtk_clist_set_button_actions"
  external freeze : [> clist] obj -> unit = "ml_gtk_clist_freeze"
  external thaw : [> clist] obj -> unit = "ml_gtk_clist_thaw"
  external column_titles_show : [> clist] obj -> unit
      = "ml_gtk_clist_column_titles_show"
  external column_titles_hide : [> clist] obj -> unit
      = "ml_gtk_clist_column_titles_hide"
  external column_title_active : [> clist] obj -> int -> unit
      = "ml_gtk_clist_column_title_active"
  external column_title_passive : [> clist] obj -> int -> unit
      = "ml_gtk_clist_column_title_passive"
  external column_titles_active : [> clist] obj -> unit
      = "ml_gtk_clist_column_titles_active"
  external column_titles_passive : [> clist] obj -> unit
      = "ml_gtk_clist_column_titles_passive"
  external set_column_title : [> clist] obj -> int -> string -> unit
      = "ml_gtk_clist_set_column_title"
  external get_column_title : [> clist] obj -> int -> string
      = "ml_gtk_clist_get_column_title"
  external set_column_widget : [> clist] obj -> int -> [> widget] obj -> unit
      = "ml_gtk_clist_set_column_widget"
  external get_column_widget : [> clist] obj -> int -> widget obj
      = "ml_gtk_clist_get_column_widget"
  external set_column_justification :
      [> clist] obj -> int -> justification -> unit
      = "ml_gtk_clist_set_column_justification"
  external set_column_visibility : [> clist] obj -> int -> bool -> unit
      = "ml_gtk_clist_set_column_visibility"
  external set_column_resizeable : [> clist] obj -> int -> bool -> unit
      = "ml_gtk_clist_set_column_resizeable"
  external set_column_auto_resize : [> clist] obj -> int -> bool -> unit
      = "ml_gtk_clist_set_column_auto_resize"
  external columns_autosize : [> clist] obj -> unit
      = "ml_gtk_clist_columns_autosize"
  external optimal_column_width : [> clist] obj -> int -> int
      = "ml_gtk_clist_optimal_column_width"
  external set_column_width : [> clist] obj -> int -> int -> unit
      = "ml_gtk_clist_set_column_width"
  external set_column_min_width : [> clist] obj -> int -> int -> unit
      = "ml_gtk_clist_set_column_min_width"
  external set_column_max_width : [> clist] obj -> int -> int -> unit
      = "ml_gtk_clist_set_column_max_width"
  external set_row_height : [> clist] obj -> int -> unit
      = "ml_gtk_clist_set_row_height"
  external moveto :
      [> clist] obj ->
      int -> int -> row_align:clampf -> col_align:clampf -> unit
      = "ml_gtk_clist_moveto"
  external row_is_visible : [> clist] obj -> int -> visibility
      = "ml_gtk_clist_row_is_visible"
  external get_cell_type : [> clist] obj -> int -> int -> cell_type
      = "ml_gtk_clist_get_cell_type"
  external set_text : [> clist] obj -> int -> int -> optstring -> unit
      = "ml_gtk_clist_set_text"
  let set_text w row col ?:text = set_text w row col (optstring text)
  external get_text : [> clist] obj -> int -> int -> string
      = "ml_gtk_clist_get_text"
  external set_pixmap :
      [> clist] obj -> int -> int -> Gdk.pixmap -> Gdk.bitmap optboxed -> unit
      = "ml_gtk_clist_set_pixmap"
  let set_pixmap w row col :pixmap ?:mask =
    set_pixmap w row col pixmap (optboxed mask)
  external get_pixmap :
      [> clist] obj -> int -> int -> Gdk.pixmap * Gdk.bitmap option
      = "ml_gtk_clist_get_pixmap"
  external set_pixtext :
      [> clist] obj -> int -> int ->
      string -> int -> Gdk.pixmap -> Gdk.bitmap optboxed -> unit
      = "ml_gtk_clist_set_pixtext"
  let set_pixtext w row col :text :spacing :pixmap ?:mask =
    set_pixtext w row col text spacing pixmap (optboxed mask)
  external set_foreground : [> clist] obj -> row:int -> Gdk.Color.t -> unit
      = "ml_gtk_clist_set_foreground"
  external set_background : [> clist] obj -> row:int -> Gdk.Color.t -> unit
      = "ml_gtk_clist_set_background"
  external set_selectable : [> clist] obj -> row:int -> bool -> unit
      = "ml_gtk_clist_set_selectable"
  external get_selectable : [> clist] obj -> row:int -> bool
      = "ml_gtk_clist_get_selectable"
  external set_shift :
      [> clist] obj -> int -> int -> vertical:int -> horizontal:int -> unit
      = "ml_gtk_clist_set_shift"
  external insert : [> clist] obj -> int -> optstring array -> int
      = "ml_gtk_clist_insert"
  let insert w row ?:texts [< [] >] =
    let len = get_columns w in
    if List.length texts > len then invalid_arg "CList.insert";
    let arr = Array.create len:(get_columns w) fill:None in
    List.fold_left texts acc:0
      fun:(fun text :acc -> arr.(acc) <- text; acc+1);
    insert w row (Array.map fun:optstring arr)
  external remove : [> clist] obj -> int -> unit
      = "ml_gtk_clist_remove"
  external select : [> clist] obj -> int -> int -> unit
      = "ml_gtk_clist_select_row"
  external unselect : [> clist] obj -> int -> int -> unit
      = "ml_gtk_clist_unselect_row"
  external clear : [> clist] obj -> unit = "ml_gtk_clist_clear"
  external get_row_column : [> clist] obj -> x:int -> y:int -> int * int
      = "ml_gtk_clist_get_selection_info"
  external select_all : [> clist] obj -> unit = "ml_gtk_clist_select_all"
  external unselect_all : [> clist] obj -> unit = "ml_gtk_clist_unselect_all"
  external swap_rows : [> clist] obj -> int -> int -> unit
      = "ml_gtk_clist_swap_rows"
  external row_move : [> clist] obj -> int -> to:int -> unit
      = "ml_gtk_clist_row_move"
  external set_sort_column : [> clist] obj -> int -> unit
      = "ml_gtk_clist_set_sort_column"
  external set_sort_type : [> clist] obj -> sort_type -> unit
      = "ml_gtk_clist_set_sort_type"
  external sort : [> clist] obj -> unit
      = "ml_gtk_clist_sort"
  external set_auto_sort : [> clist] obj -> bool -> unit
      = "ml_gtk_clist_set_auto_sort"
  let set w ?:hadjustment ?:vadjustment ?:shadow_type ?:button_actions [< [] >]
      ?:selection_mode ?:reorderable ?:use_drag_icons ?:row_height =
    let may_set f param = may param fun:(f w) in
    may_set set_hadjustment hadjustment;
    may_set set_vadjustment vadjustment;
    may_set set_shadow_type shadow_type;
    List.iter button_actions fun:(fun (n,act) -> set_button_actions w n act);
    may_set set_selection_mode selection_mode;
    may_set set_reorderable reorderable;
    may_set set_use_drag_icons use_drag_icons;
    may_set set_row_height row_height
  let set_titles w ?:show ?:active =
    may show fun:
      (fun show ->
	if show then column_titles_show w else column_titles_hide w);
    may active fun:
      (fun active ->
	if active then column_titles_active w else column_titles_passive w)
  let set_sort w ?:auto ?:column ?type:sort_type =
    may auto fun:(set_auto_sort w);
    may column fun:(set_sort_column w);
    may sort_type fun:(set_sort_type w)
  let set_column w col ?:widget ?:title ?:title_active ?:justification
      ?:visibility ?:resizeable ?:auto_resize ?:width ?:min_width ?:max_width =
    let may_set f param = may param fun:(f w col) in
    may_set set_column_widget widget;
    may_set set_column_title title;
    may title_active
      fun:(fun active -> if active then column_title_active w col
                                   else column_title_passive w col);
    may_set set_column_justification justification;
    may_set set_column_visibility visibility;
    may_set set_column_resizeable resizeable;
    may_set set_column_auto_resize auto_resize;
    may_set set_column_width width;
    may_set set_column_max_width min_width;
    may_set set_column_max_width max_width
  let set_row w row ?:foreground ?:background ?:selectable =
    may foreground fun:(set_foreground w :row);
    may background fun:(set_background w :row);
    may selectable fun:(set_selectable w :row)
  module Signals = struct
    open GtkSignal
    let marshal_select f argv =
      let p = GtkArgv.get_pointer argv pos:2 in
      let event : Gdk.Event.Button.t = Gdk.Event.unsafe_copy p in
      f row:(GtkArgv.get_int argv pos:0)
	column:(GtkArgv.get_int argv pos:1) :event
    let select_row : ([> clist],_) t =
      { name = "select_row"; marshaller = marshal_select }
    let unselect_row : ([> clist],_) t =
      { name = "unselect_row"; marshaller = marshal_select }
    let click_column : ([> clist],_) t =
      { name = "unselect_row"; marshaller = marshal_int }
  end
end

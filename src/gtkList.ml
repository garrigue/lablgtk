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
  external set_selection_mode : [> clist] obj -> selection_mode -> unit
      = "ml_gtk_clist_set_selection_mode"
  let setter w :cont ?:selection_mode =
    may selection_mode fun:(set_selection_mode w);
    cont w
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
  external set_column_widget : [> clist] obj -> int -> [> widget] obj -> unit
      = "ml_gtk_clist_set_column_widget"
  external set_column_justification :
      [> clist] obj -> int -> justification -> unit
      = "ml_gtk_clist_set_column_justification"
  external set_column_width : [> clist] obj -> int -> int -> unit
      = "ml_gtk_clist_set_column_width"
  external set_row_height : [> clist] obj -> int -> unit
      = "ml_gtk_clist_set_row_height"
  external moveto :
      [> clist] obj ->
      int -> int -> row_align:clampf -> col_align:clampf -> unit
      = "ml_gtk_clist_moveto"
  external row_is_visible : [> clist] obj -> int -> visibility
      = "ml_gtk_clist_row_is_visible"
  type cell_type = [ EMPTY TEXT PIXMAP PIXTEXT WIDGET ]
  external get_cell_type : [> clist] obj -> int -> int -> cell_type
      = "ml_gtk_clist_get_cell_type"
  external set_text : [> clist] obj -> int -> int -> string -> unit
      = "ml_gtk_clist_set_text"
  external get_text : [> clist] obj -> int -> int -> string
      = "ml_gtk_clist_get_text"
  external set_pixmap :
      [> clist] obj -> int -> int -> Gdk.pixmap -> Gdk.bitmap -> unit
      = "ml_gtk_clist_set_pixmap"
  external get_pixmap : [> clist] obj -> int -> int -> Gdk.pixmap * Gdk.bitmap
      = "ml_gtk_clist_get_pixmap"
  external set_pixtext :
      [> clist] obj -> int -> int ->
      text:string -> spacing:int ->
      pixmap:Gdk.pixmap -> bitmap:Gdk.bitmap -> unit
      = "ml_gtk_clist_set_pixtext"
  type pixtext =
      { text: string; spacing: int; pixmap: Gdk.pixmap; bitmap: Gdk.bitmap }
  external get_pixtext : [> clist] obj -> int -> int -> pixtext
      = "ml_gtk_clist_get_pixtext"
  external set_foreground : [> clist] obj -> row:int -> Gdk.Color.t -> unit
      = "ml_gtk_clist_set_foreground"
  external set_background : [> clist] obj -> row:int -> Gdk.Color.t -> unit
      = "ml_gtk_clist_set_background"
  external set_shift :
      [> clist] obj -> int -> int -> vertical:int -> horizontal:int -> unit
      = "ml_gtk_clist_set_shift"
  external append : [> clist] obj -> string array -> int
      = "ml_gtk_clist_append"
  external insert : [> clist] obj -> int -> string array -> unit
      = "ml_gtk_clist_insert"
  external remove : [> clist] obj -> int -> unit
      = "ml_gtk_clist_remove"
  external select : [> clist] obj -> int -> int -> unit
      = "ml_gtk_clist_select_row"
  external unselect : [> clist] obj -> int -> int -> unit
      = "ml_gtk_clist_unselect_row"
  external clear : [> clist] obj -> unit = "ml_gtk_clist_clear"
  external get_row_column : [> clist] obj -> x:int -> y:int -> int * int
      = "ml_gtk_clist_get_selection_info"
  module Signals = struct
    open GtkSignal
    let marshal_select f argv =
      let p = GtkArgv.get_pointer argv pos:2 in
      let ev = Gdk.Event.unsafe_copy p in
      f row:(GtkArgv.get_int argv pos:0)
	column:(GtkArgv.get_pointer argv pos:1) ev
    let select_row : ([> clist],_) t =
      { name = "select_row"; marshaller = marshal_select }
    let unselect_row : ([> clist],_) t =
      { name = "unselect_row"; marshaller = marshal_select }
    let click_column : ([> clist],_) t =
      { name = "unselect_row"; marshaller = marshal_int }
  end
end

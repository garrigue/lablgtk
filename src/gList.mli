(* $Id$ *)

open Gtk
open GObj
open GContainer

class list_item : Gtk.list_item obj ->
  object
    inherit container
    val obj : Gtk.list_item obj
    method event : event_ops
    method as_item : Gtk.list_item obj
    method connect : item_signals
    method deselect : unit -> unit
    method select : unit -> unit
    method toggle : unit -> unit
  end
val list_item :
  ?label:string ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(list_item -> unit) -> ?show:bool -> unit -> list_item

class liste : Gtk.liste obj ->
  object
    inherit [list_item] item_container
    val obj : Gtk.liste obj
    method child_position : list_item -> int
    method clear_items : start:int -> stop:int -> unit
    method insert : list_item -> pos:int -> unit
    method select_item : pos:int -> unit
    method unselect_item : pos:int -> unit
    method private wrap : Gtk.widget obj -> list_item
  end
val liste :
  ?selection_mode:Tags.selection_mode ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> liste

class clist_signals : 'a obj ->
  object
    inherit container_signals
    constraint 'a = [>`clist|`container|`widget]
    val obj : 'a obj
    method click_column : callback:(int -> unit) -> GtkSignal.id
    method select_row :
      callback:(row:int ->
                column:int -> event:GdkEvent.Button.t option -> unit) ->
      GtkSignal.id
    method unselect_row :
      callback:(row:int ->
                column:int -> event:GdkEvent.Button.t option -> unit) ->
      GtkSignal.id
    method scroll_horizontal :
      callback:(Tags.scroll_type -> pos:clampf -> unit) -> GtkSignal.id
    method scroll_vertical :
      callback:(Tags.scroll_type -> pos:clampf -> unit) -> GtkSignal.id
  end

class ['a] clist : Gtk.clist obj ->
  object
    inherit widget
    val obj : Gtk.clist obj
    method event : event_ops
    method append : string list -> int
    method cell_pixmap : int -> int -> GDraw.pixmap option
    method cell_style : int -> int -> style option
    method cell_text : int -> int -> string
    method cell_type : int -> int -> Tags.cell_type
    method clear : unit -> unit
    method column_title : int -> string
    method column_widget : int -> widget
    method columns : int
    method columns_autosize : unit -> unit
    method connect : clist_signals
    method focus_row : int
    method freeze : unit -> unit
    method get_row_column : x:int -> y:int -> int * int
    method get_row_data : int -> 'a
    method hadjustment : GData.adjustment
    method insert : row:int -> string list -> int
    method moveto :
      ?row_align:clampf -> ?col_align:clampf -> int -> int -> unit
    method optimal_column_width : int -> int
    method prepend : string list -> int
    method remove : row:int -> unit
    method row_is_visible : int -> Tags.visibility
    method row_move : int -> dst:int -> unit
    method row_selectable : int -> bool
    method row_style : int -> style option
    method rows : int
    method scroll_vertical : Tags.scroll_type -> pos:clampf -> unit
    method scroll_horizontal : Tags.scroll_type -> pos:clampf -> unit
    method select : int -> int -> unit
    method select_all : unit -> unit
    method set_border_width : int -> unit
    method set_button_actions : int -> Tags.button_action list -> unit
    method set_cell :
      ?text:string ->
      ?pixmap:GDraw.pixmap ->
      ?spacing:int -> ?style:style -> int -> int -> unit
    method set_column :
      ?widget:widget ->
      ?title:string ->
      ?title_active:bool ->
      ?justification:Tags.justification ->
      ?visibility:bool ->
      ?resizeable:bool ->
      ?auto_resize:bool ->
      ?width:int -> ?min_width:int -> ?max_width:int -> int -> unit
    method set_hadjustment : GData.adjustment -> unit
    method set_reorderable : bool -> unit
    method set_row :
      ?foreground:GDraw.optcolor ->
      ?background:GDraw.optcolor ->
      ?selectable:bool ->
      ?style:style -> int -> unit
    method set_row_data : int -> data:'a -> unit
    method set_row_height : int -> unit
    method set_selection_mode : Tags.selection_mode -> unit
    method set_shadow_type : Tags.shadow_type -> unit
    method set_shift : int -> int -> vertical:int -> horizontal:int -> unit
    method set_sort :
      ?auto:bool -> ?column:int -> ?dir:Tags.sort_type -> unit -> unit
    method set_titles_active : bool -> unit
    method set_titles_show : bool -> unit
    method set_use_drag_icons : bool -> unit
    method set_vadjustment : GData.adjustment -> unit
    method sort : unit -> unit
    method swap_rows : int -> int -> unit
    method thaw : unit -> unit
    method unselect : int -> int -> unit
    method unselect_all : unit -> unit
    method vadjustment : GData.adjustment
  end
val clist :
  ?columns:int ->
  ?titles:string list ->
  ?hadjustment:GData.adjustment ->
  ?vadjustment:GData.adjustment ->
  ?shadow_type:Tags.shadow_type ->
  ?button_actions:(int * Tags.button_action list) list ->
  ?selection_mode:Tags.selection_mode ->
  ?reorderable:bool ->
  ?use_drag_icons:bool ->
  ?row_height:int ->
  ?titles_show:bool ->
  ?titles_active:bool ->
  ?auto_sort:bool ->
  ?sort_column:int ->
  ?sort_type:Tags.sort_type ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> 'a clist

(* $Id$ *)

open Gtk

class list_item :
  ?label:string ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(list_item -> unit) -> ?show:bool ->
  object
    inherit GContainer.container
    val obj : Gtk.list_item obj
    method add_events : Gdk.Tags.event_mask list -> unit
    method as_item : Gtk.list_item obj
    method connect : ?after:bool -> GContainer.item_signals
    method deselect : unit -> unit
    method select : unit -> unit
    method toggle : unit -> unit
  end
class list_item_wrapper : Gtk.list_item obj -> list_item

class liste :
  ?selection_mode:Tags.selection_mode ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(liste -> unit) -> ?show:bool ->
  object
    inherit [Gtk.list_item,list_item] GContainer.item_container
    val obj : Gtk.liste obj
    method child_position : Gtk.list_item #GObj.is_item -> int
    method clear_items : start:int -> end:int -> unit
    method insert : Gtk.list_item #GObj.is_item -> pos:int -> unit
    method select_item : pos:int -> unit
    method unselect_item : pos:int -> unit
    method private wrap : Gtk.widget obj -> list_item
  end
class liste_wrapper : Gtk.liste obj -> liste

class clist_signals :
  'a[> clist container widget] obj -> ?after:bool ->
  object
    inherit GContainer.container_signals
    val obj : 'a obj
    method click_column : callback:(int -> unit) -> GtkSignal.id
    method select_row :
      callback:(row:int -> column:int -> event:GdkEvent.Button.t -> unit) ->
      GtkSignal.id
     method unselect_row :
      callback:(row:int -> column:int -> event:GdkEvent.Button.t -> unit) ->
      GtkSignal.id
   end

class clist :
  ?columns:int ->
  ?titles:string list ->
  ?hadjustment:GData.adjustment ->
  ?vadjustment:GData.adjustment ->
  ?shadow_type:Gtk.Tags.shadow_type ->
  ?button_actions:(int * Tags.button_action list) list ->
  ?selection_mode:Tags.selection_mode ->
  ?reorderable:bool ->
  ?use_drag_icons:bool ->
  ?row_height:int ->
  ?titles_show:bool ->
  ?titles_active:bool ->
  ?auto_sort:bool ->
  ?sort_column:int ->
  ?sort_type:Gtk.Tags.sort_type ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(clist -> unit) -> ?show:bool ->
  object
    inherit GObj.widget
    val obj : Gtk.clist obj
    method add_events : Gdk.Tags.event_mask list -> unit
    method append : string list -> int
    method cell_pixmap : int -> int -> GdkObj.pixmap
    method cell_text : int -> int -> string
    method cell_type : int -> int -> Tags.cell_type
    method clear : unit -> unit
    method column_title : int -> string
    method column_widget : int -> GObj.widget_wrapper
    method columns : int
    method columns_autosize : unit -> unit
    method connect : ?after:bool -> clist_signals
    method freeze : unit -> unit
    method get_row_column : x:int -> y:int -> int * int
    method hadjustment : GData.adjustment_wrapper
    method insert : row:int -> string list -> int
    method moveto :
      int -> int -> ?row_align:clampf -> ?col_align:clampf -> unit
    method optimal_column_width : int -> int
    method prepend : string list -> int
    method remove : int -> unit
    method row_is_visible : int -> Tags.visibility
    method row_move : int -> to:int -> unit
    method row_selectable : row:int -> bool
    method rows : int
    method select : int -> int -> unit
    method select_all : unit -> unit
    method set_button_actions : int -> Tags.button_action list -> unit
    method set_cell :
      int ->
      int -> ?text:string -> ?pixmap:#GdkObj.pixmap -> ?spacing:int -> unit
    method set_clist :
      ?hadjustment:GData.adjustment ->
      ?vadjustment:GData.adjustment ->
      ?shadow_type:Tags.shadow_type ->
      ?button_actions:(int * Tags.button_action list) list ->
      ?selection_mode:Tags.selection_mode ->
      ?reorderable:bool -> ?use_drag_icons:bool -> ?row_height:int -> unit
    method set_column :
      int ->
      ?widget:#GObj.is_widget ->
      ?title:string ->
      ?title_active:bool ->
      ?justification:Tags.justification ->
      ?visibility:bool ->
      ?resizeable:bool ->
      ?auto_resize:bool ->
      ?width:int -> ?min_width:int -> ?max_width:int -> unit
    method set_row :
      int ->
      ?foreground:Gdk.Color.t ->
      ?background:Gdk.Color.t -> ?selectable:bool -> unit
    method set_shift : int -> int -> vertical:int -> horizontal:int -> unit
    method set_size : ?border:int -> ?width:int -> ?height:int -> unit
    method set_sort : ?auto:bool -> ?column:int -> ?type:Tags.sort_type -> unit
    method set_titles : ?show:bool -> ?active:bool -> unit
    method sort : unit -> unit
    method swap_rows : int -> int -> unit
    method thaw : unit -> unit
    method unselect : int -> int -> unit
    method unselect_all : unit -> unit
    method vadjustment : GData.adjustment_wrapper
  end

class clist_wrapper : Gtk.clist obj -> clist

(* $Id$ *)

open Misc

exception Error of string
let _ = Callback.register_exception "gdkerror" (Error"")

type 'a obj

module Tags = struct
  type state = [ NORMAL ACTIVE PRELIGHT SELECTED INSENSITIVE ] 
  type window_type = [ TOPLEVEL DIALOG POPUP ]
  type direction = [ TAB_FORWARD TAB_BACKWARD UP DOWN LEFT RIGHT ]
  type shadow = [ NONE IN OUT ETCHED_IN ETCHED_OUT ]
  type arrow = [ UP DOWN LEFT RIGHT ]
  type pack_type = [ START END ]
  type policy = [ ALWAYS AUTOMATIC ]
  type update = [ CONTINUOUS DISCONTINUOUS DELAYED ]
  type attach = [ EXPAND SHRINK FILL ]
  type signal_run = [ FIRST LAST BOTH MASK NO_RECURSE ]
  type window_position = [ NONE CENTER MOUSE ]
  type submenu_direction = [ LEFT RIGHT ]
  type submenu_placement = [ TOP_BOTTOM LEFT_RIGHT ]
  type menu_factory = [ MENU MENU_BAR OPTION_MENU ]
  type metric = [ PIXELS INCHES CENTIMETERS ]
  type scroll =
      [ NONE STEP_FORWARD STEP_BACKWARD PAGE_BACKWARD PAGE_FORWARD JUMP ]
  type through = [ NONE START END JUMP ]
  type position = [ LEFT RIGHT TOP BOTTOM ]
  type preview = [ COLOR GRAYSCALE ]
  type justification = [ LEFT RIGHT CENTER FILL ]
  type selection = [ SINGLE BROWSE MULTIPLE EXTENDED ]
  type orientation = [ HORIZONTAL VERTICAL ]
  type toolbar_style = [ ICONS TEXT BOTH ]
  type visibility = [ NONE PARTIAL FULL ]
end
open Tags

module AcceleratorTable = struct
  type t
  external create : unit -> t = "ml_gtk_accelerator_table_new"
end

module Type = struct
  type t
  type klass
  external name : t -> string = "ml_gtk_type_name"
  external from_name : string -> t = "ml_gtk_type_from_name"
  external parent : t -> t = "ml_gtk_type_parent"
  external get_class : t -> klass = "ml_gtk_type_class"
  external parent_class : t -> klass = "ml_gtk_type_parent_class"
  external is_a : t -> t -> bool = "ml_gtk_type_is_a"
end

module Object = struct
  external get_type : 'a obj -> Type.t = "ml_gtk_object_type"
end

module Adjustment = struct
  type t = [ajustment] obj
  external create :
      value:float -> lower:float -> upper:float ->
      step_incr:float -> page_incr:float -> page_size:float -> t
      = "ml_gtk_adjustment_new_bc" "ml_gtk_adjustment_new"
  external set_value : [> adjustment] obj -> float -> unit
      = "ml_gtk_adjustment_set_value"
  external clamp_page :
      [> adjustment] obj -> lower:float -> upper:float -> unit
      = "ml_gtk_adjustment_clamp_page"
end

module Widget = struct
  type t = [widget] obj
  external destroy : [> widget] obj -> unit = "ml_gtk_widget_destroy"
  external unparent : [> widget] obj -> unit = "ml_gtk_widget_unparent"
  external show : [> widget] obj -> unit = "ml_gtk_widget_show"
  external show_now : [> widget] obj -> unit = "ml_gtk_widget_show_now"
  external show_all : [> widget] obj -> unit = "ml_gtk_widget_show_all"
  external hide : [> widget] obj -> unit = "ml_gtk_widget_hide"
  external hide_all : [> widget] obj -> unit = "ml_gtk_widget_hide_all"
  external map : [> widget] obj -> unit = "ml_gtk_widget_map"
  external unmap : [> widget] obj -> unit = "ml_gtk_widget_unmap"
  external realize : [> widget] obj -> unit = "ml_gtk_widget_realize"
  external unrealize : [> widget] obj -> unit = "ml_gtk_widget_unrealize"
  external queue_draw : [> widget] obj -> unit = "ml_gtk_widget_queue_draw"
  external queue_resize : [> widget] obj -> unit = "ml_gtk_widget_queue_resize"
  external draw : [> widget] obj -> Gdk.Rectangle.t -> unit
      = "ml_gtk_widget_draw"
  external draw_focus : [> widget] obj -> unit
      = "ml_gtk_widget_draw_focus"
  external draw_default : [> widget] obj -> unit
      = "ml_gtk_widget_draw_default"
  external draw_children : [> widget] obj -> unit
      = "ml_gtk_widget_draw_children"
  external event : [> widget] obj -> Gdk.Event.t -> unit
      = "ml_gtk_widget_event"
  external activate : [> widget] obj -> unit
      = "ml_gtk_widget_activate"
  external reparent : [> widget] obj -> [> widget] obj -> unit
      = "ml_gtk_widget_reparent"
  external popup : [> widget] obj -> x:int -> y:int -> unit
      = "ml_gtk_widget_popup"
  external intersect :
      [> widget] obj -> Gdk.Rectangle.t -> Gdk.Rectangle.t option
      = "ml_gtk_widget_intersect"
  external basic : [> widget] obj -> bool
      = "ml_gtk_widget_basic"
  external grab_focus : [> widget] obj -> unit
      = "ml_gtk_widget_grab_focus"
  external grab_default : [> widget] obj -> unit
      = "ml_gtk_widget_grab_default"
  external set_name : [> widget] obj -> string -> unit
      = "ml_gtk_widget_set_name"
  external get_name : [> widget] obj -> string
      = "ml_gtk_widget_get_name"
  external set_state : [> widget] obj -> state -> unit
      = "ml_gtk_widget_set_state"
  external set_sensitive : [> widget] obj -> bool -> unit
      = "ml_gtk_widget_set_sensitive"
  external set_uposition : [> widget] obj -> x:int -> y:int -> unit
      = "ml_gtk_widget_set_uposition"
  external set_usize : [> widget] obj -> width:int -> height:int -> unit
      = "ml_gtk_widget_set_usize"
  external get_toplevel : [> widget] obj -> t
      = "ml_gtk_widget_get_toplevel"
  external get_ancestor : [> widget] obj -> Type.t -> t
      = "ml_gtk_widget_get_ancestor"
  external get_colormap : [> widget] obj -> Gdk.colormap
      = "ml_gtk_widget_get_colormap"
  external get_visual : [> widget] obj -> Gdk.visual
      = "ml_gtk_widget_get_visual"
  external get_pointer : [> widget] obj -> int * int
      = "ml_gtk_widget_get_pointer"
  external is_ancestor : [> widget] obj -> [> widget] obj -> bool
      = "ml_gtk_widget_is_ancestor"
  external is_child : [> widget] obj -> [> widget] obj -> bool
      = "ml_gtk_widget_is_ancestor"
end

module Container = struct
  type t = [widget container] obj
  external border_width : [> container] obj -> int -> unit
      = "ml_gtk_container_border_width"
  external add : [> container] obj -> [> widget] obj -> unit
      = "ml_gtk_container_add"
  external remove : [> container] obj -> [> widget] obj -> unit
      = "ml_gtk_container_remove"
  external disable_resize : [> container] obj -> unit
      = "ml_gtk_container_disable_resize"
  external enable_resize : [> container] obj -> unit
      = "ml_gtk_container_enable_resize"
  external block_resize : [> container] obj -> unit
      = "ml_gtk_container_block_resize"
  external unblock_resize : [> container] obj -> unit
      = "ml_gtk_container_unblock_resize"
  external need_resize : [> container] obj -> bool
      = "ml_gtk_container_need_resize"
  external foreach : [> container] obj -> fun:(Widget.t -> unit) -> unit
      = "ml_gtk_container_foreach"
  let children w =
    let l = ref [] in
    foreach w fun:(push on:l);
    List.rev !l
  external focus : [> container] obj -> direction -> bool
      = "ml_gtk_container_focus"
  external set_focus_child : [> container] obj -> [> widget] obj -> unit
      = "ml_gtk_container_set_focus_child"
  external set_focus_vadjustment :
      [> container] obj -> [> adjustment] obj -> bool
      = "ml_gtk_container_set_focus_vadjustment"
  external set_focus_hadjustment :
      [> container] obj -> [> adjustment] obj -> bool
      = "ml_gtk_container_set_focus_hadjustment"
  let set_focus w ?:child ?:vadjustment ?:hadjustment =
    may child fun:(set_focus_child w);
    may vadjustment fun:(set_focus_vadjustment w);
    may hadjustment fun:(set_focus_hadjustment w);
    ()
end

module Window = struct
  type t = [widget container bin window] obj
  external create : window_type -> t = "ml_gtk_window_new"
  external set_title : [> window] obj -> string -> unit
      = "ml_gtk_window_set_title"
  external set_wmclass : [> window] obj -> name:string -> class:string -> unit
      = "ml_gtk_window_set_title"
  external set_focus : [> window] obj -> [> widget] obj -> unit
      = "ml_gtk_window_set_focus"
  external set_default : [> window] obj -> [> widget] obj -> unit
      = "ml_gtk_window_set_default"
  external set_policy :
      [> window] obj ->
      allow_shrink:bool -> allow_grow:bool -> auto_shrink:bool -> unit
      = "ml_gtk_window_set_policy"
  external add_accelerator_table : [> window] obj -> AcceleratorTable.t -> unit
      = "ml_gtk_window_add_accelerator_table"
  external remove_accelerator_table :
      [> window] obj -> AcceleratorTable.t -> unit
      = "ml_gtk_window_remove_accelerator_table"
  external activate_focus : [> window] obj -> unit
      = "ml_gtk_window_activate_focus"
  external activate_default : [> window] obj -> unit
      = "ml_gtk_window_activate_default"
end

module Box = struct
  type t = [widget container box] obj
  external pack_start :
      [> box] obj -> [> widget] obj ->
      expand:bool -> fill:bool -> padding:int -> unit
      = "ml_gtk_box_pack_start"
  external pack_end :
      [> box] obj -> [> widget] obj ->
      expand:bool -> fill:bool -> padding:int -> unit
      = "ml_gtk_box_pack_end"
  let pack box child ?from:dir [< (`START : pack_type) >]
      ?:expand [< true >] ?:fill [< true >] ?:padding [< 0 >] =
    (match dir with `START -> pack_start | `END -> pack_end)
      box child :expand :fill :padding
  external set_homogeneous : [> box] obj -> bool -> unit
      = "ml_gtk_box_set_homogeneous"
  external set_spacing : [> box] obj -> int -> unit
      = "ml_gtk_box_set_spacing"
  type packing =
      { expand: bool; fill: bool; padding: int; pack_type: pack_type }
  external query_child_packing : [> box] obj -> [> widget] obj -> packing
      = "ml_gtk_box_query_child_packing"
  external set_child_packing :
      [> box] obj -> [> widget] obj ->
      ?expand:bool -> ?fill:bool -> ?padding:int -> ?from:pack_type -> unit
      = "ml_gtk_box_set_child_packing_bc" "ml_gtk_box_set_child_packing"
end

module Button = struct
  type t = [widget container button] obj
  external create : unit -> t = "ml_gtk_button_new"
  external create_with_label : string -> t = "ml_gtk_button_new_with_label"
  external pressed : [> button] obj -> unit = "ml_gtk_button_pressed"
  external released : [> button] obj -> unit = "ml_gtk_button_released"
  external clicked : [> button] obj -> unit = "ml_gtk_button_clicked"
  external enter : [> button] obj -> unit = "ml_gtk_button_enter"
  external leave : [> button] obj -> unit = "ml_gtk_button_leave"
end

module Main = struct
  external init : string array -> string array = "ml_gtk_init"
  external exit : int -> unit = "ml_gtk_exit"
  external set_locale : unit -> string = "ml_gtk_set_locale"
  external main : unit -> unit = "ml_gtk_main"
  external quit : unit -> unit = "ml_gtk_main_quit"
  external grab_add : [> widget] obj -> unit = "ml_gtk_grab_add"
  external grab_remove : [> widget] obj -> unit = "ml_gtk_grab_remove"
  external grab_get_current : unit -> Widget.t = "ml_gtk_grab_get_current"
  external get_version : unit -> int * int * int = "ml_gtk_get_version"
end

module Arg = struct
  type pointer
  type t =
      Invalid
    | Unit
    | Char of char
    | Bool of bool
    | Int of int
    | Float of float
    | String of string
    | Enum of int
    | Flags of int
    | Boxed of pointer
    | Pointer of pointer
    | Object of unit obj
end

module Signal = struct
  type cb_id
  external connect :
      'a obj -> name:string -> cb:(Arg.t list -> Arg.t) -> after:bool -> cb_id
      = "ml_gtk_signal_connect"
  let connect obj :name :cb ?:after [< false >] =
    connect obj :name :cb :after
  external disconnect : 'a obj -> cb_id -> unit
      = "ml_gtk_signal_disconnect"
end

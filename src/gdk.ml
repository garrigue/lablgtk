(* $Id$ *)

open Misc

type colormap
type visual
type gc
type 'a drawable
type window = [window] drawable
type pixmap = [pixmap] drawable
type bitmap = [bitmap] drawable
type font
type image
type atom = int
type 'a event

exception Error of string
let _ = Callback.register_exception "gdkerror" (Error"")

module Tags = struct
  type event_type =
    [ NOTHING DELETE DESTROY EXPOSE MOTION_NOTIFY BUTTON_PRESS
      TWO_BUTTON_PRESS THREE_BUTTON_PRESS
      BUTTON_RELEASE KEY_PRESS
      KEY_RELEASE ENTER_NOTIFY LEAVE_NOTIFY FOCUS_CHANGE
      CONFIGURE MAP UNMAP PROPERTY_NOTIFY SELECTION_CLEAR
      SELECTION_REQUEST SELECTION_NOTIFY PROXIMITY_IN
      PROXIMITY_OUT DRAG_ENTER DRAG_LEAVE DRAG_MOTION DRAG_STATUS
      DROP_START DROP_FINISHED CLIENT_EVENT VISIBILITY_NOTIFY
      NO_EXPOSE ]

  type event_mask =
    [ EXPOSURE
      POINTER_MOTION POINTER_MOTION_HINT
      BUTTON_MOTION BUTTON1_MOTION BUTTON2_MOTION BUTTON3_MOTION
      BUTTON_PRESS BUTTON_RELEASE
      KEY_PRESS KEY_RELEASE
      ENTER_NOTIFY LEAVE_NOTIFY FOCUS_CHANGE
      STRUCTURE PROPERTY_CHANGE VISIBILITY_NOTIFY
      PROXIMITY_IN PROXIMITY_OUT SUBSTRUCTURE
      ALL_EVENTS ]

  type extension_events =
    [ NONE ALL CURSOR ]

  type visibility_state =
    [ UNOBSCURED PARTIAL FULLY_OBSCURED ]

  type input_source =
    [ MOUSE PEN ERASER CURSOR ]

  type notify_type =
    [ ANCESTOR VIRTUAL INFERIOR NONLINEAR NONLINEAR_VIRTUAL UNKNOWN ] 

  type crossing_mode =
    [ NORMAL GRAB UNGRAB ]

  type modifier =
    [ SHIFT LOCK CONTROL MOD1 MOD2 MOD3 MOD4 MOD5 BUTTON1
      BUTTON2 BUTTON3 BUTTON4 BUTTON5 ]
end
open Tags

module Color = struct
  type t

  external color_white : colormap -> t = "ml_gdk_color_white"
  external color_black : colormap -> t = "ml_gdk_color_black"
  external color_parse : string -> t = "ml_gdk_color_parse"
  external color_alloc : colormap -> t -> bool = "ml_gdk_color_alloc"
  external color_create : red:int -> green:int -> blue:int -> t
      = "ml_GdkColor"

  external get_system_colormap : unit -> colormap
      = "ml_gdk_colormap_get_system"
  type spec = [BLACK NAME(string) RGB(int * int * int) WHITE]
  let alloc color ?:colormap [< get_system_colormap () >] =
    match color with
      `WHITE -> color_white colormap
    | `BLACK -> color_black colormap
    | `NAME _|`RGB _ as c ->
	let color =
	  match c with `NAME s -> color_parse s
	  | `RGB (red,green,blue) -> color_create :red :green :blue
	in
	if not (color_alloc colormap color) then raise (Error"Color.alloc");
	color

  external red : t -> int = "ml_GdkColor_red"
  external blue : t -> int = "ml_GdkColor_green"
  external green : t -> int = "ml_GdkColor_blue"
  external pixel : t -> int = "ml_GdkColor_pixel"
end

module Rectangle = struct
  type t
  external create : x:int -> y:int -> width:int -> height:int -> t
      = "ml_GdkRectangle"
  external x : t -> int = "ml_GdkRectangle_x"
  external y : t -> int = "ml_GdkRectangle_y"
  external width : t -> int = "ml_GdkRectangle_width"
  external height : t -> int = "ml_GdkRectangle_height"
end

module Window = struct
  external visual_depth : visual -> int = "ml_gdk_visual_get_depth"
  external get_visual : window -> visual = "ml_gdk_window_get_visual"
end

module GC = struct
  type gdkFunction = [ COPY INVERT XOR ]
  type gdkFill = [ SOLID TILED STIPPLED OPAQUE_STIPPLED ]
  type gdkSubwindowMode = [ CLIP_BY_CHILDREN INCLUDE_INFERIORS ]
  type gdkLineStyle = [ SOLID ON_OFF_DASH DOUBLE_DASH ]
  type gdkCapStyle = [ NOT_LAST BUTT ROUND PROJECTING ]
  type gdkJoinStyle = [ MITER ROUND BEVEL ]
  external create : 'a drawable -> gc = "ml_gdk_gc_new"
  external set_foreground : gc -> Color.t -> unit = "ml_gdk_gc_set_foreground"
  external set_background : gc -> Color.t -> unit = "ml_gdk_gc_set_background"
  external set_font : gc -> font -> unit = "ml_gdk_gc_set_font"
  external set_function : gc -> gdkFunction -> unit = "ml_gdk_gc_set_function"
  external set_fill : gc -> gdkFill -> unit = "ml_gdk_gc_set_fill"
  external set_tile : gc -> pixmap -> unit = "ml_gdk_gc_set_tile"
  external set_stipple : gc -> pixmap -> unit = "ml_gdk_gc_set_stipple"
  external set_ts_origin : gc -> x:int -> y:int -> unit
      = "ml_gdk_gc_set_ts_origin"
  external set_clip_origin : gc -> x:int -> y:int -> unit
      = "ml_gdk_gc_set_clip_origin"
  external set_clip_mask : gc -> bitmap -> unit = "ml_gdk_gc_set_clip_mask"
  external set_clip_rectangle : gc -> Rectangle.t -> unit
      = "ml_gdk_gc_set_clip_rectangle"
  external set_subwindow : gc -> gdkSubwindowMode -> unit
      = "ml_gdk_gc_set_subwindow"
  external set_exposures : gc -> bool -> unit = "ml_gdk_gc_set_exposures"
  external set_line_attributes :
      gc -> width:int -> style:gdkLineStyle -> cap:gdkCapStyle ->
      join:gdkJoinStyle -> unit
      = "ml_gdk_gc_set_line_attributes"
  external copy : to:gc -> gc -> unit = "ml_gdk_gc_copy"
end

module Pixmap = struct
  external create : window -> width:int -> height:int -> depth:int -> pixmap
      = "ml_gdk_pixmap_new"
  external create_from_data :
      window -> string -> width:int -> height:int -> depth:int ->
      fg:Color.t -> bg:Color.t -> pixmap
      = "ml_gdk_pixmap_create_from_data_bc" "ml_gk_pixmap_create_from_data"
  external create_from_xpm :
      window -> ?:colormap -> ?transparent:Color.t ->
      file:string -> pixmap * bitmap
      = "ml_gdk_pixmap_colormap_create_from_xpm"
  external create_from_xpm_d :
      window -> ?:colormap -> ?transparent:Color.t ->
      data:string array -> pixmap * bitmap
      = "ml_gdk_pixmap_colormap_create_from_xpm_d"
end

module Bitmap = struct
  let create : window -> width:int -> height:int -> bitmap =
    Obj.magic (Pixmap.create depth:1)
  external create_from_data :
      window -> string -> width:int -> height:int -> bitmap
      = "ml_gdk_bitmap_create_from_data"
end

module Font = struct
  external load : string -> font = "ml_gdk_font_load"
  external load_fontset : string -> font = "ml_gdk_fontset_load"
  external string_width : font -> string -> int = "ml_gdk_string_width"
  external char_width : font -> char -> int = "ml_gdk_char_width"
  external string_measure : font -> string -> int = "ml_gdk_string_measure"
  external char_measure : font -> char -> int = "ml_gdk_char_measure"
end

module PointArray = struct
  type t = { len: int}
  external create : len:int -> t = "ml_point_array_new"
  external set : t -> pos:int -> x:int -> y:int -> unit = "ml_point_array_set"
  let set arr :pos =
    if pos < 0 || pos >= arr.len then invalid_arg "PointArray.set";
    set arr :pos
end

module Draw = struct
  external point : 'a drawable -> gc -> x:int -> y:int -> unit
      = "ml_gdk_draw_point"
  external line : 'a drawable -> gc -> x:int -> y:int -> x:int -> y:int -> unit
      = "ml_gdk_draw_line_bc" "ml_gdk_draw_line"
  external rectangle :
      'a drawable -> gc ->
      filled:bool -> x:int -> y:int -> width:int -> height:int -> unit
      = "ml_gdk_draw_rectangle_bc" "ml_gdk_draw_rectangle"
  let rectangle w gc :x :y :width :height ?:filled [< false >] =
    rectangle w gc :x :y :width :height :filled
  external arc :
      'a drawable -> gc -> filled:bool -> x:int -> y:int ->
      width:int -> height:int -> start:int -> angle:int -> unit
      = "ml_gdk_draw_arc_bc" "ml_gdk_draw_arc"
  let arc w gc :x :y :width :height ?:filled [< false >] ?:start [< 0.0 >]
      ?:angle [< 360.0 >] =
    arc w gc :x :y :width :height :filled
      start:(truncate(start *. 64.))
      angle:(truncate(angle *. 64.))
  external polygon : 'a drawable -> gc -> filled:bool -> PointArray.t -> unit
      = "ml_gdk_draw_polygon"
  let polygon w gc l ?:filled [< false >] =
    let len = List.length l in
    let arr = PointArray.create :len in
    List.fold_left l acc:0
      fun:(fun (x,y) acc:pos -> PointArray.set arr :pos :x :y; pos+1);
    polygon w gc :filled arr
  external string : 'a drawable -> font: font -> gc -> x: int -> y: int -> 
    string: string -> unit
      = "ml_gdk_draw_string_bc" "ml_gdk_draw_string"	
end

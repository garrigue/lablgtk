(* $Id$ *)

open Misc

type colormap
type visual
type gc
type 'a drawable
type window = [`window] drawable
type pixmap = [`pixmap] drawable
type bitmap = [`bitmap] drawable
type font
type image
type atom = int
type keysym = int
type 'a event
type drag_context

exception Error of string
let _ = Callback.register_exception "gdkerror" (Error"")

module Tags = struct
  type event_type =
    [ `NOTHING|`DELETE|`DESTROY|`EXPOSE|`MOTION_NOTIFY|`BUTTON_PRESS
     |`TWO_BUTTON_PRESS|`THREE_BUTTON_PRESS
     |`BUTTON_RELEASE|`KEY_PRESS
     |`KEY_RELEASE|`ENTER_NOTIFY|`LEAVE_NOTIFY|`FOCUS_CHANGE
     |`CONFIGURE|`MAP|`UNMAP|`PROPERTY_NOTIFY|`SELECTION_CLEAR
     |`SELECTION_REQUEST|`SELECTION_NOTIFY|`PROXIMITY_IN
     |`PROXIMITY_OUT|`DRAG_ENTER|`DRAG_LEAVE|`DRAG_MOTION|`DRAG_STATUS
     |`DROP_START|`DROP_FINISHED|`CLIENT_EVENT|`VISIBILITY_NOTIFY
     |`NO_EXPOSE ]

  type event_mask =
    [ `EXPOSURE
     |`POINTER_MOTION|`POINTER_MOTION_HINT
     |`BUTTON_MOTION|`BUTTON1_MOTION|`BUTTON2_MOTION|`BUTTON3_MOTION
     |`BUTTON_PRESS|`BUTTON_RELEASE
     |`KEY_PRESS|`KEY_RELEASE
     |`ENTER_NOTIFY|`LEAVE_NOTIFY|`FOCUS_CHANGE
     |`STRUCTURE|`PROPERTY_CHANGE|`VISIBILITY_NOTIFY
     |`PROXIMITY_IN|`PROXIMITY_OUT|`SUBSTRUCTURE
     |`ALL_EVENTS ]

  type extension_events =
    [ `NONE|`ALL|`CURSOR ]

  type visibility_state =
    [ `UNOBSCURED|`PARTIAL|`FULLY_OBSCURED ]

  type input_source =
    [ `MOUSE|`PEN|`ERASER|`CURSOR ]

  type notify_type =
    [ `ANCESTOR|`VIRTUAL|`INFERIOR|`NONLINEAR|`NONLINEAR_VIRTUAL|`UNKNOWN ] 

  type crossing_mode =
    [ `NORMAL|`GRAB|`UNGRAB ]

  type modifier =
    [ `SHIFT|`LOCK|`CONTROL|`MOD1|`MOD2|`MOD3|`MOD4|`MOD5|`BUTTON1
     |`BUTTON2|`BUTTON3|`BUTTON4|`BUTTON5 ]

  type drag_action =
    [ `DEFAULT|`COPY|`MOVE|`LINK|`PRIVATE|`ASK ]

end
open Tags

module Convert = struct
  external test_modifier : modifier -> int -> bool
      = "ml_test_GdkModifier_val"
  let modifier i =
    List.filter [`SHIFT;`LOCK;`CONTROL;`MOD1;`MOD2;`MOD3;`MOD4;`MOD5;
		 `BUTTON1;`BUTTON2;`BUTTON3;`BUTTON4;`BUTTON5]
      ~f:(fun m -> test_modifier m i)
end

module Screen = struct
  external width : unit -> int = "ml_gdk_screen_width"
  external height : unit -> int = "ml_gdk_screen_height"
end

module Visual = struct
  type visual_type =
    [ `STATIC_GRAY|`GRAYSCALE|`STATIC_COLOR
     |`PSEUDO_COLOR|`TRUE_COLOR|`DIRECT_COLOR ]

  external get_type : visual -> visual_type = "ml_GdkVisual_type"
  external depth : visual -> int = "ml_GdkVisual_depth"
  external red_mask : visual -> int = "ml_GdkVisual_red_mask"
  external red_shift : visual -> int = "ml_GdkVisual_red_shift"
  external red_prec : visual -> int = "ml_GdkVisual_red_prec"
  external green_mask : visual -> int = "ml_GdkVisual_green_mask"
  external green_shift : visual -> int = "ml_GdkVisual_green_shift"
  external green_prec : visual -> int = "ml_GdkVisual_green_prec"
  external blue_mask : visual -> int = "ml_GdkVisual_blue_mask"
  external blue_shift : visual -> int = "ml_GdkVisual_blue_shift"
  external blue_prec : visual -> int = "ml_GdkVisual_blue_prec"
end

module Image = struct
  type image_type =
    [ `NORMAL|`SHARED|`FASTEST ] 

  external create_bitmap : visual: visual -> data: string -> 
    width: int -> height: int -> image 
      = "ml_gdk_image_new_bitmap"
  external create : kind: image_type -> visual: visual -> 
    width: int -> height: int -> image
      = "ml_gdk_image_new"
  external get :
      'a drawable -> x: int -> y: int -> width: int -> height: int -> image
      = "ml_gdk_image_get"
  external put_pixel : image -> x: int -> y: int -> pixel: int -> unit
    = "ml_gdk_image_put_pixel"
  external get_pixel : image -> x: int -> y: int -> int
    = "ml_gdk_image_get_pixel"
  external destroy : image -> unit
    = "ml_gdk_image_destroy"
end

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
  type spec = [ `BLACK | `NAME of string | `RGB of int * int * int | `WHITE]
  let color_alloc ~colormap color =
    if not (color_alloc colormap color) then raise (Error"Color.alloc");
    color
  let alloc ~colormap color =
    match color with
      `WHITE -> color_white colormap
    | `BLACK -> color_black colormap
    | `NAME s -> color_alloc ~colormap (color_parse s)
    | `RGB (red,green,blue) ->
	color_alloc ~colormap (color_create ~red ~green ~blue)

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
  type background_pixmap = [ `NONE | `PARENT_RELATIVE | `PIXMAP of pixmap]
  external visual_depth : visual -> int = "ml_gdk_visual_get_depth"
  external get_visual : window -> visual = "ml_gdk_window_get_visual"
  external get_parent : window -> window = "ml_gdk_window_get_parent"
  external get_size : window -> int * int = "ml_gdk_window_get_size"
  external get_position : window -> int * int =
    "ml_gdk_window_get_position"
  external root_parent : unit -> window = "ml_GdkRootParent"
  external set_back_pixmap : window -> pixmap -> int -> unit = 
    "ml_gdk_window_set_back_pixmap"
  external clear : window -> unit = "ml_gdk_window_clear"

  let set_back_pixmap w ~pixmap: pix = 
    let null_pixmap = (Obj.magic null : pixmap) in
    match pix with
      `NONE -> set_back_pixmap w null_pixmap 0
    | `PARENT_RELATIVE -> set_back_pixmap w null_pixmap 1
    | `PIXMAP(pixmap) -> set_back_pixmap w pixmap 0 
       (* anything OK, Maybe... *) 
end

module GC = struct
  type gdkFunction = [ `COPY|`INVERT|`XOR ]
  type gdkFill = [ `SOLID|`TILED|`STIPPLED|`OPAQUE_STIPPLED ]
  type gdkSubwindowMode = [ `CLIP_BY_CHILDREN|`INCLUDE_INFERIORS ]
  type gdkLineStyle = [ `SOLID|`ON_OFF_DASH|`DOUBLE_DASH ]
  type gdkCapStyle = [ `NOT_LAST|`BUTT|`ROUND|`PROJECTING ]
  type gdkJoinStyle = [ `MITER|`ROUND|`BEVEL ]
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
  external copy : dst:gc -> gc -> unit = "ml_gdk_gc_copy"
  type values = {
      foreground : Color.t;
      background : Color.t;
      font : font option;
      fonction : gdkFunction;
      fill : gdkFill;
      tile : pixmap option;
      stipple : pixmap option;
      clip_mask : bitmap option;
      subwindow_mode : gdkSubwindowMode;
      ts_x_origin : int;
      ts_y_origin : int;
      clip_x_origin : int;
      clip_y_origin : int;
      graphics_exposures : bool;
      line_width : int;
      line_style : gdkLineStyle;
      cap_style : gdkCapStyle;
      join_style : gdkJoinStyle;
    }
  external get_values : gc -> values = "ml_gdk_gc_get_values"
end

module Pixmap = struct
  external create : window -> width:int -> height:int -> depth:int -> pixmap
      = "ml_gdk_pixmap_new"
  external create_from_data :
      window -> string -> width:int -> height:int -> depth:int ->
      fg:Color.t -> bg:Color.t -> pixmap
      = "ml_gdk_pixmap_create_from_data_bc" "ml_gk_pixmap_create_from_data"
  external create_from_xpm :
      window -> ?colormap:colormap -> ?transparent:Color.t ->
      file:string -> pixmap * bitmap
      = "ml_gdk_pixmap_colormap_create_from_xpm"
  external create_from_xpm_d :
      window -> ?colormap:colormap -> ?transparent:Color.t ->
      data:string array -> pixmap * bitmap
      = "ml_gdk_pixmap_colormap_create_from_xpm_d"
end

module Bitmap = struct
  let create : window -> width:int -> height:int -> bitmap =
    Obj.magic (Pixmap.create ~depth:1)
  external create_from_data :
      window -> string -> width:int -> height:int -> bitmap
      = "ml_gdk_bitmap_create_from_data"
end

module Font = struct
  external load : string -> font = "ml_gdk_font_load"
  external load_fontset : string -> font = "ml_gdk_fontset_load"
  external string_width : font -> string -> int = "ml_gdk_string_width"
  external char_width : font -> char -> int = "ml_gdk_char_width"
  external string_height : font -> string -> int = "ml_gdk_string_height"
  external char_height : font -> char -> int = "ml_gdk_char_height"
  external string_measure : font -> string -> int = "ml_gdk_string_measure"
  external char_measure : font -> char -> int = "ml_gdk_char_measure"
end

module PointArray = struct
  type t = { len: int}
  external create : len:int -> t = "ml_point_array_new"
  external set : t -> pos:int -> x:int -> y:int -> unit = "ml_point_array_set"
  let set arr ~pos =
    if pos < 0 || pos >= arr.len then invalid_arg "PointArray.set";
    set arr ~pos
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
  let rectangle w gc ~x ~y ~width ~height ?(filled=false) () =
    rectangle w gc ~x ~y ~width ~height ~filled
  external arc :
      'a drawable -> gc -> filled:bool -> x:int -> y:int ->
      width:int -> height:int -> start:int -> angle:int -> unit
      = "ml_gdk_draw_arc_bc" "ml_gdk_draw_arc"
  let arc w gc ~x ~y ~width ~height ?(filled=false) ?(start=0.)
      ?(angle=360.) () =
    arc w gc ~x ~y ~width ~height ~filled
      ~start:(truncate(start *. 64.))
      ~angle:(truncate(angle *. 64.))
  external polygon : 'a drawable -> gc -> filled:bool -> PointArray.t -> unit
      = "ml_gdk_draw_polygon"
  let polygon w gc ?(filled=false) l =
    let len = List.length l in
    let arr = PointArray.create ~len in
    List.fold_left l ~init:0
      ~f:(fun pos (x,y) -> PointArray.set arr ~pos ~x ~y; pos+1);
    polygon w gc ~filled arr
  external string : 'a drawable -> font: font -> gc -> x: int -> y: int ->
    string: string -> unit
      = "ml_gdk_draw_string_bc" "ml_gdk_draw_string"	
  external image : 'a drawable -> gc -> image: image -> 
    xsrc: int -> ysrc: int -> xdest: int -> ydest: int -> 
    width: int -> height: int -> unit
      = "ml_gdk_draw_image_bc" "ml_gdk_draw_image"
end

module Rgb = struct
  external init : unit -> unit = "ml_gdk_rgb_init"
  external get_visual : unit -> visual = "ml_gdk_rgb_get_visual"
  external get_cmap : unit -> colormap = "ml_gdk_rgb_get_cmap"
end

module DnD = struct
  external drag_status : drag_context -> drag_action list -> time:int -> unit
      = "ml_gdk_drag_status"
  external drag_context_suggested_action : drag_context -> drag_action
      = "ml_GdkDragContext_suggested_action"
  external drag_context_targets : drag_context -> atom list
      = "ml_GdkDragContext_targets"
end

module Truecolor = struct
  (* Truecolor quick color query *) 

  type visual_shift_prec = {
      red_shift : int;
      red_prec : int;
      green_shift : int;
      green_prec : int;
      blue_shift : int;
      blue_prec : int
    }
 
  let shift_prec visual = {
    red_shift = Visual.red_shift visual;
    red_prec = Visual.red_prec visual;
    green_shift = Visual.green_shift visual;
    green_prec = Visual.green_prec visual;
    blue_shift = Visual.blue_shift visual;
    blue_prec = Visual.blue_prec visual;
  }

  let color_creator visual =
    match Visual.get_type visual with
      `TRUE_COLOR | `DIRECT_COLOR ->
	let shift_prec = shift_prec visual in
	Format.eprintf "red : %d %d, "
	  shift_prec.red_shift shift_prec.red_prec;
	Format.eprintf "green : %d %d, "
	  shift_prec.green_shift shift_prec.green_prec;
	Format.eprintf "blue : %d %d"
	  shift_prec.blue_shift shift_prec.blue_prec;
	Format.pp_print_newline Format.err_formatter ();
	let red_lsr = 16 - shift_prec.red_prec
	and green_lsr = 16 - shift_prec.green_prec
	and blue_lsr = 16 - shift_prec.blue_prec in
	fun ~red: red ~green: green ~blue: blue ->
	  (((red lsr red_lsr) lsl shift_prec.red_shift) lor 
    	   ((green lsr green_lsr) lsl shift_prec.green_shift) lor
    	   ((blue lsr blue_lsr) lsl shift_prec.blue_shift))
    | _ -> raise (Invalid_argument "Gdk.Truecolor.color_creator")

  let color_parser visual =
    match Visual.get_type visual with
      `TRUE_COLOR | `DIRECT_COLOR ->
	let shift_prec = shift_prec visual in
	let red_lsr = 16 - shift_prec.red_prec
	and green_lsr = 16 - shift_prec.green_prec
	and blue_lsr = 16 - shift_prec.blue_prec in
	let mask = 1 lsl 16 - 1 in
	fun pixel ->
	  ((pixel lsr shift_prec.red_shift) lsl red_lsr) land mask,
	  ((pixel lsr shift_prec.green_shift) lsl green_lsr) land mask,
	  ((pixel lsr shift_prec.blue_shift) lsl blue_lsr) land mask
    | _ -> raise (Invalid_argument "Gdk.Truecolor.color_parser")
end

module X = struct
  (* X related functions *)
  external flush : unit -> unit
      = "ml_gdk_flush"
  external beep : unit -> unit
      = "ml_gdk_beep"
end

(* $Id$ *)

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

module Tags : sig
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
  type extension_events = [ `NONE|`ALL|`CURSOR ]
  type visibility_state = [ `UNOBSCURED|`PARTIAL|`FULLY_OBSCURED ]
  type input_source = [ `MOUSE|`PEN|`ERASER|`CURSOR ]
  type notify_type =
    [ `ANCESTOR|`VIRTUAL|`INFERIOR|`NONLINEAR|`NONLINEAR_VIRTUAL|`UNKNOWN ] 
  type crossing_mode = [ `NORMAL|`GRAB|`UNGRAB ]
  type modifier =
    [ `SHIFT|`LOCK|`CONTROL|`MOD1|`MOD2|`MOD3|`MOD4|`MOD5|`BUTTON1
     |`BUTTON2|`BUTTON3|`BUTTON4|`BUTTON5 ]
  type drag_action = [ `DEFAULT|`COPY|`MOVE|`LINK|`PRIVATE|`ASK ]
end

module Convert :
  sig
    val modifier : int -> Tags.modifier list
  end

module Screen :
  sig
    external width : unit -> int = "ml_gdk_screen_width"
    external height : unit -> int = "ml_gdk_screen_height"
  end

module Visual :
  sig
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

module Image :
  sig
    type image_type = [ `FASTEST|`NORMAL|`SHARED ]
    external create_bitmap :
      visual:visual -> data:string -> width:int -> height:int -> image
      = "ml_gdk_image_new_bitmap"
    external create :
      image_type:image_type ->
      visual:visual -> width:int -> height:int -> image = "ml_gdk_image_new"
    external get :
      'a drawable -> x:int -> y:int -> width:int -> height:int -> image
      = "ml_gdk_image_get"
    external put_pixel : image -> x:int -> y:int -> pixel:int -> unit
      = "ml_gdk_image_put_pixel"
    external get_pixel : image -> x:int -> y:int -> int
      = "ml_gdk_image_get_pixel"
    external destroy : image -> unit = "ml_gdk_image_destroy"
  end

module Color :
  sig
    type t
    type spec = [
      | `BLACK
      | `NAME of string
      | `RGB of int * int * int
      | `WHITE
    ]
    val alloc : ?colormap:colormap -> spec -> t
    external get_system_colormap : unit -> colormap
	= "ml_gdk_colormap_get_system"
    external red : t -> int = "ml_GdkColor_red"
    external blue : t -> int = "ml_GdkColor_green"
    external green : t -> int = "ml_GdkColor_blue"
    external pixel : t -> int = "ml_GdkColor_pixel"
  end

module Rectangle :
  sig
    type t
    external create : x:int -> y:int -> width:int -> height:int -> t
      = "ml_GdkRectangle"
    external x : t -> int = "ml_GdkRectangle_x"
    external y : t -> int = "ml_GdkRectangle_y"
    external width : t -> int = "ml_GdkRectangle_width"
    external height : t -> int = "ml_GdkRectangle_height"
  end

module Window :
  sig
    type background_pixmap = [ `NONE|`PARENT_RELATIVE|`PIXMAP of pixmap ]
    external visual_depth : visual -> int = "ml_gdk_visual_get_depth"
    external get_visual : window -> visual = "ml_gdk_window_get_visual"
    external get_parent : window -> window = "ml_gdk_window_get_parent"
    external get_size : window -> int * int = "ml_gdk_window_get_size"
    external get_position : window -> int * int
      = "ml_gdk_window_get_position"
    external root_parent : unit -> window = "ml_GdkRootParent"
    external clear : window -> unit = "ml_gdk_window_clear"
    val set_back_pixmap : window -> pixmap:background_pixmap -> unit
  end

module GC :
  sig
    type gdkFunction = [ `COPY|`INVERT|`XOR ]
    type gdkFill = [ `SOLID|`TILED|`STIPPLED|`OPAQUE_STIPPLED ]
    type gdkSubwindowMode = [ `CLIP_BY_CHILDREN|`INCLUDE_INFERIORS ]
    type gdkLineStyle = [ `SOLID|`ON_OFF_DASH|`DOUBLE_DASH ]
    type gdkCapStyle = [ `NOT_LAST|`BUTT|`ROUND|`PROJECTING ]
    type gdkJoinStyle = [ `MITER|`ROUND|`BEVEL ]
    external create : 'a drawable -> gc = "ml_gdk_gc_new"
    external set_foreground : gc -> Color.t -> unit
      = "ml_gdk_gc_set_foreground"
    external set_background : gc -> Color.t -> unit
      = "ml_gdk_gc_set_background"
    external set_font : gc -> font -> unit = "ml_gdk_gc_set_font"
    external set_function : gc -> gdkFunction -> unit
      = "ml_gdk_gc_set_function"
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
      gc ->
      width:int ->
      style:gdkLineStyle -> cap:gdkCapStyle -> join:gdkJoinStyle -> unit
      = "ml_gdk_gc_set_line_attributes"
    external copy : to:gc -> gc -> unit = "ml_gdk_gc_copy"
  end

module Pixmap :
  sig
    external create :
      window -> width:int -> height:int -> depth:int -> pixmap
      = "ml_gdk_pixmap_new"
    external create_from_data :
      window ->
      string ->
      width:int ->
      height:int -> depth:int -> fg:Color.t -> bg:Color.t -> pixmap
      = "ml_gdk_pixmap_create_from_data_bc" "ml_gk_pixmap_create_from_data"
    external create_from_xpm :
      window ->
      ?colormap:colormap ->
      ?transparent:Color.t -> file:string -> pixmap * bitmap
      = "ml_gdk_pixmap_colormap_create_from_xpm"
    external create_from_xpm_d :
      window ->
      ?colormap:colormap ->
      ?transparent:Color.t -> data:string array -> pixmap * bitmap
      = "ml_gdk_pixmap_colormap_create_from_xpm_d"
  end

module Bitmap :
  sig
    val create : window -> width:int -> height:int -> bitmap
    external create_from_data :
      window -> string -> width:int -> height:int -> bitmap
      = "ml_gdk_bitmap_create_from_data"
  end

module Font :
  sig
    external load : string -> font = "ml_gdk_font_load"
    external load_fontset : string -> font = "ml_gdk_fontset_load"
    external string_width : font -> string -> int = "ml_gdk_string_width"
    external char_width : font -> char -> int = "ml_gdk_char_width"
    external string_height : font -> string -> int = "ml_gdk_string_height"
    external char_height : font -> char -> int = "ml_gdk_char_height"
    external string_measure : font -> string -> int = "ml_gdk_string_measure"
    external char_measure : font -> char -> int = "ml_gdk_char_measure"
  end

module PointArray :
  sig
    type t = { len: int }
    external create : len:int -> t = "ml_point_array_new"
    val set : t -> pos:int -> x:int -> y:int -> unit
  end

module Draw :
  sig
    external point : 'a drawable -> gc -> x:int -> y:int -> unit
      = "ml_gdk_draw_point"
    external line :
      'a drawable -> gc -> x:int -> y:int -> x:int -> y:int -> unit
      = "ml_gdk_draw_line_bc" "ml_gdk_draw_line"
    val rectangle :
      'a drawable -> gc ->
      x:int -> y:int -> width:int -> height:int -> ?filled:bool -> unit -> unit
    val arc :
      'a drawable -> gc ->
      x:int -> y:int -> width:int -> height:int ->
      ?filled:bool -> ?start:float -> ?angle:float -> unit -> unit
    val polygon :
      'a drawable -> gc -> ?filled:bool ->(int * int) list -> unit
    external string :
      'a drawable ->
      font:font -> gc -> x:int -> y:int -> string:string -> unit
      = "ml_gdk_draw_string_bc" "ml_gdk_draw_string"
    external image :
      'a drawable ->
      gc ->
      image:image ->
      xsrc:int ->
      ysrc:int -> xdest:int -> ydest:int -> width:int -> height:int -> unit
      = "ml_gdk_draw_image_bc" "ml_gdk_draw_image"
  end

module DnD :
  sig
    external drag_status :
      drag_context -> Tags.drag_action list -> time:int -> unit
      = "ml_gdk_drag_status"
    external drag_context_suggested_action : drag_context -> Tags.drag_action
      = "ml_GdkDragContext_suggested_action"
    external drag_context_targets : drag_context -> atom list
      = "ml_GdkDragContext_targets"
  end

module Truecolor :
  sig
    val color_creator : visual -> (red: int -> green: int -> blue: int -> int)
	(* [color_creator visual] creates a function to calculate 
	   the pixel color id for given red, green and blue component 
	   value ([0..65535]) at the client side. [visual] must have 
           `TRUE_COLOR or `DIRECT_COLOR type. This function improves
           the speed of the color query of true color visual greatly. *)
	(* WARN: this approach is not theoretically correct for true color
	   visual, because we need gamma correction. *)

    val color_parser : visual -> int -> int * int * int
  end

module X :
  (* X related functions *)
  sig
    val flush : unit -> unit (* also in GtkMain *)
    val beep : unit -> unit
  end

(* $Id$ *)

type colormap
type visual
type region
type gc
type +'a drawable
type window = [`window] drawable
type pixmap = [`pixmap] drawable
type bitmap = [`bitmap] drawable
type font
type image
type atom
type keysym = int
type +'a event
type drag_context = [`dragcontext] Gobject.obj
type cursor
type xid = int32
type device

exception Error of string

module Tags : sig
  type event_type =
    [ `NOTHING | `DELETE | `DESTROY | `EXPOSE | `MOTION_NOTIFY
    | `BUTTON_PRESS | `TWO_BUTTON_PRESS | `THREE_BUTTON_PRESS | `BUTTON_RELEASE
    | `KEY_PRESS | `KEY_RELEASE
    | `ENTER_NOTIFY | `LEAVE_NOTIFY | `FOCUS_CHANGE
    | `CONFIGURE | `MAP | `UNMAP | `PROPERTY_NOTIFY
    | `SELECTION_CLEAR | `SELECTION_REQUEST | `SELECTION_NOTIFY
    | `PROXIMITY_IN | `PROXIMITY_OUT
    | `DRAG_ENTER | `DRAG_LEAVE | `DRAG_MOTION | `DRAG_STATUS
    | `DROP_START | `DROP_FINISHED | `CLIENT_EVENT | `VISIBILITY_NOTIFY
    | `NO_EXPOSE | `SCROLL | `WINDOW_STATE | `SETTING ]
  type event_mask =
    [ `EXPOSURE
    | `POINTER_MOTION | `POINTER_MOTION_HINT
    | `BUTTON_MOTION | `BUTTON1_MOTION | `BUTTON2_MOTION | `BUTTON3_MOTION
    | `BUTTON_PRESS | `BUTTON_RELEASE
    | `KEY_PRESS | `KEY_RELEASE
    | `ENTER_NOTIFY | `LEAVE_NOTIFY | `FOCUS_CHANGE
    | `STRUCTURE | `PROPERTY_CHANGE | `VISIBILITY_NOTIFY
    | `PROXIMITY_IN | `PROXIMITY_OUT
    | `SUBSTRUCTURE | `SCROLL
    | `ALL_EVENTS ]
  type extension_events = [ `NONE | `ALL | `CURSOR ]
  type visibility_state = [ `UNOBSCURED | `PARTIAL | `FULLY_OBSCURED ]
  type input_source = [ `MOUSE | `PEN | `ERASER | `CURSOR ]
  type scroll_direction = [ `UP | `DOWN | `LEFT | `RIGHT ]
  type notify_type =
    [ `ANCESTOR | `VIRTUAL | `INFERIOR | `NONLINEAR
    | `NONLINEAR_VIRTUAL | `UNKNOWN ] 
  type crossing_mode = [ `NORMAL | `GRAB | `UNGRAB ]
  type setting_action = [ `NEW | `CHANGED | `DELETED ]
  type window_state = [ `WITHDRAWN | `ICONIFIED | `MAXIMIZED | `STICKY ]
  type modifier =
    [ `SHIFT | `LOCK | `CONTROL | `MOD1 | `MOD2 | `MOD3 | `MOD4 | `MOD5
    | `BUTTON1 | `BUTTON2 | `BUTTON3 | `BUTTON4 | `BUTTON5 ]
  type drag_action = [ `DEFAULT | `COPY | `MOVE | `LINK | `PRIVATE | `ASK ]
  type rgb_dither = [ `NONE | `NORMAL | `MAX]
  type selection = [ `PRIMARY | `SECONDARY ]
  type property_state = [ `NEW_VALUE | `DELETE ]
  type property_mode = [ `REPLACE | `PREPEND | `APPEND ]
  type xdata =
    [ `BYTES of string
    | `SHORTS of int array
    | `INT32S of int32 array ]
  type xdata_ret = [ xdata | `NONE ]
end

module Convert :
  sig
    val modifier : int -> Tags.modifier list
    val window_state : int -> Tags.window_state list
  end

module Atom :
  sig
    val intern :  ?dont_create:bool -> string -> atom
    external name : atom -> string = "ml_gdk_atom_name"
  end

module Property :
  sig
    val change :
      window:window -> typ:atom ->
      ?mode:Tags.property_mode -> atom -> Tags.xdata -> unit
    val get :
      window:window -> ?max_length:int ->
      ?delete:bool -> atom -> (atom * Tags.xdata) option
    val delete : window:window -> atom -> unit
  end

module Screen :
  sig
    val width : unit -> int
    val height : unit -> int
  end

module Visual :
  sig
    type visual_type =
      [ `STATIC_GRAY|`GRAYSCALE|`STATIC_COLOR
       |`PSEUDO_COLOR|`TRUE_COLOR|`DIRECT_COLOR ]
    val get_best : ?depth:int -> ?kind:visual_type -> unit -> visual
    val get_type : visual -> visual_type
    val depth : visual -> int
    val red_mask : visual -> int
    val red_shift : visual -> int
    val red_prec : visual -> int
    val green_mask : visual -> int
    val green_shift : visual -> int
    val green_prec : visual -> int
    val blue_mask : visual -> int
    val blue_shift : visual -> int
    val blue_prec : visual -> int
  end

module Image :
  sig
    type image_type = [ `FASTEST|`NORMAL|`SHARED ]
    val create :
      kind:image_type ->
      visual:visual -> width:int -> height:int -> image
    val get :
      'a drawable -> x:int -> y:int -> width:int -> height:int -> image
    val put_pixel : image -> x:int -> y:int -> pixel:int -> unit
    val get_pixel : image -> x:int -> y:int -> int
    val destroy : image -> unit
    val width : image -> int
    val height : image -> int
    val depth : image -> int
    val get_visual : image -> visual
  end

module Color :
  sig
    val get_system_colormap : unit -> colormap
    val get_colormap : ?privat:bool -> visual -> colormap
    val get_visual : colormap -> visual

    type t
    type spec = [
      | `BLACK
      | `NAME of string
      | `RGB of int * int * int
      | `WHITE
    ]
    val alloc : colormap:colormap -> spec -> t
    val red : t -> int
    val blue : t -> int
    val green : t -> int
    val pixel : t -> int
  end

module Rectangle :
  sig
    type t
    val create : x:int -> y:int -> width:int -> height:int -> t
    val x : t -> int
    val y : t -> int
    val width : t -> int
    val height : t -> int
  end

module Window :
  sig
    type background_pixmap = [ `NONE|`PARENT_RELATIVE|`PIXMAP of pixmap ]
    val visual_depth : visual -> int
    val get_visual : window -> visual
    val get_colormap : window -> colormap
    val get_parent : window -> window
    val get_size : 'a drawable -> int * int
    val get_position : 'a drawable -> int * int
    val get_pointer_location : window -> int * int
    val root_parent : unit -> window
    val clear : window -> unit
    val get_xwindow : 'a drawable -> xid
    val set_back_pixmap : window -> background_pixmap -> unit
    val set_cursor : window -> cursor -> unit
  end

module PointArray :
  sig
    type t = { len: int }
    val create : len:int -> t
    val set : t -> pos:int -> x:int -> y:int -> unit
  end

module Region :
  sig
    type gdkFillRule = [ `EVEN_ODD_RULE|`WINDING_RULE ]
    type gdkOverlapType = [ `IN|`OUT|`PART ]
    val create : unit -> region
    val destroy : region -> unit
    val polygon : (int * int) list -> gdkFillRule -> region 
    val intersect : region -> region -> region
    val union : region -> region -> region 
    val subtract : region -> region -> region 
    val xor : region -> region -> region 
    val union_with_rect : region -> Rectangle.t -> region
    val offset : region -> x:int -> y:int -> unit
    val shrink : region -> x:int -> y:int -> unit
    val empty : region -> bool
    val equal : region -> region -> bool
    val point_in : region -> x:int -> y:int -> bool 
    val rect_in : region -> Rectangle.t -> gdkOverlapType
    val get_clipbox : region -> Rectangle.t -> unit
  end

module GC :
  sig
    type gdkFunction = [ `COPY|`INVERT|`XOR ]
    type gdkFill = [ `SOLID|`TILED|`STIPPLED|`OPAQUE_STIPPLED ]
    type gdkSubwindowMode = [ `CLIP_BY_CHILDREN|`INCLUDE_INFERIORS ]
    type gdkLineStyle = [ `SOLID|`ON_OFF_DASH|`DOUBLE_DASH ]
    type gdkCapStyle = [ `NOT_LAST|`BUTT|`ROUND|`PROJECTING ]
    type gdkJoinStyle = [ `MITER|`ROUND|`BEVEL ]
    val create : 'a drawable -> gc
    val set_foreground : gc -> Color.t -> unit
    val set_background : gc -> Color.t -> unit
    val set_font : gc -> font -> unit
    val set_function : gc -> gdkFunction -> unit
    val set_fill : gc -> gdkFill -> unit
    val set_tile : gc -> pixmap -> unit
    val set_stipple : gc -> pixmap -> unit
    val set_ts_origin : gc -> x:int -> y:int -> unit
    val set_clip_origin : gc -> x:int -> y:int -> unit
    val set_clip_mask : gc -> bitmap -> unit
    val set_clip_rectangle : gc -> Rectangle.t -> unit
    val set_clip_region : gc -> region -> unit
    val set_subwindow : gc -> gdkSubwindowMode -> unit
    val set_exposures : gc -> bool -> unit
    val set_line_attributes :
      gc ->
      width:int ->
      style:gdkLineStyle -> cap:gdkCapStyle -> join:gdkJoinStyle -> unit
    val set_dashes : gc -> offset:int -> int list -> unit
    val copy : dst:gc -> gc -> unit
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
    val get_values : gc -> values
  end

module Pixmap :
  sig
    val create :
      ?window:window -> width:int -> height:int -> ?depth:int -> unit -> pixmap
    val create_from_data :
      ?window:window -> width:int -> height:int ->
      ?depth:int -> fg:Color.t -> bg:Color.t -> string -> pixmap
    val create_from_xpm :
      ?window:window -> ?colormap:colormap -> ?transparent:Color.t ->
      file:string -> unit -> pixmap * bitmap
    val create_from_xpm_d :
      ?window:window -> ?colormap:colormap -> ?transparent:Color.t ->
      data:string array -> unit -> pixmap * bitmap
  end

module Bitmap :
  sig
    val create : ?window:window -> width:int -> height:int -> unit -> bitmap
    val create_from_data :
      ?window:window -> width:int -> height:int -> string -> bitmap
  end

module Font :
  sig
    val load : string -> font
    val load_fontset : string -> font
    val string_width : font -> string -> int
    val char_width : font -> char -> int
    val string_height : font -> string -> int
    val char_height : font -> char -> int
    val string_measure : font -> string -> int
    val char_measure : font -> char -> int
    val get_type : font -> [`FONT | `FONTSET]
    val ascent : font -> int
    val descent : font -> int
  end

module Draw :
  sig
    val point : 'a drawable -> gc -> x:int -> y:int -> unit
    val line :
      'a drawable -> gc -> x:int -> y:int -> x:int -> y:int -> unit
    val rectangle :
      'a drawable -> gc ->
      x:int -> y:int -> width:int -> height:int -> ?filled:bool -> unit -> unit
    val arc :
      'a drawable -> gc ->
      x:int -> y:int -> width:int -> height:int ->
      ?filled:bool -> ?start:float -> ?angle:float -> unit -> unit
    val polygon :
      'a drawable -> gc -> ?filled:bool ->(int * int) list -> unit
    val string :
      'a drawable ->
      font:font -> gc -> x:int -> y:int -> string -> unit
    val image :
      'a drawable -> gc -> ?xsrc:int -> ?ysrc:int ->
      ?xdest:int -> ?ydest:int -> ?width:int -> ?height:int -> image -> unit
    val pixmap :
      'a drawable -> gc -> ?xsrc:int -> ?ysrc:int ->
      ?xdest:int -> ?ydest:int -> ?width:int -> ?height:int -> pixmap -> unit
    val points : 'a drawable -> gc -> (int * int) list -> unit
    val lines : 'a drawable -> gc -> (int * int) list -> unit
    val segments : 'a drawable -> gc -> ((int * int) * (int * int)) list -> unit
  end

module Rgb :
  sig
    val init : unit -> unit
    val get_visual : unit -> visual
    val get_cmap : unit -> colormap
    val draw_image :
      'a drawable -> gc -> width:int -> height:int -> ?x:int -> ?y:int ->
      ?dither:Tags.rgb_dither -> ?row_stride:int -> Gpointer.region -> unit
    (* [row_stride] defaults to [width*3] *)
  end

module DnD :
  sig
    val drag_status :
      drag_context -> Tags.drag_action list -> time:int32 -> unit
    val drag_context_suggested_action : drag_context -> Tags.drag_action
    val drag_context_targets : drag_context -> atom list
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

module Cursor : sig
  type cursor_type = [
    | `X_CURSOR
    | `ARROW
    | `BASED_ARROW_DOWN
    | `BASED_ARROW_UP
    | `BOAT
    | `BOGOSITY
    | `BOTTOM_LEFT_CORNER
    | `BOTTOM_RIGHT_CORNER
    | `BOTTOM_SIDE
    | `BOTTOM_TEE
    | `BOX_SPIRAL
    | `CENTER_PTR
    | `CIRCLE
    | `CLOCK
    | `COFFEE_MUG
    | `CROSS
    | `CROSS_REVERSE
    | `CROSSHAIR
    | `DIAMOND_CROSS
    | `DOT
    | `DOTBOX
    | `DOUBLE_ARROW
    | `DRAFT_LARGE
    | `DRAFT_SMALL
    | `DRAPED_BOX
    | `EXCHANGE
    | `FLEUR
    | `GOBBLER
    | `GUMBY
    | `HAND1
    | `HAND2
    | `HEART
    | `ICON
    | `IRON_CROSS
    | `LEFT_PTR
    | `LEFT_SIDE
    | `LEFT_TEE
    | `LEFTBUTTON
    | `LL_ANGLE
    | `LR_ANGLE
    | `MAN
    | `MIDDLEBUTTON
    | `MOUSE
    | `PENCIL
    | `PIRATE
    | `PLUS
    | `QUESTION_ARROW
    | `RIGHT_PTR
    | `RIGHT_SIDE
    | `RIGHT_TEE
    | `RIGHTBUTTON
    | `RTL_LOGO
    | `SAILBOAT
    | `SB_DOWN_ARROW
    | `SB_H_DOUBLE_ARROW
    | `SB_LEFT_ARROW
    | `SB_RIGHT_ARROW
    | `SB_UP_ARROW
    | `SB_V_DOUBLE_ARROW
    | `SHUTTLE
    | `SIZING
    | `SPIDER
    | `SPRAYCAN
    | `STAR
    | `TARGET
    | `TCROSS
    | `TOP_LEFT_ARROW
    | `TOP_LEFT_CORNER
    | `TOP_RIGHT_CORNER
    | `TOP_SIDE
    | `TOP_TEE
    | `TREK
    | `UL_ANGLE
    | `UMBRELLA
    | `UR_ANGLE
    | `WATCH
    | `XTERM
  ]
  val create : cursor_type -> cursor
  val create_from_pixmap :
    pixmap -> mask:bitmap ->
    fg:Color.t -> bg:Color.t -> x:int -> y:int -> cursor
  val destroy : cursor -> unit
end

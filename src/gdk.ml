(* $Id$ *)

open Misc

type colormap
type visual
type window
type pixmap
type bitmap
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
      PROXIMITY_OUT DRAG_BEGIN DRAG_REQUEST DROP_ENTER
      DROP_LEAVE DROP_DATA_AVAIL CLIENT_EVENT VISIBILITY_NOTIFY
      NO_EXPOSE OTHER_EVENT ]

  type visibility_state =
    [ UNOBSCURED PARTIAL FULLY_OBSCURED ]

  type input_source =
    [ MOUSE PEN ERASER CURSOR ]

  type notify_type =
    [ ANCESTOR VIRTUAL INFERIOR NONLINEAR NONLINEAR_VIRTUAL UNKNOWN ] 
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

  type spec = [Black Name(string) RGB(int * int * int) White]
  let alloc color in:colormap =
    match color with
      `White -> color_white colormap
    | `Black -> color_black colormap
    | `Name _|`RGB _ as c ->
	let color =
	  match c with `Name s -> color_parse s
	  | `RGB (red,green,blue) -> color_create :red :green :blue
	in
	if not (color_alloc colormap color) then raise (Error"color_alloc");
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

module Event = struct
  external unsafe_copy : pointer -> #event_type event
      = "ml_gdk_event_copy"
  external get_type : 'a event -> 'a = "ml_GdkEventAny_type"
  external get_window : 'a event -> window = "ml_GdkEventAny_window"
  external get_send_event : 'a event -> bool = "ml_GdkEventAny_send_event"

  module Expose = struct
    type t = [ EXPOSE ] event
    let cast (ev : event_type event) : t =
      match get_type ev with `EXPOSE -> Obj.magic ev
      |	_ -> invalid_arg "Gdk.Event.Expose.cast"
    external area : t -> Rectangle.t = "ml_GdkEventExpose_area"
    external count : t -> int = "ml_GdkEventExpose_count"
  end

  module Visibility = struct
    type t = [ VISIBILITY_NOTIFY ] event
    let cast (ev :  event_type event) : t =
      match get_type ev with `VISIBILITY_NOTIFY -> Obj.magic ev
      |	_ -> invalid_arg "Gdk.Event.Visibility.cast"
    external visibility : t -> visibility_state
	= "ml_GdkEventVisibility_state"
  end

  module Motion = struct
    type t = [ MOTION_NOTIFY ] event
    let cast (ev : event_type event) : t =
      match get_type ev with `MOTION_NOTIFY -> Obj.magic ev
      |	_ -> invalid_arg "Gdk.Event.Motion.cast"
    external time : t -> int = "ml_GdkEventMotion_time"
    external x : t -> float = "ml_GdkEventMotion_x"
    external y : t -> float = "ml_GdkEventMotion_y"
    external pressure : t -> float = "ml_GdkEventMotion_pressure"
    external xtilt : t -> float = "ml_GdkEventMotion_xtilt"
    external ytilt : t -> float = "ml_GdkEventMotion_ytilt"
    external state : t -> int = "ml_GdkEventMotion_state"
    external is_hint : t -> bool = "ml_GdkEventMotion_is_hint"
    external source : t -> input_source = "ml_GdkEventMotion_source"
    external deviceid : t -> int = "ml_GdkEventMotion_deviceid"
    external x_root : t -> float = "ml_GdkEventMotion_x_root"
    external y_root : t -> float = "ml_GdkEventMotion_y_root"
  end

  module Button = struct
    type t =
	[ BUTTON_PRESS TWO_BUTTON_PRESS THREE_BUTTON_PRESS BUTTON_RELEASE ]
	  event
    let cast (ev : event_type event) : t =
      match get_type ev with
	`BUTTON_PRESS|`TWO_BUTTON_PRESS|`THREE_BUTTON_PRESS|`BUTTON_RELEASE
	-> Obj.magic ev
      |	_ -> invalid_arg "Gdk.Event.Button.cast"
    external time : t -> int = "ml_GdkEventButton_time"
    external x : t -> float = "ml_GdkEventButton_x"
    external y : t -> float = "ml_GdkEventButton_y"
    external pressure : t -> float = "ml_GdkEventButton_pressure"
    external xtilt : t -> float = "ml_GdkEventButton_xtilt"
    external ytilt : t -> float = "ml_GdkEventButton_ytilt"
    external state : t -> int = "ml_GdkEventButton_state"
    external button : t -> int = "ml_GdkEventButton_button"
    external source : t -> input_source = "ml_GdkEventButton_source"
    external deviceid : t -> int = "ml_GdkEventButton_deviceid"
    external x_root : t -> float = "ml_GdkEventButton_x_root"
    external y_root : t -> float = "ml_GdkEventButton_y_root"
  end

  module Key = struct
    type t = [ KEY_PRESS KEY_RELEASE ] event
    let cast (ev : event_type event) : t =
      match get_type ev with `KEY_PRESS|`KEY_RELEASE -> Obj.magic ev
      |	_ -> invalid_arg "Gdk.Event.Key.cast"
    external time : t -> int = "ml_GdkEventKey_time"
    external state : t -> int = "ml_GdkEventKey_state"
    external keyval : t -> int = "ml_GdkEventKey_keyval"
    external string : t -> string = "ml_GdkEventKey_string"
  end

  module Crossing = struct
    type t = [ ENTER_NOTIFY LEAVE_NOTIFY ] event
    let cast (ev : event_type event) : t =
      match get_type ev with `ENTER_NOTIFY|`LEAVE_NOTIFY -> Obj.magic ev
      |	_ -> invalid_arg "Gdk.Event.Crossing.cast"
    external subwindow : t -> window = "ml_GdkEventCrossing_subwindow"
    external detail : t -> notify_type = "ml_GdkEventCrossing_detail"
  end

  module Focus = struct
    type t = [ FOCUS_CHANGE ] event
    let cast (ev : event_type event) : t =
      match get_type ev with `FOCUS_CHANGE -> Obj.magic ev
      |	_ -> invalid_arg "Gdk.Event.Focus.cast"
    external focus_in : t -> bool = "ml_GdkEventFocus_in"
  end

  module Configure = struct
    type t = [ CONFIGURE ] event
    let cast (ev : event_type event) : t =
      match get_type ev with `CONFIGURE -> Obj.magic ev
      |	_ -> invalid_arg "Gdk.Event.Configure.cast"
    external x : t -> int = "ml_GdkEventConfigure_x"
    external y : t -> int = "ml_GdkEventConfigure_y"
    external width : t -> int = "ml_GdkEventConfigure_width"
    external height : t -> int = "ml_GdkEventConfigure_height"
  end

  module Property = struct
    type t = [ PROPERTY_NOTIFY ] event
    let cast (ev : event_type event) : t =
      match get_type ev with `PROPERTY_NOTIFY -> Obj.magic ev
      |	_ -> invalid_arg "Gdk.Event.Property.cast"
    external atom : t -> atom = "ml_GdkEventProperty_atom"
    external time : t -> int = "ml_GdkEventProperty_time"
    external state : t -> int = "ml_GdkEventProperty_state"
  end

  module Selection = struct
    type t = [ SELECTION_CLEAR SELECTION_REQUEST SELECTION_NOTIFY ] event
    let cast (ev : event_type event) : t =
      match get_type ev with
	`SELECTION_CLEAR|`SELECTION_REQUEST|`SELECTION_NOTIFY -> Obj.magic ev
      |	_ -> invalid_arg "Gdk.Event.Selection.cast"
    external selection : t -> atom = "ml_GdkEventSelection_selection"
    external target : t -> atom = "ml_GdkEventSelection_target"
    external property : t -> atom = "ml_GdkEventSelection_property"
    external requestor : t -> int = "ml_GdkEventSelection_requestor"
    external time : t -> int = "ml_GdkEventSelection_time"
  end

  module Proximity = struct
    type t = [ PROXIMITY_IN PROXIMITY_OUT ] event
    let cast (ev : event_type event) : t =
      match get_type ev with `PROXIMITY_IN|`PROXIMITY_OUT -> Obj.magic ev
      |	_ -> invalid_arg "Gdk.Event.Proximity.cast"
    external time : t -> int = "ml_GdkEventProximity_time"
    external source : t -> input_source = "ml_GdkEventProximity_source"
    external deviceid : t -> int = "ml_GdkEventProximity_deviceid"
  end
end

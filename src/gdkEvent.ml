(* $Id$ *)

open Gaux
open Gdk
open Tags

external unsafe_copy : Gpointer.boxed -> [< event_type] event
    = "ml_gdk_event_copy"
external copy : ([< event_type] as 'a) event -> 'a event
    = "ml_gdk_event_copy"
external get_type : 'a event -> 'a = "ml_GdkEventAny_type"
external get_window : 'a event -> window = "ml_GdkEventAny_window"
external get_send_event : 'a event -> bool = "ml_GdkEventAny_send_event"
type timed =
 [ `MOTION_NOTIFY
 | `BUTTON_PRESS | `TWO_BUTTON_PRESS | `THREE_BUTTON_PRESS | `BUTTON_RELEASE
 | `SCROLL
 | `KEY_PRESS | `KEY_RELEASE
 | `ENTER_NOTIFY | `LEAVE_NOTIFY
 | `PROPERTY_NOTIFY
 | `SELECTION_CLEAR | `SELECTION_REQUEST | `SELECTION_NOTIFY
 | `PROXIMITY_IN | `PROXIMITY_OUT
 | `DRAG_ENTER | `DRAG_LEAVE | `DRAG_MOTION | `DRAG_STATUS | `DROP_START
 | `DROP_FINISHED ]
external get_time : [< timed] event -> int32
    = "ml_gdk_event_get_time"

external create : ([< event_type] as 'a) -> 'a event
    = "ml_gdk_event_new"
external set_window : 'a event -> window -> unit
    = "ml_gdk_event_set_window"

type any = event_type event
let cast (ev : any) ~(kind : ([< event_type] as 'a) list )
    : 'a event =
  if List.mem (Obj.magic (get_type ev) : [< event_type]) kind then Obj.magic ev
  else invalid_arg "GdkEvent.cast"

module Expose = struct
  type t = [ `EXPOSE ] event
  let cast (ev : any) : t =
    match get_type ev with `EXPOSE -> Obj.magic ev
    | _ -> invalid_arg "GdkEvent.Expose.cast"
  external area : t -> Rectangle.t = "ml_GdkEventExpose_area"
  external region : t -> region = "ml_GdkEventExpose_region"
  external count : t -> int = "ml_GdkEventExpose_count"
end

module Visibility = struct
  type t = [ `VISIBILITY_NOTIFY ] event
  let cast (ev :  any) : t =
    match get_type ev with `VISIBILITY_NOTIFY -> Obj.magic ev
    | _ -> invalid_arg "GdkEvent.Visibility.cast"
  external visibility : t -> visibility_state
      = "ml_GdkEventVisibility_state"
end

module Motion = struct
  type t = [ `MOTION_NOTIFY ] event
  let cast (ev : any) : t =
    match get_type ev with `MOTION_NOTIFY -> Obj.magic ev
    | _ -> invalid_arg "GdkEvent.Motion.cast"
  let time = get_time
  external x : t -> float = "ml_GdkEventMotion_x"
  external y : t -> float = "ml_GdkEventMotion_y"
  external axes : t -> (float * float) option = "ml_GdkEventMotion_axes"
  external state : t -> int = "ml_GdkEventMotion_state"
  external is_hint : t -> bool = "ml_GdkEventMotion_is_hint"
  external device : t -> device = "ml_GdkEventMotion_device"
  external x_root : t -> float = "ml_GdkEventMotion_x_root"
  external y_root : t -> float = "ml_GdkEventMotion_y_root"
end

module Button = struct
  type types =
      [ `BUTTON_PRESS|`TWO_BUTTON_PRESS|`THREE_BUTTON_PRESS|`BUTTON_RELEASE ]
  type t = types event
  let cast (ev : any) : t =
    match get_type ev with
      `BUTTON_PRESS|`TWO_BUTTON_PRESS|`THREE_BUTTON_PRESS|`BUTTON_RELEASE
      -> Obj.magic ev
    | _ -> invalid_arg "GdkEvent.Button.cast"
  let time = get_time
  external x : t -> float = "ml_GdkEventButton_x"
  external y : t -> float = "ml_GdkEventButton_y"
  external axes : t -> (float * float) option = "ml_GdkEventButton_axes"
  external state : t -> int = "ml_GdkEventButton_state"
  external button : t -> int = "ml_GdkEventButton_button"
  external device : t -> device = "ml_GdkEventButton_device"
  external x_root : t -> float = "ml_GdkEventButton_x_root"
  external y_root : t -> float = "ml_GdkEventButton_y_root"
  external set_type : t -> [< types] -> unit
      = "ml_gdk_event_set_type"
  external set_button : t -> int -> unit
      = "ml_gdk_event_button_set_button"
end

module Scroll = struct
  type t = [ `SCROLL ] event
  let cast (ev : any) : t =
    match get_type ev with `SCROLL -> Obj.magic ev
    | _ -> invalid_arg "GdkEvent.Scroll.cast"
  let time = get_time
  external x : t -> float = "ml_GdkEventScroll_x"
  external y : t -> float = "ml_GdkEventScroll_y"
  external state : t -> int = "ml_GdkEventScroll_state"
  external direction : t -> scroll_direction = "ml_GdkEventScroll_direction"
  external device : t -> device = "ml_GdkEventScroll_device"
  external x_root : t -> float = "ml_GdkEventScroll_x_root"
  external y_root : t -> float = "ml_GdkEventScroll_y_root"
end

module Key = struct
  type t = [ `KEY_PRESS|`KEY_RELEASE ] event
  let cast (ev : any) : t =
    match get_type ev with
      `KEY_PRESS|`KEY_RELEASE -> Obj.magic ev
    | _ -> invalid_arg "GdkEvent.Key.cast"
  let time = get_time
  external state : t -> int = "ml_GdkEventKey_state"
  external keyval : t -> keysym = "ml_GdkEventKey_keyval"
  external string : t -> string = "ml_GdkEventKey_string"
  external hardware_keycode : t -> int = "ml_GdkEventKey_hardware_keycode"
  external group : t -> int = "ml_GdkEventKey_group"
  let state ev = Convert.modifier (state ev)
end

module Crossing = struct
  type t = [ `ENTER_NOTIFY|`LEAVE_NOTIFY ] event
  let cast (ev : any) : t =
    match get_type ev with
      `ENTER_NOTIFY|`LEAVE_NOTIFY -> Obj.magic ev
    | _ -> invalid_arg "GdkEvent.Crossing.cast"
  external subwindow : t -> window = "ml_GdkEventCrossing_subwindow"
  let time = get_time
  external x : t -> float = "ml_GdkEventCrossing_x"
  external y : t -> float = "ml_GdkEventCrossing_y"
  external x_root : t -> float = "ml_GdkEventCrossing_x_root"
  external y_root : t -> float = "ml_GdkEventCrossing_y_root"
  external mode : t -> crossing_mode = "ml_GdkEventCrossing_mode"
  external detail : t -> notify_type = "ml_GdkEventCrossing_detail"
  external focus : t -> bool = "ml_GdkEventCrossing_focus"
  external state : t -> int = "ml_GdkEventCrossing_state"
end

module Focus = struct
  type t = [ `FOCUS_CHANGE ] event
  let cast (ev : any) : t =
    match get_type ev with `FOCUS_CHANGE -> Obj.magic ev
    | _ -> invalid_arg "GdkEvent.Focus.cast"
  external focus_in : t -> bool = "ml_GdkEventFocus_in"
end

module Configure = struct
  type t = [ `CONFIGURE ] event
  let cast (ev : any) : t =
    match get_type ev with `CONFIGURE -> Obj.magic ev
    |	_ -> invalid_arg "GdkEvent.Configure.cast"
  external x : t -> int = "ml_GdkEventConfigure_x"
  external y : t -> int = "ml_GdkEventConfigure_y"
  external width : t -> int = "ml_GdkEventConfigure_width"
  external height : t -> int = "ml_GdkEventConfigure_height"
end

module Property = struct
  type t = [ `PROPERTY_NOTIFY ] event
  let cast (ev : any) : t =
    match get_type ev with `PROPERTY_NOTIFY -> Obj.magic ev
    | _ -> invalid_arg "GdkEvent.Property.cast"
  external atom : t -> atom = "ml_GdkEventProperty_atom"
  let time = get_time
  external state : t -> int = "ml_GdkEventProperty_state"
end

module Selection = struct
  type t = [ `SELECTION_CLEAR|`SELECTION_REQUEST|`SELECTION_NOTIFY ] event
  let cast (ev : any) : t =
    match get_type ev with
      `SELECTION_CLEAR|`SELECTION_REQUEST|`SELECTION_NOTIFY -> Obj.magic ev
    | _ -> invalid_arg "GdkEvent.Selection.cast"
  external selection : t -> atom = "ml_GdkEventSelection_selection"
  external target : t -> atom = "ml_GdkEventSelection_target"
  external property : t -> atom = "ml_GdkEventSelection_property"
  external requestor : t -> xid = "ml_GdkEventSelection_requestor"
  let time = get_time
end

module Proximity = struct
  type t = [ `PROXIMITY_IN|`PROXIMITY_OUT ] event
  let cast (ev : any) : t =
    match get_type ev with
      `PROXIMITY_IN|`PROXIMITY_OUT -> Obj.magic ev
    | _ -> invalid_arg "GdkEvent.Proximity.cast"
  let time = get_time
  external device : t -> device = "ml_GdkEventProximity_device"
end

module Client = struct
  type t = [ `CLIENT_EVENT ] event
  let cast (ev : any) : t =
    match get_type ev with
      `CLIENT_EVENT -> Obj.magic ev
    | _ -> invalid_arg "GdkEvent.Client.cast"
  external window : t -> window = "ml_GdkEventClient_window"
  external message_type : t -> atom = "ml_GdkEventClient_message_type"
  external data : t -> xdata_ret = "ml_GdkEventClient_data"
end

module Setting = struct
  type t = [ `SETTING ] event
  let cast (ev : any) : t =
    match get_type ev with `SETTING -> Obj.magic ev
    | _ -> invalid_arg "GdkEvent.Setting.cast"
  external action : t -> setting_action = "ml_GdkEventSetting_action"
  external name : t -> string = "ml_GdkEventSetting_name"
end

module WindowState = struct  type t = [ `WINDOW_STATE ] event
  let cast (ev : any) : t =
    match get_type ev with `WINDOW_STATE -> Obj.magic ev
    | _ -> invalid_arg "GdkEvent.WindowState.cast"
  external changed_mask : t -> int = "ml_GdkEventWindowState_changed_mask"
  external new_window_state : t -> int
      = "ml_GdkEventWindowState_new_window_state"
  let changed_mask ev = Convert.window_state (changed_mask ev)
  let new_window_state ev = Convert.window_state (new_window_state ev)
end

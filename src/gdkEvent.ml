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
  type types =
      [ `BUTTON_PRESS|`TWO_BUTTON_PRESS|`THREE_BUTTON_PRESS|`BUTTON_RELEASE ]
  type t = types event
  let cast (ev : any) : t =
    match get_type ev with
      `BUTTON_PRESS|`TWO_BUTTON_PRESS|`THREE_BUTTON_PRESS|`BUTTON_RELEASE
      -> Obj.magic ev
    | _ -> invalid_arg "GdkEvent.Button.cast"
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
  external set_type : t -> [< types] -> unit
      = "ml_gdk_event_set_type"
  external set_button : t -> int -> unit
      = "ml_gdk_event_button_set_button"
end

module Key = struct
  type t = [ `KEY_PRESS|`KEY_RELEASE ] event
  let cast (ev : any) : t =
    match get_type ev with
      `KEY_PRESS|`KEY_RELEASE -> Obj.magic ev
    | _ -> invalid_arg "GdkEvent.Key.cast"
  external time : t -> int = "ml_GdkEventKey_time"
  external state : t -> int = "ml_GdkEventKey_state"
  external keyval : t -> keysym = "ml_GdkEventKey_keyval"
  external string : t -> string = "ml_GdkEventKey_string"
  let state ev = Convert.modifier (state ev)
end

module Crossing = struct
  type t = [ `ENTER_NOTIFY|`LEAVE_NOTIFY ] event
  let cast (ev : any) : t =
    match get_type ev with
      `ENTER_NOTIFY|`LEAVE_NOTIFY -> Obj.magic ev
    | _ -> invalid_arg "GdkEvent.Crossing.cast"
  external subwindow : t -> window = "ml_GdkEventCrossing_subwindow"
  external detail : t -> notify_type = "ml_GdkEventCrossing_detail"
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
  external time : t -> int = "ml_GdkEventProperty_time"
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
  external requestor : t -> int = "ml_GdkEventSelection_requestor"
  external time : t -> int = "ml_GdkEventSelection_time"
end

module Proximity = struct
  type t = [ `PROXIMITY_IN|`PROXIMITY_OUT ] event
  let cast (ev : any) : t =
    match get_type ev with
      `PROXIMITY_IN|`PROXIMITY_OUT -> Obj.magic ev
    | _ -> invalid_arg "GdkEvent.Proximity.cast"
  external time : t -> int = "ml_GdkEventProximity_time"
  external source : t -> input_source = "ml_GdkEventProximity_source"
  external deviceid : t -> int = "ml_GdkEventProximity_deviceid"
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

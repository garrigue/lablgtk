(**************************************************************************)
(*                Lablgtk                                                 *)
(*                                                                        *)
(*    This program is free software; you can redistribute it              *)
(*    and/or modify it under the terms of the GNU Library General         *)
(*    Public License as published by the Free Software Foundation         *)
(*    version 2, with the exception described in file COPYING which       *)
(*    comes with the library.                                             *)
(*                                                                        *)
(*    This program is distributed in the hope that it will be useful,     *)
(*    but WITHOUT ANY WARRANTY; without even the implied warranty of      *)
(*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       *)
(*    GNU Library General Public License for more details.                *)
(*                                                                        *)
(*    You should have received a copy of the GNU Library General          *)
(*    Public License along with this program; if not, write to the        *)
(*    Free Software Foundation, Inc., 59 Temple Place, Suite 330,         *)
(*    Boston, MA 02111-1307  USA                                          *)
(*                                                                        *)
(*                                                                        *)
(**************************************************************************)

(* $Id$ *)

open Gobject

type color
type colormap
type visual
type screen = [`gdkscreen] obj
type region
type gc
type window = [`gdkwindow] obj
type atom
type keysym = int
type +'a event
type drag_context = [`dragcontext] obj
type cursor
type xid = int32
type native_window
type device
type display

exception Error of string

module Tags : sig
  (* gdkevents.h *)
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
    | `SCROLL | `WINDOW_STATE | `SETTING
    | `OWNER_CHANGE | `GRAB_BROKEN | `DAMAGE
    | `TOUCH_BEGIN | `TOUCH_UPDATE | `TOUCH_END | `TOUCH_CANCEL
    | `TOUCHPAD_SWIPE | `TOUCHPAD_PINCH
    | `PAD_BUTTON_PRESS | `PAD_BUTTON_RELEASE
    | `PAD_RING | `PAD_STRIP | `PAD_GROUP_MODE ]
  
  type visibility_state =
    [ `UNOBSCURED | `PARTIAL | `FULLY_OBSCURED ]

  type touchpad_gesture_phase =
    [ `BEGIN | `UPDATE | `END | `CANCEL ]

  type scroll_direction =
    [ `UP | `DOWN | `LEFT | `RIGHT | `SMOOTH ]

  type crossing_mode =
    [ `NORMAL | `GRAB | `UNGRAB | `GTK_GRAB | `GTK_UNGRAB
    | `STATE_CHANGED | `TOUCH_BEGIN | `TOUCH_END | `DEVICE_SWITCH ]

  type notify_type =
    [ `ANCESTOR | `VIRTUAL | `INFERIOR | `NONLINEAR | `NONLINEAR_VIRTUAL
    | `UNKNOWN ]

  type setting_action =
    [ `NEW | `CHANGED | `DELETED ]

  type owner_change =
    [ `NEW_OWNER | `DESTROY | `CLOSE ]

  type window_state =
    [ `WITHDRAWN | `ICONIFIED | `MAXIMIZED | `STICKY | `FULLSCREEN
    | `ABOVE | `BELOW | `FOCUSED | `TILED | `TOP_TILED | `TOP_RESIZABLE
    | `RIGHT_TILED | `RIGHT_RESIZABLE | `BOTTOM_TILED
    | `BOTTOM_RESIZABLE | `LEFT_TILED | `LEFT_RESIZABLE ]

  (* gdkdevice.h *)
  type input_source =
    [ `MOUSE | `PEN | `ERASER | `CURSOR | `KEYBOARD
    | `TOUCHSCREEN | `TOUCHPAD | `TRACKPOINT | `TABLET_PAD ]

  type input_mode =
    [ `DISABLED | `SCREEN | `WINDOW ]

  type device_type =
    [ `MASTER | `SLAVE | `FLOATING ]

  (* gdkvisual.h *)
  type visual_type =
    [ `STATIC_GRAY | `GRAYSCALE | `STATIC_COLOR | `PSEUDO_COLOR
    | `TRUE_COLOR | `DIRECT_COLOR ]

  (* gdkdnd.h *)
  type drag_action =
    [ `DEFAULT | `COPY | `MOVE | `LINK | `PRIVATE | `ASK ]

  type drag_cancel_reason =
    [ `NO_TARGET | `USER_CANCELLED | `ERROR ]

  type drag_protocol =
    [ `NONE | `MOTIF | `XDND | `ROOTWIN | `WIN32_DROPFILES
    | `OLE2 | `LOCAL | `WAYLAND ]

  type property_state =
    [ `NEW_VALUE | `DELETE ]

  type xdata =
    [ `BYTES of string
    | `SHORTS of int array
    | `INT32S of int32 array ]

  type xdata_ret = [ xdata | `NONE ]

  (* gdkproperty.h *)
  type property_mode =
    [ `REPLACE | `PREPEND | `APPEND ]

  (* gdkwindow.h *)
  type window_class =
    [ `INPUT_OUTPUT | `INPUT_ONLY ]

  type window_type =
    [ `ROOT | `TOPLEVEL | `CHILD | `TEMP | `FOREIGN | `OFFSCREEN | `SUBSURFACE ]

  type window_attributes_type =
    [ `TITLE | `X | `Y | `CURSOR | `VISUAL | `WMCLASS | `NOREDIR | `TYPE_HINT ]

  type window_hints =
    [ `POS | `MIN_SIZE | `MAX_SIZE | `BASE_SIZE | `ASPECT
    | `RESIZE_INC | `WIN_GRAVITY | `USER_POS | `USER_SIZE ]

  type wm_decoration =
    [ `ALL | `BORDER | `RESIZEH | `TITLE | `MENU | `MINIMIZE | `MAXIMIZE ]

  type wm_function =
    [ `ALL | `RESIZE | `MOVE | `MINIMIZE | `MAXIMIZE | `CLOSE ]

  type gravity =
    [ `NORTH_WEST | `NORTH | `NORTH_EAST | `WEST | `CENTER | `EAST
    | `SOUTH_WEST | `SOUTH | `SOUTH_EAST | `STATIC ]

  type anchor_hints =
    [ `FLIP_X | `FLIP_Y | `SLIDE_X | `SLIDE_Y | `RESIZE_X | `RESIZE_Y
    | `FLIP | `SLIDE | `RESIZE ]

  type window_edge =
    [ `NORTH_WEST | `NORTH | `NORTH_EAST | `WEST | `EAST
    | `SOUTH_WEST | `SOUTH | `SOUTH_EAST ]

  type fullscreen_mode =
    [ `ON_CURRENT_MONITOR | `ON_ALL_MONITORS ]

  (* gdktypes.h *)
  type modifier =
    [ `SHIFT | `LOCK | `CONTROL | `MOD1 | `MOD2 | `MOD3 | `MOD4 | `MOD5
    | `BUTTON1 | `BUTTON2 | `BUTTON3 | `BUTTON4 | `BUTTON5 | `SUPER
    | `HYPER | `META | `RELEASE ]

  type modifier_intent =
    [ `PRIMARY_ACCELERATOR | `CONTEXT_MENU | `EXTEND_SELECTION
    | `MODIFY_SELECTION | `NO_TEXT_INPUT | `SHIFT_GROUP | `DEFAULT_MOD_MASK ]

  type status =
    [ `OK | `ERROR | `ERROR_PARAM | `ERROR_FILE | `ERROR_MEM ]

  type grab_status =
    [ `SUCCESS | `ALREADY_GRABBED | `INVALID_TIME | `NOT_VIEWABLE | `FROZEN
    | `FAILED ]

  type grab_ownership =
    [ `NONE | `WINDOW | `APPLICATION ]

  type event_mask =
    [ `EXPOSURE | `POINTER_MOTION | `POINTER_MOTION_HINT
    | `BUTTON_MOTION | `BUTTON1_MOTION | `BUTTON2_MOTION | `BUTTON3_MOTION
    | `BUTTON_PRESS | `BUTTON_RELEASE
    | `KEY_PRESS | `KEY_RELEASE
    | `ENTER_NOTIFY | `LEAVE_NOTIFY | `FOCUS_CHANGE
    | `STRUCTURE | `PROPERTY_CHANGE | `VISIBILITY_NOTIFY
    | `PROXIMITY_IN | `PROXIMITY_OUT
    | `SUBSTRUCTURE | `SCROLL
    | `TOUCH | `SMOOTH_SCROLL | `TOUCHPAD_GESTURE | `TABLET_PAD
    | `ALL_EVENTS ]

  type gl_error =
    [ `NOT_AVAILABLE | `UNSUPPORTED_FORMAT | `UNSUPPORTED_PROFILE ]

  type window_type_hint =
    [ `NORMAL | `DIALOG | `MENU | `TOOLBAR | `SPLASHSCREEN | `UTILITY
    | `DOCK | `DESKTOP
    | `DROPDOWN_MENU | `POPUP_MENU | `TOOLTIP | `NOTIFICATION | `COMBO | `DND ]

  type axis_use =
    [ `IGNORE | `X | `Y | `PRESSURE | `XTILT | `YTILT
    | `WHEEL | `DISTANCE | `ROTATION | `SLIDER | `LAST ]

  type axis_flags =
    [ `X | `Y | `PRESSURE | `XTILT | `YTILT
    | `WHEEL | `DISTANCE | `ROTATION | `SLIDER ]
end

module Convert :
  sig
    val test_modifier : Tags.modifier -> int -> bool
    val modifier : int -> Tags.modifier list
    val window_state : int -> Tags.window_state list
  end

module Atom :
  sig
    (* Currently Gtk2 does not implement ?dont_create... *)
    val intern :  ?dont_create:bool -> string -> atom
    val name : atom -> string
    val none : atom
    val primary : atom
    val secondary : atom
    val clipboard : atom
    val string : atom
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
    val width : ?screen:screen -> unit -> int
    val height : ?screen:screen -> unit -> int
    val get_pango_context : ?screen:screen -> unit -> Pango.context
    (* Screens are only supported with Gtk+-2.2 *)
    val default : unit -> screen
  end

module Visual :
  sig
    type visual_type =
      [ `STATIC_GRAY|`GRAYSCALE|`STATIC_COLOR
       |`PSEUDO_COLOR|`TRUE_COLOR|`DIRECT_COLOR ]
    val get_best : ?depth:int -> ?kind:visual_type -> unit -> visual
    val get_type : visual -> visual_type
    val depth : visual -> int
  end

(*
module Color :
  sig
    val get_system_colormap : unit -> colormap
    val get_colormap : ?privat:bool -> visual -> colormap
    val get_visual : colormap -> visual

    type spec = [
      | `BLACK
      | `NAME of string
      | `RGB of int * int * int
      | `WHITE
    ]
    val alloc : colormap:colormap -> spec -> color
    val red : color -> int
    val blue : color -> int
    val green : color -> int
    val pixel : color -> int
  end
*)

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
    val cast : 'a obj -> window
    val create_foreign : display -> xid -> window
    val get_parent : window -> window
    val get_position : window -> int * int
    val get_pointer_location : window -> int * int
    (* val root_parent : unit -> window
    val clear : window -> unit
    val clear_area :
        window -> x:int -> y:int -> width:int -> height:int -> unit *)
    val get_xwindow : window -> xid
    val native_of_xid : xid -> native_window
    val xid_of_native : native_window -> xid
    val set_cursor : window -> cursor -> unit
    val set_transient_for : window -> window -> unit

    (* for backward compatibility for lablgtk1 programs *)	  
    val get_visual : window -> visual
  end

module DnD :
  sig
    val drag_status :
      drag_context -> Tags.drag_action option -> time:int32 -> unit
    val drag_context_suggested_action : drag_context -> Tags.drag_action
    val drag_context_targets : drag_context -> atom list
  end

(*
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
*)

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
  val create_from_pixbuf :
    [`pixbuf] Gobject.obj -> x:int -> y:int -> cursor (** @since GTK 2.4 *)
  val get_image : cursor -> [`pixbuf] obj             (** @since GTK 2.8 *)
  (* val destroy : cursor -> unit   -- done by GC *)
end

module Display : sig
    (** @since Gtk+-2.2 *)

  val default : unit -> display
  val window_at_pointer : ?display:display -> unit -> (window * int * int) option
end

module Windowing : sig
  val platform : [`QUARTZ | `WIN32 | `X11]
end

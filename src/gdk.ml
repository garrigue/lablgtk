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

open StdLabels
open Gaux
open Gobject

type color
type rgba
(* Removed in gtk3
type colormap
*)
type visual
type screen = [`gdkscreen] obj
type region
type gc
type window = [`gdkwindow] obj
type cairo
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
let _ = Callback.register_exception "gdkerror" (Error"")

external _gdk_init : unit -> unit = "ml_gdk_init"
let () = _gdk_init ()

module Tags = struct
  include (GdkEnums : module type of GdkEnums
           with module Conv := GdkEnums.Conv and type xdata := GdkEnums.xdata)
  type xdata =
    [ `BYTES of string
    | `SHORTS of int array
    | `INT32S of int32 array ]

  type xdata_ret = [ xdata | `NONE ]
end
open Tags

module Convert = struct
  external test_modifier : modifier -> int -> bool
      = "ml_test_GdkModifier_val"
  let modifier i =
    List.filter [`SHIFT;`LOCK;`CONTROL;`MOD1;`MOD2;`MOD3;`MOD4;`MOD5;
		 `BUTTON1;`BUTTON2;`BUTTON3;`BUTTON4;`BUTTON5;`SUPER;
                 `HYPER;`META;`RELEASE]
      ~f:(fun m -> test_modifier m i)
  external test_window_state : window_state -> int -> bool
      = "ml_test_GdkWindowState_val"
  let window_state i =
    List.filter [ `WITHDRAWN; `ICONIFIED; `MAXIMIZED; `STICKY ]
      ~f:(fun m -> test_window_state m i)
end

module Atom = struct
  external intern : string -> bool -> atom = "ml_gdk_atom_intern"
  let intern ?(dont_create=false) name = intern name dont_create
  external name : atom -> string = "ml_gdk_atom_name"
  let none = intern "NONE"
  let primary = intern "PRIMARY"
  let secondary = intern "SECONDARY"
  let clipboard = intern "CLIPBOARD"
  let string = intern "STRING"
end

module Property = struct
  external change :
      window ->
      property:atom -> typ:atom -> mode:property_mode -> xdata -> unit
      = "ml_gdk_property_change"
  let change ~window ~typ ?(mode=`REPLACE) property data =
    change window ~property ~typ ~mode data
  external get :
      window -> property:atom ->
      max_length:int -> delete:bool -> (atom * xdata) option
      = "ml_gdk_property_get"
  let get ~window ?(max_length=65000) ?(delete=false) property =
    get window ~property ~max_length ~delete
  external delete : window:window -> atom -> unit
      = "ml_gdk_property_delete"
end

module Screen = struct
  external get_width : screen -> int = "ml_gdk_screen_get_width"
  external width : unit -> int = "ml_gdk_screen_width"
  let width ?screen () =
    match screen with None -> width () | Some s -> get_width s
  external get_height : screen -> int = "ml_gdk_screen_get_height"
  external height : unit -> int = "ml_gdk_screen_height"
  let height ?screen () =
    match screen with None -> height () | Some s -> get_height s
  external get_pango_context_for : screen -> Pango.context =
    "ml_gdk_pango_context_get_for_screen"
  external get_pango_context : unit -> Pango.context =
    "ml_gdk_pango_context_get"
  let get_pango_context ?screen () =
    match screen with None -> get_pango_context ()
    | Some s -> get_pango_context_for s

  (* Only with Gtk-2.2 *)
  external default : unit -> screen = "ml_gdk_screen_get_default"
end

module Visual = struct
  type visual_type =
    [ `STATIC_GRAY|`GRAYSCALE|`STATIC_COLOR
     |`PSEUDO_COLOR|`TRUE_COLOR|`DIRECT_COLOR ]

  external get_best : ?depth:int -> ?kind:visual_type -> unit -> visual
      = "ml_gdk_visual_get_best"
  external get_screen : visual -> screen = "ml_gdk_visual_get_screen"
  external get_type : visual -> visual_type = "ml_gdk_visual_get_visual_type"
  external depth : visual -> int = "ml_gdk_visual_get_depth"
end

module Color = struct
(* Removed in GdkColor 3.0
  external color_white : colormap -> color = "ml_gdk_color_white"
  external color_black : colormap -> color = "ml_gdk_color_black"
*)
  external color_parse : string -> color = "ml_gdk_color_parse"
  external color_to_string : color -> string = "ml_gdk_color_to_string"
(* Removed in GdkColor 3.0
  external color_alloc : colormap -> color -> bool = "ml_gdk_color_alloc"
*)
  external color_create : red:int -> green:int -> blue:int -> color
      = "ml_GdkColor"

(* Removed in GdkColor 3.0
  external get_system_colormap : unit -> colormap
      = "ml_gdk_colormap_get_system"
  external colormap_new : visual -> privat:bool -> colormap
      = "ml_gdk_colormap_new"
  let get_colormap ?(privat=false) vis = colormap_new vis ~privat

  external get_visual : colormap -> visual
      = "ml_gdk_colormap_get_visual"

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
*)

  (* deprecated in 3.14 in favor of RGBA *)
  external red : color -> int = "ml_GdkColor_red"
  external blue : color -> int = "ml_GdkColor_blue"
  external green : color -> int = "ml_GdkColor_green"
  external pixel : color -> int = "ml_GdkColor_pixel"

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

module Windowing = struct
  external get : unit -> [`QUARTZ | `WIN32 | `X11] = "ml_gdk_get_platform"
  let platform = get ()
end

module Window = struct
  let cast w : window = Gobject.try_cast w "GdkWindow"
  external create_foreign : display -> xid -> window =
    "ml_gdk_x11_window_foreign_new_for_display"
  external get_parent : window -> window = "ml_gdk_window_get_parent"
  external get_position : window -> int * int = "ml_gdk_window_get_position"
  external get_pointer_location : window -> int * int =
    "ml_gdk_window_get_pointer_location"
  (* external root_parent : unit -> window = "ml_GDK_ROOT_PARENT" *)
  (* external set_back_pixmap : window -> pixmap -> int -> unit = 
    "ml_gdk_window_set_back_pixmap" *)
  external set_cursor : window -> cursor -> unit = 
    "ml_gdk_window_set_cursor"
  (* external clear : window -> unit = "ml_gdk_window_clear"
  external clear_area :
    window -> x:int -> y:int -> width:int -> height:int -> unit
    = "ml_gdk_window_clear" *)
  external get_xid : window -> xid = "ml_GDK_WINDOW_XID"
  let get_xwindow = get_xid
  external get_visual : window -> visual = "ml_gdk_window_get_visual"

  (* let set_back_pixmap w pix = 
    let null_pixmap = (Obj.magic Gpointer.boxed_null : pixmap) in
    match pix with
      `NONE -> set_back_pixmap w null_pixmap 0
    | `PARENT_RELATIVE -> set_back_pixmap w null_pixmap 1
    | `PIXMAP(pixmap) -> set_back_pixmap w pixmap 0 
       (* anything OK, Maybe... *) *)

  let xid_of_native (w : native_window) : xid =
    if Windowing.platform = `X11 then Obj.magic w else
    failwith "Gdk.Window.xid_of_native only allowed for X11"
  let native_of_xid (id : xid) : native_window =
    if Windowing.platform = `X11 then Obj.magic id else
    failwith "Gdk.Window.native_of_xid only allowed for X11"

  external set_transient_for : window -> window -> unit = "ml_gdk_window_set_transient_for"
end

module DnD = struct
  external drag_status : drag_context -> drag_action option -> time:int32 -> unit
      = "ml_gdk_drag_status"
  external drag_context_suggested_action : drag_context -> drag_action
      = "ml_gdk_drag_context_get_suggested_action"
  external drag_context_targets : drag_context -> atom list
      = "ml_gdk_drag_context_list_targets"
end

(*
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
        (* Format.eprintf "red : %d %d, "
	  shift_prec.red_shift shift_prec.red_prec;
	Format.eprintf "green : %d %d, "
	  shift_prec.green_shift shift_prec.green_prec;
	Format.eprintf "blue : %d %d"
	  shift_prec.blue_shift shift_prec.blue_prec;
	Format.pp_print_newline Format.err_formatter (); *)
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
*)

module X = struct
  (* X related functions *)
  external flush : unit -> unit
      = "ml_gdk_flush"
  external beep : unit -> unit
      = "ml_gdk_beep"
end

module Cursor = struct
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
  external create : cursor_type -> cursor = "ml_gdk_cursor_new"
  external create_from_pixbuf :
    [`pixbuf] obj -> x:int -> y:int -> cursor
    = "ml_gdk_cursor_new_from_pixbuf" (** @since GTK 2.4 *)
  external get_image : cursor -> [`pixbuf] obj
    = "ml_gdk_cursor_get_image"       (** @since GTK 2.8 *)
end

module Display = struct
    (* since Gtk+-2.2 *)

  external default :
    unit -> display
    = "ml_gdk_display_get_default"
  external get_window_at_pointer :
    display -> (window * int * int) option
    = "ml_gdk_display_get_window_at_pointer"
  let window_at_pointer ?display () =
    get_window_at_pointer
      (match display with None -> default ()
      | Some disp -> disp)
end

module Cairo = struct
  external create :
    window -> cairo
    = "ml_gdk_cairo_create"
end

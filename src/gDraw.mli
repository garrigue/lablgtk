(* $Id$ *)

open Gdk

type color =
  [ `COLOR of Color.t
  | `WHITE
  | `BLACK
  | `NAME of string
  | `RGB of int * int * int]
val color : color -> Color.t
class ['a] drawable : 'a Gdk.drawable ->
  object
    val gc : gc
    val w : 'a Gdk.drawable
    method arc :
      x:int ->
      y:int ->
      width:int ->
      height:int ->
      ?filled:bool -> ?start:float -> ?angle:float -> unit -> unit
    method gc_values : GC.values
    method image :
      width:int ->
      height:int ->
      ?xsrc:int -> ?ysrc:int -> ?xdest:int -> ?ydest:int -> image -> unit
    method line : x:int -> y:int -> x:int -> y:int -> unit
    method point : x:int -> y:int -> unit
    method polygon : ?filled:bool -> (int * int) list -> unit
    method rectangle :
      x:int ->
      y:int -> width:int -> height:int -> ?filled:bool -> unit -> unit
    method set_background : color -> unit
    method set_foreground : color -> unit
    method set_line_attributes :
      ?width:int ->
      ?style:GC.gdkLineStyle ->
      ?cap:GC.gdkCapStyle -> ?join:GC.gdkJoinStyle -> unit -> unit
    method string : string -> font:font -> x:int -> y:int -> unit
  end

class pixmap : ?mask:bitmap -> [ `pixmap] Gdk.drawable ->
  object
    inherit [[`pixmap]] drawable
    val bitmap : [ `bitmap] drawable option
    val mask : bitmap option
    method mask : bitmap option
    method pixmap : Gdk.pixmap
  end

val pixmap_from_xpm :
  window:window ->
  file:string ->
  ?colormap:colormap -> ?transparent:color -> unit -> pixmap
val pixmap_from_xpm_d :
  window:window ->
  data:string array ->
  ?colormap:colormap -> ?transparent:color -> unit -> pixmap

class type widget_draw =
  object
    method allocation : Gtk.rectangle
    method colormap : colormap
    method draw : Rectangle.t option -> unit
    method event : Tags.event_type event -> bool
    method hide : unit -> unit
    method hide_all : unit -> unit
    method intersect : Rectangle.t -> Rectangle.t option
    method pointer : int * int
    method realize : unit -> unit
    method set_app_paintable : bool -> unit
    method set_uposition : x:int -> y:int -> unit
    method set_usize : width:int -> height:int -> unit
    method show : unit -> unit
    method unmap : unit -> unit
    method unparent : unit -> unit
    method unrealize : unit -> unit
    method visible : bool
    method visual : visual
    method visual_depth : int
    method window : window
  end

val pixmap :
  window:< misc : #widget_draw; .. > ->
  width:int -> height:int -> ?mask:bool -> unit -> pixmap

class drag_context : Gdk.drag_context ->
  object
    val context : Gdk.drag_context
    method status : ?time:int -> Tags.drag_action list -> unit
    method suggested_action : Tags.drag_action
    method targets : atom list
  end

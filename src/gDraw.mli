(* $Id$ *)

open Gdk

type color =
  [ `COLOR of Color.t
  | `WHITE
  | `BLACK
  | `NAME of string
  | `RGB of int * int * int]

val color : ?colormap:colormap -> color -> Color.t

type optcolor =
  [ `COLOR of Color.t
  | `WHITE
  | `BLACK
  | `NAME of string
  | `RGB of int * int * int
  | `DEFAULT ]

val optcolor : ?colormap:colormap -> optcolor -> Color.t option

class drawable : ?colormap:colormap -> ([>`drawable] Gobject.obj as 'a) ->
  object
    val gc : gc
    val w : 'a
    method arc :
      x:int ->
      y:int ->
      width:int ->
      height:int ->
      ?filled:bool -> ?start:float -> ?angle:float -> unit -> unit
    method color : color -> Color.t
    method gc_values : GC.values
    method line : x:int -> y:int -> x:int -> y:int -> unit
    method point : x:int -> y:int -> unit
    method polygon : ?filled:bool -> (int * int) list -> unit
    method put_image :
      x:int -> y:int ->
      ?xsrc:int -> ?ysrc:int -> ?width:int -> ?height:int -> image -> unit
    method put_pixmap :
      x:int -> y:int ->
      ?xsrc:int -> ?ysrc:int -> ?width:int -> ?height:int -> pixmap -> unit
    method put_rgb_data :
      width:int -> height:int ->
      ?x:int -> ?y:int -> ?dither:Gdk.Tags.rgb_dither ->
      ?row_stride:int -> Gpointer.region -> unit
    method rectangle :
      x:int ->
      y:int -> width:int -> height:int -> ?filled:bool -> unit -> unit
    method set_background : color -> unit
    method set_foreground : color -> unit
    method set_clip_region : region -> unit
    method set_clip_origin : x:int -> y:int -> unit
    method set_clip_mask : bitmap -> unit
    method set_clip_rectangle : Rectangle.t -> unit
    method set_line_attributes :
      ?width:int ->
      ?style:GC.gdkLineStyle ->
      ?cap:GC.gdkCapStyle -> ?join:GC.gdkJoinStyle -> unit -> unit
    method size : int * int
    method string : string -> font:font -> x:int -> y:int -> unit
    method points : (int * int) list -> unit
    method lines : (int * int) list -> unit
    method segments : ((int * int) * (int * int)) list -> unit
  end

class pixmap :
  ?colormap:colormap -> ?mask:bitmap -> Gdk.pixmap ->
  object
    inherit drawable
    val w : Gdk.pixmap
    val bitmap : drawable option
    val mask : bitmap option
    method mask : bitmap option
    method pixmap : Gdk.pixmap
  end

class type misc_ops =
  object
    method allocation : Gtk.rectangle
    method colormap : colormap
    method draw : Rectangle.t option -> unit
    method hide : unit -> unit
    method hide_all : unit -> unit
    method intersect : Rectangle.t -> Rectangle.t option
    method pointer : int * int
    method realize : unit -> unit
    method set_app_paintable : bool -> unit
    method set_geometry :
      ?x:int -> ?y:int -> ?width:int -> ?height:int -> unit -> unit
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
  width:int -> height:int -> ?mask:bool ->
  ?window:< misc : #misc_ops; .. > -> ?colormap:colormap ->
  unit -> pixmap
val pixmap_from_xpm :
  file:string ->
  ?window:< misc : #misc_ops; .. > ->
  ?colormap:colormap -> ?transparent:color -> unit -> pixmap
val pixmap_from_xpm_d :
  data:string array ->
  ?window:< misc : #misc_ops; .. > ->
  ?colormap:colormap -> ?transparent:color -> unit -> pixmap

class drag_context : Gdk.drag_context ->
  object
    val context : Gdk.drag_context
    method status : ?time:int32 -> Tags.drag_action list -> unit
    method suggested_action : Tags.drag_action
    method targets : string list
  end

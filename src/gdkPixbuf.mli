(* $Id$ *)

(* Types *)

type pixbuf = [`base|`pixbuf] Gobject.obj
type colorspace = [ `RGB]
type alpha_mode = [ `BILEVEL | `FULL]
type interpolation = [ `BILINEAR | `HYPER | `NEAREST | `TILES]
type uint8 = int

(* Creation *)

val create :
  width:int -> height:int ->
  ?bits:int -> ?colorspace:colorspace -> ?has_alpha:bool -> unit -> pixbuf

val cast : 'a Gobject.obj -> pixbuf
external copy : pixbuf -> pixbuf = "ml_gdk_pixbuf_copy"
external from_file : string -> pixbuf = "ml_gdk_pixbuf_new_from_file"
external from_xpm_data : string array -> pixbuf
  = "ml_gdk_pixbuf_new_from_xpm_data"
val from_data :
  width:int -> height:int ->
  ?bits:int -> ?rowstride:int -> ?has_alpha:bool -> Gpointer.region -> pixbuf

val get_from_drawable :
  dest:pixbuf ->
  ?dest_x:int -> ?dest_y:int ->
  ?width:int ->  ?height:int ->
  ?src_x:int -> ?src_y:int ->
  ?colormap:Gdk.colormap -> 'a Gdk.drawable -> unit

(* Accessors *)

external get_n_channels : pixbuf -> int = "ml_gdk_pixbuf_get_n_channels"
external get_has_alpha : pixbuf -> bool = "ml_gdk_pixbuf_get_has_alpha"
external get_bits_per_sample : pixbuf -> int
  = "ml_gdk_pixbuf_get_bits_per_sample"
external get_width : pixbuf -> int = "ml_gdk_pixbuf_get_width"
external get_height : pixbuf -> int = "ml_gdk_pixbuf_get_height"
external get_rowstride : pixbuf -> int = "ml_gdk_pixbuf_get_rowstride"
val get_pixels : pixbuf -> Gpointer.region

(* Renderring *)

val render_alpha :
  Gdk.bitmap ->
  ?dest_x:int ->
  ?dest_y:int ->
  ?width:int ->
  ?height:int -> ?threshold:int -> ?src_x:int -> ?src_y:int -> pixbuf -> unit

val render_to_drawable :
  'a Gdk.drawable ->
  ?gc:Gdk.gc ->
  ?dest_x:int ->
  ?dest_y:int ->
  ?width:int ->
  ?height:int ->
  ?dither:Gdk.Tags.rgb_dither ->
  ?x_dither:int ->
  ?y_dither:int -> ?src_x:int -> ?src_y:int -> pixbuf -> unit

val render_to_drawable_alpha :
  'a Gdk.drawable ->
  ?dest_x:int ->
  ?dest_y:int ->
  ?width:int ->
  ?height:int ->
  ?alpha:alpha_mode ->
  ?threshold:int ->
  ?dither:Gdk.Tags.rgb_dither ->
  ?x_dither:int ->
  ?y_dither:int -> ?src_x:int -> ?src_y:int -> pixbuf -> unit

val create_pixmap : ?threshold:int -> pixbuf -> Gdk.pixmap * Gdk.bitmap option

(* Transform *)

val add_alpha : ?transparent:int * int * int -> pixbuf -> pixbuf

val copy_area :
  dest:pixbuf ->
  ?dest_x:int ->
  ?dest_y:int ->
  ?width:int -> ?height:int -> ?src_x:int -> ?src_y:int -> pixbuf -> unit

val scale :
  dest:pixbuf ->
  ?dest_x:int ->
  ?dest_y:int ->
  ?width:int ->
  ?height:int ->
  ?ofs_x:float ->
  ?ofs_y:float ->
  ?scale_x:float -> ?scale_y:float -> ?interp:interpolation -> pixbuf -> unit

val composite :
  dest:pixbuf ->
  alpha:int ->
  ?dest_x:int ->
  ?dest_y:int ->
  ?width:int ->
  ?height:int ->
  ?ofs_x:float ->
  ?ofs_y:float ->
  ?scale_x:float -> ?scale_y:float -> ?interp:interpolation -> pixbuf -> unit

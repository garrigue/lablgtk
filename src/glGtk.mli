(* $Id$ *)

open Gtk
open GObj

type visual_options = [
    `USE_GL
  | `BUFFER_SIZE of int
  | `LEVEL of int
  | `RGBA
  | `DOUBLEBUFFER
  | `STEREO
  | `AUX_BUFFERS of int
  | `RED_SIZE of int
  | `GREEN_SIZE of int
  | `BLUE_SIZE of int
  | `ALPHA_SIZE of int
  | `DEPTH_SIZE of int
  | `STENCIL_SIZE of int
  | `ACCUM_GREEN_SIZE of int
  | `ACCUM_ALPHA_SIZE of int
]
type gl_area = [Gtk.drawing_area|`glarea]

module GtkRaw :
  sig
    external create :
      visual_options list -> share:[>`glarea] optobj -> gl_area obj
      = "ml_gtk_gl_area_new"
    external swap_buffers : [>`glarea] obj -> unit
      = "ml_gtk_gl_area_swap_buffers"
    external make_current : [>`glarea] obj -> bool
      = "ml_gtk_gl_area_make_current"
  end

class area_signals : 'a obj ->
  object
    inherit GObj.widget_signals
    constraint 'a = [> gl_area]
    val obj : 'a obj
    method display : callback:(unit -> unit) -> GtkSignal.id
    method realize : callback:(unit -> unit) -> GtkSignal.id
    method reshape :
      callback:(width:int -> height:int -> unit) -> GtkSignal.id
  end

class area : gl_area obj ->
  object
    inherit GObj.widget
    val obj : gl_area obj
    method event : event_ops
    method as_area : gl_area obj
    method connect : area_signals
    method make_current : unit -> unit
    method set_size : width:int -> height:int -> unit
    method swap_buffers : unit -> unit
  end

val area :
  visual_options list ->
  ?share:area ->
  ?width:int ->
  ?height:int -> ?packing:(widget -> unit) -> ?show:bool -> unit -> area

val region_of_raw : 'a Raw.t -> Gpointer.region

(* $Id$ *)

open Gtk
open GObj

type visual_options = [
    `USE_GL
  | `BUFFER_SIZE int
  | `LEVEL int
  | `RGBA
  | `DOUBLEBUFFER
  | `STEREO
  | `AUX_BUFFERS int
  | `RED_SIZE int
  | `GREEN_SIZE int
  | `BLUE_SIZE int
  | `ALPHA_SIZE int
  | `DEPTH_SIZE int
  | `STENCIL_SIZE int
  | `ACCUM_GREEN_SIZE int
  | `ACCUM_ALPHA_SIZE int
]
type gl_area = [`widget|`drawing|`glarea]

module Raw :
  sig
    external create :
      visual_options list -> share:[>`glarea] optobj -> gl_area obj
      = "ml_gtk_gl_area_new"
    external swap_buffers : [>`glarea] obj -> unit
      = "ml_gtk_gl_area_swapbuffers"
    external make_current : [>`glarea] obj -> bool
      = "ml_gtk_gl_area_make_current"
  end

class area_signals : 'a obj ->
  object
    inherit widget_signals
    constraint 'a = [>`glarea|`widget]
    val obj : 'a obj
    method display : callback:(unit -> unit) -> GtkSignal.id
    method reshape :
      callback:(width:int -> height:int -> unit) -> GtkSignal.id
  end

class area : gl_area obj ->
  object
    inherit widget
    val obj : gl_area obj
    method add_events : Gdk.Tags.event_mask list -> unit
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

(* $Id$ *)

open Gtk

type visual_options = [
    USE_GL
    BUFFER_SIZE (int)
    LEVEL (int)
    RGBA
    DOUBLEBUFFER
    STEREO
    AUX_BUFFERS (int)
    RED_SIZE (int)
    GREEN_SIZE (int)
    BLUE_SIZE (int)
    ALPHA_SIZE (int)
    DEPTH_SIZE (int)
    STENCIL_SIZE (int)
    ACCUM_GREEN_SIZE (int)
    ACCUM_ALPHA_SIZE (int)
  ]

type gl_area = [drawing glarea widget]

class area_signals :
  'a[> glarea widget] obj -> ?after:bool ->
  object
    inherit GObj.widget_signals
    val obj : 'a obj
    method display : callback:(unit -> unit) -> GtkSignal.id
    method reshape :
      callback:(width:int -> height:int -> unit) -> GtkSignal.id
  end

class area :
  visual_options list ->
  ?share:[> glarea] obj ->
  ?width:int ->
  ?height:int ->
  ?packing:(area -> unit) ->
  ?show:bool ->
  object
    inherit GObj.widget
    val obj : gl_area obj
    method add_events : Gdk.Tags.event_mask list -> unit
    method connect : ?after:bool -> area_signals
    method set_size : width:int -> height:int -> unit
    method make_current : unit -> unit
    method swap_buffers : unit -> unit
  end
class area_wrapper : gl_area obj -> area


module Raw :
  sig
    external create :
      visual_options list -> share:[> glarea] optobj -> gl_area obj
      = "ml_gtk_gl_area_new"
    external swap_buffers : [> glarea] obj -> unit
      = "ml_gtk_gl_area_swapbuffers"
    external make_current : [> glarea] obj -> bool
      = "ml_gtk_gl_area_make_current"
  end

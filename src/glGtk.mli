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

class area :
  visual_options list ->
  ?share:[> glarea] obj ->
  ?width:int ->
  ?height:int ->
  ?packing:(area -> unit) ->
  ?show:bool ->
  object
    inherit GMisc.drawing_area
    val obj : gl_area obj
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
    external make_current : [> glarea] obj -> unit
      = "ml_gtk_gl_area_make_current"
  end

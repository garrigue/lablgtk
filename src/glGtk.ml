(* $Id$ *)

open Misc
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

type gl_area = [widget drawing glarea]

module Raw = struct
  external create :
    visual_options list -> share:[> glarea] optobj -> gl_area obj
    = "ml_gtk_gl_area_new"

  external swap_buffers : [> glarea] obj -> unit
    = "ml_gtk_gl_area_swapbuffers"

  external make_current : [> glarea] obj -> unit
    = "ml_gtk_gl_area_make_current"
end

class area_wrapper obj = object
  inherit GObj.widget_wrapper (obj : gl_area obj)
  method add_events = GtkBase.Widget.add_events obj
  method set_size = GtkMisc.DrawingArea.size obj
  method swap_buffers () = Raw.swap_buffers obj
  method make_current () = Raw.make_current obj
end

class area options ?:share ?:width [< 0 >] ?:height [< 0 >]
    ?:packing ?:show =
  let w = Raw.create options share:(optboxed share) in
  let () =
    if width <> 0 || height <> 0 then
      GtkMisc.DrawingArea.size w :width :height in
  object (self)
    inherit area_wrapper w
    initializer GObj.pack_return :packing ?:show (self :> area_wrapper)
  end

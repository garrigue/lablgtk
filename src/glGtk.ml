(* $Id$ *)

open Misc
open Gtk

type visual_options = [
    `USE_GL
  | `BUFFER_SIZE (int)
  | `LEVEL (int)
  | `RGBA
  | `DOUBLEBUFFER
  | `STEREO
  | `AUX_BUFFERS (int)
  | `RED_SIZE (int)
  | `GREEN_SIZE (int)
  | `BLUE_SIZE (int)
  | `ALPHA_SIZE (int)
  | `DEPTH_SIZE (int)
  | `STENCIL_SIZE (int)
  | `ACCUM_GREEN_SIZE (int)
  | `ACCUM_ALPHA_SIZE (int)
  ]

type gl_area = [`widget|`drawing|`glarea]

module Raw = struct
  external create :
    visual_options list -> share:[>`glarea] optobj -> gl_area obj
    = "ml_gtk_gl_area_new"

  external swap_buffers : [>`glarea] obj -> unit
    = "ml_gtk_gl_area_swapbuffers"

  external make_current : [>`glarea] obj -> bool
    = "ml_gtk_gl_area_make_current"
end

class area_signals obj = object (connect)
  inherit GObj.widget_signals obj as super
  method display :callback =
    connect#event#expose callback:
      begin fun ev ->
	if GdkEvent.Expose.count ev = 0 then
	  if Raw.make_current obj then callback ()
	  else prerr_endline "GlGtk-WARNING **: could not make current";
	true
      end
  method reshape :callback =
    connect#event#configure callback:
      begin fun ev ->
	if Raw.make_current obj then begin
	  callback width:(GdkEvent.Configure.width ev)
	    height:(GdkEvent.Configure.height ev)
	end
	else prerr_endline "GlGtk-WARNING **: could not make current";
	true
      end
  method realize :callback =
    super#realize callback:
      begin fun ev ->
	if Raw.make_current obj then callback ()
	else prerr_endline "GlGtk-WARNING **: could not make current"
      end
end

class area obj = object
  inherit GObj.widget (obj : gl_area obj)
  method as_area = obj
  method connect = new area_signals obj
  method add_events = GtkBase.Widget.add_events obj
  method set_size = GtkMisc.DrawingArea.size obj
  method swap_buffers () = Raw.swap_buffers obj
  method make_current () =
    if not (Raw.make_current obj) then
      raise (Gl.GLerror "make_current")
end

let area options ?:share ?(:width=0) ?(:height=0) ?:packing ?:show () =
  let share =
    match share with Some (x : area) -> Some x#as_area | None -> None in
  let w = Raw.create options share:(optboxed share) in
  if width <> 0 || height <> 0 then GtkMisc.DrawingArea.size w :width :height;
  GtkBase.Widget.add_events w [`EXPOSURE];
  GObj.pack_return (new area w) :packing :show

(* $Id$ *)

open Gaux
open Gtk

type visual_options = [
  | `USE_GL
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

module GtkRaw = struct
  external create :
    visual_options list -> share:[>`glarea] optobj -> gl_area obj
    = "ml_gtk_gl_area_new"

  external swap_buffers : [>`glarea] obj -> unit
    = "ml_gtk_gl_area_swap_buffers"

  external make_current : [>`glarea] obj -> bool
    = "ml_gtk_gl_area_make_current"
end

class area_signals obj =
object (connect)
  inherit GObj.widget_signals_impl (obj : [> gl_area] obj)
  method display ~callback =
    (new GObj.event_signals obj)#after#expose ~callback:
      begin fun ev ->
	if GdkEvent.Expose.count ev = 0 then
	  if GtkRaw.make_current obj then callback ()
	  else prerr_endline "GlGtk-WARNING **: could not make current";
	true
      end
  method reshape ~callback =
    (new GObj.event_signals obj)#after#configure ~callback:
      begin fun ev ->
	if GtkRaw.make_current obj then begin
	  callback ~width:(GdkEvent.Configure.width ev)
	    ~height:(GdkEvent.Configure.height ev)
	end
	else prerr_endline "GlGtk-WARNING **: could not make current";
	true
      end
  method realize ~callback =
    (new GObj.misc_signals (obj :> Gtk.widget obj))#after#realize ~callback:
      begin fun ev ->
	if GtkRaw.make_current obj then callback ()
	else prerr_endline "GlGtk-WARNING **: could not make current"
      end
end

class area obj = object (self)
  inherit GObj.widget (obj : gl_area obj)
  method as_area = obj
  method event = new GObj.event_ops obj
  method connect = new area_signals obj
  method set_size = GtkMisc.DrawingArea.size obj
  method swap_buffers () = GtkRaw.swap_buffers obj
  method make_current () =
    if not (GtkRaw.make_current obj) then
      raise (Gl.GLerror "make_current")
end

let area options ?share ?(width=0) ?(height=0) ?packing ?show () =
  let share =
    match share with Some (x : area) -> Some x#as_area | None -> None in
  let w = GtkRaw.create options ~share:(Gpointer.optboxed share) in
  if width <> 0 || height <> 0 then GtkMisc.DrawingArea.size w ~width ~height;
  GtkBase.Widget.add_events w [`EXPOSURE];
  GObj.pack_return (new area w) ~packing ~show

let region_of_raw raw =
  Gpointer.unsafe_create_region ~path:[|1|] ~get_length:Raw.byte_size raw

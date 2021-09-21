(**************************************************************************)
(*                Lablgtk                                                 *)
(*                                                                        *)
(*    This program is free software; you can redistribute it              *)
(*    and/or modify it under the terms of the GNU Library General         *)
(*    Public License as published by the Free Software Foundation         *)
(*    version 2, with the exception described in file COPYING which       *)
(*    comes with the library.                                             *)
(*                                                                        *)
(*    This program is distributed in the hope that it will be useful,     *)
(*    but WITHOUT ANY WARRANTY; without even the implied warranty of      *)
(*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       *)
(*    GNU Library General Public License for more details.                *)
(*                                                                        *)
(*    You should have received a copy of the GNU Library General          *)
(*    Public License along with this program; if not, write to the        *)
(*    Free Software Foundation, Inc., 59 Temple Place, Suite 330,         *)
(*    Boston, MA 02111-1307  USA                                          *)
(*                                                                        *)
(*                                                                        *)
(**************************************************************************)

(* $Id$ *)

open Gaux
open Gtk

type gl_area = [Gtk.drawing_area|`glarea]

module GtkRaw = struct
  external create : unit -> gl_area obj = "ml_gtk_gl_area_new"

  external make_current : [>`glarea] obj -> unit = "ml_gtk_gl_area_make_current"

  external set_has_alpha : [>`glarea] obj -> bool -> unit = "ml_gtk_gl_area_set_has_alpha"
  external get_has_alpha : [>`glarea] obj -> bool = "ml_gtk_gl_area_get_has_alpha"

  external set_has_depth_buffer : [>`glarea] obj -> bool -> unit = "ml_gtk_gl_area_set_has_depth_buffer"
  external get_has_depth_buffer : [>`glarea] obj -> bool = "ml_gtk_gl_area_get_has_depth_buffer"

  external set_has_stencil_buffer : [>`glarea] obj -> bool -> unit = "ml_gtk_gl_area_set_has_stencil_buffer"
  external get_has_stencil_buffer : [>`glarea] obj -> bool = "ml_gtk_gl_area_get_has_stencil_buffer"

  external set_has_auto_render : [>`glarea] obj -> bool -> unit = "ml_gtk_gl_area_set_auto_render"
  external get_has_auto_render : [>`glarea] obj -> bool = "ml_gtk_gl_area_get_auto_render"

  external set_required_version : [>`glarea] obj -> int -> int -> unit = "ml_gtk_gl_area_set_required_version"
  external get_required_version : [>`glarea] obj -> (int * int) = "ml_gtk_gl_area_get_required_version"

end

class area_signals obj =
object (connect)
  inherit GObj.widget_signals_impl (obj : [> gl_area] obj)
  method display ~callback =
    (new GObj.event_signals obj)#after#expose ~callback:
      begin fun ev ->
	if GdkEvent.Expose.count ev = 0 then begin
            GtkRaw.make_current obj;
            callback ()
        end;
	true
      end


  method render ~callback =
    let render =
      GtkSignal.{name="render"; classe=`widget; marshaller=fun f ->
        marshal1_ret ~ret:Gobject.Data.boolean
          (Gobject.Data.gobject_option : _ Gobject.data_conv)
          "Gtk::render" f} in
    let f = connect#connect render in
    f (fun _ -> callback ())

  method reshape ~(callback: (width:int -> height:int -> unit)) =
    (new GObj.event_signals obj)#after#configure ~callback:
      begin fun ev ->
        GtkRaw.make_current obj;
	callback ~width:(GdkEvent.Configure.width ev) ~height:(GdkEvent.Configure.height ev);
	true
      end
  method realize ~callback =
    (new GObj.misc_signals (obj :> Gtk.widget obj))#after#realize ~callback:
      begin fun ev ->
        GtkRaw.make_current obj;
        callback ()
      end
end

class area obj = object (self)
  inherit GObj.widget (obj : gl_area obj)
  method as_area = obj
  method event = new GObj.event_ops obj
  method connect = new area_signals obj
  (* method set_size = GtkMisc.DrawingArea.size obj *)
  method make_current () = ignore (GtkRaw.make_current obj) 

  method set_has_alpha = GtkRaw.set_has_alpha obj
  method get_has_alpha () = GtkRaw.get_has_alpha obj

  method set_has_depth_buffer = GtkRaw.set_has_depth_buffer obj
  method get_has_depth_buffer () = GtkRaw.get_has_depth_buffer obj

  method set_has_stencil_buffer = GtkRaw.set_has_stencil_buffer obj
  method get_has_stencil_buffer () = GtkRaw.get_has_stencil_buffer obj

  method set_has_auto_render = GtkRaw.set_has_auto_render obj
  method get_has_auto_render () = GtkRaw.get_has_auto_render obj

  method set_required_version = GtkRaw.set_required_version obj
  method get_required_version () = GtkRaw.get_required_version obj
  
end

let area ?packing ?show () =
  let w = GtkRaw.create () in
  GtkBase.Widget.add_events w [`EXPOSURE];
  GObj.pack_return (new area w) ~packing ~show


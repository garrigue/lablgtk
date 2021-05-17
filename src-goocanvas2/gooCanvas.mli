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

(** {2 GooCanvas interface} *)

open Gtk
open GooCanvasEnums
open GtkGooCanvas

class item_signals : ([>GooCanvas_types.item] as 'a) Gtk.obj ->
  object
    inherit ['a] GObj.gobject_signals
    method button_press : callback:(GdkEvent.Button.t -> bool) -> GtkSignal.id
    method button_release :
        callback:(GdkEvent.Button.t -> bool) -> GtkSignal.id
    method enter_notify :
        callback:(GdkEvent.Crossing.t -> bool) -> GtkSignal.id
    method focus_in : callback:(GdkEvent.Focus.t -> bool) -> GtkSignal.id
    method focus_out : callback:(GdkEvent.Focus.t -> bool) -> GtkSignal.id
    method key_press : callback:(GdkEvent.Key.t -> bool) -> GtkSignal.id
    method key_release : callback:(GdkEvent.Key.t -> bool) -> GtkSignal.id
    method leave_notify :
        callback:(GdkEvent.Crossing.t -> bool) -> GtkSignal.id
    method motion_notify :
        callback:(GdkEvent.Motion.t -> bool) -> GtkSignal.id
end

class ['p] item :
  ([> GooCanvas_types.item] as 'o) Gtk.obj ->
  object('i)
      constraint 'p = [< items_properties]
      inherit GObj.gtkobj
      val obj : 'o obj
      method as_item : GooCanvas_types.item obj
      method connect : item_signals
      method get_bounds : float * float * float * float
      method set : 'p list -> unit
      method remove : unit
      method raise : unit -> unit
      method set_parent : GooCanvas_types.item obj -> unit
      method get_n_children : int
      method remove_child : int -> unit
  end

type base_item = item_p item
class canvas :
  GooCanvas_types.canvas obj ->
    object
      inherit GContainer.container
      val obj : GooCanvas_types.canvas obj
      method event : GObj.event_ops
      method as_canvas : GooCanvas_types.canvas obj
      method get_bounds : float * float * float * float
      method set_bounds : left:float -> top:float -> right:float -> bottom: float -> unit
      method get_root_item : item_p item
      method set_root_item : item_p item -> unit
      method convert_to_item_space : base_item -> x:float -> y:float -> (float * float)
      method convert_from_item_space : base_item -> x:float -> y:float -> (float * float)
      method convert_to_pixels : x:float -> y:float -> (float * float)
      method convert_from_pixels : x:float -> y:float -> (float * float)
      method get_scale : float
      method set_scale : float -> unit
      method get_item_at : ?is_pointer_event:bool -> x:float -> y:float -> unit -> base_item option
      method scroll_to : x:float -> y:float -> unit
    end

val canvas :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(GObj.widget -> unit) ->
  ?show:bool ->
  unit -> canvas

class text :
  GooCanvas_types.text Gtk.obj ->
  object
    inherit [text_p] item
    val obj : GooCanvas_types.text Gtk.obj
  end
val text :
  ?text:string ->
  ?x:float ->
  ?y:float ->
  ?width:float ->
  ?props:GtkGooCanvas.text_p list -> 'a item -> text

class rect :
  GooCanvas_types.rect Gtk.obj ->
  object
    inherit [rect_p] item
    val obj : GooCanvas_types.rect Gtk.obj
  end
val rect :
  ?x:float ->
  ?y:float ->
  ?width:float ->
  ?height:float ->
  ?props:GtkGooCanvas.rect_p list -> 'a item -> rect


class widget :
  GooCanvas_types.widget Gtk.obj ->
  object
    inherit [widget_p] item
    val obj : GooCanvas_types.widget Gtk.obj
  end
val widget :
  ?x:float ->
  ?y:float ->
  ?width:float ->
  ?height:float ->
  ?props:GtkGooCanvas.widget_p list -> Gtk.widget obj -> 'a item -> widget

class group :
  GooCanvas_types.group Gtk.obj ->
  object
    inherit [group_p] item
    val obj : GooCanvas_types.group Gtk.obj
    method width : float
  end
val group : ?props:GtkGooCanvas.group_p list -> ?parent:'a item -> unit -> group

val canvas_points : (float * float) list -> canvas_points

class polyline :
  GooCanvas_types.polyline Gtk.obj ->
  object
    inherit [polyline_p] item
    val obj : GooCanvas_types.polyline Gtk.obj
  end

val polyline :
  ?close_path:bool -> ?points:(float * float) list ->
  ?props:GtkGooCanvas.polyline_p list -> 'a item -> polyline

val polyline_line :
  x1:float -> y1:float -> x2:float -> y2:float ->
  ?props:GtkGooCanvas.polyline_p list -> 'a item -> polyline

  
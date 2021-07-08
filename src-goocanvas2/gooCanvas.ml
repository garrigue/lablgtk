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

open Gaux
open GtkGooCanvas
open GooCanvasEnums
open Gobject
open Gtk
open GtkBase
open GooCanvas_types
open OgtkGooCanvasProps
open GObj

let coord_array_to_tuple = function
| [| x1 ; y1 ; x2 ; y2 |] -> (x1, y1, x2, y2)
| _ -> assert false

module Tags = struct
  include (GooCanvasEnums : module type of GooCanvasEnums
                      with module Conv := GooCanvasEnums.Conv)
end

let canvas_points_conv = (Gobject.Data.unsafe_pointer : GtkGooCanvas.canvas_points data_conv)

let propertize = function
| `ALPHA a -> "alpha", `FLOAT a
| `ANCHOR a -> "anchor", GooCanvasEnums.Conv.anchor_type.Gobject.inj a
| `ARROW_LENGTH l -> "arrow-length", `FLOAT l
| `ARROW_TIP_LENGTH l -> "arrow-tip-length", `FLOAT l
| `ARROW_WIDTH w -> "arrow-width", `FLOAT w
| `CAN_FOCUS b -> "can-focus", `BOOL b
| `CLIP_PATH s -> "clip-path", `STRING (Some s)
| `CLOSE_PATH b -> "close-path", `BOOL b
| `DESCRIPTION s -> "description", `STRING (Some s)
| `END_ARROW b -> "end-arrow", `BOOL b
| `FILL_COLOR s -> "fill-color", `STRING (Some s)
| `FILL_COLOR_RGBA c -> "fill-color-rgba", `INT32 c
| `FILL_PIXBUF (p : GdkPixbuf.pixbuf) -> "fill-pixbuf", `OBJECT (Some (Gobject.coerce p))
| `FONT t -> "font", `STRING (Some t)
| `FONT_DESC d -> "font-desc", GtkGooCanvasProps.ItemSimple.P.font_desc.conv.inj d
| `HEIGHT h -> "height", `FLOAT h
| `LINE_JOIN_MITER_LIMIT f -> "line-join-miter-limit", `FLOAT f
| `LINE_WIDTH w -> "line-width", `FLOAT w
| `PIXBUF p -> "pixbuf", `OBJECT (Some (Gobject.coerce p))
| `POINTER_EVENTS e -> "pointer-events", GooCanvasEnums.Conv.pointer_events.inj e
| `POINTS p -> "points", canvas_points_conv.inj p
| `RADIUS_X r -> "radius-x", `FLOAT r
| `RADIUS_Y r -> "radius-y", `FLOAT r
| `SCALE_TO_FIT b -> "scale-to-fit", `BOOL b
| `START_ARROW b -> "start-arrow", `BOOL b
| `STROKE_COLOR s -> "stroke-color", `STRING (Some s)
| `STROKE_COLOR_RGBA c -> "stroke-color-rgba", `INT32 c
| `STROKE_PIXBUF (p : GdkPixbuf.pixbuf) -> "stroke-pixbuf", `OBJECT (Some (Gobject.coerce p))
| `TEXT s -> "text", `STRING (Some s)
| `TITLE s -> "title", `STRING (Some s)
| `TOOLTIP s -> "tooltip", `STRING (Some s)
| `USE_MARKUP b -> "use-markup", `BOOL b
| `WIDTH w -> "width", `FLOAT w
| `WIDGET w -> "widget", `OBJECT (Some (Gobject.coerce w))
| `VISIBILITY v -> "visibility", GooCanvasEnums.Conv.item_visibility.Gobject.inj v
| `VISIBILITY_THRESHOLD t -> "visibility-threshold", `FLOAT t
| `X x -> "x", `FLOAT x
| `Y y -> "y", `FLOAT y


let set_properties obj p =
  List.iter
    (fun p -> let p, d = propertize p in Gobject.Property.set_dyn obj p d)
    p

class item_signals (obj: ([>GooCanvas_types.item] as 'a) Gtk.obj) =
  object (self)
    inherit ['a] GObj.gobject_signals obj
    method button_press = self#connect Item.Signals.Event.button_press
    method button_release = self#connect Item.Signals.Event.button_release
    method enter_notify = self#connect Item.Signals.Event.enter_notify
    method focus_in = self#connect Item.Signals.Event.focus_in
    method focus_out = self#connect Item.Signals.Event.focus_out
    method key_press = self#connect Item.Signals.Event.key_press
    method key_release = self#connect Item.Signals.Event.key_release
    method leave_notify = self#connect Item.Signals.Event.leave_notify
    method motion_notify = self#connect Item.Signals.Event.motion_notify
end
class ['p] item (obj : ([>GooCanvas_types.item] as 'o) obj) =
  object(self)
  constraint 'p = [< items_properties]
  inherit GObj.gtkobj obj
  method as_item = (obj :> GooCanvas_types.item obj)
  method set (p: 'p list) = set_properties obj p
  method get_bounds = coord_array_to_tuple (Item.get_bounds (obj:>GooCanvas_types.item obj))
  method remove = GtkGooCanvas.Item.remove (obj:>GooCanvas_types.item obj)
  method connect = new item_signals (obj :> GooCanvas_types.item Gtk.obj)
  method raise () = Item.raise self#as_item None
  method set_parent (i : GooCanvas_types.item obj) = Item.set_parent self#as_item i
  method get_n_children = Item.get_n_children self#as_item
  method remove_child n = Item.remove_child self#as_item n
  end

type base_item = item_p item

class canvas (obj : GooCanvas_types.canvas obj) =
  object(self)
    inherit GContainer.container obj
    method as_canvas = (obj : GooCanvas_types.canvas obj)
    method event = new GObj.event_ops obj
    method get_bounds = coord_array_to_tuple (Canvas.get_bounds obj)
    method set_bounds = Canvas.set_bounds obj
    method get_root_item : base_item = new item (Canvas.get_root_item obj)
    method set_root_item (i:base_item) = Canvas.set_root_item obj i#as_item
    method convert_to_item_space (i:base_item) ~x ~y =
      Canvas.convert_to_item_space obj i#as_item x y
    method convert_from_item_space (i:base_item) ~x ~y =
      Canvas.convert_from_item_space obj i#as_item x y
    method convert_to_pixels ~x ~y = Canvas.convert_to_pixels obj x y
    method convert_from_pixels ~x ~y = Canvas.convert_from_pixels obj x y
    method get_scale = Canvas.get_scale obj
    method set_scale s = Canvas.set_scale obj s
    method get_item_at ?(is_pointer_event=false) ~x ~y () =
      match Canvas.get_item_at obj x y is_pointer_event with
      | None -> None
      | Some obj -> let o = new item obj in Some (o:>base_item)
    method scroll_to ~x ~y = Canvas.scroll_to obj x y
  end

let canvas =
  GContainer.pack_container [] ~create:(fun pl ->
    let w = Canvas.new_canvas () in
    Gobject.set_params w pl;
    new canvas w)


class text (obj : GooCanvas_types.text obj) =
  object(self)
    inherit [text_p] item obj
  end

let text ?(text="") ?(x=0.) ?(y=0.) ?(width=(-1.)) ?(props=[]) parent =
  let t = new text (Text.new_text parent#as_item text ~x ~y ~width) in
  t#set props ;
  t

class rect (obj : GooCanvas_types.rect obj) =
  object(self)
    inherit [rect_p] item obj
  end

let rect ?(x=0.) ?(y=0.) ?(width=(-1.)) ?(height=(-1.)) ?(props=[]) parent =
  let t = new rect (Rect.new_rect parent#as_item ~x ~y ~width ~height) in
  t#set props ;
  t

class widget (obj : GooCanvas_types.widget obj) =
  object(self)
    inherit [widget_p] item obj
  end

let widget ?(x=0.) ?(y=0.) ?(width=(-1.)) ?(height=(-1.)) ?(props=[]) w parent =
  let t = new widget (GtkGooCanvas.Widget.new_widget parent#as_item w ~x ~y ~width ~height) in
  t#set props ;
  t

class image (obj : GooCanvas_types.image obj) =
  object(self)
    inherit [image_p] item obj
  end

let image ?(x=0.) ?(y=0.) ?pixbuf ?(props=[]) parent =
  let t = new image (GtkGooCanvas.Image.new_image parent#as_item ~x ~y ~pixbuf) in
  t#set props ;
  t

class group (obj : GooCanvas_types.group obj) =
  object(self)
    inherit [group_p] item obj
    method width = Gobject.Property.get obj GtkGooCanvas.Group.width
  end

let group ?(props=[]) ?parent () =
  let parent = match parent with None -> None | Some p -> Some p#as_item in
  let t = new group (Group.new_group parent) in
  t#set props ;
  t

class polyline (obj : GooCanvas_types.polyline obj) =
  object(self)
    inherit [polyline_p] item obj
  end

let canvas_points =
  let from_pairs =
    let rec iter acc = function
    | [] -> List.rev acc
    | (x, y) :: q -> iter (y :: x :: acc) q
    in
    iter []
  in
  fun l ->
    let t = Array.of_list (from_pairs l) in
    let len = Array.length t in
    GtkGooCanvas.Points.new_points len t

let polyline ?(close_path=true) ?points ?(props=[]) parent =
  let t = new polyline (Polyline.new_polyline parent#as_item close_path) in
  let props =
    match points with
    | None -> props
    | Some l -> `POINTS (canvas_points l) :: props
  in
  t#set props ;
  t

let polyline_line ~x1 ~y1 ~x2 ~y2 ?(props=[]) parent =
  let t = new polyline (Polyline.new_polyline_line parent#as_item
    x1 y1 x2 y2)
  in
  t#set props ;
  t

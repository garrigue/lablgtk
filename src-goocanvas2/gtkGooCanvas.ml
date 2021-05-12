
open GooCanvas_types

type canvas_points

type items_properties = [
(*  | `ALIGNMENT of PangoAlignment *)
  | `ANCHOR of GooCanvasEnums.anchor_type
  | `ARROW_LENGTH of float
  | `ARROW_TIP_LENGTH of float
  | `ARROW_WIDTH of float
(*  | `ANTIALIAS of GooCairoAntialias *)
  | `CAN_FOCUS of bool
(*  | `CLIP_FILL_RULE of GooCairoFillRule *)
  | `CLIP_PATH of string
  | `CLOSE_PATH of bool
  | `DESCRIPTION of string
(*  | `ELLIPSIZE of PangoEllipsizeMode *)
  | `END_ARROW of bool
  | `FILL_COLOR of string
  | `FILL_COLOR_RGBA of int32
(*  | `FILL_PATTERN of  GooCairoPattern* *)
  | `FILL_PIXBUF of GdkPixbuf.pixbuf
(*  | `FILL_RULE of GooCairoFillRule *)
  | `FONT of string
  | `FONT_DESC of Pango.font_description
(*  | `HINT_METRICS GooCairoHintMetrics of *)
  | `HEIGHT of float
(*  | `LINE_CAP of GooCairoLineCap*)
(*  | `LINE_DASH of GooCanvasLineDash *)
(*  | `LINE_JOIND of GooCairoLineJoin *)
  | `LINE_JOIN_MITER_LIMIT of float
  | `LINE_WIDTH of float
(*  | `OPERATOR of GooCairoOperator *)
  | `POINTER_EVENTS of GooCanvasEnums.pointer_events list
  | `POINTS of canvas_points
  | `RADIUS_X of float
  | `RADIUS_Y of float
  | `START_ARROW of bool
  | `STROKE_COLOR of string
  | `STROKE_COLOR_RGBA of int32
(*  | `STROKE_PATTERN of GooCairoPattern* *)
  | `STROKE_PIXBUF of GdkPixbuf.pixbuf
  | `TEXT of string
  | `TITLE of string
  | `TOOLTIP of string
(*  | `TRANSFORM of GooCairoMatrix* *)
  | `USE_MARKUP of bool
  | `VISIBILITY of GooCanvasEnums.item_visibility
  | `VISIBILITY_THRESHOLD of float
(*  | `WRAP of PangoWrapMode *)
  | `WIDTH of float
  | `WIDGET of Gtk.widget Gobject.obj
  | `X of float
  | `Y of float
]

type item_p = [
  | `CAN_FOCUS of bool
  | `DESCRIPTION of string
  | `FILL_COLOR of string
  | `FILL_COLOR_RGBA of int32
  | `FILL_PIXBUF of GdkPixbuf.pixbuf
  | `FONT of string
  | `FONT_DESC of Pango.font_description
  | `LINE_JOIN_MITER_LIMIT of float
  | `LINE_WIDTH of float
  | `POINTER_EVENTS of GooCanvasEnums.pointer_events list
  | `STROKE_COLOR of string
  | `STROKE_COLOR_RGBA of int32
  | `STROKE_PIXBUF of GdkPixbuf.pixbuf
  | `TITLE of string
  | `TOOLTIP of string
  | `VISIBILITY of GooCanvasEnums.item_visibility
  | `VISIBILITY_THRESHOLD of float
]

type text_p = [ item_p
  | `ANCHOR of GooCanvasEnums.anchor_type
  | `HEIGHT of float
  | `TEXT of string
  | `USE_MARKUP of bool
  | `WIDTH of float
  | `X of float
  | `Y of float
  ]

type rect_p = [ item_p
  | `HEIGHT of float
  | `RADIUS_X of float
  | `RADIUS_Y of float
  | `WIDTH of float
  | `X of float
  | `Y of float
  ]

type widget_p = [ item_p
  | `ANCHOR of GooCanvasEnums.anchor_type
  | `HEIGHT of float
  | `WIDTH of float
  | `WIDGET of Gtk.widget Gobject.obj
  | `X of float
  | `Y of float
  ]

type group_p = [ item_p
  | `HEIGHT of float
  | `WIDTH of float
  | `X of float
  | `Y of float
  ]

type polyline_p = [ item_p
  | `ARROW_LENGTH of float
  | `ARROW_TIP_LENGTH of float
  | `ARROW_WIDTH of float
  | `CLOSE_PATH of bool
  | `END_ARROW of bool
  | `HEIGHT of float
  | `POINTS of canvas_points
  | `START_ARROW of bool
  | `WIDTH of float
  | `X of float
  | `Y of float
  ]

type item_event =
    [ `BUTTON_PRESS | `BUTTON_RELEASE
    | `MOTION_NOTIFY | `KEY_PRESS | `KEY_RELEASE | `ENTER_NOTIFY | `LEAVE_NOTIFY
    ] Gdk.event

module Item =
  struct
    external get_bounds : item Gobject.obj -> float array = "ml_goo_canvas_item_get_bounds"
    external remove : item Gobject.obj -> unit = "ml_goo_canvas_item_remove"
    external raise : item Gobject.obj -> item Gobject.obj option -> unit = "ml_goo_canvas_item_raise"
    external set_parent : item Gobject.obj -> item Gobject.obj -> unit = "ml_goo_canvas_item_set_parent"
    external get_n_children : item Gobject.obj -> int = "ml_goo_canvas_item_get_n_children"
    external remove_child : item Gobject.obj -> int -> unit = "ml_goo_canvas_item_remove_child"

  module Signals = struct
    let marshal = GtkBase.Widget.Signals.Event.marshal
    module Event = struct
      open GtkSignal
      let marshal f argv =
        match Gobject.Closure.get_args argv with
        | _ :: _ :: [`POINTER(Some p)] ->
            let ev = GdkEvent.unsafe_copy p in
            Gobject.Closure.set_result argv (`BOOL(f ev))
        | _ -> invalid_arg "GtkGooCanvas.Item.Signals.Event.marshal"

      let button_press : ([>`oocanvasitem], GdkEvent.Button.t -> bool) t =
        { name = "button_press_event"; classe = `oocanvasitem;
          marshaller = marshal }
      let button_release : ([>`oocanvasitem], GdkEvent.Button.t -> bool) t =
        { name = "button_release_event"; classe = `oocanvasitem;
          marshaller = marshal }
      let enter_notify : ([>`oocanvasitem], GdkEvent.Crossing.t -> bool) t =
        { name = "enter_notify_event"; classe = `oocanvasitem;
          marshaller = marshal }
      let focus_in : ([>`oocanvasitem], GdkEvent.Focus.t -> bool) t =
        { name = "focus_in_event"; classe = `oocanvasitem;
          marshaller = marshal }
      let focus_out : ([>`oocanvasitem], GdkEvent.Focus.t -> bool) t =
        { name = "focus_out_event"; classe = `oocanvasitem;
          marshaller = marshal }
      let key_press : ([>`oocanvasitem], GdkEvent.Key.t -> bool) t =
        { name = "key_press_event"; classe = `oocanvasitem;
          marshaller = marshal }
      let key_release : ([>`oocanvasitem], GdkEvent.Key.t -> bool) t =
        { name = "key_release_event"; classe = `oocanvasitem;
          marshaller = marshal }
      let leave_notify : ([>`oocanvasitem], GdkEvent.Crossing.t -> bool) t =
        { name = "leave_notify_event"; classe = `oocanvasitem;
          marshaller = marshal }
      let motion_notify : ([>`oocanvasitem], GdkEvent.Motion.t -> bool) t =
        { name = "motion_notify_event"; classe = `oocanvasitem;
          marshaller = marshal }

          end
    end
  end

module Canvas =
  struct
    external new_canvas : unit -> canvas Gobject.obj = "ml_goo_canvas_new"
    external get_bounds : canvas Gobject.obj -> float array = "ml_goo_canvas_get_bounds"
    external set_bounds : canvas Gobject.obj ->
      left:float -> top:float -> right:float -> bottom: float -> unit = "ml_goo_canvas_set_bounds"
    external get_root_item : [>canvas] Gobject.obj -> item Gobject.obj = "ml_goo_canvas_get_root_item"
    external set_root_item : [>canvas] Gobject.obj -> [>item] Gobject.obj -> unit = "ml_goo_canvas_set_root_item"

    external convert_to_item_space :  [>canvas] Gobject.obj -> item Gobject.obj ->
      float -> float -> float * float = "ml_goo_canvas_convert_to_item_space"
    external convert_from_item_space :  [>canvas] Gobject.obj -> item Gobject.obj ->
      float -> float -> float * float = "ml_goo_canvas_convert_from_item_space"

    external convert_to_pixels :  [>canvas] Gobject.obj ->
      float -> float -> float * float = "ml_goo_canvas_convert_to_pixels"
    external convert_from_pixels :  [>canvas] Gobject.obj ->
      float -> float -> float * float = "ml_goo_canvas_convert_from_pixels"

    external get_scale : [>canvas] Gobject.obj -> float = "ml_goo_canvas_get_scale"
    external set_scale : [>canvas] Gobject.obj -> float -> unit = "ml_goo_canvas_set_scale"

    external get_item_at : [>canvas] Gobject.obj -> float -> float -> bool ->
      item Gobject.obj option = "ml_goo_canvas_get_item_at"

    external scroll_to : [>canvas] Gobject.obj -> float -> float -> unit =
      "ml_goo_canvas_scroll_to"
  end

module Text =
  struct
    external new_text : item Gobject.obj-> string -> x:float -> y:float -> width:float -> text Gobject.obj = "ml_goo_canvas_text_new"
  end

module Rect =
  struct
    external new_rect : item Gobject.obj-> x:float -> y:float -> width:float -> height:float -> rect Gobject.obj = "ml_goo_canvas_rect_new"
  end

module Widget =
  struct
    external new_widget : item Gobject.obj-> Gtk.widget Gobject.obj -> x:float -> y:float -> width:float -> height:float -> widget Gobject.obj = "ml_goo_canvas_widget_new_bc" "ml_goo_canvas_widget_new"
  end

module Group =
  struct
    external new_group : item Gobject.obj option-> group Gobject.obj = "ml_goo_canvas_group_new"
    let width = { Gobject.name = "width"; Gobject.conv = Gobject.Data.double }

  end

module Points =
  struct
    external new_points : int -> float array -> canvas_points = "ml_goo_canvas_points_new"
  end

module Polyline =
  struct
    external new_polyline : item Gobject.obj -> bool -> polyline Gobject.obj = "ml_goo_canvas_polyline_new"
    external new_polyline_line : item Gobject.obj -> float -> float -> float -> float -> polyline Gobject.obj = "ml_goo_canvas_polyline_new_line"
  end

(* $Id$ *)

open GnomeCanvas

type items_properties = [ 
  | `NO_WIDGET
  | `NO_FILL_COLOR
  | `NO_OUTLINE_COLOR
  | `NO_FONT
  | `NO_TEXT
  | `NO_BPATH
  | `NO_PIXBUF
  | `SIZE_PIXELS of bool
  | `WIDGET of GObj.widget
  | `PIXBUF of GdkPixbuf.pixbuf
  | `WIDTH of float
  | `HEIGHT of float
  | `BPATH of PathDef.t
  | `DASH of float * float array
  | `ANCHOR of Gtk.Tags.anchor_type
  | `JUSTIFICATION of Gtk.Tags.justification
  | `CAP_STYLE of Gdk.GC.gdkCapStyle
  | `JOIN_STYLE of Gdk.GC.gdkJoinStyle
  | `LINE_STYLE of Gdk.GC.gdkLineStyle
  | `SMOOTH of bool
  | `FIRST_ARROWHEAD of bool
  | `LAST_ARROWHEAD of bool
  | `ARROW_SHAPE_A of float
  | `ARROW_SHAPE_B of float
  | `ARROW_SHAPE_C of float
  | `POINTS of float array
  | `FILL_COLOR of string
  | `FILL_COLOR_RGBA of int32
  | `FILL_STIPPLE of Gdk.bitmap
  | `FONT of string
  | `OUTLINE_COLOR of string
  | `OUTLINE_COLOR_RGBA of int32
  | `OUTLINE_STIPPLE of Gdk.bitmap
  | `SIZE of int
  | `TEXT of string
  | `EDITABLE of bool
  | `VISIBLE of bool
  | `CURSOR_VISIBLE of bool
  | `CURSOR_BLINK of bool
  | `GROW_HEIGHT of bool
  | `LEFT_MARGIN of int
  | `RIGHT_MARGIN of int
  | `CLIP of bool
  | `CLIP_WIDTH of float
  | `CLIP_HEIGHT of float
  | `X_OFFSET of float
  | `Y_OFFSET of float
  | `WIDTH_UNITS of float
  | `WIDTH_PIXELS of int
  | `X of float
  | `X1 of float
  | `X2 of float
  | `Y of float
  | `Y1 of float
  | `Y2 of float] 

let encode tbl v = `INT (Gpointer.encode_variant tbl v)
let propertize = function
  | `X v -> "x", `FLOAT v
  | `Y v -> "y", `FLOAT v
  | `X1 v -> "x1", `FLOAT v
  | `Y1 v -> "y1", `FLOAT v
  | `X2 v -> "x2", `FLOAT v
  | `Y2 v -> "y2", `FLOAT v
  | `OUTLINE_COLOR c -> "outline_color", `STRING (Some c)
  | `OUTLINE_COLOR_RGBA c -> "outline_color_rgba", `INT32 c
  | `OUTLINE_STIPPLE (d : Gdk.bitmap) ->
      "outline_stipple", `OBJECT (Some (Gobject.coerce d))
  | `FILL_COLOR c -> "fill_color", `STRING (Some c)
  | `FILL_COLOR_RGBA c -> "fill_color_rgba", `INT32 c
  | `FILL_STIPPLE (d : Gdk.bitmap) ->
      "fill_stipple", `OBJECT (Some (Gobject.coerce d))
  | `WIDTH_UNITS v -> "width_units", `FLOAT v
  | `WIDTH_PIXELS v -> "width_pixels", `INT v
  | `TEXT t -> "text", `STRING (Some t)
  | `FONT t -> "font", `STRING (Some t)
  | `SIZE i -> "size", `INT i
  | `EDITABLE b -> "editable", `BOOL b
  | `VISIBLE b -> "visible", `BOOL b
  | `CURSOR_VISIBLE b -> "cursor_visible", `BOOL b
  | `CURSOR_BLINK b -> "cursor_blink", `BOOL b
  | `GROW_HEIGHT b -> "grow_height", `BOOL b
  | `LEFT_MARGIN i -> "left_margin", `INT i
  | `RIGHT_MARGIN i -> "right_margin", `INT i
  | `CLIP b -> "clip", `BOOL b
  | `CLIP_WIDTH v -> "clip_width", `FLOAT v
  | `CLIP_HEIGHT v -> "clip_height", `FLOAT v
  | `X_OFFSET v -> "x_offset", `FLOAT v
  | `Y_OFFSET v -> "y_offset", `FLOAT v
  | `POINTS p -> "points", `POINTER (Some (convert_points p))
  | `ARROW_SHAPE_A v -> "arrow_shape_a", `FLOAT v
  | `ARROW_SHAPE_B v -> "arrow_shape_b", `FLOAT v
  | `ARROW_SHAPE_C v -> "arrow_shape_c", `FLOAT v
  | `FIRST_ARROWHEAD b -> "first_arrowhead", `BOOL b
  | `LAST_ARROWHEAD  b -> "last_arrowhead", `BOOL b
  | `ANCHOR a -> "anchor", encode GtkEnums.anchor_type a
  | `JUSTIFICATION j -> "justification", encode GtkEnums.justification j
  | `CAP_STYLE c -> "cap_style", encode GdkEnums.cap_style c
  | `JOIN_STYLE c -> "join_style", encode GdkEnums.join_style c
  | `LINE_STYLE c -> "line_style", encode GdkEnums.line_style c
  | `BPATH p -> "bpath" , `POINTER (Some p)
  | `DASH (off, d) -> "dash", `POINTER (Some (convert_dash off d))
  | `SMOOTH b -> "smooth", `BOOL b
  | `PIXBUF (p : GdkPixbuf.pixbuf) ->
      "pixbuf", `OBJECT (Some (Gobject.coerce p))
  | `WIDTH v -> "width", `FLOAT v
  | `HEIGHT v -> "height", `FLOAT v
  | `SIZE_PIXELS b -> "size_pixels", `BOOL b
  | `WIDGET (w : GObj.widget) ->
      "widget", `OBJECT (Some (Gobject.coerce w#as_widget))
  | `NO_FILL_COLOR -> "fill_color", `STRING None
  | `NO_OUTLINE_COLOR -> "outline_color", `STRING None
  | `NO_FONT -> "font", `STRING None
  | `NO_TEXT -> "text", `STRING None
  | `NO_BPATH -> "bpath", `POINTER None
  | `NO_PIXBUF -> "pixbuf", `OBJECT None
  | `NO_WIDGET -> "widget", `OBJECT None

type item_event = [
  | `BUTTON_PRESS of GdkEvent.Button.t
  | `TWO_BUTTON_PRESS of GdkEvent.Button.t
  | `THREE_BUTTON_PRESS of GdkEvent.Button.t
  | `BUTTON_RELEASE of GdkEvent.Button.t
  | `MOTION_NOTIFY of GdkEvent.Motion.t
  | `KEY_PRESS of GdkEvent.Key.t
  | `KEY_RELEASE of GdkEvent.Key.t
  | `ENTER_NOTIFY of GdkEvent.Crossing.t
  | `LEAVE_NOTIFY of GdkEvent.Crossing.t
  | `FOCUS_CHANGE of GdkEvent.Focus.t ]

let event_proxy : (item_event -> bool) -> GnomeCanvas.item_event -> bool = 
  fun cb ev -> match GdkEvent.get_type ev with
  | `BUTTON_PRESS ->
      cb (`BUTTON_PRESS (GdkEvent.unsafe_cast ev))
  | `TWO_BUTTON_PRESS ->
      cb (`TWO_BUTTON_PRESS (GdkEvent.unsafe_cast ev))
  | `THREE_BUTTON_PRESS ->
      cb (`THREE_BUTTON_PRESS (GdkEvent.unsafe_cast ev))
  | `BUTTON_RELEASE ->
      cb (`BUTTON_RELEASE (GdkEvent.unsafe_cast ev))
  | `MOTION_NOTIFY ->
      cb (`MOTION_NOTIFY (GdkEvent.unsafe_cast ev))
  | `KEY_PRESS ->
      cb (`KEY_PRESS (GdkEvent.unsafe_cast ev))
  | `KEY_RELEASE ->
      cb (`KEY_RELEASE (GdkEvent.unsafe_cast ev))
  | `ENTER_NOTIFY ->
      cb (`ENTER_NOTIFY (GdkEvent.unsafe_cast ev))
  | `LEAVE_NOTIFY ->
      cb (`LEAVE_NOTIFY (GdkEvent.unsafe_cast ev))
  | `FOCUS_CHANGE ->
      cb (`FOCUS_CHANGE (GdkEvent.unsafe_cast ev))

class item_signals ?after obj = object
  inherit GObj.gtkobj_signals ?after obj
  method event ~callback =
    GtkSignal.connect 
      ~sgn:Item.Signals.event 
      ~callback:(event_proxy callback) ~after obj
end

class ['p] item obj = object
  inherit GObj.gtkobj obj
  constraint 'p = [< items_properties]
  method connect = new item_signals (obj :> GnomeCanvas.item Gtk.obj)
  method set (p : 'p list) =
    List.iter
      (fun p -> let p, d = propertize p in Gobject.Property.set_dyn obj p d)
      p;
    Item.set obj
  method as_item = (obj :> GnomeCanvas.item Gtk.obj)
  method canvas = Item.canvas obj
  method parent = Item.parent obj
  method xform = Item.xform obj
  method affine_relative = Item.affine_relative obj
  method affine_absolute = Item.affine_absolute obj
  method move = Item.move obj
  method raise = Item.raise obj
  method lower = Item.lower obj
  method raise_to_top () = Item.raise_to_top obj
  method lower_to_bottom () = Item.lower_to_bottom obj
  method show () = Item.show obj
  method hide () = Item.hide obj
  method grab = Item.grab obj
  method ungrab = Item.ungrab obj
  method w2i = Item.w2i obj
  method i2w = Item.i2w obj
  method i2w_affine = Item.i2w_affine obj
  method i2c_affine = Item.i2c_affine obj
  method reparent grp = Item.reparent obj grp
  method grab_focus () = Item.grab_focus obj
  method get_bounds = Item.get_bounds obj
end

class group grp_obj = object
  inherit [GnomeCanvas.group_p] item grp_obj
  method as_group = (grp_obj : GnomeCanvas.group Gtk.obj)
  method get_items =
    Group.get_items grp_obj
end

class richtext rchtxt_obj = object
  inherit [GnomeCanvas.richtext_p] item (rchtxt_obj : GnomeCanvas.richtext Gtk.obj)
  method cut_clipboard () = RichText.cut_clipboard obj
  method copy_clipboard () = RichText.copy_clipboard obj
  method paste_clipboard () = RichText.paste_clipboard obj
  method get_buffer = new GText.buffer (RichText.get_buffer obj)
end

class canvas obj = object
  inherit GPack.layout (obj : GnomeCanvas.canvas Gtk.obj)
  val aa = { Gobject.name = "aa" ; Gobject.classe = `canvas ; Gobject.conv = Gobject.Data.boolean }
  method root = new group (Canvas.root obj)
  method aa = Gobject.Property.get obj aa
  method set_scroll_region = Canvas.set_scroll_region obj
  method get_scroll_region = Canvas.get_scroll_region obj
  method set_center_scroll_region = Canvas.set_center_scroll_region obj
  method get_center_scroll_region = Canvas.get_center_scroll_region obj
  method set_pixels_per_unit = Canvas.set_pixels_per_unit obj
  method scroll_to = Canvas.scroll_to obj
  method get_scroll_offsets = Canvas.get_scroll_offsets obj
  method update_now () = Canvas.update_now obj
  method get_item_at ~x ~y = Canvas.get_item_at obj ~x ~y
  method w2c_affine = Canvas.w2c_affine obj
  method w2c = Canvas.w2c obj
  method w2c_d = Canvas.w2c_d obj
  method c2w = Canvas.c2w obj
  method window_to_world = Canvas.window_to_world obj
  method world_to_window   = Canvas.world_to_window obj
end

let canvas ?(aa=false) =
  GContainer.pack_container [] ~create:(fun pl ->
    let w =
      if aa then Canvas.new_canvas_aa () else Canvas.new_canvas () in
    Gobject.set_params w pl;
    new canvas w)

let wrap_item o (typ : (_, 'p) Types.t) =
  if not (Types.is_a o typ)
  then raise (Gobject.Cannot_cast (Gobject.Type.name (Gobject.get_type o), 
				   Types.name typ)) ;
  (new item o : 'p item)

let construct_item (typ : (_, 'p) Types.t) ~props parent =
  let i = Item.new_item parent#as_group typ in
  let o = (new item i : 'p item) in
  if props <> [] then o#set props ;
  o

let unoption_list ~rest l =
  List.rev_append
    (List.fold_left (fun acc -> function Some v -> v :: acc | None -> acc) [] l)
    rest

let group ?x ?y parent =
  let i = Item.new_item parent#as_group Types.group in
  let g = new group i in
  let props = unoption_list ~rest:[]
      [ ( match x with None -> None | Some v -> Some (`X v) ) ;
	( match y with None -> None | Some v -> Some (`Y v) ) ; ] in
  if props <> [] then g#set props ;
  g

type rect = GnomeCanvas.re_p item
let rect ?x1 ?y1 ?x2 ?y2 ?fill_color ?(props=[]) p = 
  let props = unoption_list ~rest:props
      [ ( match x1 with None -> None | Some v -> Some (`X1 v) ) ;
	( match y1 with None -> None | Some v -> Some (`Y1 v) ) ;
	( match x2 with None -> None | Some v -> Some (`X2 v) ) ;
	( match y2 with None -> None | Some v -> Some (`Y2 v) ) ;
	( match fill_color with None -> None | Some v -> Some (`FILL_COLOR v) ) ;
      ] in
  construct_item Types.rect ~props p

type ellipse = GnomeCanvas.re_p item
let ellipse ?x1 ?y1 ?x2 ?y2 ?fill_color ?(props=[]) p = 
  let props = unoption_list ~rest:props
      [ ( match x1 with None -> None | Some v -> Some (`X1 v) ) ;
	( match y1 with None -> None | Some v -> Some (`Y1 v) ) ;
	( match x2 with None -> None | Some v -> Some (`X2 v) ) ;
	( match y2 with None -> None | Some v -> Some (`Y2 v) ) ;
	( match fill_color with None -> None | Some v -> Some (`FILL_COLOR v) ) ;
      ] in
  construct_item Types.ellipse ~props p

type text = GnomeCanvas.text_p item
let text ?x ?y ?text ?font ?size ?anchor ?(props=[]) p =
  let props = unoption_list ~rest:props
      [ ( match x with None -> None | Some v -> Some (`X v) ) ;
	( match y with None -> None | Some v -> Some (`Y v) ) ;
	( match text with None -> None | Some v -> Some (`TEXT v) ) ;
	( match font with None -> None | Some v -> Some (`FONT v) ) ;
	( match size with None -> None | Some v -> Some (`SIZE v) ) ;
	( match anchor with None -> None | Some v -> Some (`ANCHOR v) ) ; 
      ] in
  construct_item Types.text ~props p

type line = GnomeCanvas.line_p item
let line ?points ?fill_color ?(props=[]) p = 
  let props = unoption_list ~rest:props
      [ ( match points with None -> None | Some v -> Some (`POINTS v) ) ;
	( match fill_color with None -> None | Some v -> Some (`FILL_COLOR v) ) ;
      ] in
  construct_item Types.line ~props p

type bpath = GnomeCanvas.bpath_p item
let bpath ?bpath ?fill_color ?(props=[]) p = 
  let props = unoption_list ~rest:props
      [ ( match bpath with None -> None | Some v -> Some (`BPATH v) ) ;
	( match fill_color with None -> None | Some v -> Some (`FILL_COLOR v) ) ;
      ] in
  construct_item Types.bpath ~props p

type pixbuf = GnomeCanvas.pixbuf_p item
let pixbuf ?x ?y ?pixbuf ?width ?height ?(props=[]) p =
  let width = match (width, pixbuf) with
  | (None, Some p) -> Some (`WIDTH (float (GdkPixbuf.get_width p)))
  | (None, _) -> None
  | (Some v, _) -> Some (`WIDTH v) in
  let height = match (height, pixbuf) with
  | (None, Some p) -> Some (`HEIGHT (float (GdkPixbuf.get_height p)))
  | (None, _) -> None
  | (Some v, _) -> Some (`HEIGHT v) in
  let props = unoption_list ~rest:props
      [ ( match x with None -> None | Some v -> Some (`X v) ) ;
	( match y with None -> None | Some v -> Some (`Y v) ) ;
	( match pixbuf with None -> None | Some v -> Some (`PIXBUF v) ) ;
	width ; height ;
      ] in
  construct_item Types.pixbuf ~props p

type polygon = GnomeCanvas.polygon_p item
let polygon ?points ?fill_color ?(props=[]) p =
  let props = unoption_list ~rest:props
      [ ( match points with None -> None | Some v -> Some (`POINTS v) ) ;
	( match fill_color with None -> None | Some v -> Some (`FILL_COLOR v) ) ;
      ] in
  construct_item Types.polygon ~props p

type widget = GnomeCanvas.widget_p item
let widget ?widget ?x ?y ?width ?height ?(props=[]) p =
  let w = match widget with None -> None | Some wi -> Some (`WIDGET wi#coerce) in
  let props = unoption_list ~rest:props
      [ ( match x with None -> None | Some v -> Some (`X v) ) ;
	( match y with None -> None | Some v -> Some (`Y v) ) ;
	( match width with None -> None | Some v -> Some (`WIDTH v) ) ;
	( match height with None -> None | Some v -> Some (`HEIGHT v) ) ;
	w ] in
  construct_item Types.widget ~props p

let richtext ?x ?y ?text ?width ?height ?(props=[]) p =
  let props = unoption_list ~rest:props
      [ ( match x with None -> None | Some v -> Some (`X v) ) ;
	( match y with None -> None | Some v -> Some (`Y v) ) ;
	( match width with None -> None | Some v -> Some (`WIDTH v) ) ;
	( match height with None -> None | Some v -> Some (`HEIGHT v) ) ;
	( match text with None -> None | Some t -> Some (`TEXT t) ) ;
      ] in
  let i = Item.new_item p#as_group Types.richtext in
  let o = new richtext i in
  if props <> [] then o#set props ;
  o

let parent i =
  new group (i#parent)

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
  | `BPATH of GnomeCanvas.PathDef.t
  | `ANCHOR of Gtk.Tags.anchor_type
  | `JUSTIFICATION of Gtk.Tags.justification
  | `CAP_STYLE of Gdk.GC.gdkCapStyle
  | `JOIN_STYLE of Gdk.GC.gdkJoinStyle
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
  | `SIZE of int
  | `TEXT of string
  | `EDITABLE of bool
  | `VISIBLE of bool
  | `CURSOR_VISIBLE of bool| `CURSOR_BLINK of bool
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

let propertize p =
  let name, g_fund, (g_val : unit Gobject.data_set) = match p with
  | `X v -> "x", `DOUBLE, `FLOAT v
  | `Y v -> "y", `DOUBLE, `FLOAT v
  | `X1 v -> "x1", `DOUBLE, `FLOAT v
  | `Y1 v -> "y1", `DOUBLE, `FLOAT v
  | `X2 v -> "x2", `DOUBLE, `FLOAT v
  | `Y2 v -> "y2", `DOUBLE, `FLOAT v
  | `OUTLINE_COLOR "" -> "outline_color", `STRING, `STRING None
  | `OUTLINE_COLOR c -> "outline_color", `STRING, `STRING (Some c)
  | `FILL_COLOR "" -> "fill_color", `STRING, `STRING None
  | `FILL_COLOR c -> "fill_color", `STRING, `STRING (Some c)
  | `FILL_COLOR_RGBA c -> "fill_color_rgba", `UINT, `INT32 c
  | `FILL_STIPPLE (d : Gdk.bitmap) -> "fill_stipple", `OBJECT, `OBJECT (Some (Gobject.unsafe_cast d))
  | `WIDTH_UNITS v -> "width_units", `DOUBLE, `FLOAT v
  | `WIDTH_PIXELS v -> "width_pixels", `UINT, `INT v
  (* | `TEXT "" -> "text", `STRING, `STRING None *)
  | `TEXT t -> "text", `STRING, `STRING (Some t)
  | `FONT t -> "font", `STRING, `STRING (Some t)
  | `SIZE i -> "size", `INT, `INT i
  | `EDITABLE b -> "editable", `BOOLEAN, `BOOL b
  | `VISIBLE b -> "visible", `BOOLEAN, `BOOL b
  | `CURSOR_VISIBLE b -> "cursor_visible", `BOOLEAN, `BOOL b
  | `CURSOR_BLINK b -> "cursor_blink", `BOOLEAN, `BOOL b
  | `GROW_HEIGHT b -> "grow_height", `BOOLEAN, `BOOL b
  | `LEFT_MARGIN i -> "left_margin", `INT, `INT i
  | `RIGHT_MARGIN i -> "right_margin", `INT, `INT i
  | `CLIP b -> "clip", `BOOLEAN, `BOOL b
  | `CLIP_WIDTH v -> "clip_width", `DOUBLE, `FLOAT v
  | `CLIP_HEIGHT v -> "clip_height", `DOUBLE, `FLOAT v
  | `X_OFFSET v -> "x_offset", `DOUBLE, `FLOAT v
  | `Y_OFFSET v -> "y_offset", `DOUBLE, `FLOAT v
  | `POINTS p -> "points", `GVAL (GnomeCanvas.convert_points p), `BOOL false
  | `ARROW_SHAPE_A v -> "arrow_shape_a", `DOUBLE, `FLOAT v
  | `ARROW_SHAPE_B v -> "arrow_shape_b", `DOUBLE, `FLOAT v
  | `ARROW_SHAPE_C v -> "arrow_shape_c", `DOUBLE, `FLOAT v
  | `FIRST_ARROWHEAD b -> "first_arrowhead", `BOOLEAN, `BOOL b
  | `LAST_ARROWHEAD  b -> "last_arrowhead", `BOOLEAN, `BOOL b
  | `ANCHOR a -> "anchor", `INT, `INT (GnomeCanvas.convert_tags (GnomeCanvas.ANCHOR a))
  | `JUSTIFICATION j -> "justification", `INT, `INT (GnomeCanvas.convert_tags (GnomeCanvas.JUSTIFICATION j))
  | `CAP_STYLE c -> "cap_style", `INT, `INT (GnomeCanvas.convert_tags (GnomeCanvas.CAPSTYLE c))
  | `JOIN_STYLE c -> "join_style", `INT, `INT (GnomeCanvas.convert_tags (GnomeCanvas.JOINSTYLE c))
  | `BPATH p -> "bpath", `POINTER , `POINTER (Some p)
  | `SMOOTH b -> "smooth", `BOOLEAN, `BOOL b
  | `PIXBUF (p : GdkPixbuf.pixbuf) -> "pixbuf", `OBJECT, `OBJECT (Some (Gobject.unsafe_cast p))
  | `WIDTH v -> "width", `DOUBLE, `FLOAT v
  | `HEIGHT v -> "height", `DOUBLE, `FLOAT v
  | `SIZE_PIXELS b -> "size_pixels", `BOOLEAN, `BOOL b
  | `WIDGET (w : GObj.widget) -> "widget", `OBJECT, `OBJECT (Some (Gobject.unsafe_cast w#as_widget))
  | `NO_FILL_COLOR -> "fill_color", `STRING, `STRING None
  | `NO_OUTLINE_COLOR -> "outline_color", `STRING, `STRING None
  | `NO_FONT -> "font", `STRING, `STRING None
  | `NO_TEXT -> "text", `STRING, `STRING None
  | `NO_BPATH -> "bpath", `POINTER, `POINTER None
  | `NO_PIXBUF -> "pixbuf", `OBJECT, `OBJECT None
  | `NO_WIDGET -> "widget", `OBJECT, `OBJECT None
  in
  let v = match g_fund with
  | `GVAL v -> v
  | #Gobject.Tags.fundamental_type as f -> 
      let v = Gobject.Value.create (Gobject.Type.of_fundamental f)  in
      Gobject.Value.set v g_val ; v
  in
  name, v

class item_signals ?after obj = object
  inherit GObj.gtkobj_signals ?after obj
  method event : callback:(GdkEvent.any -> bool) -> GtkSignal.id =
    GtkSignal.connect ~sgn:GnomeCanvas.Item.Signals.event ~after obj
end

class ['p] item obj = object
  inherit GObj.gtkobj obj
  method connect = new item_signals (obj :> GnomeCanvas.item Gtk.obj)
  method set_raw = GnomeCanvas.Item.set obj
  method set (p : 'p list) =
    GnomeCanvas.Item.set obj (List.map propertize p)
  method as_item = (obj :> GnomeCanvas.item Gtk.obj)
  method canvas = GnomeCanvas.Item.canvas obj
  method parent = GnomeCanvas.Item.parent obj
  method xform = GnomeCanvas.Item.xform obj
  method affine_relative = GnomeCanvas.Item.affine_relative obj
  method affine_absolute = GnomeCanvas.Item.affine_absolute obj
  method move = GnomeCanvas.Item.move obj
  method raise = GnomeCanvas.Item.raise obj
  method lower = GnomeCanvas.Item.lower obj
  method raise_to_top () = GnomeCanvas.Item.raise_to_top obj
  method lower_to_bottom () = GnomeCanvas.Item.lower_to_bottom obj
  method show () = GnomeCanvas.Item.show obj
  method hide () = GnomeCanvas.Item.hide obj
  method grab = GnomeCanvas.Item.grab obj
  method ungrab = GnomeCanvas.Item.ungrab obj
  method w2i = GnomeCanvas.Item.w2i obj
  method i2w = GnomeCanvas.Item.i2w obj
  method reparent grp = GnomeCanvas.Item.reparent obj grp
  method grab_focus () = GnomeCanvas.Item.grab_focus obj
  method get_bounds = GnomeCanvas.Item.get_bounds obj
end

class group grp_obj = object
  inherit [GnomeCanvas.Types.group_p] item grp_obj
  method as_group = (grp_obj : GnomeCanvas.group Gtk.obj)
  method get_items =
    (* List.map (fun i -> new item i) *)
      (GnomeCanvas.Group.get_items grp_obj)
end

class richtext rchtxt_obj = object
  inherit [GnomeCanvas.Types.richtext_p] item (rchtxt_obj : GnomeCanvas.richtext Gtk.obj)
  method cut_clipboard () = GnomeCanvas.RichText.cut_clipboard obj
  method copy_clipboard () = GnomeCanvas.RichText.copy_clipboard obj
  method paste_clipboard () = GnomeCanvas.RichText.paste_clipboard obj
  method get_buffer = new GText.buffer (GnomeCanvas.RichText.get_buffer obj)
end

class canvas obj = object
  inherit GPack.layout (obj : GnomeCanvas.canvas Gtk.obj)
  (* inherit GObj.widget_full (obj : GnomeCanvas.canvas Gtk.obj) *)
  (* method event = new GObj.event_ops obj *)
  method root = new group (GnomeCanvas.Canvas.root obj)
  method aa =
    let v = Gobject.Value.create (Gobject.Type.of_fundamental `BOOLEAN) in
    Gobject.get_property obj "aa" v ;
    match Gobject.Value.get v with
    | `BOOL b -> b
    | _ -> failwith "unexpected type for property"
  method set_scroll_region = GnomeCanvas.Canvas.set_scroll_region obj
  method get_scroll_region = GnomeCanvas.Canvas.get_scroll_region obj
  method set_center_scroll_region = GnomeCanvas.Canvas.set_center_scroll_region obj
  method get_center_scroll_region = GnomeCanvas.Canvas.get_center_scroll_region obj
  method set_pixels_per_unit = GnomeCanvas.Canvas.set_pixels_per_unit obj
  method scroll_to = GnomeCanvas.Canvas.scroll_to obj
  method get_scroll_offsets = GnomeCanvas.Canvas.get_scroll_offsets obj
  method update_now () = GnomeCanvas.Canvas.update_now obj
  method get_item_at ~x ~y = GnomeCanvas.Canvas.get_item_at obj ~x ~y
  method w2c_affine = GnomeCanvas.Canvas.w2c_affine obj
  method w2c = GnomeCanvas.Canvas.w2c obj
  method w2c_d = GnomeCanvas.Canvas.w2c_d obj
  method c2w = GnomeCanvas.Canvas.c2w obj
  method window_to_world = GnomeCanvas.Canvas.window_to_world obj
  method world_to_window   = GnomeCanvas.Canvas.world_to_window obj
end

let canvas ?(aa=false) ?border_width ?width ?height ?packing ?show () =
  let w = if aa
  then GnomeCanvas.Canvas.new_canvas_aa ()
  else GnomeCanvas.Canvas.new_canvas () in
  GtkBase.Container.set w ?border_width ?width ?height ;
  GObj.pack_return (new canvas w) ~packing ~show

let wrap_item o (typ : (_, 'p) GnomeCanvas.Types.t) =
  if not (GnomeCanvas.Types.is_a o typ)
  then raise (Gobject.Cannot_cast (Gobject.Type.name (Gobject.get_type o), 
				   GnomeCanvas.Types.name typ)) ;
  (new item o : 'p item)

let item (typ : (_, 'p) GnomeCanvas.Types.t) ?(props=[]) parent =
  let i = GnomeCanvas.Item.new_item parent#as_group typ in
  let o = (new item i : 'p item) in
  if props <> [] then o#set props ;
  o

let unoption_list ~rest l =
  List.rev_append
    (List.fold_left (fun acc -> function Some v -> v :: acc | None -> acc) [] l)
    rest

let group ?x ?y parent =
  let i = GnomeCanvas.Item.new_item parent#as_group GnomeCanvas.Types.group in
  let g = new group i in
  let props = unoption_list ~rest:[]
      [ ( match x with None -> None | Some v -> Some (`X v) ) ;
	( match y with None -> None | Some v -> Some (`Y v) ) ; ] in
  if props <> [] then g#set props ;
  g

type rect = GnomeCanvas.Types.re_p item
let rect ?props p = item GnomeCanvas.Types.rect ?props p

type ellipse = GnomeCanvas.Types.re_p item
let ellipse ?props p = item GnomeCanvas.Types.ellipse ?props p

type text = GnomeCanvas.Types.text_p item
let text ?x ?y ?text ?font ?size ?anchor ?(props=[]) p =
  let props = unoption_list ~rest:props
      [ ( match x with None -> None | Some v -> Some (`X v) ) ;
	( match y with None -> None | Some v -> Some (`Y v) ) ;
	( match text with None -> None | Some v -> Some (`TEXT v) ) ;
	( match font with None -> None | Some v -> Some (`FONT v) ) ;
	( match size with None -> None | Some v -> Some (`SIZE v) ) ;
	( match anchor with None -> None | Some v -> Some (`ANCHOR v) ) ; 
      ] in
  item GnomeCanvas.Types.text ~props p

type line = GnomeCanvas.Types.line_p item
let line ?props p = item GnomeCanvas.Types.line ?props p

type bpath = GnomeCanvas.Types.bpath_p item
let bpath ?bpath ?fill_color ?(props=[]) p = 
  let props = unoption_list ~rest:props
      [ ( match bpath with None -> None | Some v -> Some (`BPATH v) ) ;
	( match fill_color with None -> None | Some v -> Some (`FILL_COLOR v) ) ;
      ] in
  item GnomeCanvas.Types.bpath ~props p

type pixbuf = GnomeCanvas.Types.pixbuf_p item
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
  item GnomeCanvas.Types.pixbuf ~props p

type polygon = GnomeCanvas.Types.polygon_p item
let polygon ?points ?(props=[]) p =
  let props = 
    match points with None -> props | Some p -> `POINTS p :: props in
  item GnomeCanvas.Types.polygon ~props p

type widget = GnomeCanvas.Types.widget_p item
let widget ?widget ?x ?y ?width ?height ?(props=[]) p =
  let w = match widget with None -> None | Some wi -> Some (`WIDGET wi#coerce) in
  let props = unoption_list ~rest:props
      [ ( match x with None -> None | Some v -> Some (`X v) ) ;
	( match y with None -> None | Some v -> Some (`Y v) ) ;
	( match width with None -> None | Some v -> Some (`WIDTH v) ) ;
	( match height with None -> None | Some v -> Some (`HEIGHT v) ) ;
	w ] in
  item GnomeCanvas.Types.widget ~props p

let richtext ?x ?y ?text ?width ?height ?(props=[]) p =
  let props = unoption_list ~rest:props
      [ ( match x with None -> None | Some v -> Some (`X v) ) ;
	( match y with None -> None | Some v -> Some (`Y v) ) ;
	( match width with None -> None | Some v -> Some (`WIDTH v) ) ;
	( match height with None -> None | Some v -> Some (`HEIGHT v) ) ;
	( match text with None -> None | Some t -> Some (`TEXT t) ) ;
      ] in
  let i = GnomeCanvas.Item.new_item p#as_group GnomeCanvas.Types.richtext in
  let o = new richtext i in
  if props <> [] then o#set props ;
  o

let parent i =
  new group (i#parent)

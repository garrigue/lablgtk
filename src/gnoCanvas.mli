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
      
val propertize : [< items_properties] -> string * Gobject.g_value

class item_signals :
  ?after:bool -> 'b Gtk.obj ->
  object
    constraint 'b = [> GnomeCanvas.item]
    inherit GObj.gtkobj_signals
    val obj : 'b Gtk.obj
    method event : callback:(GdkEvent.any -> bool) -> GtkSignal.id
  end

class ['a] item : 'b Gtk.obj ->
  object
    constraint 'a = [< items_properties]
    constraint 'b = [> GnomeCanvas.item]
    inherit GObj.gtkobj
    val obj : 'b Gtk.obj
    method as_item : GnomeCanvas.item Gtk.obj
    method connect : item_signals
    method get_bounds : float array
    method grab : Gdk.Tags.event_mask list -> Gdk.cursor -> int32 -> unit
    method grab_focus : unit -> unit
    method hide : unit -> unit
    method i2w : x:float -> y:float -> float * float
    method lower : int -> unit
    method lower_to_bottom : unit -> unit
    method move : x:float -> y:float -> unit
    method parent : GnomeCanvas.group Gobject.obj
    method canvas : GnomeCanvas.canvas Gobject.obj
    method xform : [`IDENTITY|`TRANSL of float array|`AFFINE of float array]
    method affine_relative : float array -> unit
    method affine_absolute : float array -> unit
    method raise : int -> unit
    method raise_to_top : unit -> unit
    method reparent : GnomeCanvas.group Gobject.obj -> unit
    method set_raw : (string * Gobject.g_value) list -> unit
    method set : 'a list -> unit
    method show : unit -> unit
    method ungrab : int32 -> unit
    method w2i : x:float -> y:float -> float * float
  end

class group : GnomeCanvas.group Gtk.obj ->
  object
    inherit [GnomeCanvas.Types.group_p] item
    val obj : GnomeCanvas.group Gtk.obj
    method as_group : GnomeCanvas.group Gtk.obj
    method get_items : GnomeCanvas.item Gobject.obj list
  end

class richtext : GnomeCanvas.richtext Gtk.obj ->
  object
    inherit [GnomeCanvas.Types.richtext_p] item
    val obj : GnomeCanvas.richtext Gtk.obj
    method copy_clipboard : unit -> unit
    method cut_clipboard : unit -> unit
    method paste_clipboard : unit -> unit
    method get_buffer : GText.buffer
  end

class canvas : GnomeCanvas.canvas Gtk.obj ->
  object
    inherit GPack.layout
    val obj : GnomeCanvas.canvas Gtk.obj
    method aa : bool
    method c2w : cx:float -> cy:float -> float * float
    method get_center_scroll_region : bool
    method get_item_at : x:float -> y:float -> GnomeCanvas.item Gobject.obj
    method get_scroll_offsets : int * int
    method get_scroll_region : float array
    method root : group
    method scroll_to : x:int -> y:int -> unit
    method set_center_scroll_region : bool -> unit
    method set_pixels_per_unit : float -> unit
    method set_scroll_region :
      x1:float -> y1:float -> x2:float -> y2:float -> unit
    method update_now : unit -> unit
    method w2c : wx:float -> wy:float -> int * int
    method w2c_affine : float array
    method w2c_d : wx:float -> wy:float -> float * float
    method window_to_world : winx:float -> winy:float -> float * float
    method world_to_window : wox:float -> woy:float -> float * float
  end

val canvas :
  ?aa:bool ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(GObj.widget -> unit) ->
  ?show:bool ->
  unit -> canvas 

val wrap_item : 
  [> GnomeCanvas.item] Gtk.obj -> ('a, 'p) GnomeCanvas.Types.t -> 'p item

val group : ?x:float -> ?y:float -> #group -> group

type rect = GnomeCanvas.Types.re_p item
val rect :
  ?props:GnomeCanvas.Types.re_p list ->
  #group -> rect

type ellipse = GnomeCanvas.Types.re_p item
val ellipse :
  ?props:GnomeCanvas.Types.re_p list ->
  #group -> ellipse

type text = GnomeCanvas.Types.text_p item
val text :
  ?x:float -> ?y:float -> ?text:string ->
  ?font:string -> ?size:int -> ?anchor:Gtk.Tags.anchor_type ->
  ?props:GnomeCanvas.Types.text_p list ->
  #group -> text

type line = GnomeCanvas.Types.line_p item
val line :
  ?props:GnomeCanvas.Types.line_p list ->
  #group -> line

type bpath = GnomeCanvas.Types.bpath_p item
val bpath :
  ?bpath:GnomeCanvas.PathDef.t ->
  ?fill_color:string ->
  ?props:GnomeCanvas.Types.bpath_p list ->
  #group -> bpath

type pixbuf = GnomeCanvas.Types.pixbuf_p item
val pixbuf :
  ?x:float -> ?y:float -> ?pixbuf:GdkPixbuf.pixbuf ->
  ?width:float -> ?height:float ->
  ?props:GnomeCanvas.Types.pixbuf_p list ->
  #group -> pixbuf

type polygon = GnomeCanvas.Types.polygon_p item
val polygon :
  ?points:float array ->
  ?props:GnomeCanvas.Types.polygon_p list ->
  #group -> polygon

type widget = GnomeCanvas.Types.widget_p item
val widget :
  ?widget:< coerce: GObj.widget; .. > ->
  ?x:float -> ?y:float -> 
  ?width:float -> ?height:float ->
  ?props:GnomeCanvas.Types.widget_p list ->
  #group -> widget

val richtext :
  ?x:float -> ?y:float ->
  ?text:string ->
  ?width:float -> ?height:float ->
  ?props:GnomeCanvas.Types.richtext_p list ->
  #group -> richtext

val parent : 'a #item -> group

(* $Id$ *)

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
      
val propertize : [< items_properties] -> string * unit Gobject.data_set

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

class item_signals :
  ?after:bool -> 'b Gtk.obj ->
  object
    constraint 'b = [> GnomeCanvas.item]
    inherit GObj.gtkobj_signals
    val obj : 'b Gtk.obj
    method event : callback:(item_event -> bool) -> GtkSignal.id
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
    method i2c_affine : float array
    method i2w : x:float -> y:float -> float * float
    method i2w_affine : float array
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
    method set : 'a list -> unit
    method show : unit -> unit
    method ungrab : int32 -> unit
    method w2i : x:float -> y:float -> float * float
  end

class group : GnomeCanvas.group Gtk.obj ->
  object
    inherit [GnomeCanvas.group_p] item
    val obj : GnomeCanvas.group Gtk.obj
    method as_group : GnomeCanvas.group Gtk.obj
    method get_items : GnomeCanvas.item Gobject.obj list
  end

class rich_text : GnomeCanvas.rich_text Gtk.obj ->
  object
    inherit [GnomeCanvas.rich_text_p] item
    val obj : GnomeCanvas.rich_text Gtk.obj
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

type rect = GnomeCanvas.re_p item
val rect :
  ?x1:float -> ?y1:float -> 
  ?x2:float -> ?y2:float -> 
  ?fill_color:string ->
  ?props:GnomeCanvas.re_p list ->
  #group -> rect

type ellipse = GnomeCanvas.re_p item
val ellipse :
  ?x1:float -> ?y1:float -> 
  ?x2:float -> ?y2:float -> 
  ?fill_color:string ->
  ?props:GnomeCanvas.re_p list ->
  #group -> ellipse

type text = GnomeCanvas.text_p item
val text :
  ?x:float -> ?y:float -> ?text:string ->
  ?font:string -> ?size:int -> ?anchor:Gtk.Tags.anchor_type ->
  ?props:GnomeCanvas.text_p list ->
  #group -> text

type line = GnomeCanvas.line_p item
val line :
  ?points:float array ->
  ?fill_color:string ->
  ?props:GnomeCanvas.line_p list ->
  #group -> line

type bpath = GnomeCanvas.bpath_p item
val bpath :
  ?bpath:GnomeCanvas.PathDef.t ->
  ?fill_color:string ->
  ?props:GnomeCanvas.bpath_p list ->
  #group -> bpath

type pixbuf = GnomeCanvas.pixbuf_p item
val pixbuf :
  ?x:float -> ?y:float -> ?pixbuf:GdkPixbuf.pixbuf ->
  ?width:float -> ?height:float ->
  ?props:GnomeCanvas.pixbuf_p list ->
  #group -> pixbuf

type polygon = GnomeCanvas.polygon_p item
val polygon :
  ?points:float array ->
  ?fill_color:string ->
  ?props:GnomeCanvas.polygon_p list ->
  #group -> polygon

type widget = GnomeCanvas.widget_p item
val widget :
  ?widget:< coerce: GObj.widget; .. > ->
  ?x:float -> ?y:float -> 
  ?width:float -> ?height:float ->
  ?props:GnomeCanvas.widget_p list ->
  #group -> widget

val rich_text :
  ?x:float -> ?y:float ->
  ?text:string ->
  ?width:float -> ?height:float ->
  ?props:GnomeCanvas.rich_text_p list ->
  #group -> rich_text

val parent : 'a #item -> group

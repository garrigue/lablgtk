type items_properties = [ 
  | `parent of GnomeCanvas.item Gtk.obj
  | `anchor of Gtk.Tags.anchor_type
  | `first_arrowhead of bool
  | `last_arrowhead of bool
  | `arrow_shape_a of float
  | `arrow_shape_b of float
  | `arrow_shape_c of float
  | `points of float array
  | `fill_color of string
  | `font of string
  | `outline_color of string
  | `size of int
  | `text of string
  | `width_units of float
  | `width_pixels of int
  | `x of float
  | `x1 of float
  | `x2 of float
  | `y of float
  | `y1 of float
  | `y2 of float] 
      
val propertize : [< items_properties] -> string * Gobject.g_value

class item_signals :
  ?after:bool -> 'b Gtk.obj ->
  object
    constraint 'b = [> GnomeCanvas.item]
    inherit GObj.gtkobj_signals
    val obj : 'b Gtk.obj
    method event : callback:(GdkEvent.any -> unit) -> GtkSignal.id
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
    method grab_focus : unit
    method hide : unit
    method i2w : x:float -> y:float -> float * float
    method lower : int -> unit
    method lower_to_bottom : unit
    method move : x:float -> y:float -> unit
    method parent : GnomeCanvas.group Gobject.obj
    method raise_item : int -> unit
    method raise_to_top : unit
    method reparent : GnomeCanvas.group Gobject.obj -> unit
    method set_raw : (string * Gobject.g_value) list -> unit
    method set : 'a list -> unit
    method show : unit
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

class canvas : GnomeCanvas.canvas Gtk.obj ->
  object
    inherit GObj.widget_full
    val obj : GnomeCanvas.canvas Gtk.obj
    method c2w : cx:float -> cy:float -> float * float
    method event : GObj.event_ops
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

val item :
  ([> GnomeCanvas.item], [< items_properties] as 'a) GnomeCanvas.Types.t ->
  ?props:'a list -> #group -> 'a item

val group :
  ?props:GnomeCanvas.Types.group_p list ->
  #group -> group


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
  ?props:GnomeCanvas.Types.text_p list ->
  #group -> text

type line = GnomeCanvas.Types.line_p item
val line :
  ?props:GnomeCanvas.Types.line_p list ->
  #group -> line

val parent : 'a #item -> [< items_properties] item

(* $Id$ *)

open Misc
open GdkObj
open GtkObj

class ['a] menu_factory (menu : 'a)
    ?:accel_group [< Gtk.AccelGroup.create () >]
    ?:accel_mod [< [`CONTROL] >]
    ?:accel_flags [< [`VISIBLE] >] =
  object (self)
    val menu : #menu_shell = menu
    val group = accel_group
    val m = accel_mod
    val flags = accel_flags
    method menu = menu
    method accel_group = group
    method private bind (item : menu_item) ?:key ?:callback =
      menu#append item;
      may key fun:
	(fun key -> item#add_accelerator group :key mod:m :flags);
      may callback fun:(fun callback -> item#connect#activate :callback)
    method add_item :label ?:key ?:callback ?:submenu =
      let item = new_menu_item :label in
      self#bind item ?:key ?:callback;
      may (submenu : menu option) fun:item#set_submenu;
      item
    method add_check_item :label ?:active ?:key ?:callback =
      let item = new_check_menu_item :label ?:active in
      self#bind (item :> menu_item) ?:key
	?callback:(may_map callback fun:(fun f () -> f item#active));
      item
    method add_radio_item :label ?:group ?:active ?:key ?:callback =
      let item = new_radio_menu_item :label ?:group ?:active in
      self#bind (item :> menu_item) ?:key
	?callback:(may_map callback fun:(fun f () -> f item#active));
      item
    method add_separator () = new_menu_item packing:menu#append
    method add_submenu :label ?:key =
      let item = new_menu_item :label in
      self#bind item ?:key;
      new_menu packing:item#set_submenu
end

class pixdraw parent:(w : #GtkObj.widget) :width :height =
  let depth = w#misc#realize (); Gtk.Style.get_depth w#misc#style in
  let window = w#misc#window in
  object
    inherit [[pixmap]] drawing
	(Gdk.Pixmap.create window :width :height :depth) as pixmap
    val mask = new drawing (Gdk.Bitmap.create window :width :height)
    method mask = mask
    method point :x :y =
      pixmap#point :x :y;
      mask#point :x :y
    method line :x :y :x :y =
      pixmap#line :x :y :x :y;
      mask#line :x :y :x :y
    method rectangle :x :y :width :height ?:filled =
      pixmap#rectangle :x :y :width :height ?:filled;
      mask#rectangle :x :y :width :height ?:filled
    method arc :x :y :width :height ?:filled ?:start ?:angle =
      pixmap#arc :x :y :width :height ?:filled ?:start ?:angle;
      mask#arc :x :y :width :height ?:filled ?:start ?:angle;
    method polygon l ?:filled =
      pixmap#polygon l ?:filled;
      mask#polygon l ?:filled
    method string s :font :x :y =
      pixmap#string s :font :x :y;
      mask#string s :font :x :y
    initializer
      mask#set foreground:`BLACK;
      mask#rectangle x:0 y:0 :width :height filled:true;
      mask#set foreground:`WHITE
  end


let new_pixdraw (pd : #pixdraw) =
  GtkObj.new_pixmap pd#raw mask:pd#mask#raw
let set_pixdraw (pm : #GtkObj.pixmap) (pd : #pixdraw) =
  pm#set pixmap:pd#raw mask:pd#mask#raw

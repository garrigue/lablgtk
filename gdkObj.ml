(* $Id$ *)

open Misc
open Gdk

type color = [COLOR(Color.t) WHITE BLACK NAME(string) RGB(int*int*int)]

let color : color -> Color.t = function
    `COLOR col -> col
  | `WHITE|`BLACK|`NAME _|`RGB _ as def -> Color.alloc def

let gc_set gc ?:foreground ?:background =
  Misc.may foreground fun:(fun col -> GC.set_foreground gc (color col));
  Misc.may background fun:(fun col -> GC.set_background gc (color col))

class ['a] drawing w = object
  val gc = GC.create w
  val w : 'a drawable = w
  method raw = w
  method set = gc_set ?gc
  method point = Draw.point w gc
  method line = Draw.line w gc
  method rectangle = Draw.rectangle w gc
  method arc = Draw.arc w gc
  method polygon = Draw.polygon w gc
  method string s = Draw.string w gc string:s
end

class pixdraw parent:(w : #GtkObj.widget) :width :height =
  let depth = w#misc#realize (); Gtk.Style.get_depth w#misc#style in
  let window = w#misc#window in
  object
    inherit [[pixmap]] drawing
	(Pixmap.create window :width :height :depth) as pixmap
    val mask = new drawing (Bitmap.create window :width :height)
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

(* $Id$ *)

open Misc
open Gdk

type color = [Color(Color.t) White Black Name(string) RGB(int*int*int)]

let color : color -> Color.t = function
    `Color col -> col
  | `White|`Black|`Name _|`RGB _ as def -> Color.alloc def

let gc_set gc ?:foreground ?:background =
  Misc.may foreground fun:(fun col -> GC.set_foreground gc (color col));
  Misc.may background fun:(fun col -> GC.set_background gc (color col))

class ['a] drawing w = object
  val gc = GC.create w
  val w : 'a drawable = w
  method raw = w
  method set = gc_set ?gc
  method arc = Draw.arc w gc
  method rectangle :x :y :width :height ?:filled =
    Draw.rectangle w gc :x :y :width :height ?:filled
  method polygon = Draw.polygon w gc
end

class pixdraw parent:(w : _ #GtkObj.widget_skel) :width :height =
  let depth = w#misc#realize (); Gtk.Style.get_depth w#misc#style in
  let window = w#misc#window in
  object
    inherit [[pixmap]] drawing
	(Pixmap.create window :width :height :depth) as pixmap
    val mask = new drawing (Bitmap.create window :width :height)
    method mask = mask
    method arc :x :y :width :height ?:filled ?:start ?:angle =
      pixmap#arc :x :y :width :height ?:filled ?:start ?:angle;
      mask#arc :x :y :width :height ?:filled ?:start ?:angle;
    method rectangle :x :y :width :height ?:filled =
      pixmap#rectangle :x :y :width :height ?:filled;
      mask#rectangle :x :y :width :height ?:filled
    method polygon l ?:filled =
      pixmap#polygon l ?:filled;
      mask#polygon l ?:filled
    initializer
      mask#set foreground:`Black;
      mask#rectangle x:0 y:0 :width :height filled:true;
      mask#set foreground:`White
  end


let new_pixdraw (pd : #pixdraw) =
  GtkObj.new_pixmap pd#raw mask:pd#mask#raw
let set_pixdraw (pm : #GtkObj.pixmap) (pd : #pixdraw) =
  pm#set pixmap:pd#raw mask:pd#mask#raw

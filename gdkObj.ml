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
  method set = gc_set ?gc
  method point = Draw.point w gc
  method line = Draw.line w gc
  method rectangle = Draw.rectangle w gc
  method arc = Draw.arc w gc
  method polygon = Draw.polygon w gc
  method string s = Draw.string w gc string:s
end

class pixmap pm ?:mask = object
  inherit [[pixmap]] drawing pm as pixmap
  val bitmap = may_map mask fun:(new drawing)
  val mask : bitmap option = mask
  method pixmap = w
  method mask = mask
  method point :x :y =
    pixmap#point :x :y;
    may bitmap fun:(fun m -> m#point :x :y)
  method line :x :y :x :y =
    pixmap#line :x :y :x :y;
    may bitmap fun:(fun m -> m#line :x :y :x :y)
  method rectangle :x :y :width :height ?:filled =
    pixmap#rectangle :x :y :width :height ?:filled;
    may bitmap fun:(fun m -> m#rectangle :x :y :width :height ?:filled)
  method arc :x :y :width :height ?:filled ?:start ?:angle =
    pixmap#arc :x :y :width :height ?:filled ?:start ?:angle;
    may bitmap
      fun:(fun m -> m#arc :x :y :width :height ?:filled ?:start ?:angle);
  method polygon l ?:filled =
    pixmap#polygon l ?:filled;
    may bitmap fun:(fun m -> m#polygon l ?:filled)
  method string s :font :x :y =
    pixmap#string s :font :x :y;
    may bitmap fun:(fun m -> m#string s :font :x :y)
end

class pixmap_from_xpm :file :window ?:colormap ?:transparent =
  let pm, mask =
    try Pixmap.create_from_xpm window :file ?:colormap
	?transparent:(may_map transparent fun:color)
    with Null_pointer -> invalid_arg "GdkObj.pixmap_from_xpm"
  in pixmap pm :mask

class pixmap_from_xpm_d :data :window ?:colormap ?:transparent =
  let pm, mask =
    Pixmap.create_from_xpm_d window :data ?:colormap
      ?transparent:(may_map transparent fun:color) in
  pixmap pm :mask

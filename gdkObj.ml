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

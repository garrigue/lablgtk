(* $Id$ *)

open Misc
open Gdk

type color = [`COLOR Color.t|`WHITE|`BLACK|`NAME string|`RGB (int*int*int)]

(*
let color : color -> Color.t = function
    `COLOR col -> col
  | `WHITE|`BLACK|`NAME _|`RGB _ as def -> Color.alloc def
*)
let color : color -> Color.t = function
    `COLOR col -> col
  | `WHITE -> Color.alloc `WHITE
  | `BLACK -> Color.alloc `BLACK
  | `NAME x -> Color.alloc (`NAME x)
  | `RGB x -> Color.alloc (`RGB x)

class ['a] drawing w = object
  val gc = GC.create w
  val w : 'a drawable = w
  method set_foreground col = GC.set_foreground gc (color col)
  method set_background col = GC.set_background gc (color col)
  method set_line_attributes = GC.set_line_attributes gc
  method point = Draw.point w gc
  method line = Draw.line w gc
  method rectangle = Draw.rectangle w gc
  method arc = Draw.arc w gc
  method polygon ?:filled l = Draw.polygon w gc ?:filled l
  method string s = Draw.string w gc string:s
  method image image = Draw.image w gc :image
end

class pixmap ?:mask pm = object
  inherit [[`pixmap]] drawing pm as pixmap
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
  method rectangle :x :y :width :height ?:filled () =
    pixmap#rectangle :x :y :width :height ?:filled ();
    may bitmap fun:(fun m -> m#rectangle :x :y :width :height ?:filled ())
  method arc :x :y :width :height ?:filled ?:start ?:angle () =
    pixmap#arc :x :y :width :height ?:filled ?:start ?:angle ();
    may bitmap
      fun:(fun m -> m#arc :x :y :width :height ?:filled ?:start ?:angle ());
  method polygon ?:filled l =
    pixmap#polygon ?:filled l;
    may bitmap fun:(fun m -> m#polygon ?:filled l)
  method string s :font :x :y =
    pixmap#string s :font :x :y;
    may bitmap fun:(fun m -> m#string s :font :x :y)
end

class pixmap_from_xpm :file ?:colormap ?:transparent window =
  let pm, mask =
    try Pixmap.create_from_xpm window :file ?:colormap
	?transparent:(may_map transparent fun:color)
    with Null_pointer -> invalid_arg "GdkObj.pixmap_from_xpm"
  in pixmap pm :mask

class pixmap_from_xpm_d :data ?:colormap ?:transparent window =
  let pm, mask =
    Pixmap.create_from_xpm_d window :data ?:colormap
      ?transparent:(may_map transparent fun:color) in
  pixmap pm :mask

class drag_context context = object
  val context = context
  method status ?:time{=0} act = Gdk.DnD.drag_status context act :time
  method suggested_action = Gdk.DnD.drag_context_suggested_action context
  method targets = Gdk.DnD.drag_context_targets context
end

(* $Id$ *)

open Misc
open Gtk
open GtkData
open GtkMisc
open GUtil
open GObj

class pixmap_wrapper obj = object
  inherit GMisc.misc (obj : pixmap obj)
  method connect = new widget_signals ?obj
  method set = Pixmap.setter ?obj ?cont:null_cont
  method pixmap = Pixmap.pixmap obj
  method mask = Pixmap.mask obj
end

class pixmap pix ?:mask ?:xalign ?:yalign ?:xpad ?:ypad ?:packing =
  let w = Pixmap.create pix ?:mask in
  let () = Misc.setter w cont:null_cont ?:xalign ?:yalign ?:xpad ?:ypad in
  object (self)
    inherit pixmap_wrapper w
    initializer pack_return :packing (self :> pixmap_wrapper)
  end

open GdkObj

class pixdraw parent:(w : #GObj.widget) :width :height =
  let depth = w#misc#realize (); Style.get_depth w#misc#style in
  let window = w#misc#window in
  object (self)
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
    method new_pixmap = new pixmap self#raw mask:mask#raw
  end

let set_pixmap (pm : #pixmap) (px : #pixdraw) =
   pm#set pixmap:px#raw mask:px#mask#raw

(* $Id$ *)

open Misc
open Gtk
open GtkData
open GtkMisc
open GObj

class pixmap_wrapper obj = object
  inherit GMisc.misc (obj : pixmap obj)
  method connect = new widget_signals ?obj
  method set_pixmap : 'a. (#GdkObj.pixmap as 'a) -> unit = fun pm ->
    Pixmap.set obj pixmap:pm#pixmap ?mask:pm#mask
  method pixmap =
    new GdkObj.pixmap (Pixmap.pixmap obj)
      ?mask:(try Some(Pixmap.mask obj) with Null_pointer -> None)
end

class pixmap (pm : #GdkObj.pixmap)
    ?:xalign ?:yalign ?:xpad ?:ypad ?:width ?:height ?:packing ?:show =
  let w = Pixmap.create pm#pixmap ?mask:pm#mask in
  let () =
    Misc.set w ?:xalign ?:yalign ?:xpad ?:ypad ?:width ?:height
  in
  object (self)
    inherit pixmap_wrapper w
    initializer pack_return :packing ?:show (self :> pixmap_wrapper)
  end

class pixdraw parent:(w : #GObj.widget) :width :height =
  let depth = w#misc#realize (); w#misc#visual_depth in
  let window = w#misc#window in
  object
    inherit GdkObj.pixmap (Gdk.Pixmap.create window :width :height :depth)
	mask:(Gdk.Bitmap.create window :width :height)
    initializer
      may bitmap fun:
	begin fun mask ->
	  mask#set foreground:`BLACK;
	  mask#rectangle x:0 y:0 :width :height filled:true;
	  mask#set foreground:`WHITE
	end
  end

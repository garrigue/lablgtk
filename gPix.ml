(* $Id$ *)

open Misc
open Gtk
open GtkBase
open GtkData
open GtkMisc
open GObj

class pixmap obj = object
  inherit GMisc.misc (obj : Gtk.pixmap obj)
  method connect = new widget_signals obj
  method set_pixmap (pm : GdkObj.pixmap) =
    Pixmap.set obj ~pixmap:pm#pixmap ?mask:pm#mask
  method pixmap =
    new GdkObj.pixmap (Pixmap.pixmap obj)
      ?mask:(try Some(Pixmap.mask obj) with Null_pointer -> None)
end

let pixmap (pm : #GdkObj.pixmap) ?xalign ?yalign ?xpad ?ypad
    ?(width = -2) ?(height = -2) ?packing ?show () =
  let w = Pixmap.create pm#pixmap ?mask:pm#mask in
  Misc.set w ?xalign ?yalign ?xpad ?ypad;
  if width <> -2 || height <> -2 then Widget.set_usize w ~width ~height;
  pack_return (new pixmap w) ~packing ~show

class pixdraw ~(window : #GObj.widget) ~width ~height ?(mask=false) () =
  let depth = window#misc#realize (); window#misc#visual_depth in
  let window = window#misc#window in
  object
    inherit GdkObj.pixmap (Gdk.Pixmap.create window ~width ~height ~depth)
	?mask:(if mask then Some(Gdk.Bitmap.create window ~width ~height)
                       else None)
    initializer
      may bitmap ~f:
	begin fun (mask : _ GdkObj.drawing) ->
	  mask#set_foreground `BLACK;
	  mask#rectangle ~x:0 ~y:0 ~width ~height ~filled:true ();
	  mask#set_foreground `WHITE
	end
  end

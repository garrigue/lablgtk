(* $Id$ *)

open Gtk
open Gdk
open GtkObj

let window = new_window `TOPLEVEL
let w = window#misc#realize (); window#misc#window

let pixmap =
  Pixmap.create w width:50 height:50 depth:(Style.get_depth window#misc#style)
let pixmap2 =
  Pixmap.create w width:50 height:50 depth:(Style.get_depth window#misc#style)
let bitmap =
  Bitmap.create w width:50 height:50

let gc = GC.create pixmap
let gc' = GC.create bitmap

let _ =
  GC.set_foreground gc (Color.alloc `Black);
  Draw.arc pixmap gc x:5 y:5 width:40 height:40 filled:true;
  GC.set_foreground gc (Color.alloc `White);
  Draw.arc pixmap2 gc x:5 y:5 width:40 height:40 filled:true;
  GC.set_foreground gc (Color.alloc `Black);
  Draw.arc pixmap2 gc x:5 y:5 width:40 height:40;
  GC.set_foreground gc' (Color.alloc `White);
  Draw.arc bitmap gc' x:5 y:5 width:40 height:40 filled:true;
  Draw.arc bitmap gc' x:5 y:5 width:40 height:40

let pm = new_pixmap pixmap2 mask:bitmap

let table = new_table columns:5 rows:5

class toggle () = object (self)
  inherit button (Button.create ())
  val pm = new_pixmap pixmap mask:bitmap
  val mutable toggle = false
  method swap () =
    toggle <- not toggle;
    pm#set pixmap:(if toggle then pixmap2 else pixmap)
  initializer
    self#add pm;
    self#connect#clicked callback:self#swap;
    ()
end

let _ =
  window#connect#destroy callback:Main.quit;
  window#set title:"pousse";
  window#add table;
  for i = 0 to 4 do for j = 0 to 4 do
    let button = new toggle () in
    button#connect#event#enter_notify
      callback:(fun _ -> button#misc#grab_focus (); false);
    if (i + j) mod 2 = 0 then button#swap ();
    table#attach left:i top:j button
  done done;
  window#show_all ();
  Main.main ()

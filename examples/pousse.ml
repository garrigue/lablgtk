(* $Id$ *)

open Gtk
open GtkObj
open GdkObj

let window = new_window `TOPLEVEL

let pixdraw = new pixdraw parent:window width:50 height:50
let pixdraw2 = new pixdraw parent:window width:50 height:50

let _ =
  pixdraw#set foreground:`Black;
  pixdraw#arc x:5 y:5 width:40 height:40 filled:true;
  pixdraw2#set foreground:`White;
  pixdraw2#arc x:5 y:5 width:40 height:40 filled:true;
  pixdraw2#set foreground:`Black;
  pixdraw2#arc x:5 y:5 width:40 height:40

let table = new_table columns:5 rows:5

class toggle () = object (self)
  inherit button (Button.create ())
  val pm = new_pixdraw pixdraw
  val mutable toggle = false
  method swap () =
    toggle <- not toggle;
    set_pixdraw pm (if toggle then pixdraw2 else pixdraw)
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

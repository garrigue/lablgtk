(* $Id$ *)

open Gtk
open GtkObj

class xpm_label_box :parent :file :label =
  let _ = 
    if not (Sys.file_exists file) then failwith (file ^ " does not exist") in
  object
    inherit box (Box.create `HORIZONTAL) as box

    val pixmapwid =
      parent#widget_ops#realize ();
      let style = parent#widget_ops#style in
      let pixmap, mask =
	Gdk.Pixmap.create_from_xpm (parent#widget_ops#window)
	  transparent:(Style.get_bg style) :file
      in
      new_pixmap pixmap :mask

    val label = new_label :label

    initializer
      box#set border_width: 2;
      List.iter [widgeter pixmapwid; widgeter label]
	fun:(box#pack expand:false fill:false padding:3)

    method show () =
      pixmapwid#show ();
      label#show ();
      box#show ()
  end

let main () =
  let window = new_window `TOPLEVEL in
  window#set title:"Pixmap'd Buttons!" border_width:10;
  window#connect#destroy callback:Main.quit;
  let button = new_button () in
  button#connect#clicked
    callback:(fun () -> prerr_endline "Hello again - cool button was pressed");
  let box =
    new xpm_label_box parent:window file:"info.xpm" label:"cool button" in
  box#show ();
  button#add box;
  button#show ();
  window#add button;
  window#show ();
  Main.main ()

let _ = main ()

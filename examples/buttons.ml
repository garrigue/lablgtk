(* $Id$ *)

open GMain

let xpm_label_box parent:(parent : #GContainer.container)
    :file :text ?:packing{=parent#add} () =
  if not (Sys.file_exists file) then failwith (file ^ " does not exist");
  let box = GPack.hbox border_width: 2 :packing show:false () in
  parent#misc#realize ();
  let pixmap = GdkObj.pixmap_from_xpm :file window:(parent#misc#window) () in
  GPix.pixmap pixmap packing:(box#pack expand:false fill:false padding:3) ();
  GMisc.label :text packing:(box#pack expand:false fill:false padding:3) ();
  box#misc#show ();
  new GObj.widget_full box#as_widget

let main () =
  let window = GWindow.window title:"Pixmap'd Buttons!" border_width:10 () in
  window#connect#destroy callback:Main.quit;
  let button = GButton.button packing:window#add () in
  button#connect#clicked
    callback:(fun () -> prerr_endline "Hello again - cool button was pressed");
  xpm_label_box parent:button file:"test.xpm" text:"cool button" ();
  window#show ();
  Main.main ()

let _ = main ()

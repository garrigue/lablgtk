(* $Id$ *)

open GMain

class xpm_label_box parent:(parent : #GContainer.container)
    :file :text ?:packing =
  let _ = 
    if not (Sys.file_exists file) then failwith (file ^ " does not exist") in
  object (self)
    inherit GPack.box `HORIZONTAL border_width: 2 ?:packing as box

    val pixmapwid =
      parent#misc#realize ();
      let pixmap =
	new GdkObj.pixmap_from_xpm :file window:(parent#misc#window)
      in
      new GPix.pixmap pixmap

    val label = new GMisc.label :text

    initializer
      if packing = None then parent#add self;
      List.iter [(pixmapwid :> GObj.widget); (label :> GObj.widget)]
	fun:(box#pack expand:false fill:false padding:3)
  end

let main () =
  let window =
    new GWindow.window title:"Pixmap'd Buttons!" border_width:10 in
  window#connect#destroy callback:Main.quit;
  let button = new GButton.button packing:window#add in
  button#connect#clicked
    callback:(fun () -> prerr_endline "Hello again - cool button was pressed");
  new xpm_label_box parent:button file:"test.xpm" text:"cool button";
  window#show ();
  Main.main ()

let _ = main ()

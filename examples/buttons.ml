(* $Id$ *)

open GMain

class xpm_label_box parent:(parent : #GObj.widget) :file :text =
  let _ = 
    if not (Sys.file_exists file) then failwith (file ^ " does not exist") in
  object
    inherit GPack.box `HORIZONTAL border_width: 2 as box

    val pixmapwid =
      parent#misc#realize ();
      let pixmap, mask =
	Gdk.Pixmap.create_from_xpm (parent#misc#window)
	  transparent:(GtkData.Style.get_bg parent#misc#style) :file
      in
      new GPix.pixmap pixmap :mask

    val label = new GMisc.label :text

    initializer
      box#set_size border: 2;
      List.iter [(pixmapwid :> GObj.widget); (label :> GObj.widget)]
	fun:(box#pack expand:false fill:false padding:3)

    method show () =
      pixmapwid#show ();
      label#show ();
      box#show ()
  end

let main () =
  let window =
    new GWindow.window `TOPLEVEL title:"Pixmap'd Buttons!" border_width:10 in
  window#connect#destroy callback:Main.quit;
  let button = new GButton.button in
  button#connect#clicked
    callback:(fun () -> prerr_endline "Hello again - cool button was pressed");
  let box =
    new xpm_label_box parent:window file:"info.xpm" text:"cool button" in
  box#show ();
  button#add box;
  button#show ();
  window#add button;
  window#show ();
  Main.main ()

let _ = main ()

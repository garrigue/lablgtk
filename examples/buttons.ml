(* $Id$ *)

open Gtk

let xpm_label_box :parent :file :label =
  if not (Sys.file_exists file) then failwith (file ^ " does not exist");
  let box1 = Box.create `HORIZONTAL in
  Box.set box1 border_width: 2;
  let style = Widget.get_style parent in
  let pixmap, mask =
    Gdk.Pixmap.create_from_xpm (Widget.window parent)
      transparent:(Style.get_bg style) :file
  in
  let pixmapwid = Pixmap.create pixmap :mask in
  let label = Label.create label in
  Box.pack box1 pixmapwid expand:false fill:false padding:3;
  Box.pack box1 label expand:false fill:false padding:3;
  Widget.show pixmapwid;
  Widget.show label;
  box1

let main () =
  let window = Window.create `TOPLEVEL in
  Window.set window title:"Pixmap'd Buttons!" border_width:10;
  Window.Connect.destroy window cb:Main.quit;
  Widget.realize window;
  let button = Button.create () in
  Button.Connect.clicked button
    cb:(fun () -> prerr_endline "Hello again - cool button was pressed");
  let box1 =
    xpm_label_box parent:window file:"info.xpm" label:"cool button" in
  Widget.show box1;
  Button.add button box1;
  Widget.show button;
  Window.add window button;
  Widget.show window;
  Main.main ()

let _ = main ()

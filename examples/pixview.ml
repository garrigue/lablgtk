(* $Id$ *)

(* An image viewer, supporting all formats allowed by GdkPixbuf *)

let pb = GdkPixbuf.from_file Sys.argv.(1)

let pm, _ = GdkPixbuf.create_pixmap pb

let width = GdkPixbuf.get_width pb
let height = GdkPixbuf.get_height pb

let w = GWindow.window ~width ~height ~title:Sys.argv.(1) ()
let da = GMisc.drawing_area ~packing:w#add ()

let dw = da#misc#realize (); new GDraw.drawable da#misc#window

let () =
  da#event#connect#expose (fun _ -> dw#put_pixmap ~x:0 ~y:0 pm; true);
  w#connect#destroy GMain.quit;
  w#show ();
  GMain.main ()


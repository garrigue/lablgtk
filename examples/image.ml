(* $Id$ *)

open GMain
open Gdk

(* load image *)
let load_image file =
  let buf = String.create (256*256*3) in
  let ic = open_in_bin file in
  really_input ic buf 0 (256*256*3);
  close_in ic;
  buf

let rgb_at buf x y =
  let offset = (y * 256 + x) * 3 in
  (int_of_char buf.[offset  ],
   int_of_char buf.[offset+1],
   int_of_char buf.[offset+2])

(* alternate approach: map the file *)
(* Requires bigarray.cma, but needed for Rgb.draw_image *)
(*
let load_image file =
  let fd = Unix.openfile file [Unix.O_RDONLY] 0 in
  let arr =
    Bigarray.Array1.map_file fd Bigarray.int8_unsigned Bigarray.c_layout
      false (256*256*3) in
  Unix.close fd;
  arr

let rgb_at buf x y =
  let offset = (y * 256 + x) * 3 in
  (buf.{offset}, buf.{offset+1}, buf.{offset+2})
*)

(* Choose a visual appropriate for RGB *)
let () =
  Gdk.Rgb.init ();
  GtkBase.Widget.set_default_visual (Gdk.Rgb.get_visual ());
  GtkBase.Widget.set_default_colormap (Gdk.Rgb.get_cmap ())

(* We need show: true because of the need of visual *)
let window = GWindow.window ~show:true ~width: 256 ~height: 256 ()

let visual = window#misc#visual

let color_create = Truecolor.color_creator visual

let w = window#misc#window
let drawing = new GDraw.drawable w

let () =
  window#connect#destroy ~callback:Main.quit;

  (* Using images *)
  let image =
    Image.create ~kind: `FASTEST ~visual: visual ~width: 256 ~height: 256
  in

  let buf = load_image "image256x256.rgb" in
  for x = 0 to 255 do
    for y = 0 to 255 do
      let r,g,b = rgb_at buf x y in
      Image.put_pixel image ~x: x ~y: y ~pixel:
        (color_create ~red: (r * 256) ~green: (g * 256) ~blue: (b * 256))
    done
  done; 
 
  let display () = drawing#put_image image ~x:0 ~y:0 in

  (* Using Rgb.draw_image *)
  (*
  let pixmap = Pixmap.create ~window:w ~width:256 ~height:256 () in
  let buf = load_image "image256x256.rgb" in
  Rgb.draw_image pixmap (GC.create pixmap) ~width:256 ~height:256 buf;
    
  let display () = drawing#put_pixmap pixmap ~x:0 ~y:0 in
  *)

  (* Bind display callback *)
  window#event#connect#after#expose ~callback:
    begin fun _ ->
      display (); false
    end;

  window#show ();
  Main.main ()

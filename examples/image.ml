(* $Id$ *)

open GMain
open Gdk

(* load image *)
let buf = String.create (256*256*3)
let ic = open_in_bin "image256x256.rgb"
let _ = 
  really_input ic buf 0 (256*256*3);
  close_in ic

let rgb_at x y =
  let offset = (y * 256 + x) * 3 in
  (int_of_char buf.[offset  ],
   int_of_char buf.[offset+1],
   int_of_char buf.[offset+2])

(* let id = Thread.create GtkThread.main () *)

(* Choose a visual appropriate for RGB *)
let _ =
  Gdk.Rgb.init ();
  GtkBase.Widget.set_default_visual (Gdk.Rgb.get_visual ());
  GtkBase.Widget.set_default_colormap (Gdk.Rgb.get_cmap ())

(* We need show: true because of the need of visual *)
let window = GWindow.window ~show:true ~width: 256 ~height: 256 ()

let visual = window#misc#visual

let color_create = Truecolor.color_creator visual

let w = window#misc#window
let drawing = new GDraw.drawable w

let _ =
  window#connect#destroy ~callback:Main.quit;

  let image =
    Image.create ~kind: `FASTEST ~visual: visual ~width: 256 ~height: 256
  in

  let draw () =
    for x = 0 to 255 do
      for y = 0 to 255 do
        let r,g,b = rgb_at x y in
        Image.put_pixel image ~x: x ~y: y 
          ~pixel: (color_create ~red: (r * 256) ~green: (g * 256) ~blue: (b * 256))
      done
    done 
  in
 
  let display () =
    drawing#put_image image ~x:0 ~y:0
  in

  draw (); 

  window#event#connect#after#expose ~callback:
    begin fun _ ->
      display (); false
    end;
  (* Thread.join id *)

  window#show ();
  Main.main ()

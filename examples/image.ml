(* $Id$ *)

open GdkObj
open GMain
open Gdk

(* load image *)
let buf = String.create (256*256*3)
let ic = open_in_bin "image256x256.rgb"
let _ = 
  really_input ic ~buf:buf ~pos:0 ~len:(256*256*3);
  close_in ic

let rgb_at x y =
  let offset = (y * 256 + x) * 3 in
  (int_of_char buf.[offset  ],
   int_of_char buf.[offset+1],
   int_of_char buf.[offset+2])

(* let id = Thread.create GtkThread.main () *)

(* We need show: true because of the need of visual *)
let window = GWindow.window ~show:true ~width: 256 ~height: 256 ()

let visual = window#misc#visual

let color_create = Truecolor.color_creator visual

let w = window#misc#window
let drawing = new drawing w

let _ =
  window#connect#destroy ~callback:Main.quit;

  let image =
    Image.create ~image_type: `FASTEST ~visual: visual ~width: 256 ~height: 256
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
    drawing#image image ~xsrc:0 ~ysrc:0 ~xdest:0 ~ydest:0 ~width:256 ~height:256
  in

  draw (); 

  window#connect#after#event#expose ~callback:
    begin fun _ ->
      display (); false
    end;
  (* Thread.join id *)

  window#show ();
  Main.main ()

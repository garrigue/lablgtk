(* $Id$ *)

(* Embedding xpm data into an ML file *)

let openfile = [|
(* width height num_colors chars_per_pixel *)
"    20    19       5            1";
(* colors *)
". c None";
"# c #000000";
"i c #ffffff";
"s c #7f7f00";
"y c #ffff00";
(* pixels *)
"....................";
"....................";
"....................";
"...........###......";
"..........#...#.#...";
"...............##...";
"...###........###...";
"..#yiy#######.......";
"..#iyiyiyiyi#.......";
"..#yiyiyiyiy#.......";
"..#iyiy###########..";
"..#yiy#sssssssss#...";
"..#iy#sssssssss#....";
"..#y#sssssssss#.....";
"..##sssssssss#......";
"..###########.......";
"....................";
"....................";
"...................." |]

open GMain

let main () =
  let w = GWindow.window ~border_width:2 () in
  w#misc#realize ();
  let hbox = GPack.hbox ~spacing:10 ~packing:w#add () in
  let pm = GDraw.pixmap_from_xpm_d ~data:openfile ~window:w () in
  GMisc.pixmap pm ~packing:hbox#add ();
  GMisc.label ~text:"Embedded xpm" ~packing:hbox#add ();
  w#show ();
  w#connect#destroy ~callback:Main.quit;
  Main.main ()

let () = main ()

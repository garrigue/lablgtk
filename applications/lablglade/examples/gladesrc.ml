open GMain

let main () =
   let window1 = new GWindow.window in
   let fixed1 = new GPack.fixed packing:window1#add in
   let drawingarea1 = new GMisc.drawing_area width:336 height:136 packing:fixed1#add in
   drawingarea1#misc#set x:48 y:136;
   let button1 = new GButton.button label:"button1" width:47 height:22 packing:fixed1#add in
   button1#misc#set x:64 y:56;
   let entry1 = new GEdit.entry text:"" width:158 height:22 packing:fixed1#add in
   entry1#misc#set x:184 y:64;
   window1#show ();
   Main.main () 

let _ = main ()
(* $Id$ *)

open GMain

let main () =
  let w = new GWindow.window title:"LablGL/Gtk" in
  w#connect#destroy callback:Main.quit;
  let area =
    new GlGtk.area [`RGBA;`DEPTH_SIZE 1] width:500 height:500 packing:w#add in
  area#connect#realize callback:
    begin fun () ->
      GlMat.mode `projection;
      GlMat.load_identity ();
      GlMat.ortho x:(-1.0,1.0) y:(-1.0,1.0) z:(-1.0,1.0);
    end;
  area#connect#display callback:
    begin fun () ->
      GlClear.color (0.0, 0.0, 0.0);
      GlClear.clear [`color];
      GlDraw.color (1.0, 1.0, 1.0);
      GlDraw.begins `polygon;
      GlDraw.vertex x:(-0.5) y:(-0.5);
      GlDraw.vertex x:(-0.5) y:(0.5);
      GlDraw.vertex x:(0.5) y:(0.5);
      GlDraw.vertex x:(0.5) y:(-0.5);
      GlDraw.ends ();
      Gl.flush ()
    end;
  Timeout.add 10000 callback:(fun () -> w#destroy ();false);
  w#show ();
  Main.main ()

let _ = main ()

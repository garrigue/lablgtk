(* Lissajous 図形 *)
open GdkObj
open GtkObj

class double_buffer parent:(p : #widget) :width :height =
  let depth = p#misc#realize (); Gtk.Style.get_depth (p#misc#style) in
  let window = p#misc#window in
  let drawing = new drawing (Gdk.Pixmap.create window :width :height :depth) in
  object (self)
    val mutable current =
      new drawing (Gdk.Pixmap.create window :width :height :depth)
    val mutable other = drawing
    inherit pixmap (Gtk.Pixmap.create drawing#raw)
    method switch_buffers () =
      let tmp = current in current <- other; other <- tmp;
      self#set pixmap:other#raw;
      self#misc#draw (Gdk.Rectangle.create x:0 y:0 :width :height)
    method set_gc ?:foreground ?:background =
      current#set ?:foreground ?:background
    method point = current#point
    method line = current#line
    method rectangle = current#rectangle
    method arc = current#arc
    method polygon = current#polygon
    method string = current#string
  end
    
let main () =
  let window = new_window `TOPLEVEL border_width: 10 in
  window#connect#event#delete
     callback:(fun _ -> prerr_endline "Delete event occured"; true);
  window#connect#destroy callback:Main.quit;
  let vbx = new_box `VERTICAL packing:window#add in  
  let quit = new_button label:"Quit" packing:vbx#add in
  quit#connect#clicked callback:window#destroy;
  let drawing = new double_buffer width:200 height:200 parent:vbx in
  vbx#add drawing;
  let m_pi = acos (-1.) in
  let c = ref 0. in
  let draw () =
    drawing#set_gc foreground: `WHITE;
    drawing#rectangle filled:true x:0 y:0 width:200 height:200;
    drawing#set_gc foreground: `BLACK;
(*    drawing#line x:0 y:0 x:150 y:150; 
      drawing#polygon filled:true [10,100; 35,35; 100,10; 10, 100];
*)
    let n = 200 in
    let r = 100. in
    let a = 3 in let b = 5 in 
    for i=0 to n do
      let theta0 = 2.*.m_pi*.(float (i-1))/. (float n) in
      let x0 = 100 + (truncate (r*.sin ((float a)*.theta0))) in
      let y0 = 100 - (truncate (r*.cos ((float b)*.(theta0+. !c)))) in
      let theta1 = 2.*.m_pi*.(float i)/.(float n) in
      let x1 = 100 + (truncate (r*.sin((float a)*.theta1))) in
      let y1 = 100 - (truncate (r*.cos((float b)*.(theta1+. !c)))) in
      drawing#line x:x0 y:y0 x:x1 y:y1
    done
  in 
  draw ();
  let ready = ref false in
  drawing#connect#event#expose callback:(fun _ -> ready := true; false);
  window#connect#event#unmap callback:(fun _ -> ready := false; false);
  let timeout () =
    if !ready then begin
      c := !c +. 0.002 *. m_pi;
      draw (); drawing#switch_buffers ();
    end;
    true
  in
  window#show_all ();
  Timeout.add 50 callback:timeout;
  Main.main ()

let _ = Printexc.print main()

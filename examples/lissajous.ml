(* Lissajous 図形 *)
open GtkObj
open GdkObj  


let main () =
  let window = new_window `TOPLEVEL border_width: 10 in
  window#connect#event#delete
     callback:(fun _ -> prerr_endline "Delete event occured"; true);
  window#connect#destroy callback:Main.quit;
  let vbx = new_box `VERTICAL packing:window#add in  
  let quit = new_button label:"Quit" packing:vbx#add in
  quit#connect#clicked callback:window#destroy;
  let area = new_drawing_area width:200 height:200 packing:vbx#add in
  let drawing = area#misc#realize (); new drawing (area#misc#window) in
  let m_pi = acos (-1.) in
  let c = ref 0. in
  let expose_event _ =
    drawing#set foreground: `WHITE;
    drawing#rectangle filled:true x:0 y:0 width:200 height:200;
    drawing#set foreground: `BLACK;
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
    done;  
    false
  in 
  area#connect#event#expose callback:expose_event;
  let timeout _ = c := !c +. 0.01*.m_pi;
                  expose_event ();
		  true in 
  Timeout.add 500 callback:timeout;
  window#show_all ();
  Main.main ()

let _ = Printexc.print main()

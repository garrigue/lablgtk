
let pad = 4

let item_callback it (p1, p2) ev =
  let process = 
    match GdkEvent.get_type ev with
    | `BUTTON_PRESS ->
	GdkEvent.Button.button (GdkEvent.Button.cast ev) = 1
    | _ -> false
  in
  if process
  then begin
    if (GnoCanvas.parent it)#get_oid = p1#get_oid
    then it#reparent p2#as_group
    else it#reparent p1#as_group
  end


let create_canvas_features window =
  let vbox = GPack.vbox ~border_width:pad ~spacing:pad ~packing:window#add () in
  GMisc.label 
    ~text:"Reparent test:  click on the items to switch them between parents" 
    ~packing:vbox#add () ;
  let align = GBin.alignment 
      ~x:0.5 ~y:0.5 
      ~xscale:0. ~yscale:0. 
      ~packing:vbox#add () in
  let frame = GBin.frame ~shadow_type:`IN ~packing:align#add () in

  let canvas = GnoCanvas.canvas ~width:400 ~height:200 ~packing:frame#add () in
  canvas#set_scroll_region 0. 0. 400. 200. ;

  let parent_1 = GnoCanvas.group canvas#root ~props:[ `x 0. ; `y 0. ] in
  GnoCanvas.rect parent_1
    ~props:[ `x1 0.; `y1 0.; 
	     `x2 200.; `y2 200.; 
	     `fill_color "tan" ] ;
  let parent_2 = GnoCanvas.group canvas#root ~props:[ `x 200. ; `y 0. ] in
  GnoCanvas.rect parent_2
    ~props:[ `x1 0.; `y1 0.; 
	     `x2 200.; `y2 200.; 
	     `fill_color "#204060" ] ;

  let item = GnoCanvas.ellipse parent_1
      ~props:[ `x1 10.; `y1 10.; 
	       `x2 190.; `y2 190.; 
	       `outline_color "black" ;
	       `fill_color "mediumseagreen" ;
	       `width_units 3. ] in
  item#connect#event (item_callback item (parent_1, parent_2)) ;
  
  let group = GnoCanvas.group parent_2 ~props:[ `x 100.; `y 100. ] in
  GnoCanvas.ellipse group 
    ~props:[ `x1 (-50.); `y1 (-50.); 
	     `x2 50.; `y2 50.; 
	     `outline_color "black" ;
	     `fill_color "wheat" ;
	     `width_units 3. ] ;
  GnoCanvas.ellipse group 
    ~props:[ `x1 (-25.); `y1 (-25.); 
	     `x2 25.; `y2 25.; 
	     `fill_color "steelblue" ] ;
  group#connect#event (item_callback group (parent_1, parent_2)) ;
  
  vbox


let main_1 () =
  let window = GWindow.window () in
  let truc = create_canvas_features window in

  window#connect#destroy ~callback:GMain.Main.quit ;

  window#show () ;
  GMain.Main.main ()

let _ = 
   main_1 ()

(* Local Variables: *)
(* compile-command: "ocamlopt -w s -i -I ../../src lablgtk.cmxa gtkInit.cmx lablgnomecanvas.cmxa canvas-features.ml" *)
(* End: *)

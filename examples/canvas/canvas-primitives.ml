
let zoom_changed canvas adj () =
  canvas#set_pixels_per_unit adj#value

type 'p item_state = {
    item : 'p GnoCanvas.item ;
    mutable dragging : bool ;
    mutable x : float ;
    mutable y : float ;
  }

let item_event_button_press config ev =
  let state = GdkEvent.Button.state ev in
  match GdkEvent.Button.button ev with
  | 1 when Gdk.Convert.test_modifier `SHIFT state ->
      config.item#destroy ()
  | 1 ->
      let x = GdkEvent.Button.x ev in
      let y = GdkEvent.Button.y ev in
      let (item_x, item_y) = (GnoCanvas.parent config.item)#w2i x y in
      config.x <- item_x ;
      config.y <- item_y ;
      config.dragging <- true
  | 2 when Gdk.Convert.test_modifier `SHIFT state ->
      config.item#lower_to_bottom
  | 2 ->
      config.item#lower 1
  | 3 when Gdk.Convert.test_modifier `SHIFT state ->
      config.item#raise_to_top
  | 3 ->
      config.item#raise 1
  | _ -> ()

let item_event_button_release config ev =
  config.dragging <- false

let item_event_motion config ev = 
  if config.dragging && Gdk.Convert.test_modifier `BUTTON1 (GdkEvent.Motion.state ev)
  then
    let x = GdkEvent.Motion.x ev in
    let y = GdkEvent.Motion.y ev in
    let (item_x, item_y) = (GnoCanvas.parent config.item)#w2i x y in
    config.item#move (item_x -. config.x) (item_y -. config.y) ;
    config.x <- item_x ;
    config.y <- item_y
    
let item_event config ev =
  begin match GdkEvent.get_type ev with
  | `BUTTON_PRESS ->
      let ev = GdkEvent.Button.cast ev in
      item_event_button_press config ev
  | `BUTTON_RELEASE ->
      let ev = GdkEvent.Button.cast ev in
      item_event_button_release config ev
  | `MOTION_NOTIFY ->
      let ev = GdkEvent.Motion.cast ev in
      item_event_motion config ev
  | _ -> () end ;
  false

let setup_item (it : 'a #GnoCanvas.item) =
  let config = { 
    item = (it : 'a #GnoCanvas.item :> 'a GnoCanvas.item) ;
    dragging = false ;
    x = 0. ; y = 0. ; } in
  it#connect#event (item_event config)



let setup_div root =
  let grp = GnoCanvas.group root ~x:0. ~y:0. in
  GnoCanvas.rect grp 
    ~props:[ `x1 0.; `y1 0.; `x2 600.; `y2 450. ;
	     `outline_color "black" ; `width_units 4. ] ;
  List.map
    (fun p ->
      GnoCanvas.line grp
	~props:[ `fill_color "black"; `width_units 4. ;
		 `points p ])
    [ [| 0.; 150.; 600.; 150. |] ;
      [| 0.; 300.; 600.; 300. |] ;
      [| 200.; 0.; 200.; 450. |] ;
      [| 400.; 0.; 400.; 450. |] ; ] ;

  List.map
    (fun (text, pos) ->
      GnoCanvas.text grp
	~props:[ `text text ;
		 `x (float (pos mod 3 * 200 + 100)) ;
		 `y (float (pos / 3 * 150 + 5)) ;
		 `font "Sans 12" ; `anchor `NORTH ;
		 `fill_color "black" ])
    [ ("Rectangles", 0);
      ("Ellipses", 1);
      ("Texts", 2);
      ("Images", 3);
      ("Lines", 4);
      ("Curves", 5);
      ("Arcs", 6);
      ("Polygons", 7);
      ("Widgets", 8); ] ;
  ()

let setup_rectangles root =
  setup_item
    (GnoCanvas.rect root
       ~props:[ `x1 20.; `y1 30.; `x2 70.; `y2 60.;
		`outline_color "red" ; `width_pixels 8 ]) ;
  
  setup_item
    (GnoCanvas.rect root
       ~props:( [ `x1 90.; `y1 40.; `x2 180.; `y2 100.;
		  `outline_color "black" ;
		  `width_units 4. ] @
		if (new GnoCanvas.canvas root#canvas)#aa   (* glurg ! c'est moche *)
		then [ `fill_color_rgba (Int32.of_int 0x3cb37180) ]
		else [ `fill_color "mediumseagreen" ;
		       `fill_stipple (Gdk.Bitmap.create_from_data ~width:2 ~height:2 "\002\001")
		     ] )) ;
     
  setup_item
    (GnoCanvas.rect root
       ~props:[ `x1 10.; `y1 80.; `x2 80.; `y2 140.;
		`fill_color "steelblue" ])


let setup_ellipses root =
  setup_item
    (GnoCanvas.ellipse root
       ~props:[ `x1 220.; `y1 30.; `x2 270.; `y2 60. ;
		`outline_color "goldenrod" ;
		`width_pixels 8 ]) ;
  setup_item
    (GnoCanvas.ellipse root
       ~props:[ `x1 290.; `y1 40.; `x2 380.; `y2 100. ;
		`fill_color "wheat" ;
		`outline_color "midnightblue" ;
		`width_units 4. ]) ;
  setup_item
    (GnoCanvas.ellipse root
       ~props:( [ `x1 210.; `y1 80.; `x2 280.; `y2 140.;
		  `outline_color "black" ;
		  `width_pixels 0 ] @
		if (new GnoCanvas.canvas root#canvas)#aa   (* glurg ! c'est moche *)
		then [ `fill_color_rgba (Int32.of_int 0x5f9ea080) ]
		else [ `fill_color "cadetblue" ;
		       `fill_stipple (Gdk.Bitmap.create_from_data ~width:2 ~height:2 "\002\001")
		     ] ))

let make_anchor root ~x ~y =
  let grp = GnoCanvas.group ~x ~y root in
  setup_item grp ;
  GnoCanvas.rect grp
    ~props:[ `x1 (-2.); `y1 (-2.); `x2 2.; `y2 2. ;
	     `outline_color "black" ; `width_pixels 0 ] ;
  grp

let setup_texts root =
  GnoCanvas.text (make_anchor root ~x:420. ~y:20.)
    ~props:([ `text "Anchor NW" ;`anchor `NW ; 
	      `x 0. ; `y 0. ; `font "Sans Bold 24" ; ] @
	    if (new GnoCanvas.canvas root#canvas)#aa   (* glurg ! c'est moche *)
	    then [ `fill_color_rgba (Int32.of_int 0x0000ff80) ]
	    else [ `fill_color "blue" ;
		       `fill_stipple (Gdk.Bitmap.create_from_data ~width:2 ~height:2 "\002\001")
		 ] ) ;
  GnoCanvas.text (make_anchor root ~x:470. ~y:75.)
    ~props:[ `text "Anchor center\nJustify center\nMultiline text" ;
	     `x 0. ; `y 0. ; `font "Sans monospace bold 14" ;
	     `anchor `CENTER ; `justification `CENTER ;
	     `fill_color "firebrick" ] ;
	    
  GnoCanvas.text (make_anchor root ~x:590. ~y:140.)
    ~props:[ `text "Clipped text\nClipped text\nClipped text\nClipped text\nClipped text\nClipped text" ;
	     `x 0. ; `y 0. ; `font "Sans 12" ;
	     `anchor `SE ; 
	     `clip true ; `clip_width 50. ; `clip_height 55. ;
	     `x_offset 10. ; `fill_color "darkgreen" ] ;
  ()
	     
let plant_flower root x y =
  let im = GdkPixbuf.from_file "flower.png" in
  setup_item
    (GnoCanvas.pixbuf root ~pixbuf:im ~x ~y 
       ~props:[ `anchor `CENTER] ) ;
  ()

let setup_images root =
  let im = GdkPixbuf.from_file "toroid.png" in
  setup_item
    (GnoCanvas.pixbuf ~x:100. ~y:225. ~pixbuf:im 
       ~props:[ `anchor `CENTER ] root) ;

  plant_flower root  20. 170. ;
  plant_flower root 180. 170. ;
  plant_flower root  20. 280. ;
  plant_flower root 180. 280.


let polish_diamond root =
  let grp = GnoCanvas.group ~x:270. ~y:230. root in
  setup_item grp ;
  let p = Array.make 4 0. in
  let vertices, radius = (10, 60.) in
  for i=0 to pred vertices do
    let a = 8. *. atan 1. *. (float i) /. (float vertices) in
    p.(0) <- radius *. cos a ;
    p.(1) <- radius *. sin a ;
    for j=i+1 to pred vertices do
      let a = 8. *. atan 1. *. (float j) /. (float vertices) in
      p.(2) <- radius *. cos a ;
      p.(3) <- radius *. sin a ;
      GnoCanvas.line grp
	~props:[ `points p; `fill_color "black" ;
		 `width_units 1. ; `cap_style `ROUND ] ;
      ()
    done
  done

let make_hilbert root =
  let scale = 7. in
  let hilbert = "urdrrulurulldluuruluurdrurddldrrruluurdrurddldrddlulldrdldrrurd" in 
  let points = Array.make (2 * (String.length hilbert + 1)) 0. in
  points.(0) <- 340. ; points.(1) <- 290. ;
  for i=1 to String.length hilbert do
    let (dx, dy) = 
      match hilbert.[pred i] with
      | 'd' -> (0., scale)
      | 'u' -> (0., ~-. scale)
      | 'l' -> (~-. scale, 0.)
      | 'r' -> (scale, 0.) 
      | _ -> failwith "pb" in
    points.(2 * i) <- points.(2 * (pred i)) +. dx ;
    points.(2 * i + 1) <- points.(2 * (pred i) + 1) +. dy
  done ;
  setup_item
    (GnoCanvas.line root
       ~props:( [ `points points ; `width_units 4. ;
		  `cap_style `PROJECTING ; `join_style `MITER ] @
		if (new GnoCanvas.canvas root#canvas)#aa   (* glurg ! c'est moche *)
		then [ `fill_color_rgba (Int32.of_int 0xff000080) ]
		else [ `fill_color "red" ;
		       `fill_stipple (Gdk.Bitmap.create_from_data ~width:2 ~height:2 "\002\001")
		     ] ) ) ;
  ()
	
let setup_lines root =
  polish_diamond root ;
  make_hilbert root ;
  let points = [| 340.; 170.; 340.; 230.; 390.; 230.; 390.; 170. |] in
  setup_item
    (GnoCanvas.line root
       ~props:[ `points points ; `fill_color "midnightblue" ; `width_units 3. ; 
		`first_arrowhead true ; `last_arrowhead true ; 
		`arrow_shape_a 8. ; `arrow_shape_b 12. ; `arrow_shape_c 4. ]) ;

  let points = [| 356.; 180.; 374.; 220.; |] in
  setup_item
    (GnoCanvas.line root
       ~props:[ `points points ; `fill_color "blue" ; `width_pixels 0 ; 
		`first_arrowhead true ; `last_arrowhead true ; 
		`arrow_shape_a 6. ; `arrow_shape_b 6. ; `arrow_shape_c 4. ]) ;

  let points = [| 356.; 220.; 374.; 180.; |] in
  setup_item
    (GnoCanvas.line root
       ~props:[ `points points ; `fill_color "blue" ; `width_pixels 0 ; 
		`first_arrowhead true ; `last_arrowhead true ; 
		`arrow_shape_a 6. ; `arrow_shape_b 6. ; `arrow_shape_c 4. ]) ;
  ()

let setup_curves root =
  let p = GnomeCanvas.PathDef.new_path () in
  GnomeCanvas.PathDef.moveto p 500. 175. ;
  GnomeCanvas.PathDef.curveto p 550. 175. 550. 275. 500. 275. ;
  setup_item
    (GnoCanvas.bpath root
       ~props:[ `bpath p ; `outline_color "black" ; `width_pixels 4 ]) ;
  ()

let setup_polygons root =
  let points = [| 210. ; 320.; 210.; 380.; 260.; 350.; |] in
  setup_item
    (GnoCanvas.polygon ~points root
       ~props:( (`outline_color "black") ::
		if (new GnoCanvas.canvas root#canvas)#aa
		then [ `fill_color_rgba (Int32.of_int 0x0000ff80) ]
		else [ `fill_color "blue" ; 
		       `fill_stipple (Gdk.Bitmap.create_from_data ~width:2 ~height:2 "\002\001") ] )) ;
  let points = [|
	270.0; 330.0; 270.0; 430.0;
	390.0; 430.0; 390.0; 330.0;
	310.0; 330.0; 310.0; 390.0;
	350.0; 390.0; 350.0; 370.0;
	330.0; 370.0; 330.0; 350.0;
	370.0; 350.0; 370.0; 410.0;
	290.0; 410.0; 290.0; 330.0; |] in
  setup_item
    (GnoCanvas.polygon ~points root
       ~props:[ `fill_color "tan" ; `outline_color "black" ; `width_units 3. ]) ;
  ()


let setup_widgets root =
  let w = GButton.button ~label:"Hello world!" () in
  setup_item
    (GnoCanvas.widget root ~widget:w ~x:420. ~y:330.
       ~props:[ `anchor `NW ; `size_pixels false ;
		`width 100. ; `height 40. ]) ;
  ()

let key_press (canvas : GnoCanvas.canvas) ev =
  let (x, y) = canvas#get_scroll_offsets in
  match GdkEvent.Key.keyval ev with
  | k when k = GdkKeysyms._Up -> canvas#scroll_to x (y-20) ; true
  | k when k = GdkKeysyms._Down -> canvas#scroll_to x (y+20) ; true
  | k when k = GdkKeysyms._Left -> canvas#scroll_to (x-10) y ; true
  | k when k = GdkKeysyms._Right -> canvas#scroll_to (x+10) y ; true
  | _ -> false

let create_canvas_primitives window ~aa =
  let vbox = GPack.vbox ~border_width:4 ~spacing:4 ~packing:window#add () in
  GMisc.label 
    ~text:"Drag an item with button 1.  Click button 2 on an item to lower it,\n\
           or button 3 to raise it.  Shift+click with buttons 2 or 3 to send\n\
           an item to the bottom or top, respectively."
    ~packing:vbox#pack () ;
  let hbox = GPack.hbox ~spacing:4 ~packing:vbox#pack () in
  GtkBase.Widget.push_colormap (Gdk.Rgb.get_cmap ()) ;
  let canvas = GnoCanvas.canvas ~aa () in
  canvas#set_center_scroll_region false ;
  let root = canvas#root in
  setup_div root ;
  setup_rectangles root ;
  setup_ellipses root ;
  setup_texts root ;
  setup_images root ;
  setup_lines root ;
  setup_polygons root ;
  setup_curves root ;
  setup_widgets root ;  
  (* root#affine_relative [| 1.5; 0.; 0.; 0.7; 0.; 0.; |] ; *)
  GtkBase.Widget.pop_colormap () ;
  
  GMisc.label ~text:"Zoom:" ~packing:hbox#pack () ;
  let adj = GData.adjustment 
      ~value:1. ~lower:0.05 ~upper:5. 
      ~step_incr:0.05 ~page_incr:0.5 ~page_size:0.5 () in
  adj#connect#value_changed (zoom_changed canvas adj) ;
  let w = GEdit.spin_button ~adjustment:adj ~rate:0. ~digits:2 ~width:50 ~packing:hbox#pack () in
  let table = GPack.table ~rows:2 ~columns:2 ~row_spacings:4 ~col_spacings:4 ~packing:vbox#pack () in
  let frame = GBin.frame ~shadow_type:`IN () in
  table#attach ~left:0 ~right:1 ~top:0 ~bottom:1
    ~expand:`BOTH ~fill:`BOTH ~shrink:`BOTH ~xpadding:0 ~ypadding:0
    frame#coerce ;
  canvas#misc#set_size_request ~width:600 ~height:450 ;
  canvas#set_scroll_region 0. 0. 600. 450. ;
  frame#add canvas#coerce ;
  canvas#event#connect#after#key_press (key_press canvas) ;
  let w = GRange.scrollbar `HORIZONTAL ~adjustment:canvas#hadjustment () in
  table#attach ~left:0 ~right:1 ~top:1 ~bottom:2
    ~expand:`X ~fill:`BOTH ~shrink:`X ~xpadding:0 ~ypadding:0
    w#coerce ;
  let w = GRange.scrollbar `VERTICAL ~adjustment:canvas#vadjustment () in
  table#attach ~left:1 ~right:2 ~top:0 ~bottom:1
    ~expand:`Y ~fill:`BOTH ~shrink:`Y ~xpadding:0 ~ypadding:0 
    w#coerce ;
  canvas#misc#set_can_focus true ;
  canvas#misc#grab_focus ()


let main_1 () =
  let aa = 
    if Array.length Sys.argv > 1 
    then try bool_of_string Sys.argv.(1) 
         with Invalid_argument _ -> false
    else false in
  let window = GWindow.window () in
  create_canvas_primitives window ~aa ;
  window#connect#destroy ~callback:GMain.Main.quit ;
  window#show () ;
  GMain.Main.main ()

let _ = 
   main_1 ()


(* Local Variables: *)
(* compile-command: "ocamlopt -w s -i -I ../../src lablgtk.cmxa gtkInit.cmx lablgnomecanvas.cmxa canvas-primitives.ml" *)
(* End: *)

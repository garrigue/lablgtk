
type config = {
    mutable width   : int ;
    mutable shape_a : int ;
    mutable shape_b : int ;
    mutable shape_c : int ;
  }
type data = {
    big_arrow : GnoCanvas.line ;
    outline   : GnoCanvas.line ;
    width_drag_box     : GnoCanvas.rect ;
    shape_a_drag_box   : GnoCanvas.rect ;
    shape_b_c_drag_box : GnoCanvas.rect ;
    width_items   : GnoCanvas.line * GnoCanvas.text ;
    shape_a_items : GnoCanvas.line * GnoCanvas.text ;
    shape_b_items : GnoCanvas.line * GnoCanvas.text ;
    shape_c_items : GnoCanvas.line * GnoCanvas.text ;
    width_info    : GnoCanvas.text ;
    shape_a_info  : GnoCanvas.text ;
    shape_b_info  : GnoCanvas.text ;
    shape_c_info  : GnoCanvas.text ;
    samples : GnoCanvas.line list
  }

let global_data = ref None

let left = 50.
let right = 350.
let middle = 150.

let config = {
  width   = 2 ;
  shape_a = 8 ;
  shape_b = 10 ;
  shape_c = 3 ;
}

let set_dimension (arrow, text) ~x1 ~y1 ~x2 ~y2 ~tx ~ty dim =
  let points = [| x1; y1; x2; y2 |] in
  arrow#set [ `points points ] ;
  text#set  [ `text (string_of_int dim); `x tx; `y ty]



let move_drag_box item ~x ~y =
  item#set [ `x1 (x -. 5.) ; `y1 (y -. 5.) ;
	     `x2 (x +. 5.) ; `y2 (y +. 5.) ; ]



let set_arrow_shape c =
  let d = match !global_data with
  | None -> failwith "argl"
  | Some v -> v in
  d.big_arrow#set [ `width_pixels (10 * c.width) ;
		    `arrow_shape_a (float c.shape_a *. 10.) ;
		    `arrow_shape_b (float c.shape_b *. 10.) ;
		    `arrow_shape_c (float c.shape_c *. 10.) ; ] ;
  let p = [| right -. 10. *. float c.shape_a ; middle ;
	     right -. 10. *. float c.shape_b ; 
	     middle -. 10. *. (float c.shape_c +. float c.width /. 2.) ;
	     right ; middle ;
	     right -. 10. *. float c.shape_b ; 
	     middle +. 10. *. (float c.shape_c +. float c.width /. 2.) ;
	     right -. 10. *. float c.shape_a ; middle ; |] in
  d.outline#set [ `points p ] ;

  move_drag_box d.width_drag_box ~x:left ~y:(middle -. 10. *. float c.width /. 2.) ;
  move_drag_box d.shape_a_drag_box ~x:(right -. 10. *. float c.shape_a) ~y:middle ;
  move_drag_box d.shape_b_c_drag_box 
    ~x:(right -. 10. *. float c.shape_b) 
    ~y:(middle -. 10. *. (float c.shape_c +. float c.width /. 2.)) ;

  set_dimension d.width_items 
    ~x1:(left -. 10.) ~y1:(middle -. 10. *. (float c.width /. 2.))
    ~x2:(left -. 10.) ~y2:(middle +. 10. *. (float c.width /. 2.))
    ~tx:(left -. 15.) ~ty:middle 
    c.width ;

  set_dimension d.shape_a_items
    ~x1:(right -. 10. *. float c.shape_a) 
    ~y1:(middle +. 10. *. (float c.width /. 2. +. float c.shape_c) +. 10.)
    ~x2:right 
    ~y2:(middle +. 10. *. (float c.width /. 2. +. float c.shape_c) +. 10.)
    ~tx:(right -. 10. *. float c.shape_a /. 2.) 
    ~ty:(middle +. 10. *. (float c.width /. 2. +. float c.shape_c) +. 15.)
    c.shape_a ;

  set_dimension d.shape_b_items
    ~x1:(right -. 10. *. float c.shape_b) 
    ~y1:(middle +. 10. *. (float c.width /. 2. +. float c.shape_c) +. 35.)
    ~x2:right 
    ~y2:(middle +. 10. *. (float c.width /. 2. +. float c.shape_c) +. 35.)
    ~tx:(right -. 10. *. float c.shape_b /. 2.) 
    ~ty:(middle +. 10. *. (float c.width /. 2. +. float c.shape_c) +. 40.)
    c.shape_b ;

  set_dimension d.shape_c_items
    ~x1:(right +. 10.) ~y1:(middle -. 10. *. (float c.width /. 2.))
    ~x2:(right +. 10.) 
    ~y2:(middle +. 10. *. (float c.width /. 2. +. float c.shape_c))
    ~tx:(right +. 15.) 
    ~ty:(middle -. 10. *. (float (c.width + c.shape_c) /. 2.))
    c.shape_c ;
  
  d.width_info#set [ `text (Printf.sprintf "width: %d" c.width) ] ;
  d.shape_a_info#set [ `text (Printf.sprintf "arrow_shape_a: %d" c.shape_a) ] ;
  d.shape_b_info#set [ `text (Printf.sprintf "arrow_shape_b: %d" c.shape_b) ] ;
  d.shape_c_info#set [ `text (Printf.sprintf "arrow_shape_c: %d" c.shape_c) ] ;
			
  List.iter 
    (fun i -> i#set [ `width_pixels c.width ;
		      `arrow_shape_a (float c.shape_a) ;
		      `arrow_shape_b (float c.shape_b) ;
		      `arrow_shape_c (float c.shape_c) ; ] )
    d.samples

  
let highlight_box item ev =
  match GdkEvent.get_type ev with
  | `ENTER_NOTIFY ->
      item#set [ `fill_color "red" ]
  | `LEAVE_NOTIFY ->
      let state = GdkEvent.Crossing.state (GdkEvent.Crossing.cast ev) in
      if not (Gdk.Convert.test_modifier `BUTTON1 state)
      then item#set [ `fill_color "" ]
  | `BUTTON_PRESS ->
      let curs = Gdk.Cursor.create `FLEUR in
      item#grab [`POINTER_MOTION; `BUTTON_RELEASE] curs 
	(GdkEvent.Button.time (GdkEvent.Button.cast ev))
  | `BUTTON_RELEASE ->
      item#ungrab (GdkEvent.Button.time (GdkEvent.Button.cast ev))
  | _ -> ()


let create_drag_box grp cb =
  let box = GnoCanvas.rect 
      ~props:[ `fill_color "" ; `outline_color "black" ; `width_pixels 0 ]
      grp in
  let sigs = box#connect in
  sigs#event (highlight_box box) ;
  sigs#event cb ;
  box


let width_event c ev =
  match GdkEvent.get_type ev with
  | `MOTION_NOTIFY ->
      let ev = GdkEvent.Motion.cast ev in
      let state = GdkEvent.Motion.state ev in
      let width = int_of_float ((middle -. GdkEvent.Motion.y ev) /. 5.) in
      if Gdk.Convert.test_modifier `BUTTON1 state && width >= 0
      then begin
	c.width <- width ;
	set_arrow_shape c
      end
  | _ -> ()

let shape_a_event c ev =
  match GdkEvent.get_type ev with
  | `MOTION_NOTIFY ->
      let ev = GdkEvent.Motion.cast ev in
      let state = GdkEvent.Motion.state ev in
      let shape_a = int_of_float ((right -. GdkEvent.Motion.x ev) /. 10.) in
      if Gdk.Convert.test_modifier `BUTTON1 state && 
	0 <= shape_a && shape_a <= 30
      then begin
	c.shape_a <- shape_a ;
	set_arrow_shape c
      end
  | _ -> ()

let shape_b_c_event c ev =
  match GdkEvent.get_type ev with
  | `MOTION_NOTIFY ->
      let ev = GdkEvent.Motion.cast ev in
      let state = GdkEvent.Motion.state ev in
      let change = ref false in
      let shape_b = int_of_float ((right -. GdkEvent.Motion.x ev) /. 10.) in
      let shape_c = 
	int_of_float (((middle -. 5. *. float c.width) -.
			 (GdkEvent.Motion.y ev)) /. 10.) in
      if Gdk.Convert.test_modifier `BUTTON1 state
      then begin
	if 0 <= shape_b && shape_b <= 30
	then begin
	  c.shape_b <- shape_b ;
	  change := true
	end ;
	if 0 <= shape_c
	then begin
	  c.shape_c <- shape_c ;
	  change := true
	end ;
	if !change then set_arrow_shape c
      end
  | _ -> ()


let create_dimension grp anchor =
  let a = 
    GnoCanvas.line 
      ~props:[ `fill_color "black" ;
	       `first_arrowhead true ;
	       `last_arrowhead true ;
	       `arrow_shape_a 5. ;
	       `arrow_shape_b 5. ;
	       `arrow_shape_c 3. ; ] 
      grp in
  let t = GnoCanvas.text 
      ~props:[ `fill_color "black" ;
	       `font "Sans 12" ;
	       `anchor anchor ] grp in
  (a, t)
  

let create_info grp ~x ~y =
  GnoCanvas.text
    ~props:[ `x x; `y y;
	     `fill_color "black" ;
	     `font "Sans 14" ;
	     `anchor `NW ]
    grp


let create_sample_arrow grp p =
  GnoCanvas.line
    ~props:[ `points p ; `fill_color "black" ;
	     `first_arrowhead true ; `last_arrowhead true ]
    grp


let create_canvas_arrowhead window =
  let vbox = GPack.vbox ~border_width:4 ~packing:window#add () in
  GMisc.label
    ~text:"This demo allows you to edit arrowhead shapes.  Drag the little boxes\n\
	   to change the shape of the line and its arrowhead.  You can see the\n\
           arrows at their normal scale on the right hand side of the window."
    ~packing:vbox#add () ;
  let align = GBin.alignment
      ~x:0.5 ~y:0.5 
      ~xscale:0. ~yscale:0. 
      ~packing:vbox#add () in
  let frame = GBin.frame ~shadow_type:`IN ~packing:align#add () in

  let canvas = GnoCanvas.canvas ~width:500 ~height:350 ~packing:frame#add () in
  canvas#set_scroll_region 0. 0. 500. 350. ;
  let root = canvas#root in

  let p = [| left; middle; right; middle |] in
  let big_arrow = GnoCanvas.line root
      ~props:[ `points p ; `fill_color "mediumseagreen" ;
	       `width_pixels (config.width * 10) ;
	       `last_arrowhead true ] in
  let outline = GnoCanvas.line root
      ~props:[ `fill_color "black" ;
	       (* `capstyle `ROUND ; `join_style `ROUND ; *)
	       `width_pixels 2; ] in
  
  let width_drag_box = create_drag_box root (width_event config) in
  let shape_a_drag_box = create_drag_box root (shape_a_event config) in
  let shape_b_c_drag_box = create_drag_box root (shape_b_c_event config) in

  let width_items = create_dimension root `EAST in
  let shape_a_items = create_dimension root `NORTH in
  let shape_b_items = create_dimension root `NORTH in
  let shape_c_items = create_dimension root `WEST in

  let width_info = create_info root ~x:left ~y:260. in
  let shape_a_info = create_info root ~x:left ~y:280. in
  let shape_b_info = create_info root ~x:left ~y:300. in
  let shape_c_info = create_info root ~x:left ~y:320. in

  let p = [| right +. 50.; 0.; right +. 50.; 1000. |] in
  GnoCanvas.line root
    ~props:[ `points p; `fill_color "black" ;
	     `width_pixels 2 ] ;

  let samples = 
    List.map (create_sample_arrow root)
      [ [| right +. 100.; 30.; right +. 100. ; middle -. 30. |] ;
	[| right +. 70. ; middle; right +. 130. ; middle |] ;
	[| right +. 70. ; middle +. 30. ; right +. 130. ; middle +. 120. |] ]
  in
  
  global_data := Some
      { big_arrow = big_arrow ;
	outline = outline ;
	width_drag_box = width_drag_box ;
	shape_a_drag_box = shape_a_drag_box ;
	shape_b_c_drag_box = shape_b_c_drag_box ;
	width_items = width_items ;
	shape_a_items = shape_a_items ;
	shape_b_items = shape_b_items ;
	shape_c_items = shape_c_items ;
	width_info = width_info ;
	shape_a_info = shape_a_info ;
	shape_b_info = shape_b_info ;
	shape_c_info = shape_c_info ;
	samples = samples ; } ;

  set_arrow_shape config




let main_1 () =
  let window = GWindow.window () in

  create_canvas_arrowhead window ;

  window#connect#destroy ~callback:GMain.Main.quit ;

  window#show () ;
  GMain.Main.main ()

let _ = 
   main_1 ()



(* Local Variables: *)
(* compile-command: "ocamlopt -w s -i -I ../../src lablgtk.cmxa gtkInit.cmx lablgnomecanvas.cmxa canvas-arrowhead.ml" *)
(* End: *)

(* This examples combines Cairo and Pango to implement a renderer for
   natural deduction trees.

   Author: Claudio Sacerdoti Coen
*)

type nd_tree =
 { conclusion: string
 ; rule : string
 ; premises: nd_tree list option
 }

let test =
 { conclusion = "(A ∨ D ⇒ B) ⇒ (A ⇒ C) ⇒ A ⇒ B ∧ C"
 ; rule = "⇒<sub>i</sub>"
 ; premises = Some
   [ { conclusion = "(A ⇒ C) ⇒ A ⇒ B ∧ C"
     ; rule = "⇒i"
     ; premises = Some
       [ { conclusion = "A ⇒ B ∧ C"
         ; rule = "⇒i"
         ; premises = Some
           [ { conclusion = "B ∧ C"
             ; rule = "∧i"
             ; premises = Some
               [ { conclusion = "B"
                 ; rule = "⇒e"
                 ; premises = Some
                   [ { conclusion = "[A ∨ D ⇒ B]"
                     ; rule = ""
                     ; premises = None }
                   ; { conclusion = "A ∨ D"
                     ; rule = "∨i<sub>l</sub>"
                     ; premises = Some
                       [ { conclusion = "[A]"
                         ; rule = ""
                         ; premises = None } ] } ] }
               ; { conclusion = "C"
                 ; rule = "⇒e"
                 ; premises = Some
                   [ { conclusion = "[A ⇒ C]"
                     ; rule = ""
                     ; premises = None }
                   ; { conclusion = "[A]"
                     ; rule = ""
                     ; premises = None } ] } ] } ] } ] } ] }

type sized_layout =
 { layout : GPango.layout
 ; width : float
 ; height : float }

type nd_tree_layout =
 { ndl_conclusion : sized_layout
 ; ndl_rule : sized_layout
 ; ndl_premises : nd_tree_layout list option
 ; ndl_padding : float
 ; ndl_width : float       (* total width of tree *)
 ; ndl_height : float      (* total height of tree *)
 }

let map_opt f = function None -> None | Some x -> Some (f x)
let map_opt_d d f = function None -> d | Some x -> f x
let rec last = function [] -> assert false | [x] -> x | _::tl -> last tl

(* where the conclusions are printed *)
type area = { x : float ; y : float ; w : float ; h : float }

let font_size = ref 100
let highlighted = ref None
let pressed = ref false

(* the pad must leave enough space for rule names *)
let pad () = float !font_size *. 3. /. 10.
(* the minipad is put between the inference rule and the rule name *)
let minipad () = pad () /. 70.

let resize a d () =
 font_size := int_of_float a#value ;
 highlighted := None ;
 pressed := false ;
 d#misc#queue_draw ()

let leave d _ =
 highlighted := None ;
 pressed := false ;
 d#misc#queue_draw () ;
 true

let layout_text cr ?(percent=100) text =
 let layout = new GPango.layout (Cairo_pango.create_layout cr) in
 let pango_context = layout#get_context in
 let fd = pango_context#font_description in
 fd#modify ~size:(fd#size * !font_size * percent / 10000) () ;
 pango_context#set_font_description fd ;
 layout#set_markup text ;
 let width,height = layout#get_pixel_size in
 { layout; width = float width ; height = float height }

(* turn a nd_tree into a nd_tree_layout by recursively computing all relevant
   sizes and by engraving strings into Pango layouts *)
let rec layout_nd_tree cr t =
 let ndl_premises = map_opt (List.map (layout_nd_tree cr)) t.premises in
 let {layout;width;height} = layout_text cr t.conclusion in
 let ndl_rule = layout_text cr ~percent:75 t.rule in
 let padding = float (max 0 (map_opt_d 0 List.length ndl_premises - 1)) *. pad () in
 let premises_width =
  map_opt_d 0. (List.fold_left (fun acc x -> acc +. x.ndl_width) 0.) ndl_premises
   +. padding in
 let ndl_width = max width premises_width in
 let ndl_height =
  height +.
   (map_opt_d 0. (List.fold_left (fun x p -> max x p.ndl_height) 0.) ndl_premises)
 in
 let ndl_padding = max 0. (width -. premises_width) in
 { ndl_conclusion = { layout ; width ; height } ; ndl_rule
 ; ndl_premises ; ndl_padding ; ndl_width ; ndl_height }

(* If centered=true then (x,y) is the middle-point below the conclusion;
   otherwise it is the lowermost-leftmost point of the bounded box of the
   tree. It returns a list of areas. *)
let rec draw_nd_tree_layout ?(map = []) ?(centered = true) cr x y t =
 let cw = t.ndl_conclusion.width in
 let ch = t.ndl_conclusion.height in
 let pw = t.ndl_width in
 (* redefine (x,y) to be middle-point above the conclusion *)
 let x = if centered then x else x +. pw /. 2. in
 let y = y -. ch in
 Cairo.move_to cr (x -.  cw /. 2.) y ;
 Cairo_pango.show_layout cr t.ndl_conclusion.layout#as_layout ;
 let map = {x = x -. cw /. 2. ; y ; w=cw ; h=ch}::map in
 match t.ndl_premises with
    None -> map
  | Some l ->
     if l <> [] && let fst = List.hd l in let lst = last l in
        2. *. pw -. fst.ndl_width -. lst.ndl_width
        +. fst.ndl_conclusion.width +. lst.ndl_conclusion.width
     >= 2. *. cw
     then begin
      let fst = List.hd l in
      let lst = last l in
      Cairo.move_to cr
        (x -. (pw -. fst.ndl_width +. fst.ndl_conclusion.width) /. 2.) y ;
      Cairo.line_to cr
        (x +. (pw -. lst.ndl_width +. lst.ndl_conclusion.width) /. 2.) y ;
     end else begin
      Cairo.move_to cr (x -. cw /. 2.) y ;
      Cairo.line_to cr (x +. cw /. 2.) y ;
     end ;
     Cairo.rel_move_to cr (minipad ()) (-. t.ndl_rule.height /. 2.) ;
     Cairo_pango.show_layout cr t.ndl_rule.layout#as_layout ;
     Cairo.stroke cr ;
     draw_premises ~map cr (x -. pw /. 2. +. t.ndl_padding /. 2.) y l

and draw_premises ~map cr x y tl =
 fst (
  List.fold_left
   (fun (map,x) t ->
     let map = draw_nd_tree_layout ~map cr ~centered:false x y t in
     map,x +. t.ndl_width +. pad ())
   (map,x) tl)

let areas = ref []

let inside x b w = b <= x && x <= b+.w

let look_for_area x y =
 List.find_opt
  (fun area -> inside x area.x area.w && inside y area.y area.h) !areas

let draw (drawing_area : #GMisc.drawing_area) cr =
 
 let l = layout_nd_tree cr test in
 drawing_area#misc#set_size_request ~width:(int_of_float l.ndl_width)
  ~height:(int_of_float l.ndl_height) ();
 let allocation = drawing_area#misc#allocation in
 let w = float allocation.Gtk.width in
 let h = float allocation.Gtk.height in
 Cairo.set_source_rgba cr 1. 1. 1. 1.;
 Cairo.rectangle cr 0. 0. w h ;
 Cairo.fill cr ;
 Cairo.set_source_rgba cr 0. 0. 0. 1.;
 areas := draw_nd_tree_layout cr (w /. 2.) h l ;
 (match !highlighted with
     None -> ()
   | Some {x;y;w;h} ->
      if !pressed then
       Cairo.set_source_rgba cr 0. 1. 0. 0.5
      else
       Cairo.set_source_rgba cr 1. 0. 0. 0.5;
      Cairo.rectangle cr x y ~w ~h;
      Cairo.fill cr;
      Cairo.set_source_rgba cr 0. 0. 0. 1.
 );
 true

let button_press d b =
 let x = GdkEvent.Button.x b in
 let y = GdkEvent.Button.y b in
 highlighted := look_for_area x y;
 pressed := true;
 d#misc#queue_draw ();
 true

let motion_notify d b =
 let x = GdkEvent.Motion.x b in
 let y = GdkEvent.Motion.y b in
 highlighted := look_for_area x y;
 pressed := false;
 d#misc#queue_draw ();
 true

let () =
  let _ = GMain.init () in
  let w = GWindow.window ~title:"Natural deduction demo" () in
  w#set_default_size ~width:400 ~height:(Gdk.Screen.height () * 3 / 4);
  ignore(w#connect#destroy ~callback:GMain.quit);

  let b = GPack.box `VERTICAL ~packing:w#add () in

  let a = GData.adjustment ~lower:50. ~value:100. ~upper:210. () in
  let f =
   GRange.scale `HORIZONTAL ~draw_value:false ~adjustment:a ~digits:0
    ~packing:b#pack () in

  let s = GBin.scrolled_window ~packing:b#add () in

  let d = GMisc.drawing_area ~packing:s#add () in
  ignore(d#misc#connect#draw ~callback:(draw d));
  ignore(d#event#connect#button_press ~callback:(button_press d));
  ignore(d#event#connect#motion_notify ~callback:(motion_notify d));
  ignore(f#connect#value_changed ~callback:(resize a d));
  ignore(d#event#connect#leave_notify ~callback:(leave d));
  d#set_events [`BUTTON_PRESS ; `POINTER_MOTION ; `LEAVE_NOTIFY ];

  w#show();
  GMain.main()

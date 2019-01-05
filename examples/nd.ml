(* This examples combines Cairo and Pango to implement a renderer for
   natural deduction trees.

   Author: Claudio Sacerdoti Coen
*)

type nd_tree =
 { conclusion: string
 ; premises: nd_tree list option
 }

let test =
 { conclusion = "(A ∨ D ⇒ B) ⇒ (A ⇒ C) ⇒ A ⇒ B ∧ C"
 ; premises = Some
   [ { conclusion = "(A ⇒ C) ⇒ A ⇒ B ∧ C"
     ; premises = Some
       [ { conclusion = "A ⇒ B ∧ C"
         ; premises = Some
           [ { conclusion = "B ∧ C"
             ; premises = Some
               [ { conclusion = "B"
                 ; premises = Some
                   [ { conclusion = "[A ∨ D ⇒ B]"
                     ; premises = None }
                   ; { conclusion = "A ∨ D"
                     ; premises = Some
                       [ { conclusion = "[A]"
                         ; premises = None } ] } ] }
               ; { conclusion = "C"
                 ; premises = Some
                   [ { conclusion = "[A ⇒ C]"
                     ; premises = None }
                   ; { conclusion = "[A]"
                     ; premises = None } ] } ] } ] } ] } ] }

type conclusion_layout =
 { layout : GPango.layout
 ; width : float
 ; height : float }

type nd_tree_layout =
 { ndl_conclusion : conclusion_layout
 ; ndl_premises : nd_tree_layout list option
 ; ndl_padding : float
 ; ndl_width : float       (* total width of tree *)
 }

let map_opt f = function None -> None | Some x -> Some (f x)
let map_opt_d d f = function None -> d | Some x -> f x
let rec last = function [] -> assert false | [x] -> x | _::tl -> last tl

let pad = 10.

(* turn a nd_tree into a nd_tree_layout by recursively computing all relevant
   sizes and by engraving strings into Pango layouts *)
let rec layout_nd_tree cr t =
 let ndl_premises = map_opt (List.map (layout_nd_tree cr)) t.premises in
 let layout = new GPango.layout (Cairo_pango.create_layout cr) in
 layout#set_markup t.conclusion ;
 let width,height = layout#get_pixel_size in
 let width = float width in
 let height = float height in
 let padding = float (max 0 (map_opt_d 0 List.length ndl_premises - 1)) *. pad in
 let premises_width =
  map_opt_d 0. (List.fold_left (fun acc x -> acc +. x.ndl_width) 0.) ndl_premises
   +. padding in
 let ndl_width = max width premises_width in
 let ndl_padding = max 0. (ndl_width -. premises_width) in
 { ndl_conclusion = { layout ; width ; height }
 ; ndl_premises ; ndl_padding ; ndl_width }

(* if centered=true then (x,y) is the middle-point below the conclusion;
   otherwise it is the lowermost-leftmost point of the bounded box of the
   tree *)
let rec draw_nd_tree_layout ?(centered = true) cr x y t =
 let cw = t.ndl_conclusion.width in
 let ch = t.ndl_conclusion.height in
 let pw = t.ndl_width in
 (* redefine (x,y) to be middle-point above the conclusion *)
 let x = if centered then x else x +. pw /. 2. in
 let y = y -. ch in
 Cairo.move_to cr (x -.  cw /. 2.) y ;
 Cairo_pango.show_layout cr t.ndl_conclusion.layout#as_layout ;
 match t.ndl_premises with
    None -> ()
  | Some l ->
     if t.ndl_padding = 0. then begin
      let fst = List.hd l in
      let lst = last l in
      Cairo.move_to cr
        (x -. (pw -. fst.ndl_width +. fst.ndl_conclusion.width) /. 2.) y ;
      Cairo.line_to cr
        (x +. (pw -. lst.ndl_width +. lst.ndl_conclusion.width) /. 2.) y ;
      Cairo.stroke cr ;
     end else begin
      Cairo.move_to cr (x -. cw /. 2.) y ;
      Cairo.line_to cr (x +. cw /. 2.) y ;
      Cairo.stroke cr ;
     end ;
     draw_premises cr (x -. pw /. 2. +. t.ndl_padding /. 2.) y l

and draw_premises cr x y tl =
 ignore (
  List.fold_left
   (fun x t ->
     draw_nd_tree_layout cr ~centered:false x y t ;
     x +. t.ndl_width +. pad)
   x tl)

let expose drawing_area cr =
 let allocation = drawing_area#misc#allocation in
 let w = float allocation.Gtk.width in
 let h = float allocation.Gtk.height in
 let l = layout_nd_tree cr test in
 draw_nd_tree_layout cr (w /. 2.) h l ;
 true

let () =
  let w = GWindow.window ~title:"Natural deduction demo" ~width:500 ~height:400 () in
  ignore(w#connect#destroy ~callback:GMain.quit);

  let d = GMisc.drawing_area ~packing:w#add () in
  ignore(d#misc#connect#draw ~callback:(expose d));

  w#show();
  GMain.main()

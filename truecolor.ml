(* Truecolor quick color query *) 

open Gdk

type visual_shift_prec = {
  red_shift : int;
  red_prec : int;
  green_shift : int;
  green_prec : int;
  blue_shift : int;
  blue_prec : int
}
 
let shift_prec visual = {
  red_shift = Visual.red_shift visual;
  red_prec = Visual.red_prec visual;
  green_shift = Visual.green_shift visual;
  green_prec = Visual.green_prec visual;
  blue_shift = Visual.blue_shift visual;
  blue_prec = Visual.blue_prec visual;
}

let color_creator visual =
  match Visual.get_type visual with
    `TRUE_COLOR | `DIRECT_COLOR ->
      let shift_prec = shift_prec visual in
    (*
    prerr_endline (Format.sprintf "red : %d %d" shift_prec.red_shift shift_prec.red_prec);
    prerr_endline (Format.sprintf "green : %d %d" shift_prec.green_shift shift_prec.green_prec);
    prerr_endline (Format.sprintf "blue : %d %d" shift_prec.blue_shift shift_prec.blue_prec);
    *)
      let red_lsr = 16 - shift_prec.red_prec
      and green_lsr = 16 - shift_prec.green_prec
      and blue_lsr = 16 - shift_prec.blue_prec in
      fun red: red green: green blue: blue ->
	(((red lsr red_lsr) lsl shift_prec.red_shift) lor 
    	 ((green lsr green_lsr) lsl shift_prec.green_shift) lor
    	 ((blue lsr blue_lsr) lsl shift_prec.blue_shift))
  | _ -> raise (Invalid_argument "color_creator")

let color_parser visual =
  match Visual.get_type visual with
    `TRUE_COLOR | `DIRECT_COLOR ->
      let shift_prec = shift_prec visual in
      let red_lsr = 16 - shift_prec.red_prec
      and green_lsr = 16 - shift_prec.green_prec
      and blue_lsr = 16 - shift_prec.blue_prec in
      let mask = 1 lsl 16 - 1 in
      fun pixel ->
	((pixel lsr shift_prec.red_shift) lsl red_lsr) land mask,
	((pixel lsr shift_prec.green_shift) lsl green_lsr) land mask,
	((pixel lsr shift_prec.blue_shift) lsl blue_lsr) land mask
  | _ -> raise (Invalid_argument "color_parser")

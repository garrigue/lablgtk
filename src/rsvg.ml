(* $Id$ *)

type size_fun = int -> int -> int * int

let round f =
  int_of_float (if f < 0. then f -. 0.5 else f +. 0.5)

let default w h = (w, h)
let at_size rw rh w h = 
  (if rw < 0 then w else rw), (if rh < 0 then h else rh)
let at_zoom zx zy w h =
  if w < 0 || h < 0
  then (w, h)
  else
    (round (float w *. zx)), (round (float h *. zy))
let at_max_size mw mh w h =
  if w < 0 || h < 0
  then (w, h)
  else
    let zx = float mw /. float w in
    let zy = float mh /. float h in
    let z = min zx zy in
    (round (float w *. z)), (round (float h *. z))

let at_zoom_with_max zx zy mw mh w h =
  if w < 0 || h < 0
  then (w, h)
  else 
    let rw = round (float w *. zx) in
    let rh = round (float h *. zy) in
    if rw > mw || rh > mh
    then 
      let zx = float mw /. float w in
      let zy = float mh /. float h in
      let z = min zx zy in
      (round (float w *. z)), (round (float h *. z))
    else
      (rw, rh)

type t
external new_handle : unit -> t
    = "ml_rsvg_handle_new"
external set_size_callback : t -> size_fun -> unit
    = "ml_rsvg_handle_set_size_callback"
external free_handle : t -> unit
    = "ml_rsvg_handle_free"
external close : t -> unit = "ml_rsvg_handle_close"
external write : t -> string -> off:int -> len:int -> unit = "ml_rsvg_handle_write"
external get_pixbuf : t -> GdkPixbuf.pixbuf = "ml_rsvg_handle_get_pixbuf"
external set_dpi : t -> float -> unit = "ml_rsvg_handle_set_dpi"
external set_default_dpi : float -> unit = "ml_rsvg_set_default_dpi"

let render ?dpi ?(size_cb=default) buff =
  let h = new_handle () in
  set_size_callback h size_cb ;
  begin match dpi with
  | None -> ()
  | Some v -> set_dpi h v end ;
  write h buff 0 (String.length buff) ;
  close h ;
  let pb = get_pixbuf h in
  free_handle h ; 
  pb

let render_from_file ?dpi ?size_cb fname =
  let ic = open_in fname in
  let len = in_channel_length ic in
  let buff = String.create len in
  really_input ic buff 0 len ;
  close_in ic ;
  render ?dpi ?size_cb buff

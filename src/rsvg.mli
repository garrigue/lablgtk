(* $Id$ *)
(** librsvg bindings *)

type size_fun = int -> int -> int * int

val at_size : int -> int -> size_fun
val at_zoom : float -> float -> size_fun
val at_max_size : int -> int -> size_fun
val at_zoom_with_max : float -> float -> int -> int -> size_fun

val set_default_dpi : float -> unit

val render : ?dpi:float -> ?size_cb:size_fun -> string -> GdkPixbuf.pixbuf
val render_from_file :
             ?dpi:float -> ?size_cb:size_fun -> string -> GdkPixbuf.pixbuf

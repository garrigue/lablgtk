(* $Id$ *)
(** librsvg bindings *)

type size_fun = int -> int -> int * int

val at_size : int -> int -> size_fun
val at_zoom : float -> float -> size_fun
val at_max_size : int -> int -> size_fun
val at_zoom_with_max : float -> float -> int -> int -> size_fun

val set_default_dpi : float -> unit

(** @raise Error if an error occurs loading data *)
(** @raise Sys_error if an error occurs while reading from the channel *)
val render_from_string :
  ?gz:bool -> 
  ?dpi:float -> 
  ?size_cb:size_fun -> 
  ?pos:int -> ?len:int ->
  string -> GdkPixbuf.pixbuf

(** @raise Error if an error occurs loading data *)
(** @raise Sys_error if an error occurs while reading from the file *)
val render_from_file :
  ?gz:bool -> 
  ?dpi:float -> 
  ?size_cb:size_fun -> 
  string -> GdkPixbuf.pixbuf

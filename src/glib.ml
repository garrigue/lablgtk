(* $Id$ *)

type warning_func = string -> unit

external set_warning_handler : (string -> unit) -> warning_func
    = "ml_g_set_warning_handler"

type print_func = string -> unit

external set_print_handler : (string -> unit) -> print_func
    = "ml_g_set_print_handler"

module Main = struct
  type t
  external create : bool -> t = "ml_g_main_new"
  external iteration : bool -> unit = "ml_g_main_iteration"
  external is_running : t -> bool = "ml_g_main_is_running"
  external quit : t -> unit = "ml_g_main_quit"
  external destroy : t -> unit = "ml_g_main_destroy"
end

(* $Id$ *)

type warning_func = string -> unit

external set_warning_handler : (string -> unit) -> warning_func
    = "ml_g_set_warning_handler"

type print_func = string -> unit

external set_print_handler : (string -> unit) -> print_func
    = "ml_g_set_print_handler"

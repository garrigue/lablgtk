(* $Id$ *)

type pointer

type warning_func = string -> unit

external set_warning_handler : (string -> unit) -> warning_func
    = "ml_g_set_warning_handler"

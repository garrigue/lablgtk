(* $Id$ *)

type print_func = string -> unit

external set_print_handler : (string -> unit) -> print_func
    = "ml_g_set_print_handler"

module Main = struct
  type t
  external create : bool -> t = "ml_g_main_new"
  external iteration : bool -> bool = "ml_g_main_iteration"
  external pending : unit -> bool = "ml_g_main_pending"
  external is_running : t -> bool = "ml_g_main_is_running"
  external quit : t -> unit = "ml_g_main_quit"
  external destroy : t -> unit = "ml_g_main_destroy"
end

module Io = struct
  type channel
  type condition = [ `IN | `OUT | `PRI | `ERR | `HUP | `NVAL ]
  external channel_of_descr : Unix.file_descr -> channel
    = "ml_g_io_channel_unix_new"   (* Unix only *)
  external add_watch :
    cond:condition -> callback:(unit -> bool) -> ?prio:int -> channel -> unit
    = "ml_g_io_add_watch"
end

(*
module Thread = struct
  external init : unit -> unit = "ml_g_thread_init"
      (* Call only once! *)
  external enter : unit -> unit = "ml_gdk_threads_enter"
  external leave : unit -> unit = "ml_gdk_threads_leave"
end
*)

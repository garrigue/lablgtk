(* $Id$ *)

type print_func = string -> unit

external set_print_handler : (string -> unit) -> print_func
    = "ml_g_set_print_handler"

exception GError of string
let () = Callback.register_exception "gerror" (GError "")

module Main = struct
  type t
  external create : bool -> t = "ml_g_main_new"
  external iteration : bool -> bool = "ml_g_main_iteration"
  external pending : unit -> bool = "ml_g_main_pending"
  external is_running : t -> bool = "ml_g_main_is_running"
  external quit : t -> unit = "ml_g_main_quit"
  external destroy : t -> unit = "ml_g_main_destroy"
end

module Timeout = struct
  type id
  external add : ms:int -> callback:(unit -> bool) -> id
    = "ml_g_timeout_add"
  external remove : id -> unit = "ml_g_source_remove"
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

module Conversion = struct
  external convert_ : string -> int -> string -> string -> string =
	"ml_g_convert"
  let convert 
	?length
	~to_codeset
        ~from_codeset text =
	
    convert_ text 
	(match length with
	 | None -> String.length text
	 | Some i -> i)
 	 to_codeset from_codeset
	 	
end

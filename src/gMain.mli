(* $Id$ *)

module Main : sig
  val init : ?setlocale:bool -> unit -> string
    (* [init] returns the locale name *)
    (* Set [~setlocale] to [true] if your program needs a non-C locale *)
  val main : unit -> unit
    (* [main] runs the main loop, until [quit] is called. *)
    (* Do not use in multi-threaded programs. *)
  val quit : unit -> unit
    (* quit the main loop *)
  val version : int * int * int
    (* [major, minor, micro] *)
end

val main : unit -> unit (* cf. [Main.main] *)
val quit : unit -> unit (* cf. [Main.quit] *)

module Grab : sig
  val add : #GObj.widget -> unit
  val remove : #GObj.widget -> unit
  val get_current : unit -> GObj.widget
end

module Rc : sig
  val add_default_file : string -> unit
end

module Timeout : sig
  type id = GtkMain.Timeout.id
  val add : ms:int -> callback:(unit -> bool) -> id
  val remove : id -> unit
end

module Io : sig
  type event_source
  type channel = Glib.Io.channel
  type condition = [ `IN | `OUT | `PRI | `ERR | `HUP | `NVAL ]
  val channel_of_descr : Unix.file_descr -> channel (* Unix only *)
  val remove_source : event_source -> bool
  val add_watch :
    cond:condition -> callback:(unit -> bool) -> ?prio:int -> channel -> event_source
	
end

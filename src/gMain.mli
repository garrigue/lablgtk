(* $Id$ *)

(** Library initialization, main event loop, and events *)

(** @gtkdoc gtk gtk-General *)
module Main : sig
  val init : ?setlocale:bool -> unit -> string
    (** [init] also sets the locale and returns its name.
       Either set [~setlocale] to [false] or GTK_SETLOCALE to "0"
       if you don't want to the locale to be set *)
  val main : unit -> unit
    (** [main] runs the main loop, until [quit] is called.
       {e Do not use in multi-threaded programs.} *)
  val quit : unit -> unit
    (** quit the main loop *)
  val version : int * int * int
    (** [major, minor, micro] *)
end

(** Direct access to functions of [GMain.Main] *)

val init : ?setlocale:bool -> unit -> string
val main : unit -> unit
val quit : unit -> unit

(** Global structures *)

val selection : GData.clipboard
val clipboard : GData.clipboard

module Grab : sig
  val add : #GObj.widget -> unit
  val remove : #GObj.widget -> unit
  val get_current : unit -> GObj.widget
end

module Rc : sig
  val add_default_file : string -> unit
end

module Timeout : sig
  type id = Glib.Timeout.id
  val add : ms:int -> callback:(unit -> bool) -> id
  val remove : id -> unit
end

module Idle : sig
  type id = Glib.Idle.id
  val add : callback:(unit -> bool) -> id
  val remove : id -> unit
end

module Io : sig
  type channel = Glib.Io.channel
  type condition = [ `IN | `OUT | `PRI | `ERR | `HUP | `NVAL ]
  val channel_of_descr : Unix.file_descr -> channel (* Unix only *)
  val add_watch :
    cond:condition -> callback:(unit -> bool) -> ?prio:int -> channel -> unit
end

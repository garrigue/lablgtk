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

module Timeout : sig
  type id = GtkMain.Timeout.id
  val add : ms:int -> callback:(unit -> bool) -> id
  val remove : id -> unit
end

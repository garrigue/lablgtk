(* $Id$ *)

open Gtk

type id
type ('a, 'b) t = { name : string; marshaller : 'b -> GtkArgv.t -> unit }

exception Stop_emit
    (* This exception may be raised in a call back to prohibit further
       handling of the current signal invocation, by calling
       [emit_stop_by_name]. Be careful about where you use it, since
       the concept of current signal may be tricky. *)
val stop_emit : unit -> 'a
    (* raise [Stop_emit] *)

val connect :
  sgn:('a, 'b) t -> callback:'b -> ?after:bool -> 'a obj -> id
    (* You may use [stop_emit] inside the callback *)

external disconnect : 'a obj -> id -> unit
  = "ml_gtk_signal_disconnect"
external emit_stop_by_name : 'a obj -> name:string -> unit
  = "ml_gtk_signal_emit_stop_by_name"
    (* Unsafe: use [stop_emit] instead. *)
external handler_block : 'a obj -> id -> unit
  = "ml_gtk_signal_handler_block"
external handler_unblock : 'a obj -> id -> unit
  = "ml_gtk_signal_handler_unblock"

(* Some marshaller functions, to build signals *)
val marshal_unit : (unit -> 'a) -> GtkArgv.t -> 'a
val marshal_int : (int -> 'a) -> GtkArgv.t -> 'a

(* Emitter functions *)
val emit :
  'a obj -> sgn:('a, 'b) t -> emitter:('a obj -> name:string -> 'b) -> 'b
val emit_unit : 'a obj -> sgn:('a, unit -> unit) t -> unit
val emit_int : 'a obj -> sgn:('a, int -> unit) t -> int -> unit

(* $Id$ *)

open Gtk

type id
type ('a, 'b) t = { name : string; marshaller : 'b -> GtkArgv.t -> unit }

exception Stop_emit
    (* This exception may be raised in a call back to prohibit further
       handling of the current signal invocation, by calling
       [emit_stop_by_name]. Be careful about where you use it, since
       the concept of current signal may be tricky. *)

val connect :
  sgn:('a, 'b) t -> callback:'b -> ?after:bool -> 'a obj -> id
    (* You may raise [Stop_emit] inside the callback *)

external disconnect : 'a obj -> id -> unit
  = "ml_gtk_signal_disconnect"
external emit_stop_by_name : 'a obj -> name:string -> unit
  = "ml_gtk_signal_emit_stop_by_name"
    (* Better to avoid it, and use [Stop_emit] instead. *)
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
val emit_none : 'a obj -> sgn:('a, unit -> unit) t -> unit
val emit_int : 'a obj -> sgn:('a, int -> unit) t -> int -> unit

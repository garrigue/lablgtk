(* $Id$ *)

open Gobject

type id
type ('a,'b) t =
 { name: string; classe: 'a;
   marshaller: ('b -> Closure.argv -> data_get list -> unit) }

val stop_emit : unit -> unit
    (* Call [stop_emit ()] in a callback to prohibit further handling
       of the current signal invocation, by calling [emit_stop_by_name].
       Be careful about where you use it, since the concept of current
       signal may be tricky. *)

val connect :
  sgn:('a, 'b) t -> callback:'b -> ?after:bool -> 'a obj -> id
    (* You may use [stop_emit] inside the callback *)

external connect_by_name :
  'a obj -> name:string -> callback:g_closure -> after:bool -> id
  = "ml_g_signal_connect_closure"
external disconnect : 'a obj -> id -> unit
  = "ml_g_signal_handler_disconnect"
external emit_stop_by_name : 'a obj -> name:string -> unit
  = "ml_g_signal_stop_emission_by_name"
    (* Unsafe: use [stop_emit] instead. *)
external handler_block : 'a obj -> id -> unit
  = "ml_g_signal_handler_block"
external handler_unblock : 'a obj -> id -> unit
  = "ml_g_signal_handler_unblock"

(* Some marshaller functions, to build signals *)
val marshal_unit : (unit -> unit) -> Closure.argv -> data_get list -> unit
val marshal_int : (int -> unit) -> Closure.argv -> data_get list -> unit

(* Emitter functions *)
val emit :
  'a Gobject.obj -> sgn:('a, 'b) t ->
  emitter:(cont:('c Gobject.data_set array -> 'd) -> 'b) ->
  conv:(Gobject.g_value -> 'd) -> 'b
val emit_unit : 'a obj -> sgn:('a, unit -> unit) t -> unit
val emit_int : 'a obj -> sgn:('a, int -> unit) t -> int -> unit

(* Internal functions. *)
val enter_callback : (unit -> unit) ref
val exit_callback : (unit -> unit) ref
type saved_state
val push_callback : unit -> saved_state
val pop_callback : saved_state -> bool

(* $Id$ *)

open Gtk

type id
type ('a,'b) t = { name: string; marshaller: 'b -> GtkArgv.t -> unit }
external connect :
  'a obj -> name:string ->
  callback:(GtkArgv.t -> unit) -> after:bool -> id
  = "ml_gtk_signal_connect"
let connect : 'a obj -> sig:('a, _) t -> _ =
  fun obj sig:signal :callback ?:after [< false >] ->
    connect obj name:signal.name callback:(signal.marshaller callback) :after
external disconnect : 'a obj -> id -> unit
  = "ml_gtk_signal_disconnect"
external emit : 'a obj -> name:string -> unit = "ml_gtk_signal_emit_by_name"
let emit (obj : 'a obj) sig:(sgn : ('a,unit->unit) t) =
  emit obj name:sgn.name
external emit_stop_by_name: 'a obj -> name:string -> unit
  = "ml_gtk_signal_emit_stop_by_name"
external handler_block: 'a obj -> id -> unit
  = "ml_gtk_signal_handler_block"
external handler_unblock: 'a obj -> id -> unit
  = "ml_gtk_signal_handler_unblock"

let marshal_unit f _ = f ()
let marshal_int f argv = f (GtkArgv.get_int argv pos:0)

(* $Id$ *)

open Gtk

type id
type ('a,'b) t =
 { name: string;
   marshaller: ('b -> GtkArgv.t -> unit) }

external connect :
  'a obj -> name:string -> callback:(GtkArgv.t -> unit) -> after:bool -> id
  = "ml_gtk_signal_connect"
exception Stop_emit
let stop_emit () = raise Stop_emit
external emit_stop_by_name : 'a obj -> name:string -> unit
  = "ml_gtk_signal_emit_stop_by_name"
let connect  ~(sgn : ('a, _) t) ~callback ?(after=false) (obj : 'a obj) =
  let callback argv =
    try sgn.marshaller callback argv
    with Stop_emit ->
      emit_stop_by_name obj ~name:sgn.name
  in
  connect obj ~name:sgn.name ~callback ~after
external disconnect : 'a obj -> id -> unit
  = "ml_gtk_signal_disconnect"
external handler_block : 'a obj -> id -> unit
  = "ml_gtk_signal_handler_block"
external handler_unblock : 'a obj -> id -> unit
  = "ml_gtk_signal_handler_unblock"

let marshal_unit f _ = f ()
let marshal_int f argv = f (GtkArgv.get_int argv ~pos:0)

let emit (obj : 'a obj) ~(sgn : ('a, 'b) t)
    ~(emitter : 'a obj -> name:string -> 'b) =
  emitter obj ~name:sgn.name
external emit_none : 'a obj -> name:string -> unit -> unit
    = "ml_gtk_signal_emit_none"
let emit_unit obj ~sgn = emit obj ~emitter:emit_none ~sgn ()
external emit_int : 'a obj -> name:string -> int -> unit
    = "ml_gtk_signal_emit_int"
let emit_int = emit ~emitter:emit_int

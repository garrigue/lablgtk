(* $Id$ *)

open Gtk

type id
type ('a,'b) t =
 { name: string; classe: 'a;
   marshaller: ('b -> GtkArgv.t -> GtkArgv.data list -> unit) }

let enter_callback = ref (fun () -> ())
and exit_callback = ref (fun () -> ())

let stop_emit_ref = ref false
let stop_emit () = stop_emit_ref := true

type saved_state = State of bool
let push_callback () =
  !enter_callback ();
  let old = !stop_emit_ref in
  stop_emit_ref := false;
  State old

let pop_callback (State old) =
  let res = !stop_emit_ref in
  stop_emit_ref := old;
  !exit_callback ();
  res

external connect_by_name :
  'a obj -> name:string -> callback:(GtkArgv.t -> unit) -> after:bool -> id
  = "ml_gtk_signal_connect"
external emit_stop_by_name : 'a obj -> name:string -> unit
  = "ml_gtk_signal_emit_stop_by_name"
let connect  ~(sgn : ('a, _) t) ~callback ?(after=false) (obj : 'a obj) =
  let callback argv =
    let old = push_callback () in
    let exn =
      try sgn.marshaller callback argv (GtkArgv.get_args argv); None
      with exn -> Some exn
    in
    if pop_callback old then emit_stop_by_name obj ~name:sgn.name;
    Gaux.may ~f:raise exn
  in
  connect_by_name obj ~name:sgn.name ~callback ~after
external disconnect : 'a obj -> id -> unit
  = "ml_gtk_signal_disconnect"
external handler_block : 'a obj -> id -> unit
  = "ml_gtk_signal_handler_block"
external handler_unblock : 'a obj -> id -> unit
  = "ml_gtk_signal_handler_unblock"

let marshal_unit f _ _ = f ()
let marshal_int f _ = function
  | GtkArgv.INT n :: _ -> f n
  | _ -> invalid_arg "GtkSignal.marshal_int"
let marshal_int2 f _ = function
  | GtkArgv.INT n :: GtkArgv.INT m ::_ -> f n m
  | _ -> invalid_arg "GtkSignal.marshal_int2"

let emit (obj : 'a obj) ~(sgn : ('a, 'b) t)
    ~(emitter : 'a obj -> name:string -> 'b) =
  emitter obj ~name:sgn.name
external emit_none : 'a obj -> name:string -> unit -> unit
    = "ml_gtk_signal_emit_none"
let emit_unit obj ~sgn = emit obj ~emitter:emit_none ~sgn ()
external emit_int : 'a obj -> name:string -> int -> unit
    = "ml_gtk_signal_emit_int"
let emit_int = emit ~emitter:emit_int
external emit_int2 : 'a obj -> name:string -> int -> int -> unit
    = "ml_gtk_signal_emit_int2"
let emit_int2 = emit ~emitter:emit_int2

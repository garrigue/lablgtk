(* $Id$ *)

open StdLabels
open Gobject

type id
type 'a marshaller = 'a -> Closure.argv -> data_get list -> unit
type ('a,'b) t =
 { name: string; classe: 'a; marshaller: 'b marshaller }

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
  'a obj -> name:string -> callback:g_closure -> after:bool -> id
  = "ml_g_signal_connect_closure"
external emit_stop_by_name : 'a obj -> name:string -> unit
  = "ml_g_signal_stop_emission_by_name"
let connect  ~(sgn : ('a, _) t) ~callback ?(after=false) (obj : 'a obj) =
  let callback argv =
    let old = push_callback () in
    let exn =
      try 
        (* Omit the referent object from the argument list *)
        let args = List.tl (Closure.get_args argv) in
        sgn.marshaller callback argv args;
        None
      with exn -> Some exn
    in
    if pop_callback old then emit_stop_by_name obj ~name:sgn.name;
    Gaux.may ~f:raise exn
  in
  connect_by_name obj ~name:sgn.name ~callback:(Closure.create callback) ~after
external handler_block : 'a obj -> id -> unit
  = "ml_g_signal_handler_block"
external handler_unblock : 'a obj -> id -> unit
  = "ml_g_signal_handler_unblock"
external disconnect : 'a obj -> id -> unit
  = "ml_g_signal_handler_disconnect"
external is_connected : 'a obj -> id -> bool
  = "ml_g_signal_handler_is_connected"

let marshal_unit f _ _ = f ()
let marshal_int f _ = function
  | `INT n :: _ -> f n
  | _ -> invalid_arg "GtkSignal.marshal_int"
let marshal_string f _ = function
  | `STRING (Some s) :: _ -> f s
  | _ -> invalid_arg "GtkSignal.marshal_string"

let marshal1 conv1 name f argv _ =
  let arg1 =
    try Data.of_value conv1 (Closure.nth argv 1)
    with _ -> failwith ("GtkSignal.marhsal1 : " ^ name)
  in f arg1

let marshal2 conv1 conv2 name f argv _ =
  let get conv pos = Data.of_value conv (Closure.nth argv ~pos) in
  let arg1, arg2 =
    try get conv1 1, get conv2 2
    with _ -> failwith ("GtkSignal.marhsal2 : " ^ name)
  in f arg1 arg2

let marshal3 conv1 conv2 conv3 name f argv _ =
  let get conv pos = Data.of_value conv (Closure.nth argv ~pos) in
  let arg1, arg2, arg3 =
    try get conv1 1, get conv2 2, get conv3 3
    with _ -> failwith ("GtkSignal.marhsal3 : " ^ name)
  in f arg1 arg2 arg3

let marshal4 conv1 conv2 conv3 conv4 name f argv _ =
  let get conv pos = Data.of_value conv (Closure.nth argv ~pos) in
  let arg1, arg2, arg3, arg4 =
    try
      get conv1 1, get conv2 2, get conv3 3, get conv4 4
    with _ -> failwith ("GtkSignal.marhsal4 : " ^ name)
  in f arg1 arg2 arg3 arg4

let set_result conv argv res =
  Closure.set_result argv (conv.inj res)

let marshal0_ret ~ret f argv l =
  set_result ret argv (f ())

let marshal1_ret ~ret conv1 name f argv l =
  set_result ret argv (marshal1 conv1 name f argv l)

let marshal2_ret ~ret conv1 conv2 name f argv l =
  set_result ret argv (marshal2 conv1 conv2 name f argv l)

let marshal3_ret ~ret conv1 conv2 conv3 name f argv l =
  set_result ret argv (marshal3 conv1 conv2 conv3 name f argv l)

let marshal4_ret ~ret conv1 conv2 conv3 conv4 name f argv l =
  set_result ret argv (marshal4 conv1 conv2 conv3 conv4 name f argv l)

external emit_by_name :
  'a obj -> name:string -> params:'b data_set array -> g_value
  = "ml_g_signal_emit_by_name"
let emit_by_name_unit obj ~name ~params =
  ignore (emit_by_name obj ~name ~params)

let emit (obj : 'a obj) ~(sgn : ('a, 'b) t)
    ~(emitter : cont:(_ data_set array -> 'c) -> 'b) ~(conv : g_value -> 'c) =
  emitter ~cont:
    (fun params -> conv(emit_by_name obj ~name:sgn.name ~params))
let emit_unit obj =
  emit obj ~emitter:(fun ~cont () -> cont [||]) ~conv:ignore ()
let emit_int =
  emit ~emitter:(fun ~cont n -> cont [|`INT n|]) ~conv:ignore

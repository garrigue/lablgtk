(* $Id$ *)

open Misc
open Gtk

module Arg = struct
  type t
  external shift : t -> pos:int -> t = "ml_gtk_arg_shift"
  external get_type : t -> gtktype = "ml_gtk_arg_get_type"
  (* Safely get an argument *)
  external get_char : t -> char = "ml_gtk_arg_get_char"
  external get_bool : t -> bool = "ml_gtk_arg_get_bool"
  external get_int : t -> int = "ml_gtk_arg_get_int"
  external get_float : t -> float = "ml_gtk_arg_get_float"
  external get_string : t -> string = "ml_gtk_arg_get_string"
  external get_pointer : t -> pointer = "ml_gtk_arg_get_pointer"
  external get_object : t -> unit obj = "ml_gtk_arg_get_object"
  (* Safely set a result
     Beware: this is not the opposite of get, arguments and results
     are two different ways to use GtkArg. *)
  external set_char : t -> char -> unit = "ml_gtk_arg_set_char"
  external set_bool : t -> bool -> unit = "ml_gtk_arg_set_bool"
  external set_int : t -> int -> unit = "ml_gtk_arg_set_int"
  external set_float : t -> float -> unit = "ml_gtk_arg_set_float"
  external set_string : t -> string -> unit = "ml_gtk_arg_set_string"
  external set_pointer : t -> pointer -> unit = "ml_gtk_arg_set_pointer"
  external set_object : t -> unit obj -> unit = "ml_gtk_arg_set_object"
end

module Argv = struct
  open Arg
  type raw_obj
  type t = { referent: raw_obj; nargs: int; args: Arg.t }
  let nth arg :pos =
    if pos < 0 || pos >= arg.nargs then invalid_arg "Argv.nth";
    shift arg.args :pos
  let result arg =
    if arg.nargs < 0 then invalid_arg "Argv.result";
    shift arg.args pos:arg.nargs
  external wrap_object : raw_obj -> unit obj = "Val_GtkObject"
  let referent arg =
    if arg.referent == Obj.magic (-1) then invalid_arg "Argv.referent";
    wrap_object arg.referent
  let get_result_type arg = get_type (result arg)
  let get_type arg :pos = get_type (nth arg :pos)
  let get_char arg :pos = get_char (nth arg :pos)
  let get_bool arg :pos = get_bool (nth arg :pos)
  let get_int arg :pos = get_int (nth arg :pos)
  let get_float arg :pos = get_float (nth arg :pos)
  let get_string arg :pos = get_string (nth arg :pos)
  let get_pointer arg :pos = get_pointer (nth arg :pos)
  let get_object arg :pos = get_object (nth arg :pos)
  let set_result_char arg = set_char (result arg)
  let set_result_bool arg = set_bool (result arg)
  let set_result_int arg = set_int (result arg)
  let set_result_float arg = set_float (result arg)
  let set_result_string arg = set_string (result arg)
  let set_result_pointer arg = set_pointer (result arg)
  let set_result_object arg = set_object (result arg)
end

type id
type ('a,'b) t = { name: string; marshaller: 'b -> Argv.t -> unit }
external connect :
    'a obj -> name:string -> callback:(Argv.t -> unit) -> after:bool -> id
    = "ml_gtk_signal_connect"
let connect : 'a obj -> sig:('a, _) t -> _ =
  fun obj sig:signal :callback ?:after [< false >] ->
    connect obj name:signal.name callback:(signal.marshaller callback) :after
external disconnect : 'a obj -> id -> unit = "ml_gtk_signal_disconnect"
external emit : 'a obj -> name:string -> unit = "ml_gtk_signal_emit_by_name"
let emit (obj : 'a obj) sig:(sgn : ('a,unit->unit) t) =
  emit obj name:sgn.name

module Marshal = struct
  let unit f _ = f ()
  let int f argv = f (Argv.get_int argv pos:0)
  let event f argv =
    let p = Argv.get_pointer argv pos:0 in
    let ev = Gdk.Event.unsafe_copy p in
    Argv.set_result_bool argv (f ev)
end

module Event = struct
  let any : ([> widget], Gdk.Tags.event_type Gdk.event -> bool) t =
    { name = "event"; marshaller = Marshal.event }
  let button_press : ([> widget], Gdk.Event.Button.t -> bool) t =
    { name = "button_press_event"; marshaller = Marshal.event }
  let button_release : ([> widget], Gdk.Event.Button.t -> bool) t =
    { name = "button_release_event"; marshaller = Marshal.event }
  let motion_notify : ([> widget], Gdk.Event.Motion.t -> bool) t =
    { name = "motion_notify_event"; marshaller = Marshal.event }
  let delete : ([> widget], [DELETE] Gdk.event -> bool) t =
    { name = "delete_event"; marshaller = Marshal.event }
  let destroy : ([> widget], [DESTROY] Gdk.event -> bool) t =
    { name = "destroy_event"; marshaller = Marshal.event }
  let expose : ([> widget], Gdk.Event.Expose.t -> bool) t =
    { name = "expose_event"; marshaller = Marshal.event }
  let key_press : ([> widget], Gdk.Event.Key.t -> bool) t =
    { name = "key_press_event"; marshaller = Marshal.event }
  let key_release : ([> widget], Gdk.Event.Key.t -> bool) t =
    { name = "key_release_event"; marshaller = Marshal.event }
  let enter_notify : ([> widget], Gdk.Event.Crossing.t -> bool) t =
    { name = "enter_notify_event"; marshaller = Marshal.event }
  let leave_notify : ([> widget], Gdk.Event.Crossing.t -> bool) t =
    { name = "leave_notify_event"; marshaller = Marshal.event }
  let configure : ([> widget], Gdk.Event.Configure.t -> bool) t =
    { name = "configure_event"; marshaller = Marshal.event }
  let focus_in : ([> widget], Gdk.Event.Focus.t -> bool) t =
    { name = "focus_in_event"; marshaller = Marshal.event }
  let focus_out : ([> widget], Gdk.Event.Focus.t -> bool) t =
    { name = "focus_out_event"; marshaller = Marshal.event }
  let map : ([> widget], [MAP] Gdk.event -> bool) t =
    { name = "map_event"; marshaller = Marshal.event }
  let unmap : ([> widget], [UNMAP] Gdk.event -> bool) t =
    { name = "unmap_event"; marshaller = Marshal.event }
  let property_notify : ([> widget], Gdk.Event.Property.t -> bool) t =
    { name = "property_notify_event"; marshaller = Marshal.event }
  let selection_clear : ([> widget], Gdk.Event.Selection.t -> bool) t =
    { name = "selection_clear_event"; marshaller = Marshal.event }
  let selection_request : ([> widget], Gdk.Event.Selection.t -> bool) t =
    { name = "selection_request_event"; marshaller = Marshal.event }
  let selection_notify : ([> widget], Gdk.Event.Selection.t -> bool) t =
    { name = "selection_notify_event"; marshaller = Marshal.event }
  let proximity_in : ([> widget], Gdk.Event.Proximity.t -> bool) t =
    { name = "proximity_in_event"; marshaller = Marshal.event }
  let proximity_out : ([> widget], Gdk.Event.Proximity.t -> bool) t =
    { name = "proximity_out_event"; marshaller = Marshal.event }
end

module Timeout = struct
  type id
  external add : int -> callback:(Argv.t -> unit) -> id = "ml_gtk_timeout_add"
  let add inter :callback =
    add inter callback:(fun arg -> Argv.set_result_bool arg (callback ()))
  external remove : id -> unit = "ml_gtk_timeout_remove"
end

(* $Id$ *)

type -'a obj
type g_type
type g_class
type g_value
type g_closure

type basic =
  [ `CHAR of char
  | `BOOL of bool
  | `INT of int
  | `FLOAT of float
  | `STRING of string option
  | `POINTER of Gpointer.boxed option
  | `INT64 of int64 ]

type data_get = [ basic | `NONE | `OBJECT of unit obj option ]
type 'a data_set =
 [ basic | `OBJECT of 'a obj option | `INT32 of int32 | `LONG of nativeint ]

module Tags = struct
  type fundamental_type =
    [ `INVALID | `NONE | `INTERFACE
    | `CHAR | `UCHAR | `BOOLEAN
    | `INT  | `UINT  | `LONG  | `ULONG  | `INT64  | `UINT64
    | `ENUM | `FLAGS
    | `FLOAT  | `DOUBLE
    | `STRING | `POINTER  | `BOXED  | `PARAM
    | `OBJECT ]
end
open Tags

module Type = struct
  external name : g_type -> string = "ml_g_type_name"
  external from_name : string -> g_type = "ml_g_type_from_name"
  external parent : g_type -> g_type = "ml_g_type_parent"
  external depth : g_type -> int = "ml_g_type_depth"
  external is_a : g_type -> g_type -> bool = "ml_g_type_is_a"
  external fundamental : g_type -> fundamental_type
      = "ml_G_TYPE_FUNDAMENTAL"
  external of_fundamental : fundamental_type -> g_type
      = "ml_Fundamental_type_val"
end

module Value = struct
  external create : g_type -> g_value = "ml_g_value_new"
      (* create a g_value owned by ML *)
  external release : g_value -> unit = "ml_g_value_release"
      (* invalidate a g_value, releasing the data if owned by ML *)
  external get_type : g_value -> g_type = "ml_G_VALUE_TYPE"
  external copy : g_value -> g_value -> unit = "ml_g_value_copy"
  external reset : g_value -> unit = "ml_g_value_reset"
  external get : g_value -> data_get = "ml_g_value_get"
  external set : g_value -> 'a data_set -> unit = "ml_g_value_set_variant"
  external get_pointer : g_value -> Gpointer.boxed = "ml_g_value_get_pointer"
  external get_nativeint : g_value -> nativeint = "ml_g_value_get_nativeint"
end

module Closure = struct
  type args
  type argv = { result: g_value; nargs: int; args: args }

  external create : (argv -> unit) -> g_closure = "ml_g_closure_new"

  external _nth : args -> pos:int -> g_value = "ml_g_value_shift"
  let nth arg ~pos =
    if pos < 0 || pos >= arg.nargs then invalid_arg "Gobject.Closure.nth";
    _nth arg.args ~pos
  let result argv = argv.result
  let get_result_type arg = Value.get_type (result arg)
  let get_type arg ~pos = Value.get_type (nth arg ~pos)
  let get arg ~pos = Value.get (nth arg ~pos)
  let set_result arg = Value.set (result arg)
  let get_args arg =
    let rec loop args ~pos =
      if pos < 0 then args
      else loop (get arg ~pos :: args) ~pos:(pos-1)
    in loop [] ~pos:(arg.nargs - 1)

  let get_pointer arg ~pos = Value.get_pointer (nth arg ~pos)
  let get_nativeint arg ~pos = Value.get_nativeint (nth arg ~pos)
end

external get_type : 'a obj -> g_type = "ml_G_TYPE_FROM_INSTANCE"
let is_a obj name =
  Type.is_a (get_type obj) (Type.from_name name)

exception Cannot_cast of string * string
external unsafe_cast : 'a obj -> 'b obj = "%identity"
let try_cast w name =
  if is_a w name then unsafe_cast w
  else raise (Cannot_cast(Type.name(get_type w), name))

let get_id (obj : 'a obj) : int = (snd (Obj.magic obj) lor 0)

external freeze_notify : 'a obj -> unit = "ml_g_object_freeze_notify"
external thaw_notify : 'a obj -> unit = "ml_g_object_thaw_notify"

external set_property : 'a obj -> string -> g_value -> unit 
  = "ml_g_object_set_property"

(* $Id$ *)

open Gaux

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

type fundamental_type =
  [ `INVALID | `NONE | `INTERFACE
  | `CHAR | `UCHAR | `BOOLEAN
  | `INT  | `UINT  | `LONG  | `ULONG  | `INT64  | `UINT64
  | `ENUM | `FLAGS
  | `FLOAT  | `DOUBLE
  | `STRING | `POINTER  | `BOXED  | `PARAM
  | `OBJECT ]

module Type = struct
  external init : unit -> unit = "ml_g_type_init"
  let () = init ()
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
  let get_int32 arg ~pos = Nativeint.to_int32 (get_nativeint arg ~pos)
end

external get_type : 'a obj -> g_type = "ml_G_TYPE_FROM_INSTANCE"
let is_a obj name =
  Type.is_a (get_type obj) (Type.from_name name)

exception Cannot_cast of string * string
external unsafe_cast : 'a obj -> 'b obj = "%identity"
let try_cast w name =
  if is_a w name then unsafe_cast w
  else raise (Cannot_cast(Type.name(get_type w), name))

external coerce : 'a -> [`base] obj = "%identity"
  (* [coerce] is safe *)

let get_oid (obj : 'a obj) : int = (snd (Obj.magic obj) lor 0)

module Data = struct
  type kind =
    [ `BOOLEAN
    | `CHAR
    | `UCHAR
    | `INT
    | `UINT
    | `LONG
    | `ULONG
    | `INT64
    | `UINT64
    | `ENUM
    | `FLAGS
    | `FLOAT
    | `DOUBLE
    | `STRING
    | `POINTER
    | `BOXED
    | `OBJECT ]

  type 'a conv =
      { kind: kind;
        proj: (data_get -> 'a);
        inj: ('a -> unit data_set) }
  let boolean =
    { kind = `BOOLEAN;
      proj = (function `BOOL b -> b | _ -> failwith "Gobject.get_bool");
      inj = (fun b -> `BOOL b) }
  let char =
    { kind = `CHAR;
      proj = (function `CHAR c -> c | _ -> failwith "Gobject.get_char");
      inj = (fun c -> `CHAR c) }
  let uchar = {char with kind = `UCHAR}
  let int =
    { kind = `INT;
      proj = (function `INT c -> c | _ -> failwith "Gobject.get_int");
      inj = (fun c -> `INT c) }
  let uint = {int with kind = `UINT}
  let long = {int with kind = `LONG}
  let ulong = {int with kind = `ULONG}
  let enum = {int with kind = `ENUM}
  let flags = {int with kind = `FLAGS}
  let int64 =
    { kind = `INT64;
      proj = (function `INT64 c -> c | _ -> failwith "Gobject.get_int64");
      inj = (fun c -> `INT64 c) }
  let uint64 = {int64 with kind = `UINT64}
  let float =
    { kind = `FLOAT;
      proj = (function `FLOAT c -> c | _ -> failwith "Gobject.get_float");
      inj = (fun c -> `FLOAT c) }
  let double = {float with kind = `DOUBLE}
  let string =
    { kind = `STRING;
      proj = (function `STRING (Some s) -> s | `STRING None -> ""
             | _ -> failwith "Gobject.get_string");
      inj = (fun s -> `STRING (Some s)) }
  let string_option =
    { kind = `STRING;
      proj = (function `STRING c -> c | _ -> failwith "Gobject.get_string");
      inj = (fun c -> `STRING c) }
  let pointer =
    { kind = `POINTER;
      proj = (function `POINTER c -> c | _ -> failwith "Gobject.get_pointer");
      inj = (fun c -> `POINTER c) }
  let boxed = {pointer with kind = `BOXED}
  let gobject =
    { kind = `OBJECT;
      proj = (function `OBJECT c -> may_map ~f:unsafe_cast c
             | _ -> failwith "Gobject.get_object");
      inj = (fun c -> `OBJECT (may_map ~f:unsafe_cast c)) }

  let of_value kind v =
    kind.proj (Value.get v)
  let to_value kind x =
    let v =
      Value.create (Type.of_fundamental (kind.kind :> fundamental_type)) in
    Value.set v (kind.inj x);
  v
end

type ('a,'b) property = { name: string; classe: 'a; conv: 'b Data.conv }

module Property = struct
  external freeze_notify : 'a obj -> unit = "ml_g_object_freeze_notify"
  external thaw_notify : 'a obj -> unit = "ml_g_object_thaw_notify"
  external notify : 'a obj -> string -> unit = "ml_g_object_notify"
  external set_property : 'a obj -> string -> g_value -> unit 
    = "ml_g_object_set_property"
  external get_property : 'a obj -> string -> g_value -> unit
    = "ml_g_object_get_property"
  external get_property_type : 'a obj -> string -> g_type
    = "ml_g_object_get_property_type"
  let set_dyn obj prop data =
    let v = Value.create (get_property_type obj prop) in
    Value.set v data;
    set_property obj prop v
  let get_dyn obj prop =
    let v = Value.create (get_property_type obj prop) in
    get_property obj prop v;
    Value.get v
  let set (obj : 'a obj) (prop : ('a,_) property) x =
    set_dyn obj prop.name (prop.conv.Data.inj x)
  let get (obj : 'a obj) (prop : ('a,_) property) =
    prop.conv.Data.proj (get_dyn obj prop.name)
  let get_some obj prop =
    match get obj prop with Some x -> x
    | None -> failwith ("Gobject.Property.get_some: " ^ prop.name)
end

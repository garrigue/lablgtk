(* $Id$ *)

(* marked pointers *)
type 'a optaddr

let optaddr : 'a option -> 'a optaddr =
  function
      None -> Obj.magic 0
    | Some x -> Obj.magic x

(* naked pointers *)
type optstring

external get_null : unit -> optstring = "ml_get_null"
let raw_null = get_null ()

let optstring : string option -> optstring =
  function
      None -> raw_null
    | Some x -> Obj.magic x

(* boxed pointers *)
type boxed
let boxed_null : boxed = Obj.magic (0, raw_null)

external peek_string : ?pos:int -> ?len:int -> boxed -> string
    = "ml_string_at_pointer"
external peek_int : boxed -> int
    = "ml_int_at_pointer"

type 'a optboxed

let optboxed : 'a option -> 'a optboxed =
  function
      None -> Obj.magic boxed_null
    | Some obj -> Obj.magic obj

let may_box ~f obj : 'a optboxed =
  match obj with
    None -> Obj.magic boxed_null
  | Some obj -> Obj.magic (f obj : 'a)

(* Variant tables *)

type 'a variant_table constraint 'a = [> ]

external decode_variant : 'a variant_table -> int -> 'a
  = "ml_ml_lookup_from_c"
external encode_variant : 'a variant_table -> 'a -> int
  = "ml_ml_lookup_to_c"

(* Exceptions *)

exception Null
let _ =  Callback.register_exception "null_pointer" Null

(* Stable pointer *)
type 'a stable
external stable_copy : 'a -> 'a stable = "ml_stable_copy"

(* Region pointers *)

type region = { data: Obj.t; path: int array; offset:int; length: int }

let length reg = reg.length

let unsafe_create_region ~path ~get_length data =
  { data = Obj.repr data; path = path; offset = 0; length = get_length data }

let sub ?(pos=0) ?len reg =
  let len = match len with Some x -> x | None -> reg.length - pos in
  if pos < 0 || pos > reg.length || pos + len > reg.length then
    invalid_arg "Gpointer.sub";
  { reg with offset = reg.offset + pos; length = len }

external unsafe_get_byte : region -> pos:int -> int
    = "ml_gpointer_get_char"
external unsafe_set_byte : region -> pos:int -> int -> unit
    = "ml_gpointer_set_char"
external unsafe_blit : src:region -> dst:region -> unit
    ="ml_gpointer_blit"

(* handle with care, if allocation not static *)
external get_addr : region -> nativeint
    = "ml_gpointer_get_addr"

let get_byte reg ~pos =
  if pos >= reg.length then invalid_arg "Gpointer.get_char";
  unsafe_get_byte reg ~pos

let set_byte reg ~pos ch =
  if pos >= reg.length then invalid_arg "Gpointer.set_char";
  unsafe_set_byte reg ~pos ch

let blit ~src ~dst =
  if src.length <> dst.length then invalid_arg "Gpointer.blit";
  unsafe_blit ~src ~dst

(* Making a region from a string is easy *)
let region_of_string =
  unsafe_create_region ~path:[||] ~get_length:String.length

let string_of_region reg =
  let s = String.create reg.length in
  let reg' = region_of_string s in
  unsafe_blit reg reg';
  s

(* Access bigarrays breaking the abstraction... dirty *)
type 'a bigarray = (int, Bigarray.int8_unsigned_elt, 'a) Bigarray.Array1.t
let bigarray_size (arr : 'a bigarray) =
  let size =
    { data = Obj.repr arr; path = [|1+4|]; offset = 0; length = 0 } in
  Nativeint.to_int (get_addr size)
let region_of_bigarray arr =
  unsafe_create_region ~path:[|1|] ~get_length:bigarray_size arr

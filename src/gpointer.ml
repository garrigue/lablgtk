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

type 'a optboxed

let optboxed : 'a option -> 'a optboxed =
  function
      None -> Obj.magic boxed_null
    | Some obj -> Obj.magic obj

let may_box ~f obj : 'a optboxed =
  match obj with
    None -> Obj.magic boxed_null
  | Some obj -> Obj.magic (f obj : 'a)

(* Exceptions *)

exception Null
let _ =  Callback.register_exception "null_pointer" Null

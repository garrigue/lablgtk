(* $Id$ *)

let push x on:l = l := x :: !l
(*
let pop l =
  match !l with [] -> invalid_arg "Misc.pop"
  | a :: l' ->  l := l'; a
*)

let may fun:f x =
  match x with None -> ()
  | Some x -> let _ = f x in ()

let may_map fun:f x =
  match x with None -> None
  | Some x -> Some (f x)

let default x =
  function None -> x | Some y -> y

let may_default f x =
  function for:None -> f x | for:Some y -> y

(* marked pointers *)
type 'a optaddr

let optaddr : 'a option -> 'a optaddr =
  function
      None -> Obj.magic 0
    | Some x -> Obj.magic x

(* naked pointers *)
type optstring

external get_null : unit -> optstring = "ml_get_null"
let null = get_null ()

let optstring : string option -> optstring =
  function
      None -> null
    | Some x -> Obj.magic x

(* boxed pointers *)
type 'a optboxed

let optboxed : 'a option -> 'a optboxed =
  function
      None -> Obj.magic (0,null)
    | Some obj -> Obj.magic obj

type pointer

let null_cont _ = ()

let identity x = x

let kill x y = x

(* Exceptions *)

exception Null_pointer
let _ =  Callback.register_exception "null_pointer" Null_pointer

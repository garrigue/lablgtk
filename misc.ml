(* $Id$ *)

let push x on:l = l := x :: !l

let may fun:f x =
  match x with None -> ()
  | Some x -> let _ = f x in ()

let default x =
  function None -> x | Some y -> y

let may_default f x =
  function for:None -> f x | for:Some y -> y

type 'a optpointer

external get_null : unit -> Obj.t = "ml_get_null"
let null = get_null ()

let optpointer : 'a option -> 'a optpointer =
  function
      None -> Obj.obj null
    | Some x -> Obj.magic x

type pointer

(* $Id$ *)

let push x on:l = l := x :: !l

let may fun:f x =
  match x with None -> None
  | Some x -> Some (f x)

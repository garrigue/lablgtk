(* $Id$ *)

let push x on:l = l := x :: !l

let may fun:f x =
  match x with None -> ()
  | Some x -> let _ = f x in ()

let default x =
  function None -> x | Some y -> y

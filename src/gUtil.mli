(* $Id$ *)

open GObj

class ['a] memo : unit ->
  object
    constraint 'a = #gtkobj
    val tbl : (int, 'a) Hashtbl.t
    method add : 'a -> unit
    method find : #gtkobj -> 'a
    method remove : #gtkobj -> unit
  end

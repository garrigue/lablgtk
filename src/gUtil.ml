(* $Id$ *)

open Misc

class packing packing =
  object (self)
    initializer
      may packing fun:(fun f -> (f self : unit))
  end

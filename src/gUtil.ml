(* $Id$ *)

open Misc

class packing packing =
  object (self)
    initializer
      may packing fun:(fun f -> (f self : unit))
  end

let pack_return :packing self =
  may packing fun:(fun f -> (f self : unit))

(* $Id$ *)

open GObj

class ['a] memo () = object
  constraint 'a = #gtkobj
  val tbl = Hashtbl.create size:7
  method add (obj : 'a) =
    Hashtbl.add tbl key:obj#get_id data:obj
  method find : 'b. (#gtkobj as 'b) -> 'a =
    fun obj -> Hashtbl.find tbl key:obj#get_id
  method remove : 'c. (#gtkobj as 'c) -> unit =
    fun obj -> Hashtbl.remove tbl key:obj#get_id
end

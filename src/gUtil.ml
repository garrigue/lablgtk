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

let signal_id = ref 0

let next_id () : GtkSignal.id =
  decr signal_id; Obj.magic (!signal_id : int)

class ['a] signal obj = object
  val obj = obj
  val mutable callbacks : (GtkSignal.id * ('a -> unit)) list = []
  method connect :callback ?:after [< false >] =
    let id = next_id () in
    callbacks <-
      if after then callbacks @ [id,callback] else (id,callback)::callbacks;
    id
  method call arg =
    List.iter callbacks fun:(fun (_,f) -> f arg)
  method disconnect id =
    List.mem_assoc id in:callbacks &&
    (callbacks <- List.filter callbacks pred:(fun (id',_) -> id = id'); true)
    
  initializer
    GtkSignal.connect obj sig:GtkBase.Object.Signals.destroy
      callback:(fun () -> callbacks <- []);
    ()
end

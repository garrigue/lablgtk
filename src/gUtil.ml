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

let next_callback_id () : GtkSignal.id =
  decr signal_id; Obj.magic (!signal_id : int)

class type disconnector = object
  method disconnect : GtkSignal.id -> bool
  method reset : unit -> unit
end

let disconnectors : (int, disconnector list) Hashtbl.t =
  Hashtbl.create size:7

class ['a] signal obj = object (self)
  val mutable callbacks : (GtkSignal.id * ('a -> unit)) list = []
  val mutable registered = false
  method private register () =
    registered <- true;
    let key = GtkBase.Object.get_id obj in
    try
      let l = Hashtbl.find disconnectors :key in
      Hashtbl.remove disconnectors :key;
      Hashtbl.add disconnectors :key data:((self :> disconnector)::l)
    with Not_found ->
      GtkSignal.connect obj sig:GtkBase.Object.Signals.destroy callback:
	begin fun () ->
	  List.iter (Hashtbl.find disconnectors :key) fun:(fun d -> d#reset());
	  Hashtbl.remove disconnectors :key
	end;
      Hashtbl.add disconnectors :key data:[(self :> disconnector)]
  method connect :callback ?:after [< false >] =
    if not registered then self#register ();
    let id = next_callback_id () in
    callbacks <-
      if after then callbacks @ [id,callback] else (id,callback)::callbacks;
    id
  method call arg =
    List.iter callbacks fun:(fun (_,f) -> f arg)
  method disconnect id =
    List.mem_assoc id in:callbacks &&
    (callbacks <- List.remove_assoc id in:callbacks; true)
  method reset () = callbacks <- []
end

class has_ml_signals obj = object
  method disconnect id =
    let key = GtkBase.Object.get_id obj in
    try
      let l = Hashtbl.find disconnectors :key in
      if List.exists l pred:(fun d -> d#disconnect id) then ()
      else raise Not_found
    with Not_found ->
      GtkSignal.disconnect obj id
end

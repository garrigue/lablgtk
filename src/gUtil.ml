(* $Id$ *)

open GObj

class ['a] memo () = object
  constraint 'a = #widget
  val tbl = Hashtbl.create 7
  method add (obj : 'a) =
    Hashtbl.add tbl ~key:obj#get_id ~data:obj
  method find (obj : widget) = Hashtbl.find tbl obj#get_id
  method remove (obj : widget) = Hashtbl.remove tbl obj#get_id
end

let signal_id = ref 0

let next_callback_id () : GtkSignal.id =
  decr signal_id; Obj.magic (!signal_id : int)

class type disconnector = object
  method disconnect : GtkSignal.id -> bool
  method reset : unit -> unit
end

let disconnectors : (int, disconnector list) Hashtbl.t =
  Hashtbl.create 7

class ['a] signal obj = object (self)
  val mutable callbacks : (GtkSignal.id * ('a -> unit)) list = []
  val mutable registered = false
  method private register () =
    registered <- true;
    let key = GtkBase.Object.get_id obj in
    try
      let l = Hashtbl.find disconnectors key in
      Hashtbl.remove disconnectors key;
      Hashtbl.add disconnectors ~key ~data:((self :> disconnector)::l)
    with Not_found ->
      GtkSignal.connect obj ~sgn:GtkBase.Object.Signals.destroy ~callback:
	begin fun () ->
	  List.iter (Hashtbl.find disconnectors key) ~f:(fun d -> d#reset());
	  Hashtbl.remove disconnectors key
	end;
      Hashtbl.add disconnectors ~key ~data:[(self :> disconnector)]
  method connect ~after ~callback =
    if not registered then self#register ();
    let id = next_callback_id () in
    callbacks <-
      if after then callbacks @ [id,callback] else (id,callback)::callbacks;
    id
  method call arg =
    List.iter callbacks ~f:(fun (_,f) -> f arg)
  method disconnect key =
    List.mem_assoc key callbacks &&
    (callbacks <- List.remove_assoc key callbacks; true)
  method reset () = callbacks <- []
end

class has_ml_signals obj = object
  method disconnect id =
    let key = GtkBase.Object.get_id obj in
    try
      let l = Hashtbl.find disconnectors key in
      if List.exists l ~f:(fun d -> d#disconnect id) then ()
      else raise Not_found
    with Not_found ->
      GtkSignal.disconnect obj id
end

class ['a] variable_signals obj
    ~(changed : 'a signal)~(accessed : unit signal)  ~(destroy : unit signal) =
object
  inherit has_ml_signals obj
  val obj = obj
  val after = false
  method after = {< after = true >}
  method changed = changed#connect ~after
  method accessed = accessed#connect ~after
  method destroy = destroy#connect ~after
end

class ['a] variable ~on:(w : #widget) x =
  let obj = w#as_widget in
object (self)
  val changed = new signal obj
  val accessed = new signal obj
  val destroy = new signal obj
  val obj = obj
  method connect = new variable_signals obj ~changed ~accessed ~destroy
  val mutable x : 'a = x
  method set y = x <- y; changed#call y
  method get = accessed#call (); x
  val mutable cbid = None
  method destroy () =
    match cbid with None -> ()
    | Some id ->
        cbid <- None;
        GtkSignal.disconnect obj id;
        destroy#call ()
  initializer
    cbid <- Some
        (GtkSignal.connect obj ~sgn:GtkBase.Object.Signals.destroy
           ~callback:self#destroy)
end

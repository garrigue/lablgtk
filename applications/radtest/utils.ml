open GObj

external test_modifier : Gdk.Tags.modifier -> int -> bool
    = "ml_test_GdkModifier_val"



(*********** some utility functions **************)
let rec list_remove pred:f = function
  | [] -> []
  | hd :: tl -> if f hd then tl else hd :: (list_remove pred:f tl)

let rec list_split pred:f = function
  | [] -> [], []
  | hd :: tl -> let g, d = list_split pred:f tl in
    if f hd then (hd :: g, d) else (g, hd :: d)

let list_pos ch in:l =
  let rec aux pos = function
    | [] -> raise Not_found
    | hd :: tl -> if hd = ch then pos else aux (pos+1) tl
  in aux 0 l

(* moves the pos element up; pos is >= 1;
   the first element is numbered 0 *)
let rec list_reorder_up :pos = function
    | hd1 :: hd2 :: tl when pos = 1 -> hd2 :: hd1 :: tl
    | hd :: tl when pos > 1 -> hd :: (list_reorder_up pos:(pos-1) tl)
    | _ -> failwith "list_reorder"

(* moves the pos element down; pos is < length of l - 1;
   the first element is numbered 0 *)
let rec list_reorder_down :pos = 
  list_reorder_up pos:(pos+1)

let rec change_property_name oldname newname = function
  | (n, p) :: tl when oldname = n -> (newname, p) :: tl
  | (n, p) :: tl -> (n, p) :: change_property_name oldname newname tl
  | [] -> failwith "change_property_name: name not found"

(********************* memo ***************************)

class ['a, 'd] memo () = object
  constraint 'a = #gtkobj
  val tbl = Hashtbl.create size:7
  method add (obj : 'a) data:(data : 'd) =
    Hashtbl.add tbl key:obj#get_id :data
  method find : 'b. (#gtkobj as 'b) -> 'd =
    fun obj -> Hashtbl.find tbl key:obj#get_id
  method remove : 'c. (#gtkobj as 'c) -> unit =
    fun obj -> Hashtbl.remove tbl key:obj#get_id
end




let signal_id = ref 0

let next_callback_id () : GtkSignal.id =
  decr signal_id; Obj.magic (!signal_id : int)

class ['a] signal = object
  val mutable callbacks : (GtkSignal.id * ('a -> unit)) list = []
  method connect :callback ?:after [< false >] =
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

class type disconnector =
  object
    method disconnect : GtkSignal.id -> bool
    method reset : unit -> unit
  end

class has_ml_signals = object
  val mutable disconnectors = []
  method private add_signal : 'a. 'a signal -> unit =
    fun sgn -> disconnectors <- (sgn :> disconnector) :: disconnectors

  method disconnect id =
    List.exists disconnectors pred:(fun d -> d#disconnect id)
end


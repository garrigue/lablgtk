open GObj
open GWindow
open GPack
open GMisc
open GButton

external test_modifier : Gdk.Tags.modifier -> int -> bool
    = "ml_test_GdkModifier_val"


(************* types *************)
(* used in the load_parser and for the selection *)

(* widget: class * name * property list
   where property = name * value_string *)
type yywidget = string * string * (string * string) list
type yywidget_tree = Node of yywidget * yywidget_tree list


(**************  formatter to string **************)
let to_string sref =
  let b = Buffer.create len:80 in
  new Oformat.c
    (Format.make_formatter
       out:(fun :buffer -> Buffer.add_substring b buffer)
       flush:(fun () -> sref := Buffer.contents b))

(*********** some utility functions **************)
let rec list_remove pred:f = function
  | [] -> []
  | hd :: tl -> if f hd then tl else hd :: (list_remove pred:f tl)


(* cut the list at the element elt; elt stays in tail;
   hd stays in reverse order *)
let cut_list :elt l =
  let rec aux h t = match t with
  | hd :: tl -> if hd = elt then h, t
	else aux (hd :: h) tl
  | [] -> failwith "cut_list"
  in aux [] l

(* split a list according to a predicate *)
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



(* contains the list of names of widgets in the current project;
   used to test if a name is already used;
   a name is added to the list when a tiwrapper is created (in
   the initilizer part of tiwrapper,
   it is removed when the widget is removed from his parent,
   in method remove_me of tiwrapper *)
let name_list = ref ([] : string list)

let split name =
  let l = String.length name in
  let i = ref (l-1) in
  while !i >= 0 && name.[!i] >= '0' && name.[!i] <= '9' do decr i done;
  if !i = l-1 then
    name, 0
  else
    (String.sub name pos:0 len:(!i+1)),
    int_of_string (String.sub name pos:(!i+1) len:(l- !i-1))

let change_name name =
  let n, i = split name in
  n ^ (string_of_int (i+1))

let test_unique name = not (List.mem name in: !name_list)

let message_name () =
  let w = new window show:true modal:true in
  let v = new vbox packing:w#add in
  let l = new label text:"name already in use\npick a new name"
      packing:v#add in
  let b = new button label:"OK" packing:v#add in
  b#connect#clicked callback:w#destroy;
  w#connect#destroy callback:GMain.Main.quit;
  GMain.Main.main ()


(******************  ML signals *****************)
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


(* $Id$ *)

open GObj

open Common

external test_modifier : Gdk.Tags.modifier -> int -> bool
    = "ml_test_GdkModifier_val"


(************* types *************)
(* used in the load_parser and for the selection *)

(* widget: class * name * property list
   where property = name * value_string *)
type yywidget = string * string * (string * string) list
type yywidget_tree = Node of yywidget * yywidget_tree list


(*********** some utility functions **************)
let rec list_remove ~f = function
  | [] -> []
  | hd :: tl -> if f hd then tl else hd :: (list_remove ~f tl)


(* cut the list at the element elt; elt stays in tail;
   hd stays in reverse order *)
let cut_list ~item l =
  let rec aux h t = match t with
  | hd :: tl -> if hd = item then h, t
	else aux (hd :: h) tl
  | [] -> failwith "cut_list"
  in aux [] l

let list_pos ~item l =
  let rec aux pos = function
    | [] -> raise Not_found
    | hd :: tl -> if hd = item then pos else aux (pos+1) tl
  in aux 0 l

(* moves the pos element up; pos is >= 1;
   the first element is numbered 0 *)
let rec list_reorder_up ~pos = function
    | hd1 :: hd2 :: tl when pos = 1 -> hd2 :: hd1 :: tl
    | hd :: tl when pos > 1 -> hd :: (list_reorder_up ~pos:(pos-1) tl)
    | _ -> failwith "list_reorder"

(* moves the pos element down; pos is < length of l - 1;
   the first element is numbered 0 *)
let rec list_reorder_down ~pos = 
  list_reorder_up ~pos:(pos+1)


let rec list_insert ~item l ~pos =
  if pos=0 then item :: l
  else
    match l with
    | [] ->  failwith "list_insert"
    | hd :: tl -> hd :: (list_insert ~item tl ~pos:(pos-1))


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
    (String.sub name ~pos:0 ~len:(!i+1)),
    int_of_string (String.sub name ~pos:(!i+1) ~len:(l- !i-1))

let test_unique name = not (List.mem name !name_list)

let make_new_name ?(index=1) base =
  let index = ref index in
  let name = ref (base ^ (string_of_int !index)) in
  while not (test_unique !name) do
    incr index;
    name := base ^ (string_of_int !index)
  done;
  !name

let change_name name =
  let base, index = split name in make_new_name base ~index

let message s =
  let w = GWindow.window ~show:true ~modal:true () in
  let v = GPack.vbox ~packing:w#add () in
  let l = GMisc.label ~text:s ~packing:v#add () in
  let b = GButton. button ~label:"OK" ~packing:v#add () in
  b#connect#clicked ~callback:w#destroy;
  w#connect#destroy ~callback:GMain.Main.quit;
  GMain.Main.main ()

let message_name () = message "name already in use\npick a new name"


(*************** file selection *****************)

let get_filename ~callback:set_filename ?(dir="") () =
  let res = ref false in
  let file_selection = GWindow.file_selection ~modal:true () in
  if dir <> "" then file_selection#set_filename dir;
  file_selection#show ();
  file_selection#ok_button#connect#clicked
    ~callback:(fun () -> set_filename file_selection#get_filename;
      res := true;
      file_selection#destroy ());
  file_selection#cancel_button#connect#clicked
    ~callback:file_selection#destroy;
  file_selection#connect#destroy ~callback:GMain.Main.quit;
  GMain.Main.main ();
  !res

(* returns the directory and the file name (without the extension) *)
let split_filename filename ~ext =
  let lext = String.length ext in
  let l = String.length filename in
  let filename, l =
    if (l > lext) && (String.sub filename ~pos:(l - lext) ~len:lext = ext)
    then (String.sub filename ~pos:0 ~len:(l-lext)), l-lext
    else filename, l in
  let i = 1 + (String.rindex filename '/') in
  String.sub filename ~pos:0 ~len:i,
  String.sub filename ~pos:i ~len:(l-i)


(******************  ML signals *****************)
let signal_id = ref 0

let next_callback_id () : GtkSignal.id =
  decr signal_id; Obj.magic (!signal_id : int)

class ['a] signal = object
  val mutable callbacks : (GtkSignal.id * ('a -> unit)) list = []
  method connect ~callback ~after =
    let id = next_callback_id () in
    callbacks <-
      if after then callbacks @ [id,callback] else (id,callback)::callbacks;
    id
  method call arg =
    List.iter callbacks ~f:(fun (_,f) -> f arg)
  method disconnect id =
    List.mem_assoc id callbacks &&
    (callbacks <- List.remove_assoc id callbacks; true)
  method reset () = callbacks <- []
end

class type disconnector =
  object
    method disconnect : GtkSignal.id -> bool
    method reset : unit -> unit
  end

class has_ml_signals = object
  val mutable disconnectors = []
  method private add_signal (sgn : 'a signal) =
    disconnectors <- (sgn :> disconnector) :: disconnectors

  method disconnect id =
    List.exists disconnectors ~f:(fun d -> d#disconnect id)
end


(****************** undo information ********************)

type undo_action =
  | Add of string * yywidget_tree * int
  | Remove of string
  | Property of prop * string
  | Add_window of yywidget_tree
  | Remove_window of string

let undo_info = ref ([] : undo_action list)
let next_undo_info = ref ([] : undo_action list)
let last_action_was_undo = ref false

let add_undo f =
  undo_info := f :: !undo_info;
  last_action_was_undo := false

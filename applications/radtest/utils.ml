
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

(* better: use a spin button *)
let get_a_number s default=
  let res = ref default in
  let w = GWindow.window ~show:true ~modal:true () in
  let v = GPack.vbox ~packing:w#add () in
  let l = GMisc.label ~text:s ~packing:v#add () in
  let e = GEdit.entry ~text:(string_of_int default) ~packing:v#add () in
  let b = GButton. button ~label:"OK" ~packing:v#add () in
  b#connect#clicked ~callback:(fun () ->
    begin try res := int_of_string e#text with Failure _ -> () end;
    w#destroy ());
  w#connect#destroy ~callback:GMain.Main.quit;
  GMain.Main.main ();
  !res


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


(**********************************************************)
let ftrue f = fun x -> f x; true


(**********************************************************)

let toolbar_child_prop kind =
  let rt = ref "" and rtt = ref "" and rptt = ref "" and ok = ref false in
  let w  = GWindow.window ~modal:true () in
  let v  = GPack.vbox ~packing:w#add () in
  let h1 = GPack.hbox ~packing:v#add () in
  let h2 = GPack.hbox ~packing:v#add () in
  let h3 = GPack.hbox ~packing:v#add () in
  let h4 = GPack.hbox ~packing:v#add () in
  let l1 = GMisc.label ~text:"text" ~packing:h1#add () in
  let e1 = GEdit.entry ~packing:h1#add () in
  let l2 = GMisc.label ~text:"tooltip_text" ~packing:h2#add () in
  let e2 = GEdit.entry ~packing:h2#add () in
  let l3 = GMisc.label ~text:"private_text" ~packing:h3#add () in
  let e3 = GEdit.entry ~packing:h3#add () in
  let b1 = GButton.button ~label:"OK" ~packing:h4#add () in
  let b2 = GButton.button ~label:"Cancel" ~packing:h4#add () in
  w#show ();
  b1#connect#clicked
    ~callback:(fun () -> rt := e1#text; rtt := e2#text;
      rptt := e3#text; ok := true;
      w#destroy ());
  b2#connect#clicked ~callback:w#destroy;
  w#connect#destroy ~callback:GMain.Main.quit;
  GMain.Main.main ();
  !ok, !rt, !rtt, !rptt



(**********************************************************)

let get5floats_from_string s =
  try
    let n1 = String.index s ' ' in
    let f1 = float_of_string (String.sub s ~pos:0 ~len:(n1-1)) in
    let n2 = String.index_from s (n1+1) ' ' in
    let f2 = float_of_string (String.sub s ~pos:(n1+1) ~len:(n2-1)) in
    let n3 = String.index_from s (n2+1) ' ' in
    let f3 = float_of_string (String.sub s ~pos:(n2+1) ~len:(n3-1)) in
    let n4 = String.index_from s (n3+1) ' ' in
    let f4 = float_of_string (String.sub s ~pos:(n3+1) ~len:(n4-1)) in
    let f5 = float_of_string (String.sub s ~pos:(n4+1) ~len:
				((String.length s) -1)) in
    f1, f2, f3, f4, f5
  with _ -> failwith "get5floats_of_string"



(**********************************************************)

exception Float_of_string
let my_float_of_string s =
  let l = String.length s in
  if l=0 then raise Float_of_string;
  let sign, d = match s.[0] with
  | '+' ->  1, 1
  | '-' -> -1, 1
  | _   ->  1, 0 in
  let m, p =
    let p = 
      try
	String.index s '.'
      with Not_found -> l in
    if p=d then 0, p
    else
      try int_of_string (String.sub s ~pos:d ~len:(p-d)), p
      with Failure "int_of_string" -> raise Float_of_string
  in
  if p=l then float_of_int m
  else begin
    let f = ref 0. and r = ref 0.1 in
    for i = p+1 to l-1 do
      let k = (int_of_char s.[i]) - 48 in
      if k > 9 || k < 0 then raise Float_of_string;
      f := !f +. (float_of_int k) *. !r;
      r := !r *. 0.1
    done;
    !f +. (float_of_int m)
  end

    
  

class entry_float obj ~init = let rv = ref init in
object
  inherit GEdit.entry obj as entry
  method value =
    try 
      let v = my_float_of_string entry#text in
      rv := v;
      v
    with Float_of_string ->
      let pop = GWindow.window ~title:"error" ~modal:true () in
      let vb = GPack.vbox ~packing:pop#add () in
      let l = GMisc.label ~text:"value must be a float" ~packing:vb#pack () in
      let b = GButton.button ~label:"OK" ~packing:vb#pack () in
      b#connect#clicked ~callback:pop#destroy;
      pop#connect#event#delete ~callback:(fun _ -> pop#destroy (); true);
      pop#connect#destroy ~callback:GtkMain.Main.quit;
      pop#show ();
      GtkMain.Main.main ();
      entry#set_text (string_of_float !rv);
      !rv
end


let set_editable ?editable ?(width = -2) ?(height = -2) w =
  Gaux.may editable ~f:(GtkEdit.Editable.set_editable w);
  if width <> -2 || height <> -2 then GtkBase.Widget.set_usize w ~width ~height


let entry_float ~init ?max_length ?visibility ?editable
    ?width ?height ?packing ?show () = 
  let w = GtkEdit.Entry.create ?max_length () in
  GtkEdit.Entry.set w ~text:(string_of_float init) ?visibility;
  set_editable w ?editable ?width ?height;
  pack_return (new entry_float w ~init) ~packing ~show

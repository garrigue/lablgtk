
open GObj
open GEdit
open GData
open GPack
open GMisc
open GWindow


class ['a] rval :init ?inits:inits [< "" >] :setfun ?:value_list [< [] >] = object
  val mutable value : 'a = init
  val mutable value_string : string = inits
  val value_list : (string * 'a) list = value_list
  method value = value
  method value_list = value_list
  method value_string = value_string
  method set : 'a -> n:string -> unit = fun v n:n -> 
    if value <> v then begin
      value <- v; 
      value_string <- n;
      setfun v
    end
end


type property =
  | Bool of bool rval
  | Int of int rval
  | Float of float rval
  | String of string rval
  | Shadow of Gtk.Tags.shadow_type rval
  | Policy of Gtk.Tags.policy_type rval


(* these functions return a string except int and float *)
let get_int_prop name in:l =
  match List.assoc name in:l with
  | Int rval -> rval#value
  | _ -> failwith "bug get_int_prop"

let get_float_prop name in:l =
  match List.assoc name in:l with
  | Float rval -> rval#value
  | _ -> failwith "bug get_float_prop"

let get_bool_prop name in:l =
  match List.assoc name in:l with
  | Bool rval -> rval#value
  | _ -> failwith "bug get_bool_prop"

let get_string_prop name in:l =
  match List.assoc name in:l with
  | String rval -> rval#value
  | _ -> failwith "bug get_string_prop"

let get_enum_prop name in:l =
  match List.assoc name in:l with
  | Bool rval -> rval#value_string
  | Shadow rval -> rval#value_string
  | Policy rval -> rval#value_string
  | _ -> failwith "bug get_enum_prop"


let string_of_int_prop name in:l =
  string_of_int (get_int_prop name in:l)

let string_of_float_prop name in:l =
  string_of_float (get_float_prop name in:l)

class type rwidget_base = object
  method name : string
  method proplist : (string * property) list
  method base : widget
end

class prop_enumtype l :callback ?:packing :value = object(self)
  inherit combo popdown_strings:(List.map fun:fst l) show:true
      ?:packing use_arrows_always:true

  val revl = List.map fun:(fun (a,b) -> (b,a)) l
  initializer
    self#entry#connect#changed callback:
      (fun _ ->
	callback (List.assoc self#entry#text in:l) n:self#entry#text);
    self#entry#set_editable false;
    self#entry#set_text (List.assoc value in:revl)
end


class prop_bool = prop_enumtype ["true", true; "false", false]

class prop_shadow =
  prop_enumtype ["NONE", `NONE; "IN", `IN; "OUT", `OUT;
		  "ETCHED_IN", `ETCHED_IN; "ETCHED_OUT", `ETCHED_OUT ]

class prop_policy =
  prop_enumtype ["ALWAYS", `ALWAYS; "AUTOMATIC", `AUTOMATIC ]

class prop_string :callback ?:packing :value = object(self)
  inherit entry text:value ?:packing show:true
  initializer
    self#connect#activate callback:(fun _ -> callback self#text n:"");
    ()
end

class spin_int ?:value [< 0 >] :lower :upper ?:step_incr [< 1. >]
    ?:page_incr [< 1. >] ?:packing :callback =
object(self)
  inherit spin_button rate:0.5 digits:0
      adjustment:(new adjustment value:(float_of_int value) :lower
		    :upper :step_incr :page_incr page_size:0.)
      show:true ?:packing
  initializer
    self#connect#activate callback:
      (fun _ -> callback self#value_as_int n:"");
    ()
end

class spin_float ?:value [< 0. >] :lower :upper ?:step_incr [< 1. >]
    ?:page_incr [< 1. >] ?:packing :callback =
object(self)
  inherit spin_button rate:0.5 digits:2
      adjustment:(new adjustment value:value :lower
		    :upper :step_incr :page_incr page_size:0.)
      show:true ?:packing
  initializer
    self#connect#activate callback:
      (fun _ -> callback self#value n:"");
    ()
end

let plist_affich list =
  let une_prop_affich prop = 
    let hbox = new box `HORIZONTAL show:true homogeneous:true in
    begin match prop with
    | name, Bool prop -> new label text:name show:true
	  packing:(hbox#pack fill:true);
	new prop_bool callback:prop#set packing:(hbox#pack fill:true)
	  value:prop#value;
	()
    | name, Int prop -> new label text:name show:true
	  packing:(hbox#pack fill:true);
	new spin_int lower:(-2.) upper:5000. callback:prop#set
	  packing:(hbox#pack fill:true) value:prop#value;
	()
    | name, Float prop -> new label text:name show:true
	  packing:(hbox#pack fill:true);
	let mini = List.assoc "min" in:prop#value_list
	and maxi = List.assoc "max" in:prop#value_list in
	new spin_float lower:mini upper:maxi
	  step_incr:((maxi-.mini)/.100.) callback:prop#set
	  packing:(hbox#pack fill:true) value:prop#value;
	()
    | name, String prop -> new label text:name show:true
	  packing:(hbox#pack fill:true);
	new prop_string  callback:prop#set
	  packing:(hbox#pack fill:true) value:prop#value;
	()
    | name, Shadow prop -> new label text:name show:true
	  packing:(hbox#pack fill:true);
	new prop_shadow  callback:prop#set
	  packing:(hbox#pack fill:true) value:prop#value;
	()
    | name, Policy prop -> new label text:name show:true
	  packing:(hbox#pack fill:true);
	new prop_policy  callback:prop#set
	  packing:(hbox#pack fill:true) value:prop#value;
	()
    end;
    hbox
  in let vbox = new box `VERTICAL show:true in
  List.iter fun:(fun (n, p) -> vbox#pack (une_prop_affich (n,p));
	new separator `HORIZONTAL show:true packing:vbox#pack; ()) list;
  vbox
;;



let propwin = new window show:true title:"properties"
let vbox = new box `VERTICAL show:true packing:propwin#add
let hbox = new box `HORIZONTAL show:true
    packing:(vbox#pack padding:5);;

new separator `HORIZONTAL packing:vbox#pack show:true;
new separator `HORIZONTAL packing:vbox#pack show:true;;

let cb = new combo popdown_strings:[] use_arrows_always:true
    packing:(hbox#pack expand:true fill:false);;
cb#entry#set_editable false;;

let vbox2 = plist_affich [];;
vbox#pack vbox2;;
let vboxref = ref vbox2
let last_sel = ref (None : rwidget_base option)
let rwidget_list = ref ([] : rwidget_base list)
let rname_prop_list = ref ([] : (string * (string * property) list) list);;
    

propwin#connect#event#focus_out callback:
    (fun _ -> begin match !last_sel with
    |	None -> ()
    |	Some sl -> sl#base#misc#set state:`NORMAL end;
      true);

propwin#connect#event#focus_in callback:
    (fun _ -> begin match !last_sel with
    |	None -> ()
    |	Some sl -> sl#base#misc#set state:`SELECTED end;
      true);
  
cb#entry#connect#changed callback:
    (fun _ ->
      let vb = plist_affich (List.assoc cb#entry#text in:!rname_prop_list) in
      vbox#remove !vboxref;
      vbox#pack vb;
      vboxref := vb;
      if cb#entry#misc#has_focus then begin
	match !last_sel with
	| None -> ()
	| Some sl -> sl#base#misc#set state:`NORMAL
      end;
      let n = cb#entry#text in
      let w = List.find pred:(fun x -> x#name = n) !rwidget_list in
      if cb#entry#misc#has_focus then w#base#misc#set state:`SELECTED;
      last_sel := Some w
	  );;

let property_add rw =
    rwidget_list := (rw :> rwidget_base) :: !rwidget_list;
    let nplist = List.map fun:(fun w -> (w#name, w#proplist)) !rwidget_list in
    rname_prop_list := nplist;
    cb#set_combo popdown_strings:(List.map fun:fst nplist)

let property_remove rw =
  let rec aux = function
    |	[] -> []
    |	hd :: tl -> if hd = (rw :> rwidget_base) then tl else hd :: (aux tl)
  in rwidget_list := aux !rwidget_list;
  let nplist = List.map fun:(fun w -> (w#name, w#proplist)) !rwidget_list in
  rname_prop_list := nplist;
  cb#set_combo popdown_strings:(List.map fun:fst nplist)

let property_update () =
  let nplist = List.map fun:(fun w -> (w#name, w#proplist)) !rwidget_list in
  rname_prop_list := nplist;
  cb#set_combo popdown_strings:(List.map fun:fst nplist)

let test_unique name = not (List.mem_assoc name in:!rname_prop_list)




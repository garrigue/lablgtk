
open GObj
open GEdit
open GData
open GPack
open GMisc
open GWindow

open Utils

class ['a] rval :init :inits :undo_fun :setfun ?:value_list [< [] >] :codename = object
  val mutable value : 'a = init
  val mutable value_string : string = inits
  val value_list : (string * 'a) list = value_list
(*  method codename = (codename : string)   the string used in the init code *)
  val codename : string = codename
  method value = value
  method value_list = value_list
  method value_string = value_string
  method set = fun value:v value_string:vs -> 
    if value <> v then begin
      undo_fun value_string;
      value <- v; 
      value_string <- vs;
      setfun v
    end
  method modified =
    if value <> init then Some (codename, value_string) else None
end


type property =
  | Int    of int rval
  | Float  of float rval
  | String of string rval
  | Bool   of bool rval
  | Shadow of Gtk.Tags.shadow_type rval
  | Policy of Gtk.Tags.policy_type rval

let prop_modified = function
  | Int    r -> r#modified
  | Float  r -> r#modified
  | String r -> r#modified
  | Bool   r -> r#modified
  | Shadow r -> r#modified
  | Policy r -> r#modified

let get_value_string = function
  | Int    r -> r#value_string
  | Float  r -> r#value_string
  | String r -> r#value_string
  | Bool   r -> r#value_string
  | Shadow r -> r#value_string
  | Policy r -> r#value_string

let bool_values = ["true", true; "false", false]

let shadow_type_values = ["NONE", `NONE; "IN", `IN; "OUT", `OUT;
		  "ETCHED_IN", `ETCHED_IN; "ETCHED_OUT", `ETCHED_OUT ]
let policy_type_values = ["ALWAYS", `ALWAYS; "AUTOMATIC", `AUTOMATIC ]

(* value_string is the string representation of the value *)
let change_value_in_prop :value_string = function
  | Int rval  -> rval#set value:(int_of_string value_string) :value_string
  | Float rval ->  rval#set value:(float_of_string value_string) :value_string
  | String rval ->
      rval#set value:value_string
	value_string:("\"" ^ String.escaped value_string ^ "\"")
  | Bool rval ->  rval#set :value_string
	value:(List.assoc value_string in:bool_values)
  | Shadow rval -> rval#set :value_string
	value:(List.assoc value_string in:shadow_type_values)
  | Policy rval -> rval#set :value_string
	value:(List.assoc value_string in:policy_type_values)

let rec set_property_in_list name value_string = function
  | (n, p) :: tl ->
      if name = n then change_value_in_prop p :value_string
      else  (set_property_in_list name value_string tl)
  | [] -> failwith ("set_property_in_list: property not found " ^ name)



(* these functions return a string except int and float *)
let get_int_prop name in:l =
  match List.assoc name in:l with
  | Int rval -> rval#value
  | _ -> failwith "bug get_int_prop"

let get_float_prop name in:l =
  match List.assoc name in:l with
  | Float rval -> rval#value
  | _ -> failwith "bug get_float_prop"

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


class type tiwidget_base = object
  method name : string
  method proplist : (string * property) list
(*  method base : widget *)
end

class prop_enumtype l :callback ?:packing :value = object(self)
  inherit combo popdown_strings:(List.map fun:fst l) show:true
      ?:packing use_arrows:`ALWAYS

  val revl = List.map fun:(fun (a,b) -> (b,a)) l
  initializer
    self#entry#connect#changed callback:
      (fun _ -> let text = self#entry#text in
	callback value:(List.assoc text in:l) value_string:text);
    self#entry#set_editable false;
    self#entry#set_text (List.assoc value in:revl)
end


class prop_bool = prop_enumtype bool_values
class prop_shadow = prop_enumtype shadow_type_values
class prop_policy = prop_enumtype policy_type_values

class prop_string :callback ?:packing :value = object(self)
  inherit entry text:value ?:packing show:true
  initializer
    self#connect#activate callback:
      (fun _ -> let text = self#text in
        callback value:text value_string:("\"" ^ String.escaped text ^ "\""));
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
      (fun _ -> let value = self#value_as_int in
        callback :value value_string:(string_of_int value));
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
      (fun _ -> let value = self#value in
	callback :value value_string:(string_of_float value));
    ()
end

let plist_affich list =
  let une_prop_affich prop = 
    let hbox = new hbox homogeneous:true in
    begin
      match prop with
      | name, Bool prop -> new label text:name
	    packing:(hbox#pack fill:true);
	  new prop_bool callback:prop#set packing:(hbox#pack fill:true)
	    value:prop#value;
	  ()
      | name, Int prop -> new label text:name
	    packing:(hbox#pack fill:true);
	  new spin_int lower:(-2.) upper:5000. callback:prop#set
	    packing:(hbox#pack fill:true) value:prop#value;
	  ()
      | name, Float prop -> new label text:name
	    packing:(hbox#pack fill:true);
	  let mini = List.assoc "min" in:prop#value_list
	  and maxi = List.assoc "max" in:prop#value_list in
	  new spin_float lower:mini upper:maxi
	    step_incr:((maxi-.mini)/.100.) callback:prop#set
	    packing:(hbox#pack fill:true) value:prop#value;
	  ()
      | name, String prop -> new label text:name
	    packing:(hbox#pack fill:true);
	  new prop_string  callback:prop#set
	    packing:(hbox#pack fill:true) value:prop#value;
	  ()
      | name, Shadow prop -> new label text:name
	    packing:(hbox#pack fill:true);
	  new prop_shadow  callback:prop#set
	    packing:(hbox#pack fill:true) value:prop#value;
	  ()
      | name, Policy prop -> new label text:name
	    packing:(hbox#pack fill:true);
	  new prop_policy  callback:prop#set
	    packing:(hbox#pack fill:true) value:prop#value;
	  ()
    end;
    hbox
  in let vbox = new vbox in
  List.iter
    fun:(fun (n, p) ->
      vbox#pack (une_prop_affich (n,p)) expand:false;
      new separator `HORIZONTAL packing:(vbox#pack expand:false);
      ())
    list;
  vbox
;;



let propwin = new window show:true title:"properties"
let vbox = new vbox packing:propwin#add

let vbox2 = plist_affich [];;
vbox#pack vbox2;;
let vboxref = ref vbox2
let affiched = ref ""

let affich_vb vb =
  vbox#remove !vboxref;
  vbox#pack vb;
  vboxref := vb

let prop_affich_pool = new Omap.c []

let prop_affich (w : #tiwidget_base) =
  let name = w#name in
  let vb = try
    prop_affich_pool#find key:name
  with Not_found ->
    let vb = plist_affich w#proplist in
    prop_affich_pool#add key:name data:vb;
    vb in
  affich_vb vb;
  affiched := name


let prop_add (w : #tiwidget_base) =
  let vb = plist_affich w#proplist in
  prop_affich_pool#add key:w#name data:vb


let prop_remove name =
  prop_affich_pool#remove key:name;
  if !affiched = name then begin
    affich_vb (plist_affich [])
  end

let prop_change_name oldname newname =
  let vb = prop_affich_pool#find key:oldname in
  prop_affich_pool#remove key:oldname;
  prop_affich_pool#add key:newname data:vb

let prop_update (w : #tiwidget_base) =
  let vb = plist_affich w#proplist in
  prop_affich_pool#remove key:w#name;
  prop_affich_pool#add key:w#name data:vb;
  if !affiched = w#name then affich_vb vb



  


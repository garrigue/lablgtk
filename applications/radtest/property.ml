(* $Id$ *)

open Gtk
open GObj
open GEdit
open GData
open GPack
open GMisc
open GWindow

open Utils

external id : 'a -> 'a = "%identity"

type range =
    String
  | Int
  | Float of float * float
  | Enum of string list

class virtual vprop :name :init :set =
  object (self)
    val mutable s : string = init
    val name : string = name
    method private virtual parse : string -> 'a
    method get = s
    method set s' =
      if s' <> s then begin
	let v = self#parse s' in
	(* undo s'; *)
	s <- s';
	set v
      end
    method modified = s <> init
    method name = name
    method code = s
    method virtual range : range
  end

class type prop =
  object
    method name : string
    method range : range
    method get : string
    method set : string -> unit
    method modified : bool
    method code : string	(* encoded value *)
  end

class prop_enum :values :name :init :set =
  object (self)
    inherit vprop :name :init :set
    method private parse s =
      try List.assoc s in:values
      with Not_found -> invalid_arg "Property.prop_enum#parse"
    method range = Enum (List.map fun:fst values)
  end

let bool_values =
  [ "true", true; "false", false ]

let shadow_type_values : (string * Tags.shadow_type) list =
  [ "NONE", `NONE; "IN", `IN; "OUT", `OUT;
    "ETCHED_IN", `ETCHED_IN; "ETCHED_OUT", `ETCHED_OUT ]

let policy_type_values : (string * Tags.policy_type) list =
  [ "ALWAYS", `ALWAYS; "AUTOMATIC", `AUTOMATIC ]

class prop_bool = prop_enum values:bool_values

class prop_variant :values :name :init :set : prop =
  object
    inherit prop_enum :values :name :init :set
    method code = "`" ^ s
  end

class prop_shadow = prop_enum values:shadow_type_values
class prop_policy = prop_enum values:policy_type_values

class prop_int :name :init :set : prop =
  object
    inherit vprop :name :init :set
    method private parse s =
      try int_of_string s with _ -> invalid_arg "Property.prop_int#parse"
    method range = Int
  end

class prop_float :name :init :min :max :set : prop =
  object
    inherit vprop :name :init :set
    method private parse s =
      try float_of_string s with _ -> invalid_arg "Property.prop_float#parse"
    method code =
      if String.contains s '.' || String.contains s 'e' then s else s ^ ".0"
    method range = Float(min,max)
  end

class prop_string :name :init :set : prop =
  object
    inherit vprop :name :init :set
    method private parse s = s
    method range = String
    method code = "\"" ^ String.escaped s ^ "\""
  end

class type tiwidget_base = object
  method name : string
  method proplist : (string * prop) list
(*  method base : widget *)
end

let prop_widget (prop : prop) =
  match prop#range with
    Enum l ->
      let w =
	new combo popdown_strings:l use_arrows:`ALWAYS
      in
      w#entry#connect#changed callback:(fun () -> prop#set w#entry#text);
      w#entry#set_editable false;
      w#entry#set_text prop#get;
      (w :> widget)
  | String ->
      let w = new entry text:prop#get in
      w#connect#activate callback:(fun () -> prop#set w#text);
      (w :> widget)
  | Int ->
      let adjustment =
	new adjustment value:(float_of_string prop#get)
	  lower:(-2.) upper:5000. step_incr:1. page_incr:10. page_size:0.
      in
      let w =
	new spin_button rate:0.5 digits:0 :adjustment in
      w#connect#activate
	callback:(fun () -> prop#set (string_of_int w#value_as_int));
      (w :> widget)
  | Float (lower, upper) ->
      let adjustment =
	new adjustment value:(float_of_string prop#get)
	  :lower :upper step_incr:((upper-.lower)/.100.)
	  page_incr:((upper-.lower)/.10.) page_size:0.
      in
      let w = new spin_button rate:0.5 digits:2 :adjustment in
      w#connect#activate
	callback:(fun () -> prop#set (string_of_float w#value));
      (w :> widget)

let prop_box list ?:packing ?:show =
  let vbox = new box `VERTICAL ?:packing ?:show in
  List.iter list fun:
    begin fun (name, prop) ->
      let hbox = new hbox homogeneous:true packing:(vbox#pack expand:false) in
      hbox#pack fill:true (new label text:name);
      hbox#pack fill:true (prop_widget prop);
      vbox#pack expand:false (new separator `HORIZONTAL)
    end;
  vbox

let prop_window = new window show:true title:"Properties"
let vbox = new vbox packing:prop_window#add

let widget_pool = new Omap.c []

let null_box = prop_box [] packing:vbox#add
let () = widget_pool#add key:"" data:null_box

let vboxref = ref null_box
let shown_widget = ref ""

let show_prop_box vb =
  vbox#remove !vboxref;
  vbox#pack vb;
  vboxref := vb

let prop_show (w : #tiwidget_base) =
  let name = w#name in
  let vb =
    try
      widget_pool#find key:name
    with Not_found ->
      let vb = prop_box w#proplist in
      widget_pool#add key:name data:vb;
      vb
  in
  show_prop_box vb;
  shown_widget := name

let prop_add (w : #tiwidget_base) =
  let vb = prop_box w#proplist in
  widget_pool#add key:w#name data:vb


let prop_remove name =
  widget_pool#remove key:name;
  if !shown_widget = name then begin
    shown_widget := "";
    show_prop_box (widget_pool#find key:"")
  end

let prop_change_name oldname newname =
  let vb = widget_pool#find key:oldname in
  widget_pool#remove key:oldname;
  widget_pool#add key:newname data:vb

let prop_update (w : #tiwidget_base) =
  let vb = prop_box w#proplist in
  widget_pool#remove key:w#name;
  widget_pool#add key:w#name data:vb;
  if !shown_widget = w#name then show_prop_box vb



  


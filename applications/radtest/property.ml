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

class property :name :init :range :parse :set :encode =
  object
    val mutable v : 'a = parse init
    val mutable s : string = init
    val name : string = name
    method get = s
    method set s' =
      if s' <> s then begin
	let v' = parse s' in
	(* undo s'; *)
	s <- s';
	v <- v';
	set v'
      end
    method modified = s <> init
    method name = name
    method code : string = encode s
    method range : range = range
end

let prop_enum :name :init :values =
  let parse s =
    try List.assoc s in:values
    with Not_found -> invalid_arg "Property.prop_enum#parse"
  in
  new property :name range:(Enum (List.map fun:fst values))
    :init :parse

let bool_values =
  [ "true", true; "false", false ]

let shadow_type_values : (string * Tags.shadow_type) list =
  [ "NONE", `NONE; "IN", `IN; "OUT", `OUT;
    "ETCHED_IN", `ETCHED_IN; "ETCHED_OUT", `ETCHED_OUT ]

let policy_type_values : (string * Tags.policy_type) list =
  [ "ALWAYS", `ALWAYS; "AUTOMATIC", `AUTOMATIC ]

let bq = (^) "`"

let prop_bool = prop_enum values:bool_values encode:id
let prop_shadow = prop_enum values:shadow_type_values encode:bq
let prop_policy = prop_enum values:policy_type_values encode:bq

let prop_int =
  let parse s =
    try int_of_string s with _ -> invalid_arg "Property.prop_int#parse"
  in
  new property :parse range:Int encode:id

let prop_float :name :init :min :max =
  let parse s =
    try float_of_string s with _ -> invalid_arg "Property.prop_float#parse"
  and encode s =
    if String.contains s '.' || String.contains s 'e' then s else s ^ ".0"
  in
  new property :name :init :parse range:(Float(min,max)) :encode

let prop_string =
  new property range:String parse:id
    encode:(fun s -> "\"" ^ String.escaped s ^ "\"")

class type tiwidget_base = object
  method name : string
  method proplist : (string * property) list
(*  method base : widget *)
end

let property_widget (property : property) =
  match property#range with
    Enum l ->
      let w =
	new combo popdown_strings:l use_arrows:`ALWAYS
      in
      w#entry#connect#changed callback:(fun () -> property#set w#entry#text);
      w#entry#set_editable false;
      w#entry#set_text property#get;
      (w :> widget)
  | String ->
      let w = new entry text:property#get in
      w#connect#activate callback:(fun () -> property#set w#text);
      (w :> widget)
  | Int ->
      let adjustment =
	new adjustment value:(float_of_string property#get)
	  lower:(-2.) upper:5000. step_incr:1. page_incr:10. page_size:0.
      in
      let w =
	new spin_button rate:0.5 digits:0 :adjustment in
      w#connect#activate
	callback:(fun () -> property#set (string_of_int w#value_as_int));
      (w :> widget)
  | Float (lower, upper) ->
      let adjustment =
	new adjustment value:(float_of_string property#get)
	  :lower :upper step_incr:((upper-.lower)/.100.)
	  page_incr:((upper-.lower)/.10.) page_size:0.
      in
      let w = new spin_button rate:0.5 digits:2 :adjustment in
      w#connect#activate
	callback:(fun () -> property#set (string_of_float w#value));
      (w :> widget)

let property_box list ?:packing ?:show =
  let vbox = new box `VERTICAL ?:packing ?:show in
  List.iter list fun:
    begin fun (name, property) ->
      let hbox = new hbox homogeneous:true packing:(vbox#pack expand:false) in
      hbox#pack fill:true (new label text:name);
      hbox#pack fill:true (property_widget property);
      vbox#pack expand:false (new separator `HORIZONTAL)
    end;
  vbox

let property_window = new window show:true title:"Properties"
let vbox = new vbox packing:property_window#add

let widget_pool = new Omap.c []

let null_box = property_box [] packing:vbox#add
let () = widget_pool#add key:"" data:null_box

let vboxref = ref null_box
let shown_widget = ref ""

let show_property_box vb =
  vbox#remove !vboxref;
  vbox#pack vb;
  vboxref := vb

let prop_show (w : #tiwidget_base) =
  let name = w#name in
  let vb =
    try
      widget_pool#find key:name
    with Not_found ->
      let vb = property_box w#proplist in
      widget_pool#add key:name data:vb;
      vb
  in
  show_property_box vb;
  shown_widget := name

let prop_add (w : #tiwidget_base) =
  let vb = property_box w#proplist in
  widget_pool#add key:w#name data:vb


let prop_remove name =
  widget_pool#remove key:name;
  if !shown_widget = name then begin
    shown_widget := "";
    show_property_box (widget_pool#find key:"")
  end

let prop_change_name oldname newname =
  let vb = widget_pool#find key:oldname in
  widget_pool#remove key:oldname;
  widget_pool#add key:newname data:vb

let prop_update (w : #tiwidget_base) =
  let vb = property_box w#proplist in
  widget_pool#remove key:w#name;
  widget_pool#add key:w#name data:vb;
  if !shown_widget = w#name then show_property_box vb



  


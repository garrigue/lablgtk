(* $Id$ *)

open Gtk
open GObj
open GEdit
open GData
open GPack
open GMisc
open GWindow

open Common
open Utils

external id : 'a -> 'a = "%identity"

class virtual vprop ~name ~init ~set =
  object (self)
    val mutable s : string = init
    val name : string = name
    method private virtual parse : string -> 'a
    method get = s
    method set s' =
      if s' <> s then begin
	let v = self#parse s' in
	add_undo (Property ((self :> prop), s));
	s <- s';
	set v
      end
    method modified = s <> init
    method name = name
    method code = s
    method virtual range : range
  end

let invalid_prop kind name s =
  invalid_arg (Printf.sprintf "Property.%s(%s) <- %s" kind name s)

class prop_enum ~values ~name ~init ~set =
  object (self)
    inherit vprop ~name ~init ~set
    method private parse s =
      try List.assoc s values
      with Not_found -> invalid_prop "enum" name s
    method range = Enum (List.map ~f:fst values)
  end

let bool_values =
  [ "true", true; "false", false ]

let shadow_type_values : (string * Tags.shadow_type) list =
  [ "NONE", `NONE; "IN", `IN; "OUT", `OUT;
    "ETCHED_IN", `ETCHED_IN; "ETCHED_OUT", `ETCHED_OUT ]

let policy_type_values : (string * Tags.policy_type) list =
  [ "ALWAYS", `ALWAYS; "AUTOMATIC", `AUTOMATIC ]

class prop_bool = prop_enum ~values:bool_values

class prop_variant ~values ~name ~init ~set : prop =
  object
    inherit prop_enum ~values ~name ~init ~set
    method code = "`" ^ s
  end

class prop_shadow = prop_enum ~values:shadow_type_values
class prop_policy = prop_enum ~values:policy_type_values

class prop_int ~name ~init ~set : prop =
  object
    inherit vprop ~name ~init ~set
    method private parse s =
      try int_of_string s with _ -> invalid_prop "int" name s
    method range = Int
  end

class prop_float ~name ~init ~min ~max ~set : prop =
  object
    inherit vprop ~name ~init ~set
    method private parse s =
      try float_of_string s with _ -> invalid_prop "float" name s
    method code =
      if String.contains s '.' || String.contains s 'e' then s
      else s ^ ".0"
    method range = Float(min,max)
  end

class prop_string ~name ~init ~set : prop =
  object
    inherit vprop ~name ~init ~set
    method private parse s = s
    method range = String
    method code = "\"" ^ String.escaped s ^ "\""
  end

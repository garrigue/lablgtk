(* $Id$ *)

open StdLabels
open Gtk
open GObj
open GEdit
open GData
open GPack
open GMisc
open GWindow

open Common
open Utils

(* external id : 'a -> 'a = "%identity" *)

class virtual vprop ~name ~init ~set =
  object (self)
    val mutable s : string = init
    val name : string = name
    method private virtual parse : string -> 'a
    method get = s
    method set s' =
      if s' <> s then begin
	let v = self#parse s' in
	if (set v) then begin
	  add_undo (Property ((self :> prop), s));
	  s <- s'
	end
      end
    method modified = s <> init
    method name = name
    method code = s
    method virtual range : range
    method save_code = self#code
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

(* used for radio_button groups; there is nothing to do
  in radtest when setting a radio_button group, only when writing
  code or saving *)
class prop_enum_dyn ~values ~name ~init ~set =
  object (self)
    inherit vprop ~name ~init ~set
    method private parse s = ()
    method range = Enum (values ())
  end

let bool_values =
  [ "true", true; "false", false ]

let shadow_type_values : (string * Tags.shadow_type) list =
  [ "NONE", `NONE; "IN", `IN; "OUT", `OUT;
    "ETCHED_IN", `ETCHED_IN; "ETCHED_OUT", `ETCHED_OUT ]

let policy_type_values : (string * Tags.policy_type) list =
  [ "ALWAYS", `ALWAYS; "AUTOMATIC", `AUTOMATIC ]

let orientation_values : (string * Tags.orientation) list =
  [ "HORIZONTAL", `HORIZONTAL; "VERTICAL", `VERTICAL ]

let toolbar_style_values : (string * Tags.toolbar_style) list =
  [ "ICONS", `ICONS; "TEXT", `TEXT; "BOTH", `BOTH ]

let toolbar_space_style_values : (string * [`EMPTY | `LINE]) list =
  [ "EMPTY", `EMPTY; "LINE", `LINE ]

let relief_style_values : (string * Tags.relief_style) list =
  [ "NORMAL", `NORMAL; "HALF", `HALF; "NONE", `NONE ]

let position_values : (string * Tags.position) list =
  [ "LEFT", `LEFT; "RIGHT", `RIGHT; "TOP", `TOP; "BOTTOM", `BOTTOM ]

let combo_use_arrows_values : (string * [ `NEVER | `DEFAULT | `ALWAYS ]) list =
[ "NEVER", `NEVER; "DEFAULT", `DEFAULT; "ALWAYS", `ALWAYS ] 

let spin_button_update_policy_values :
    (string * Tags. spin_button_update_policy) list =
  [ "ALWAYS", `ALWAYS; "IF_VALID", `IF_VALID ]

let button_box_style_values : (string * Tags.button_box_style) list =
  [ "DEFAULT_STYLE", `DEFAULT_STYLE; "SPREAD", `SPREAD; "EDGE", `EDGE;
    "START", `START; "END", `END ]

let update_type_values : (string * Tags.update_type) list =
  [ "CONTINUOUS", `CONTINUOUS; "DISCONTINUOUS", `DISCONTINUOUS;
    "DELAYED", `DELAYED ]


class prop_bool = prop_enum ~values:bool_values

(*
class prop_variant ~values ~name ~init ~set : prop =
  object
    inherit prop_enum ~values ~name ~init ~set
    method code = "`" ^ s
  end
*)

class prop_shadow = prop_enum ~values:shadow_type_values
class prop_policy = prop_enum ~values:policy_type_values
class prop_orientation = prop_enum ~values:orientation_values
class prop_toolbar_style = prop_enum ~values:toolbar_style_values
class prop_toolbar_space_style = prop_enum ~values:toolbar_space_style_values
class prop_relief_style = prop_enum ~values:relief_style_values
class prop_position = prop_enum ~values:position_values
class prop_combo_use_arrows = prop_enum ~values:combo_use_arrows_values
class prop_spin_button_update_policy = prop_enum
    ~values:spin_button_update_policy_values
class prop_button_box_style = prop_enum ~values:button_box_style_values
class prop_update_type = prop_enum ~values:update_type_values

class prop_int ~name ~init ~set : prop =
  object
    inherit vprop ~name ~init ~set
    method private parse s =
      try int_of_string s with _ -> invalid_prop "int" name s
    method range = Int
  end

(* NB: float_of_string doesn't raise an exception in case of error *)
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

class prop_adjustment ~name ~init ~set : prop =
  object
    inherit vprop ~name ~init ~set
    method private parse = get5floats_from_string
    method range = Adjust
  end

class prop_clist_titles ~name ~init ~set : prop =
  object
    inherit vprop ~name ~init ~set
    method private parse = split_string ~sep:' '
    method range = CList_titles
    method code = "[ \"" ^
      String.concat ~sep:"\"; \"" (split_string ~sep:' ' s) ^ "\" ]"
    method save_code = "\"" ^ s ^ "\""
  end

class prop_file ~name ~init ~set : prop =
  object
    inherit vprop ~name ~init ~set
    method private parse s = s
    method range = File
    method code = "\"" ^ String.escaped s ^ "\""
  end


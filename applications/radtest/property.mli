(* $Id$ *)

open Gtk.Tags
open Common

class virtual vprop :
  name:string ->		(* property's name *)
  init:string ->		(* default value *)
  set:('a -> bool) ->
  object
    val name : string
    val mutable s : string
    method code : string	(* encoded value *)
    method get : string
    method modified : bool
    method name : string
    method private virtual parse : string -> 'a
    method virtual range : range
    method save_code : string
    method set : string -> unit
  end

class prop_int :
  name:string -> init:string -> set:(int -> bool) -> prop

class prop_float :
  name:string ->
  init:string -> min:float -> max:float -> set:(float -> bool) -> prop

class prop_string :
  name:string -> init:string -> set:(string -> bool) -> prop

class prop_bool :
  name:string -> init:string -> set:(bool -> bool) -> prop
(*
class prop_variant :
  values:(string * 'a) list ->
  name:string -> init:string -> set:('a -> bool) -> prop
*)
class prop_shadow :
  name:string -> init:string -> set:(shadow_type -> bool) -> prop

class prop_policy :
  name:string -> init:string -> set:(policy_type -> bool) -> prop

class prop_orientation :
  name:string ->
  init:string -> set:(Gtk.Tags.orientation -> bool) -> prop

class prop_toolbar_style :
  name:string ->
  init:string -> set:(Gtk.Tags.toolbar_style -> bool) -> prop

class prop_toolbar_space_style :
  name:string -> init:string -> set:([ `EMPTY | `LINE] -> bool) -> prop

class prop_relief_style :
  name:string ->
  init:string -> set:(Gtk.Tags.relief_style -> bool) -> prop

class prop_position :
  name:string ->
  init:string -> set:(Gtk.Tags.position -> bool) -> prop

class prop_combo_use_arrows :
  name:string ->
  init:string -> set:([ `NEVER | `DEFAULT | `ALWAYS] -> bool) -> prop

class prop_spin_button_update_policy :
  name:string ->
  init:string -> set:(Gtk.Tags.spin_button_update_policy -> bool) -> prop

class prop_button_box_style :
  name:string ->
  init:string -> set:(Gtk.Tags.button_box_style -> bool) -> prop

class prop_update_type :
  name:string ->
  init:string -> set:(Gtk.Tags.update_type -> bool) -> prop

class prop_enum_dyn :
  values:(unit -> string list) -> name:string ->
  init:string -> set:(unit -> bool) -> prop

class prop_adjustment :
  name:string -> init:string ->
    set:(float * float * float * float * float -> bool) -> prop

class prop_clist_titles :
  name:string -> init:string ->
    set:(string list -> bool) -> prop

class prop_file :
  name:string -> init:string -> set:(string -> bool) -> prop



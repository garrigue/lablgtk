(* $Id$ *)

open Gtk.Tags
open Common

class virtual vprop :
  name:string ->		(* property's name *)
  init:string ->		(* default value *)
  set:('a -> unit) ->
  object
    val name : string
    val mutable s : string
    method code : string	(* encoded value *)
    method get : string
    method modified : bool
    method name : string
    method private virtual parse : string -> 'a
    method virtual range : range
    method set : string -> unit
  end

class prop_int :
  name:string -> init:string -> set:(int -> unit) -> prop

class prop_float :
  name:string ->
  init:string -> min:float -> max:float -> set:(float -> unit) -> prop

class prop_string :
  name:string -> init:string -> set:(string -> unit) -> prop

class prop_bool :
  name:string -> init:string -> set:(bool -> unit) -> prop

class prop_variant :
  values:(string * 'a) list ->
  name:string -> init:string -> set:('a -> unit) -> prop

class prop_shadow :
  name:string -> init:string -> set:(shadow_type -> unit) -> prop

class prop_policy :
  name:string -> init:string -> set:(policy_type -> unit) -> prop

(* $Id$ *)

open Gtk

type range =
    String
  | Int
  | Float of float * float
  | Enum of string list

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

(*
class prop_enum :
  values:(string * 'a) list ->
  name:string ->
  init:string ->
  set:('a -> unit) ->
  object
    val name : string
    val mutable s : string
    method code : string
    method get : string
    method modified : bool
    method name : string
    method private parse : string -> 'a
    method range : range
    method set : string -> unit
  end
*)

class type prop =
  object
    method code : string
    method get : string
    method modified : bool
    method name : string
    method range : range
    method set : string -> unit
  end

class prop_int : name:string -> init:string -> set:(int -> unit) -> prop

class prop_float :
  name:string ->
  init:string -> min:float -> max:float -> set:(float -> unit) -> prop

class prop_string :
  name:string -> init:string -> set:(string -> unit) -> prop

class prop_variant :
  values:(string * 'a) list ->
  name:string -> init:string -> set:('a -> unit) -> prop

class prop_bool :
  name:string -> init:string -> set:(bool -> unit) -> prop

class prop_shadow :
  name:string ->
  init:string -> set:(Gtk.Tags.shadow_type -> unit) -> prop

class prop_policy :
  name:string ->
  init:string -> set:(Gtk.Tags.policy_type -> unit) -> prop

class type tiwidget_base =
  object method name : string method proplist : (string * prop) list end

val prop_show : #tiwidget_base -> unit
val prop_add : #tiwidget_base -> unit
val prop_remove : string -> unit
val prop_change_name : string -> string -> unit
val prop_update : #tiwidget_base -> unit

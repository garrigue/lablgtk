(* $Id$ *)

open Gtk

type range =
    String
  | Int
  | Float of float * float
  | Enum of string list

class property :
  name:string ->		(* property's name *)
  init:string ->		(* default value *)
  range:range ->
  parse:(string -> 'a) ->
  set:('a -> unit) ->
  encode:(string -> string) ->	(* how to represent the value in ML *)
  object
    val name : string
    val mutable s : string
    val mutable v : 'a
    method name : string
    method range : range
    method get : string
    method set : string -> unit
    method modified : bool
    method code : string	(* encoded value *)
  end

val prop_enum :
  name:string ->
  init:string ->
  values:(string * 'a) list ->
  set:('a -> unit) -> encode:(string -> string) -> property
val prop_bool :
  name:string ->
  init:string -> set:(bool -> unit) -> property
val prop_shadow :
  name:string ->
  init:string ->
  set:(Tags.shadow_type -> unit) -> property
val prop_policy :
  name:string ->
  init:string ->
  set:(Tags.policy_type -> unit) -> property
val prop_int : name:string -> init:string -> set:(int -> unit) -> property
val prop_float :
  name:string ->
  init:string -> min:float -> max:float -> set:(float -> unit) -> property
val prop_string :
  name:string -> init:string -> set:(string -> unit) -> property

class type tiwidget_base =
  object method name : string method proplist : (string * property) list end

val prop_show : #tiwidget_base -> unit
val prop_add : #tiwidget_base -> unit
val prop_remove : string -> unit
val prop_change_name : string -> string -> unit
val prop_update : #tiwidget_base -> unit

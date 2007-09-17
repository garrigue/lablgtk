(**************************************************************************)
(*                Lablgtk                                                 *)
(*                                                                        *)
(*    This program is free software; you can redistribute it              *)
(*    and/or modify it under the terms of the GNU Library General         *)
(*    Public License as published by the Free Software Foundation         *)
(*    version 2, with the exception described in file COPYING which       *)
(*    comes with the library.                                             *)
(*                                                                        *)
(*    This program is distributed in the hope that it will be useful,     *)
(*    but WITHOUT ANY WARRANTY; without even the implied warranty of      *)
(*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       *)
(*    GNU Library General Public License for more details.                *)
(*                                                                        *)
(*    You should have received a copy of the GNU Library General          *)
(*    Public License along with this program; if not, write to the        *)
(*    Free Software Foundation, Inc., 59 Temple Place, Suite 330,         *)
(*    Boston, MA 02111-1307  USA                                          *)
(*                                                                        *)
(*                                                                        *)
(**************************************************************************)

(* $Id$ *)

type -'a obj
type g_type
type -'a g_type_info
type -'a g_class
type g_value
type g_closure
type g_param_spec
type basic =
  [ `BOOL of bool
  | `CAML of Obj.t
  | `CHAR of char
  | `FLOAT of float
  | `INT of int
  | `INT64 of int64
  | `POINTER of Gpointer.boxed option
  | `STRING of string option ]

type data_get = [ basic | `NONE | `OBJECT of unit obj option ]
type 'a data_set =
  [ basic | `OBJECT of 'a obj option | `INT32 of int32 | `LONG of nativeint ]

type base_data =
  [ `BOOLEAN
  | `CHAR
  | `UCHAR
  | `INT
  | `UINT
  | `LONG
  | `ULONG
  | `INT64
  | `UINT64
  | `ENUM
  | `FLAGS
  | `FLOAT
  | `DOUBLE
  | `STRING
  | `POINTER
  | `BOXED
  | `OBJECT ]

type data_kind = [ `INT32 | `UINT32 | `OTHER of g_type | base_data ]
type data_conv_get = [ `INT32 of int32 | data_get ]

type 'a data_conv =
    { kind : data_kind; proj : data_conv_get -> 'a; inj : 'a -> unit data_set }

type ('a, 'b) property = { name : string; conv : 'b data_conv }

type fundamental_type =
  [ `INVALID | `NONE | `INTERFACE | `PARAM | base_data ]

exception Cannot_cast of string * string

val get_type : 'a obj -> g_type
val is_a : 'a obj -> string -> bool
val try_cast : 'a obj -> string -> 'b obj
val get_oid : 'a obj -> int

external unsafe_cast : 'a obj -> 'b obj = "%identity"
external coerce : 'a obj -> unit obj = "%identity"
external coerce_option : 'a obj option -> unit obj option = "%identity"
    (* [coerce] and [coerce_option] are safe *)

type +'a param
val dyn_param : string -> 'a data_set -> 'b param
val param : ('a,'b) property -> 'b -> 'a param

val unsafe_create : g_type -> 'a param list -> 'b obj
val unsafe_create_from_name : classe:string -> 'a param list -> 'a obj
    (* This type is NOT safe *)
val unsafe_unref : 'a obj -> unit
    (* Creates a NULL pointer; many places do not check for them! *)
val get_ref_count : 'a obj -> int
    (* Number of references to an object (for debugging) *)

val set : ('a, 'b) property -> 'a obj -> 'b -> unit
val get : ('a, 'b) property -> 'a obj -> 'b
val set_params : 'a obj -> 'a param list -> unit

module Type :
  sig
    val init : unit -> unit
    val name : g_type -> string
    val from_name : string -> g_type
    val parent : g_type -> g_type
    val depth : g_type -> int
    val is_a : g_type -> g_type -> bool
    val fundamental : g_type -> fundamental_type
    val of_fundamental : fundamental_type -> g_type
    val interface_prerequisites : g_type -> g_type list
    val of_class : 'a g_class -> g_type

    val register_static :
      parent: g_type ->
      name: string ->
      ?info: 'a g_type_info ->
      unit -> g_type
    val query : g_type -> (g_type * string * int * int)
    (* @raise Not_found if the [g_type] is invalid *)

    val create_info :
      ?class_size: int ->
      ?base_init: ('a g_class -> unit) ->
      ?base_finalize: ('a g_class -> unit) ->
      ?class_init: ('a g_class -> unit) ->
      ?class_finalize: ('a g_class -> unit) ->
      ?instance_size: int ->
      ?n_preallocs: int ->
(*      ?instance_init: TODO ->*)
(*      ?value_table: TODO ->*)
      unit -> 'a g_type_info

    val caml : g_type
  end

module Value :
  sig
    val create_empty : unit -> g_value
    val init : g_value -> g_type -> unit
    val create : g_type -> g_value
    val release : g_value -> unit
    val get_type : g_value -> g_type
    val copy : g_value -> g_value -> unit
    val reset : g_value -> unit
    val type_compatible : g_type -> g_type -> bool
    val type_transformable : g_type -> g_type -> bool
    val transform : g_value -> g_value -> bool
    val get : g_value -> data_get
    val set : g_value -> 'a data_set -> unit
    val get_pointer : g_value -> Gpointer.boxed
    val get_nativeint : g_value -> nativeint
    val get_int32 : g_value -> int32
    val get_conv : data_kind -> g_value -> data_conv_get
  end

module Class :
  sig
    exception Cannot_cast of (string * string)
    val name : 'a g_class -> string
    val unsafe_cast : 'a g_class -> 'b g_class
    val try_cast : 'a g_class -> g_type -> 'b g_class
    val of_type : g_type -> 'a g_class
      (** @raise Gpointer.Null if there was any trouble identifying the [g_type] *)
    val peek : g_type -> 'a g_class
      (** @raise Gpointer.Null if the class of the type passed in does not currently
        exist (hasn't been referenced before) *)
    val ref : g_type -> 'a g_class
    val unref : 'a g_class -> unit
  end

module Closure :
  sig
    type args
    type argv = { result : g_value; nargs : int; args : args; }
    val create : (argv -> unit) -> g_closure
    val nth : argv -> pos:int -> g_value
    val result : argv -> g_value
    val get_result_type : argv -> g_type
    val get_type : argv -> pos:int -> g_type
    val get : argv -> pos:int -> data_get
    val set_result : argv -> 'a data_set -> unit
    val get_args : argv -> data_get list
    val get_pointer : argv -> pos:int -> Gpointer.boxed
    val get_nativeint : argv -> pos:int -> nativeint
    val get_int32 : argv -> pos:int -> int32
  end

module Data :
  sig
    val boolean : bool data_conv
    val char : char data_conv
    val uchar : char data_conv
    val int : int data_conv
    val uint : int data_conv
    val long : int data_conv
    val ulong : int data_conv
    val flags : ([>  ] as 'a) Gpointer.variant_table -> 'a list data_conv
    val enum : ([>  ] as 'a) Gpointer.variant_table -> 'a data_conv
    val int32 : int32 data_conv
    val uint32 : int32 data_conv
    val int64 : int64 data_conv
    val uint64 : int64 data_conv
    val float : float data_conv
    val double : float data_conv
    val string : string data_conv
    val string_option : string option data_conv
    (* pointers disable copy *)
    val pointer : Gpointer.boxed option data_conv
    val unsafe_pointer : 'a data_conv
    val unsafe_pointer_option : 'a option data_conv
    (* use boxed to enable copy of parameter *)
    val boxed : g_type -> Gpointer.boxed option data_conv
    val unsafe_boxed : g_type -> 'a data_conv
    val unsafe_boxed_option : g_type -> 'a option data_conv
    val gobject : 'a obj data_conv
    val gobject_option : 'a obj option data_conv
    val gobject_by_name : string -> 'a obj data_conv
    val caml : 'a data_conv
    val caml_option : 'a option data_conv
    val wrap :
      inj:('a -> 'b) -> proj:('b -> 'a) -> 'b data_conv -> 'a data_conv
    val of_value : 'a data_conv -> g_value -> 'a
    val to_value : 'a data_conv -> 'a -> g_value
    val get_type : 'a data_conv -> g_type
  end

module Property :
  sig
    val freeze_notify : 'a obj -> unit
    val thaw_notify : 'a obj -> unit
    val notify : 'a obj -> string -> unit
    val set_value : 'a obj -> string -> g_value -> unit
    val get_value : 'a obj -> string -> g_value -> unit
    val get_type : 'a obj -> string -> g_type
    val set_dyn : 'a obj -> string -> 'b data_set -> unit
    val get_dyn : 'a obj -> string -> data_get
    val set : 'a obj -> ('a, 'b) property -> 'b -> unit
    val get : 'a obj -> ('a, 'b) property -> 'b
    val get_some : 'a obj -> ('a, 'b option) property -> 'b
    val check : 'a obj -> ('a, 'b) property -> unit
    val may_cons :
      ('a,'b) property -> 'b option -> 'a param list -> 'a param list
    val may_cons_opt :
      ('a,'b option) property -> 'b option -> 'a param list -> 'a param list
  end

type param_flag =
  [ `READABLE | `WRITABLE | `CONSTRUCT | `CONSTRUCT_ONLY | `LAX_VALIDATION
  | `STATIC_NAME | `PRIVATE | `STATIC_NICK | `STATIC_BLURB ]

module ParamSpec :
  sig
    val int :
      name: string -> ?nick: string -> ?blurb: string ->
      ?min: int -> ?max: int -> ?default: int ->
      ?param: param_flag list -> unit -> g_param_spec
(** @param nick default value is [name]
    @param blurb default value is [name]
    @param min default value is [min_int]
    @param max default value is [max_int]
    @param default default value is [0]
    @param param default value is [[]] *)
    val string :
      name: string -> ?nick: string -> ?blurb: string ->
      ?default: string -> ?param: param_flag list ->
      unit -> g_param_spec
(** @param nick default value is [name]
    @param blurb default value is [name]
    @param default default value is [""]
    @param param default value is [[]] *)
  end

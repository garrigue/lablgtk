module SMap :
  sig
    type key = string
    and 'a t
    val empty : 'a t
    val add : key:key -> data:'a -> 'a t -> 'a t
    val find : key:key -> 'a t -> 'a
    val remove : key:key -> 'a t -> 'a t
    val mem : key:key -> 'a t -> bool
    val iter : fun:(key:key -> data:'a -> unit) -> 'a t -> unit
    val map : fun:('a -> 'b) -> 'a t -> 'b t
    val fold :
      fun:(key:key -> data:'a -> acc:'b -> 'b) -> 'a t -> acc:'b -> 'b
  end
class ['a] rval :
  'a ->
  setfun:('a -> unit) ->
  ?value_list:(string * 'a) list ->
  object
    val mutable value : 'a
    val value_list : (string * 'a) list
    method set : 'a -> unit
    method value : 'a
    method value_list : (string * 'a) list
  end
type property =
    Bool of bool rval
  | Int of int rval
  | Float of float rval
  | String of string rval
val get_int_prop : SMap.key -> in:property SMap.t -> int
val get_bool_prop : SMap.key -> in:property SMap.t -> bool
val get_float_prop : SMap.key -> in:property SMap.t -> float
val get_string_prop : SMap.key -> in:property SMap.t -> string
val string_of_int_prop : SMap.key -> in:property SMap.t -> string
val string_of_bool_prop : SMap.key -> in:property SMap.t -> string
val string_of_float_prop : SMap.key -> in:property SMap.t -> string
class type rwidget_base =
  object
    method base : GObj.widget
    method name : string
    method proplist : property SMap.t
  end
val property_add : #rwidget_base -> unit
val property_remove : #rwidget_base -> unit
val property_update : unit -> unit
val test_unique : string -> bool

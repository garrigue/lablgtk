(* $Id$ *)

type 'a obj
type g_type
type g_class

module Tags = struct
  type fundamental_type =
    [ `INVALID | `NONE | `INTERFACE
    | `CHAR | `UCHAR | `BOOLEAN
    | `INT  | `UINT  | `LONG  | `ULONG  | `INT64  | `UINT64
    | `ENUM | `FLAGS
    | `FLOAT  | `DOUBLE
    | `STRING | `POINTER  | `BOXED  | `PARAM
    | `OBJECT ]
end
open Tags

module Type = struct
  external name : g_type -> string = "ml_g_type_name"
  external from_name : string -> g_type = "ml_g_type_from_name"
  external parent : g_type -> g_type = "ml_g_type_parent"
  external depth : g_type -> int = "ml_g_type_depth"
  external is_a : g_type -> g_type -> bool = "ml_g_type_is_a"
  external fundamental : g_type -> fundamental_type
      = "ml_g_type_fundamental"
end

external get_type : 'a obj -> gtk_type = "ml_G_TYPE_FROM_INSTANCE"
let is_a obj name =
  Type.is_a (get_type obj) (Type.from_name name)

external unsafe_cast : 'a obj -> 'b obj = "%identity"
let try_cast w name =
  if is_a w name then unsafe_cast w
  else raise (Cannot_cast(Type.name(get_type w), name))

let get_id (obj : 'a obj) : int = (snd (Obj.magic obj) lor 0)

external freeze_notify : g_object -> unit = "ml_g_object_freeze_notify"
external thaw_notify : g_object -> unit = "ml_g_object_thaw_notify"

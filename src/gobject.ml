(* $Id$ *)

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


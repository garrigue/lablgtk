(* $Id$ *)

type range =
    String
  | Int
  | Float of float * float
  | Enum of string list
  | Enum_string of string list
  | Adjust

class type prop =
  object
    method name : string	(* name of the property *)
    method range : range	(* range of its values *)
    method get : string		(* current value *)
    method set : string -> unit	(* change value *)
    method modified : bool	(* value differs from default *)
    method code : string	(* encoded value *)
  end

class type tiwidget_base = object
  method name : string
  method proplist : (string * prop) list
end


(*
  [utf8 0xiii] converts an index [iii] (usually in hexadecimal form) into a 
  string containing the UTF-8 encoded character [0xiii]. See 
  http://www.unicode.org for charmaps.
  Does not check that the given index is a valid unicode index. 
*)
val from_unicode_index : int -> string


val validate : string -> bool

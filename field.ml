(* $Id$ *)


type 'a table
type ('a,'b) field = { table: 'a table; field: int }

external get : ('a,'b) field -> 'a -> 'b = "ml_table_get_field"

let event_table : ('a event) table = ..
let event_type : ('a event, 'a) field = { table = event_table; field = 0 }

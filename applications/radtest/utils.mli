external test_modifier : Gdk.Tags.modifier -> int -> bool
  = "ml_test_GdkModifier_val"
type yywidget = string * string * (string * string) list
and yywidget_tree = Node of yywidget * yywidget_tree list
val to_string : string ref -> Oformat.c
val list_remove : pred:('a -> bool) -> 'a list -> 'a list
val cut_list : elt:'a -> 'a list -> 'a list * 'a list
val list_split : pred:('a -> bool) -> 'a list -> 'a list * 'a list
val list_pos : 'a -> in:'a list -> int
val list_reorder_up : pos:int -> 'a list -> 'a list
val list_reorder_down : pos:int -> 'a list -> 'a list
val change_property_name : 'a -> 'a -> ('a * 'b) list -> ('a * 'b) list
val name_list : string list ref
val split : string -> string * int
val change_name : string -> string
val test_unique : string -> bool
val message_name : unit -> unit
val signal_id : int ref
val next_callback_id : unit -> GtkSignal.id
class ['a] signal :
  object
    val mutable callbacks : (GtkSignal.id * ('a -> unit)) list
    method call : 'a -> unit
    method connect : callback:('a -> unit) -> ?after:bool -> GtkSignal.id
    method disconnect : GtkSignal.id -> bool
    method reset : unit -> unit
  end
class type disconnector =
  object
    method disconnect : GtkSignal.id -> bool
    method reset : unit -> unit
  end
class has_ml_signals :
  object
    val mutable disconnectors : disconnector list
    method private add_signal : 'a signal -> unit
    method disconnect : GtkSignal.id -> bool
  end

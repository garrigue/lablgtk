(* $Id$ *)

open Gtk
open GObj

class editable_signals : 'a obj ->
  object
    inherit widget_signals
    constraint 'a = [> editable]
    val obj : 'a obj
    method activate : callback:(unit -> unit) -> GtkSignal.id
    method changed : callback:(unit -> unit) -> GtkSignal.id
    method delete_text :
      callback:(start:int -> stop:int -> unit) -> GtkSignal.id
    method insert_text :
      callback:(string -> pos:int -> unit) -> GtkSignal.id
  end

class editable : 'a obj ->
  object
    inherit widget
    constraint 'a = [> Gtk.editable]
    val obj : 'a obj
    method connect : editable_signals
    method copy_clipboard : unit -> unit
    method cut_clipboard : unit -> unit
    method delete_selection : unit -> unit
    method delete_text : start:int -> stop:int -> unit
    method get_chars : start:int -> stop:int -> string
    method insert_text : string -> pos:int -> int
    method paste_clipboard : unit -> unit
    method position : int
    method select_region : start:int -> stop:int -> unit
    method selection : (int * int) option
    method set_editable : bool -> unit
    method set_position : int -> unit
  end

class entry : 'a obj ->
  object
    inherit editable
    constraint 'a = [> Gtk.entry]
    val obj : 'a obj
    method event : event_ops
    method append_text : string -> unit
    method prepend_text : string -> unit
    method set_max_length : int -> unit
    method set_text : string -> unit
    method set_visibility : bool -> unit
    method text : string
    method text_length : int
  end
val entry :
  ?max_length:int ->
  ?text:string ->
  ?visibility:bool ->
  ?editable:bool ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> entry

class spin_button : Gtk.spin_button obj ->
  object
    inherit entry
    val obj : Gtk.spin_button obj
    method adjustment : GData.adjustment
    method set_adjustment : GData.adjustment -> unit
    method set_digits : int -> unit
    method set_numeric : bool -> unit
    method set_snap_to_ticks : bool -> unit
    method set_update_policy : [`ALWAYS|`IF_VALID] -> unit
    method set_value : float -> unit
    method set_wrap : bool -> unit
    method spin : Tags.spin_type -> unit
    method update : unit
    method value : float
    method value_as_int : int
  end
val spin_button :
  ?adjustment:GData.adjustment ->
  ?rate:float ->
  ?digits:int ->
  ?value:float ->
  ?update_policy:[`ALWAYS|`IF_VALID] ->
  ?numeric:bool ->
  ?wrap:bool ->
  ?snap_to_ticks:bool ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> spin_button

class combo : Gtk.combo obj ->
  object
    inherit widget
    val obj : Gtk.combo obj
    method disable_activate : unit -> unit
    method entry : entry
    method list : GList.liste
    method set_case_sensitive : bool -> unit
    method set_item_string : GList.list_item -> string -> unit
    method set_popdown_strings : string list -> unit
    method set_use_arrows : [`NEVER|`DEFAULT|`ALWAYS] -> unit
    method set_value_in_list :
      ?required:bool -> ?ok_if_empty:bool -> unit -> unit
  end
val combo :
  ?popdown_strings:string list ->
  ?use_arrows:[`NEVER|`DEFAULT|`ALWAYS] ->
  ?case_sensitive:bool ->
  ?value_in_list:bool ->
  ?ok_if_empty:bool ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> combo

(*
class text : Gtk.text obj ->
  object
    inherit editable
    val obj : Gtk.text obj
    method event : event_ops
    method freeze : unit -> unit
    method hadjustment : GData.adjustment
    method insert :
      ?font:Gdk.font ->
      ?foreground:GDraw.color -> ?background:GDraw.color -> string -> unit
    method length : int
    method point : int
    method set_hadjustment : GData.adjustment -> unit
    method set_point : int -> unit
    method set_vadjustment : GData.adjustment -> unit
    method set_word_wrap : bool -> unit
    method set_line_wrap : bool -> unit
    method thaw : unit -> unit
    method vadjustment : GData.adjustment
  end
val text :
  ?hadjustment:GData.adjustment ->
  ?vadjustment:GData.adjustment ->
  ?editable:bool ->
  ?word_wrap:bool ->
  ?line_wrap:bool ->
  ?width:int ->
  ?height:int -> ?packing:(widget -> unit) -> ?show:bool -> unit -> text
*)

(* $Id$ *)

open Gtk
open GObj

class editable_signals : [> editable] obj ->
  object
    inherit widget_signals
    method changed : callback:(unit -> unit) -> GtkSignal.id
    method delete_text :
      callback:(start:int -> stop:int -> unit) -> GtkSignal.id
    method insert_text :
      callback:(string -> pos:int ref -> unit) -> GtkSignal.id
  end

class editable : 'a obj ->
  object
    inherit widget
    constraint 'a = [> Gtk.editable]
    val obj : 'a obj
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
    method set_position : int -> unit
  end

class entry_signals : [> Gtk.entry] obj ->
  object
    inherit editable_signals
    method activate : callback:(unit -> unit) -> GtkSignal.id
    method copy_clipboard : callback:(unit -> unit) -> GtkSignal.id
    method cut_clipboard : callback:(unit -> unit) -> GtkSignal.id
    method delete_from_cursor :
      callback:(Gtk.Tags.delete_type -> int -> unit) -> GtkSignal.id
    method insert_at_cursor : callback:(string -> unit) -> GtkSignal.id
    method move_cursor :
      callback:(Gtk.Tags.movement_step -> int -> extend:bool -> unit) ->
      GtkSignal.id
    method paste_clipboard : callback:(unit -> unit) -> GtkSignal.id
    method populate_popup : callback:(GMenu.menu -> unit) -> GtkSignal.id
    method toggle_overwrite : callback:(unit -> unit) -> GtkSignal.id
  end

class entry : ([> Gtk.entry] as 'a) obj ->
  object
    inherit editable
    val obj : 'a obj
    method connect : entry_signals
    method event : event_ops
    method append_text : string -> unit
    method prepend_text : string -> unit
    method scroll_offset : int
    method text : string
    method text_length : int
    method set_activates_default : bool -> unit
    method set_editable : bool -> unit
    method set_has_frame : bool -> unit
    method set_invisible_char : int -> unit
    method set_max_length : int -> unit
    method set_text : string -> unit
    method set_visibility : bool -> unit
    method set_width_chars : int -> unit
    method activates_default : bool
    method editable : bool
    method has_frame : bool
    method invisible_char : int
    method max_length : int
    method visibility : bool
    method width_chars : int
  end
val entry :
  ?text:string ->
  ?visibility:bool ->
  ?max_length:int ->
  ?activates_default:bool ->
  ?editable:bool ->
  ?has_frame:bool ->
  ?width_chars:int ->
  ?width:int -> ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> entry

class spin_button_signals : [> Gtk.spin_button] obj ->
  object
    inherit entry_signals
    method change_value :
      callback:(Gtk.Tags.scroll_type -> unit) -> GtkSignal.id
    method input : callback:(unit -> int) -> GtkSignal.id
    method output : callback:(unit -> bool) -> GtkSignal.id
    method value_changed : callback:(unit -> unit) -> GtkSignal.id
  end

class spin_button : Gtk.spin_button obj ->
  object
    inherit widget
    val obj : Gtk.spin_button obj
    method connect : spin_button_signals
    method event : GObj.event_ops
    method spin : Tags.spin_type -> unit
    method update : unit
    method value_as_int : int
    method set_adjustment : GData.adjustment -> unit
    method set_digits : int -> unit
    method set_numeric : bool -> unit
    method set_rate : float -> unit
    method set_snap_to_ticks : bool -> unit
    method set_update_policy : [`ALWAYS|`IF_VALID] -> unit
    method set_value : float -> unit
    method set_wrap : bool -> unit
    method adjustment : GData.adjustment
    method digits : int
    method numeric : bool
    method rate : float
    method snap_to_ticks : bool
    method update_policy : [`ALWAYS|`IF_VALID]
    method value : float
    method wrap : bool
  end
val spin_button :
  ?adjustment:GData.adjustment ->
  ?rate:float ->
  ?digits:int ->
  ?numeric:bool ->
  ?snap_to_ticks:bool ->
  ?update_policy:[`ALWAYS|`IF_VALID] ->
  ?value:float ->
  ?wrap:bool ->
  ?width:int -> ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> spin_button

class combo : Gtk.combo obj ->
  object
    inherit widget
    val obj : Gtk.combo obj
    method disable_activate : unit -> unit
    method entry : entry
    method list : GList.liste
    method set_item_string : GList.list_item -> string -> unit
    method set_popdown_strings : string list -> unit
    method set_allow_empty : bool -> unit
    method set_case_sensitive : bool -> unit
    method set_enable_arrow_keys : bool -> unit
    method set_value_in_list : bool -> unit
    method allow_empty : bool
    method case_sensitive : bool
    method enable_arrow_keys : bool
    method value_in_list : bool
  end
val combo :
  ?popdown_strings:string list ->
  ?allow_empty:bool ->
  ?case_sensitive:bool ->
  ?enable_arrow_keys:bool ->
  ?value_in_list:bool ->
  ?border_width:int -> ?width:int -> ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> combo

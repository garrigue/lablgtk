(* $Id$ *)

open Gtk

class editable_signals :
  'a[> editable widget] obj ->
  ?after:bool ->
  object
    inherit GObj.widget_signals
    val obj : 'a obj
    method activate : callback:(unit -> unit) -> GtkSignal.id
    method changed : callback:(unit -> unit) -> GtkSignal.id
  end

class editable :
  'a[> editable widget] obj ->
  object
    inherit GObj.widget
    val obj : 'a obj
    method connect : ?after:bool -> editable_signals
    method copy_clipboard : unit -> unit
    method cut_clipboard : unit -> unit
    method delete_selection : unit -> unit
    method delete_text : start:int -> end:int -> unit
    method get_chars : start:int -> end:int -> string
    method insert_text : string -> pos:int -> int
    method paste_clipboard : unit -> unit
    method position : int
    method select_region : start:int -> end:int -> unit
    method selection : (int * int) option
    method set_editable : bool -> unit
    method set_position : int -> unit
  end

class entry :
  ?max_length:int ->
  ?text:string ->
  ?visibility:bool ->
  ?editable:bool ->
  ?width:int -> ?height:int ->
  ?packing:(entry -> unit) -> ?show:bool ->
  object
    inherit editable
    val obj : Gtk.entry obj
    method add_events : Gdk.Tags.event_mask list -> unit
    method append_text : string -> unit
    method prepend_text : string -> unit
    method set_entry : ?visibility:bool -> ?max_length:int -> unit
    method set_text : string -> unit
    method text : string
    method text_length : int
  end
class entry_wrapper : ([> entry]) obj -> entry

class spin_button :
  rate:float ->
  digits:int ->
  ?adjustment:GData.adjustment ->
  ?value:float ->
  ?update_policy:[ALWAYS IF_VALID] ->
  ?numeric:bool ->
  ?wrap:bool ->
  ?shadow_type:Tags.shadow_type ->
  ?snap_to_ticks:bool ->
  ?width:int -> ?height:int ->
  ?packing:(spin_button -> unit) -> ?show:bool ->
  object
    inherit entry
    val obj : Gtk.spin_button obj
    method adjustment : GData.adjustment
    method value : float
    method value_as_int : int
    method spin : Tags.spin_type -> unit
    method update : unit
    method set_spin :
      ?adjustment:GData.adjustment ->
      ?digits:int ->
      ?update_policy:[ALWAYS IF_VALID] ->
      ?numeric:bool ->
      ?wrap:bool ->
      ?shadow_type:Tags.shadow_type -> ?snap_to_ticks:bool -> unit
    method set_value : float -> unit
  end
class spin_button_wrapper : Gtk.spin_button obj -> spin_button

class combo :
  ?popdown_strings:string list ->
  ?use_arrows:bool ->
  ?use_arrows_always:bool ->
  ?case_sensitive:bool ->
  ?value_in_list:bool ->
  ?ok_if_empty:bool ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(combo -> unit) -> ?show:bool ->
  object
    inherit GContainer.container_wrapper
    val obj : Gtk.combo obj
    method disable_activate : unit -> unit
    method entry : entry
    method set_combo :
      ?popdown_strings:string list ->
      ?use_arrows:bool ->
      ?use_arrows_always:bool ->
      ?case_sensitive:bool ->
      ?value_in_list:bool -> ?ok_if_empty:bool -> unit
  end
class combo_wrapper : Gtk.combo obj -> combo

class text :
  ?hadjustment:GData.adjustment ->
  ?vadjustment:GData.adjustment ->
  ?editable:bool ->
  ?word_wrap:bool ->
  ?width:int -> ?height:int ->
  ?packing:(text -> unit) -> ?show:bool ->
  object
    inherit editable
    val obj : Gtk.text obj
    method add_events : Gdk.Tags.event_mask list -> unit
    method insert :
      string -> ?font:Gdk.font ->
      ?foreground:GdkObj.color -> ?background:GdkObj.color -> unit
    method length : int
    method point : int
    method hadjustment : GData.adjustment
    method vadjustment : GData.adjustment
    method set_text :
      ?hadjustment:GData.adjustment ->
      ?vadjustment:GData.adjustment -> ?word_wrap:bool -> unit
    method set_point : int -> unit
    method freeze : unit -> unit
    method thaw : unit -> unit
  end
class text_wrapper : Gtk.text obj -> text

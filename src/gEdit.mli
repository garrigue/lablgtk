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
    method delete_text : start:int -> end:int -> unit
    method get_chars : start:int -> end:int -> string
    method insert_text : string -> ?pos:int -> int
    method paste_clipboard : unit -> unit
    method select_region : start:int -> end:int -> unit
  end

class entry :
  ?max_length:int ->
  ?text:string ->
  ?position:int ->
  ?visibility:bool ->
  ?editable:bool ->
  ?packing:(entry -> unit) -> ?show:bool ->
  object
    inherit editable
    val obj : Gtk.entry obj
    method append_text : string -> unit
    method prepend_text : string -> unit
    method set_editable : bool -> unit
    method set_max_length : int -> unit
    method set_position : int -> unit
    method set_text : string -> unit
    method set_visibility : bool -> unit
    method text : string
    method text_length : int
  end
class entry_wrapper : ([> entry]) obj -> entry

class spin_button :
  rate:float ->
  digits:int ->
  ?adjustment:GData.adjustment ->
  ?value:float ->
  ?update_policy:Tags.update_policy ->
  ?numeric:bool ->
  ?wrap:bool ->
  ?shadow_type:Tags.shadow_type ->
  ?snap_to_ticks:bool ->
  ?packing:(spin_button -> unit) -> ?show:bool ->
  object
    inherit entry
    val obj : Gtk.spin_button obj
    method get_adjustment : GData.adjustment
    method get_value : float
    method get_value_as_int : float
    method spin : [DOWN UP] -> step:float -> unit
    method update : unit
    method set :
      ?adjustment:GData.adjustment ->
      ?digits:int ->
      ?value:float ->
      ?update_policy:Tags.update_policy ->
      ?numeric:bool ->
      ?wrap:bool ->
      ?shadow_type:Tags.shadow_type -> ?snap_to_ticks:bool -> unit
  end
class spin_button_wrapper : Gtk.spin_button obj -> spin_button

class combo :
  ?popdown_strings:string list ->
  ?use_arrows:bool ->
  ?use_arrows_always:bool ->
  ?case_sensitive:bool ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(combo -> unit) -> ?show:bool ->
  object
    inherit GPack.box
    val obj : Gtk.combo obj
    method disable_activate : unit -> unit
    method entry : entry
    method set_case_sensitive : bool -> unit
    method set_popdown_strings : string list -> unit
    method set_use_arrows : bool -> unit
    method set_use_arrows_always : bool -> unit
    method set_value_in_list : bool -> ok_if_empty:bool -> unit
  end
class combo_wrapper : Gtk.combo obj -> combo

class text :
  ?hadjustment:[> adjustment] obj ->
  ?vadjustment:[> adjustment] obj ->
  ?editable:bool ->
  ?word_wrap:bool ->
  ?point:int ->
  ?packing:(text -> unit) -> ?show:bool ->
  object
    inherit editable
    val obj : Gtk.text obj
    method freeze : unit -> unit
    method insert :
      ?font:Gdk.font ->
      ?foreground:Gdk.Color.t -> ?background:Gdk.Color.t -> string -> unit
    method length : int
    method point : int
    method set_adjustment :
      ?horizontal:GData.adjustment -> ?vertical:GData.adjustment -> unit
    method set_editable : bool -> unit
    method set_point : int -> unit
    method set_word_wrap : bool -> unit
    method thaw : unit -> unit
  end
class text_wrapper : Gtk.text obj -> text

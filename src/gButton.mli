(* $Id$ *)

open Gtk

class button_skel :
  'a[> button container widget] obj ->
  object
    inherit GContainer.container
    val obj : 'a obj
    method clicked : unit -> unit
    method grab_default : unit -> unit
  end

class button_signals :
  'a[> button container widget] obj -> ?after:bool ->
  object
    inherit GContainer.container_signals
    val obj : 'a obj
    method clicked : callback:(unit -> unit) -> GtkSignal.id
    method enter : callback:(unit -> unit) -> GtkSignal.id
    method leave : callback:(unit -> unit) -> GtkSignal.id
    method pressed : callback:(unit -> unit) -> GtkSignal.id
    method released : callback:(unit -> unit) -> GtkSignal.id
  end

class button :
  ?label:string ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(button -> unit) -> ?show:bool ->
  object
    inherit button_skel
    val obj : Gtk.button obj
    method connect : ?after:bool -> button_signals
    method add_events : Gdk.Tags.event_mask list -> unit
  end
class button_wrapper : ([> button] obj) -> button

class toggle_button_signals :
  'a[> button container toggle widget] obj -> ?after:bool ->
  object
    inherit button_signals
    val obj : 'a obj
    method toggled : callback:(unit -> unit) -> GtkSignal.id
  end

class toggle_button :
  ?label:string ->
  ?active:bool ->
  ?draw_indicator:bool ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(toggle_button -> unit) -> ?show:bool ->
  object
    inherit button_skel
    val obj : Gtk.toggle_button obj
    method active : bool
    method connect : ?after:bool -> toggle_button_signals
    method set_toggle : ?active:bool -> ?draw_indicator:bool -> unit
  end
class toggle_button_wrapper : ([> toggle] obj) -> toggle_button

class check_button :
  ?label:string ->
  ?active:bool ->
  ?draw_indicator:bool ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(toggle_button -> unit) -> ?show:bool -> toggle_button

class radio_button :
  ?group:group ->
  ?label:string ->
  ?active:bool ->
  ?draw_indicator:bool ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(radio_button -> unit) -> ?show:bool ->
  object
    inherit button_skel
    val obj : Gtk.radio_button obj
    method active : bool
    method connect : ?after:bool -> toggle_button_signals
    method group : group
    method set_group : group -> unit
    method set_toggle : ?active:bool -> ?draw_indicator:bool -> unit
  end
class radio_button_wrapper : Gtk.radio_button obj -> radio_button

class toolbar :
  ?orientation:Tags.orientation ->
  ?style:Tags.toolbar_style ->
  ?space_size:int ->
  ?space_style:[EMPTY LINE] ->
  ?tooltips:bool ->
  ?button_relief:Tags.relief_type ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(toolbar -> unit) -> ?show:bool ->
  object
    inherit GContainer.container_wrapper
    val obj : Gtk.toolbar obj
    method get_button_relief : Tags.relief_type
    method insert_button :
      ?icon:#GObj.is_widget ->
      ?text:string ->
      ?tooltip:string ->
      ?tooltip_private:string ->
      ?pos:int -> ?callback:(unit -> unit) -> button
    method insert_radio_button :
      ?icon:#GObj.is_widget ->
      ?text:string ->
      ?tooltip:string ->
      ?tooltip_private:string ->
      ?pos:int -> ?callback:(unit -> unit) -> radio_button
    method insert_space : ?pos:int -> unit
    method insert_toggle_button :
      ?icon:#GObj.is_widget ->
      ?text:string ->
      ?tooltip:string ->
      ?tooltip_private:string ->
      ?pos:int -> ?callback:(unit -> unit) -> toggle_button
    method insert_widget :
      #GObj.is_widget ->
      ?tooltip:string -> ?tooltip_private:string -> ?pos:int -> unit
    method set_button_relief : Tags.relief_type -> unit
    method set_orientation : Tags.orientation -> unit
    method set_space_size : int -> unit
    method set_space_style : [EMPTY LINE] -> unit
    method set_style : Tags.toolbar_style -> unit
    method set_tooltips : bool -> unit
  end
class toolbar_wrapper : Gtk.toolbar obj -> toolbar

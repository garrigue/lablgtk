(* $Id$ *)

open Gtk
open GObj
open GContainer

class button_skel : 'a obj ->
  object
    inherit container
    constraint 'a = [> button]
    val obj : 'a obj
    method clicked : unit -> unit
    method set_relief : Tags.relief_style -> unit
    method relief : Tags.relief_style
    method grab_default : unit -> unit
    method event : event_ops
  end
class button_signals : 'b obj ->
  object ('a)
    inherit container_signals
    constraint 'b = [> button]
    val obj : 'b obj
    method clicked : callback:(unit -> unit) -> GtkSignal.id
    method enter : callback:(unit -> unit) -> GtkSignal.id
    method leave : callback:(unit -> unit) -> GtkSignal.id
    method pressed : callback:(unit -> unit) -> GtkSignal.id
    method released : callback:(unit -> unit) -> GtkSignal.id
  end

class button : Gtk.button obj ->
  object
    inherit button_skel
    val obj : Gtk.button obj
    method connect : button_signals
  end
val button :
  ?label:string ->
  ?use_mnemonic:bool ->
  ?stock:GtkStock.id ->
  ?relief:Tags.relief_style ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> button

class toggle_button_signals : 'b obj ->
  object ('a)
    inherit button_signals
    constraint 'b = [> toggle_button]
    val obj : 'b obj
    method toggled : callback:(unit -> unit) -> GtkSignal.id
  end

class toggle_button :
  'a obj ->
  object
    inherit button_skel
    constraint 'a = [> Gtk.toggle_button]
    val obj : 'a obj
    method active : bool
    method connect : toggle_button_signals
    method set_active : bool -> unit
    method set_draw_indicator : bool -> unit
  end
val toggle_button :
  ?label:string ->
  ?use_mnemonic:bool ->
  ?stock:GtkStock.id ->
  ?relief:Tags.relief_style ->
  ?active:bool ->
  ?draw_indicator:bool ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> toggle_button
val check_button :
  ?label:string ->
  ?use_mnemonic:bool ->
  ?stock:GtkStock.id ->
  ?relief:Tags.relief_style ->
  ?active:bool ->
  ?draw_indicator:bool ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> toggle_button

class radio_button :
  Gtk.radio_button obj ->
  object
    inherit toggle_button
    val obj : Gtk.radio_button obj
    method group : Gtk.radio_button group
    method set_group : Gtk.radio_button group -> unit
  end
val radio_button :
  ?group:Gtk.radio_button group ->
  ?label:string ->
  ?use_mnemonic:bool ->
  ?stock:GtkStock.id ->
  ?relief:Tags.relief_style ->
  ?active:bool ->
  ?draw_indicator:bool ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> radio_button

class toolbar :
  Gtk.toolbar obj ->
  object
    inherit container_full
    val obj : Gtk.toolbar obj
    method insert_button :
      ?text:string ->
      ?tooltip:string ->
      ?tooltip_private:string ->
      ?icon:widget ->
      ?pos:int -> ?callback:(unit -> unit) -> unit -> button
    method insert_radio_button :
      ?text:string ->
      ?tooltip:string ->
      ?tooltip_private:string ->
      ?icon:widget ->
      ?pos:int -> ?callback:(unit -> unit) -> unit -> radio_button
    method insert_space : ?pos:int -> unit -> unit
    method insert_toggle_button :
      ?text:string ->
      ?tooltip:string ->
      ?tooltip_private:string ->
      ?icon:widget ->
      ?pos:int -> ?callback:(unit -> unit) -> unit -> toggle_button
    method insert_widget :
      ?tooltip:string ->
      ?tooltip_private:string -> ?pos:int -> widget -> unit
    method set_orientation : Tags.orientation -> unit
    method set_style : Tags.toolbar_style -> unit
    method set_tooltips : bool -> unit
  end
val toolbar :
  ?orientation:Tags.orientation ->
  ?style:Tags.toolbar_style ->
  ?tooltips:bool ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> toolbar

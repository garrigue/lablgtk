(* $Id$ *)

open Gtk
open GObj
open GContainer

(** A widget that creates a signal when clicked on *)

(** {3 GtkButton} *)

(** @gtkdoc gtk GtkButton *)
class button_skel : 'a obj ->
  object
    inherit GContainer.container
    constraint 'a = [> button]
    val obj : 'a obj
    method clicked : unit -> unit
    method set_relief : Tags.relief_style -> unit
    method relief : Tags.relief_style
    method set_label : string -> unit
    method label : string
    method grab_default : unit -> unit
    method event : event_ops
  end

(** @gtkdoc gtk GtkButton *)
class button_signals : 'b obj ->
  object ('a)
    inherit GContainer.container_signals
    constraint 'b = [> button]
    val obj : 'b obj
    method clicked : callback:(unit -> unit) -> GtkSignal.id
    method enter : callback:(unit -> unit) -> GtkSignal.id
    method leave : callback:(unit -> unit) -> GtkSignal.id
    method pressed : callback:(unit -> unit) -> GtkSignal.id
    method released : callback:(unit -> unit) -> GtkSignal.id
  end

(** A widget that creates a signal when clicked on
   @gtkdoc gtk GtkButton *)
class button : Gtk.button obj ->
  object
    inherit button_skel
    val obj : Gtk.button obj
    method connect : button_signals
  end

(** @gtkdoc gtk GtkButton *)
val button :
  ?label:string ->
  ?use_mnemonic:bool ->
  ?stock:GtkStock.id ->
  ?relief:Tags.relief_style ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> button

(** {4 GtkToggleButton & GtkRadioButton} *)

(** @gtkdoc gtk GtkToggleButton *)
class toggle_button_signals : 'b obj ->
  object ('a)
    inherit button_signals
    constraint 'b = [> toggle_button]
    val obj : 'b obj
    method toggled : callback:(unit -> unit) -> GtkSignal.id
  end

(** Create buttons which retain their state
   @gtkdoc gtk GtkToggleButton *)
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

(** @gtkdoc gtk GtkToggleButton *)
val toggle_button :
  ?label:string ->
  ?use_mnemonic:bool ->
  ?stock:GtkStock.id ->
  ?relief:Tags.relief_style ->
  ?active:bool ->
  ?draw_indicator:bool ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> toggle_button

(** @gtkdoc gtk GtkCheckButton *)
val check_button :
  ?label:string ->
  ?use_mnemonic:bool ->
  ?stock:GtkStock.id ->
  ?relief:Tags.relief_style ->
  ?active:bool ->
  ?draw_indicator:bool ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> toggle_button

(** A choice from multiple check buttons
   @gtkdoc gtk GtkRadioButton *)
class radio_button :
  Gtk.radio_button obj ->
  object
    inherit toggle_button
    val obj : Gtk.radio_button obj
    method group : Gtk.radio_button group
    method set_group : Gtk.radio_button group -> unit
  end

(** @gtkdoc gtk GtkRadioButton *)
val radio_button :
  ?group:Gtk.radio_button group ->
  ?label:string ->
  ?use_mnemonic:bool ->
  ?stock:GtkStock.id ->
  ?relief:Tags.relief_style ->
  ?active:bool ->
  ?draw_indicator:bool ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> radio_button

(** {3 GtkToolbar} *)

(** Create bars of buttons and other widgets 
   @gtkdoc gtk GtkToolbar *)
class toolbar :
  Gtk.toolbar obj ->
  object
    inherit GContainer.container_full
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

(** @gtkdoc gtk GtkToolbar *)
val toolbar :
  ?orientation:Tags.orientation ->
  ?style:Tags.toolbar_style ->
  ?tooltips:bool ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> toolbar

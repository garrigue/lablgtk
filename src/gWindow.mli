(* $Id$ *)

open Gtk
open GObj

class ['a] window_skel : 'b obj ->
  object
    inherit GContainer.container
    constraint 'a = 'a #window_skel
    constraint 'b = [> window]
    val obj : 'b obj
    method activate_default : unit -> unit
    method activate_focus : unit -> unit
    method add_accel_group : accel_group -> unit
    method event : event_ops
    method as_window : Gtk.window obj
    method set_allow_grow : bool -> unit
    method set_allow_shrink : bool -> unit
    method set_default_size : width:int -> height:int -> unit
    method resize : width:int -> height:int -> unit
    method set_modal : bool -> unit
    method set_position : Tags.window_position -> unit
    method set_resize_mode : Tags.resize_mode -> unit
    method set_title : string -> unit
    method set_transient_for : 'a -> unit
    method set_wm_class : string -> unit
    method set_wm_name : string -> unit
    method show : unit -> unit
    method present : unit -> unit
  end

class window : Gtk.window obj ->
  object
    inherit [window] window_skel
    val obj : Gtk.window obj
    method connect : GContainer.container_signals
  end
val window :
  ?kind:Tags.window_type ->
  ?title:string ->
  ?wm_name:string ->
  ?wm_class:string ->
  ?position:Tags.window_position ->
  ?allow_shrink:bool ->
  ?allow_grow:bool ->
  ?modal:bool ->
  ?x:int ->
  ?y:int ->
  ?border_width:int ->
  ?width:int -> ?height:int -> ?show:bool -> unit -> window

val toplevel : #widget -> window option
(** return the toplevel window of this widget, if existing *)

class dialog : Gtk.dialog obj ->
  object
    inherit [window] window_skel
    val obj : Gtk.dialog obj
    method action_area : GPack.box
    method connect : GContainer.container_signals
    method event : event_ops
    method vbox : GPack.box
  end
val dialog :
  ?title:string ->
  ?wm_name:string ->
  ?wm_class:string ->
  ?position:Tags.window_position ->
  ?allow_shrink:bool ->
  ?allow_grow:bool ->
  ?modal:bool ->
  ?x:int ->
  ?y:int ->
  ?border_width:int ->
  ?width:int -> ?height:int -> ?show:bool -> unit -> dialog

class color_selection_dialog : Gtk.color_selection_dialog obj ->
  object
    inherit [window] window_skel
    val obj : Gtk.color_selection_dialog obj
    method cancel_button : GButton.button
    method colorsel : GMisc.color_selection
    method connect : GContainer.container_signals
    method help_button : GButton.button
    method ok_button : GButton.button
  end
val color_selection_dialog :
  ?title:string ->
  ?wm_name:string ->
  ?wm_class:string ->
  ?position:Tags.window_position ->
  ?allow_shrink:bool ->
  ?allow_grow:bool ->
  ?modal:bool ->
  ?x:int ->
  ?y:int ->
  ?border_width:int ->
  ?width:int -> ?height:int -> ?show:bool -> unit -> color_selection_dialog

class file_selection : Gtk.file_selection obj ->
  object
    inherit [window] window_skel
    val obj : Gtk.file_selection obj
    method cancel_button : GButton.button
    method complete : filter:string -> unit
    method connect : GContainer.container_signals
    method get_filename : string
    method help_button : GButton.button
    method ok_button : GButton.button
    method file_list : string GList.clist
    method set_filename : string -> unit
    method set_fileop_buttons : bool -> unit
  end
val file_selection :
  ?title:string ->
  ?filename:string ->
  ?fileop_buttons:bool ->
  ?wm_name:string ->
  ?wm_class:string ->
  ?position:Tags.window_position ->
  ?allow_shrink:bool ->
  ?allow_grow:bool ->
  ?modal:bool ->
  ?x:int ->
  ?y:int ->
  ?border_width:int ->
  ?width:int -> ?height:int -> ?show:bool -> unit -> file_selection

class font_selection_dialog : Gtk.font_selection_dialog obj ->
  object
    inherit [window] window_skel
    val obj : Gtk.font_selection_dialog obj
    method apply_button : GButton.button
    method cancel_button : GButton.button
    method connect : GContainer.container_signals
    method selection : GMisc.font_selection
    method ok_button : GButton.button
  end
val font_selection_dialog :
  ?title:string ->
  ?wm_name:string ->
  ?wm_class:string ->
  ?position:Tags.window_position ->
  ?allow_shrink:bool ->
  ?allow_grow:bool ->
  ?modal:bool ->
  ?x:int ->
  ?y:int ->
  ?border_width:int ->
  ?width:int -> ?height:int -> ?show:bool -> unit -> font_selection_dialog

class plug : Gtk.plug obj -> window

val plug :
  window:Gdk.xid ->
  ?border_width:int ->
  ?width:int -> ?height:int -> ?show:bool -> unit -> plug

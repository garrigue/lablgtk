(* $Id$ *)

open Gtk
open GObj

class ['a] window_skel : 'b obj ->
  object
    inherit GContainer.container
    constraint 'a = 'a #window_skel
    constraint 'b = [> window]
    val obj : 'b obj
    method activate_default : unit -> bool
    method activate_focus : unit -> bool
    method add_accel_group : accel_group -> unit
    method event : event_ops
    method as_window : Gtk.window obj
    method set_default_size : width:int -> height:int -> unit
    method resize : width:int -> height:int -> unit
    method set_allow_shrink : bool -> unit
    method set_allow_grow : bool -> unit
    method set_modal : bool -> unit
    method set_position : Tags.window_position -> unit
    method set_resizable : bool -> unit
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
  ?icon:GdkPixbuf.pixbuf ->
  ?screen:Gdk.screen ->
  ?position:Gtk.Tags.window_position ->
  ?allow_grow:bool ->
  ?allow_shrink:bool ->
  ?resizable:bool ->
  ?modal:bool ->
  ?x:int ->
  ?y:int ->
  ?border_width:int ->
  ?width:int -> ?height:int -> ?show:bool -> unit -> window

val toplevel : #widget -> window option
(** return the toplevel window of this widget, if existing *)

class ['a] dialog_signals : Gtk.dialog obj -> (int * 'a) list ref ->
  object
    inherit GContainer.container_signals
    val obj : Gtk.dialog obj
    method response : callback:('a -> unit) -> GtkSignal.id
    method close : callback:(unit -> unit) -> GtkSignal.id
  end
class ['a] dialog : Gtk.dialog obj ->
  object
    constraint 'a = [> `DELETE_EVENT | `NONE]
    inherit [window] window_skel
    val obj : Gtk.dialog obj
    method action_area : GPack.box
    method connect : 'a dialog_signals
    method event : event_ops
    method vbox : GPack.box
    method add_button : string -> 'a -> unit
    method add_button_stock : GtkStock.id -> 'a -> unit
    method response : 'a -> unit
    method set_response_sensitive : 'a -> bool -> unit
    method set_default_response : 'a -> unit
    method get_has_separator : bool
    method set_has_separator : bool -> unit
    method run : unit -> 'a
  end
val dialog :
  ?parent:#window ->
  ?destroy_with_parent:bool ->
  ?no_separator:bool ->
  ?title:string ->
  ?wm_name:string ->
  ?wm_class:string ->
  ?icon:GdkPixbuf.pixbuf ->
  ?screen:Gdk.screen ->
  ?position:Gtk.Tags.window_position ->
  ?allow_grow:bool ->
  ?allow_shrink:bool ->
  ?resizable:bool ->
  ?modal:bool ->
  ?x:int ->
  ?y:int ->
  ?border_width:int ->
  ?width:int -> ?height:int -> ?show:bool -> unit -> 'a dialog

type 'a buttons
module Buttons : sig
val none : [>`NONE] buttons
val ok : [>`OK] buttons
val close : [>`CLOSE] buttons
val yes_no : [>`YES|`NO] buttons
val ok_cancel : [>`OK|`CANCEL] buttons
end
val message_dialog :
  ?message:string ->
  message_type:Gtk.Tags.message_type ->
  buttons:'a buttons ->
  ?parent:#window ->
  ?destroy_with_parent:bool ->
  ?no_separator:bool ->
  ?title:string ->
  ?wm_name:string ->
  ?wm_class:string ->
  ?icon:GdkPixbuf.pixbuf ->
  ?screen:Gdk.screen ->
  ?position:Gtk.Tags.window_position ->
  ?allow_grow:bool ->
  ?allow_shrink:bool ->
  ?resizable:bool ->
  ?modal:bool ->
  ?x:int ->
  ?y:int ->
  ?border_width:int ->
  ?width:int -> ?height:int -> ?show:bool -> unit -> 'a dialog

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
  ?icon:GdkPixbuf.pixbuf ->
  ?screen:Gdk.screen ->
  ?position:Gtk.Tags.window_position ->
  ?allow_grow:bool ->
  ?allow_shrink:bool ->
  ?resizable:bool ->
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
    method get_selections : string list
    method help_button : GButton.button
    method ok_button : GButton.button
    method file_list : string GList.clist
    method select_multiple : bool
    method set_filename : string -> unit
    method set_fileop_buttons : bool -> unit
    method set_select_multiple : bool -> unit
  end
val file_selection :
  ?title:string ->
  ?filename:string ->
  ?fileop_buttons:bool ->
  ?select_multiple:bool ->
  ?wm_name:string ->
  ?wm_class:string ->
  ?icon:GdkPixbuf.pixbuf ->
  ?screen:Gdk.screen ->
  ?position:Gtk.Tags.window_position ->
  ?allow_grow:bool ->
  ?allow_shrink:bool ->
  ?resizable:bool ->
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
  ?icon:GdkPixbuf.pixbuf ->
  ?screen:Gdk.screen ->
  ?position:Gtk.Tags.window_position ->
  ?allow_grow:bool ->
  ?allow_shrink:bool ->
  ?resizable:bool ->
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

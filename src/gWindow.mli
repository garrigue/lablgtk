(* $Id$ *)

open Gtk
open GObj

(** Windows *)

(** {3 GtkWindow} *)

(** @gtkdoc gtk GtkWindow *)
class ['a] window_skel : 'b obj ->
  object
    inherit GContainer.bin
    constraint 'a = 'a #window_skel
    constraint 'b = [> window]
    val obj : 'b obj
    method activate_default : unit -> bool
    method activate_focus : unit -> bool
    method add_accel_group : accel_group -> unit
    method as_window : Gtk.window obj
    method event : event_ops
    method deiconify : unit -> unit
    method iconify : unit -> unit
    method move : x:int -> y:int -> unit
    method parse_geometry : string -> bool
    method present : unit -> unit
    method resize : width:int -> height:int -> unit
    method show : unit -> unit
    method set_allow_grow : bool -> unit
    method set_allow_shrink : bool -> unit
    method set_default_height : int -> unit
    method set_default_size : width:int -> height:int -> unit
    method set_default_width : int -> unit
    method set_destroy_with_parent : bool -> unit
    method set_geometry_hints :
      ?min_size:int * int ->
      ?max_size:int * int ->
      ?base_size:int * int ->
      ?aspect:float * float ->
      ?resize_inc:int * int ->
      ?win_gravity:Gdk.Tags.gravity ->
      ?pos:bool -> ?user_pos:bool -> ?user_size:bool -> GObj.widget -> unit
    method set_gravity : Gdk.Tags.gravity -> unit
    method set_icon : GdkPixbuf.pixbuf option -> unit
    method set_modal : bool -> unit
    method set_position : Tags.window_position -> unit
    method set_resizable : bool -> unit
    method set_screen : Gdk.screen -> unit
    method set_skip_pager_hint : bool -> unit
    method set_skip_taskbar_hint : bool -> unit
    method set_title : string -> unit
    method set_transient_for : 'a -> unit
    method set_type_hint : Gdk.Tags.window_type_hint -> unit
    method set_wm_class : string -> unit
    method set_wm_name : string -> unit
    method allow_grow : bool
    method allow_shrink : bool
    method default_height : int
    method default_width : int
    method destroy_with_parent : bool
    method has_toplevel_focus : bool
    method icon : GdkPixbuf.pixbuf option
    method is_active : bool
    method kind : Tags.window_type
    method modal : bool
    method position : Tags.window_position
    method resizable : bool
    method screen : Gdk.screen
    method skip_pager_hint : bool
    method skip_taskbar_hint : bool
    method title : string
    method type_hint : Gdk.Tags.window_type_hint
  end

(** Toplevel widget which can contain other widgets
   @gtkdoc gtk GtkWindow *)
class window : Gtk.window obj ->
  object
    inherit [window] window_skel
    val obj : Gtk.window obj
    method connect : GContainer.container_signals
    method fullscreen : unit -> unit
    method maximize : unit -> unit
    method stick : unit -> unit
    method unfullscreen : unit -> unit
    method unmaximize : unit -> unit
    method unstick : unit -> unit
  end

(** @gtkdoc gtk GtkWindow *)
val window :
  ?kind:Tags.window_type ->
  ?title:string ->
  ?allow_grow:bool ->
  ?allow_shrink:bool ->
  ?icon:GdkPixbuf.pixbuf ->
  ?modal:bool ->
  ?resizable:bool ->
  ?screen:Gdk.screen ->
  ?type_hint:Gdk.Tags.window_type_hint ->
  ?position:Tags.window_position ->
  ?wm_name:string ->
  ?wm_class:string ->
  ?border_width:int ->
  ?width:int -> ?height:int -> ?show:bool -> unit -> window

val toplevel : #widget -> window option
(** return the toplevel window of this widget, if existing *)

(** {3 GtkDialog} *)

(** @gtkdoc gtk GtkDialog *)
class ['a] dialog_signals :
  ([> Gtk.dialog] as 'b) obj -> (int * 'a) list ref ->
  object
    inherit GContainer.container_signals
    val obj : 'b obj
    method response : callback:('a -> unit) -> GtkSignal.id
    method close : callback:(unit -> unit) -> GtkSignal.id
  end

(** @gtkdoc gtk GtkDialog *)
class ['a] dialog_skel : ([>Gtk.dialog] as 'b) obj ->
  object
    constraint 'a = [> `DELETE_EVENT]
    inherit [window] window_skel
    val obj : 'b obj
    method action_area : GPack.box
    method connect : 'a dialog_signals
    method event : event_ops
    method vbox : GPack.box
    method response : 'a -> unit
    method set_response_sensitive : 'a -> bool -> unit
    method set_default_response : 'a -> unit
    method has_separator : bool
    method set_has_separator : bool -> unit
    method run : unit -> 'a
  end

(** Create popup windows
   @gtkdoc gtk GtkDialog *)
class ['a] dialog : [>Gtk.dialog] obj ->
  object
    inherit ['a] dialog_skel
    method add_button : string -> 'a -> unit
    method add_button_stock : GtkStock.id -> 'a -> unit
  end

(** @gtkdoc gtk GtkDialog *)
val dialog :
  ?no_separator:bool ->
  ?parent:#window ->
  ?destroy_with_parent:bool ->
  ?title:string ->
  ?allow_grow:bool ->
  ?allow_shrink:bool ->
  ?icon:GdkPixbuf.pixbuf ->
  ?modal:bool ->
  ?resizable:bool ->
  ?screen:Gdk.screen ->
  ?type_hint:Gdk.Tags.window_type_hint ->
  ?position:Tags.window_position ->
  ?wm_name:string ->
  ?wm_class:string ->
  ?border_width:int ->
  ?width:int -> ?height:int -> ?show:bool -> unit -> 'a dialog

(** {3 GtkMessageDialog} *)

type 'a buttons
module Buttons : sig
val ok : [>`OK] buttons
val close : [>`CLOSE] buttons
val yes_no : [>`YES|`NO] buttons
val ok_cancel : [>`OK|`CANCEL] buttons
type color_selection = [`OK | `CANCEL | `HELP | `DELETE_EVENT]
type file_selection = [`OK | `CANCEL | `HELP | `DELETE_EVENT]
type font_selection = [`OK | `CANCEL | `APPLY | `DELETE_EVENT]
end

(** Convenient message window
   @gtkdoc gtk GtkMessageDialog *)
class type ['a] message_dialog =
  object
    inherit ['a] dialog_skel
    val obj : [> Gtk.message_dialog] obj
    method message_type : Tags.message_type
    method set_message_type : Tags.message_type -> unit
  end

(** @gtkdoc gtk GtkMessageDialog *)
val message_dialog :
  ?message:string ->
  message_type:Tags.message_type ->
  buttons:'a buttons ->
  ?parent:#window ->
  ?destroy_with_parent:bool ->
  ?title:string ->
  ?allow_grow:bool ->
  ?allow_shrink:bool ->
  ?icon:GdkPixbuf.pixbuf ->
  ?modal:bool ->
  ?resizable:bool ->
  ?screen:Gdk.screen ->
  ?type_hint:Gdk.Tags.window_type_hint ->
  ?position:Tags.window_position ->
  ?wm_name:string ->
  ?wm_class:string ->
  ?border_width:int ->
  ?width:int -> ?height:int -> ?show:bool -> unit -> 'a message_dialog

(** {3 Selection Dialogs} *)

(** @gtkdoc gtk GtkColorSelectionDialog *)
class color_selection_dialog : Gtk.color_selection_dialog obj ->
  object
    inherit [Buttons.color_selection] dialog_skel
    val obj : Gtk.color_selection_dialog obj
    method cancel_button : GButton.button
    method colorsel : GMisc.color_selection
    method help_button : GButton.button
    method ok_button : GButton.button
  end

(** @gtkdoc gtk GtkColorSelectionDialog *)
val color_selection_dialog :
  ?title:string ->
  ?parent:#window ->
  ?destroy_with_parent:bool ->
  ?allow_grow:bool ->
  ?allow_shrink:bool ->
  ?icon:GdkPixbuf.pixbuf ->
  ?modal:bool ->
  ?screen:Gdk.screen ->
  ?type_hint:Gdk.Tags.window_type_hint ->
  ?position:Tags.window_position ->
  ?wm_name:string ->
  ?wm_class:string ->
  ?border_width:int ->
  ?width:int -> ?height:int -> ?show:bool -> unit -> color_selection_dialog


(** @gtkdoc gtk GtkFileSelection *)
class file_selection : Gtk.file_selection obj ->
  object
    inherit [Buttons.file_selection] dialog_skel
    val obj : Gtk.file_selection obj
    method cancel_button : GButton.button
    method complete : filter:string -> unit
    method filename : string
    method get_selections : string list
    method help_button : GButton.button
    method ok_button : GButton.button
    method file_list : string GList.clist
    method select_multiple : bool
    method show_fileops : bool
    method set_filename : string -> unit
    method set_show_fileops : bool -> unit
    method set_select_multiple : bool -> unit
  end

(** @gtkdoc gtk GtkFileSelection *)
val file_selection :
  ?title:string ->
  ?show_fileops:bool ->
  ?filename:string ->
  ?select_multiple:bool ->
  ?parent:#window ->
  ?destroy_with_parent:bool ->
  ?allow_grow:bool ->
  ?allow_shrink:bool ->
  ?icon:GdkPixbuf.pixbuf ->
  ?modal:bool ->
  ?resizable:bool ->
  ?screen:Gdk.screen ->
  ?type_hint:Gdk.Tags.window_type_hint ->
  ?position:Tags.window_position ->
  ?wm_name:string ->
  ?wm_class:string ->
  ?border_width:int ->
  ?width:int -> ?height:int -> ?show:bool -> unit -> file_selection

(** @gtkdoc gtk GtkFontSelectionDialog*)
class font_selection_dialog : Gtk.font_selection_dialog obj ->
  object
    inherit [Buttons.font_selection] dialog_skel
    val obj : Gtk.font_selection_dialog obj
    method apply_button : GButton.button
    method cancel_button : GButton.button
    method selection : GMisc.font_selection
    method ok_button : GButton.button
  end

(** @gtkdoc gtk GtkFontSelectionDialog*)
val font_selection_dialog :
  ?title:string ->
  ?parent:#window ->
  ?destroy_with_parent:bool ->
  ?allow_grow:bool ->
  ?allow_shrink:bool ->
  ?icon:GdkPixbuf.pixbuf ->
  ?modal:bool ->
  ?resizable:bool ->
  ?screen:Gdk.screen ->
  ?type_hint:Gdk.Tags.window_type_hint ->
  ?position:Tags.window_position ->
  ?wm_name:string ->
  ?wm_class:string ->
  ?border_width:int ->
  ?width:int -> ?height:int -> ?show:bool -> unit -> font_selection_dialog

(** {3 GtkPlug} *)

(** Toplevel for embedding into other processes 
   @gtkdoc gtk GtkPlug *)
class plug : Gtk.plug obj -> window

(** @gtkdoc gtk GtkPlug *)
val plug :
  window:Gdk.xid ->
  ?border_width:int ->
  ?width:int -> ?height:int -> ?show:bool -> unit -> plug

(* $Id$ *)

open Misc
open Gtk
open Tags
open GtkBase

module Window = struct
  let cast w : window obj =
    if Object.is_a w "GtkWindow" then Obj.magic w
    else invalid_arg "Gtk.Window.cast"
  external coerce : [> window] obj -> window obj = "%identity"
  external create : window_type -> window obj = "ml_gtk_window_new"
  external set_title : [> window] obj -> string -> unit
      = "ml_gtk_window_set_title"
  external set_wmclass : [> window] obj -> name:string -> class:string -> unit
      = "ml_gtk_window_set_title"
  external get_wmclass_name : [> window] obj -> string
      = "ml_gtk_window_get_wmclass_name"
  external get_wmclass_class : [> window] obj -> string
      = "ml_gtk_window_get_wmclass_class"
  (* set_focus/default are called by Widget.grab_focus/default *)
  external set_focus : [> window] obj -> [> widget] obj -> unit
      = "ml_gtk_window_set_focus"
  external set_default : [> window] obj -> [> widget] obj -> unit
      = "ml_gtk_window_set_default"
  external set_policy :
      [> window] obj ->
      allow_shrink:bool -> allow_grow:bool -> auto_shrink:bool -> unit
      = "ml_gtk_window_set_policy"
  external get_allow_shrink : [> window] obj -> bool
      = "ml_gtk_window_get_allow_shrink"
  external get_allow_grow : [> window] obj -> bool
      = "ml_gtk_window_get_allow_grow"
  external get_auto_shrink : [> window] obj -> bool
      = "ml_gtk_window_get_auto_shrink"
  external activate_focus : [> window] obj -> bool
      = "ml_gtk_window_activate_focus"
  external activate_default : [> window] obj -> bool
      = "ml_gtk_window_activate_default"
  external set_modal : [>window] obj -> bool -> unit
      = "ml_gtk_window_set_modal"
  external set_default_size :
      [> window] obj -> width:int -> height:int -> unit
      = "ml_gtk_window_set_default_size"
  external set_position : [> window] obj -> window_position -> unit
      = "ml_gtk_window_set_position"
  external set_transient_for : [> window] obj ->[> window] obj -> unit
      = "ml_gtk_window_set_transient_for"

  let setter w :cont ?:title ?:wmclass_name ?:wmclass_class ?:position
      ?:allow_shrink ?:allow_grow ?:auto_shrink ?:modal
      ?:x [< -2 >] ?:y [< -2 >] =
    may title fun:(set_title w);
    if wmclass_name <> None || wmclass_class <> None then
      set_wmclass w name:(may_default get_wmclass_name w for:wmclass_name)
	class:(may_default get_wmclass_class w for:wmclass_class);
    may position fun:(set_position w);
    if allow_shrink <> None || allow_grow <> None || auto_shrink <> None then
      set_policy w
	allow_shrink:(may_default get_allow_shrink w for:allow_shrink)
	allow_grow:(may_default get_allow_grow w for:allow_grow)
	auto_shrink:(may_default get_auto_shrink w for:auto_shrink);
    may fun:(set_modal w) modal;
    if x > -2 || y > -2 then Widget.set_uposition w :x :y;
    cont w
  external add_accel_group : [> window] obj -> accel_group -> unit
      = "ml_gtk_window_add_accel_group"
  external remove_accel_group :
      [> window] obj -> accel_group -> unit
      = "ml_gtk_window_remove_accel_group"
  external activate_focus : [> window] obj -> unit
      = "ml_gtk_window_activate_focus"
  external activate_default : [> window] obj -> unit
      = "ml_gtk_window_activate_default"
  module Signals = struct
    open GtkSignal
    let move_resize : ([> window],_) t =
      { name = "move_resize"; marshaller = marshal_unit }
    let set_focus : ([> window],_) t =
      { name = "set_focus"; marshaller = Widget.Signals.marshal }
  end
end

module Dialog = struct
  let cast w : dialog obj =
    if Object.is_a w "GtkDialog" then Obj.magic w
    else invalid_arg "Gtk.Dialog.cast"
  external coerce : [> dialog] obj -> dialog obj = "%identity"
  external create : unit -> dialog obj = "ml_gtk_dialog_new"
  external action_area : [> dialog] obj -> box obj
      = "ml_GtkDialog_action_area"
  external vbox : [> dialog] obj -> box obj
      = "ml_GtkDialog_vbox"
end

module InputDialog = struct
  let cast w : input_dialog obj =
    if Object.is_a w "GtkInputDialog" then Obj.magic w
    else invalid_arg "Gtk.InputDialog.cast"
  external create : unit -> input_dialog obj = "ml_gtk_input_dialog_new"
  module Signals = struct
    open GtkSignal
    let enable_device : ([> inputdialog],_) t =
      { name = "enable_device"; marshaller = marshal_int }
    let disable_device : ([> inputdialog],_) t =
      { name = "disable_device"; marshaller = marshal_int }
  end
end

module FileSelection = struct
  let cast w : file_selection obj =
    if Object.is_a w "GtkFileSelection" then Obj.magic w
    else invalid_arg "Gtk.FileSelection.cast"
  external create : string -> file_selection obj = "ml_gtk_file_selection_new"
  external set_filename : [> filesel] obj -> string -> unit
      = "ml_gtk_file_selection_set_filename"
  external get_filename : [> filesel] obj -> string
      = "ml_gtk_file_selection_get_filename"
  external show_fileop_buttons : [> filesel] obj -> unit
      = "ml_gtk_file_selection_show_fileop_buttons"
  external hide_fileop_buttons : [> filesel] obj -> unit
      = "ml_gtk_file_selection_hide_fileop_buttons"
  external get_ok_button : [> filesel] obj -> button obj
      = "ml_gtk_file_selection_get_ok_button"
  external get_cancel_button : [> filesel] obj -> button obj
      = "ml_gtk_file_selection_get_cancel_button"
  external get_help_button : [> filesel] obj -> button obj
      = "ml_gtk_file_selection_get_help_button"
  let setter w :cont ?:filename ?:fileop_buttons =
    may filename fun:(set_filename w);
    may fileop_buttons fun:
      (fun b -> (if b then show_fileop_buttons else hide_fileop_buttons) w);
    cont w
end

(* $Id$ *)

open Gaux
open Gtk
open Tags
open GtkBase

module Window = struct
  let cast w : window obj = Object.try_cast w "GtkWindow"
  external create : window_type -> window obj = "ml_gtk_window_new"
  external set_title : [>`window] obj -> string -> unit
      = "ml_gtk_window_set_title"
  external get_title : [>`window] obj -> string
      = "ml_gtk_window_get_title"
  external set_wmclass : [>`window] obj -> name:string -> clas:string -> unit
      = "ml_gtk_window_set_wmclass"
  external get_wmclass_name : [>`window] obj -> string
      = "ml_gtk_window_get_wmclass_name"
  external get_wmclass_class : [>`window] obj -> string
      = "ml_gtk_window_get_wmclass_class"
  external set_role : [>`window] obj -> string -> unit
      = "ml_gtk_window_set_role"
  external get_role : [>`window] obj -> string
      = "ml_gtk_window_get_role"
  (* set_focus/default are called by Widget.grab_focus/default *)
  external set_focus : [>`window] obj -> [>`widget] obj -> unit
      = "ml_gtk_window_set_focus"
  external get_focus : [>`window] obj -> widget obj
      = "ml_gtk_window_get_focus"
  external set_default : [>`window] obj -> [>`widget] obj -> unit
      = "ml_gtk_window_set_default"
  external set_policy :
      [>`window] obj -> allow_shrink:bool -> allow_grow:bool -> unit
      = "ml_gtk_window_set_policy"
  external get_allow_shrink : [>`window] obj -> bool
      = "ml_gtk_window_get_allow_shrink"
  external get_allow_grow : [>`window] obj -> bool
      = "ml_gtk_window_get_allow_grow"
  external activate_focus : [>`window] obj -> bool
      = "ml_gtk_window_activate_focus"
  external activate_default : [>`window] obj -> bool
      = "ml_gtk_window_activate_default"
  external set_modal : [>`window] obj -> bool -> unit
      = "ml_gtk_window_set_modal"
  external set_default_size :
      [>`window] obj -> width:int -> height:int -> unit
      = "ml_gtk_window_set_default_size"
  external set_position : [>`window] obj -> window_position -> unit
      = "ml_gtk_window_set_position"
  external set_transient_for : [>`window] obj ->[>`window] obj -> unit
      = "ml_gtk_window_set_transient_for"
  external get_transient_for : [>`window] obj -> window obj
      = "ml_gtk_window_get_transient_for"

  let set_wmclass ?name ?clas:wm_class w =
    set_wmclass w ~name:(may_default get_wmclass_name w ~opt:name)
      ~clas:(may_default get_wmclass_class w ~opt:wm_class)
  let set_policy ?allow_shrink ?allow_grow w =
    set_policy w
      ~allow_shrink:(may_default get_allow_shrink w ~opt:allow_shrink)
      ~allow_grow:(may_default get_allow_grow w ~opt:allow_grow)
  let set ?title ?wm_name ?wm_class ?role ?position ?allow_shrink ?allow_grow
      ?auto_shrink ?modal ?(x = -2) ?(y = -2) w =
    may title ~f:(set_title w);
    if wm_name <> None || wm_class <> None then
      set_wmclass w ?name:wm_name ?clas:wm_class;
    may role ~f:(set_role w);
    may position ~f:(set_position w);
    if allow_shrink <> None || allow_grow <> None then
      set_policy w ?allow_shrink ?allow_grow;
    may ~f:(set_modal w) modal;
    if x <> -2 || y <> -2 then Widget.set_uposition w ~x ~y
  external add_accel_group : [>`window] obj -> accel_group -> unit
      = "ml_gtk_window_add_accel_group"
  external remove_accel_group :
      [>`window] obj -> accel_group -> unit
      = "ml_gtk_window_remove_accel_group"
  external activate_focus : [>`window] obj -> unit
      = "ml_gtk_window_activate_focus"
  external activate_default : [>`window] obj -> unit
      = "ml_gtk_window_activate_default"
  external present :  [>`window] obj -> unit
      = "ml_gtk_window_present"
  module Signals = struct
    open GtkSignal
    let move_resize =
      { name = "move_resize"; classe = `window; marshaller = marshal_unit }
    let set_focus =
      { name = "set_focus"; classe = `window;
        marshaller = Widget.Signals.marshal_opt }
  end
end

module Dialog = struct
  let cast w : dialog obj = Object.try_cast w "GtkDialog"
  external create : unit -> dialog obj = "ml_gtk_dialog_new"
  external action_area : [>`dialog] obj -> box obj
      = "ml_GtkDialog_action_area"
  external vbox : [>`dialog] obj -> box obj
      = "ml_GtkDialog_vbox"
end

module InputDialog = struct
  let cast w : input_dialog obj = Object.try_cast w "GtkInputDialog"
  external create : unit -> input_dialog obj = "ml_gtk_input_dialog_new"
  module Signals = struct
    open GtkSignal
    let enable_device =
      { name = "enable_device"; classe = `inputdialog;
        marshaller = marshal_int }
    let disable_device =
      { name = "disable_device"; classe = `inputdialog;
        marshaller = marshal_int }
  end
end

module FileSelection = struct
  let cast w : file_selection obj = Object.try_cast w "GtkFileSelection"
  external create : string -> file_selection obj = "ml_gtk_file_selection_new"
  external set_filename : [>`filesel] obj -> string -> unit
      = "ml_gtk_file_selection_set_filename"
  external get_filename : [>`filesel] obj -> string
      = "ml_gtk_file_selection_get_filename"
  external complete : [>`filesel] obj -> filter:string -> unit
      = "ml_gtk_file_selection_complete"
  external show_fileop_buttons : [>`filesel] obj -> unit
      = "ml_gtk_file_selection_show_fileop_buttons"
  external hide_fileop_buttons : [>`filesel] obj -> unit
      = "ml_gtk_file_selection_hide_fileop_buttons"
  external get_ok_button : [>`filesel] obj -> button obj
      = "ml_gtk_file_selection_get_ok_button"
  external get_cancel_button : [>`filesel] obj -> button obj
      = "ml_gtk_file_selection_get_cancel_button"
  external get_help_button : [>`filesel] obj -> button obj
      = "ml_gtk_file_selection_get_help_button"
  external get_file_list : [>`filesel] obj -> clist obj
      = "ml_gtk_file_selection_get_file_list"
  let set_fileop_buttons w = function
      true -> show_fileop_buttons w
    | false -> hide_fileop_buttons w
  let set ?filename ?fileop_buttons w =
    may filename ~f:(set_filename w);
    may fileop_buttons ~f:(set_fileop_buttons w)
end

module FontSelectionDialog = struct
  let cast w : font_selection_dialog obj =
    Object.try_cast w "GtkFontSelectionDialog"
  external create : ?title:string -> unit -> font_selection_dialog obj
      = "ml_gtk_font_selection_dialog_new"
  external font_selection : [>`fontseldialog] obj -> font_selection obj
      = "ml_gtk_font_selection_dialog_fontsel"
  external ok_button : [>`fontseldialog] obj -> button obj
      = "ml_gtk_font_selection_dialog_ok_button"
  external apply_button : [>`fontseldialog] obj -> button obj
      = "ml_gtk_font_selection_dialog_apply_button"
  external cancel_button : [>`fontseldialog] obj -> button obj
      = "ml_gtk_font_selection_dialog_cancel_button"
(*
  type null_terminated
  let null_terminated arg : null_terminated =
    match arg with None -> Obj.magic Gpointer.raw_null
    | Some l ->
	let len = List.length l in
	let arr = Array.create (len + 1) "" in
	let rec loop i = function
	    [] -> arr.(i) <- Obj.magic Gpointer.raw_null
	  | s::l -> arr.(i) <- s; loop (i+1) l
	in loop 0 l;
	Obj.magic (arr : string array)
  external get_font : [>`fontseldialog] obj -> Gdk.font
      = "ml_gtk_font_selection_dialog_get_font"
  let get_font w =
    try Some (get_font w) with Gpointer.Null -> None
  external get_font_name : [>`fontseldialog] obj -> string
      = "ml_gtk_font_selection_dialog_get_font_name"
  let get_font_name w =
    try Some (get_font_name w) with Gpointer.Null -> None
  external set_font_name : [>`fontseldialog] obj -> string -> unit
      = "ml_gtk_font_selection_dialog_set_font_name"
  external set_filter :
    [>`fontseldialog] obj -> font_filter_type -> font_type list ->
    null_terminated -> null_terminated -> null_terminated ->
    null_terminated -> null_terminated -> null_terminated -> unit
    = "ml_gtk_font_selection_dialog_set_filter_bc"
      "ml_gtk_font_selection_dialog_set_filter"
  let set_filter w ?kind:(tl=[`ALL]) ?foundry
      ?weight ?slant ?setwidth ?spacing ?charset filter =
    set_filter w filter tl (null_terminated foundry)
      (null_terminated weight) (null_terminated slant)
      (null_terminated setwidth) (null_terminated spacing)
      (null_terminated charset)
  external get_preview_text : [>`fontseldialog] obj -> string
      = "ml_gtk_font_selection_dialog_get_preview_text"
  external set_preview_text : [>`fontseldialog] obj -> string -> unit
      = "ml_gtk_font_selection_dialog_set_preview_text"
*)
end

module Plug = struct
  let cast w : plug obj = Object.try_cast w "GtkPlug"
  external create : Gdk.xid -> plug obj = "ml_gtk_plug_new"
end

(* $Id$ *)

external _gtkfile_init : unit -> unit = "ml_gtkfile_init"
let () = _gtkfile_init ()

module FileFilter = struct
  external create : unit -> Gtk.file_filter Gtk.obj
      = "ml_gtk_file_filter_new"
  external set_name : [> Gtk.file_filter] Gtk.obj -> string -> unit
      = "ml_gtk_file_filter_set_name"
  external get_name : [> Gtk.file_filter] Gtk.obj -> string
      = "ml_gtk_file_filter_get_name"
  external add_mime_type : [> Gtk.file_filter] Gtk.obj -> string -> unit
      = "ml_gtk_file_filter_add_mime_type"
  external add_pattern : [> Gtk.file_filter] Gtk.obj -> string -> unit
      = "ml_gtk_file_filter_add_pattern"
end

module FileChooser = struct
  include GtkFileProps.FileChooser

  type error =
    | ERROR_NONEXISTENT
    | ERROR_BAD_FILENAME
  exception Error of error * string
  let () = Callback.register_exception 
      "gtk_file_chooser_error" (Error (ERROR_NONEXISTENT, ""))

(*   external set_action : [> Gtk.file_chooser] Gtk.obj -> Gtk.Tags.file_chooser_action -> unit *)
(*       = "ml_gtk_file_chooser_set_action" *)
(*   external get_action : [> Gtk.file_chooser] Gtk.obj -> Gtk.Tags.file_chooser_action *)
(*       = "ml_gtk_file_chooser_get_action" *)
(*   external set_folder_mode : [> Gtk.file_chooser] Gtk.obj -> bool -> unit *)
(*       = "ml_gtk_file_chooser_set_folder_mode" *)
(*   external get_folder_mode : [> Gtk.file_chooser] Gtk.obj -> bool *)
(*       = "ml_gtk_file_chooser_get_folder_mode" *)
(*   external set_local_only : [> Gtk.file_chooser] Gtk.obj -> bool -> unit *)
(*       = "ml_gtk_file_chooser_set_local_only" *)
(*   external get_local_only : [> Gtk.file_chooser] Gtk.obj -> bool *)
(*       = "ml_gtk_file_chooser_get_local_only" *)
(*   external set_select_multiple : [> Gtk.file_chooser] Gtk.obj -> bool -> unit *)
(*       = "ml_gtk_file_chooser_set_select_multiple" *)
(*   external get_select_multiple : [> Gtk.file_chooser] Gtk.obj -> bool *)
(*       = "ml_gtk_file_chooser_get_select_multiple" *)
  external set_current_name : [> Gtk.file_chooser] Gtk.obj -> string -> unit
      = "ml_gtk_file_chooser_set_current_name"

  external get_filename : [> Gtk.file_chooser] Gtk.obj -> string
      = "ml_gtk_file_chooser_get_filename"
  external set_filename : [> Gtk.file_chooser] Gtk.obj -> string -> unit
      = "ml_gtk_file_chooser_set_filename"
  external select_filename : [> Gtk.file_chooser] Gtk.obj -> string -> unit
      = "ml_gtk_file_chooser_select_filename"
  external unselect_filename : [> Gtk.file_chooser] Gtk.obj -> string -> unit
      = "ml_gtk_file_chooser_unselect_filename"
  external select_all : [> Gtk.file_chooser] Gtk.obj -> unit
      = "ml_gtk_file_chooser_select_all"
  external unselect_all : [> Gtk.file_chooser] Gtk.obj -> unit
      = "ml_gtk_file_chooser_unselect_all"
  external get_filenames : [> Gtk.file_chooser] Gtk.obj -> string list
      = "ml_gtk_file_chooser_get_filenames"
  external get_current_folder : [> Gtk.file_chooser] Gtk.obj -> string
      = "ml_gtk_file_chooser_get_current_folder"
  external set_current_folder : [> Gtk.file_chooser] Gtk.obj -> string -> unit
      = "ml_gtk_file_chooser_set_current_folder"

  external get_uri : [> Gtk.file_chooser] Gtk.obj -> string
      = "ml_gtk_file_chooser_get_uri"
  external set_uri : [> Gtk.file_chooser] Gtk.obj -> string -> unit
      = "ml_gtk_file_chooser_set_uri"
  external select_uri : [> Gtk.file_chooser] Gtk.obj -> string -> unit
      = "ml_gtk_file_chooser_select_uri"
  external unselect_uri : [> Gtk.file_chooser] Gtk.obj -> string -> unit
      = "ml_gtk_file_chooser_unselect_uri"
  external get_uris : [> Gtk.file_chooser] Gtk.obj -> string list
      = "ml_gtk_file_chooser_get_uris"
  external get_current_folder_uri : [> Gtk.file_chooser] Gtk.obj -> string
      = "ml_gtk_file_chooser_get_current_folder_uri"
  external set_current_folder_uri : [> Gtk.file_chooser] Gtk.obj -> string -> unit
      = "ml_gtk_file_chooser_set_current_folder_uri"

(*   external set_preview_widget : [> Gtk.file_chooser] Gtk.obj -> Gtk.widget Gtk.obj -> unit *)
(*       = "ml_gtk_file_chooser_set_preview_widget" *)
(*   external get_preview_widget : [> Gtk.file_chooser] Gtk.obj -> Gtk.widget Gtk.obj *)
(*       = "ml_gtk_file_chooser_get_preview_widget" *)
(*   external set_preview_widget_active : [> Gtk.file_chooser] Gtk.obj -> bool -> unit *)
(*       = "ml_gtk_file_chooser_set_preview_widget_active" *)
(*   external get_preview_widget_active : [> Gtk.file_chooser] Gtk.obj -> bool *)
(*       = "ml_gtk_file_chooser_get_preview_widget_active" *)
  external get_preview_filename : [> Gtk.file_chooser] Gtk.obj -> string
      = "ml_gtk_file_chooser_get_preview_filename"
  external get_preview_uri : [> Gtk.file_chooser] Gtk.obj -> string
      = "ml_gtk_file_chooser_get_preview_uri"

(*   external set_extra_widget : [> Gtk.file_chooser] Gtk.obj -> Gtk.widget Gtk.obj -> unit *)
(*       = "ml_gtk_file_chooser_set_extra_widget" *)
(*   external get_extra_widget : [> Gtk.file_chooser] Gtk.obj -> Gtk.widget Gtk.obj *)
(*       = "ml_gtk_file_chooser_get_extra_widget" *)

  external add_filter : [> Gtk.file_chooser] Gtk.obj -> Gtk.file_filter Gtk.obj -> unit
      = "ml_gtk_file_chooser_add_filter"
  external remove_filter : [> Gtk.file_chooser] Gtk.obj -> Gtk.file_filter Gtk.obj -> unit
      = "ml_gtk_file_chooser_remove_filter"
  external list_filters : [> Gtk.file_chooser] Gtk.obj -> Gtk.file_filter Gtk.obj list
      = "ml_gtk_file_chooser_list_filters"
(*   external set_filter : [> Gtk.file_chooser] Gtk.obj -> Gtk.file_filter Gtk.obj -> unit *)
(*       = "ml_gtk_file_chooser_set_filter" *)
(*   external get_filter : [> Gtk.file_chooser] Gtk.obj -> Gtk.file_filter Gtk.obj *)
(*       = "ml_gtk_file_chooser_get_filter" *)

  external add_shortcut_folder : [> Gtk.file_chooser] Gtk.obj -> string -> unit
      = "ml_gtk_file_chooser_add_shortcut_folder"
  external remove_shortcut_folder : [> Gtk.file_chooser] Gtk.obj -> string -> unit
      = "ml_gtk_file_chooser_remove_shortcut_folder"
  external list_shortcut_folders : [> Gtk.file_chooser] Gtk.obj -> string list
      = "ml_gtk_file_chooser_list_shortcut_folders"
  external add_shortcut_folder_uri : [> Gtk.file_chooser] Gtk.obj -> string -> unit
      = "ml_gtk_file_chooser_add_shortcut_folder_uri"
  external remove_shortcut_folder_uri : [> Gtk.file_chooser] Gtk.obj -> string -> unit
      = "ml_gtk_file_chooser_remove_shortcut_folder_uri"
  external list_shortcut_folder_uris : [> Gtk.file_chooser] Gtk.obj -> string list
      = "ml_gtk_file_chooser_list_shortcut_folder_uris"

  let dialog_create pl : [Gtk.dialog|Gtk.file_chooser] Gtk.obj = GtkObject.make "GtkFileChooserDialog" pl
  let widget_create pl : [Gtk.widget|Gtk.file_chooser] Gtk.obj = GtkObject.make "GtkFileChooserWidget" pl
end

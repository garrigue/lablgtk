(** The new file chooser widget *)

(** {3 GtkFileFilter} *)

(** @since GTK 2.4
    @gtkdoc gtk gtk-gtkfilefilter *)
class filter :
  ([> Gtk.file_filter ] as 'a) Gtk.obj ->
  object
    inherit GObj.gtkobj
    val obj : 'a Gtk.obj
    method as_file_filter : Gtk.file_filter Gtk.obj
    method add_mime_type : string -> unit
    method add_pattern : string -> unit
    method name : string
    method set_name : string -> unit
  end

(** @since GTK 2.4
    @gtkdoc gtk gtk-gtkfilefilter *)
val filter : ?name:string -> unit -> filter

(** {3 GtkFileChooser} *)

(** @since GTK 2.4
    @gtkdoc gtk GtkFileChooser *)
class type chooser_signals =
  object
    method current_folder_changed : callback:(unit -> unit) -> GtkSignal.id
    method selection_changed : callback:(unit -> unit) -> GtkSignal.id
    method update_preview : callback:(unit -> unit) -> GtkSignal.id
    method file_activated : callback:(unit -> unit) -> GtkSignal.id
  end

(** @since GTK 2.4
    @gtkdoc gtk GtkFileChooser *)
class type chooser =
  object
    method set_action : Gtk.Tags.file_chooser_action -> unit
    method action : Gtk.Tags.file_chooser_action
    method set_folder_mode : bool -> unit
    method folder_mode : bool
    method set_local_only : bool -> unit
    method local_only : bool
    method set_select_multiple : bool -> unit
    method select_multiple : bool
    method set_current_name : string -> unit
    method show_hidden : bool
    method set_show_hidden : bool -> unit

    method set_filename : string -> unit
    method filename : string
    method select_filename : string -> unit
    method unselect_filename : string -> unit
    method get_filenames : string list
    method set_current_folder : string -> unit
    method current_folder : string

    method set_uri : string -> unit
    method uri : string
    method select_uri : string -> unit
    method unselect_uri : string -> unit
    method get_uris : string list
    method set_current_folder_uri : string -> unit
    method current_folder_uri : string

    method select_all : unit
    method unselect_all : unit

    method set_preview_widget : GObj.widget -> unit
    method preview_widget : GObj.widget
    method set_preview_widget_active : bool -> unit
    method preview_widget_active : bool
    method preview_filename : string
    method preview_uri : string

    method set_extra_widget : GObj.widget -> unit
    method extra_widget : GObj.widget

    method add_filter : filter -> unit
    method remove_filter : filter -> unit
    method list_filters : filter list
    method set_filter : filter -> unit
    method filter : filter

    method add_shortcut_folder : string -> unit
    method remove_shortcut_folder : string -> unit
    method list_shortcut_folders : string list
    method add_shortcut_folder_uri : string -> unit
    method remove_shortcut_folder_uri : string -> unit
    method list_shortcut_folder_uris : string list
  end

(** @since GTK 2.4
    @gtkdoc gtk GtkFileChooserWidget *)
class chooser_widget_signals :
  ([> Gtk.widget|Gtk.file_chooser] as 'a) Gtk.obj ->
  object
    inherit GObj.widget_signals
    inherit chooser_signals
  end

(** @since GTK 2.4
    @gtkdoc gtk GtkFileChooserWidget *)
class chooser_widget :
  ([> Gtk.widget|Gtk.file_chooser] as 'a) Gtk.obj ->
  object
    inherit GObj.widget
    inherit chooser
    val obj : 'a Gtk.obj
    method connect : chooser_widget_signals
  end

(** @since GTK 2.4
    @gtkdoc gtk GtkFileChooserWidget *)
val chooser_widget : 
  action:Gtk.Tags.file_chooser_action ->
  ?packing:(GObj.widget -> unit) -> 
  ?show:bool ->
  unit ->
  chooser_widget

(**/**)

class virtual chooser_impl :
  ([> Gtk.file_chooser] as 'a) Gtk.obj ->
  object
    method private virtual obj : 'a Gtk.obj
    inherit chooser
  end


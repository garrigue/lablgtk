
open GtkFile
  
class filter obj = object
   inherit GObj.gtkobj obj
   method as_file_filter = (obj :> Gtk.file_filter Gtk.obj)
   method set_name = FileFilter.set_name obj 
   method name = FileFilter.get_name obj
   method add_mime_type = FileFilter.add_mime_type obj
   method add_pattern = FileFilter.add_pattern obj
   method add_custom = FileFilter.add_custom obj
end

let filter ?name () =
   let w = FileFilter.create () in
   Gaux.may (FileFilter.set_name w) name ;
   new filter w

class type chooser_signals = object
  method current_folder_changed : callback:(unit -> unit) -> GtkSignal.id
  method file_activated : callback:(unit -> unit) -> GtkSignal.id
  method selection_changed : callback:(unit -> unit) -> GtkSignal.id
  method update_preview : callback:(unit -> unit) -> GtkSignal.id
end

class type chooser =
  object
    method set_action : GtkEnums.file_chooser_action -> unit
    method action : GtkEnums.file_chooser_action
    method set_local_only : bool -> unit
    method local_only : bool
    method set_select_multiple : bool -> unit
    method select_multiple : bool
    method set_current_name : string -> unit
    method show_hidden : bool
    method set_show_hidden : bool -> unit

    method set_filename : string -> bool
    method get_filename : string option
    method select_filename : string -> bool
    method unselect_filename : string -> unit
    method get_filenames : string list
    method set_current_folder : string -> bool
    method get_current_folder : string option

    method set_uri : string -> bool
    method get_uri : string option
    method select_uri : string -> bool
    method unselect_uri : string -> unit
    method get_uris : string list
    method set_current_folder_uri : string -> bool
    method get_current_folder_uri : string

    method select_all : unit
    method unselect_all : unit

    method set_preview_widget : GObj.widget -> unit
    method preview_widget : GObj.widget
    method set_preview_widget_active : bool -> unit
    method preview_widget_active : bool
    method get_preview_filename : string option
    method get_preview_uri : string option
    method set_use_preview_label : bool -> unit
    method use_preview_label : bool

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

class virtual chooser_impl = object (self)
  method private virtual obj : 'a Gtk.obj
  inherit OgtkFileProps.file_chooser_props

  method set_current_name = FileChooser.set_current_name self#obj

  method set_filename = FileChooser.set_filename self#obj
  method get_filename = FileChooser.get_filename self#obj
  method select_filename = FileChooser.select_filename self#obj
  method unselect_filename = FileChooser.unselect_filename self#obj
  method select_all = FileChooser.select_all self#obj
  method unselect_all = FileChooser.unselect_all self#obj
  method get_filenames = FileChooser.get_filenames self#obj
  method set_current_folder = FileChooser.set_current_folder self#obj
  method get_current_folder = FileChooser.get_current_folder self#obj

  method set_uri = FileChooser.set_uri self#obj
  method get_uri = FileChooser.get_uri self#obj
  method select_uri = FileChooser.select_uri self#obj
  method unselect_uri = FileChooser.unselect_uri self#obj
  method get_uris = FileChooser.get_uris self#obj
  method set_current_folder_uri = FileChooser.set_current_folder_uri self#obj
  method get_current_folder_uri = FileChooser.get_current_folder_uri self#obj

  method get_preview_filename = FileChooser.get_preview_filename self#obj
  method get_preview_uri = FileChooser.get_preview_uri self#obj

  method add_filter (f : filter) = FileChooser.add_filter self#obj f#as_file_filter
  method remove_filter (f : filter) = FileChooser.remove_filter self#obj f#as_file_filter
  method list_filters = List.map (new filter) (FileChooser.list_filters self#obj )
  method set_filter (f : filter) = Gobject.set FileChooser.P.filter self#obj f#as_file_filter
  method filter = new filter (Gobject.get FileChooser.P.filter self#obj)
      
  method add_shortcut_folder = FileChooser.add_shortcut_folder self#obj
  method remove_shortcut_folder = FileChooser.remove_shortcut_folder self#obj
  method list_shortcut_folders = FileChooser.list_shortcut_folders self#obj
  method add_shortcut_folder_uri = FileChooser.add_shortcut_folder_uri self#obj
  method remove_shortcut_folder_uri = FileChooser.remove_shortcut_folder_uri self#obj
  method list_shortcut_folder_uris = FileChooser.list_shortcut_folder_uris self#obj
end

class chooser_widget_signals obj = object
  inherit GObj.widget_signals_impl obj
  inherit OgtkFileProps.file_chooser_sigs
end

class chooser_widget obj = object
  inherit [_] GObj.widget_impl obj
  inherit chooser_impl
  method event = new GObj.event_ops obj
  method connect = new chooser_widget_signals obj
end

let chooser_widget ~action ?backend ?packing ?show () =
  let w = FileChooser.widget_create 
      (Gobject.Property.may_cons 
	 FileChooser.P.file_system_backend backend
	 [ Gobject.param FileChooser.P.action action ]) in
  let o = new chooser_widget w in
  GObj.pack_return o ?packing ?show

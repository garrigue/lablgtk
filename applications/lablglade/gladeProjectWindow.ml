open Misc
open Gtk
open Tags
open GtkBase
open Glade
open GladeProject
   
module ProjectWindow = struct
  let cast w : project_window obj =  
    if Object.is_a w "GladeProjectWindow" then Obj.magic w
    else invalid_arg "Glade.ProjectWindow.cast"
  external coerce : [> project_window] obj -> project_window obj = "%identity"
  external create : unit -> project_window obj = "ml_glade_project_window_new"

  external new_project : [> project_window] obj -> unit = "ml_glade_project_window_new_project"
  external on_open_project : [> project_window] obj -> unit = "ml_glade_project_window_on_open_project"
  external open_project : [> project_window] obj -> string -> unit = "ml_glade_project_window_open_project"
  external save_project : [> project_window] obj -> unit = "ml_glade_project_window_save_project"
  external on_save_project_as : [> project_window] obj -> unit = "ml_glade_project_window_on_save_project_as"
  external write_source : [> project_window] obj -> unit = "ml_glade_project_window_write_source"
  external edit_options : [> project_window] obj -> unit = "ml_glade_project_window_edit_options"
  external cut : [> project_window] obj -> unit = "ml_glade_project_window_cut"
  external copy : [> project_window] obj -> unit = "ml_glade_project_window_copy"
  external paste : [> project_window] obj -> unit = "ml_glade_project_window_paste"
  external delete : [> project_window] obj -> unit = "ml_glade_project_window_delete"
  external show_palette : [> project_window] obj -> unit = "ml_glade_project_window_show_palette"
  external show_property_editor : [> project_window] obj -> unit = "ml_glade_project_window_show_property_editor"
  external show_widget_tree : [> project_window] obj -> unit = "ml_glade_project_window_show_widget_tree"
  external show_clipboard : [> project_window] obj -> unit = "ml_glade_project_window_show_clipboard"
  external toggle_tooltips : [> project_window] obj -> unit = "ml_glade_project_window_toggle_tooltips"
  external toggle_grid : [> project_window] obj -> unit = "ml_glade_project_window_toggle_grid"
  external edit_grid_settings : [> project_window] obj -> unit = "ml_glade_project_window_edit_grid_settings"
  external toggle_snap : [> project_window] obj -> unit = "ml_glade_project_window_toggle_snap"
  external edit_snap_settings : [> project_window] obj -> unit = "ml_glade_project_window_edit_snap_settings"
  external about : [> project_window] obj -> unit = "ml_glade_project_window_about"
  external set_project : [> project_window] obj -> project obj -> unit = "ml_glade_project_window_set_project"
end

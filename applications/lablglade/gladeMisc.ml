open Misc
open Gtk
open Tags
open GtkBase
open Glade


module GladeMisc = struct
  external init   : unit -> unit = "ml_glade_init"
  external show_project_window : unit -> unit = "ml_glade_show_project_window"
  external hide_project_window : unit -> unit = "ml_glade_hide_project_window"
  external show_palette : unit -> unit = "ml_glade_show_palette"
  external show_property_editor : unit -> unit = "ml_glade_show_property_editor"
  external show_widget_tree : unit -> unit = "ml_glade_show_widget_tree"
  external show_clipboard : unit -> unit = "ml_glade_show_clipboard"

  external hide_palette : unit -> unit = "ml_glade_hide_palette"
  external hide_property_editor : unit -> unit = "ml_glade_hide_property_editor"
  external hide_widget_tree : unit -> unit = "ml_glade_hide_widget_tree"
  external hide_clipboard : unit -> unit = "ml_glade_hide_clipboard"

  external show_widget_tooltips : bool -> unit = "ml_glade_show_widget_tooltips"
  external show_grid : bool -> unit = "ml_glade_show_grid"
  external snap_to_grid : bool -> unit = "ml_glade_snap_to_grid"
  external show_snap_settings : unit -> unit = "ml_glade_show_snap_settings"
  external show_grid_settings : unit -> unit = "ml_glade_show_grid_settings"
end

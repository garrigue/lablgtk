open Misc
open Gtk
open GtkBase
open GObj
(* open GContainer *)
open GPack
open Glade
open GladeProjectWindow

class project_window_skel obj = object (self)
  inherit box_skel obj
  method new_project () = ProjectWindow.new_project obj
  method on_open_project () =  ProjectWindow.on_open_project obj
  method open_project name = ProjectWindow.open_project obj name
  method save_project () = ProjectWindow.save_project obj
  method on_save_project_as () = ProjectWindow.on_save_project_as obj
  method write_source () = ProjectWindow.write_source obj
  method edit_options () = ProjectWindow.edit_options obj
  method cut ()  = ProjectWindow.cut obj
  method copy () = ProjectWindow.copy obj
  method paste () = ProjectWindow.paste obj
  method delete () = ProjectWindow.delete obj
  method show_palette () = ProjectWindow.show_palette obj
  method show_property_editor () = ProjectWindow.show_property_editor obj
  method show_widget_tree () = ProjectWindow.show_widget_tree obj
  method show_clipboard () = ProjectWindow.show_clipboard obj
  method toggle_tooltips () = ProjectWindow.toggle_tooltips obj
  method toggle_grid () = ProjectWindow.toggle_grid obj
  method edit_grid_settings () = ProjectWindow.edit_grid_settings obj
  method toggle_snap () = ProjectWindow.toggle_snap obj
  method edit_snap_settings () = ProjectWindow.edit_snap_settings obj
  method about () = ProjectWindow.about obj
  method set_project proj = ProjectWindow.set_project obj proj
end

class project_window_wrapper obj = object
  inherit project_window_skel (ProjectWindow.coerce obj)
  method add_events = Widget.add_events obj
end

class project_window ?:border_width ?:width ?:height ?:packing ?:show =
  let w = ProjectWindow.create () in
  let () =
    Container.set w ?:border_width ?:width ?:height in
  object (self)
    inherit project_window_wrapper w
    initializer pack_return :packing ?:show (self :> project_window_wrapper)
  end

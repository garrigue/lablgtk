open Misc
open Gtk
open Tags
open GtkBase
open Glade
   
module ProjectView = struct
  let cast w : project_view obj =  
    if Object.is_a w "GladeProjectView" then Obj.magic w
    else invalid_arg "Glade.ProjectView.cast"
  external coerce : [> project_view] obj -> project_view obj = "%identity"
  external create : unit -> project_view obj = "ml_glade_project_view_new"
  external set_project : [> project_view] obj -> [> project] obj -> unit = "ml_glade_project_view_set_project"
  module Signals = struct
  end
end
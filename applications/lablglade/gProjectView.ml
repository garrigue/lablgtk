open Misc
open Gtk
open GtkBase
open GObj
open GContainer
open Glade
open GladeProject
open GladeProjectView

class project_view_skel obj = object (self)
  inherit container obj
  method set_project (proj:project obj) = ProjectView.set_project obj proj
end

class project_view_signals obj ?:after = object
  inherit container_signals obj ?:after
end

class project_view_wrapper obj = object
  inherit project_view_skel (ProjectView.coerce obj)
  method connect = new project_view_signals ?obj
  method add_events = Widget.add_events obj
end

class project_view ?:border_width ?:width ?:height ?:packing ?:show =
  let w = ProjectView.create () in
  let () =
    Container.set w ?:border_width ?:width ?:height in
  object (self)
    inherit project_view_wrapper w
    initializer pack_return :packing ?:show (self :> project_view_wrapper)
  end



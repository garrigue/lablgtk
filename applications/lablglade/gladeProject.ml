open Misc
open Gtk
open Tags
(* open GtkBase *)
open Glade


module Project = struct
  let cast w : project obj =
    if GtkBase.Object.is_a w "GladeProject" then Obj.magic w
    else invalid_arg "Glade.Project.cast"
  external coerce : [> project] obj -> project obj = "%identity"
  external set_source_files : [> project] obj ->
                              string -> string -> string -> string -> unit =
                             "ml_glade_project_set_source_files"
  external create_internal : unit -> project obj = "ml_glade_project_new" 
  let create () = let ret = create_internal () in
                  let _ = set_source_files ret "gladesrc.ml" "gladesrc.mli"
                                               "gladesig.ml" "gladesig.mli" in
                  ret
end

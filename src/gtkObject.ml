open Gtk
open Gobject

let cast w : [`gtk] obj = try_cast w "GtkObject"
external _ref_and_sink : [>`gtk] obj -> unit
    = "ml_gtk_object_ref_and_sink"
let make ~classe params =
  let obj = unsafe_create ~classe params in _ref_and_sink obj;
  obj

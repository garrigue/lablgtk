(* $Id$ *)

(* This module provides some low-level interfacing with libglade *)

external init : unit -> unit = "ml_glade_init"
    (* You must call [init] before importing any glade specification *)
    (* Returns immediately if already initialized *)

(* The raw glade XML widget *)
type glade_xml = [ `data | `glade_xml]

external create : file:string -> root:string -> glade_xml Gtk.obj
  = "ml_glade_xml_new"

val signal_autoconnect :
  [> `glade_xml] Gtk.obj ->
  f:(handler:string ->
     signal:string ->
     after:bool -> ?target:unit Gtk.obj -> unit Gtk.obj -> unit) ->
  unit
external get_widget :
  [> `glade_xml] Gtk.obj -> name:string -> Gtk.widget Gtk.obj
  = "ml_glade_xml_get_widget"
external get_widget_by_long_name :
  [> `glade_xml] Gtk.obj -> name:string -> Gtk.widget Gtk.obj
  = "ml_glade_xml_get_widget_by_long_name"
external get_widget_name : [> `widget] Gtk.obj -> string
  = "ml_glade_get_widget_name"
external get_widget_long_name : [> `widget] Gtk.obj -> string
  = "ml_glade_get_widget_long_name"
external get_widget_tree : [> `widget] Gtk.obj -> glade_xml Gtk.obj
  = "ml_glade_get_widget_tree"


(* Handler bindings *)
type handler =
  [ `Simple of unit -> unit
  | `Object of string * (unit Gtk.obj -> unit)
  | `Custom of GtkArgv.t -> GtkArgv.data list -> unit]
val gtk_bool : bool -> GtkArgv.t -> 'a -> unit

val add_handler : name:string -> handler -> unit
    (* Add a global handler for some well known name.
       The default ones (gtk_main_quit, gtk_widget_destroy, ...) are
       already defined. *)
val bind_handlers :
  ?extra:(string * handler) list -> [> `glade_xml] Gtk.obj -> unit
    (* Bind handlers on a glade widget. You may add some local bindings
       specific to this widget. *)

val bind_handler :
  name:string -> handler:handler -> [> `glade_xml] Gtk.obj -> unit
    (* Bind an individual handler *)

(* $Id$ *)

open Gtk

type glade_xml = [`data|`glade_xml]

external init : unit -> unit
    = "ml_glade_init"
external gnome_init : unit -> unit
    = "ml_glade_gnome_init"
external create : file:string -> root:string -> glade_xml obj
    = "ml_glade_xml_new"
external set_signal_autoconnect :
    [> `glade_xml] obj ->
    (string * unit obj * string * unit obj option * bool -> unit) -> unit
    = "ml_glade_xml_signal_autoconnect_full"

let set_signal_autoconnect self ~f =
  set_signal_autoconnect self
    (fun (handler, obj, signal, target, after) ->
      f ~handler ~signal ~after ?target obj)

external get_widget : [> `glade_xml] obj -> name:string -> widget obj
    = "ml_glade_xml_get_widget"
external get_widget_name : [> `widget] obj -> string
    = "ml_glade_get_widget_name"
external get_widget_tree : [> `widget] obj -> glade_xml obj
    = "ml_glade_get_widget_tree"

(* Basic usage *)
(*
Glade.init ();;
let xml = Glade.create ~file:"../project1/project1.glade" ~root:"window1";;
let f ~handler ~signal ~after ?target obj =
  Printf.printf "object=%s, signal=%s, handler=%s\n"
   (Glade.get_widget_name (GtkBase.Widget.cast obj)) signal handler;;
Glade.set_signal_autoconnect xml ~f;;
*)

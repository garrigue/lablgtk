(* $Id$ *)

open Gtk

(* GladeXML widget *)

type glade_xml = [`data|`glade_xml]

external init : unit -> unit = "ml_glade_init"
(* external gnome_init : unit -> unit = "ml_glade_gnome_init" *)
external create : file:string -> root:string -> glade_xml obj
    = "ml_glade_xml_new"
external _signal_autoconnect :
    [> `glade_xml] obj ->
    (string * unit obj * string * unit obj option * bool -> unit) -> unit
    = "ml_glade_xml_signal_autoconnect_full"

let signal_autoconnect self ~f =
  _signal_autoconnect self
    (fun (handler, obj, signal, target, after) ->
      f ~handler ~signal ~after ?target obj)

external get_widget : [> `glade_xml] obj -> name:string -> widget obj
    = "ml_glade_xml_get_widget"
external get_widget_by_long_name :
    [> `glade_xml] obj -> name:string -> widget obj
    = "ml_glade_xml_get_widget_by_long_name"
external get_widget_name : [> `widget] obj -> string
    = "ml_glade_get_widget_name"
external get_widget_long_name : [> `widget] obj -> string
    = "ml_glade_get_widget_long_name"
external get_widget_tree : [> `widget] obj -> glade_xml obj
    = "ml_glade_get_widget_tree"

(* Signal handlers *)

type handler =
  [ `Simple of (unit -> unit)
  | `Object of string * (unit obj -> unit)
  | `Custom of (GtkArgv.t -> GtkArgv.data list -> unit) ]

let ($) f g x = g (f x)
let gtk_bool b argv _ = GtkArgv.set_result argv (`BOOL b)
let known_handlers : (string, handler) Hashtbl.t = Hashtbl.create 7
let add_handler ~name handler =
  Hashtbl.add known_handlers ~key:name ~data:handler
open GtkBase
let _ = List.iter ~f:(fun (name,h) -> add_handler ~name h)
    [ "gtk_widget_destroy", `Object ("GtkObject", Object.destroy);
      "gtk_main_quit", `Simple GtkMain.Main.quit;
      "gtk_widget_show", `Object ("GtkWidget", Widget.cast $ Widget.show);
      "gtk_widget_hide", `Object ("GtkWidget", Widget.cast $ Widget.hide);
      "gtk_widget_grab_focus",
      `Object ("GtkWidget", Widget.cast $ Widget.grab_focus);
      "gtk_window_activate_default",
      `Object ("GtkWindow",
              GtkWindow.Window.cast $ GtkWindow.Window.activate_default);
      "gtk_true", `Custom (gtk_bool true);
      "gtk_false", `Custom (gtk_bool false);
    ]

open Printf

let check_handler ?target ?(name="<unknown>") handler =
  match handler with
    `Simple f ->
      if target <> None then
        eprintf "Glade.ml: %s does not take an object argument.\n" name;
      fun _ -> f ()
  | `Object (cls, f) ->
      begin match target with
        None ->
          eprintf "Glade.ml: %s requires an object argument.\n" name;
          raise Not_found
      | Some obj ->
          if GtkBase.Object.is_a obj cls then
            fun _ -> f obj
          else begin
            eprintf "Glade.ml: %s expects a %s argument.\n" name cls;
            raise Not_found
          end
      end
  | `Custom f ->
      if target <> None then
        eprintf "Glade.ml: %s does not take an object argument.\n" name;
      fun argv -> f argv (GtkArgv.get_args argv)

let bind_handlers ?(extra=[]) xml =
  signal_autoconnect xml ~f:
    begin fun ~handler:name ~signal ~after ?target obj ->
      try
        let handler =
          try List.assoc name extra
          with Not_found -> Hashtbl.find known_handlers name
        in
        let callback = check_handler ?target ~name handler in
        ignore (GtkSignal.connect_by_name obj ~name:signal ~after ~callback)
      with Not_found ->
        if String.length name < 3
        || String.sub name ~pos:0 ~len:3 <> "on_"
        then eprintf "Glade.ml: no handler for %s.\n" name
    end;
  flush stderr

(** Writing panel applets
   @gtkdoc panel-applet panelapplet *)

type panel_applet = [ `panelapplet | Gtk.event_box]
type flags = [ `EXPAND_MAJOR | `EXPAND_MINOR | `HAS_HANDLE]
type background_type = [
  | `NO_BACKGROUND
  | `COLOR_BACKGROUND of Gdk.color
  | `PIXMAP_BACKGROUND of Gdk.pixmap
]
type orient_type = [ `UP | `DOWN | `LEFT | `RIGHT ]

type verb = string * (string -> unit)

(** @gtkdoc panel-applet panelapplet *)
class applet_signals :
  panel_applet Gtk.obj ->
  object
    inherit GContainer.container_signals
    val obj : panel_applet Gtk.obj
    method change_background : callback:(background_type -> unit) -> GtkSignal.id
    method change_orient : callback:(orient_type -> unit) -> GtkSignal.id
    method change_size   : callback:(int -> unit) -> GtkSignal.id
    method move_focus_out_of_applet :
      callback:(GtkEnums.direction_type -> unit) -> GtkSignal.id
  end

(** @gtkdoc panel-applet panelapplet *)
class applet :
  ([> panel_applet] as 'a) Gtk.obj ->
  object
    inherit GContainer.container
    val obj : 'a Gtk.obj
    method connect : applet_signals
    method event : GObj.event_ops

    method get_background : unit -> background_type
    method get_orient : unit -> orient_type
    method get_size : unit -> int
    method get_flags : unit -> flags list
    method set_flags : flags list -> unit

    method setup_menu : xml:string -> verb list -> unit
    method setup_menu_from_file :
      ?dir:string -> file:string -> ?app_name:string -> verb list -> unit
  end

(** A generic 'main' routine for applets. *)
val factory_main : iid:string -> (applet -> iid:string -> bool) -> bool

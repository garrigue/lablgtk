(* $Id$ *)

open Gaux
open Gtk
open Tags
open GtkProps
open GtkBase

external _gtkbin_init : unit -> unit = "ml_gtkbin_init"
let () = _gtkbin_init ()

module Alignment = Alignment

module EventBox = EventBox

module Frame = struct
  include Frame

  let setter ~cont =
    make_params ~cont:(fun params ->
      cont (fun w -> Gobject.set_params w params))

  let set ?label = setter ~cont:(fun f w -> f w) ?label
end

module AspectFrame = AspectFrame

module HandleBox = struct
  include HandleBox
  module Signals = struct
    open GtkSignal
    let child_attached =
      { name = "child_attached"; classe = `handlebox;
        marshaller = Widget.Signals.marshal }
    let child_detached =
      { name = "child_detached"; classe = `handlebox;
        marshaller = Widget.Signals.marshal }
  end
end

module Viewport = Viewport

module ScrolledWindow = struct
  include ScrolledWindow
  external add_with_viewport : [>`scrolledwindow] obj -> [>`widget] obj -> unit
      = "ml_gtk_scrolled_window_add_with_viewport"
end

module Socket = struct
  include Socket
  external steal : [>`socket] obj -> Gdk.xid -> unit = "ml_gtk_socket_steal"
  module S = struct
    open GtkSignal
   let plug_added =
      { name = "plug_added"; classe = `socket; marshaller = marshal_unit }
    let plug_removed =
      { name = "plug_removed"; classe = `socket; marshaller = marshal_unit }
  end
end

(* module Invisible = Invisible *)

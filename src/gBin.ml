(* $Id$ *)

open Gaux
open Gtk
open GtkProps
open GtkBase
open GtkBin
open GObj
open OGtkProps
open GContainer

let set = Gobject.Property.set

class scrolled_window obj = object
  inherit [Gtk.scrolled_window] container_impl obj
  method connect = new container_signals obj
  inherit scrolled_window_props
  method add_with_viewport w =
    ScrolledWindow.add_with_viewport obj (as_widget w)
end

let scrolled_window ?hadjustment ?vadjustment =
  ScrolledWindow.make_params []
    ?hadjustment:(may_map ~f:GData.as_adjustment hadjustment)
    ?vadjustment:(may_map ~f:GData.as_adjustment vadjustment)
    ~cont:(
  pack_container ~create:(fun pl ->
    new scrolled_window (ScrolledWindow.create pl)))

class event_box obj = object
  inherit container_full (obj : Gtk.event_box obj)
  method event = new GObj.event_ops obj
end

let event_box =
  pack_container [] ~create:(fun pl -> new event_box (EventBox.create pl))

class handle_box_signals (obj : [> handle_box] obj) = object
  inherit widget_signals_impl obj
  inherit container_sigs
  inherit handle_box_sigs
end

class handle_box obj = object
  inherit [Gtk.handle_box] container_impl obj
  method connect = new handle_box_signals obj
  method event = new GObj.event_ops obj
  inherit handle_box_props
end

let handle_box =
  HandleBox.make_params [] ~cont:(
  pack_container ~create:(fun pl -> new handle_box (HandleBox.create pl)))

class frame_skel obj = object
  inherit [[> frame]] container_impl obj
  inherit frame_props
end

class frame obj = object
  inherit frame_skel (obj : Gtk.frame obj)
  method connect = new container_signals obj
end

let frame =
  Frame.make_params [] ~cont:(
  pack_container ~create:(fun pl -> new frame (Frame.create pl)))

class aspect_frame obj = object
  inherit frame_skel (obj : Gtk.aspect_frame obj)
  method connect = new container_signals obj
  inherit aspect_frame_props
end

let aspect_frame =
  AspectFrame.make_params [] ~cont:(
  Frame.make_params ~cont:(
  pack_container ~create:(fun pl -> new aspect_frame (AspectFrame.create pl))))

class viewport obj = object
  inherit [Gtk.viewport] container_impl obj
  method connect = new container_signals obj
  method event = new event_ops obj
  inherit viewport_props
end

let viewport ?hadjustment ?vadjustment =
  Viewport.make_params []
    ?hadjustment:(may_map ~f:GData.as_adjustment hadjustment)
    ?vadjustment:(may_map ~f:GData.as_adjustment vadjustment) ~cont:(
  pack_container ~create:(fun pl -> new viewport (Viewport.create pl)))

class alignment obj = object
  inherit [Gtk.alignment] container_impl obj
  method connect = new container_signals obj
  inherit alignment_props
end

let alignment =
  Alignment.make_params [] ~cont:(
  pack_container ~create:(fun pl -> new alignment (Alignment.create pl)))
  
let alignment_cast w = new alignment (Alignment.cast w#as_widget)

class socket_signals obj = object
  inherit widget_signals_impl (obj : [> socket] obj)
  inherit container_sigs
  inherit socket_sigs
end

class socket obj = object (self)
  inherit container (obj : Gtk.socket obj)
  method connect = new socket_signals obj
  method steal = Socket.steal obj
  method xwindow =
    self#misc#realize ();
    Gdk.Window.get_xwindow self#misc#window
end

let socket =
  pack_container [] ~create:(fun pl -> new socket (Socket.create pl))

(* $Id$ *)

open Gaux
open Gtk
open GtkBase
open GtkBin
open GObj
open GContainer

class scrolled_window obj = object
  inherit container_full (obj : Gtk.scrolled_window obj)
  method hadjustment =
    new GData.adjustment (ScrolledWindow.get_hadjustment obj)
  method vadjustment =
    new GData.adjustment (ScrolledWindow.get_vadjustment obj)
  method set_hadjustment adj =
    ScrolledWindow.set_hadjustment obj (GData.as_adjustment adj)
  method set_vadjustment adj =
    ScrolledWindow.set_vadjustment obj (GData.as_adjustment adj)
  method set_hpolicy hpolicy = ScrolledWindow.set_policy' obj ~hpolicy
  method set_vpolicy vpolicy = ScrolledWindow.set_policy' obj ~vpolicy
  method set_placement = ScrolledWindow.set_placement obj
  method add_with_viewport w =
    ScrolledWindow.add_with_viewport obj (as_widget w)
end

let scrolled_window ?hadjustment ?vadjustment ?hpolicy ?vpolicy
    ?placement ?border_width ?width ?height ?packing ?show () =
  let w =
    ScrolledWindow.create ()
      ?hadjustment:(may_map ~f:GData.as_adjustment hadjustment)
      ?vadjustment:(may_map ~f:GData.as_adjustment vadjustment) in
  ScrolledWindow.set w ?hpolicy ?vpolicy ?placement;
  Container.set w ?border_width ?width ?height;
  pack_return (new scrolled_window w) ~packing ~show

class event_box obj = object
  inherit container_full (obj : Gtk.event_box obj)
  method event = new GObj.event_ops obj
end

let event_box ?border_width ?width ?height ?packing ?show () =
  let w = EventBox.create () in
  Container.set w ?border_width ?width ?height;
  pack_return (new event_box w) ~packing ~show

class handle_box_signals obj = object
  inherit container_signals obj
  method child_attached ~callback =
    GtkSignal.connect ~sgn:HandleBox.Signals.child_attached obj ~after
      ~callback:(fun obj -> callback (new widget obj))
  method child_detached ~callback =
    GtkSignal.connect ~sgn:HandleBox.Signals.child_detached obj ~after
      ~callback:(fun obj -> callback (new widget obj))
end

class handle_box obj = object
  inherit container (obj : Gtk.handle_box obj)
  method set_shadow_type     = HandleBox.set_shadow_type     obj
  method set_handle_position = HandleBox.set_handle_position obj
  method set_snap_edge       = HandleBox.set_snap_edge       obj
  method connect = new handle_box_signals obj
  method event = new GObj.event_ops obj
end

let handle_box ?handle_position ?snap_edge ?shadow_type
    ?border_width ?width ?height ?packing ?show () =
  let w = HandleBox.create () in
  HandleBox.set w ?handle_position ?snap_edge ?shadow_type;
  Container.set w ?border_width ?width ?height;
  pack_return (new handle_box w) ~packing ~show

class frame_skel obj = object
  inherit container obj
  method set_label = Frame.set_label obj
  method set_label_align ?x ?y () = Frame.set_label_align' obj ?x ?y
  method set_shadow_type = Frame.set_shadow_type obj
end

class frame obj = object
  inherit frame_skel (obj : Gtk.frame obj)
  method connect = new container_signals obj
end

let frame ?(label="") ?label_xalign ?label_yalign ?shadow_type
    ?border_width ?width ?height ?packing ?show () =
  let w = Frame.create label in
  Frame.set w ?label_xalign ?label_yalign ?shadow_type;
  Container.set w ?border_width ?width ?height;
  pack_return (new frame w) ~packing ~show

class aspect_frame obj = object
  inherit frame_skel (obj : Gtk.aspect_frame obj)
  method connect = new container_signals obj
  method set_alignment ?x ?y () = AspectFrame.set obj ?xalign:x ?yalign:y
  method set_ratio ratio = AspectFrame.set obj ~ratio
  method set_obey_child obey_child = AspectFrame.set obj ~obey_child
end

let aspect_frame ?label ?xalign ?yalign ?ratio ?obey_child
    ?label_xalign ?label_yalign ?shadow_type
    ?border_width ?width ?height ?packing ?show () =
  let w =
    AspectFrame.create ?label ?xalign ?yalign ?ratio ?obey_child () in
  Frame.set w ?label_xalign ?label_yalign ?shadow_type;
  Container.set w ?border_width ?width ?height;
  pack_return (new aspect_frame w) ~packing ~show

class viewport obj = object
  inherit container_full (obj : Gtk.viewport obj)
  method event = new event_ops obj
  method set_hadjustment adj =
    Viewport.set_hadjustment obj (GData.as_adjustment adj)
  method set_vadjustment adj =
    Viewport.set_vadjustment obj (GData.as_adjustment adj)
  method set_shadow_type = Viewport.set_shadow_type obj
  method hadjustment = new GData.adjustment (Viewport.get_hadjustment obj)
  method vadjustment = new GData.adjustment (Viewport.get_vadjustment obj)
end

let viewport ?hadjustment ?vadjustment ?shadow_type
    ?border_width ?width ?height ?packing ?show () =
  let w = Viewport.create ()
      ?hadjustment:(may_map ~f:GData.as_adjustment hadjustment)
      ?vadjustment:(may_map ~f:GData.as_adjustment vadjustment) in
  may shadow_type ~f:(Viewport.set_shadow_type w);
  Container.set w ?border_width ?width ?height;
  pack_return (new viewport w) ~packing ~show

class alignment obj = object
  inherit container_full (obj : Gtk.alignment obj)
  method set_alignment ?x ?y () = Alignment.set ?x ?y obj
  method set_scale ?x ?y () = Alignment.set ?xscale:x ?yscale:y obj
end

let alignment ?x ?y ?xscale ?yscale
    ?border_width ?width ?height ?packing ?show () =
  let w = Alignment.create ?x ?y ?xscale ?yscale () in
  Container.set w ?border_width ?width ?height;
  pack_return (new alignment w) ~packing ~show
  
let alignment_cast w = new alignment (Alignment.cast w#as_widget)

class socket obj = object (self)
  inherit container_full (obj : Gtk.socket obj)
  method steal = Socket.steal obj
  method xwindow =
    self#misc#realize ();
    Gdk.Window.get_xwindow self#misc#window
end

let socket ?border_width ?width ?height ?packing ?show () =
  let w = Socket.create () in
  Container.set w ?border_width ?width ?height;
  pack_return (new socket w) ?packing ?show

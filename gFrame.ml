(* $Id$ *)

open Misc
open Gtk
open GtkBase
open GtkFrame
open GObj
open GContainer

class scrolled_window_wrapper obj = object
  inherit container_wrapper (obj : scrolled_window obj)
  method hadjustment =
    new GData.adjustment_wrapper (ScrolledWindow.get_hadjustment obj)
  method vadjustment =
    new GData.adjustment_wrapper (ScrolledWindow.get_vadjustment obj)
  method set_hadjustment (adj : GData.adjustment) =
    ScrolledWindow.set_hadjustment obj adj#as_adjustment
  method set_vadjustment (adj : GData.adjustment) =
    ScrolledWindow.set_vadjustment obj adj#as_adjustment
  method set_hpolicy hpolicy = ScrolledWindow.set_policy' obj :hpolicy
  method set_vpolicy vpolicy = ScrolledWindow.set_policy' obj :vpolicy
  method set_placement = ScrolledWindow.set_placement obj
  method add_with_viewport : 'a. (#is_widget as 'a) -> _ =
    fun w -> ScrolledWindow.add_with_viewport obj w#as_widget
end

class scrolled_window ?:hadjustment ?:vadjustment ?:hpolicy ?:vpolicy
    ?:placement ?:border_width ?:width ?:height ?:packing ?:show =
  let w =
    ScrolledWindow.create ?None
      ?hadjustment:(GData.adjustment_option hadjustment)
      ?vadjustment:(GData.adjustment_option vadjustment) in
  let () =
    ScrolledWindow.set w ?:hpolicy ?:vpolicy ?:placement;
    Container.set w ?:border_width ?:width ?:height
  in
  object (self)
    inherit scrolled_window_wrapper w
    initializer pack_return :packing ?:show (self :> scrolled_window_wrapper)
  end

class event_box_wrapper obj = object
  inherit container_wrapper (obj : event_box obj)
  method add_events = Widget.add_events obj
end

class event_box ?:border_width ?:width ?:height ?:packing ?:show =
  let w = EventBox.create () in
  let () = Container.set w ?:border_width ?:width ?:height in
  object (self)
    inherit event_box_wrapper w
    initializer pack_return :packing ?:show (self :> event_box_wrapper)
  end

class handle_box_signals obj ?:after = object
  inherit container_signals obj ?:after
  method child_attached =
    GtkSignal.connect sig:HandleBox.Signals.child_attached obj ?:after
  method child_detached =
    GtkSignal.connect sig:HandleBox.Signals.child_detached obj ?:after
end

class handle_box_wrapper obj = object
  inherit container (obj : handle_box obj)
  method set_shadow_type     = HandleBox.set_shadow_type     obj
  method set_handle_position = HandleBox.set_handle_position obj
  method set_snap_edge       = HandleBox.set_snap_edge       obj
  method connect = new handle_box_signals ?obj
  method add_events = Widget.add_events obj
end

class handle_box ?:border_width ?:width ?:height ?:packing ?:show =
  let w = HandleBox.create () in
  let () = Container.set w ?:border_width ?:width ?:height in
  object (self)
    inherit handle_box_wrapper w
    initializer pack_return :packing ?:show (self :> handle_box_wrapper)
  end

class frame_skel obj = object
  inherit container obj
  method set_label = Frame.set_label obj
  method set_label_align = Frame.set_label_align' ?obj
  method set_shadow_type = Frame.set_shadow_type obj
end

class frame_wrapper obj = object
  inherit frame_skel (Frame.coerce obj)
  method connect = new container_signals ?obj
end

class frame ?:label ?:label_xalign ?:label_yalign ?:shadow_type
    ?:border_width ?:width ?:height ?:packing ?:show =
  let w = Frame.create ?:label ?None in
  let () =
    Frame.set w ?:label_xalign ?:label_yalign ?:shadow_type;
    Container.set w ?:border_width ?:width ?:height
  in
  object (self)
    inherit frame_wrapper w
    initializer pack_return :packing ?:show (self :> frame_wrapper)
  end

class aspect_frame_wrapper obj = object
  inherit frame_skel (obj : Gtk.aspect_frame obj)
  method connect = new container_signals ?obj
  method set_alignment ?:x ?:y = AspectFrame.set obj ?xalign:x ?yalign:y
  method set_ratio ratio = AspectFrame.set obj :ratio
  method set_obey_child obey_child = AspectFrame.set obj :obey_child
end

class aspect_frame ?:label ?:xalign ?:yalign ?:ratio ?:obey_child
    ?:label_xalign ?:label_yalign ?:shadow_type
    ?:border_width ?:width ?:height ?:packing ?:show =
  let w =
    AspectFrame.create ?:label ?:xalign ?:yalign ?:ratio ?:obey_child ?None in
  let () =
    Frame.set w ?:label_xalign ?:label_yalign ?:shadow_type;
    Container.set w ?:border_width ?:width ?:height
  in
  object (self)
    inherit aspect_frame_wrapper w
    initializer pack_return :packing ?:show (self :> aspect_frame_wrapper)
  end

class viewport_wrapper obj = object
  inherit container_wrapper (obj : viewport obj)
  method set_hadjustment (adj : GData.adjustment) =
    Viewport.set_hadjustment obj adj#as_adjustment
  method set_vadjustment (adj : GData.adjustment) =
    Viewport.set_vadjustment obj adj#as_adjustment
  method set_shadow_type = Viewport.set_shadow_type obj
  method hadjustment =
    new GData.adjustment_wrapper (Viewport.get_hadjustment obj)
  method vadjustment =
    new GData.adjustment_wrapper (Viewport.get_vadjustment obj)
end

class viewport ?:hadjustment ?:vadjustment ?:shadow_type
    ?:border_width ?:width ?:height ?:packing ?:show =
  let w = Viewport.create ?None
      ?hadjustment:(GData.adjustment_option hadjustment)
      ?vadjustment:(GData.adjustment_option vadjustment) in
  let () =
    may shadow_type fun:(Viewport.set_shadow_type w);
    Container.set w ?:border_width ?:width ?:height
  in
  object (self)
    inherit viewport_wrapper w
    initializer pack_return :packing ?:show (self :> viewport_wrapper)
  end

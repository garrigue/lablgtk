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
  method set_policy ?:hscrollbar ?:vscrollbar =
    ScrolledWindow.setter obj cont:null_cont
      ?hscrollbar_policy:hscrollbar ?vscrollbar_policy:vscrollbar
  method add_with_viewport : 'a. (#is_widget as 'a) -> _ =
    fun w -> ScrolledWindow.add_with_viewport obj w#as_widget
end

class scrolled_window ?:hscrollbar_policy ?:vscrollbar_policy
    ?:border_width ?:width ?:height ?:packing ?:show =
  let w = ScrolledWindow.create () in
  let () =
    ScrolledWindow.setter w cont:null_cont
      ?:hscrollbar_policy ?:vscrollbar_policy;
    Container.setter w ?:border_width ?:width ?:height cont:null_cont
  in
  object (self)
    inherit scrolled_window_wrapper w
    initializer pack_return :packing ?:show (self :> scrolled_window_wrapper)
  end

class event_box ?:border_width ?:width ?:height ?:packing ?:show =
  let w = EventBox.create () in
  let () = Container.setter w ?:border_width ?:width ?:height cont:null_cont in
  object (self)
    inherit container_wrapper w
    initializer pack_return :packing ?:show (self :> container_wrapper)
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
end

class handle_box ?:border_width ?:width ?:height ?:packing ?:show =
  let w = HandleBox.create () in
  let () = Container.setter w ?:border_width ?:width ?:height cont:null_cont in
  object (self)
    inherit handle_box_wrapper w
    initializer pack_return :packing ?:show (self :> handle_box_wrapper)
  end

class frame_skel obj = object
  inherit container obj
  method set_label ?label ?:xalign ?:yalign =
    Frame.setter obj ?:label ?label_xalign:xalign ?label_yalign:yalign
      cont:null_cont
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
    Frame.setter w cont:null_cont ?:label_xalign ?:label_yalign ?:shadow_type;
    Container.setter w ?:border_width ?:width ?:height cont:null_cont
  in
  object (self)
    inherit frame_wrapper w
    initializer pack_return :packing ?:show (self :> frame_wrapper)
  end

class aspect_frame_wrapper obj = object
  inherit frame_skel (obj : Gtk.aspect_frame obj)
  method connect = new container_signals ?obj
  method set_aspect = AspectFrame.setter ?obj ?cont:null_cont
end

class aspect_frame ?:label ?:xalign ?:yalign ?:ratio ?:obey_child
    ?:label_xalign ?:label_yalign ?:shadow_type
    ?:border_width ?:width ?:height ?:packing ?:show =
  let w =
    AspectFrame.create ?:label ?:xalign ?:yalign ?:ratio ?:obey_child ?None in
  let () =
    Frame.setter w cont:null_cont ?:label_xalign ?:label_yalign ?:shadow_type;
    Container.setter w ?:border_width ?:width ?:height cont:null_cont
  in
  object (self)
    inherit aspect_frame_wrapper w
    initializer pack_return :packing ?:show (self :> aspect_frame_wrapper)
  end

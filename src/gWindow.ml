(* $Id$ *)

open Misc
open Gtk
open GObj
open GCont
open GUtil

class type is_window = object method as_window : Window.t obj end

class window_skel obj = object
  inherit container obj
  method as_window = Window.coerce obj
  method show_all () = Widget.show_all obj
  method activate_focus () = Window.activate_focus obj
  method activate_default () = Window.activate_default obj
  method add_accel_group = Window.add_accel_group obj
  method set_modal = Window.set_modal obj
  method set_default_size = Window.set_default_size obj
  method set_position = Window.set_position obj
  method set_transient_for : 'a . (#is_window as 'a) -> unit
      = fun w -> Window.set_transient_for obj (w #as_window)
  method set_wm ?:title ?:name ?class:c =
    Window.setter obj cont:null_cont
      ?:title ?wmclass_name:name ?wmclass_class:c
  method set_policy ?:allow_shrink ?:allow_grow ?:auto_shrink =
    Window.setter obj cont:null_cont ?:allow_shrink ?:allow_grow ?:auto_shrink
end

class window_wrapper obj = object
  inherit window_skel (Window.coerce obj)
  method connect = new container_signals ?obj
end

class window t ?:title ?:wmclass_name ?:wmclass_class ?:position ?:allow_shrink
    ?:allow_grow ?:auto_shrink ?:modal ?:x ?:y ?:border_width ?:width ?:height
    ?:packing =
  let w = Window.create t in
  let () =
    Window.setter w ?:title ?:wmclass_name ?:wmclass_class ?:position
      ?:allow_shrink ?:allow_grow ?:auto_shrink ?:modal ?:x ?:y cont:null_cont;
    Container.setter w ?:border_width ?:width ?:height cont:null_cont
  in
  object (self)
    inherit window_wrapper w
    initializer pack_return :packing (self :> window_wrapper)
  end

class scrolled_window_wrapper obj = object
  inherit container_wrapper (obj : ScrolledWindow.t obj)
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
    ?:border_width ?:width ?:height ?:packing =
  let w = ScrolledWindow.create () in
  let () =
    ScrolledWindow.setter w cont:null_cont
      ?:hscrollbar_policy ?:vscrollbar_policy;
    Container.setter w ?:border_width ?:width ?:height cont:null_cont
  in
  object (self)
    inherit scrolled_window_wrapper w
    initializer pack_return :packing (self :> scrolled_window_wrapper)
  end

class event_box ?:border_width ?:width ?:height ?:packing =
  let w = EventBox.create () in
  let () = Container.setter w ?:border_width ?:width ?:height cont:null_cont in
  object (self)
    inherit container_wrapper w
    initializer pack_return :packing (self :> container_wrapper)
  end

class handle_box_signals obj ?:after = object
  inherit container_signals obj ?:after
  method child_attached =
    Signal.connect sig:HandleBox.Signals.child_attached obj ?:after
  method child_detached =
    Signal.connect sig:HandleBox.Signals.child_detached obj ?:after
end

class handle_box_wrapper obj = object
  inherit container (obj : HandleBox.t obj)
  method set_shadow_type     = HandleBox.set_shadow_type     obj
  method set_handle_position = HandleBox.set_handle_position obj
  method set_snap_edge       = HandleBox.set_snap_edge       obj
  method connect = new handle_box_signals ?obj
end

class handle_box ?:border_width ?:width ?:height ?:packing =
  let w = HandleBox.create () in
  let () = Container.setter w ?:border_width ?:width ?:height cont:null_cont in
  object (self)
    inherit handle_box_wrapper w
    initializer pack_return :packing (self :> handle_box_wrapper)
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
    ?:border_width ?:width ?:height ?:packing =
  let w = Frame.create ?:label ?None in
  let () =
    Frame.setter w cont:null_cont ?:label_xalign ?:label_yalign ?:shadow_type;
    Container.setter w ?:border_width ?:width ?:height cont:null_cont
  in
  object (self)
    inherit frame_wrapper w
    initializer pack_return :packing (self :> frame_wrapper)
  end

class aspect_frame_wrapper obj = object
  inherit frame_skel (obj : AspectFrame.t obj)
  method connect = new container_signals ?obj
  method set_aspect = AspectFrame.setter ?obj ?cont:null_cont
end

class aspect_frame ?:label ?:xalign ?:yalign ?:ratio ?:obey_child
    ?:label_xalign ?:label_yalign ?:shadow_type
    ?:border_width ?:width ?:height ?:packing =
  let w =
    AspectFrame.create ?:label ?:xalign ?:yalign ?:ratio ?:obey_child ?None in
  let () =
    Frame.setter w cont:null_cont ?:label_xalign ?:label_yalign ?:shadow_type;
    Container.setter w ?:border_width ?:width ?:height cont:null_cont
  in
  object (self)
    inherit aspect_frame_wrapper w
    initializer pack_return :packing (self :> aspect_frame_wrapper)
  end

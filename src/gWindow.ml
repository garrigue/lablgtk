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

class dialog_wrapper obj = object
  inherit window_skel (Dialog.coerce obj)
  method connect = new container_signals ?obj
  method action_area = new GBox.box (Dialog.action_area obj)
  method vbox = new GBox.box (Dialog.vbox obj)
end

class dialog ?:title ?:wmclass_name ?:wmclass_class ?:position ?:allow_shrink
    ?:allow_grow ?:auto_shrink ?:modal ?:x ?:y ?:border_width ?:width ?:height
    ?:packing =
  let w = Dialog.create () in
  let () =
    Window.setter w ?:title ?:wmclass_name ?:wmclass_class ?:position
      ?:allow_shrink ?:allow_grow ?:auto_shrink ?:modal ?:x ?:y cont:null_cont;
    Container.setter w ?:border_width ?:width ?:height cont:null_cont
  in
  object (self)
    inherit dialog_wrapper w
    initializer pack_return :packing (self :> dialog_wrapper)
  end

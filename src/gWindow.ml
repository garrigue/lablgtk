(* $Id$ *)

open Misc
open Gtk
open GtkBase
open GtkWindow
open GtkMisc
open GObj
open GContainer

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
  method connect = new GContainer.container_signals ?obj
  method action_area = new GPack.box_wrapper (Dialog.action_area obj)
  method vbox = new GPack.box_wrapper (Dialog.vbox obj)
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

class color_selection_dialog_wrapper obj = object
  inherit window_skel (obj : Gtk.color_selection_dialog obj)
  method connect = new GContainer.container_signals ?obj
  method ok_button =
    new GButton.button_wrapper (ColorSelection.ok_button obj)
  method cancel_button =
    new GButton.button_wrapper (ColorSelection.cancel_button obj)
  method help_button =
    new GButton.button_wrapper (ColorSelection.help_button obj)
  method colorsel =
    new GMisc.color_selection_wrapper (ColorSelection.colorsel obj)
end

class color_selection_dialog :title ?:wmclass_name ?:wmclass_class ?:position
    ?:allow_shrink ?:allow_grow ?:auto_shrink ?:modal ?:x ?:y
    ?:border_width ?:width ?:height ?:packing =
  let w = ColorSelection.create_dialog title in
  let () =
    Window.setter w ?title:None ?:wmclass_name ?:wmclass_class ?:position
      ?:allow_shrink ?:allow_grow ?:auto_shrink ?:modal ?:x ?:y cont:null_cont;
    Container.setter w ?:border_width ?:width ?:height cont:null_cont
  in
  object (self)
    inherit color_selection_dialog_wrapper w
    initializer pack_return :packing (self :> color_selection_dialog_wrapper)
  end

class file_selection_wrapper obj = object
  inherit window_skel (obj : Gtk.file_selection obj)
  method connect = new GContainer.container_signals ?obj
  method set_filename = FileSelection.set_filename obj
  method get_filename = FileSelection.get_filename obj
  method show_fileop_buttons () = FileSelection.show_fileop_buttons obj
  method hide_fileop_buttons () = FileSelection.hide_fileop_buttons obj
  method ok_button =
    new GButton.button_wrapper (FileSelection.get_ok_button obj)
  method cancel_button =
    new GButton.button_wrapper (FileSelection.get_cancel_button obj)
  method help_button =
    new GButton.button_wrapper (FileSelection.get_help_button obj)
end

class file_selection :title ?:filename ?:fileop_buttons
    ?:wmclass_name ?:wmclass_class ?:position
    ?:allow_shrink ?:allow_grow ?:auto_shrink ?:modal ?:x ?:y
    ?:border_width ?:width ?:height ?:packing =
  let w = FileSelection.create title in
  let () =
    FileSelection.setter w cont:null_cont ?:filename ?:fileop_buttons;
    Window.setter w ?title:None ?:wmclass_name ?:wmclass_class ?:position
      ?:allow_shrink ?:allow_grow ?:auto_shrink ?:modal ?:x ?:y cont:null_cont;
    Container.setter w ?:border_width ?:width ?:height cont:null_cont
  in
  object (self)
    inherit file_selection_wrapper w
    initializer pack_return :packing (self :> file_selection_wrapper)
  end

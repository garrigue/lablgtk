(* $Id$ *)

open Misc
open Gtk
open GUtil
open GObj
open GWin

class dialog_wrapper obj = object
  inherit window_skel (Dialog.coerce obj)
  method connect = new GCont.container_signals ?obj
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

class color_selection_wrapper obj = object
  inherit GPack.box_skel (ColorSelection.coerce obj)
  method connect = new GCont.container_signals ?obj
  method set_update_policy = ColorSelection.set_update_policy obj
  method set_opacity = ColorSelection.set_opacity obj
  method set_color = ColorSelection.set_color obj
  method get_color = ColorSelection.get_color obj
end

class color_selection ?:border_width ?:width ?:height ?:packing =
  let w = ColorSelection.create () in
  let () = Container.setter w cont:null_cont ?:border_width ?:width ?:height in
  object (self)
    inherit color_selection_wrapper w
    initializer pack_return :packing (self :> color_selection_wrapper)
  end

class color_selection_dialog_wrapper obj = object
  inherit window_skel (obj : ColorSelection.dialog obj)
  method connect = new GCont.container_signals ?obj
  method ok_button =
    new GButton.button_wrapper (ColorSelection.ok_button obj)
  method cancel_button =
    new GButton.button_wrapper (ColorSelection.cancel_button obj)
  method help_button =
    new GButton.button_wrapper (ColorSelection.help_button obj)
  method colorsel =
    new color_selection_wrapper (ColorSelection.colorsel obj)
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
  inherit window_skel (obj : FileSelection.t obj)
  method connect = new GCont.container_signals ?obj
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

(* $Id$ *)

open Misc
open Gtk
open GtkBase
open GtkWindow
open GtkMisc
open GObj
open GContainer

class ['a] window_skel obj = object
  constraint 'a = _ #window_skel
  inherit container obj
  method add_events = Widget.add_events obj
  method as_window = Window.coerce obj
  method activate_focus () = Window.activate_focus obj
  method activate_default () = Window.activate_default obj
  method add_accel_group = Window.add_accel_group obj
  method set_modal = Window.set_modal obj
  method set_default_size = Window.set_default_size obj
  method set_position = Window.set_position obj
  method set_resize_mode = Container.set_resize_mode obj
  method set_transient_for (w : 'a) =
    Window.set_transient_for obj w#as_window
  method set_title = Window.set_title obj
  method set_wm_name name = Window.set_wmclass obj ~name
  method set_wm_class cls = Window.set_wmclass obj ~clas:cls
  method set_allow_shrink allow_shrink = Window.set_policy obj ~allow_shrink
  method set_allow_grow allow_grow = Window.set_policy obj ~allow_grow
  method set_auto_shrink auto_shrink = Window.set_policy obj ~auto_shrink
  method show () = Widget.show obj
end

class window obj = object
  inherit [window] window_skel (Window.coerce obj)
  method connect = new container_signals obj
end

let window ?kind:(t=`TOPLEVEL) ?title ?wm_name ?wm_class ?position
    ?allow_shrink ?allow_grow ?auto_shrink ?modal ?x ?y
    ?border_width ?width ?height ?packing ?(show=false) () =
  let w = Window.create t in
  Window.set w ?title ?wm_name ?wm_class ?position
    ?allow_shrink ?allow_grow ?auto_shrink ?modal ?x ?y;
  Container.set w ?border_width ?width ?height;
  pack_return (new window w) ~packing ~show:(Some show)

class dialog obj = object
  inherit [window] window_skel (Dialog.coerce obj)
  method connect = new container_signals obj
  method action_area = new GPack.box (Dialog.action_area obj)
  method vbox = new GPack.box (Dialog.vbox obj)
end

let dialog ?title ?wm_name ?wm_class ?position ?allow_shrink
    ?allow_grow ?auto_shrink ?modal ?x ?y ?border_width ?width ?height
    ?packing ?(show=false) () =
  let w = Dialog.create () in
  Window.set w ?title ?wm_name ?wm_class ?position
    ?allow_shrink ?allow_grow ?auto_shrink ?modal ?x ?y;
  Container.set w ?border_width ?width ?height;
  pack_return (new dialog w) ~packing ~show:(Some show)

class color_selection_dialog obj = object
  inherit [window] window_skel (obj : Gtk.color_selection_dialog obj)
  method connect = new container_signals obj
  method ok_button =
    new GButton.button (ColorSelection.ok_button obj)
  method cancel_button =
    new GButton.button (ColorSelection.cancel_button obj)
  method help_button =
    new GButton.button (ColorSelection.help_button obj)
  method colorsel =
    new GMisc.color_selection (ColorSelection.colorsel obj)
end

let color_selection_dialog ?(title="Pick a color")
    ?wm_name ?wm_class ?position
    ?allow_shrink ?allow_grow ?auto_shrink ?modal ?x ?y
    ?border_width ?width ?height ?packing ?(show=false) () =
  let w = ColorSelection.create_dialog title in
  Window.set w ?wm_name ?wm_class ?position
    ?allow_shrink ?allow_grow ?auto_shrink ?modal ?x ?y;
  Container.set w ?border_width ?width ?height;
  pack_return (new color_selection_dialog w) ~packing ~show:(Some show)

class file_selection obj = object
  inherit [window] window_skel (obj : Gtk.file_selection obj)
  method connect = new container_signals obj
  method set_filename = FileSelection.set_filename obj
  method get_filename = FileSelection.get_filename obj
  method set_fileop_buttons = FileSelection.set_fileop_buttons obj
  method ok_button = new GButton.button (FileSelection.get_ok_button obj)
  method cancel_button =
    new GButton.button (FileSelection.get_cancel_button obj)
  method help_button = new GButton.button (FileSelection.get_help_button obj)
end

let file_selection ?(title="Choose a file") ?filename
    ?(fileop_buttons=false)
    ?wm_name ?wm_class ?position
    ?allow_shrink ?allow_grow ?auto_shrink ?modal ?x ?y
    ?border_width ?width ?height ?packing ?(show=false) () =
  let w = FileSelection.create title in
  FileSelection.set w ?filename ~fileop_buttons;
  Window.set w ?wm_name ?wm_class ?position
    ?allow_shrink ?allow_grow ?auto_shrink ?modal ?x ?y;
  Container.set w ?border_width ?width ?height;
  pack_return (new file_selection w) ~packing ~show:(Some show)

class font_selection_dialog obj = object
  inherit [window] window_skel (obj : Gtk.font_selection_dialog obj)
  method connect = new container_signals obj
  method font = FontSelectionDialog.get_font obj
  method font_name = FontSelectionDialog.get_font_name obj
  method set_font_name = FontSelectionDialog.set_font_name obj
  method preview_text = FontSelectionDialog.get_preview_text obj
  method set_preview_text = FontSelectionDialog.set_preview_text obj
  method set_filter = FontSelectionDialog.set_filter obj
  method ok_button =  new GButton.button (FontSelectionDialog.ok_button obj)
  method apply_button =
    new GButton.button (FontSelectionDialog.apply_button obj)
  method cancel_button =
    new GButton.button (FontSelectionDialog.cancel_button obj)
end

let font_selection_dialog ?title ?wm_name ?wm_class ?position
    ?allow_shrink ?allow_grow ?auto_shrink ?modal ?x ?y
    ?border_width ?width ?height ?packing ?(show=false) () =
  let w = FontSelectionDialog.create ?title () in
  Window.set w ?wm_name ?wm_class ?position
    ?allow_shrink ?allow_grow ?auto_shrink ?modal ?x ?y;
  Container.set w ?border_width ?width ?height;
  pack_return (new font_selection_dialog w) ~packing ~show:(Some show)

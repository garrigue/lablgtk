(* $Id$ *)

open Gaux
open Gtk
open GtkBase
open GtkWindow
open GtkMisc
open GObj
open GContainer

class ['a] window_skel obj = object
  constraint 'a = _ #window_skel
  inherit container obj
  method event = new GObj.event_ops obj
  method as_window = (obj :> Gtk.window obj)
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
  inherit [window] window_skel (obj : Gtk.window obj)
  method connect = new container_signals obj
end

let window ?kind:(t=`TOPLEVEL) ?title ?wm_name ?wm_class ?position
    ?allow_shrink ?allow_grow ?auto_shrink ?modal ?x ?y
    ?border_width ?width ?height ?(show=false) () =
  let w = Window.create t in
  Window.set w ?title ?wm_name ?wm_class ?position
    ?allow_shrink ?allow_grow ?auto_shrink ?modal ?x ?y;
  Container.set w ?border_width ?width ?height;
  if show then Widget.show w;
  new window w

let cast_window (w : #widget) =
  new window (GtkWindow.Window.cast w#as_widget)

let toplevel (w : #widget) =
  try Some (cast_window w#misc#toplevel) with Cannot_cast _ -> None

class dialog obj = object
  inherit [window] window_skel (obj : Gtk.dialog obj)
  method connect = new container_signals obj
  method action_area = new GPack.box (Dialog.action_area obj)
  method vbox = new GPack.box (Dialog.vbox obj)
end

let dialog ?title ?wm_name ?wm_class ?position ?allow_shrink
    ?allow_grow ?auto_shrink ?modal ?x ?y ?border_width ?width ?height
    ?(show=false) () =
  let w = Dialog.create () in
  Window.set w ?title ?wm_name ?wm_class ?position
    ?allow_shrink ?allow_grow ?auto_shrink ?modal ?x ?y;
  Container.set w ?border_width ?width ?height;
  if show then Widget.show w;
  new dialog w

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
    ?border_width ?width ?height ?(show=false) () =
  let w = ColorSelection.create_dialog title in
  Window.set w ?wm_name ?wm_class ?position
    ?allow_shrink ?allow_grow ?auto_shrink ?modal ?x ?y;
  Container.set w ?border_width ?width ?height;
  if show then Widget.show w;
  new color_selection_dialog w

class file_selection obj = object
  inherit [window] window_skel (obj : Gtk.file_selection obj)
  method connect = new container_signals obj
  method set_filename = FileSelection.set_filename obj
  method get_filename = FileSelection.get_filename obj
  method complete = FileSelection.complete obj
  method set_fileop_buttons = FileSelection.set_fileop_buttons obj
  method ok_button = new GButton.button (FileSelection.get_ok_button obj)
  method cancel_button =
    new GButton.button (FileSelection.get_cancel_button obj)
  method help_button = new GButton.button (FileSelection.get_help_button obj)
  method file_list : string GList.clist =
    new GList.clist (FileSelection.get_file_list obj)
  method dir_list : string GList.clist =
    new GList.clist (FileSelection.get_dir_list obj)
end

let file_selection ?(title="Choose a file") ?filename
    ?(fileop_buttons=false)
    ?wm_name ?wm_class ?position
    ?allow_shrink ?allow_grow ?auto_shrink ?modal ?x ?y
    ?border_width ?width ?height ?(show=false) () =
  let w = FileSelection.create title in
  FileSelection.set w ?filename ~fileop_buttons;
  Window.set w ?wm_name ?wm_class ?position
    ?allow_shrink ?allow_grow ?auto_shrink ?modal ?x ?y;
  Container.set w ?border_width ?width ?height;
  if show then Widget.show w;
  new file_selection w

class font_selection_dialog obj = object
  inherit [window] window_skel (obj : Gtk.font_selection_dialog obj)
  method connect = new container_signals obj
(*
  method font = FontSelectionDialog.get_font obj
  method font_name = FontSelectionDialog.get_font_name obj
  method set_font_name = FontSelectionDialog.set_font_name obj
  method preview_text = FontSelectionDialog.get_preview_text obj
  method set_preview_text = FontSelectionDialog.set_preview_text obj
  method set_filter = FontSelectionDialog.set_filter obj
*)
  method selection =
    new GMisc.font_selection (FontSelectionDialog.font_selection obj)
  method ok_button =  new GButton.button (FontSelectionDialog.ok_button obj)
  method apply_button =
    new GButton.button (FontSelectionDialog.apply_button obj)
  method cancel_button =
    new GButton.button (FontSelectionDialog.cancel_button obj)
end

let font_selection_dialog ?title ?wm_name ?wm_class ?position
    ?allow_shrink ?allow_grow ?auto_shrink ?modal ?x ?y
    ?border_width ?width ?height ?(show=false) () =
  let w = FontSelectionDialog.create ?title () in
  Window.set w ?wm_name ?wm_class ?position
    ?allow_shrink ?allow_grow ?auto_shrink ?modal ?x ?y;
  Container.set w ?border_width ?width ?height;
  if show then Widget.show w;
  new font_selection_dialog w

class plug (obj : Gtk.plug obj) = window (obj :> Gtk.window obj)

let plug ~window:xid ?border_width ?width ?height ?(show=false) () =
  let w = Plug.create xid in
  Container.set w ?border_width ?width ?height;
  if show then Widget.show w;
  new plug w

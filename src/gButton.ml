(* $Id$ *)

open Gaux
open Gtk
open GtkBase
open GtkButton
open GObj
open GContainer

class button_skel obj = object (self)
  inherit container obj
  method clicked () = Button.clicked obj
  method grab_default () =
    Widget.set_can_default obj true;
    Widget.grab_default obj
end

class button_signals obj = object
  inherit container_signals obj
  method clicked = GtkSignal.connect ~sgn:Button.Signals.clicked ~after obj
  method pressed = GtkSignal.connect ~sgn:Button.Signals.pressed ~after obj
  method released = GtkSignal.connect ~sgn:Button.Signals.released ~after obj
  method enter = GtkSignal.connect ~sgn:Button.Signals.enter ~after obj
  method leave = GtkSignal.connect ~sgn:Button.Signals.leave ~after obj
end

class button obj = object
  inherit button_skel (Button.coerce obj)
  method connect = new button_signals obj
  method event = new GObj.event_ops obj
end

let button ?label ?border_width ?width ?height ?packing ?show () =
  let w = Button.create ?label () in
  Container.set w ?border_width ?width ?height;
  pack_return (new button w) ~packing ~show

class toggle_button_signals obj = object
  inherit button_signals obj
  method toggled =
    GtkSignal.connect ~sgn:ToggleButton.Signals.toggled obj ~after
end

class toggle_button obj = object
  inherit button_skel obj
  method connect = new toggle_button_signals obj
  method active = ToggleButton.get_active obj
  method set_active = ToggleButton.set_active obj
  method set_draw_indicator = ToggleButton.set_mode obj
end

let toggle_button ?label ?active ?draw_indicator
    ?border_width ?width ?height ?packing ?show () =
  let w = ToggleButton.create_toggle ?label () in
  ToggleButton.set w ?active ?draw_indicator;
  Container.set w ?border_width ?width ?height;
  pack_return (new toggle_button w) ~packing ~show

let check_button ?label ?active ?draw_indicator
    ?border_width ?width ?height ?packing ?show () =
  let w = ToggleButton.create_check ?label () in
  ToggleButton.set w ?active ?draw_indicator;
  Container.set w ?border_width ?width ?height;
  pack_return (new toggle_button w) ~packing ~show

class radio_button obj = object
  inherit toggle_button (obj : Gtk.radio_button obj)
  method set_group = RadioButton.set_group obj
  method group = Some obj
end

let radio_button ?group ?label ?active ?draw_indicator
    ?border_width ?width ?height ?packing ?show () =
  let w = RadioButton.create ?group ?label () in
  ToggleButton.set w ?active ?draw_indicator;
  Container.set w ?border_width ?width ?height;
  pack_return (new radio_button w) ~packing ~show

class toolbar obj = object
  inherit container_full (obj : Gtk.toolbar obj)
  method insert_widget ?tooltip ?tooltip_private ?pos w =
    Toolbar.insert_widget obj (as_widget w) ?tooltip ?tooltip_private ?pos

  method insert_button ?text ?tooltip ?tooltip_private ?icon
      ?pos ?callback () =
    let icon = may_map icon ~f:as_widget in
    new button
      (Toolbar.insert_button obj ~kind:`BUTTON ?icon ?text
	 ?tooltip ?tooltip_private ?pos ?callback ())

  method insert_toggle_button ?text ?tooltip ?tooltip_private ?icon
      ?pos ?callback () =
    let icon = may_map icon ~f:as_widget in
    new toggle_button
      (ToggleButton.cast
	 (Toolbar.insert_button obj ~kind:`TOGGLEBUTTON ?icon ?text
	    ?tooltip ?tooltip_private ?pos ?callback ()))

  method insert_radio_button ?text ?tooltip ?tooltip_private ?icon
      ?pos ?callback () =
    let icon = may_map icon ~f:as_widget in
    new radio_button
      (RadioButton.cast
	 (Toolbar.insert_button obj ~kind:`RADIOBUTTON ?icon ?text
	    ?tooltip ?tooltip_private ?pos ?callback ()))

  method insert_space = Toolbar.insert_space obj

  method set_orientation = Toolbar.set_orientation obj
  method set_style = Toolbar.set_style obj
  method set_space_size = Toolbar.set_space_size obj
  method set_space_style = Toolbar.set_space_style obj
  method set_tooltips = Toolbar.set_tooltips obj
  method set_button_relief = Toolbar.set_button_relief obj
  method button_relief = Toolbar.get_button_relief obj
end

let toolbar ?(orientation=`HORIZONTAL) ?style
    ?space_size ?space_style ?tooltips ?button_relief
    ?border_width ?width ?height ?packing ?show () =
  let w = Toolbar.create orientation ?style () in
  Toolbar.set w ?space_size ?space_style ?tooltips ?button_relief;
  Container.set w ?border_width ?width ?height;
  pack_return (new toolbar w) ~packing ~show

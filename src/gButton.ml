(* $Id$ *)

open Gaux
open Gobject
open Gtk
open GtkBase
open GtkButton
open OGtkProps
open GObj
open GContainer

class button_skel obj = object (self)
  inherit container obj
  method clicked () = Button.clicked obj
  method set_relief = set Button.P.relief obj
  method relief = get Button.P.relief obj
  method grab_default () =
    set Widget.P.can_default obj true;
    set Widget.P.has_default obj true
end

class button_signals obj = object
  inherit widget_signals_impl obj
  inherit container_sigs
  inherit button_sigs
end

class button obj = object
  inherit button_skel (obj : Gtk.button obj)
  method connect = new button_signals obj
  method event = new GObj.event_ops obj
end

let pack_return create p ?packing ?show () =
  pack_return (create p) ~packing ~show

let button ?label =
  Button.make_params [] ?label ~cont:(
  pack_return (fun p -> new button (Button.create p)))

class toggle_button_signals obj = object
  inherit button_signals obj
  method toggled =
    GtkSignal.connect ~sgn:ToggleButton.Signals.toggled obj ~after
end

class toggle_button obj = object
  inherit button_skel obj
  method connect = new toggle_button_signals obj
  method active = get ToggleButton.P.active obj
  method set_active = set ToggleButton.P.active obj
  method set_draw_indicator = set ToggleButton.P.draw_indicator obj
end

let make_toggle_button create ?label =
  Button.make_params [] ?label ~cont:(
  ToggleButton.make_params ~cont:(
  pack_return (fun p -> new toggle_button (create p))))

let toggle_button = make_toggle_button ToggleButton.create
let check_button = make_toggle_button ToggleButton.create_check

class radio_button obj = object
  inherit toggle_button (obj : Gtk.radio_button obj)
  method set_group = set RadioButton.P.group obj
  method group = Some obj
end

let radio_button ?group =
  Button.make_params [] ~cont:(
  ToggleButton.make_params ~cont:(
  pack_return (fun p -> new radio_button (RadioButton.create ?group p))))

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

  method set_orientation = set Toolbar.P.orientation obj
  method set_style = set Toolbar.P.toolbar_style obj
  method set_tooltips = Toolbar.set_tooltips obj
end

let toolbar ?orientation ?style ?tooltips =
  pack_container [] ~create:(fun p ->
    let w = Toolbar.create p in
    Toolbar.set w ?orientation ?style ?tooltips;
    new toolbar w)

(* $Id$ *)

open Misc
open Gtk
open GtkBase
open GtkButton
open GObj
open GContainer
open GButton

module Toolbar2 = struct
  external set_text : [>`toolbar] obj -> string -> int -> unit =
    "ml_gtk_toolbar2_set_text"
  external set_icon : [>`toolbar] obj -> [>`widget] obj -> int -> unit =
    "ml_gtk_toolbar2_set_icon"
end

class toolbar2 obj = object
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
  method set_text = Toolbar2.set_text obj
  method set_icon (icon : widget) = Toolbar2.set_icon obj icon#as_widget
end

let toolbar2 ?(orientation=`HORIZONTAL) ?style
    ?space_size ?space_style ?tooltips ?button_relief
    ?border_width ?width ?height ?packing ?show () =
  let w = Toolbar.create orientation ?style () in
  Toolbar.set w ?space_size ?space_style ?tooltips ?button_relief;
  Container.set w ?border_width ?width ?height;
  pack_return (new toolbar2 w) ~packing ~show

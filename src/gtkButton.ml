(* $Id$ *)

open Gaux
open Gobject
open Gtk
open Tags
open GtkButtonProps
open GtkBase

external _gtkbutton_init : unit -> unit = "ml_gtkbutton_init"
let () = _gtkbutton_init ()

module Button = struct
  include Button
  let make_params ~cont p ?label ?use_mnemonic ?stock =
    let label, use_stock =
      match stock with None -> label, None
      | Some id -> Some (GtkStock.convert_id id), Some true in
    make_params ~cont p ?label ?use_underline:use_mnemonic ?use_stock
  external pressed : [>`button] obj -> unit = "ml_gtk_button_pressed"
  external released : [>`button] obj -> unit = "ml_gtk_button_released"
  external clicked : [>`button] obj -> unit = "ml_gtk_button_clicked"
  external enter : [>`button] obj -> unit = "ml_gtk_button_enter"
  external leave : [>`button] obj -> unit = "ml_gtk_button_leave"
end

module ToggleButton = struct
  include ToggleButton
  let create_check pl : toggle_button obj = Object.make "GtkCheckButton" pl
  external toggled : [>`toggle] obj -> unit
      = "ml_gtk_toggle_button_toggled"
end

module RadioButton = struct
  include RadioButton
  let create ?group p = create (Property.may_cons P.group group p)
end

module Toolbar = struct
  include Toolbar
  external insert_space : [>`toolbar] obj -> pos:int -> unit
      = "ml_gtk_toolbar_insert_space"
  let insert_space w ?(pos = -1) () = insert_space w ~pos
  external insert_button :
      [>`toolbar] obj -> kind:[`BUTTON|`TOGGLEBUTTON|`RADIOBUTTON] ->
      text:string -> tooltip:string ->
      tooltip_private:string ->
      icon:[>`widget] optobj -> pos:int -> button obj
      = "ml_gtk_toolbar_insert_element_bc" "ml_gtk_toolbar_insert_element"
  let insert_button w ?(kind=`BUTTON) ?(text="") ?(tooltip="")
      ?(tooltip_private="") ?icon ?(pos = -1) ?callback () =
    let b =insert_button w ~kind ~text ~tooltip ~tooltip_private ~pos
        ~icon:(Gpointer.optboxed icon)
    in
    may callback ~f:
      (fun callback -> GtkSignal.connect b ~sgn:Button.S.clicked ~callback);
    b
  external insert_widget :
      [>`toolbar] obj -> [>`widget] obj ->
      tooltip:string -> tooltip_private:string -> pos:int -> unit
      = "ml_gtk_toolbar_insert_widget"
  let insert_widget w ?(tooltip="") ?(tooltip_private="") ?(pos = -1) w' =
    insert_widget w w' ~tooltip ~tooltip_private ~pos
  external set_tooltips : [>`toolbar] obj -> bool -> unit =
    "ml_gtk_toolbar_set_tooltips"
  let set ?orientation ?style ?tooltips w =
    may orientation ~f:(set P.orientation w);
    may style ~f:(set P.toolbar_style w);
    may tooltips ~f:(set_tooltips w)
end

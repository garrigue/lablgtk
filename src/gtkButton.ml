(**************************************************************************)
(*                Lablgtk                                                 *)
(*                                                                        *)
(*    This program is free software; you can redistribute it              *)
(*    and/or modify it under the terms of the GNU Library General         *)
(*    Public License as published by the Free Software Foundation         *)
(*    version 2, with the exception described in file COPYING which       *)
(*    comes with the library.                                             *)
(*                                                                        *)
(*    This program is distributed in the hope that it will be useful,     *)
(*    but WITHOUT ANY WARRANTY; without even the implied warranty of      *)
(*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       *)
(*    GNU Library General Public License for more details.                *)
(*                                                                        *)
(*    You should have received a copy of the GNU Library General          *)
(*    Public License along with this program; if not, write to the        *)
(*    Free Software Foundation, Inc., 59 Temple Place, Suite 330,         *)
(*    Boston, MA 02111-1307  USA                                          *)
(*                                                                        *)
(*                                                                        *)
(**************************************************************************)

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

module Toolbar = Toolbar

module ColorButton = ColorButton

module FontButton = FontButton

module LinkButton = struct 
  include LinkButton
  external create : string -> [>`linkbutton] obj = "ml_gtk_link_button_new"
  external create_with_label : string -> string -> [>`linkbutton] obj = "ml_gtk_link_button_new_with_label"
end

module ToolItem = ToolItem

module SeparatorToolItem = SeparatorToolItem

module ToolButton = ToolButton

module ToggleToolButton = ToggleToolButton

module RadioToolButton = RadioToolButton

module MenuToolButton = MenuToolButton

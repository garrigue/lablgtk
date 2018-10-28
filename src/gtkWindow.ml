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
open GtkBaseProps
open GtkBase

external _gtkwindow_init : unit -> unit = "ml_gtkwindow_init"
let () = _gtkwindow_init ()

module Window = struct
  include Window
  external set_wmclass : [>`window] obj -> name:string -> clas:string -> unit
      = "ml_gtk_window_set_wmclass"
  external add_accel_group : [>`window] obj -> accel_group -> unit
      = "ml_gtk_window_add_accel_group"
  external remove_accel_group : [>`window] obj -> accel_group -> unit
      = "ml_gtk_window_remove_accel_group"
  external activate_focus : [>`window] obj -> bool
      = "ml_gtk_window_activate_focus"
  external activate_default : [>`window] obj -> bool
      = "ml_gtk_window_activate_default"
  external set_geometry_hints :
      [>`window] obj -> ?pos: bool -> ?min_size: int * int ->
      ?max_size: int * int -> ?base_size: int * int ->
      ?aspect: float * float -> ?resize_inc: int * int ->
      ?win_gravity: Gdk.Tags.gravity -> ?user_pos: bool ->
      ?user_size: bool -> [>`widget] obj -> unit
      = "ml_gtk_window_set_geometry_hints_bc"
        "ml_gtk_window_set_geometry_hints"
  external list_toplevels : unit -> window obj list
      = "ml_gtk_window_list_toplevels"
  external add_mnemonic :
      [>`window] obj -> Gdk.keysym -> [>`widget] obj -> unit
      = "ml_gtk_window_add_mnemonic"
  external remove_mnemonic :
      [>`window] obj -> Gdk.keysym -> [>`widget] obj -> unit
      = "ml_gtk_window_remove_mnemonic"
  external activate_mnemonic :
      [>`window] obj -> ?modi: Gdk.Tags.modifier list -> Gdk.keysym -> unit
      = "ml_gtk_window_mnemonic_activate"
  external get_focus : [>`window] obj -> widget obj
      = "ml_gtk_window_get_focus"
  (* set_focus/default are called by Widget.grab_focus/default *)
  external set_focus : [>`window] obj -> [>`widget] obj -> unit
      = "ml_gtk_window_set_focus"
  external set_default : [>`window] obj -> [>`widget] obj -> unit
      = "ml_gtk_window_set_default"
  (* see gtk.props for others *)
end

module Dialog = struct
  include Dialog
  external action_area : [>`dialog] obj -> button_box obj
      = "ml_gtk_dialog_get_action_area"
  external vbox : [>`dialog] obj -> box obj
      = "ml_gtk_dialog_get_content_area"
  external add_button : [>`dialog] obj -> string -> int -> unit 
      = "ml_gtk_dialog_add_button"
  external response : [>`dialog] obj -> int -> unit
      = "ml_gtk_dialog_response"
  external set_response_sensitive : [>`dialog] obj -> int -> bool -> unit
      = "ml_gtk_dialog_set_response_sensitive"
  external set_default_response : [>`dialog] obj -> int -> unit
      = "ml_gtk_dialog_set_default_response"
  external run : [>`dialog] obj -> int
      = "ml_gtk_dialog_run"
  let std_response = Gpointer.encode_variant GtkEnums.Conv.response_tbl
  let decode_response = Gpointer.decode_variant GtkEnums.Conv.response_tbl
end

module MessageDialog = MessageDialog

module AboutDialog = struct
  include AboutDialog
  external create : unit -> Gtk.about_dialog obj = "ml_gtk_about_dialog_new"
end

module Plug = struct
  include Plug
(*  external create : Gdk.native_window -> plug obj = "ml_gtk_plug_new"*)
end

module Socket = Socket

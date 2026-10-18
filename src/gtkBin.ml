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
open Gtk
open Tags
open GtkBinProps
open GtkBase

module Alignment = Alignment

module EventBox = EventBox

module Frame = Frame

module AspectFrame = AspectFrame

module HandleBox = HandleBox

module Viewport = Viewport

module ScrolledWindow = ScrolledWindow

module Invisible = Invisible

module Expander = Expander

module Popover = struct
  include Popover
  external set_pointing_to : [> `popover] Gtk.obj -> Gdk.Rectangle.t -> unit
    = "ml_gtk_popover_set_pointing_to"
  external get_pointing_to_raw : [> `popover] Gtk.obj -> (int * int * int * int) option
    = "ml_gtk_popover_get_pointing_to"
  let get_pointing_to obj =
    match get_pointing_to_raw obj with
    | None -> None
    | Some (x, y, width, height) ->
        Some (Gdk.Rectangle.create ~x ~y ~width ~height)
end

module Overlay = struct
  include Overlay
  external add_overlay : [> `overlay] Gtk.obj -> [> `widget] Gtk.obj -> unit
    = "ml_gtk_overlay_add_overlay"
end
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
open GtkPackProps
open GtkBase

external _gtkpack_init : unit -> unit = "ml_gtkpack_init"
let () = _gtkpack_init ()

module Box = struct
  include Box
  let pack box ?from:( dir = (`START : pack_type))
      ?(expand=false) ?(fill=true) ?(padding=0) child =
    (match dir with `START -> pack_start | `END -> pack_end)
      box child ~expand ~fill ~padding
end

module BBox = ButtonBox

module Fixed = Fixed

module Layout = Layout

module Paned = Paned

module Notebook = Notebook

module SizeGroup = SizeGroup

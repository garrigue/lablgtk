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

open Gtk
open GtkMain
open GObj
open OgtkMainProps

module Main = Main

module Grab = struct
  open Grab
  let add (w : #widget) = add w#as_widget
  let remove (w : #widget) = remove w#as_widget
  let get_current () = new widget (get_current ())
end

module Rc = Rc

module Timeout = Glib.Timeout

module Idle = Glib.Idle

module Io = Glib.Io

open Main
let main = main
let quit = quit
let init = init

let selection = GData.clipboard Gdk.Atom.primary
let clipboard = GData.clipboard Gdk.Atom.clipboard

class settings
  (obj: ([>Gtk.settings] as 'a) obj) = object
    inherit gtkobj obj
    method private obj = (obj :> 'a obj)
    inherit settings_props
  end

let settings
  ?screen
  () =
    let obj = match screen with
    | Some screen ->
        GtkMain.Settings.get_for_screen screen
    | None ->
        GtkMain.Settings.get_default () in
    new settings obj


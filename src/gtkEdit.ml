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

open StdLabels
open Gaux
open Gobject
open Gtk
open Tags
open GtkEditProps
open GtkBase

external _gtkedit_init : unit -> unit = "ml_gtkedit_init"
let () = _gtkedit_init ()

module Editable = struct
  include Editable
  let marshal_insert f argv =
    match List.tl (Closure.get_args argv) with
    | `STRING _ :: `INT len :: `POINTER(Some p) :: _ ->
        (* XXX These two accesses are implementation-dependent *)
        let s = Gpointer.peek_string (Closure.get_pointer argv ~pos:1) ~len
        and pos = ref (Gpointer.peek_int p) in
        (f s ~pos : unit); Gpointer.poke_int p !pos
    | _ -> invalid_arg "GtkEdit.Editable.marshal_insert"
  let () = Internal.marshal_insert := marshal_insert
end

module Entry = Entry

module SpinButton = struct
  include SpinButton
  let get_value_as_int w = truncate (floor (get P.value w +. 0.5))
end

module ComboBox = GtkEditProps.ComboBox

module ComboBoxText = GtkEditProps.ComboBoxText

module EntryCompletion = GtkEditProps.EntryCompletion

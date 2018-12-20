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

open Gobject
open GtkBuilder
open GtkBuilderProps

class builder (obj : [> Gtk.builder] obj) = object
  inherit GObj.gtkobj obj
  inherit OgtkBuilderProps.builder_props

  method add_from_file : string -> unit = Builder.add_from_file obj
  method add_objects_from_file : string -> string list -> unit = Builder.add_objects_from_file obj
  method get_object : string -> unit obj = Builder.get_object obj
end

let builder_new ?translation_domain () =
  Builder.make_params ?translation_domain [] ~cont:(
  fun _ -> new builder (GtkBuilder.Builder.new_ ()))

let builder_new_from_file ?translation_domain filename =
  Builder.make_params ?translation_domain [] ~cont:(
  fun _ -> new builder (GtkBuilder.Builder.new_from_file filename))

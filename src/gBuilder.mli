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

class builder :
  ([> Gtk.builder] as 'a) Gtk.obj ->
  object
    inherit GObj.gtkobj
    val obj : 'a Gtk.obj

    (** Properties *)

    method translation_domain : string
    method set_translation_domain : string -> unit

    method add_from_file : string -> unit
    method add_from_string : string -> unit
    method add_objects_from_file : string -> string list -> unit
    method add_objects_from_string : string -> string list -> unit
    method get_object : string -> unit obj
  end

(** Build an interface from an XML UI definition.
    @gtkdoc gtk GtkBuilder
    @since GTK 3.10 *)
val builder_new : ?translation_domain:string -> unit -> builder

(** Build an interface from an XML UI definition.
    @gtkdoc gtk GtkBuilder
    @since GTK 3.10 *)
val builder_new_from_file : ?translation_domain:string -> string -> builder

(** Build an interface from an XML UI definition.
    @gtkdoc gtk GtkBuilder
    @since GTK 3.10 *)
val builder_new_from_string : ?translation_domain:string -> string -> builder

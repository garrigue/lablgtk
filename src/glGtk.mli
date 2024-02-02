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
open GObj

type gl_area = [Gtk.drawing_area|`glarea]

module GtkRaw :
  sig
    external create : unit -> gl_area obj = "ml_gtk_gl_area_new"
    external make_current : [>`glarea] obj -> unit = "ml_gtk_gl_area_make_current"

    external set_has_alpha : [>`glarea] obj -> bool -> unit = "ml_gtk_gl_area_set_has_alpha"
    external get_has_alpha : [>`glarea] obj -> bool = "ml_gtk_gl_area_get_has_alpha"

    external set_has_depth_buffer : [>`glarea] obj -> bool -> unit = "ml_gtk_gl_area_set_has_depth_buffer"
    external get_has_depth_buffer : [>`glarea] obj -> bool = "ml_gtk_gl_area_get_has_depth_buffer"

    external set_has_stencil_buffer : [>`glarea] obj -> bool -> unit = "ml_gtk_gl_area_set_has_stencil_buffer"
    external get_has_stencil_buffer : [>`glarea] obj -> bool = "ml_gtk_gl_area_get_has_stencil_buffer"

    external set_has_auto_render : [>`glarea] obj -> bool -> unit = "ml_gtk_gl_area_set_auto_render"
    external get_has_auto_render : [>`glarea] obj -> bool = "ml_gtk_gl_area_get_auto_render"

    external set_required_version : [>`glarea] obj -> int -> int -> unit = "ml_gtk_gl_area_set_required_version"
    external get_required_version : [>`glarea] obj -> (int * int) = "ml_gtk_gl_area_get_required_version"

  end

class area_signals : 'a obj ->
  object
    inherit GObj.widget_signals
    constraint 'a = [> gl_area]
    val obj : 'a obj
    method display : callback:(unit -> unit) -> GtkSignal.id
    method realize : callback:(unit -> unit) -> GtkSignal.id
    method render: callback:(unit -> bool) -> GtkSignal.id
    method reshape :
      callback:(width:int -> height:int -> unit) -> GtkSignal.id
  end

class area : gl_area obj ->
  object
    inherit GObj.widget
    val obj : gl_area obj
    method event : event_ops
    method as_area : gl_area obj
    method connect : area_signals

    method make_current : unit -> unit

    method set_has_alpha : bool -> unit
    method get_has_alpha : unit -> bool

    method set_has_depth_buffer : bool -> unit
    method get_has_depth_buffer : unit -> bool

    method set_has_stencil_buffer : bool -> unit
    method get_has_stencil_buffer : unit -> bool

    method set_has_auto_render : bool -> unit
    method get_has_auto_render : unit -> bool

    method set_required_version : int -> int -> unit
    method get_required_version : unit -> (int * int)

  end

val area : ?packing:(widget -> unit) -> ?show:bool -> unit -> area


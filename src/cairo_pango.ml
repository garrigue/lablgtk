(* File: cairo_pango.ml

   Copyright (C) 2018-

     Christophe Troestler <Christophe.Troestler@umons.ac.be>
     WWW: http://math.umons.ac.be/an/software/

   This library is free software; you can redistribute it and/or modify
   it under the terms of the GNU Lesser General Public License version 3 or
   later as published by the Free Software Foundation, with the special
   exception on linking described in the file LICENSE.

   This library is distributed in the hope that it will be useful, but
   WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the file
   LICENSE for more details. *)

module Font_map = struct
  type t = [`pangofontmap | `cairo] Gobject.obj

  external get_default : unit -> Pango.font_map
    = "caml_pango_cairo_font_map_get_default"
  external set_default : t -> unit
    = "caml_pango_cairo_font_map_set_default"  [@@noalloc]
  external create : unit -> Pango.font_map
    = "caml_pango_cairo_font_map_new"
  external create_for_font_type : Cairo.font_type -> Pango.font_map
    = "caml_pango_cairo_font_map_new_for_font_type"
  external get_font_type : t -> Cairo.font_type
    = "caml_pango_cairo_font_map_get_font_type"
  external set_resolution : t -> float -> unit
    = "caml_pango_cairo_font_map_set_resolution" [@@noalloc]
  external get_resolution : t -> float
    = "caml_pango_cairo_font_map_get_resolution"
  external create_context : Pango.font_map -> Pango.context
    = "caml_cairo_pango_font_map_create_context"
end

type cairo_font = [`pangofont | `cairo] Gobject.obj

external get_scaled_font : cairo_font -> _ Cairo.Scaled_font.t
  = "caml_pango_cairo_font_get_scaled_font"
external set_resolution : Pango.context -> float -> unit
  = "caml_pango_cairo_context_set_resolution"  [@@noalloc]
external get_resolution : Pango.context -> float
  = "caml_pango_cairo_context_get_resolution"
external set_font_options : Pango.context -> Cairo.Font_options.t -> unit
  = "caml_pango_cairo_context_set_font_options"  [@@noalloc]
external get_font_options : Pango.context -> Cairo.Font_options.t
  = "caml_pango_cairo_context_get_font_options"
external create_context : Cairo.context -> Pango.context
  = "caml_pango_cairo_create_context"
external update_context : Cairo.context -> Pango.context -> unit
  = "caml_pango_cairo_update_context"  [@@noalloc]
external create_layout : Cairo.context -> Pango.layout
  = "caml_pango_cairo_create_layout"
external update_layout : Cairo.context -> Pango.layout -> unit
  = "caml_pango_cairo_update_layout"  [@@noalloc]
external show_layout : Cairo.context -> Pango.layout -> unit
  = "caml_pango_cairo_show_layout"  [@@noalloc]
external show_error_underline :
  Cairo.context -> float -> float -> w:float -> h:float -> unit
  = "caml_pango_cairo_show_error_underline"
external layout_path : Cairo.context -> Pango.layout -> unit
  = "caml_pango_cairo_layout_path"
external error_underline_path :
  Cairo.context -> float -> float -> w:float -> h:float -> unit
  = "caml_pango_cairo_error_underline_path"

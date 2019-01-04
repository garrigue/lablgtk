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
open Pango
open Font

let to_pixels (x : units) = (x-1) / scale + 1
let from_pixels x : units = x * scale

class metrics obj = object
  method ascent = get_ascent obj
  method descent = get_descent obj
  method approx_char_width = get_approximate_char_width obj
  method approx_digit_width = get_approximate_digit_width obj
end

class font_description fd = object
  method fd = fd
  method copy = new font_description (copy fd)
  method to_string = to_string fd
  method family = get_family fd
  method style = get_style fd
  method variant = get_variant fd
  method weight = get_weight fd
  method stretch = get_stretch fd
  method size = get_size fd
  method modify = modify fd
end

let font_description_from_string s = new font_description (from_string s)

open Context

class layout obj = object
  val obj = obj
  method as_layout = obj
  method copy = new layout (Layout.copy obj)
  method get_context = new context (Layout.get_context obj)
  method get_text = Layout.get_text obj
  method set_text s = Layout.set_text obj s
  method set_markup s = Layout.set_markup obj s
  method set_markup_with_accel s c = Layout.set_markup_with_accel obj s c
  method set_font_description (fd : font_description) = Layout.set_font_description obj fd#fd
  method get_width = Layout.get_width obj
  method set_width w = Layout.set_width obj w
  method get_indent = Layout.get_indent obj
  method set_indent i = Layout.set_indent obj i
  method get_spacing = Layout.get_spacing obj
  method set_spacing s = Layout.set_spacing obj s
  method get_wrap = Layout.get_wrap obj
  method set_wrap w = Layout.set_wrap obj w
  method get_justify = Layout.get_justify obj
  method set_justify b = Layout.set_justify obj b
  method get_single_paragraph_mode = Layout.get_single_paragraph_mode obj
  method set_single_paragraph_mode b = Layout.set_single_paragraph_mode obj b
  method context_changed = Layout.context_changed obj
  method get_size = Layout.get_size obj
  method get_pixel_size = Layout.get_pixel_size obj
  method get_extent = Layout.get_extent obj
  method get_pixel_extent = Layout.get_pixel_extent obj
  method index_to_pos i = Layout.index_to_pos obj i
  method xy_to_index ~x ~y = Layout.xy_to_index obj ~x ~y
  method get_ellipsize = Layout.get_ellipsize obj
  method set_ellipsize m = Layout.set_ellipsize obj m
end

and context obj = object (self)
  val obj = obj
  method as_context = obj
  method font_description = new font_description (get_font_description obj)
  method font_name = Font.to_string (get_font_description obj)
  method language = Language.to_string (get_language obj)
  method load_font desc = load_font obj (Font.from_string desc)
  method load_fontset
      ?(desc = self#font_description) ?(lang = self#language) () =
    load_fontset obj (desc#fd) (Language.from_string lang)
  method get_metrics
      ?(desc = self#font_description) ?(lang = self#language) () =
    new metrics (get_metrics obj (desc#fd) (Some (Language.from_string lang)))
  method create_layout = new layout (Layout.create obj)
end

class context_rw obj = object
  inherit context obj
  method set_font_description (desc : font_description) =
    set_font_description obj desc#fd
  method set_font_by_name desc =
    set_font_description obj (Font.from_string desc)
  method set_language lang = set_language obj (Language.from_string lang)
end

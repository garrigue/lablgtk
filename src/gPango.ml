(* $Id$ *)

open Gaux
open Pango
open Font

let to_pixels x = (x-1 / scale) + 1
let from_pixels x = x * scale

class metrics obj = object
  method ascent = get_ascent obj
  method descent = get_descent obj
  method approx_char_width = get_approximate_char_width obj
  method approx_digit_width = get_approximate_digit_width obj
end

let font_description = from_string

open Context

class context obj = object (self)
  val obj = obj
  method as_context = obj
  method font_description = get_font_description obj
  method font_name = Font.to_string (get_font_description obj)
  method language = Language.to_string (get_language obj)
  method load_font desc = load_font obj (Font.from_string desc)
  method load_fontset
      ?(desc = self#font_description) ?(lang = self#language) () =
    load_fontset obj desc (Language.from_string lang)
  method get_metrics
      ?(desc = self#font_description) ?(lang = self#language) () =
    new metrics (get_metrics obj desc (Some (Language.from_string lang)))
end

class context_rw obj = object
  inherit context obj
  method set_font_description desc = set_font_description obj desc
  method set_font_by_name desc =
    set_font_description obj (Font.from_string desc)
  method set_language lang = set_language obj (Language.from_string lang)
end

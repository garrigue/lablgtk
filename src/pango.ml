(* $Id$ *)

open Gobject

type context = [`pangocontext] obj
type font = [`pangofont] obj
type font_description
type font_metrics
type language

module Tags = struct
  type style =
      [ `NORMAL | `OBLIQUE | `ITALIC ]
  external style_to_int : style -> int = "ml_Pango_style_val"
  type weight_internal =
      [ `ULTRALIGHT | `LIGHT | `NORMAL |`BOLD | `ULTRABOLD |`HEAVY ]
  external weight_to_int_internal : weight_internal -> int 
    = "ml_Pango_weight_val"
  type weight = [ weight_internal | `CUSTOM of int]
  let weight_to_int (w : weight) =
    match w with 
      | `CUSTOM b -> b 
      | #weight_internal as w -> weight_to_int_internal w
  type variant =
        [ `NORMAL | `SMALL_CAPS ]
  type stretch =
      [ `ULTRA_CONDENSED | `EXTRA_CONDENSED 
      | `CONDENSED | `SEMI_CONDENSED 
      | `NORMAL | `SEMI_EXPANDED
      | `EXPANDED | `EXTRA_EXPANDED | `ULTRA_EXPANDED ]
  type scale =
      [ `XX_SMALL | `X_SMALL | `SMALL | `MEDIUM 
      | `LARGE | `X_LARGE | `XX_LARGE
      | `CUSTOM of float ]
  external scale_to_float : scale -> float = "ml_Pango_scale_val"
  type underline = [ `NONE | `SINGLE | `DOUBLE | `LOW ]
  external underline_to_int : underline -> int = "ml_Pango_underline_val"
  external justification_to_int : Gtk.Tags.justification -> int 
    = "ml_Justification_val"
  external text_direction_to_int : Gtk.Tags.text_direction -> int 
    = "ml_Text_direction_val"
end

module Font = struct
  external from_string : string -> font_description = 
    "ml_pango_font_description_from_string"
  external copy : font_description -> font_description = 
    "ml_pango_font_description_copy"

  external get_metrics : font -> language -> font_metrics =
    "ml_pango_font_get_metrics"

  external get_ascent : font_metrics -> int =
    "ml_pango_font_metrics_get_ascent"
  external get_descent : font_metrics -> int =
    "ml_pango_font_metrics_get_descent"
  external get_approximate_char_width : font_metrics -> int =
    "ml_pango_font_metrics_get_approximate_char_width"
  external get_approximate_digit_width : font_metrics -> int =
    "ml_pango_font_metrics_get_approximate_digit_width"
end

module Language = struct
  external from_string : string -> language = "ml_pango_language_from_string"
  external to_string : language -> string = "ml_pango_language_to_string"
  external matches : language -> string -> bool = "ml_pango_language_matches"
  let none : language = Obj.magic Gpointer.boxed_null
end

module Context = struct
  let cast w : context = Gobject.try_cast w "PangoContext"
  external get_font_description : context -> font_description =
    "ml_pango_context_get_font_description"
  external set_font_description : context -> font_description -> unit =
    "ml_pango_context_set_font_description"
  external get_language : context -> language =
    "ml_pango_context_get_language"
  external set_language : context -> language -> unit =
    "ml_pango_context_set_language"
  external load_font : context -> font_description -> font =
    "ml_pango_context_load_font"
  external load_fontset : context -> font_description -> language -> font =
    "ml_pango_context_load_fontset"
  external get_metrics :
    context -> font_description -> language -> font_metrics =
    "ml_pango_context_get_metrics"
end

external scale : unit -> int = "ml_PANGO_SCALE"
let scale = scale ()

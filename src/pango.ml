module Font = struct
  type description
  type style =
      [ `NORMAL | `OBLIQUE | `ITALIC ]
  external style_to_int : style -> int = "ml_PangoStyle_Val"
  type weight =
      [ `ULTRALIGHT | `LIGHT | `NORMAL |`BOLD | `ULTRABOLD |`HEAVY
      | `CUSTOM of int]
      
  external weight_to_int_internal :
    [< `ULTRALIGHT | `LIGHT | `NORMAL |`BOLD | `ULTRABOLD |`HEAVY] -> int 
    = "ml_PangoWeight_Val"
  let weight_to_int (w:weight) =
    match w with 
      | `CUSTOM b -> b 
      | `ULTRALIGHT | `LIGHT | `NORMAL |`BOLD | `ULTRABOLD |`HEAVY 
	  as w -> weight_to_int_internal w
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
  external scale_to_float_unsafe : [< `XX_SMALL | `X_SMALL | `SMALL | `MEDIUM 
      | `LARGE | `X_LARGE | `XX_LARGE] -> float = "ml_PangoScale_Val"
  let scale_to_float s = 
    match s with 
      | `CUSTOM b -> b 
      |`XX_SMALL | `X_SMALL | `SMALL | `MEDIUM 
      | `LARGE | `X_LARGE | `XX_LARGE as w -> scale_to_float_unsafe w
  type underline = [ `NONE | `SINGLE | `DOUBLE | `LOW ]
  external underline_to_int : underline -> int = "ml_PangoUnderline_Val"
  external justification_to_int : Gtk.Tags.justification -> int 
    = "ml_PangoJustification_Val"
  external text_direction_to_int : Gtk.Tags.text_direction -> int 
    = "ml_PangoTextDirection_Val"
  external from_string : string -> description = 
      "ml_pango_font_description_from_string"
  external copy : description -> description = 
	  "ml_pango_font_description_copy"
  external free : description -> unit = 
  "ml_pango_font_description_free"
    
end

external scale : unit -> int = "ml_PANGO_SCALE"
let scale = scale ()


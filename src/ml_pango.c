/* $Id$ */

#include <stdio.h>
#include <pango/pango.h>

#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>
#include <caml/fail.h>
#include <caml/custom.h>

#include "wrappers.h"
#include "ml_glib.h"
#include "ml_gobject.h"
#include "ml_pango.h"
#include "pango_tags.h"
#include "gtk_tags.h"
#include "pango_tags.c"

/* PangoFontDescription */

Make_Val_final_pointer (PangoFontDescription, pango_font_description_copy,
                        pango_font_description_free, 20)
Make_Val_final_pointer_ext (PangoFontDescription, _new, Ignore,
                            pango_font_description_free, 20)

ML_1(pango_font_description_from_string, String_val,
     Val_PangoFontDescription_new)
ML_1(pango_font_description_copy, PangoFontDescription_val,
     Val_PangoFontDescription_new)
ML_1(pango_font_description_free, PangoFontDescription_val, Unit)

/* PangoFontMetrics */

Make_Val_final_pointer (PangoFontMetrics, pango_font_metrics_ref,
                        pango_font_metrics_unref, 20)
Make_Val_final_pointer_ext (PangoFontMetrics, _new, Ignore,
                            pango_font_metrics_unref, 20)

ML_1 (pango_font_metrics_get_ascent, PangoFontMetrics_val, Val_int)
ML_1 (pango_font_metrics_get_descent, PangoFontMetrics_val, Val_int)
ML_1 (pango_font_metrics_get_approximate_char_width,
      PangoFontMetrics_val, Val_int)
ML_1 (pango_font_metrics_get_approximate_digit_width,
      PangoFontMetrics_val, Val_int)

/* PangoFont */

#define Val_PangoFont_new(val) Val_GObject_new(G_OBJECT(val))
ML_2 (pango_font_get_metrics, PangoFont_val, PangoLanguage_val,
      Val_PangoFontMetrics_new)

/* Enums */

CAMLprim value ml_PANGO_SCALE ()
{
  return(Val_int(PANGO_SCALE));
}

ML_1 (Pango_style_val, 0+, Val_int)
ML_1 (Pango_underline_val, 0+, Val_int)
ML_1 (Justification_val, 0+, Val_int)
ML_1 (Text_direction_val, 0+, Val_int)
ML_1 (Pango_weight_val, 0+, Val_int)

/* This one uses the generated MLTAG but not the conversion functions because
   we have defined float values */
value ml_Pango_scale_val (value val) 
{
  double r;
  if (Is_block(val)) return Field(val,1); /* `CUSTOM */
  switch(val)
    {
    case MLTAG_XX_SMALL: r = PANGO_SCALE_XX_SMALL ;break;
    case MLTAG_X_SMALL:	 r = PANGO_SCALE_X_SMALL ;break;
    case MLTAG_SMALL:	 r = PANGO_SCALE_SMALL ;break;
    case MLTAG_MEDIUM:	 r = PANGO_SCALE_MEDIUM ;break;
    case MLTAG_LARGE:	 r = PANGO_SCALE_LARGE ;break;
    case MLTAG_X_LARGE:	 r = PANGO_SCALE_X_LARGE ;break;
    case MLTAG_XX_LARGE: r = PANGO_SCALE_XX_LARGE ;break;
    default: printf("Bug in ml_PangoScale_val. Please report");
      r=1;
      break;
    }
  return copy_double(r);
}

/* PangoLanguage */

ML_1 (pango_language_from_string, String_val, Val_PangoLanguage)
ML_1 (pango_language_to_string, PangoLanguage_val, Val_optstring)
ML_2 (pango_language_matches, PangoLanguage_val, String_val, Val_bool)

/* PangoContext */

ML_1 (pango_context_get_font_description, PangoContext_val,
      Val_PangoFontDescription)
ML_2 (pango_context_set_font_description, PangoContext_val,
      PangoFontDescription_val, Unit)
ML_1 (pango_context_get_language, PangoContext_val, Val_PangoLanguage)
ML_2 (pango_context_set_language, PangoContext_val, PangoLanguage_val, Unit)
ML_2 (pango_context_load_font, PangoContext_val, PangoFontDescription_val,
      Val_PangoFont_new)
ML_3 (pango_context_load_fontset, PangoContext_val, PangoFontDescription_val,
      PangoLanguage_val, Val_PangoFont_new)
ML_3 (pango_context_get_metrics, PangoContext_val, PangoFontDescription_val,
      PangoLanguage_val, Val_PangoFontMetrics_new)

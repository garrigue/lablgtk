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
#include "ml_pango.h"
#include "gtk_tags.h"
#include "pango_tags.c"

#define Val_PangoFontDescription Val_pointer/* Must use Font.copy on ML side */


ML_1(pango_font_description_from_string,String_val,Val_PangoFontDescription)

ML_1(pango_font_description_copy,PangoFontDescription_val,Val_PangoFontDescription)
ML_1(pango_font_description_free,PangoFontDescription_val,Unit)

value ml_PANGO_SCALE ()
{
  return(Val_int(PANGO_SCALE));
}

value ml_PangoStyle_Val (value val) 
{
  return(Val_int(Pango_style_val(val)));
}

value ml_PangoUnderline_Val (value val) 
{
  return(Val_int(Pango_underline_val(val)));
}

value ml_PangoJustification_Val (value val) 
{
  return(Val_int(Justification_val(val)));
}

value ml_PangoTextDirection_Val (value val) 
{
  return(Val_int(Text_direction_val(val)));
}

value ml_PangoWeight_Val (value val) 
{
  return(Val_int(Pango_weight_val(val)));
}

/* This one uses the generated MLTAG but not the conversion functions because
   we have defined float values */
value ml_PangoScale_Val (value val) 
{
  CAMLparam1(val);
  double r;
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
  CAMLreturn(copy_double(r));
}

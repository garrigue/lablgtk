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

Make_Val_final_pointer_ext(PangoFontDescription, _mine,Ignore,pango_font_description_free,1)

value Val_PangoFontDescription(PangoFontDescription* it){
  return(Val_PangoFontDescription_mine(pango_font_description_copy(it))); 
}

CAMLprim value ml_pango_font_description_copy (value tm)
{
  CAMLparam1(tm);
  CAMLlocal1(res);
  res = Val_PangoFontDescription(PangoFontDescription_val(tm));
  CAMLreturn(res);
}

ML_1(pango_font_description_from_string,String_val,Val_PangoFontDescription)

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


#define Val_PangoFontDescription Val_pointer/* Must use Font.copy on ML side */


ML_1(pango_font_description_from_string,String_val,Val_PangoFontDescription)

ML_1(pango_font_description_copy,PangoFontDescription_val,Val_PangoFontDescription)
ML_1(pango_font_description_free,PangoFontDescription_val,Unit)


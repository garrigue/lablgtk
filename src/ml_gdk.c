/* $Id$ */

#include <gdk/gdk.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>

#include "wrappers.h"

extern void raise_with_string (value tag, const char * msg) Noreturn;

void ml_raise_gdk (const char *errmsg)
{
  static value * exn = NULL;
  if (exn == NULL)
      exn = caml_named_value ("gdkerror");
  raise_with_string (*exn, errmsg);
}

value ml_gdk_color_white (value cmap)
{
    value color = alloc (Wosizeof(GdkColor), Abstract_tag);
    gdk_color_white ((GdkColormap*)Pointer_val(cmap), (GdkColor*)color);
    return color;
}
    
value ml_gdk_color_black (value cmap)
{
    value color = alloc (Wosizeof(GdkColor), Abstract_tag);
    gdk_color_black ((GdkColormap*)Pointer_val(cmap), (GdkColor*)color);
    return color;
}

value ml_gdk_color_parse (char *spec)
{
    value color = alloc (Wosizeof(GdkColor), Abstract_tag);
    if (!gdk_color_parse (spec, (GdkColor*)color))
	ml_raise_gdk ("color_parse");
    return color;
}

ML_2 (gdk_color_alloc, (GdkColormap*)Pointer_val, (GdkColor*), Val_bool)

value ml_GdkColor (value red, value green, value blue)
{
    GdkColor *color = (GdkColor*) alloc (Wosizeof(GdkColor), Abstract_tag);
    color->red = Int_val(red);
    color->green = Int_val(green);
    color->blue = Int_val(blue);
    color->pixel = 0;
    return (value)color;
}

Make_Extractor (GdkColor,(GdkColor*),red,Val_int)
Make_Extractor (GdkColor,(GdkColor*),green,Val_int)
Make_Extractor (GdkColor,(GdkColor*),blue,Val_int)
Make_Extractor (GdkColor,(GdkColor*),pixel,Val_int)

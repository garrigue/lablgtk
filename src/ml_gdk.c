/* $Id$ */

#include <gdk/gdk.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>

#include "wrappers.h"
#include "ml_gdk.h"

extern void raise_with_string (value tag, const char * msg) Noreturn;

void ml_raise_gdk (const char *errmsg)
{
  static value * exn = NULL;
  if (exn == NULL)
      exn = caml_named_value ("gdkerror");
  raise_with_string (*exn, errmsg);
}

/* Color */

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

/* Rectangle */

value ml_GdkRectangle (value x, value y, value width, value height)
{
    GdkRectangle *rectangle =
        (GdkRectangle*) alloc (Wosizeof(GdkRectangle), Abstract_tag);
    rectangle->x = Int_val(x);
    rectangle->y = Int_val(y);
    rectangle->width = Int_val(width);
    rectangle->height = Int_val(height);
    return (value)rectangle;
}

Make_Extractor (GdkRectangle,(GdkRectangle*),x,Val_int)
Make_Extractor (GdkRectangle,(GdkRectangle*),y,Val_int)
Make_Extractor (GdkRectangle,(GdkRectangle*),width,Val_int)
Make_Extractor (GdkRectangle,(GdkRectangle*),height,Val_int)

/* Colormap */

Make_Val_final_pointer (GdkColormap, gdk_colormap_ref, gdk_colormap_unref)

/* Window */

Make_Val_final_pointer (GdkWindow, gdk_window_ref, gdk_window_unref)

/* Pixmap */

Make_Val_final_pointer (GdkPixmap, gdk_pixmap_ref, gdk_pixmap_unref)
Make_Val_final_pointer (GdkBitmap, gdk_bitmap_ref, gdk_bitmap_unref)
ML_4 (gdk_pixmap_new, GdkWindow_val, Int_val, Int_val, Int_val, Val_GdkPixmap)
ML_4 (gdk_bitmap_create_from_data, GdkWindow_val,
      String_val, Int_val, Int_val, Val_GdkBitmap)
ML_7 (gdk_pixmap_create_from_data, GdkWindow_val, String_val,
      Int_val, Int_val, Int_val, (GdkColor*), (GdkColor*), Val_GdkPixmap)
ML_bc7 (ml_gdk_pixmap_create_from_data)

value ml_gdk_pixmap_colormap_create_from_xpm
	(value window, value colormap, value transparent, char *filename)
{
    GdkBitmap *mask;
    value vpixmap =
	Val_GdkPixmap
	(gdk_pixmap_colormap_create_from_xpm (GdkWindow_val(window),
				     Option_val(colormap,GdkColormap_val,NULL),
				     &mask,
				     Option_val(transparent,(GdkColor*),NULL),
				     filename));
    value ret, vmask = Val_unit;

    Begin_roots2 (vpixmap, vmask);
    vmask = Val_GdkBitmap(mask);
    ret = alloc_tuple(2);
    Field(ret,0) = vpixmap;
    Field(ret,1) = vmask;
    End_roots ();

    return ret;
}

value ml_gdk_pixmap_colormap_create_from_xpm_d
	(value window, value colormap, value transparent, char **data)
{
    GdkBitmap *mask;
    value ret, vpixmap, vmask;
    vpixmap =
	Val_GdkPixmap
	(gdk_pixmap_colormap_create_from_xpm_d
	 (GdkWindow_val(window), Option_val(colormap,GdkColormap_val,NULL),
	  &mask, Option_val(transparent,(GdkColor*),NULL), data));
    vmask = Val_unit;

    Begin_roots2 (vpixmap, vmask);
    vmask = Val_GdkBitmap(mask);
    ret = alloc_tuple(2);
    Field(ret,0) = vpixmap;
    Field(ret,1) = vmask;
    End_roots ();

    return ret;
}

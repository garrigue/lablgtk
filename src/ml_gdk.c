/* $Id$ */

#include <gdk/gdk.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>

#include "wrappers.h"
#include "ml_gdk.h"
#include "gdk_tags.h"

extern void raise_with_string (value tag, const char * msg) Noreturn;

void ml_raise_gdk (const char *errmsg)
{
  static value * exn = NULL;
  if (exn == NULL)
      exn = caml_named_value ("gdkerror");
  raise_with_string (*exn, errmsg);
}

#include "gdk_tags.c"

/* Color */

value ml_gdk_color_white (value cmap)
{
    value color = alloc (Wosizeof(GdkColor), Abstract_tag);
    gdk_color_white (GdkColormap_val(cmap), GdkColor_val(color));
    return color;
}
    
value ml_gdk_color_black (value cmap)
{
    value color = alloc (Wosizeof(GdkColor), Abstract_tag);
    gdk_color_black (GdkColormap_val(cmap), GdkColor_val(color));
    return color;
}

value ml_gdk_color_parse (char *spec)
{
    value color = alloc (Wosizeof(GdkColor), Abstract_tag);
    if (!gdk_color_parse (spec, GdkColor_val(color)))
	ml_raise_gdk ("color_parse");
    return color;
}

ML_2 (gdk_color_alloc, GdkColormap_val, GdkColor_val, Val_bool)

value ml_GdkColor (value red, value green, value blue)
{
    GdkColor *color = (GdkColor*) alloc (Wosizeof(GdkColor), Abstract_tag);
    color->red = Int_val(red);
    color->green = Int_val(green);
    color->blue = Int_val(blue);
    color->pixel = 0;
    return Val_GdkColor(color);
}

Make_Extractor (GdkColor,GdkColor_val,red,Val_int)
Make_Extractor (GdkColor,GdkColor_val,green,Val_int)
Make_Extractor (GdkColor,GdkColor_val,blue,Val_int)
Make_Extractor (GdkColor,GdkColor_val,pixel,Val_int)

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
      Int_val, Int_val, Int_val, GdkColor_val, GdkColor_val, Val_GdkPixmap)
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
				     Option_val(transparent,GdkColor_val,NULL),
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
	  &mask, Option_val(transparent,GdkColor_val,NULL), data));
    vmask = Val_unit;

    Begin_roots2 (vpixmap, vmask);
    vmask = Val_GdkBitmap(mask);
    ret = alloc_tuple(2);
    Field(ret,0) = vpixmap;
    Field(ret,1) = vmask;
    End_roots ();

    return ret;
}

/* Font */

Make_Val_final_pointer (GdkFont, gdk_font_ref, gdk_font_unref)
ML_1 (gdk_font_load, String_val, Val_GdkFont)
ML_1 (gdk_fontset_load, String_val, Val_GdkFont)
ML_2 (gdk_string_width, GdkFont_val, String_val, Val_int)
ML_2 (gdk_char_width, GdkFont_val, Char_val, Val_int)
ML_2 (gdk_string_measure, GdkFont_val, String_val, Val_int)
ML_2 (gdk_char_measure, GdkFont_val, Char_val, Val_int)

/* Events */

ML_1 (gdk_event_copy, (GdkEvent *), Val_any)
ML_1 (gdk_event_free, (GdkEvent *), Unit)

Make_Extractor (GdkEventAny, (GdkEventAny*), type, Val_gdkEventType)
Make_Extractor (GdkEventAny, (GdkEventAny*), window, Val_GdkWindow)
Make_Extractor (GdkEventAny, (GdkEventAny*), send_event, Val_bool)

Make_Extractor (GdkEventExpose, (GdkEventExpose*), area, (value)&)
Make_Extractor (GdkEventExpose, (GdkEventExpose*), count, Val_int)

Make_Extractor (GdkEventVisibility, (GdkEventVisibility*), state,
		Val_gdkVisibilityState)

Make_Extractor (GdkEventMotion, (GdkEventMotion*), time, Val_int)
Make_Extractor (GdkEventMotion, (GdkEventMotion*), x, copy_double)
Make_Extractor (GdkEventMotion, (GdkEventMotion*), y, copy_double)
Make_Extractor (GdkEventMotion, (GdkEventMotion*), pressure, copy_double)
Make_Extractor (GdkEventMotion, (GdkEventMotion*), xtilt, copy_double)
Make_Extractor (GdkEventMotion, (GdkEventMotion*), ytilt, copy_double)
Make_Extractor (GdkEventMotion, (GdkEventMotion*), state, Val_int)
Make_Extractor (GdkEventMotion, (GdkEventMotion*), is_hint, Val_int)
Make_Extractor (GdkEventMotion, (GdkEventMotion*), source, Val_gdkInputSource)
Make_Extractor (GdkEventMotion, (GdkEventMotion*), deviceid, Val_int)
Make_Extractor (GdkEventMotion, (GdkEventMotion*), x_root, copy_double)
Make_Extractor (GdkEventMotion, (GdkEventMotion*), y_root, copy_double)

Make_Extractor (GdkEventButton, (GdkEventButton*), time, Val_int)
Make_Extractor (GdkEventButton, (GdkEventButton*), x, copy_double)
Make_Extractor (GdkEventButton, (GdkEventButton*), y, copy_double)
Make_Extractor (GdkEventButton, (GdkEventButton*), pressure, copy_double)
Make_Extractor (GdkEventButton, (GdkEventButton*), xtilt, copy_double)
Make_Extractor (GdkEventButton, (GdkEventButton*), ytilt, copy_double)
Make_Extractor (GdkEventButton, (GdkEventButton*), state, Val_int)
Make_Extractor (GdkEventButton, (GdkEventButton*), button, Val_int)
Make_Extractor (GdkEventButton, (GdkEventButton*), source, Val_gdkInputSource)
Make_Extractor (GdkEventButton, (GdkEventButton*), deviceid, Val_int)
Make_Extractor (GdkEventButton, (GdkEventButton*), x_root, copy_double)
Make_Extractor (GdkEventButton, (GdkEventButton*), y_root, copy_double)

Make_Extractor (GdkEventKey, (GdkEventKey*), time, Val_int)
Make_Extractor (GdkEventKey, (GdkEventKey*), state, Val_int)
Make_Extractor (GdkEventKey, (GdkEventKey*), keyval, Val_int)
Make_Extractor (GdkEventKey, (GdkEventKey*), string, copy_string)

Make_Extractor (GdkEventCrossing, (GdkEventCrossing*), subwindow,
		Val_GdkWindow)
Make_Extractor (GdkEventCrossing, (GdkEventCrossing*), detail,
		Val_gdkNotifyType)

Make_Extractor (GdkEventFocus, (GdkEventFocus*), in, Val_int)

Make_Extractor (GdkEventConfigure, (GdkEventConfigure*), x, Val_int)
Make_Extractor (GdkEventConfigure, (GdkEventConfigure*), y, Val_int)
Make_Extractor (GdkEventConfigure, (GdkEventConfigure*), width, Val_int)
Make_Extractor (GdkEventConfigure, (GdkEventConfigure*), height, Val_int)

Make_Extractor (GdkEventProperty, (GdkEventProperty*), atom, Val_int)
Make_Extractor (GdkEventProperty, (GdkEventProperty*), time, Val_int)
Make_Extractor (GdkEventProperty, (GdkEventProperty*), state, Val_int)

Make_Extractor (GdkEventSelection, (GdkEventSelection*), selection, Val_int)
Make_Extractor (GdkEventSelection, (GdkEventSelection*), target, Val_int)
Make_Extractor (GdkEventSelection, (GdkEventSelection*), property, Val_int)
Make_Extractor (GdkEventSelection, (GdkEventSelection*), requestor, Val_int)
Make_Extractor (GdkEventSelection, (GdkEventSelection*), time, Val_int)

Make_Extractor (GdkEventProximity, (GdkEventProximity*), time, Val_int)
Make_Extractor (GdkEventProximity, (GdkEventProximity*), source,
		Val_gdkInputSource)
Make_Extractor (GdkEventProximity, (GdkEventProximity*), deviceid, Val_int)

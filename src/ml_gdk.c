/* $Id$ */

#include <strings.h>
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

Make_Flags_val (GdkModifier_val)

/* Colormap */

Make_Val_final_pointer (GdkColormap, gdk_colormap_ref, gdk_colormap_unref)
ML_0 (gdk_colormap_get_system, Val_GdkColormap)

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

Make_Copy (rectangle, GdkRectangle)    

/* Window */

Make_Val_final_pointer (GdkWindow, gdk_window_ref, gdk_window_unref)

/* Pixmap */

Make_Val_final_pointer (GdkPixmap, gdk_pixmap_ref, gdk_pixmap_unref)
Make_Val_final_pointer (GdkBitmap, gdk_bitmap_ref, gdk_bitmap_unref)
ML_4 (gdk_pixmap_new, GdkWindow_val, Int_val, Int_val, Int_val,
      Val_GdkPixmap_no_ref)
ML_4 (gdk_bitmap_create_from_data, GdkWindow_val,
      String_val, Int_val, Int_val, Val_GdkBitmap_no_ref)
ML_7 (gdk_pixmap_create_from_data, GdkWindow_val, String_val,
      Int_val, Int_val, Int_val, GdkColor_val, GdkColor_val,
      Val_GdkPixmap_no_ref)
ML_bc7 (ml_gdk_pixmap_create_from_data)

value ml_gdk_pixmap_colormap_create_from_xpm
	(value window, value colormap, value transparent, char *filename)
{
    GdkBitmap *mask;
    value vpixmap =
	Val_GdkPixmap_no_ref
	(gdk_pixmap_colormap_create_from_xpm (GdkWindow_val(window),
				     Option_val(colormap,GdkColormap_val,NULL),
				     &mask,
				     Option_val(transparent,GdkColor_val,NULL),
				     filename));
    value ret, vmask = Val_unit;

    Begin_roots2 (vpixmap, vmask);
    vmask = Val_GdkBitmap_no_ref (mask);
    ret = alloc_tuple (2);
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
	Val_GdkPixmap_no_ref
	(gdk_pixmap_colormap_create_from_xpm_d
	 (GdkWindow_val(window), Option_val(colormap,GdkColormap_val,NULL),
	  &mask, Option_val(transparent,GdkColor_val,NULL), data));
    vmask = Val_unit;

    Begin_roots2 (vpixmap, vmask);
    vmask = Val_GdkBitmap_no_ref (mask);
    ret = alloc_tuple (2);
    Field(ret,0) = vpixmap;
    Field(ret,1) = vmask;
    End_roots ();

    return ret;
}

/* Font */

Make_Val_final_pointer (GdkFont, gdk_font_ref, gdk_font_unref)
ML_1 (gdk_font_load, String_val, Val_GdkFont_no_ref)
ML_1 (gdk_fontset_load, String_val, Val_GdkFont_no_ref)
ML_2 (gdk_string_width, GdkFont_val, String_val, Val_int)
ML_2 (gdk_char_width, GdkFont_val, Char_val, Val_int)
ML_2 (gdk_string_measure, GdkFont_val, String_val, Val_int)
ML_2 (gdk_char_measure, GdkFont_val, Char_val, Val_int)

/* GC */

Make_Val_final_pointer (GdkGC, gdk_gc_ref, gdk_gc_unref)
ML_1 (gdk_gc_new, GdkWindow_val, Val_GdkGC_no_ref)
ML_2 (gdk_gc_set_foreground, GdkGC_val, GdkColor_val, Unit)
ML_2 (gdk_gc_set_background, GdkGC_val, GdkColor_val, Unit)
ML_2 (gdk_gc_set_font, GdkGC_val, GdkFont_val, Unit)
ML_2 (gdk_gc_set_function, GdkGC_val, GdkFunction_val, Unit)
ML_2 (gdk_gc_set_fill, GdkGC_val, GdkFill_val, Unit)
ML_2 (gdk_gc_set_tile, GdkGC_val, GdkPixmap_val, Unit)
ML_2 (gdk_gc_set_stipple, GdkGC_val, GdkPixmap_val, Unit)
ML_3 (gdk_gc_set_ts_origin, GdkGC_val, Int_val, Int_val, Unit)
ML_3 (gdk_gc_set_clip_origin, GdkGC_val, Int_val, Int_val, Unit)
ML_2 (gdk_gc_set_clip_mask, GdkGC_val, GdkBitmap_val, Unit)
ML_2 (gdk_gc_set_clip_rectangle, GdkGC_val, (GdkRectangle*), Unit)
ML_2 (gdk_gc_set_clip_region, GdkGC_val, (GdkRegion*), Unit)
ML_2 (gdk_gc_set_subwindow, GdkGC_val, GdkSubwindowMode_val, Unit)
ML_2 (gdk_gc_set_exposures, GdkGC_val, Bool_val, Unit)
ML_5 (gdk_gc_set_line_attributes, GdkGC_val, Int_val, GdkLineStyle_val,
      GdkCapStyle_val, GdkJoinStyle_val, Unit)
ML_2 (gdk_gc_copy, GdkGC_val, GdkGC_val, Unit)

/* Draw */

#define PointArray_val(val) ((GdkPoint*)&Field(val,1))
#define PointArrayLen_val(val) Int_val(Field(val,0))
value ml_point_array_new (value len)
{
    value ret = alloc_shr (1+Int_val(len)*Wosizeof(GdkPoint), Abstract_tag);
    Field(ret,0) = len;
    return ret;
}
value ml_point_array_set (value arr, value pos, value x, value y)
{
    GdkPoint *pt = PointArray_val(arr) + Int_val(pos);
    pt->x = Int_val(x);
    pt->y = Int_val(y);
    return Val_unit;
}

ML_4 (gdk_draw_point, GdkDrawable_val, GdkGC_val, Int_val, Int_val, Unit)
ML_6 (gdk_draw_line, GdkDrawable_val, GdkGC_val, Int_val, Int_val,
      Int_val, Int_val, Unit)
ML_bc6 (ml_gdk_draw_line)
ML_7 (gdk_draw_rectangle, GdkDrawable_val, GdkGC_val, Bool_val,
      Int_val, Int_val, Int_val, Int_val, Unit)
ML_bc7 (ml_gdk_draw_rectangle)
ML_9 (gdk_draw_arc, GdkDrawable_val, GdkGC_val, Bool_val, Int_val, Int_val,
      Int_val, Int_val, Int_val, Int_val, Unit)
ML_bc9 (ml_gdk_draw_arc)
ML_4 (gdk_draw_polygon, GdkDrawable_val, GdkGC_val, Bool_val,
      Insert(PointArray_val(arg4)) PointArrayLen_val, Unit)
ML_6 (gdk_draw_string, GdkDrawable_val, GdkFont_val, GdkGC_val, Int_val, Int_val, String_val, Unit)
ML_bc6 (ml_gdk_draw_string)

/* Events */

Make_Val_final_pointer (GdkEvent, , gdk_event_free)
ML_1 (gdk_event_copy, (GdkEvent*), Val_GdkEvent_no_ref)

Make_Extractor (GdkEventAny, GdkEvent_val(Any), type, Val_gdkEventType)
Make_Extractor (GdkEventAny, GdkEvent_val(Any), window, Val_GdkWindow)
Make_Extractor (GdkEventAny, GdkEvent_val(Any), send_event, Val_bool)

Make_Extractor (GdkEventExpose, GdkEvent_val(Expose), area, (value)&)
Make_Extractor (GdkEventExpose, GdkEvent_val(Expose), count, Val_int)

Make_Extractor (GdkEventVisibility, GdkEvent_val(Visibility), state,
		Val_gdkVisibilityState)

Make_Extractor (GdkEventMotion, GdkEvent_val(Motion), time, Val_int)
Make_Extractor (GdkEventMotion, GdkEvent_val(Motion), x, copy_double)
Make_Extractor (GdkEventMotion, GdkEvent_val(Motion), y, copy_double)
Make_Extractor (GdkEventMotion, GdkEvent_val(Motion), pressure, copy_double)
Make_Extractor (GdkEventMotion, GdkEvent_val(Motion), xtilt, copy_double)
Make_Extractor (GdkEventMotion, GdkEvent_val(Motion), ytilt, copy_double)
Make_Extractor (GdkEventMotion, GdkEvent_val(Motion), state, Val_int)
Make_Extractor (GdkEventMotion, GdkEvent_val(Motion), is_hint, Val_int)
Make_Extractor (GdkEventMotion, GdkEvent_val(Motion), source, Val_gdkInputSource)
Make_Extractor (GdkEventMotion, GdkEvent_val(Motion), deviceid, Val_int)
Make_Extractor (GdkEventMotion, GdkEvent_val(Motion), x_root, copy_double)
Make_Extractor (GdkEventMotion, GdkEvent_val(Motion), y_root, copy_double)

Make_Extractor (GdkEventButton, GdkEvent_val(Button), time, Val_int)
Make_Extractor (GdkEventButton, GdkEvent_val(Button), x, copy_double)
Make_Extractor (GdkEventButton, GdkEvent_val(Button), y, copy_double)
Make_Extractor (GdkEventButton, GdkEvent_val(Button), pressure, copy_double)
Make_Extractor (GdkEventButton, GdkEvent_val(Button), xtilt, copy_double)
Make_Extractor (GdkEventButton, GdkEvent_val(Button), ytilt, copy_double)
Make_Extractor (GdkEventButton, GdkEvent_val(Button), state, Val_int)
Make_Extractor (GdkEventButton, GdkEvent_val(Button), button, Val_int)
Make_Extractor (GdkEventButton, GdkEvent_val(Button), source, Val_gdkInputSource)
Make_Extractor (GdkEventButton, GdkEvent_val(Button), deviceid, Val_int)
Make_Extractor (GdkEventButton, GdkEvent_val(Button), x_root, copy_double)
Make_Extractor (GdkEventButton, GdkEvent_val(Button), y_root, copy_double)

Make_Extractor (GdkEventKey, GdkEvent_val(Key), time, Val_int)
Make_Extractor (GdkEventKey, GdkEvent_val(Key), state, Val_int)
Make_Extractor (GdkEventKey, GdkEvent_val(Key), keyval, Val_int)
Make_Extractor (GdkEventKey, GdkEvent_val(Key), string, copy_string)

Make_Extractor (GdkEventCrossing, GdkEvent_val(Crossing), subwindow,
		Val_GdkWindow)
Make_Extractor (GdkEventCrossing, GdkEvent_val(Crossing), detail,
		Val_gdkNotifyType)

Make_Extractor (GdkEventFocus, GdkEvent_val(Focus), in, Val_int)

Make_Extractor (GdkEventConfigure, GdkEvent_val(Configure), x, Val_int)
Make_Extractor (GdkEventConfigure, GdkEvent_val(Configure), y, Val_int)
Make_Extractor (GdkEventConfigure, GdkEvent_val(Configure), width, Val_int)
Make_Extractor (GdkEventConfigure, GdkEvent_val(Configure), height, Val_int)

Make_Extractor (GdkEventProperty, GdkEvent_val(Property), atom, Val_int)
Make_Extractor (GdkEventProperty, GdkEvent_val(Property), time, Val_int)
Make_Extractor (GdkEventProperty, GdkEvent_val(Property), state, Val_int)

Make_Extractor (GdkEventSelection, GdkEvent_val(Selection), selection, Val_int)
Make_Extractor (GdkEventSelection, GdkEvent_val(Selection), target, Val_int)
Make_Extractor (GdkEventSelection, GdkEvent_val(Selection), property, Val_int)
Make_Extractor (GdkEventSelection, GdkEvent_val(Selection), requestor, Val_int)
Make_Extractor (GdkEventSelection, GdkEvent_val(Selection), time, Val_int)

Make_Extractor (GdkEventProximity, GdkEvent_val(Proximity), time, Val_int)
Make_Extractor (GdkEventProximity, GdkEvent_val(Proximity), source,
		Val_gdkInputSource)
Make_Extractor (GdkEventProximity, GdkEvent_val(Proximity), deviceid, Val_int)

/* $Id$ */

#include <string.h>
#include <gdk/gdk.h>
#ifdef _WIN32
#include <gdk/win32/gdkwin32.h>
#else
#include <gdk/gdkx.h>
#endif
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>

#include "wrappers.h"
#include "ml_glib.h"
#include "ml_gdk.h"
#include "gdk_tags.h"

void ml_raise_gdk (const char *errmsg)
{
  static value * exn = NULL;
  if (exn == NULL)
      exn = caml_named_value ("gdkerror");
  raise_with_string (*exn, (char*)errmsg);
}

#include "gdk_tags.c"

Make_OptFlags_val (GdkModifier_val)
Make_Flags_val (Event_mask_val)

#define Make_test(conv) \
value ml_test_##conv (value mask, value test) \
{ return Val_bool (conv(mask) & Int_val(test)); }

Make_test(GdkModifier_val)

/* Colormap */

Make_Val_final_pointer (GdkColormap, gdk_colormap_ref, gdk_colormap_unref)
ML_0 (gdk_colormap_get_system, Val_GdkColormap)

/* Screen geometry */
ML_0 (gdk_screen_width, Val_int)
ML_0 (gdk_screen_height, Val_int)

/* Visual */
Make_Extractor (GdkVisual,GdkVisual_val,type,Val_gdkVisualType)
Make_Extractor (GdkVisual,GdkVisual_val,depth,Val_int)
Make_Extractor (GdkVisual,GdkVisual_val,red_mask,Val_int)
Make_Extractor (GdkVisual,GdkVisual_val,red_shift,Val_int)
Make_Extractor (GdkVisual,GdkVisual_val,red_prec,Val_int)
Make_Extractor (GdkVisual,GdkVisual_val,green_mask,Val_int)
Make_Extractor (GdkVisual,GdkVisual_val,green_shift,Val_int)
Make_Extractor (GdkVisual,GdkVisual_val,green_prec,Val_int)
Make_Extractor (GdkVisual,GdkVisual_val,blue_mask,Val_int)
Make_Extractor (GdkVisual,GdkVisual_val,blue_shift,Val_int)
Make_Extractor (GdkVisual,GdkVisual_val,blue_prec,Val_int)

ML_4 (gdk_image_new_bitmap, GdkVisual_val, String_val, Int_val, Int_val, Val_GdkImage)
ML_4 (gdk_image_new, GdkImageType_val, GdkVisual_val, Int_val, Int_val, Val_GdkImage)
ML_5 (gdk_image_get, GdkWindow_val, Int_val, Int_val, Int_val, Int_val, Val_GdkImage)
ML_4 (gdk_image_put_pixel, GdkImage_val, Int_val, Int_val, Int_val, Unit)
ML_3 (gdk_image_get_pixel, GdkImage_val, Int_val, Int_val, Val_int)
ML_1 (gdk_image_destroy, GdkImage_val, Unit)

/* Color */

value ml_gdk_color_white (value cmap)
{
    GdkColor color;
    gdk_color_white (GdkColormap_val(cmap), &color);
    return Val_copy(color);
}
    
value ml_gdk_color_black (value cmap)
{
    GdkColor color;
    gdk_color_black (GdkColormap_val(cmap), &color);
    return Val_copy(color);
}

value ml_gdk_color_parse (char *spec)
{
    GdkColor color;
    if (!gdk_color_parse (spec, &color))
	ml_raise_gdk ("color_parse");
    return Val_copy(color);
}

ML_2 (gdk_color_alloc, GdkColormap_val, GdkColor_val, Val_bool)

value ml_GdkColor (value red, value green, value blue)
{
    GdkColor color;
    color.red = Int_val(red);
    color.green = Int_val(green);
    color.blue = Int_val(blue);
    color.pixel = 0;
    return Val_copy(color);
}

Make_Extractor (GdkColor, GdkColor_val, red, Val_int)
Make_Extractor (GdkColor, GdkColor_val, green, Val_int)
Make_Extractor (GdkColor, GdkColor_val, blue, Val_int)
Make_Extractor (GdkColor, GdkColor_val, pixel, Val_int)

/* Rectangle */

value ml_GdkRectangle (value x, value y, value width, value height)
{
    GdkRectangle rectangle;
    rectangle.x = Int_val(x);
    rectangle.y = Int_val(y);
    rectangle.width = Int_val(width);
    rectangle.height = Int_val(height);
    return Val_copy(rectangle);
}

Make_Extractor (GdkRectangle, GdkRectangle_val, x, Val_int)
Make_Extractor (GdkRectangle, GdkRectangle_val, y, Val_int)
Make_Extractor (GdkRectangle, GdkRectangle_val, width, Val_int)
Make_Extractor (GdkRectangle, GdkRectangle_val, height, Val_int)

/* Window */

Make_Val_final_pointer (GdkWindow, gdk_window_ref, gdk_window_unref)
Make_Extractor (gdk_visual_get, GdkVisual_val, depth, Val_int)
ML_1 (gdk_window_get_visual, GdkWindow_val, Val_GdkVisual)
ML_3 (gdk_window_set_back_pixmap, GdkWindow_val, GdkPixmap_val, Int_val, Unit)
ML_1 (gdk_window_clear, GdkWindow_val, Unit)
value ml_GdkRootParent (value unit)
{
  return Val_GdkWindow( GDK_ROOT_PARENT () );
}

ML_1 (gdk_window_get_parent, GdkWindow_val, Val_GdkWindow)
value ml_gdk_window_get_position (value window)
{
  int x, y;
  value ret;

  gdk_window_get_position (GdkWindow_val(window), &x, &y);
  
  ret = alloc_tuple (2);
  Field(ret,0) = Val_int(x);
  Field(ret,1) = Val_int(y);
  return ret;
}

value ml_gdk_window_get_size (value window)
{
  int x, y;
  value ret;

  gdk_window_get_size (GdkWindow_val(window), &x, &y);
  
  ret = alloc_tuple (2);
  Field(ret,0) = Val_int(x);
  Field(ret,1) = Val_int(y);
  return ret;
}

/* Pixmap */

Make_Val_final_pointer (GdkPixmap, gdk_pixmap_ref, gdk_pixmap_unref)
Make_Val_final_pointer (GdkBitmap, gdk_bitmap_ref, gdk_bitmap_unref)
Make_Val_final_pointer_ext (GdkPixmap, _no_ref, Ignore, gdk_pixmap_unref)
Make_Val_final_pointer_ext (GdkBitmap, _no_ref, Ignore, gdk_bitmap_unref)
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
    value vpixmap = Val_unit, vmask = Val_unit, ret;
    CAMLparam2 (vpixmap, vmask);

    vpixmap = Val_GdkPixmap_no_ref
	(gdk_pixmap_colormap_create_from_xpm
	 (GdkWindow_val(window), Option_val(colormap,GdkColormap_val,NULL),
	  &mask, Option_val(transparent,GdkColor_val,NULL), filename));
    vmask = Val_GdkBitmap_no_ref (mask);
    ret = alloc_tuple (2);
    Field(ret,0) = vpixmap;
    Field(ret,1) = vmask;

    CAMLreturn(ret);
}

value ml_gdk_pixmap_colormap_create_from_xpm_d
	(value window, value colormap, value transparent, char **data)
{
    GdkBitmap *mask;
    value ret, vpixmap = Val_unit, vmask = Val_unit;
    CAMLparam2 (vpixmap, vmask);

    vpixmap = Val_GdkPixmap_no_ref
	(gdk_pixmap_colormap_create_from_xpm_d
	 (GdkWindow_val(window), Option_val(colormap,GdkColormap_val,NULL),
	  &mask, Option_val(transparent,GdkColor_val,NULL), data));
    vmask = Val_GdkBitmap_no_ref (mask);
    ret = alloc_tuple (2);
    Field(ret,0) = vpixmap;
    Field(ret,1) = vmask;

    CAMLreturn(ret);
}

/* Font */

Make_Val_final_pointer (GdkFont, gdk_font_ref, gdk_font_unref)
Make_Val_final_pointer_ext (GdkFont, _no_ref, Ignore, gdk_font_unref)
ML_1 (gdk_font_load, String_val, Val_GdkFont_no_ref)
ML_1 (gdk_fontset_load, String_val, Val_GdkFont_no_ref)
ML_2 (gdk_string_width, GdkFont_val, String_val, Val_int)
ML_2 (gdk_char_width, GdkFont_val, (gchar)Long_val, Val_int)
ML_2 (gdk_string_height, GdkFont_val, String_val, Val_int)
ML_2 (gdk_char_height, GdkFont_val, (gchar)Long_val, Val_int)
ML_2 (gdk_string_measure, GdkFont_val, String_val, Val_int)
ML_2 (gdk_char_measure, GdkFont_val, (char)Long_val, Val_int)

/* GC */

Make_Val_final_pointer (GdkGC, gdk_gc_ref, gdk_gc_unref)
Make_Val_final_pointer_ext (GdkGC, _no_ref, Ignore, gdk_gc_unref)
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
ML_2 (gdk_gc_set_clip_rectangle, GdkGC_val, GdkRectangle_val, Unit)
ML_2 (gdk_gc_set_clip_region, GdkGC_val, (GdkRegion*), Unit)
ML_2 (gdk_gc_set_subwindow, GdkGC_val, GdkSubwindowMode_val, Unit)
ML_2 (gdk_gc_set_exposures, GdkGC_val, Bool_val, Unit)
ML_5 (gdk_gc_set_line_attributes, GdkGC_val, Int_val, GdkLineStyle_val,
      GdkCapStyle_val, GdkJoinStyle_val, Unit)
ML_2 (gdk_gc_copy, GdkGC_val, GdkGC_val, Unit)
value ml_gdk_gc_get_values (value gc)
{
     GdkGCValues values;
     int i;
     value ret, tmp;
     CAMLparam2(ret, tmp);
     gdk_gc_get_values (GdkGC_val(gc), &values);
     ret = alloc (18, 0);
     for (i = 0; i < 18; i++) Field(ret,i) = Val_unit;
     tmp = Val_copy(values.foreground); modify (&Field(ret,0), tmp);
     tmp = Val_copy(values.background); modify (&Field(ret,1), tmp);
     if (values.font) {
          tmp = ml_some(Val_GdkFont(values.font));
          modify (&Field(ret,2), tmp);
     }
     Field(ret,3) = Val_gdkFunction(values.function);
     Field(ret,4) = Val_gdkFill(values.fill);
     if (values.tile) {
          tmp = ml_some(Val_GdkPixmap(values.tile));
          modify (&Field(ret,5), tmp);
     }
     if (values.tile) {
          tmp = ml_some(Val_GdkPixmap(values.stipple));
          modify (&Field(ret,6), tmp);
     }
     if (values.tile) {
          tmp = ml_some(Val_GdkPixmap(values.clip_mask));
          modify (&Field(ret,7), tmp);
     }
     Field(ret,8) = Val_gdkSubwindowMode(values.subwindow_mode);
     Field(ret,9) = Val_int(values.ts_x_origin);
     Field(ret,10) = Val_int(values.ts_y_origin);
     Field(ret,11) = Val_int(values.clip_x_origin);
     Field(ret,12) = Val_int(values.clip_y_origin);
     Field(ret,13) = Val_bool(values.graphics_exposures);
     Field(ret,14) = Val_int(values.line_width);
     Field(ret,15) = Val_gdkLineStyle(values.line_style);
     Field(ret,16) = Val_gdkCapStyle(values.cap_style);
     Field(ret,17) = Val_gdkJoinStyle(values.join_style);
     CAMLreturn(ret);
}

/* Draw */

#define PointArray_val(val) ((GdkPoint*)&Field(val,1))
#define PointArrayLen_val(val) Int_val(Field(val,0))
value ml_point_array_new (value len)
{
    value ret = alloc (1 + Wosize_asize(Int_val(len)*sizeof(GdkPoint)),
		       Abstract_tag);
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

ML_9 (gdk_draw_image, GdkDrawable_val, GdkGC_val, GdkImage_val, Int_val, Int_val, Int_val, Int_val, Int_val, Int_val, Unit)
ML_bc9 (ml_gdk_draw_image)

/* Events */

Make_Val_final_pointer (GdkEvent, Ignore, gdk_event_free)
ML_1 (gdk_event_copy, GdkEvent_val, Val_GdkEvent)

value ml_gdk_event_new (value event_type)
{
    GdkEvent event;
    memset (&event, 0, sizeof(GdkEvent));
    event.type = GdkEventType_val(event_type);
    event.any.send_event = TRUE;
    return Val_copy(event);
}

#define GdkEvent_arg(type) (GdkEvent##type*)GdkEvent_val

Make_Extractor (GdkEventAny, GdkEvent_arg(Any), type, Val_gdkEventType)
Make_Extractor (GdkEventAny, GdkEvent_arg(Any), window, Val_GdkWindow)
Make_Extractor (GdkEventAny, GdkEvent_arg(Any), send_event, Val_bool)
Make_Setter (gdk_event_set, GdkEvent_arg(Any), GdkEventType_val, type)
Make_Setter (gdk_event_set, GdkEvent_arg(Any), GdkWindow_val, window)

Make_Extractor (GdkEventExpose, GdkEvent_arg(Expose), area, Val_copy)
Make_Extractor (GdkEventExpose, GdkEvent_arg(Expose), count, Val_int)

Make_Extractor (GdkEventVisibility, GdkEvent_arg(Visibility), state,
		Val_gdkVisibilityState)

Make_Extractor (GdkEventMotion, GdkEvent_arg(Motion), time, Val_int)
Make_Extractor (GdkEventMotion, GdkEvent_arg(Motion), x, copy_double)
Make_Extractor (GdkEventMotion, GdkEvent_arg(Motion), y, copy_double)
Make_Extractor (GdkEventMotion, GdkEvent_arg(Motion), pressure, copy_double)
Make_Extractor (GdkEventMotion, GdkEvent_arg(Motion), xtilt, copy_double)
Make_Extractor (GdkEventMotion, GdkEvent_arg(Motion), ytilt, copy_double)
Make_Extractor (GdkEventMotion, GdkEvent_arg(Motion), state, Val_int)
Make_Extractor (GdkEventMotion, GdkEvent_arg(Motion), is_hint, Val_int)
Make_Extractor (GdkEventMotion, GdkEvent_arg(Motion), source, Val_gdkInputSource)
Make_Extractor (GdkEventMotion, GdkEvent_arg(Motion), deviceid, Val_int)
Make_Extractor (GdkEventMotion, GdkEvent_arg(Motion), x_root, copy_double)
Make_Extractor (GdkEventMotion, GdkEvent_arg(Motion), y_root, copy_double)

Make_Extractor (GdkEventButton, GdkEvent_arg(Button), time, Val_int)
Make_Extractor (GdkEventButton, GdkEvent_arg(Button), x, copy_double)
Make_Extractor (GdkEventButton, GdkEvent_arg(Button), y, copy_double)
Make_Extractor (GdkEventButton, GdkEvent_arg(Button), pressure, copy_double)
Make_Extractor (GdkEventButton, GdkEvent_arg(Button), xtilt, copy_double)
Make_Extractor (GdkEventButton, GdkEvent_arg(Button), ytilt, copy_double)
Make_Extractor (GdkEventButton, GdkEvent_arg(Button), state, Val_int)
Make_Extractor (GdkEventButton, GdkEvent_arg(Button), button, Val_int)
Make_Extractor (GdkEventButton, GdkEvent_arg(Button), source, Val_gdkInputSource)
Make_Extractor (GdkEventButton, GdkEvent_arg(Button), deviceid, Val_int)
Make_Extractor (GdkEventButton, GdkEvent_arg(Button), x_root, copy_double)
Make_Extractor (GdkEventButton, GdkEvent_arg(Button), y_root, copy_double)

Make_Setter (gdk_event_button_set, GdkEvent_arg(Button), Int_val, button)

Make_Extractor (GdkEventKey, GdkEvent_arg(Key), time, Val_int)
Make_Extractor (GdkEventKey, GdkEvent_arg(Key), state, Val_int)
Make_Extractor (GdkEventKey, GdkEvent_arg(Key), keyval, Val_int)
Make_Extractor (GdkEventKey, GdkEvent_arg(Key), string, Val_string)

Make_Extractor (GdkEventCrossing, GdkEvent_arg(Crossing), subwindow,
		Val_GdkWindow)
Make_Extractor (GdkEventCrossing, GdkEvent_arg(Crossing), detail,
		Val_gdkNotifyType)

Make_Extractor (GdkEventFocus, GdkEvent_arg(Focus), in, Val_int)

Make_Extractor (GdkEventConfigure, GdkEvent_arg(Configure), x, Val_int)
Make_Extractor (GdkEventConfigure, GdkEvent_arg(Configure), y, Val_int)
Make_Extractor (GdkEventConfigure, GdkEvent_arg(Configure), width, Val_int)
Make_Extractor (GdkEventConfigure, GdkEvent_arg(Configure), height, Val_int)

Make_Extractor (GdkEventProperty, GdkEvent_arg(Property), atom, Val_int)
Make_Extractor (GdkEventProperty, GdkEvent_arg(Property), time, Val_int)
Make_Extractor (GdkEventProperty, GdkEvent_arg(Property), state, Val_int)

Make_Extractor (GdkEventSelection, GdkEvent_arg(Selection), selection, Val_int)
Make_Extractor (GdkEventSelection, GdkEvent_arg(Selection), target, Val_int)
Make_Extractor (GdkEventSelection, GdkEvent_arg(Selection), property, Val_int)
Make_Extractor (GdkEventSelection, GdkEvent_arg(Selection), requestor, Val_int)
Make_Extractor (GdkEventSelection, GdkEvent_arg(Selection), time, Val_int)

Make_Extractor (GdkEventProximity, GdkEvent_arg(Proximity), time, Val_int)
Make_Extractor (GdkEventProximity, GdkEvent_arg(Proximity), source,
		Val_gdkInputSource)
Make_Extractor (GdkEventProximity, GdkEvent_arg(Proximity), deviceid, Val_int)

/* DnD */
Make_Val_final_pointer (GdkDragContext, gdk_drag_context_ref, gdk_drag_context_unref)
Make_Flags_val (GdkDragAction_val)
ML_3 (gdk_drag_status, GdkDragContext_val, Flags_GdkDragAction_val, Int_val, Unit)
Make_Extractor (GdkDragContext, GdkDragContext_val, suggested_action, Val_gdkDragAction)
value val_int(gpointer i)
{
  return Val_int (GPOINTER_TO_INT(i));
}
value ml_GdkDragContext_targets (value c)
{
  GList *t;

  t = (GdkDragContext_val(c))->targets;
  return Val_GList (t, val_int);
}

/* Misc */
ML_0 (gdk_flush, Unit)
ML_0 (gdk_beep, Unit)

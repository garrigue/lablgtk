/* $Id$ */

#include <string.h>
#include <gtk/gtk.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>
#include <caml/fail.h>

#include "wrappers.h"
#include "ml_glib.h"
#include "ml_gdk.h"
#include "ml_gtk.h"
#include "gtk_tags.h"
#include "gdk_tags.h"

/* gtkgamma.h */

#define GtkGammaCurve_val(val) check_cast(GTK_GAMMA_CURVE,val)
ML_0 (gtk_gamma_curve_new, Val_GtkWidget_sink)
Make_Extractor (gtk_gamma_curve_get, GtkGammaCurve_val, gamma, copy_double)

/* gtkstatusbar.h */

#define GtkStatusbar_val(val) check_cast(GTK_STATUSBAR,val)
ML_0 (gtk_statusbar_new, Val_GtkWidget_sink)
ML_2 (gtk_statusbar_get_context_id, GtkStatusbar_val, String_val, Val_int)
ML_3 (gtk_statusbar_push, GtkStatusbar_val, Int_val, String_val, Val_int)
ML_2 (gtk_statusbar_pop, GtkStatusbar_val, Int_val, Unit)
ML_3 (gtk_statusbar_remove, GtkStatusbar_val, Int_val, Int_val, Unit)

/* gtkcalendar.h */

#define GtkCalendar_val(val) check_cast(GTK_CALENDAR,val)
ML_0 (gtk_calendar_new, Val_GtkWidget_sink)
ML_3 (gtk_calendar_select_month, GtkCalendar_val, Int_val, Int_val, Unit)
ML_2 (gtk_calendar_select_day, GtkCalendar_val, Int_val, Unit)
ML_2 (gtk_calendar_mark_day, GtkCalendar_val, Int_val, Unit)
ML_2 (gtk_calendar_unmark_day, GtkCalendar_val, Int_val, Unit)
ML_1 (gtk_calendar_clear_marks, GtkCalendar_val, Unit)
Make_Flags_val (Calendar_display_options_val)
ML_2 (gtk_calendar_display_options, GtkCalendar_val,
      Flags_Calendar_display_options_val, Unit)
value ml_gtk_calendar_get_date (value w)
{
    guint year, month, day;
    value ret;

    gtk_calendar_get_date (GtkCalendar_val(w), &year, &month, &day);
    ret = alloc_small (3, 0);
    Field(ret,0) = Val_int(year);
    Field(ret,1) = Val_int(month);
    Field(ret,2) = Val_int(day);
    return ret;
}
ML_1 (gtk_calendar_freeze, GtkCalendar_val, Unit)
ML_1 (gtk_calendar_thaw, GtkCalendar_val, Unit)

/* gtkdrawingarea.h */

#define GtkDrawingArea_val(val) check_cast(GTK_DRAWING_AREA,val)
ML_0 (gtk_drawing_area_new, Val_GtkWidget_sink)
ML_3 (gtk_drawing_area_size, GtkDrawingArea_val, Int_val, Int_val, Unit)

/* gtkmisc.h */

#define GtkMisc_val(val) check_cast(GTK_MISC,val)
ML_3 (gtk_misc_set_alignment, GtkMisc_val, Double_val, Double_val, Unit)
ML_3 (gtk_misc_set_padding, GtkMisc_val, Int_val, Int_val, Unit)
Make_Extractor (gtk_misc_get, GtkMisc_val, xalign, copy_double)
Make_Extractor (gtk_misc_get, GtkMisc_val, yalign, copy_double)
Make_Extractor (gtk_misc_get, GtkMisc_val, xpad, Val_int)
Make_Extractor (gtk_misc_get, GtkMisc_val, ypad, Val_int)

/* gtkarrow.h */

#define GtkArrow_val(val) check_cast(GTK_ARROW,val)
ML_2 (gtk_arrow_new, Arrow_type_val, Shadow_type_val, Val_GtkWidget_sink)
ML_3 (gtk_arrow_set, GtkArrow_val, Arrow_type_val, Shadow_type_val, Unit)

/* gtkimage.h */

#define GtkImage_val(val) check_cast(GTK_IMAGE,val)
ML_2 (gtk_image_new, GdkImage_val,
      Option_val (arg2, GdkBitmap_val, NULL) Ignore, Val_GtkWidget_sink)
ML_3 (gtk_image_set, GtkImage_val, GdkImage_val,
      Option_val (arg2, GdkBitmap_val, NULL) Ignore, Unit)

/* gtklabel.h */

#define GtkLabel_val(val) check_cast(GTK_LABEL,val)
ML_1 (gtk_label_new, String_val, Val_GtkWidget_sink)
ML_2 (gtk_label_set_text, GtkLabel_val, String_val, Unit)
ML_2 (gtk_label_set_pattern, GtkLabel_val, String_val, Unit)
ML_2 (gtk_label_set_justify, GtkLabel_val, Justification_val, Unit)
ML_2 (gtk_label_set_line_wrap, GtkLabel_val, Bool_val, Unit)
Make_Extractor (gtk_label_get, GtkLabel_val, label, Val_string)

/* gtktipsquery.h */

#define GtkTipsQuery_val(val) check_cast(GTK_TIPS_QUERY,val)
ML_0 (gtk_tips_query_new, Val_GtkWidget_sink)
ML_1 (gtk_tips_query_start_query, GtkTipsQuery_val, Unit)
ML_1 (gtk_tips_query_stop_query, GtkTipsQuery_val, Unit)
ML_2 (gtk_tips_query_set_caller, GtkTipsQuery_val, GtkWidget_val, Unit)
ML_3 (gtk_tips_query_set_labels, GtkTipsQuery_val,
      String_val, String_val, Unit)
value ml_gtk_tips_query_set_emit_always (value w, value arg)
{
    GtkTipsQuery_val(w)->emit_always = Bool_val(arg);
    return Val_unit;
}
Make_Extractor (gtk_tips_query_get, GtkTipsQuery_val, emit_always, Val_bool)
Make_Extractor (gtk_tips_query_get, GtkTipsQuery_val, caller, Val_GtkWidget)
Make_Extractor (gtk_tips_query_get, GtkTipsQuery_val, label_inactive,
		Val_string)
Make_Extractor (gtk_tips_query_get, GtkTipsQuery_val, label_no_tip,
		Val_string)

/* gtkpixmap.h */

#define GtkPixmap_val(val) check_cast(GTK_PIXMAP,val)
ML_2 (gtk_pixmap_new, GdkPixmap_val,
      Option_val (arg2, GdkBitmap_val, NULL) Ignore,
      Val_GtkWidget_sink)
value ml_gtk_pixmap_set (value val, value pixmap, value mask)
{
    GtkPixmap *w = GtkPixmap_val(val);
    gtk_pixmap_set (w, Option_val(pixmap,GdkPixmap_val,w->pixmap),
		    Option_val(mask,GdkBitmap_val,w->mask));
    return Val_unit;
}
Make_Extractor (GtkPixmap, GtkPixmap_val, pixmap, Val_GdkPixmap)
Make_Extractor (GtkPixmap, GtkPixmap_val, mask, Val_GdkBitmap)

/* gtk[hv]separator.h */

ML_0 (gtk_hseparator_new, Val_GtkWidget_sink)
ML_0 (gtk_vseparator_new, Val_GtkWidget_sink)

/* gtkpreview.h */

#define GtkPreview_val(val) check_cast(GTK_PREVIEW,val)
ML_1 (gtk_preview_new, Preview_type_val, Val_GtkWidget_sink)
ML_9 (gtk_preview_put, GtkPreview_val, GdkWindow_val, GdkGC_val,
      Int_val, Int_val, Int_val, Int_val, Int_val, Int_val, Unit)
ML_bc9 (ml_gtk_preview_put)
ML_3 (gtk_preview_size, GtkPreview_val, Int_val, Int_val, Unit)
ML_2 (gtk_preview_set_expand, GtkPreview_val, Bool_val, Unit)
ML_1 (gtk_preview_set_gamma, Float_val, Unit)
ML_2 (gtk_preview_set_dither, GtkPreview_val, GdkRgbDither_val, Unit)

#define ROWBUF_SIZE 3072     
value ml_gtk_preview_draw_row (value val, value data, value x, value y)
{
    GtkPreview *w = GtkPreview_val(val);
    gint length = Wosize_val(data);
    gint xi = Int_val(x);
    gint yi = Int_val(y);
    guchar buf[ROWBUF_SIZE];
    gint offset = 0;
    gboolean rgb = w->type == GTK_PREVIEW_COLOR;
    
    while (offset < length) {
	guchar* p = buf;
	gint block_len;
	gint i;

	if (rgb) {
	    block_len = MIN(length - offset, ROWBUF_SIZE / 3);
	    for (i = 0; i < block_len; i++) {
		gint32 c = Int_val(Field(data, offset + i));
		*p++ = (c >> 16) & 0xff;
		*p++ = (c >> 8) & 0xff;
		*p++ = c & 0xff;
	    }
	} else {
	    block_len = MIN(length - offset, ROWBUF_SIZE);
	    for (i = 0; i < block_len; i++) {
		gint32 c = Int_val(Field(data, offset + i));
		*p++ = c & 0xff;
	    }
	}
	gtk_preview_draw_row(w, buf, xi + offset, yi, block_len);
	offset += block_len;
    }
    return Val_unit;
}

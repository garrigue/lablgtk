/**************************************************************************/
/*                Lablgtk                                                 */
/*                                                                        */
/*    This program is free software; you can redistribute it              */
/*    and/or modify it under the terms of the GNU Library General         */
/*    Public License as published by the Free Software Foundation         */
/*    version 2, with the exception described in file COPYING which       */
/*    comes with the library.                                             */
/*                                                                        */
/*    This program is distributed in the hope that it will be useful,     */
/*    but WITHOUT ANY WARRANTY; without even the implied warranty of      */
/*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       */
/*    GNU Library General Public License for more details.                */
/*                                                                        */
/*    You should have received a copy of the GNU Library General          */
/*    Public License along with this program; if not, write to the        */
/*    Free Software Foundation, Inc., 59 Temple Place, Suite 330,         */
/*    Boston, MA 02111-1307  USA                                          */
/*                                                                        */
/*                                                                        */
/**************************************************************************/

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
#include "ml_gobject.h"
#include "ml_gdk.h"
#include "ml_gtk.h"
#include "gtk_tags.h"

/* Init all */

CAMLprim value ml_gtkrange_init(value unit)
{
    /* Since these are declared const, must force gcc to call them! */
    GType t =
        gtk_progress_bar_get_type() +
        gtk_hscale_get_type() +
        gtk_vscale_get_type() +
        gtk_hscrollbar_get_type() +
        gtk_vscrollbar_get_type();
    return Val_GType(t);
}

/* gtkprogress.h */
/*
#define GtkProgress_val(val) check_cast(GTK_PROGRESS,val)
ML_2 (gtk_progress_set_show_text, GtkProgress_val, Bool_val, Unit)
ML_3 (gtk_progress_set_text_alignment, GtkProgress_val,
      Option_val(arg2,Float_val,(GtkProgress_val(arg1))->x_align) Ignore,
      Option_val(arg3,Float_val,(GtkProgress_val(arg1))->y_align) Ignore, Unit)
ML_2 (gtk_progress_set_format_string, GtkProgress_val, String_val, Unit)
ML_2 (gtk_progress_set_adjustment, GtkProgress_val, GtkAdjustment_val, Unit)
ML_4 (gtk_progress_configure, GtkProgress_val,
      Float_val, Float_val, Float_val, Unit)
ML_2 (gtk_progress_set_percentage, GtkProgress_val, Float_val, Unit)
ML_2 (gtk_progress_set_value, GtkProgress_val, Float_val, Unit)
ML_1 (gtk_progress_get_value, GtkProgress_val, copy_double)
ML_1 (gtk_progress_get_current_percentage, GtkProgress_val, copy_double)
ML_2 (gtk_progress_set_activity_mode, GtkProgress_val, Bool_val, Unit)
ML_1 (gtk_progress_get_current_text, GtkProgress_val, Val_string)
Make_Extractor (gtk_progress_get, GtkProgress_val, adjustment,
		Val_GtkAny)
*/
/* gtkprogressbar.h */

#define GtkProgressBar_val(val) check_cast(GTK_PROGRESS_BAR,val)
ML_1 (gtk_progress_bar_pulse, GtkProgressBar_val, Unit)

/* gtkrange.h */

#define GtkRange_val(val) check_cast(GTK_RANGE,val)

/* gtkscale.h */
/*
#define GtkScale_val(val) check_cast(GTK_SCALE,val)
ML_2 (gtk_scale_set_digits, GtkScale_val, Int_val, Unit)
ML_2 (gtk_scale_set_draw_value, GtkScale_val, Bool_val, Unit)
ML_2 (gtk_scale_set_value_pos, GtkScale_val, Position_type_val, Unit)
ML_1 (gtk_scale_get_digits, GtkScale_val, Val_int)
ML_1 (gtk_scale_get_draw_value, GtkScale_val, Val_bool)
ML_1 (gtk_scale_get_value_pos, GtkScale_val, Val_position)
ML_1 (gtk_hscale_new, GtkAdjustment_val, Val_GtkWidget_sink)
ML_1 (gtk_vscale_new, GtkAdjustment_val, Val_GtkWidget_sink)
*/
/* gtkscrollbar.h */
/*
ML_1 (gtk_hscrollbar_new, GtkAdjustment_val, Val_GtkWidget_sink)
ML_1 (gtk_vscrollbar_new, GtkAdjustment_val, Val_GtkWidget_sink)
*/

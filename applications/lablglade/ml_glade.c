#include <gtk/gtk.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>
#include <caml/fail.h>


#include "glade.h"
#include "glade_clipboard.h"
#include "glade_project.h"
#include "glade_project_options.h"
#include "libglade/glade_project_window.h"
#include "glade_project_view.h"
#include "editor.h"
#include "gbwidget.h"
#include "load.h"
#include "utils.h"

#include "wrappers.h"
#include "ml_gtk.h"

/* conversion functions */

/* glade.c */
ML_0 (glade_init, Unit)
ML_0(glade_show_project_window, Unit)
ML_0(glade_hide_project_window, Unit)
ML_0(glade_show_palette, Unit)
ML_0(glade_hide_palette, Unit)
ML_0(glade_show_property_editor, Unit)
ML_0(glade_hide_property_editor, Unit)
ML_0(glade_show_widget_tree, Unit)
ML_0(glade_hide_widget_tree, Unit)
ML_0(glade_show_clipboard, Unit)
ML_0(glade_hide_clipboard, Unit)
ML_1(glade_show_widget_tooltips, Bool_val, Unit)
ML_1(glade_show_grid, Bool_val, Unit)
ML_1(glade_snap_to_grid, Bool_val, Unit)
ML_0(glade_show_grid_settings, Unit)
ML_0(glade_show_snap_settings, Unit)

/* glade_project.c */
#define GladeProject_val(val) check_cast(GLADE_PROJECT,val)
ML_0 (glade_project_new, Val_GtkObject_sink)
ML_5 (glade_project_set_source_files, GladeProject_val,
      String_val, String_val, String_val, String_val, Unit)      
     
/* glade_project_view.c */
#define GladeProjectView_val(val) check_cast(GLADE_PROJECT_VIEW,val)
ML_0 (glade_project_view_new, Val_GtkObject_sink)
ML_2 (glade_project_view_set_project, GladeProjectView_val, GladeProject_val, Unit)

#define GtkWidget_val(val) check_cast(GTK_WIDGET,val)/* copied from ml_gtk.c */

/* glade_project_window.c */
#define GladeProjectWindow_val(val) check_cast(GLADE_PROJECT_WINDOW,val)

ML_0 (glade_project_window_new, Val_GtkObject_sink)     
ML_1 (glade_project_window_new_project, GtkWidget_val, Unit)
ML_1 (glade_project_window_on_open_project, GtkWidget_val, Unit)
ML_2 (glade_project_window_open_project, GladeProjectWindow_val,
				         String_val, Unit);
ML_1 (glade_project_window_save_project, GtkWidget_val, Unit)
ML_1 (glade_project_window_on_save_project_as, GtkWidget_val, Unit)
ML_1 (glade_project_window_write_source, GtkWidget_val, Unit)
ML_1 (glade_project_window_edit_options, GtkWidget_val, Unit)
ML_1 (glade_project_window_cut, GtkWidget_val, Unit)
ML_1 (glade_project_window_copy, GtkWidget_val, Unit)
ML_1 (glade_project_window_paste, GtkWidget_val, Unit)
ML_1 (glade_project_window_delete, GtkWidget_val, Unit)
ML_1 (glade_project_window_show_palette, GtkWidget_val, Unit)
ML_1 (glade_project_window_show_property_editor, GtkWidget_val, Unit)
ML_1 (glade_project_window_show_widget_tree, GtkWidget_val, Unit)
ML_1 (glade_project_window_show_clipboard, GtkWidget_val, Unit)
ML_1 (glade_project_window_toggle_tooltips, GtkWidget_val, Unit)
ML_1 (glade_project_window_toggle_grid, GtkWidget_val, Unit)
ML_1 (glade_project_window_edit_grid_settings, GtkWidget_val, Unit)
ML_1 (glade_project_window_toggle_snap, GtkWidget_val, Unit)
ML_1 (glade_project_window_edit_snap_settings, GtkWidget_val, Unit)
ML_1 (glade_project_window_about, GtkWidget_val, Unit)
ML_2 (glade_project_window_set_project, GladeProjectWindow_val, GladeProject_val, Unit)	


/* gbwidget.c (?) */

value ml_gb_widget_widget_data (value arg) {
   GtkWidget* widget;
   GbWidgetData *widget_data;

   widget = GtkWidget_val(arg);
   widget_data = gtk_object_get_data (GTK_OBJECT (widget), GB_WIDGET_DATA_KEY);
   return (value)widget_data;
}
     
#define GB_WIDGET_DATA(fname, conv) \
value ml_gb_widget_data_##fname (value arg) \
{ \
  GbWidgetData* wdata = (GbWidgetData*)arg;\
  return conv(wdata->##fname );\
}

Make_Extractor(gb_widget_data, (GbWidgetData*), flags, Val_int)
Make_Extractor(gb_widget_data, (GbWidgetData*), x, Val_int)
Make_Extractor(gb_widget_data, (GbWidgetData*), y, Val_int)
Make_Extractor(gb_widget_data, (GbWidgetData*), width, Val_int)
Make_Extractor(gb_widget_data, (GbWidgetData*), height, Val_int)
Make_Extractor(gb_widget_data, (GbWidgetData*), tooltip, Val_string)

value ml_val(x) {
  return (value)x;
}
     
value ml_gb_widget_data_signals (value arg) 
{
  GbWidgetData* wdata = (GbWidgetData*)arg;
  return Val_GList(wdata->signals, ml_val);
}

value ml_gb_widget_data_accelerators (value arg) 
{
  GbWidgetData* wdata = (GbWidgetData*)arg;
  return Val_GList(wdata->accelerators, ml_val);
}

Make_Extractor(gb_widget_data, (GbWidgetData*), gbstyle, (value))

#define GB_SIGNAL(fname, conv) \
value ml_gb_signal_##fname (value arg) \
{\
  GbSignal* wdata = (GbSignal*)arg;\
  return conv(wdata->##fname);\
}

Make_Extractor(gb_signal, (GbSignal*), name, Val_string)
Make_Extractor(gb_signal, (GbSignal*), handler, Val_string)
Make_Extractor(gb_signal, (GbSignal*), object, Val_string)
Make_Extractor(gb_signal, (GbSignal*), after, Val_bool)
Make_Extractor(gb_signal, (GbSignal*), data, Val_string)

#define GB_Accelerator(fname, conv) \
value ml_gb_accelerator_##fname (value arg) \
{\
  GbAccelerator* wdata = (GbAccelerator*)arg;\
  return conv(wdata->##fname );\
}

Make_Extractor(gb_accelerator, (GbAccelerator*), modifiers, Val_int)
Make_Extractor(gb_accelerator, (GbAccelerator*), key, Val_string)
Make_Extractor(gb_accelerator, (GbAccelerator*), signal, Val_string)

value ml_gb_is_placeholder (value arg)
{
 GtkWidget* widget = GtkWidget_val(arg);
 return Val_bool(GB_IS_PLACEHOLDER(widget));
}

/*  styles.h */

Make_Extractor(gb_style, (GbStyle*), name, Val_string)
Make_Extractor(gb_style, (GbStyle*), xlfd_fontname, Val_string)
/* copied from ml_gtk.c */
/* Make_Val_final_pointer (GtkStyle, _no_ref, Ignore, gtk_style_unref) */
Make_Extractor(gb_style, (GbStyle*), style, Val_GtkStyle_no_ref)
/*  Make_Array_Extractor(gb_style, (GbStyle*), Int_val,
                        bg_pixmap_filenames, Val_string) */
value ml_gb_style_bg_pixmap_filenames (value arg1, value arg2) {
  GbStyle* style = (GbStyle*)arg1;
  int i = Int_val (arg2);
  if (0<=i && i<GB_NUM_STYLE_STATES) {
    return Val_string(style->bg_pixmap_filenames[i]);
  } else {
    Val_string("");
  }
}

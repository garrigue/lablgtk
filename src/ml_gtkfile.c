/* $Id$ */

#include <gtk/gtk.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>
#include <caml/fail.h>

#include "wrappers.h"
#include "ml_glib.h"
#include "ml_gobject.h"
#include "ml_gtk.h"
#include "gtk_tags.h"


CAMLprim value ml_gtkfile_init(value unit)
{
  GType t =
#ifdef HASGTK24
    gtk_file_chooser_dialog_get_type () +
    gtk_file_chooser_widget_get_type ();
#else
    0;
#endif
  return Val_GType(t);
}

static void ml_raise_gtk_file_chooser_error(GError *) Noreturn;
static void ml_raise_gtk_file_chooser_error(GError *err)
{
  static value *exn = NULL;
#ifdef HASGTK24
  if(err && err->domain == GTK_FILE_CHOOSER_ERROR) {
    if(exn == NULL)
      exn = caml_named_value("gtk_file_chooser_error");
    if(exn == NULL)
      ml_raise_gerror(err);
    {
      value b = 0, msg = 0;
      Begin_roots2(b, msg)
	msg = copy_string(err->message);
        b = alloc_small(3, 0);
        Field(b, 0) = *exn;
        Field(b, 1) = Val_int(err->code);
        Field(b, 2) = msg;
        g_error_free(err);
      End_roots();
      mlraise(b);
    }
  }
#endif
  ml_raise_gerror(err);
}

#ifdef HASGTK24
#define GtkFileChooser_val(val) check_cast(GTK_FILE_CHOOSER,val)

ML_2 (gtk_file_chooser_set_current_name, GtkFileChooser_val, String_val, Unit)
static value copy_string_and_free(gchar *s)
{
  value v = copy_string(s ? s : "");
  g_free(s);
  return v;
}
#define string_list_of_GSList(l) Val_GSList_free(l, (value_in) copy_string_and_free)
#define widget_list_of_GSList(l) Val_GSList_free(l, (value_in) Val_GObject)

ML_1 (gtk_file_chooser_get_filename, GtkFileChooser_val, copy_string_and_free)
ML_2 (gtk_file_chooser_set_filename, GtkFileChooser_val, String_val, Unit)
ML_2 (gtk_file_chooser_select_filename, GtkFileChooser_val, String_val, Unit)
ML_2 (gtk_file_chooser_unselect_filename, GtkFileChooser_val, String_val, Unit)
ML_1 (gtk_file_chooser_select_all, GtkFileChooser_val, Unit)
ML_1 (gtk_file_chooser_unselect_all, GtkFileChooser_val, Unit)
ML_1 (gtk_file_chooser_get_filenames, GtkFileChooser_val, string_list_of_GSList)
ML_2 (gtk_file_chooser_set_current_folder, GtkFileChooser_val, String_val, Unit)
ML_1 (gtk_file_chooser_get_current_folder, GtkFileChooser_val, copy_string_and_free)

ML_1 (gtk_file_chooser_get_uri, GtkFileChooser_val, copy_string_and_free)
ML_2 (gtk_file_chooser_set_uri, GtkFileChooser_val, String_val, Unit)
ML_2 (gtk_file_chooser_select_uri, GtkFileChooser_val, String_val, Unit)
ML_2 (gtk_file_chooser_unselect_uri, GtkFileChooser_val, String_val, Unit)
ML_1 (gtk_file_chooser_get_uris, GtkFileChooser_val, string_list_of_GSList)
ML_2 (gtk_file_chooser_set_current_folder_uri, GtkFileChooser_val, String_val, Unit)
ML_1 (gtk_file_chooser_get_current_folder_uri, GtkFileChooser_val, copy_string_and_free)

ML_1 (gtk_file_chooser_get_preview_filename, GtkFileChooser_val, copy_string_and_free)
ML_1 (gtk_file_chooser_get_preview_uri, GtkFileChooser_val, copy_string_and_free)

#define GtkFileFilter_val(val)  check_cast(GTK_FILE_FILTER, val)
ML_0 (gtk_file_filter_new, Val_GtkAny_sink)
ML_2 (gtk_file_filter_set_name, GtkFileFilter_val, String_val, Unit)
ML_1 (gtk_file_filter_get_name, GtkFileFilter_val, copy_string_or_null);
ML_2 (gtk_file_filter_add_mime_type, GtkFileFilter_val, String_val, Unit)
ML_2 (gtk_file_filter_add_pattern, GtkFileFilter_val, String_val, Unit)

ML_2 (gtk_file_chooser_add_filter, GtkFileChooser_val, GtkFileFilter_val, Unit)
ML_2 (gtk_file_chooser_remove_filter, GtkFileChooser_val, GtkFileFilter_val, Unit)
ML_1 (gtk_file_chooser_list_filters, GtkFileChooser_val, widget_list_of_GSList)

CAMLprim value ml_gtk_file_chooser_add_shortcut_folder(value w, value f)
{
  GError *err = NULL;
  gtk_file_chooser_add_shortcut_folder(GtkFileChooser_val(w), 
				       String_val(f), &err);
  if (err) ml_raise_gtk_file_chooser_error(err);
  return Val_unit;
}
CAMLprim value ml_gtk_file_chooser_remove_shortcut_folder(value w, value f)
{
  GError *err = NULL;
  gtk_file_chooser_remove_shortcut_folder(GtkFileChooser_val(w), 
				       String_val(f), &err);
  if (err) ml_raise_gtk_file_chooser_error(err);
  return Val_unit;
}
ML_1 (gtk_file_chooser_list_shortcut_folders, GtkFileChooser_val, string_list_of_GSList)
CAMLprim value ml_gtk_file_chooser_add_shortcut_folder_uri(value w, value f)
{
  GError *err = NULL;
  gtk_file_chooser_add_shortcut_folder_uri(GtkFileChooser_val(w), 
					   String_val(f), &err);
  if (err) ml_raise_gtk_file_chooser_error(err);
  return Val_unit;
}
CAMLprim value ml_gtk_file_chooser_remove_shortcut_folder_uri(value w, value f)
{
  GError *err = NULL;
  gtk_file_chooser_remove_shortcut_folder_uri(GtkFileChooser_val(w), 
					      String_val(f), &err);
  if (err) ml_raise_gtk_file_chooser_error(err);
  return Val_unit;
}
ML_1 (gtk_file_chooser_list_shortcut_folder_uris, GtkFileChooser_val, string_list_of_GSList)

#else /* HASGTK24 */

Unsupported_24(gtk_file_chooser_set_current_name)
Unsupported_24(gtk_file_chooser_get_filename)
Unsupported_24(gtk_file_chooser_set_filename)
Unsupported_24(gtk_file_chooser_select_filename)
Unsupported_24(gtk_file_chooser_unselect_filename)
Unsupported_24(gtk_file_chooser_select_all)
Unsupported_24(gtk_file_chooser_unselect_all)
Unsupported_24(gtk_file_chooser_get_filenames)
Unsupported_24(gtk_file_chooser_set_current_folder)
Unsupported_24(gtk_file_chooser_get_current_folder)
Unsupported_24(gtk_file_chooser_get_uri)
Unsupported_24(gtk_file_chooser_set_uri)
Unsupported_24(gtk_file_chooser_select_uri)
Unsupported_24(gtk_file_chooser_unselect_uri)
Unsupported_24(gtk_file_chooser_get_uris)
Unsupported_24(gtk_file_chooser_set_current_folder_uri)
Unsupported_24(gtk_file_chooser_get_current_folder_uri)
Unsupported_24(gtk_file_chooser_get_preview_filename)
Unsupported_24(gtk_file_chooser_get_preview_uri)
Unsupported_24(gtk_file_filter_new)
Unsupported_24(gtk_file_filter_set_name)
Unsupported_24(gtk_file_filter_get_name)
Unsupported_24(gtk_file_filter_add_mime_type)
Unsupported_24(gtk_file_filter_add_pattern)
Unsupported_24(gtk_file_chooser_add_filter)
Unsupported_24(gtk_file_chooser_remove_filter)
Unsupported_24(gtk_file_chooser_list_filters)
Unsupported_24(gtk_file_chooser_list_shortcut_folders)
Unsupported_24(gtk_file_chooser_add_shortcut_folder)
Unsupported_24(gtk_file_chooser_remove_shortcut_folder)
Unsupported_24(gtk_file_chooser_add_shortcut_folder_uri)
Unsupported_24(gtk_file_chooser_remove_shortcut_folder_uri)
Unsupported_24(gtk_file_chooser_list_shortcut_folder_uris)

#endif /* HASGTK24 */

#include <gtk/gtk.h>

#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/fail.h>

#include "wrappers.h"
#include "ml_glib.h"
#include "ml_gobject.h"
#include "ml_gtk.h"
#include "ml_gdkpixbuf.h"
#include "gtk_tags.h"
#include "gdk_tags.h"

/* gtkiconfactory.h */

/* GtkIconSource */
Make_Val_final_pointer_ext(GtkIconSource, _new, Ignore, gtk_icon_source_free, 5)
#define GtkIconSource_val(v)    ((GtkIconSource*)Pointer_val(v))
ML_0 (gtk_icon_source_new, Val_GtkIconSource_new)
ML_2 (gtk_icon_source_set_filename, GtkIconSource_val, String_val, Unit)
ML_2 (gtk_icon_source_set_pixbuf, GtkIconSource_val, GdkPixbuf_val, Unit)
ML_1 (gtk_icon_source_get_filename, GtkIconSource_val, copy_string)
ML_1 (gtk_icon_source_get_pixbuf, GtkIconSource_val, Val_GdkPixbuf)

ML_2 (gtk_icon_source_set_direction_wildcarded, GtkIconSource_val, Bool_val, Unit)
ML_2 (gtk_icon_source_set_state_wildcarded, GtkIconSource_val, Bool_val, Unit)
ML_2 (gtk_icon_source_set_size_wildcarded, GtkIconSource_val, Bool_val, Unit)
ML_2 (gtk_icon_source_set_direction, GtkIconSource_val, Text_direction_val, Unit)
ML_2 (gtk_icon_source_set_state, GtkIconSource_val, State_type_val, Unit)
ML_2 (gtk_icon_source_set_size, GtkIconSource_val, Icon_size_val, Unit)


/* GtkIconSet */
Make_Val_final_pointer(GtkIconSet, gtk_icon_set_ref, gtk_icon_set_unref, 0)
Make_Val_final_pointer_ext(GtkIconSet, _new, Ignore, gtk_icon_set_unref, 5)
#define GtkIconSet_val(v)       ((GtkIconSet*)Pointer_val(v))
ML_0 (gtk_icon_set_new, Val_GtkIconSet_new)
ML_1 (gtk_icon_set_new_from_pixbuf, GdkPixbuf_val, Val_GtkIconSet_new)
ML_2 (gtk_icon_set_add_source, GtkIconSet_val, GtkIconSource_val, Unit)
CAMLprim value ml_gtk_icon_set_get_sizes(value s)
{
  CAMLparam0();
  CAMLlocal2(p, c);
  GtkIconSize *arr;
  gint n;
  gtk_icon_set_get_sizes(GtkIconSet_val(s), &arr, &n);
  p = Val_emptylist;
  for(; n>=0; n--){
    c = alloc_small(2, Tag_cons);
    Field(c, 0) = Val_icon_size(arr[n]);
    Field(c, 1) = p;
    p = c;
  }
  g_free(arr);
  CAMLreturn(c);
}

/* GtkIconFactory */
#define GtkIconFactory_val(val) check_cast(GTK_ICON_FACTORY, val)
ML_0 (gtk_icon_factory_new, Val_GAnyObject_new)
ML_3 (gtk_icon_factory_add, GtkIconFactory_val, String_val, GtkIconSet_val, Unit)
ML_2 (gtk_icon_factory_lookup, GtkIconFactory_val, String_val, Val_GtkIconSet)

ML_1 (gtk_icon_factory_add_default, GtkIconFactory_val, Unit)
ML_1 (gtk_icon_factory_remove_default, GtkIconFactory_val, Unit)
ML_1 (gtk_icon_factory_lookup_default, String_val, Val_GtkIconSet)

/* GtkStockItem */
static Make_Flags_val (GdkModifier_val)

CAMLprim value ml_gtk_stock_add(value item)
{
  GtkStockItem it;
  it.stock_id = String_val(Field(item, 0));
  it.label    = String_val(Field(item, 1));
  it.modifier = Flags_GdkModifier_val(Field(item, 2)) ;
  it.keyval   = Int_val(Field(item, 3));
  it.translation_domain = NULL;
  gtk_stock_add(&it, 1);
  return Val_unit;
}

CAMLprim value ml_gtk_stock_list_ids(value unit)
{
  return Val_GSList_free( gtk_stock_list_ids(), (value_in) copy_string_g_free);
}

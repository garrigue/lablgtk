/* $Id$ */

#include <string.h>
#include <gtk/gtk.h>
#include <glade/glade.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>
#include <caml/fail.h>

#include "wrappers.h"
#include "ml_glib.h"
#include "ml_gdk.h"
#include "ml_gtk.h"


ML_0 (glade_init, Unit)
/* ML_0 (glade_gnome_init, Unit) */

#define GladeXML_val(val) ((GladeXML*)GtkObject_val(val))

CAMLprim value ml_glade_xml_new (value file, value data, value root, value domain)
{
    GladeXML *ret;
    if (Is_block(data))
        ret = glade_xml_new_from_memory (String_val(Field(data,0)),
                                         string_length(Field(data,0)),
                                         String_option_val(root),
                                         String_option_val(domain));
    else if (Is_block(file))
        ret = glade_xml_new_with_domain (String_val(Field(file,0)),
                                         String_option_val(root),
                                         String_option_val(domain));
    else invalid_argument ("Glade.create");
    return Val_GtkAny_sink (ret);
}

#define set(variable, expr) {value tmp = expr; initialize(&variable, tmp);}

void ml_glade_callback_marshal (const gchar *handler_name,
                                GtkObject *object,
                                const gchar *signal_name,
                                const gchar *signal_data,
                                GtkObject *connect_object,
                                gboolean after,
                                gpointer user_data)
{
    value vargs = alloc(5,0);

    CAMLparam1 (vargs);
    set(Field(vargs,0), Val_string(handler_name));
    set(Field(vargs,1), Val_GtkObject(object));
    set(Field(vargs,2), Val_string(signal_name));
    set(Field(vargs,3), Val_option(connect_object, Val_GtkObject));
    set(Field(vargs,4), Val_bool(after));
    
    callback (*(value*)user_data, vargs);

    CAMLreturn0;
}

CAMLprim value ml_glade_xml_signal_autoconnect_full (value self, value clos)
{
    value *clos_p = ml_global_root_new (clos);
    glade_xml_signal_autoconnect_full (GladeXML_val(self),
                                       ml_glade_callback_marshal,
                                       clos_p);
    return Val_unit;
}

CAMLprim value ml_glade_xml_signal_connect_full (value self, value name, value clos)
{
    value *clos_p = ml_global_root_new (clos);
    glade_xml_signal_connect_full (GladeXML_val(self),
                                   String_val(name),
                                   ml_glade_callback_marshal,
                                   clos_p);
    return Val_unit;
}

ML_2 (glade_xml_get_widget, GladeXML_val, String_val, Val_GtkWidget)
ML_2 (glade_xml_get_widget_by_long_name, GladeXML_val, String_val,
      Val_GtkWidget)
ML_1 (glade_get_widget_name, GtkWidget_val, Val_string)
ML_1 (glade_get_widget_long_name, GtkWidget_val, Val_string)
ML_1 (glade_get_widget_tree, GtkWidget_val, Val_GtkAny)

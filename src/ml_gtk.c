/* $Id$ */

#include <gtk/gtk.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>

#include "wrappers.h"
#include "ml_gtk.h"
#include "gtk_tags.h"
#include "gtk_tags.c"

inline value Val_pointer (void *p)
{
    value ret = alloc_shr (2, Abstract_tag);
    initialize (&Field(ret,1), (value) p);
    return ret;
}

Make_Val_final_pointer(GtkObject, gtk_object_ref, gtk_object_unref)

/* gtktypeutils.h */

ML_1 (gtk_type_name, Int_val, copy_string)
ML_1 (gtk_type_from_name, (char *), Val_int)
ML_1 (gtk_type_parent, Int_val, Val_int)
ML_1 (gtk_type_class, Int_val, (value))
ML_1 (gtk_type_parent_class, Int_val, (value))
ML_2 (gtk_type_is_a, Int_val, Int_val, Val_bool)

/* gtkobject.h */

/* ML_1 (GTK_OBJECT_TYPE, GtkObject_val, Val_int) */
value ml_gtk_object_type (value val)
{
    return Val_int (GtkObject_val(val)->klass->type);
}
value ml_gtk_class_type (GtkObjectClass *cl)
{
    return Val_int (cl->type);
}

/* gtkaccelerator.h */

Make_Val_final_pointer (GtkAcceleratorTable, gtk_accelerator_table_ref, gtk_accelerator_table_unref)

ML_0 (gtk_accelerator_table_new, Val_GtkAcceleratorTable)

/* gtkwidget.h */

#define GtkWidget_val(val) GTK_WIDGET(Pointer_val(val))
ML_1 (gtk_widget_show, GtkWidget_val, Unit)
ML_1 (gtk_widget_show_now, GtkWidget_val, Unit)
ML_1 (gtk_widget_show_all, GtkWidget_val, Unit)
ML_1 (gtk_widget_hide, GtkWidget_val, Unit)
ML_1 (gtk_widget_hide_all, GtkWidget_val, Unit)
ML_1 (gtk_widget_map, GtkWidget_val, Unit)
ML_1 (gtk_widget_unmap, GtkWidget_val, Unit)
ML_1 (gtk_widget_realize, GtkWidget_val, Unit)
ML_1 (gtk_widget_unrealize, GtkWidget_val, Unit)
ML_1 (gtk_widget_queue_draw, GtkWidget_val, Unit)
ML_1 (gtk_widget_queue_resize, GtkWidget_val, Unit)
ML_2 (gtk_widget_draw, GtkWidget_val, (GdkRectangle*), Unit)
ML_1 (gtk_widget_draw_focus, GtkWidget_val, Unit)
ML_1 (gtk_widget_draw_default, GtkWidget_val, Unit)
ML_1 (gtk_widget_draw_children, GtkWidget_val, Unit)
ML_2 (gtk_widget_event, GtkWidget_val, (GdkEvent*), Unit)
ML_1 (gtk_widget_activate, GtkWidget_val, Unit)
ML_2 (gtk_widget_reparent, GtkWidget_val, GtkWidget_val, Unit)
ML_3 (gtk_widget_popup, GtkWidget_val, Int_val, Int_val, Unit)

value ml_gtk_widget_intersect (value w, GdkRectangle *area)
{
    value ret = Val_unit;
    value inter = alloc (Wosizeof(GdkRectangle), Abstract_tag);
    if (gtk_widget_intersect (GtkWidget_val(w), area, (GdkRectangle*)inter)) {
	Begin_root(inter);
	ret = alloc_tuple(1);
	Field(ret,0) = inter;
	End_roots ();
    }
    return ret;
}

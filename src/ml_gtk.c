/* $Id$ */

#include <gtk/gtk.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>

#include "wrappers.h"
#include "ml_gtk.h"
/*
#include "gtk_tags.h"
#include "gtk_tags.c"
*/

#define Wosizeof(x) ((sizeof(x)-1)/sizeof(value)+1)

inline value Val_pointer (void *p)
{
    value ret = alloc_shr (2, Abstract_tag);
    initialize (&Field(ret,1), (value) p);
    return ret;
}

/*
inline value Val_final_pointer (void *p, final_fun final)
{
    value ret = alloc_final (2, final, 1, 50);
    initialize (&Field(ret,1), (value) p);
    return ret;
}
*/

#define Make_Val_final_pointer(type, init, final) \
static void ml_final_##type (value val) \
{ final (type##_val(val)); } \
inline value Val_##type (type *p) \
{ value ret = alloc_final (2, ml_final_##type, 1, 50); \
  initialize (&Field(ret,1), (value) p); init (p); return ret; }

Make_Val_final_pointer(GtkObject, gtk_object_ref, gtk_object_unref)

/* gtktypeutils.h */

/* ML_0 (gtk_type_init, Unit) */
/* gtk_type_unique not implemented */
ML_1 (gtk_type_name, Int_val, copy_string)
ML_1 (gtk_type_from_name, (char *), Val_int)
ML_1 (gtk_type_parent, Int_val, Val_int)
ML_1 (gtk_type_class, Int_val, (value))
ML_1 (gtk_type_parent_class, Int_val, (value))
/* ML_1 (gtk_type_new, Int_val, Val_GtkObject) */
/* gtk_type_describe* not implemented */
ML_2 (gtk_type_is_a, Int_val, Int_val, Val_bool)
/*
  ML_4 (gtk_type_get_arg, GtkObject_val, Int_val, (GtkArg *), Int_val, Unit)
  ML_4 (gtk_type_set_arg, GtkObject_val, Int_val, (GtkArg *), Int_val, Unit)
  value ml_gtk_alloc_arg (value unit)
  {
  return alloc (Wosizeof(GtkArg), Abstract_tag);
  }
*/

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

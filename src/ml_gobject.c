/* $Id$ */

#include <glib.h>
#include <glib-object.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>
#include <caml/fail.h>

#include "wrappers.h"
#include "ml_gobject.h"
#include "gobject_tags.h"
#include "gobject_tags.c"

/* gobject.h */

Make_Val_final_pointer(GObject, g_object_ref, g_object_unref, 0)
Make_Val_final_pointer_ext (GObject, _new, Ignore, g_object_unref, 20)
ML_1 (G_TYPE_FROM_INSTANCE, GObject_val, Val_int)
ML_1 (g_object_ref, GObject_val, Unit)
ML_1 (g_object_unref, GObject_val, Unit)
ML_1 (g_object_freeze_notify, GObject_val, Unit)
ML_1 (g_object_thaw_notify, GObject_val, Unit)

/* gtype.h */

ML_1 (g_type_name, Int_val, Val_string)
ML_1 (g_type_from_name, String_val, Val_int)
ML_1 (g_type_parent, Int_val, Val_int)
ML_1 (g_type_depth, Int_val, Val_int)
ML_2 (g_type_is_a, Int_val, Int_val, Val_bool)
value ml_g_type_fundamental (value type)
{
    return Val_fundamental_type (G_TYPE_FUNDAMENTAL (Int_val(type)));
}
ML_1 (Fundamental_type_val, Int_val, )

/* gclosure.h */

Make_Val_final_pointer(GClosure, g_closure_ref, g_closure_unref, 0)

#define g_closure_ref_and_sink(w) (g_closure_ref(w), g_closure_sink(w))
Make_Val_final_pointer_ext(GClosure, _sink , g_closure_ref_and_sink,
                           g_closure_unref, 20)

static void notify_destroy(gpointer clos_p, GClosure *c)
{
    remove_global_root((value*)clos_p);
}

static void marshal (GClosure *closure, GValue *ret,
                     guint nargs, const GValue *args,
                     gpointer hint, gpointer marshall_data)
{
    value vargs = alloc_small(3,0);

    CAMLparam1 (vargs);
    Field(vargs,0) = (value) ret;
    Field(vargs,1) = Val_int(nargs);
    Field(vargs,2) = (value) args;

    callback ((value)closure->data, vargs);

    Field(vargs,0) = Val_int(-1);
    Field(vargs,1) = Val_int(-1);
    CAMLreturn0;
}

value ml_g_closure_new (value clos)
{
    GClosure* closure = g_closure_new_simple(sizeof(GClosure), (gpointer)clos);
    register_global_root((value*)&closure->data);
    g_closure_add_finalize_notifier(closure, &closure->data, notify_destroy);
    g_closure_set_marshal(closure, marshal);
    return Val_GClosure_sink(closure);
}

/* gvalue.h / gparamspec.h */

GValue *GValue_val(value val)
{
    GValue *ret = (GValue*)Pointer_val(val);
    if ((long)ret == -1) invalid_argument("Gobject.GValue_val");
    return ret;
}

ML_2 (g_value_set_boolean, GValue_val, Int_val, Unit)
ML_1 (g_value_get_boolean, GValue_val, Val_bool)
ML_2 (g_value_set_char, GValue_val, Char_val, Unit)
ML_1 (g_value_get_char, GValue_val, Val_char)
ML_2 (g_value_set_int, GValue_val, Int_val, Unit)
ML_1 (g_value_get_int, GValue_val, Val_int)
ML_2 (g_value_set_long, GValue_val, Nativeint_val, Unit)
ML_1 (g_value_get_long, GValue_val, copy_nativeint)
ML_2 (g_value_set_int64, GValue_val, Int64_val, Unit)
ML_1 (g_value_get_int64, GValue_val, copy_int64)
ML_2 (g_value_set_float, GValue_val, Float_val, Unit)
ML_1 (g_value_get_float, GValue_val, copy_double)

/* $Id$ */

#include <glib.h>
#include <glib-object.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>
#include <caml/fail.h>

#include "wrappers.h"
#include "ml_glib.h"
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

ML_3 (g_object_set_property, GObject_val, String_val, GValue_val, Unit)
ML_3 (g_object_get_property, GObject_val, String_val, GValue_val, Unit)


/* gtype.h */

ML_1 (g_type_name, GType_val, Val_string)
ML_1 (g_type_from_name, String_val, Val_GType)
ML_1 (g_type_parent, GType_val, Val_GType)
ML_1 (g_type_depth, GType_val, Val_int)
ML_2 (g_type_is_a, GType_val, GType_val, Val_bool)
ML_1 (G_TYPE_FUNDAMENTAL, GType_val, Val_fundamental_type)
ML_1 (Fundamental_type_val, GType_val, )

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

    Field(vargs,0) = 0;
    Field(vargs,1) = 0;
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

value ml_g_value_new(value gtype)
{
    value v = alloc_small(sizeof(GValue)/sizeof(value), Abstract_tag);
    g_value_init(GValue_val(v), GType_val(gtype));
    return v;
}

ML_1 (G_VALUE_TYPE, GValue_val, Val_GType)
ML_2 (g_value_copy, GValue_val, GValue_val, Unit)
ML_1 (g_value_reset, GValue_val, Unit)
ML_1 (g_value_unset, GValue_val, Unit)


CAMLprim value ml_g_value_shift (value args, value index)
{
    return (value) (&GValue_val(args)[Int_val(index)]);
}

#define DATA  (val->data[0])

CAMLprim value ml_g_value_get (value arg)
{
    CAMLparam0();
    CAMLlocal1(tmp);
    GValue *val = GValue_val(arg);
    value ret = MLTAG_NONE;
    GType type = G_VALUE_TYPE(val);
    int tag;

    if (!g_type_check_value_holds(val,type))
        invalid_argument("Gobject.Value.get");
    switch (G_TYPE_FUNDAMENTAL(type)) {
        /* This is such a pain that we access the data directly :-( */
        /* We do like in gvaluetypes.c */
    case G_TYPE_CHAR:
    case G_TYPE_UCHAR:
        tag = MLTAG_CHAR;
        tmp = Val_int(DATA.v_int);
        break;
    case G_TYPE_BOOLEAN:
        tag = MLTAG_BOOL;
        tmp = Val_bool(DATA.v_int);
        break;
    case G_TYPE_INT:
    case G_TYPE_UINT:
        tag = MLTAG_INT;
        tmp = Val_int (DATA.v_int);
        break;
    case G_TYPE_LONG:
    case G_TYPE_ULONG:
    case G_TYPE_ENUM:
    case G_TYPE_FLAGS:
        tag = MLTAG_INT;
        tmp = Val_long (DATA.v_long);
        break;
    case G_TYPE_FLOAT:
        tag = MLTAG_FLOAT;
        tmp = copy_double ((double)DATA.v_float);
        break;
    case G_TYPE_DOUBLE:
        tag = MLTAG_FLOAT;
        tmp = copy_double (DATA.v_double);
        break;
    case G_TYPE_STRING:
        tag = MLTAG_STRING;
        tmp = Val_option (DATA.v_pointer, copy_string);
        break;
    case G_TYPE_OBJECT:
        tag = MLTAG_OBJECT;
        tmp = Val_option ((GObject*)DATA.v_pointer, Val_GObject);
        break;
    case G_TYPE_BOXED:
    case G_TYPE_POINTER:
        tag = MLTAG_POINTER;
        tmp = Val_option (DATA.v_pointer, Val_pointer);
        break;
    case G_TYPE_INT64:
    case G_TYPE_UINT64:
        tag = MLTAG_INT64;
        tmp = copy_int64 (DATA.v_int64);
        break;
    default:
        tag = -1;
    }
    if (tag != -1) {
        ret = alloc_small(2,0);
        Field(ret,0) = tag;
        Field(ret,1) = tmp;
    }
    CAMLreturn(ret);
}

CAMLprim value ml_g_value_set (value arg1, value arg2)
{
    GValue *val = GValue_val(arg1);
    value tag = Field(arg2,0);
    value data = Field(arg2,1);
    GType type = G_VALUE_TYPE(val);
    switch (G_TYPE_FUNDAMENTAL(type)) {
    case G_TYPE_CHAR:
    case G_TYPE_UCHAR:
        if (tag != MLTAG_CHAR) break;
        DATA.v_int = Int_val(data);
        return Val_unit;
    case G_TYPE_BOOLEAN:
        if (tag != MLTAG_BOOL) break;
        DATA.v_int = Int_val(data);
        return Val_unit;
    case G_TYPE_INT:
    case G_TYPE_UINT:
        if (tag == MLTAG_INT)
            DATA.v_int = Int_val(data);
        else if (tag == MLTAG_INT32)
            DATA.v_int = Int32_val(data);
        else break;
        return Val_unit;
    case G_TYPE_LONG:
    case G_TYPE_ULONG:
    case G_TYPE_ENUM:
    case G_TYPE_FLAGS:
        if (tag == MLTAG_INT)
            DATA.v_long = Int_val(data);
        else if (tag == MLTAG_INT32)
            DATA.v_long = Int32_val(data);
        else if (tag == MLTAG_LONG)
            DATA.v_long = Nativeint_val(data);
        else break;
        return Val_unit;
    case G_TYPE_FLOAT:
        if (tag != MLTAG_FLOAT) break;
        DATA.v_float = (float)Double_val(data);
        return Val_unit;
    case G_TYPE_DOUBLE:
        if (tag != MLTAG_FLOAT) break;
        DATA.v_double = (double)Double_val(data);
        return Val_unit;
    case G_TYPE_STRING:
        if (tag != MLTAG_STRING) break;
        g_value_set_string(val, String_option_val(data));
        return Val_unit;
    case G_TYPE_OBJECT:
        if (tag != MLTAG_OBJECT) break;
        g_value_set_object(val, Option_val(data,GObject_val,NULL));
        return Val_unit;
    case G_TYPE_BOXED:
    case G_TYPE_POINTER:
        if (tag != MLTAG_POINTER && tag != MLTAG_OBJECT) break;
        DATA.v_pointer = Option_val(data,Pointer_val,NULL);
        return Val_unit;
    case G_TYPE_INT64:
    case G_TYPE_UINT64:
        if (tag == MLTAG_INT64)
            DATA.v_int64 = Int64_val(data);
        else if (tag == MLTAG_INT)
            DATA.v_int64 = Int_val(data);
        else if (tag == MLTAG_INT32)
            DATA.v_int64 = Int32_val(data);
        else if (tag == MLTAG_LONG)
            DATA.v_int64 = Nativeint_val(data);
        else break;
        return Val_unit;
    default:
        failwith ("Gobject.Value.set : cannot set this value");
    }
    failwith ("GObject.Value.set : argument type mismatch");
    return Val_unit;
}

CAMLprim value ml_g_value_get_nativeint(value arg) {
    GValue *val = GValue_val(arg);
    switch(G_TYPE_FUNDAMENTAL(G_VALUE_TYPE(val))) {
    case G_TYPE_INT:
    case G_TYPE_UINT:
        return copy_nativeint (DATA.v_int);
    case G_TYPE_LONG:
    case G_TYPE_ULONG:
    case G_TYPE_ENUM:
    case G_TYPE_FLAGS:
        return copy_nativeint (DATA.v_long);
    default:
        invalid_argument ("Gobject.get_nativeint");
    }
    return Val_unit;
}

CAMLprim value ml_g_value_get_pointer (value arg)
{
    gpointer p = NULL;
    GValue *val = GValue_val(arg);
    switch(G_TYPE_FUNDAMENTAL(G_VALUE_TYPE(val))) {
    case G_TYPE_STRING:
    case G_TYPE_OBJECT:
    case G_TYPE_BOXED:
    case G_TYPE_POINTER:
        p = DATA.v_pointer; break;
    default:
	invalid_argument ("Gobject.get_pointer");
    }
    return Val_pointer(p);
}

#undef DATA

/*
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
*/

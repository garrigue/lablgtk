/* $Id$ */
#include <stdio.h>
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
Make_Val_final_pointer_ext (GObject, _new, G_OBJECT, g_object_unref, 20)
ML_1 (G_TYPE_FROM_INSTANCE, GObject_val, Val_int)
ML_1 (g_object_ref, GObject_val, Unit)
ML_1 (g_object_unref, GObject_val, Unit)
ML_1 (g_object_freeze_notify, GObject_val, Unit)
ML_1 (g_object_thaw_notify, GObject_val, Unit)

ML_3 (g_object_set_property, GObject_val, String_val, GValue_val, Unit)
ML_3 (g_object_get_property, GObject_val, String_val, GValue_val, Unit)


/* gtype.h */

ML_0 (g_type_init, Unit)
ML_1 (g_type_name, GType_val, Val_string)
ML_1 (g_type_from_name, String_val, Val_GType)
ML_1 (g_type_parent, GType_val, Val_GType)
ML_1 (g_type_depth, GType_val, Val_int)
ML_2 (g_type_is_a, GType_val, GType_val, Val_bool)
ML_1 (G_TYPE_FUNDAMENTAL, GType_val, Val_fundamental_type)
ML_1 (Fundamental_type_val,,Val_GType)

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
    value vargs = alloc(3,0);

    CAMLparam1 (vargs);
    Store_field(vargs, 0, (ret ? Val_GValue(ret) : alloc(2,0)));
    Store_field(vargs, 1, Val_int(nargs));
    Store_field(vargs, 2, Val_GValue((GValue*)args));

    callback ((value)closure->data, vargs);

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

#define g_value_unset_and_free(gv) g_value_unset(gv); g_free(gv)
Make_Val_final_pointer_ext(GValue, _new, Ignore, g_value_unset_and_free, 20)

value ml_g_value_new(value gtype)
{
    GValue *gvalue = g_malloc(sizeof(GValue));
    if (gvalue==NULL) raise_out_of_memory ();
    gvalue->g_type = 0;
    g_value_init(gvalue, GType_val(gtype));
    return Val_GValue_new(gvalue);
}

value ml_g_value_release(value val)
{
    if (Tag_val(val) == Custom_tag) ml_final_GValue_new(val);
    GValue_val(val) = NULL;
    return Val_unit;
}

GValue* GValue_check(value val)
{
    GValue *v = GValue_val(val);
    if (v == NULL) invalid_argument("GValue_check");
    return v;
}

ML_1 (G_VALUE_TYPE, GValue_check, Val_GType)
ML_2 (g_value_copy, GValue_check, GValue_check, Unit)
ML_1 (g_value_reset, GValue_check, Unit)

CAMLprim value ml_g_value_shift (value args, value index)
{
    return Val_GValue (&GValue_check(args)[Int_val(index)]);
}

#define DATA  (val->data[0])

CAMLprim value ml_g_value_get (value arg)
{
    CAMLparam0();
    CAMLlocal1(tmp);
    GValue *val = GValue_check(arg);
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

void g_value_set_variant (GValue *val, value arg2)
{
    value tag = Field(arg2,0);
    value data = Field(arg2,1);
    GType type = G_VALUE_TYPE(val);
    switch (G_TYPE_FUNDAMENTAL(type)) {
    case G_TYPE_CHAR:
    case G_TYPE_UCHAR:
        if (tag != MLTAG_CHAR) break;
        DATA.v_int = Int_val(data);
        return;
    case G_TYPE_BOOLEAN:
        if (tag != MLTAG_BOOL) break;
        DATA.v_int = Int_val(data);
        return;
    case G_TYPE_INT:
    case G_TYPE_UINT:
        if (tag == MLTAG_INT)
            DATA.v_int = Int_val(data);
        else if (tag == MLTAG_INT32)
            DATA.v_int = Int32_val(data);
        else break;
        return;
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
        return;
    case G_TYPE_FLOAT:
        if (tag != MLTAG_FLOAT) break;
        DATA.v_float = (float)Double_val(data);
        return;
    case G_TYPE_DOUBLE:
        if (tag != MLTAG_FLOAT) break;
        DATA.v_double = (double)Double_val(data);
        return;
    case G_TYPE_STRING:
        if (tag != MLTAG_STRING) break;
        g_value_set_string(val, String_option_val(data));
        return;
    case G_TYPE_OBJECT:
        if (tag != MLTAG_OBJECT) break;
        g_value_set_object(val, Option_val(data,GObject_val,NULL));
        return;
    case G_TYPE_BOXED:
    case G_TYPE_POINTER:
        if (tag != MLTAG_POINTER && tag != MLTAG_OBJECT) break;
        DATA.v_pointer = Option_val(data,MLPointer_val,NULL);
        return;
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
        return;
    default:
        failwith ("Gobject.Value.set : cannot set this value");
    }
    failwith ("GObject.Value.set : argument type mismatch");
    return;
}

ML_2 (g_value_set_variant, GValue_check, , Unit)

CAMLprim value ml_g_value_get_nativeint(value arg) {
    GValue *val = GValue_check(arg);
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
    GValue *val = GValue_check(arg);
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
ML_2 (g_value_set_boolean, GValue_check, Int_val, Unit)
ML_1 (g_value_get_boolean, GValue_check, Val_bool)
ML_2 (g_value_set_char, GValue_check, Char_val, Unit)
ML_1 (g_value_get_char, GValue_check, Val_char)
ML_2 (g_value_set_int, GValue_check, Int_val, Unit)
ML_1 (g_value_get_int, GValue_check, Val_int)
ML_2 (g_value_set_long, GValue_check, Nativeint_val, Unit)
ML_1 (g_value_get_long, GValue_check, copy_nativeint)
ML_2 (g_value_set_int64, GValue_check, Int64_val, Unit)
ML_1 (g_value_get_int64, GValue_check, copy_int64)
ML_2 (g_value_set_float, GValue_check, Float_val, Unit)
ML_1 (g_value_get_float, GValue_check, copy_double)
*/

/* gsignal.h */

ML_4 (g_signal_connect_closure, GObject_val, String_val, GClosure_val,
      Bool_val, Val_long)
ML_2 (g_signal_handler_block, GObject_val, Long_val, Unit)
ML_2 (g_signal_handler_unblock, GObject_val, Long_val, Unit)
ML_2 (g_signal_handler_disconnect, GObject_val, Long_val, Unit)
ML_2 (g_signal_handler_is_connected, GObject_val, Long_val, Val_bool)
ML_2 (g_signal_stop_emission_by_name, GObject_val, String_val, Unit)
value ml_g_signal_emit_by_name (value obj, value sig, value params)
{
    CAMLparam3(obj,sig,params);
    CAMLlocal1(ret);
    GObject *instance = GObject_val(obj);
    GValue *iparams = (GValue*)calloc(1 + Wosize_val(params), sizeof(GValue));
    GQuark detail = 0;
    GType itype = G_TYPE_FROM_INSTANCE (instance);
    GType return_type;
    guint signal_id;
    int i;
    GSignalQuery query;

    if(!g_signal_parse_name(String_val(sig), itype, &signal_id, &detail, TRUE))
        failwith("GtkSignal.emit_by_name : bad signal name");
    g_value_init (iparams, itype);
    g_value_set_object (iparams, instance);
    g_signal_query (signal_id, &query);
    if (Wosize_val(params) != query.n_params)
        failwith("GtkSignal.emit_by_name : bad parameters number");
    return_type = query.return_type & ~G_SIGNAL_TYPE_STATIC_SCOPE;
    if (return_type != G_TYPE_NONE)
        ret = ml_g_value_new (Val_GType (return_type));
    for (i = 0; i < query.n_params; i++) {
        g_value_init (&iparams[i+1],
                      query.param_types[i] & ~G_SIGNAL_TYPE_STATIC_SCOPE);
        g_value_set_variant (&iparams[i+1], Field(params,i));
    }
    g_signal_emitv (iparams, signal_id, detail, (ret ? GValue_val(ret) : 0));
    for (i = 0; i < query.n_params + 1; i++)
        g_value_unset (iparams + i);
    free (iparams);
    CAMLreturn(ret);
}

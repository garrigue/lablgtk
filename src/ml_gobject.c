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
#include "ml_gvaluecaml.h"
#include "gobject_tags.h"
#include "gobject_tags.c"

/* gobject.h */

Make_Val_final_pointer(GObject, g_object_ref, g_object_unref, 0)
Make_Val_final_pointer_ext (GObject, _new, G_OBJECT, g_object_unref, 20)
ML_1 (G_TYPE_FROM_INSTANCE, GObject_val, Val_int)
// ML_1 (g_object_ref, GObject_val, Unit)
CAMLprim value ml_g_object_unref (value val)
{
    if (Field(val,1)) g_object_unref (GObject_val(val));
    Field(val,1) = 0;
    return Val_unit;
}
Make_Extractor(g_object, GObject_val, ref_count, Val_int)
    
ML_1 (g_object_freeze_notify, GObject_val, Unit)
ML_1 (g_object_thaw_notify, GObject_val, Unit)
ML_2 (g_object_notify, GObject_val, String_val, Unit)
ML_3 (g_object_set_property, GObject_val, String_val, GValue_val, Unit)
ML_3 (g_object_get_property, GObject_val, String_val, GValue_val, Unit)
GType my_g_object_get_property_type(GObject *obj, const char *prop)
{
    GParamSpec *pspec =
        g_object_class_find_property (G_OBJECT_GET_CLASS(obj), prop);
    if (pspec == NULL) raise_not_found();
    return pspec->value_type;
}
ML_2 (my_g_object_get_property_type, GObject_val, String_val, Val_GType)


/* gtype.h */

ML_0 (g_type_init, Unit)
ML_1 (g_type_name, GType_val, Val_string)
ML_1 (g_type_from_name, String_val, Val_GType)
ML_1 (g_type_parent, GType_val, Val_GType)
ML_1 (g_type_depth, GType_val, Val_int)
ML_2 (g_type_is_a, GType_val, GType_val, Val_bool)
ML_1 (G_TYPE_FUNDAMENTAL, GType_val, Val_fundamental_type)
CAMLprim value ml_Fundamental_type_val(value fund)
{
  /* G_TYPE_CAML is not a constant, it's a function call, so it can't
     be in the lookup_table.
     It's not a true fundamental type because Gtk{Tree,List}Store won't
     accept unknown fundamental types. */
  if (fund == MLTAG_CAML)
    return Val_GType(G_TYPE_CAML);
  return Val_GType(Fundamental_type_val(fund));
}

#ifdef HASGTK22
CAMLprim value  ml_g_type_interface_prerequisites(value type)
{
    value res = Val_unit;
    CAMLparam1(res);
    CAMLlocal1(tmp);
    guint n;
    GType *intf = g_type_interface_prerequisites(GType_val(type), &n);
    while (n-- > 0) {
        tmp = res;
        res = alloc_small(2,0);
        Field(res,0) = Val_GType(intf[n]);
        Field(res,1) = tmp;
    }
    CAMLreturn(res);
}
#else
Unsupported(g_type_interface_prerequisites)
#endif

CAMLprim value ml_g_type_register_static(value parent_type,value type_name)
{
  value res;
  CAMLparam1(res);
  GTypeQuery query;
  g_type_query(GType_val(parent_type),&query);
  printf("Parent_name: %s\nClass_size: %d\nInstance Size: %d\n",
	  query.type_name,query.class_size,query.instance_size);
  {
  const GTypeInfo info =
    { query.class_size,
      NULL, /* base_init */
      NULL, /* base_finalize */
      NULL, /*      (GClassInitFunc) tictactoe_class_init */
      NULL, /* class_finalize */
      NULL, /* class_data */
      query.instance_size,
      0,    /* n_preallocs */
      NULL, /*(GInstanceInitFunc) tictactoe_init*/}; 

  res = Val_GType
    (g_type_register_static(GType_val(parent_type),
			    String_val(type_name),
			    &info,
			    0));
  }
  CAMLreturn(res);
}
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
    Store_field(vargs, 0, (ret ? Val_GValue_wrap(ret) : alloc(2,0)));
    Store_field(vargs, 1, Val_int(nargs));
    Store_field(vargs, 2, Val_GValue_wrap((GValue*)args));

    callback ((value)closure->data, vargs);

    CAMLreturn0;
}

CAMLprim value ml_g_closure_new (value clos)
{
    GClosure* closure = g_closure_new_simple(sizeof(GClosure), (gpointer)clos);
    register_global_root((value*)&closure->data);
    g_closure_add_finalize_notifier(closure, &closure->data, notify_destroy);
    g_closure_set_marshal(closure, marshal);
    return Val_GClosure_sink(closure);
}

/* gvalue.h / gparamspec.h */

static void ml_final_GValue (value val)
{
    GValue *gv = GValueptr_val(val);
    if (gv != NULL && gv->g_type != 0) g_value_unset(gv);
}

static struct custom_operations ml_custom_GValue =
{ "GValue/2.0/", ml_final_GValue, custom_compare_default, custom_hash_default,
  custom_serialize_default, custom_deserialize_default };

CAMLprim value ml_g_value_new(void)
{
    value ret = alloc_custom(&ml_custom_GValue, sizeof(value)+sizeof(GValue),
                             20, 1000);
    /* create an MLPointer */
    Field(ret,1) = 2;
    ((GValue*)&Field(ret,2))->g_type = 0;
    return ret;
}

value Val_GValue_copy(GValue *gv)
{
    value ret = ml_g_value_new();
    *((GValue*)&Field(ret,2)) = *gv;
    return ret;
}

CAMLprim value ml_g_value_release(value val)
{
    ml_final_GValue (val);
    Pointer_val(val) = NULL;
    return Val_unit;
}

GValue* GValue_val(value val)
{
    void *v = MLPointer_val(val);
    if (v == NULL) invalid_argument("GValue_val");
    return (GValue*)v;
}

ML_1 (G_VALUE_TYPE, GValue_val, Val_GType)
ML_2 (g_value_init, GValue_val, GType_val, Unit)
ML_2 (g_value_copy, GValue_val, GValue_val, Unit)
ML_1 (g_value_reset, GValue_val, Unit)
ML_2 (g_value_type_compatible, GType_val, GType_val, Val_bool)
ML_2 (g_value_type_transformable, GType_val, GType_val, Val_bool)
ML_2 (g_value_transform, GValue_val, GValue_val, Val_bool)

CAMLprim value ml_g_value_shift (value args, value index)
{
    return Val_GValue_wrap (&GValue_val(args)[Int_val(index)]);
}

/* gboxed finalization */
static void ml_final_gboxed (value val)
{
    gpointer p = Pointer_val(val);
    if (p != NULL) g_boxed_free (Field(val,2), p);
    p = NULL;
}
static struct custom_operations ml_custom_gboxed =
{ "gboxed/2.0/", ml_final_gboxed, custom_compare_default, custom_hash_default,
  custom_serialize_default, custom_deserialize_default };
value Val_gboxed(GType t, gpointer p)
{
    value ret = alloc_custom(&ml_custom_gboxed, 2*sizeof(value), 10, 1000);
    Pointer_val(ret) = g_boxed_copy (t,p);
    Field(ret,2) = t;
    return ret;
}
value Val_gboxed_new(GType t, gpointer p)
{
    value ret = alloc_custom(&ml_custom_gboxed, 2*sizeof(value), 10, 1000);
    Pointer_val(ret) = p;
    Field(ret,2) = t;
    return ret;
}

/* Read/Write a value */

#define DATA  (val->data[0])

value g_value_get_variant (GValue *val)
{
    CAMLparam0();
    CAMLlocal1(tmp);
    value ret = MLTAG_NONE;
    GType type;
    int tag;

    if (! G_IS_VALUE(val))
      invalid_argument("Gobject.Value.get");

    type = G_VALUE_TYPE(val);

    if (type == G_TYPE_CAML) {
        tmp = DATA.v_long;
	if (tmp == 0)
	  CAMLreturn(ret);
        tag = MLTAG_CAML;
    }
    else
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
      case G_TYPE_INTERFACE: /* assume interfaces are for objects */
      case G_TYPE_OBJECT:
        tag = MLTAG_OBJECT;
        tmp = Val_option ((GObject*)DATA.v_pointer, Val_GObject);
        break;
      case G_TYPE_BOXED:
        tag = MLTAG_POINTER;
        tmp = (DATA.v_pointer == NULL ? Val_unit
               : ml_some(Val_gboxed(type, DATA.v_pointer)));
        break;
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

ML_1 (g_value_get_variant, GValue_val, ID)

void g_value_set_variant (GValue *val, value arg)
{
    value tag = Field(arg,0);
    value data = Field(arg,1);
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
        if (tag == MLTAG_INT || tag == MLTAG_BOOL)
            DATA.v_int = Int_val(data);
        else if (tag == MLTAG_INT32)
            DATA.v_int = Int32_val(data);
        else break;
        return;
    case G_TYPE_LONG:
    case G_TYPE_ULONG:
    case G_TYPE_ENUM:
    case G_TYPE_FLAGS:
      switch (tag) {
      case MLTAG_INT:
	DATA.v_long = Int_val(data); return;
      case MLTAG_INT32:
	DATA.v_long = Int32_val(data); return;
      case MLTAG_LONG:
	DATA.v_long = Nativeint_val(data); return;
      };
      break;
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
    case G_TYPE_INTERFACE: /* assume interfaces are for objects */
    case G_TYPE_OBJECT:
        if (tag != MLTAG_OBJECT) break;
        g_value_set_object(val, Option_val(data,GObject_val,NULL));
        return;
    case G_TYPE_BOXED:
        if (tag != MLTAG_POINTER) break;
        g_value_set_boxed(val, Option_val(data,MLPointer_val,NULL));
        return;
    case G_TYPE_POINTER:
      switch (tag) {
        case MLTAG_CAML:
	  DATA.v_long = data; return;
        case MLTAG_POINTER:
        case MLTAG_OBJECT:
          DATA.v_pointer = Option_val(data,MLPointer_val,NULL);
          return;
      };
      break;
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
    /* fprintf(stderr,"value has type %s\n", g_type_name(type)); */
    failwith ("GObject.Value.set : argument type mismatch");
    return;
}

ML_2 (g_value_set_variant, GValue_val, ID, Unit)

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

CAMLprim value ml_g_value_get_int32(value arg) {
    GValue *val = GValue_val(arg);
    switch(G_TYPE_FUNDAMENTAL(G_VALUE_TYPE(val))) {
    case G_TYPE_INT:
    case G_TYPE_UINT:
        return copy_int32 (DATA.v_int);
    case G_TYPE_ENUM:
    case G_TYPE_FLAGS:
        return copy_int32 (DATA.v_long);
    default:
        failwith ("Gobject.get_int32");
    }
    return Val_unit;
}

CAMLprim value ml_g_value_get_pointer (value arg)
{
    gpointer p = NULL;
    GValue *val = GValue_val(arg);
    switch(G_TYPE_FUNDAMENTAL(G_VALUE_TYPE(val))) {
    case G_TYPE_STRING:
    case G_TYPE_BOXED:
    case G_TYPE_POINTER:
        p = DATA.v_pointer; break;
    default:
	failwith ("Gobject.get_pointer");
    }
    return Val_pointer(p);
}

#undef DATA

/* gobject.h / properties */

CAMLprim value ml_g_object_new (value type, value params)
{
    int i, n;
    value cell = params;
    GParameter *params_copy = NULL, *param;
    GObjectClass *class = g_type_class_ref(GType_val(type));
    GParamSpec *pspec;
    GObject *ret;

    for (n = 0; cell != Val_unit; cell = Field(cell,1)) n++;
    if (n > 0) {
      params_copy = (GParameter*)calloc(n, sizeof(GParameter));
      param = params_copy;
      for (cell = params; cell != Val_unit; cell = Field(cell,1)) {
        param->name = String_val(Field(Field(cell,0),0));
        pspec = g_object_class_find_property (class, param->name);
        if (!pspec) failwith ("Gobject.create");
        g_value_init (&param->value, pspec->value_type);
        g_value_set_variant (&param->value, Field(Field(cell,0),1));
        param++;
      }
    }

    ret = g_object_newv (GType_val(type), n, params_copy);

    if (n > 0) {
      for (i=0; i<n; i++) g_value_unset(&params_copy[i].value);
      free(params_copy);
    }
    g_type_class_unref(class);
    return Val_GObject_new(ret);
}

CAMLprim value ml_g_object_get_property_dyn (value vobj, value prop)
{
  GObject *obj = GObject_val(vobj);
  GType tp = my_g_object_get_property_type(obj, String_val(prop));
  GValue val = {0};
  value ret;
  g_value_init (&val, tp);
  g_object_get_property (obj, String_val(prop), &val);
  ret = g_value_get_variant (&val);
  g_value_unset (&val);
  return ret;
}

CAMLprim value ml_g_object_set_property_dyn (value vobj, value prop, value arg)
{
  GObject *obj = GObject_val(vobj);
  GType tp = my_g_object_get_property_type(obj, String_val(prop));
  GValue val = {0};
  g_value_init (&val, tp);
  g_value_set_variant (&val, arg);
  g_object_set_property (obj, String_val(prop), &val);
  g_value_unset (&val);
  return Val_unit;
}

/* gsignal.h */

ML_4 (g_signal_connect_closure, GObject_val, String_val, GClosure_val,
      Bool_val, Val_long)
ML_2 (g_signal_handler_block, GObject_val, Long_val, Unit)
ML_2 (g_signal_handler_unblock, GObject_val, Long_val, Unit)
ML_2 (g_signal_handler_disconnect, GObject_val, Long_val, Unit)
ML_2 (g_signal_handler_is_connected, GObject_val, Long_val, Val_bool)
ML_2 (g_signal_stop_emission_by_name, GObject_val, String_val, Unit)
CAMLprim value ml_g_signal_emit_by_name (value obj, value sig, value params)
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
    if (return_type != G_TYPE_NONE) {
        ret = ml_g_value_new();
        g_value_init (GValue_val(ret), return_type);
    }
    for (i = 0; i < query.n_params; i++) {
        g_value_init (&iparams[i+1],
                      query.param_types[i] & ~G_SIGNAL_TYPE_STATIC_SCOPE);
        g_value_set_variant (&iparams[i+1], Field(params,i));
    }
    g_signal_emitv (iparams, signal_id, detail, (ret ? GValue_val(ret) : 0));
    for (i = 0; i < query.n_params + 1; i++)
        g_value_unset (iparams + i);
    free (iparams);
    if (!ret) ret = Val_unit;
    CAMLreturn(ret);
}

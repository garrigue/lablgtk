/**************************************************************************/
/*                Lablgtk                                                 */
/*                                                                        */
/*    This program is free software; you can redistribute it              */
/*    and/or modify it under the terms of the GNU Library General         */
/*    Public License as published by the Free Software Foundation         */
/*    version 2, with the exception described in file COPYING which       */
/*    comes with the library.                                             */
/*                                                                        */
/*    This program is distributed in the hope that it will be useful,     */
/*    but WITHOUT ANY WARRANTY; without even the implied warranty of      */
/*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       */
/*    GNU Library General Public License for more details.                */
/*                                                                        */
/*    You should have received a copy of the GNU Library General          */
/*    Public License along with this program; if not, write to the        */
/*    Free Software Foundation, Inc., 59 Temple Place, Suite 330,         */
/*    Boston, MA 02111-1307  USA                                          */
/*                                                                        */
/*                                                                        */
/**************************************************************************/

/* $Id$ */
#include <stdio.h>
#include <gtk/gtk.h>
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

static gboolean ml_g_object_unref0 (gpointer p)
{ g_object_unref((GObject*)p); return 0; }

CAMLexport void ml_g_object_unref_later (GObject *p)
{
    g_timeout_add_full(G_PRIORITY_HIGH_IDLE, 0, ml_g_object_unref0,
                       (gpointer)(p), NULL);
}


Make_Val_final_pointer(GObject, g_object_ref, ml_g_object_unref_later, 0)
Make_Val_final_pointer_ext (GObject, _new, Ignore, ml_g_object_unref_later, 20)
ML_1 (G_TYPE_FROM_INSTANCE, GObject_val, Val_GType)
ML_1 (G_TYPE_FROM_CLASS, GObjectClass_val, Val_GType)
ML_1 (g_object_ref, GObject_val, Unit)
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
static GType my_g_object_get_property_type(GObject *obj, const char *prop)
{
    GParamSpec *pspec =
        g_object_class_find_property (G_OBJECT_GET_CLASS(obj), prop);
    if (pspec == NULL) raise_not_found();
    return pspec->value_type;
}
ML_2 (my_g_object_get_property_type, GObject_val, String_val, Val_GType)


/* gtype.h */

static int ml_compare_GType(value v1, value v2)
{
  GType t1 = (GType)Field(v1,1);
  GType t2 = (GType)Field(v2,1);
  if (g_type_is_a(t1, t2) && g_type_is_a(t2, t1))
    return 0;
  else return 1;
}
static struct custom_operations ml_custom_GType =
{ "GType/2.0/", custom_finalize_default, ml_compare_GType,
  custom_hash_default, custom_serialize_default, custom_deserialize_default };
CAMLprim value Val_GType (GType p)
{ value ret = alloc_custom (&ml_custom_GType, sizeof(value), 20, 1000);
  initialize (&Field(ret,1), (value) p); return ret; }

void g_class_ref(GObjectClass *klass)
{ g_type_class_ref(G_TYPE_FROM_CLASS(G_OBJECT_CLASS(klass))); }
void g_class_unref(GObjectClass *klass)
{ g_type_class_unref(G_OBJECT_CLASS(klass)); }

Make_Val_final_pointer(GObjectClass, g_class_ref, g_class_unref, 0)

ML_0 (g_type_init, Unit)
ML_1 (g_type_name, GType_val, Val_string)
ML_1 (g_type_from_name, String_val, Val_GType)
ML_1 (g_type_parent, GType_val, Val_GType)
ML_1 (g_type_depth, GType_val, Val_int)
ML_2 (g_type_is_a, GType_val, GType_val, Val_bool)
ML_1 (G_TYPE_FUNDAMENTAL, GType_val, Val_fundamental_type)
ML_1 (Fundamental_type_val, (value), Val_GType)
ML_1 (G_OBJECT_CLASS_NAME, GType_val, Val_string)

static GType
g_type_of_variant (value varnt)
{
    GType g_type = G_TYPE_INVALID;
    if ((long)varnt & 1) { /* polymorphic variant without data */
        switch (varnt) {
          case MLTAG_NONE:
            g_type = G_TYPE_NONE;
            break;
          case MLTAG_BOOL:
            g_type = G_TYPE_BOOLEAN;
            break;
          case MLTAG_UCHAR:
            g_type = G_TYPE_UCHAR;
            break;
          case MLTAG_CHAR:
            g_type = G_TYPE_CHAR;
            break;
          case MLTAG_INT:
            g_type = G_TYPE_INT;
            break;
          case MLTAG_ENUM:
            g_type = G_TYPE_ENUM;
            break;
          case MLTAG_FLAGS:
            g_type = G_TYPE_FLAGS;
            break;
          case MLTAG_UINT:
            g_type = G_TYPE_UINT;
            break;
          case MLTAG_LONG:
            g_type = G_TYPE_LONG;
            break;
          case MLTAG_UINT64:
            g_type = G_TYPE_UINT64;
            break;
          case MLTAG_INT64:
            g_type = G_TYPE_INT64;
            break;
          case MLTAG_DOUBLE:
            g_type = G_TYPE_DOUBLE;
            break;
          case MLTAG_FLOAT:
            g_type = G_TYPE_FLOAT;
            break;
          case MLTAG_INTERFACE:
            g_type = G_TYPE_INTERFACE;
            break;
          case MLTAG_OBJECT:
            g_type = G_TYPE_OBJECT;
            break;
          case MLTAG_BOXED:
            g_type = G_TYPE_BOXED;
            break;
          case MLTAG_POINTER:
            g_type = G_TYPE_POINTER;
            break;
          case MLTAG_STRING:
            g_type = G_TYPE_STRING;
            break;
          default:
            /* XXX: include UINT32, INT32;
             * I don't know what they do in data_kind,
             * they do not even exist in G_TYPE_* */
            break;
        }
    } else { /* polymorphic variant with data */
        switch (Field(varnt, 0)) {
          default: /* include MLTAG_OTHER */
            g_type = Field(varnt, 1);
            break;
        }
    }
    return (g_type);
}

CAMLprim value
ml_gtk_type_class (value type)
{
  GObjectClass *g_class;
  if (!(g_class = gtk_type_class(GType_val(type))))
    ml_raise_null_pointer();
  return (Val_GObjectClass(g_class));
}

CAMLprim value
ml_g_type_class_peek (value type)
{
  GObjectClass *g_class;
  if (!(g_class = g_type_class_peek(GType_val(type))))
    ml_raise_null_pointer();
  return (Val_GObjectClass(g_class));
}

ML_1 (g_type_class_ref, GType_val, Val_GObjectClass)
ML_1 (g_type_class_unref, GObjectClass_val, Unit)

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

CAMLprim value ml_g_type_query (value type)
{
  CAMLparam1(type);
  GTypeQuery query;
  g_type_query(GType_val(type), &query);

  if (query.type == G_TYPE_INVALID) raise_not_found();
  CAMLlocal1(tup);
  tup = alloc_tuple(4);
  Store_field(tup,0,Val_GType(query.type));
  Store_field(tup,1,Val_string(query.type_name));
  Store_field(tup,2,Val_int(query.class_size));
  Store_field(tup,3,Val_int(query.instance_size));
  CAMLreturn(tup);
}

/* These macros are used to create a jump table
 * within the class_data field of GTypeInfo,
 * storing its Caml callbacks */
#define _G_TYPE_INFO_JMPTBL_SIZE 4
#define _G_TYPE_INFO_JMPTBL_OFFSET_CLASS_INIT 0
#define _G_TYPE_INFO_JMPTBL_OFFSET_CLASS_FINALIZE 1
#define _G_TYPE_INFO_JMPTBL_OFFSET_BASE_INIT 2
#define _G_TYPE_INFO_JMPTBL_OFFSET_BASE_FINALIZE 3

/* The custom finalize function for GTypeInfo,
 * whose purpose is to free the jump table
 * of the Caml callbacks */
static void
ml_final_GTypeInfo (value info)
{
    gint i;
    GTypeInfo *_info = &(GTypeInfo_val(info));

    /* Remove the Caml callbacks out the garbage collector machinery */
    for (i = _G_TYPE_INFO_JMPTBL_SIZE; i > 0;) {
      value *ptr = (value *)_info->class_data + (--i);
      if (*ptr) remove_global_root(ptr);
    }

    g_free((void *)_info->class_data);
    _info->class_data = NULL; /* security */
}

static struct custom_operations ml_custom_GTypeInfo =
{
  "GTypeInfo/2.0/",
  ml_final_GTypeInfo,
  custom_compare_default,
  custom_hash_default,
  custom_serialize_default,
  custom_deserialize_default
};

/* C wrappers of Caml callbacks follow */

/* class_init and class_finalize access the jump table
 * directly through their class_data parameter */
static void
_g_type_info_class_init (gpointer _g_class, gconstpointer jmptbl)
{
  value g_class = Val_GObjectClass(_g_class);
  callback(*((value *)jmptbl + _G_TYPE_INFO_JMPTBL_OFFSET_CLASS_INIT), g_class);
}
static void
_g_type_info_class_finalize (gpointer _g_class, gconstpointer jmptbl)
{
  value g_class = Val_GObjectClass(_g_class);
  callback(*((value *)jmptbl + _G_TYPE_INFO_JMPTBL_OFFSET_CLASS_FINALIZE), g_class);
}

/* Since base_init, and other GTypeInfo callbacks have no *_data parameters,
 * we use GQuarks to attach their Caml callbacks within the jump table (stored in GTypeInfo.class_data)
 * to the derived GType at the time of its registering (see ml_g_type_register_static).
 * Then, these GQuarks will be use by the C wrappers of the callbacks
 * to retrieve the addresses of the Caml callbacks */
static char *_g_type_info_base_init_string = "_g_type_info_base_init_quark";
static GQuark _g_type_info_base_init_quark = 0;
static void
_g_type_info_base_init (gpointer _g_class)
{
  GType gtype = G_TYPE_FROM_CLASS(_g_class);
  gpointer gptr = g_type_get_qdata(gtype, _g_type_info_base_init_quark);
  value g_class = Val_GObjectClass(_g_class);
  callback((value)gptr, g_class);
}
static char *_g_type_info_base_finalize_string = "_g_type_info_base_finalize_quark";
static GQuark _g_type_info_base_finalize_quark = 0;
static void
_g_type_info_base_finalize (gpointer _g_class)
{
  GType gtype = G_TYPE_FROM_CLASS(_g_class);
  gpointer gptr = g_type_get_qdata(gtype, _g_type_info_base_finalize_quark);
  value g_class = Val_GObjectClass(_g_class);
  callback((value)gptr, g_class);
}

/* Initialization function running once and for all at starting time,
 * whose purpose is to set up the GQuarks used by the wrapping of GTypeInfo */
CAMLprim value
ml_GTypeInfo_init(value unit)
{
  _g_type_info_base_init_quark
    = g_quark_from_static_string(_g_type_info_base_init_string);
  _g_type_info_base_finalize_quark
    = g_quark_from_static_string(_g_type_info_base_finalize_string);
  return Val_unit;
}

/* GTypeInfo creator */
CAMLprim value
ml_GTypeInfo_new(value class_size, value base_init, value base_finalize,
                 value class_init, value class_finalize, value instance_size,
                 value n_preallocs, /* TODO: value value_table,
                 value instance_init,*/ value unit)
{
  CAMLparam5(class_size, base_init, base_finalize,
             class_init, class_finalize);
  CAMLxparam2(instance_size, n_preallocs);
  CAMLlocal1(info);
  gint i;

  /* Use the class_data field of the GTypeInfo as a jump table,
   * discarding incidentally its const qualifier */
  value *class_data = g_new0(value, _G_TYPE_INFO_JMPTBL_SIZE);

  *(class_data + _G_TYPE_INFO_JMPTBL_OFFSET_CLASS_INIT)
    = Option_val(class_init,Id,(value)NULL);
  *(class_data + _G_TYPE_INFO_JMPTBL_OFFSET_CLASS_FINALIZE)
    = Option_val(class_finalize,Id,(value)NULL);

  /* Following fields are stored here in order to be attached
   * with a GQuark to the GType when it is registered */
  *(class_data + _G_TYPE_INFO_JMPTBL_OFFSET_BASE_INIT)
    = Option_val(base_init,Id,(value)NULL);
  *(class_data + _G_TYPE_INFO_JMPTBL_OFFSET_BASE_FINALIZE)
    = Option_val(base_finalize,Id,(value)NULL);

  /* Register the Caml callbacks in the garbage collector machinery */
  for (i = _G_TYPE_INFO_JMPTBL_SIZE; i > 0;) {
    value *ptr = class_data + (--i);
    if (*ptr) register_global_root(ptr);
  }

  /* Freed in the custom finalization function */
  info = alloc_custom(&ml_custom_GTypeInfo, sizeof(GTypeInfo),
                      20, 1000 /* TODO: verify the pertinence of these numbers */);
  GTypeInfo *_info = &(GTypeInfo_val(info));

  _info->class_size = Option_val(class_size,Int_val,0);
  _info->base_init = (GBaseInitFunc)Option_val(base_init,_g_type_info_base_init Ignore,NULL);
  _info->base_finalize = (GBaseFinalizeFunc)Option_val(base_finalize,_g_type_info_base_finalize Ignore,NULL);
  _info->class_init = (GClassInitFunc)Option_val(class_init,_g_type_info_class_init Ignore,NULL);
  _info->class_finalize = (GClassFinalizeFunc)Option_val(class_finalize,_g_type_info_class_finalize Ignore,NULL);
  _info->class_data = class_data;
  _info->instance_size = Option_val(instance_size,Int_val,0);
  _info->n_preallocs = Option_val(n_preallocs,Int_val,0);
  _info->instance_init = NULL;
  _info->value_table = NULL; /* TODO */

  CAMLreturn(info);
}
ML_bc8 (ml_GTypeInfo_new)

CAMLprim value
ml_g_type_register_static(value parent, value type_name,
                          value info, value unit)
{
  GType derived;
  GType _parent = GType_val(parent);
  const GTypeInfo *_info;

  if ((long)info-1) { /* Some _ */
    _info = &(GTypeInfo_val(Field(info,0)));
  } else {
    /* When no GTypeInfo is provided, a minimal one is used */
    GTypeQuery query;
    g_type_query (_parent, &query);
    if (query.type == G_TYPE_INVALID)
      failwith ("g_type_register_static: invalid parent g_type");
    /* The contents of the GTypeInfo struct is copied,
     * so it is ok to use a not really static one
     * (i.e. one on the stack) */
    const GTypeInfo const_info = {
        query.class_size,
        NULL, /* base_init */
        NULL, /* base_finalize */
        NULL, /* class_init */
        NULL, /* class_finalize */
        NULL, /* class_data */
        query.instance_size,
        0,    /* n_preallocs */
        NULL, /* instance_init */
        NULL  /* value_table */ };
    _info = &const_info;
  }
  if ((derived = g_type_register_static(_parent,
         String_val(type_name), _info, 0)) == G_TYPE_INVALID)
    failwith ("g_type_register_static: invalid derived g_type");

  if ((long)info-1) { /* Some _ */
    /* The _info->class_data is used as a jump table (see ml_GTypeInfo_new)
     * holding the addresses of the Caml callbacks.
     * Except class_init and class_finalize, the C wrappers of these
     * Caml callback have no access to class_data, thus no access
     * to the Caml callbacks within, so the trick is to attach these
     * Caml callbacks to the GType through a GQuark. That's what we do now */
    g_type_set_qdata(derived, _g_type_info_base_init_quark,
                     (gpointer)*((value *)_info->class_data
                       + _G_TYPE_INFO_JMPTBL_OFFSET_BASE_INIT));
    g_type_set_qdata(derived, _g_type_info_base_finalize_quark,
                     (gpointer)*((value *)_info->class_data
                       + _G_TYPE_INFO_JMPTBL_OFFSET_BASE_FINALIZE));
  }

  return (Val_GType(derived));
}

/* gclosure.h */

Make_Val_final_pointer(GClosure, g_closure_ref, g_closure_unref, 0)

#define g_closure_ref_and_sink(w) (g_closure_ref(w), g_closure_sink(w))
Make_Val_final_pointer_ext(GClosure, _sink , g_closure_ref_and_sink,
                           g_closure_unref, 20)

static void notify_destroy(gpointer unit, GClosure *c)
{
    // printf("release %p\n", &c->data);
    remove_global_root((value*)&c->data);
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

    callback_exn ((value)closure->data, vargs);

    CAMLreturn0;
}

CAMLprim value ml_g_closure_new (value clos)
{
    GClosure* closure = g_closure_new_simple(sizeof(GClosure), (gpointer)clos);
    // printf("register %p\n", &closure->data);
    register_global_root((value*)&closure->data);
    g_closure_add_invalidate_notifier(closure, NULL, notify_destroy);
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
    Field(ret,1) = (value)2;
    ((GValue*)&Field(ret,2))->g_type = 0;
    return ret;
}

CAMLprim value Val_GValue_copy(GValue *gv)
{
    value ret = ml_g_value_new();
    *((GValue*)&Field(ret,2)) = *gv;
    return ret;
}

CAMLprim value ml_g_value_release(value val)
{
    ml_final_GValue (val);
    Store_pointer(val,NULL);
    return Val_unit;
}

CAMLprim GValue* GValue_val(value val)
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
    if (p != NULL) g_boxed_free ((GType)Field(val,2), p);
    p = NULL;
}
static struct custom_operations ml_custom_gboxed =
{ "gboxed/2.0/", ml_final_gboxed, custom_compare_default, custom_hash_default,
  custom_serialize_default, custom_deserialize_default };
CAMLprim value Val_gboxed(GType t, gpointer p)
{
    value ret = alloc_custom(&ml_custom_gboxed, 2*sizeof(value), 10, 1000);
    Store_pointer(ret, g_boxed_copy (t,p));
    Field(ret,2) = (value)t;
    return ret;
}
CAMLprim value Val_gboxed_new(GType t, gpointer p)
{
    value ret = alloc_custom(&ml_custom_gboxed, 2*sizeof(value), 10, 1000);
    Store_pointer(ret, p);
    Field(ret,2) = (value)t;
    return ret;
}

/* Read/Write a value */

#define DATA  (val->data[0])

static value g_value_get_variant (GValue *val)
{
    CAMLparam0();
    CAMLlocal1(tmp);
    value ret = MLTAG_NONE;
    GType type;
    value tag = (value)0;

    if (! G_IS_VALUE(val))
      invalid_argument("Gobject.Value.get");

    type = G_VALUE_TYPE(val);

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
      if (type == G_TYPE_CAML) {
	value *data = g_value_get_boxed (val);
	if (data != NULL) {
	  tag = MLTAG_CAML;
	  tmp = *data;
	}
      }
      else {
	tag = MLTAG_POINTER;
	tmp = (DATA.v_pointer == NULL ? Val_unit
	       : ml_some(Val_gboxed(type, DATA.v_pointer)));
      }
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
    }
    if ((long)tag != 0) {
        ret = alloc_small(2,0);
        Field(ret,0) = tag;
        Field(ret,1) = tmp;
    }
    CAMLreturn(ret);
}

ML_1 (g_value_get_variant, GValue_val, ID)

static void g_value_set_variant (GValue *val, value arg)
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
      switch ((long)tag) {
      case (long)MLTAG_INT:
	DATA.v_long = Int_val(data); return;
      case (long)MLTAG_INT32:
	DATA.v_long = Int32_val(data); return;
      case (long)MLTAG_LONG:
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
        if (tag == MLTAG_CAML && type == G_TYPE_CAML)
	  g_value_store_caml_value (val, data);
	else if (tag == MLTAG_POINTER)
	  g_value_set_boxed(val, Option_val(data,MLPointer_val,NULL));
	else break;
        return;
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
      params_copy = g_new0(GParameter, n);
      param = params_copy;
      for (cell = params; cell != Val_unit; cell = Field(cell,1)) {
        param->name = String_val(Field(Field(cell,0),0));
        pspec = g_object_class_find_property (class, param->name);
        if (!pspec) failwith ("Gobject.unsafe_create");
        g_value_init (&param->value, pspec->value_type);
        g_value_set_variant (&param->value, Field(Field(cell,0),1));
        param++;
      }
    }

    ret = g_object_newv (GType_val(type), n, params_copy);

    if (n > 0) {
      for (i=0; i<n; i++) g_value_unset(&params_copy[i].value);
      g_free(params_copy);
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

Make_Flags_val (Signal_flag_val)
Make_OptFlags_val (Signal_flag_val)

ML_4 (g_signal_connect_closure, GObject_val, String_val, GClosure_val,
      Bool_val, Val_long)
ML_2 (g_signal_handler_block, GObject_val, Long_val, Unit)
ML_2 (g_signal_handler_unblock, GObject_val, Long_val, Unit)
ML_2 (g_signal_handler_disconnect, GObject_val, Long_val, Unit)
ML_2 (g_signal_handler_is_connected, GObject_val, Long_val, Val_bool)
ML_2 (g_signal_stop_emission_by_name, GObject_val, String_val, Unit)

CAMLprim value
ml_g_signal_new (value name, value itype, value signal_flags,
                 /* TODO: value class_closure, value accumulator, */
                 value return_type, value params, value unit)
{
    CAMLparam5(name, itype, signal_flags, return_type, params);
    gint n_params = Option_val(params, Wosize_val, 0);
    GType *param_types = g_new0 (GType, n_params);
    GType *ptr = param_types;
    gint i, id;
    value p = Option_val(params, Id, (value)NULL);
    
    for (i = 0; i < n_params;)
        *(ptr++) = g_type_of_variant(Field(p, i++));
    
    id = g_signal_newv (
      String_val(name),
      GType_val(itype),
      OptFlags_Signal_flag_val(signal_flags),
      (GClosure *)NULL,
      (GSignalAccumulator)NULL,
      (gpointer)NULL,
      (GSignalCMarshaller)marshal,
      Option_val(return_type, GType_val, G_TYPE_NONE),
      n_params,
      param_types );
    
    g_free (param_types);
    CAMLreturn (Int_val(id));
}
ML_bc6(ml_g_signal_new)

CAMLprim value ml_g_signal_emit_by_name (value obj, value sig, value params)
{
    CAMLparam3(obj,sig,params);
    CAMLlocal1(ret);
    GObject *instance = GObject_val(obj);
    GValue *iparams = g_new0(GValue,1 + Wosize_val(params));
    GQuark detail = 0;
    GType itype = G_TYPE_FROM_INSTANCE (instance);
    GType return_type;
    guint signal_id;
    unsigned int i;
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
    g_free (iparams);
    if (!ret) ret = Val_unit;
    CAMLreturn(ret);
}

CAMLprim value ml_g_signal_override_class_closure(value vname, value vt, value vc)
{
  GType t = GType_val(vt);
  guint signal_id = g_signal_lookup(String_val(vname), t);
  g_signal_override_class_closure (signal_id, t, GClosure_val(vc));
  return Val_unit;
}

CAMLprim value ml_g_signal_chain_from_overridden (value clos_argv)
{
  CAMLparam1(clos_argv);
  value val;
  GValue *ret, *args;

  val  = Field(clos_argv, 0);
  ret  = Tag_val(val) == Abstract_tag ? GValue_val (val) : NULL;
  val  = Field(clos_argv, 2);
  args = Tag_val(val) == Abstract_tag ? GValue_val (val) : NULL;
  g_signal_chain_from_overridden (args, ret);
  CAMLreturn(Val_unit);
}

/* gparamspecs.h */

Make_Val_final_pointer(GParamSpec, g_param_spec_ref, g_param_spec_unref, 0)
#define g_param_spec_ref_and_sink(w) (g_param_spec_ref(w), g_param_spec_sink(w))
Make_Val_final_pointer_ext(GParamSpec, _sink , g_param_spec_ref_and_sink,
                           g_param_spec_unref, 20)

Make_Flags_val (Param_flag_val)
Make_OptFlags_val (Param_flag_val)

ML_7 (g_param_spec_int, String_val, String_val, String_val,
      Int_val, Int_val, Int_val, Flags_Param_flag_val, Val_GParamSpec)
ML_bc7 (ml_g_param_spec_int)

CAMLprim value
ml_g_param_spec_string(value name, value nick, value blurb,
                       value def, value param, value unit)
{
  gchar *_name = String_val(name);
  return (Val_GParamSpec(g_param_spec_string(_name,
                                             Option_val(nick,String_val,_name),
                                             Option_val(blurb,String_val,_name),
                                             String_option_val(def),
                                             OptFlags_Param_flag_val(param))));
}
ML_bc6 (ml_g_param_spec_string)

ML_7 (g_param_spec_float, String_val, String_val, String_val,
      Float_val, Float_val, Float_val, Flags_Param_flag_val, Val_GParamSpec)
ML_bc7 (ml_g_param_spec_float)


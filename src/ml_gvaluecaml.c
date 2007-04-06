
#include <glib-object.h>

#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/fail.h>
#include <caml/callback.h>

#include "wrappers.h"
#include "ml_gobject.h"
#include "ml_gvaluecaml.h"

static gpointer caml_boxed_copy (gpointer boxed)
{
  value *val = boxed;
  return ml_global_root_new (*val);
}

GType g_caml_get_type()
{
  static GType type = G_TYPE_INVALID;
  if (type == G_TYPE_INVALID)
    type = g_boxed_type_register_static ("Caml",
					 caml_boxed_copy,
					 ml_global_root_destroy);
  return type;
}

CAMLprim value ml_g_caml_get_type(value unit)
{
  return Val_GType(G_TYPE_CAML);
}

void g_value_store_caml_value (GValue *val, value arg)
{
  g_return_if_fail (G_VALUE_HOLDS(val, G_TYPE_CAML));
  g_value_set_boxed (val, &arg);
}

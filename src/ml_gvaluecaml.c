
#include <glib-object.h>

#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/fail.h>
#include <caml/callback.h>

#include "wrappers.h"
#include "ml_gobject.h"
#include "ml_gvaluecaml.h"

static void
value_init_caml (GValue *value)
{
  /* GValue is already zeroed-out */
  /* value->data[0].v_long = 0; */
  register_global_root(&value->data[0].v_long);
}

static void
value_free_caml (GValue *value)
{
  remove_global_root(&value->data[0].v_long);
}

static void
value_copy_caml (const GValue *src_value,
		 GValue       *dest_value)
{
  dest_value->data[0].v_long = src_value->data[0].v_long;
}

GType
g_caml_get_type()
{
  static GType type;
  if (type == G_TYPE_INVALID) {
    const GTypeValueTable value_table = {
      /* .value_init = */ 	value_init_caml,
      /* .value_free = */ 	value_free_caml,		
      /* .value_copy = */ 	value_copy_caml, 
      /* .value_peek_pointer = */ NULL,
      /* .collect_format = */ 	NULL,
      /* .collect_value = */ 	NULL,
      /* .lcopy_format = */ 	NULL,
      /* .lcopy_value = */ 	NULL
    };
    const GTypeInfo info = {
      /* .class_size = */ 	0,    
      /* .base_init = */ 	NULL, 
      /* .base_finalize = */ 	NULL, 
      /* .class_init = */ 	NULL, 
      /* .class_finalize = */ 	NULL, 
      /* .class_data = */ 	NULL, 
      /* .instance_size = */ 	0,    
      /* .n_preallocs = */ 	0,    
      /* .instance_init = */ 	NULL, 
      /* .value_table = */ 	&value_table 
    };
    type = g_type_register_static(G_TYPE_POINTER, "Caml",
				  &info, G_TYPE_FLAG_ABSTRACT);
  }
  return type;
}

CAMLprim value ml_g_caml_get_type(value unit)
{
  return Val_GType(G_TYPE_CAML);
}

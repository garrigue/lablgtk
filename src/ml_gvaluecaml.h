GType g_caml_get_type() G_GNUC_CONST;

#define G_TYPE_CAML (g_caml_get_type())

void g_value_store_caml_value (GValue *, value);

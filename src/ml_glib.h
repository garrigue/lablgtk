/* $Id$ */

value copy_string_g_free (char *str); /* for g_strings only */

typedef value (*value_in)(gpointer);
typedef gpointer (*value_out)(value);

value Val_GList (GList *list, value_in);
value Val_GList_free (GList *list, value_in);
GList *GList_val (value list, value_out);

value Val_GSList (GSList *list, value_in);
value Val_GSList_free (GSList *list, value_in);
GSList *GSList_val (value list, value_out);

void ml_register_exn_map (GQuark domain, char *caml_name);
void ml_raise_gerror(GError *) Noreturn;

/* $Id$ */

CAMLexport value copy_string_g_free (char *str); /* for g_strings only */

typedef value (*value_in)(gpointer);
typedef gpointer (*value_out)(value);

CAMLexport value Val_GList (GList *list, value_in);
CAMLexport value Val_GList_free (GList *list, value_in);
CAMLexport GList *GList_val (value list, value_out);

CAMLexport value Val_GSList (GSList *list, value_in);
CAMLexport value Val_GSList_free (GSList *list, value_in);
CAMLexport GSList *GSList_val (value list, value_out);

CAMLexport void ml_register_exn_map (GQuark domain, char *caml_name);
CAMLexport void ml_raise_gerror(GError *) Noreturn;

/* $Id$ */

CAMLextern value copy_string_g_free (char *str); /* for g_strings only */

typedef value (*value_in)(gpointer);
typedef gpointer (*value_out)(value);

CAMLextern value Val_GList (GList *list, value_in);
CAMLextern value Val_GList_free (GList *list, value_in);
CAMLextern GList *GList_val (value list, value_out);

CAMLextern value Val_GSList (GSList *list, value_in);
CAMLextern value Val_GSList_free (GSList *list, value_in);
CAMLextern GSList *GSList_val (value list, value_out);

CAMLextern void ml_register_exn_map (GQuark domain, char *caml_name);
CAMLextern void ml_raise_gerror(GError *) Noreturn;

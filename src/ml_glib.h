/* $Id$ */

value copy_string_and_free (char *str); /* for g_strings only */
value Val_GList (GList *list, value (*func)(gpointer));
GList *GList_val (value list, gpointer (*func)(value));

/*
value Val_GSList (GSList *list, value (*func)(gpointer));
GSList *GSList_val (value list, gpointer (*func)(value));
*/

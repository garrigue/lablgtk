/* $Id$ */

extern value Val_GSList (GSList *list, value (*func)(gpointer));

extern GSList *GSList_val (value list, gpointer (*func)(value));

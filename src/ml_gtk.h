/* $Id$ */

#define GtkObject_val(obj) ((GtkObject*)Field(obj,1))
extern value Val_GtkObject (GtkObject *w);

#define cast(f,v) (v == NULL ? NULL : f(v))

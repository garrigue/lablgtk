/* $Id$ */

#define GtkObject_val(obj) ((GtkObject*)Field(obj,1))
extern value Val_GtkObject (GtkObject *w);

#define check_cast(f,v) (Pointer_val(v) == NULL ? NULL : f(Pointer_val(v)))

/* $Id$ */

#define GtkObject_val(obj) ((GtkObject*)Field(obj,1))
extern value Val_GtkObject (GtkObject *w);

#ifdef GTK_NO_CHECK_CASTS
#define check_cast(f,v) f(Pointer_val(v))
#else
#define check_cast(f,v) (Pointer_val(v) == NULL ? NULL : f(Pointer_val(v)))
#endif

/* $Id$ */

#define GtkObject_val(obj) ((GtkObject*)Field(obj,1))
value Val_GtkObject (GtkObject *w);
value Val_GtkObject_sink (GtkObject *w);
#define Val_GtkAny(w) Val_GtkObject((GtkObject*)w)
#define Val_GtkAny_sink(w) Val_GtkObject_sink((GtkObject*)w)
#define Val_GtkWidget Val_GtkAny
#define Val_GtkWidget_sink Val_GtkAny_sink

#ifdef GTK_NO_CHECK_CASTS
#define check_cast(f,v) f(Pointer_val(v))
#else
#define check_cast(f,v) (Pointer_val(v) == NULL ? NULL : f(Pointer_val(v)))
#endif

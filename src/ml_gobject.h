/* $Id$ */

/* Defined in ml_gobject.h */

#define GObject_val(val) ((GObject*)Pointer_val(val))
value Val_GObject (GObject *);
value Val_GObject_new (GObject *);
#define Val_GObject_child(val) (Val_GObject(&(val)->parent_instance))
#define Val_GObject_child_new(val) (Val_GObject_new(&(val)->parent_instance))

#define GType_val Int_val
#define Val_GType Val_int

#define GClosure_val(val) ((GClosure*)Pointer_val(val))
value Val_GClosure (GClosure *);

#define Val_GValue Val_pointer  /* Must use Value.copy on ML side */
#define GValue_val(val) ((GValue *)Pointer_val(val))
GValue *GValue_check(value);    /* Error if NULL */
value ml_g_value_new(value gtype);


/* Macro utilities for export */
/* used in ml_gtk.h for instance */

#ifdef G_DISABLE_CAST_CHECKS
#define check_cast(f,v) f(Pointer_val(v))
#else
#define check_cast(f,v) (Pointer_val(v) == NULL ? NULL : f(Pointer_val(v)))
#endif

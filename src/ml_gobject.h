/* $Id$ */

#define GObject_val(val) ((GObject*)Pointer_val(val))
value Val_GObject (GObject *);
value Val_GObject_new (GObject *);

#define GType_val Int_val
#define Val_GType Val_int

#define GClosure_val(val) ((GClosure*)Pointer_val(val))
value Val_GClosure (GClosure *);

#define Val_GValue Val_pointer  /* Must use Value.copy on ML side */
#define GValue_val(val) ((GValue *)Pointer_val(val))
GValue *GValue_check(value);    /* Error if NULL */
value ml_g_value_new(value gtype);

/* $Id$ */

#define GObject_val(val) ((GObject*)Pointer_val(val))
value Val_GObject (GObject *);
value Val_GObject_new (GObject *);

#define GClosure_val(val) ((GClosure*)Pointer_val(val))
value Val_GClosure (GClosure *);

#define Val_GValue Val_pointer
GValue *GValue_val(value);

/* $Id$ */

#define GdkPixbuf_val(val)       (check_cast(GDK_PIXBUF, val))
#define Val_GdkPixbuf(val)       (Val_GObject(G_OBJECT(val)))
#define Val_GdkPixbuf_new(val)   (Val_GObject_new(G_OBJECT(val)))


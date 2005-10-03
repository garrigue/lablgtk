/* $Id$ */

#define GdkPixbuf_val(val)       (check_cast(GDK_PIXBUF, val))
value Val_GdkPixbuf_ (GdkPixbuf *, gboolean);
#define Val_GdkPixbuf(p)         Val_GdkPixbuf_(p, TRUE)
#define Val_GdkPixbuf_new(p)     Val_GdkPixbuf_(p, FALSE)

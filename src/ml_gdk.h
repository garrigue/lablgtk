/* $Id$ */

#define GdkColormap_val(val) ((GdkColormap*)Pointer_val(val))
extern value Val_GdkColormap (GdkColormap *);

#define GdkColor_val(val) ((GdkColor *) val)
#define Val_GdkColor Val_any

#define GdkWindow_val(val) ((GdkWindow*)Pointer_val(val))
extern value Val_GdkWindow (GdkWindow *);

#define GdkPixmap_val(val) ((GdkPixmap*)Pointer_val(val))
extern value Val_GdkPixmap (GdkPixmap *);

#define GdkBitmap_val(val) ((GdkBitmap*)Pointer_val(val))
extern value Val_GdkBitmap (GdkBitmap *);

#define GdkFont_val(val) ((GdkFont*)Pointer_val(val))
extern value Val_GdkFont (GdkFont *);

#define GdkEvent_val(type) (GdkEvent##type *)Pointer_val

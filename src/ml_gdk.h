/* $Id$ */

#define GdkAtom_val(val) ((GdkAtom)Long_val(val))
#define Val_GdkAtom(val) (Val_long(val))

#define GdkColormap_val(val) check_cast(GDK_COLORMAP,val)
#define Val_GdkColormap Val_GAnyObject

#define GdkColor_val(val) ((GdkColor*)MLPointer_val(val))
#define Val_GdkColor Val_pointer

#define GdkRectangle_val(val) ((GdkRectangle*)MLPointer_val(val))
#define Val_GdkRectangle Val_pointer

#define GdkDrawable_val(val) check_cast(GDK_DRAWABLE,val)

#define GdkWindow_val(val) check_cast(GDK_WINDOW,val)
#define Val_GdkWindow Val_GAnyObject

#define GdkCursor_val(val) ((GdkCursor*)Pointer_val(val))

#define GdkPixmap_val(val) check_cast(GDK_PIXMAP,val)
#define Val_GdkPixmap Val_GAnyObject
#define Val_GdkPixmap_no_ref Val_GAnyObject_new

#define GdkBitmap_val(val) ((GdkBitmap*)GdkPixmap_val(val))
#define Val_GdkBitmap Val_GdkPixmap
#define Val_GdkBitmap_no_ref Val_GdkPixmap_no_ref

#ifndef UnsafeImage
extern GdkImage *GdkImage_val (value);  /* check argument */
extern value Val_GdkImage (GdkImage *);
#else
#define GdkImage_val(val) ((GdkImage*)val)
#define Val_GdkImage(img) ((value) img)
#endif

#define GdkFont_val(val) ((GdkFont*)Pointer_val(val))
extern value Val_GdkFont (GdkFont *);

extern GdkRegion *GdkRegion_val (value); /* check argument */
extern value Val_GdkRegion (GdkRegion *); /* finalizer is destroy! */

#define GdkGC_val(val) check_cast(GDK_GC,val)
#define Val_GdkGC Val_GAnyObject
#define Val_GdkGC_no_ref Val_GAnyObject_new

#define GdkEvent_val (GdkEvent*)MLPointer_val

#define GdkVisual_val(val) ((GdkVisual*) val)
#define Val_GdkVisual(visual) ((value) visual)

#define GdkScreen_val(val) check_cast(GDK_SCREEN,val)
#define Val_GdkScreen Val_GAnyObject

#define GdkDevice_val(val) ((GdkDevice*) val)
#define Val_GdkDevice(device) ((value) device)

#ifdef _WIN32
#define Val_XID(id) copy_int32((long) id)
#else
#define Val_XID copy_int32
#endif
#define XID_val Int32_val

extern int OptFlags_GdkModifier_val (value);
extern int Flags_GdkModifier_val (value);
extern int Flags_Event_mask_val (value);
extern lookup_info ml_table_extension_events[];
#define Extension_events_val(key) ml_lookup_to_c (ml_table_extension_events, key)

#define GdkDragContext_val(val) check_cast(GDK_DRAG_CONTEXT,val)
#define Val_GdkDragContext Val_GAnyObject
extern int Flags_GdkDragAction_val (value);

/* $Id$ */

#define GdkAtom_val(val) ((GdkAtom)Long_val(val))
#define Val_GdkAtom(val) (Val_long(val))

#define GdkColormap_val(val) ((GdkColormap*)Pointer_val(val))
extern value Val_GdkColormap (GdkColormap *);

#define GdkColor_val(val) ((GdkColor*)MLPointer_val(val))
#define Val_GdkColor Val_pointer

#define GdkRectangle_val(val) ((GdkRectangle*)MLPointer_val(val))
#define Val_GdkRectangle Val_pointer

#define GdkDrawable_val(val) ((GdkDrawable*)Pointer_val(val))

#define GdkWindow_val(val) ((GdkWindow*)Pointer_val(val))
extern value Val_GdkWindow (GdkWindow *);

#define GdkCursor_val(val) ((GdkCursor*)Pointer_val(val))
#define Val_GdkCursor Val_pointer

#define GdkPixmap_val(val) ((GdkPixmap*)Pointer_val(val))
extern value Val_GdkPixmap (GdkPixmap *);

#define GdkBitmap_val(val) ((GdkBitmap*)Pointer_val(val))
extern value Val_GdkBitmap (GdkBitmap *);

extern GdkImage *GdkImage_val (value); /* check argument */
extern value Val_GdkImage (GdkImage *); /* finalizer is destroy! */

#define GdkFont_val(val) ((GdkFont*)Pointer_val(val))
extern value Val_GdkFont (GdkFont *);

extern GdkRegion *GdkRegion_val (value); /* check argument */
extern value Val_GdkRegion (GdkRegion *); /* finalizer is destroy! */

#define GdkGC_val(val) ((GdkGC*)Pointer_val(val))
extern value Val_GdkGC (GdkGC *);

#define GdkEvent_val (GdkEvent*)MLPointer_val

#define GdkVisual_val(val) ((GdkVisual*) val)
#define Val_GdkVisual(visual) ((value) visual)

#define GdkDevice_val(val) ((GdkDevice*) val)
#define Val_GdkDevice(device) ((value) device)

#ifdef _WIN32
#define Val_XID(id) copy_int32((long) id)
#else
#define Val_XID copy_int32
#endif
#define XID_val Int32_val

extern int OptFlags_GdkModifier_val (value);
extern int Flags_Event_mask_val (value);
extern lookup_info ml_table_extension_events[];
#define Extension_events_val(key) ml_lookup_to_c (ml_table_extension_events, key)

#define GdkDragContext_val(val) ((GdkDragContext*)Pointer_val(val))
extern value Val_GdkDragContext (GdkDragContext *);
extern int Flags_GdkDragAction_val (value);

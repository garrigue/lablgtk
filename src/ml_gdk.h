/**************************************************************************/
/*                Lablgtk                                                 */
/*                                                                        */
/*    This program is free software; you can redistribute it              */
/*    and/or modify it under the terms of the GNU Library General         */
/*    Public License as published by the Free Software Foundation         */
/*    version 2, with the exception described in file COPYING which       */
/*    comes with the library.                                             */
/*                                                                        */
/*    This program is distributed in the hope that it will be useful,     */
/*    but WITHOUT ANY WARRANTY; without even the implied warranty of      */
/*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       */
/*    GNU Library General Public License for more details.                */
/*                                                                        */
/*    You should have received a copy of the GNU Library General          */
/*    Public License along with this program; if not, write to the        */
/*    Free Software Foundation, Inc., 59 Temple Place, Suite 330,         */
/*    Boston, MA 02111-1307  USA                                          */
/*                                                                        */
/*                                                                        */
/**************************************************************************/

/* $Id$ */

#define GdkAtom_val(val) ((GdkAtom)Long_val(val))
#define Val_GdkAtom(val) (Val_long((long)val))

/* Removed in gtk3
#define GdkColormap_val(val) check_cast(GDK_COLORMAP,val)
#define Val_GdkColormap Val_GAnyObject
*/

#define GdkColor_val(val) ((GdkColor*)MLPointer_val(val))
#define Val_GdkColor Val_pointer

#define GdkRectangle_val(val) ((GdkRectangle*)MLPointer_val(val))
#define Val_GdkRectangle Val_pointer

#define GdkDrawable_val(val) check_cast(GDK_DRAWABLE,val)

#define GdkWindow_val(val) check_cast(GDK_WINDOW,val)
#define Val_GdkWindow Val_GAnyObject

#define GdkCursor_val(val) ((GdkCursor*)Pointer_val(val))

#define GdkDisplay_val(val) ((GdkDisplay*) val)
#define Val_GdkDisplay(display) ((value) display)

#define GdkEvent_val (GdkEvent*)MLPointer_val
CAMLexport value Val_GdkEvent (GdkEvent *);

#define GdkVisual_val(val) ((GdkVisual*) val)
#define Val_GdkVisual(visual) ((value) visual)

#define GdkScreen_val(val) check_cast(GDK_SCREEN,val)
#define Val_GdkScreen Val_GAnyObject

#define GdkDevice_val(val) ((GdkDevice*) val)
#define Val_GdkDevice(device) ((value) device)

// Future replacement for XID?
#ifdef GDK_NATIVE_WINDOW_POINTER
#define GdkNativeWindow_val Pointer_val
#define Val_GdkNativeWindow Val_pointer
#else
#define Val_GdkNativeWindow copy_int32
#define GdkNativeWindow_val Int32_val
#endif

#ifdef _WIN32
#define Val_XID(id) copy_int32((long) id)
#else
#define Val_XID copy_int32
#endif
#define XID_val Int32_val


CAMLexport int OptFlags_GdkModifier_val (value);
CAMLexport int Flags_GdkModifier_val (value);
CAMLexport int Flags_Event_mask_val (value);
CAMLexport lookup_info *ml_table_extension_events;
#define Extension_events_val(key) ml_lookup_to_c(ml_table_extension_events,key)

#define GdkDragContext_val(val) check_cast(GDK_DRAG_CONTEXT,val)
#define Val_GdkDragContext Val_GAnyObject
CAMLexport int Flags_GdkDragAction_val (value);

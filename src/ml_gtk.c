/* $Id$ */

#include <gtk/gtk.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>
#include <caml/fail.h>

#include "wrappers.h"
#include "ml_glib.h"
#include "ml_gdk.h"
#include "ml_gtk.h"
#include "gtk_tags.h"

void ml_raise_gtk (const char *errmsg)
{
  static value * exn = NULL;
  if (exn == NULL)
      exn = caml_named_value ("gtkerror");
  raise_with_string (*exn, (char*)errmsg);
}

value copy_string_and_free (char *str)
{
    value res;
    res = copy_string_check (str);
    g_free (str);
    return res;
}

/* conversion functions */

#include "gtk_tags.c"

ML_1 (Val_direction_type, Int_val, )
ML_1 (Val_orientation, Int_val, )
ML_1 (Val_toolbar_style, Int_val, )
ML_1 (Val_state_type, Int_val, )

Make_Flags_val (Attach_options_val)
Make_Flags_val (Button_action_val)

/* gtkobject.h */

Make_Val_final_pointer(GtkObject, , gtk_object_ref, gtk_object_unref)

#define gtk_object_ref_and_sink(w) (gtk_object_ref(w), gtk_object_sink(w))
Make_Val_final_pointer(GtkObject, _sink , gtk_object_ref_and_sink,
		       gtk_object_unref)

#define Val_GtkAny(w) Val_GtkObject((GtkObject*)w)
#define Val_GtkAny_sink(w) Val_GtkObject_sink((GtkObject*)w)

/* gtkaccelgroup.h */

#define GtkAccelGroup_val(val) ((GtkAccelGroup*)Pointer_val(val))
Make_Val_final_pointer (GtkAccelGroup, , gtk_accel_group_ref,
			gtk_accel_group_unref)
Make_Val_final_pointer (GtkAccelGroup, _no_ref, Ignore,
			gtk_accel_group_unref)
Make_OptFlags_val (Accel_flag_val)

#define Signal_name_val(val) String_val(Field(val,0))

ML_0 (gtk_accel_group_new, Val_GtkAccelGroup_no_ref)
ML_0 (gtk_accel_group_get_default, Val_GtkAccelGroup)
ML_3 (gtk_accel_group_activate, GtkAccelGroup_val, Int_val,
      OptFlags_GdkModifier_val, Val_bool)
ML_3 (gtk_accel_groups_activate, GtkObject_val, Int_val,
      OptFlags_GdkModifier_val, Val_bool)
ML_2 (gtk_accel_group_attach, GtkAccelGroup_val, GtkObject_val, Unit)
ML_2 (gtk_accel_group_detach, GtkAccelGroup_val, GtkObject_val, Unit)
ML_1 (gtk_accel_group_lock, GtkAccelGroup_val, Unit)
ML_1 (gtk_accel_group_unlock, GtkAccelGroup_val, Unit)
ML_3 (gtk_accel_group_lock_entry, GtkAccelGroup_val, Int_val,
      OptFlags_GdkModifier_val, Unit)
ML_3 (gtk_accel_group_unlock_entry, GtkAccelGroup_val, Int_val,
      OptFlags_GdkModifier_val, Unit)
ML_6 (gtk_accel_group_add, GtkAccelGroup_val, Int_val,
      OptFlags_GdkModifier_val, OptFlags_Accel_flag_val,
      GtkObject_val, Signal_name_val, Unit)
ML_bc6 (ml_gtk_accel_group_add)
ML_4 (gtk_accel_group_remove, GtkAccelGroup_val, Int_val,
      OptFlags_GdkModifier_val, GtkObject_val, Unit)
ML_2 (gtk_accelerator_valid, Int_val, OptFlags_GdkModifier_val, Val_bool)
ML_1 (gtk_accelerator_set_default_mod_mask, OptFlags_GdkModifier_val, Unit)

/* gtkstyle.h */

#define GtkStyle_val(val) ((GtkStyle*)Pointer_val(val))
Make_Val_final_pointer (GtkStyle, , gtk_style_ref, gtk_style_unref)
Make_Val_final_pointer (GtkStyle, _no_ref, Ignore, gtk_style_unref)
ML_0 (gtk_style_new, Val_GtkStyle_no_ref)
ML_1 (gtk_style_copy, GtkStyle_val, Val_GtkStyle_no_ref)
ML_2 (gtk_style_attach, GtkStyle_val, GdkWindow_val, Val_GtkStyle)
ML_1 (gtk_style_detach, GtkStyle_val, Unit)
ML_3 (gtk_style_set_background, GtkStyle_val, GdkWindow_val, State_type_val, Unit)
ML_6 (gtk_draw_hline, GtkStyle_val, GdkWindow_val, State_type_val,
      Int_val, Int_val, Int_val, Unit)
ML_bc6 (ml_gtk_draw_hline)
ML_6 (gtk_draw_vline, GtkStyle_val, GdkWindow_val, State_type_val,
      Int_val, Int_val, Int_val, Unit)
ML_bc6 (ml_gtk_draw_vline)
Make_Array_Extractor (gtk_style_get, GtkStyle_val, State_type_val,  bg, Val_copy)
Make_Array_Setter (gtk_style_set, GtkStyle_val, State_type_val, *GdkColor_val, bg)
Make_Extractor (gtk_style_get, GtkStyle_val, colormap, Val_GdkColormap)
Make_Extractor (gtk_style_get, GtkStyle_val, depth, Val_int)
Make_Extractor (gtk_style_get, GtkStyle_val, font, Val_GdkFont)
Make_Setter (gtk_style_set, GtkStyle_val, GdkFont_val, font)

/* gtktypeutils.h */

ML_1 (gtk_type_name, Int_val, Val_string)
ML_1 (gtk_type_from_name, String_val, Val_int)
ML_1 (gtk_type_parent, Int_val, Val_int)
ML_1 (gtk_type_class, Int_val, (value))
ML_1 (gtk_type_parent_class, Int_val, (value))
ML_2 (gtk_type_is_a, Int_val, Int_val, Val_bool)
value ml_gtk_type_fundamental (value type)
{
    return Val_fundamental_type (GTK_FUNDAMENTAL_TYPE (Int_val(type)));
}

/* gtkobject.h */

/* ML_1 (GTK_OBJECT_TYPE, GtkObject_val, Val_int) */
value ml_gtk_object_type (value val)
{
    return Val_int (GtkObject_val(val)->klass->type);
}

ML_1 (gtk_object_destroy, GtkObject_val, Unit)
ML_1 (gtk_object_ref, GtkObject_val, Unit)
ML_1 (gtk_object_unref, GtkObject_val, Unit)
ML_1 (gtk_object_sink, GtkObject_val, Unit)

Make_Extractor (gtk_class,(GtkObjectClass *),type,Val_int)

/* gtkdata.h */

/* gtkadjustment.h */

#define GtkAdjustment_val(val) check_cast(GTK_ADJUSTMENT,val)
ML_6 (gtk_adjustment_new, Float_val, Float_val, Float_val, Float_val,
      Float_val, Float_val, Val_GtkObject_sink)
ML_bc6 (ml_gtk_adjustment_new)
ML_2 (gtk_adjustment_set_value, GtkAdjustment_val, Float_val, Unit)
ML_3 (gtk_adjustment_clamp_page, GtkAdjustment_val,
      Float_val, Float_val, Unit)
Make_Extractor (GtkAdjustment, GtkAdjustment_val, value, copy_double)

/* gtktooltips.h */

#define GtkWidget_val(val) check_cast(GTK_WIDGET,val)
#define GtkTooltips_val(val) check_cast(GTK_TOOLTIPS,val)
ML_0 (gtk_tooltips_new, Val_GtkAny)
ML_1 (gtk_tooltips_enable, GtkTooltips_val, Unit)
ML_1 (gtk_tooltips_disable, GtkTooltips_val, Unit)
ML_2 (gtk_tooltips_set_delay, GtkTooltips_val, Int_val, Unit)
ML_4 (gtk_tooltips_set_tip, GtkTooltips_val, GtkWidget_val,
      String_option_val, String_option_val, Unit)
ML_3 (gtk_tooltips_set_colors, GtkTooltips_val,
      Option_val(arg2, GdkColor_val, NULL) Ignore,
      Option_val(arg3, GdkColor_val, NULL) Ignore,
      Unit)

/* gtkwidget.h */

#define Val_GtkWidget Val_GtkAny
#define Val_GtkWidget_sink Val_GtkAny_sink

value ml_gtk_widget_set_can_default (value val, value bool)
{
    GtkWidget *w = GtkWidget_val(val);
    guint32 saved_flags = GTK_WIDGET_FLAGS(w);
    if (Bool_val(bool)) GTK_WIDGET_SET_FLAGS(w, GTK_CAN_DEFAULT);
    else GTK_WIDGET_UNSET_FLAGS(w, GTK_CAN_DEFAULT);
    if (saved_flags != GTK_WIDGET_FLAGS(w))
	gtk_widget_queue_resize (w);
    return Val_unit;
}
value ml_gtk_widget_set_can_focus (value val, value bool)
{
    GtkWidget *w = GtkWidget_val(val);
    guint32 saved_flags = GTK_WIDGET_FLAGS(w);
    if (Bool_val(bool)) GTK_WIDGET_SET_FLAGS(w, GTK_CAN_FOCUS);
    else GTK_WIDGET_UNSET_FLAGS(w, GTK_CAN_FOCUS);
    if (saved_flags != GTK_WIDGET_FLAGS(w))
	gtk_widget_queue_resize (w);
    return Val_unit;
}
ML_1 (gtk_widget_unparent, GtkWidget_val, Unit)
ML_1 (gtk_widget_show, GtkWidget_val, Unit)
ML_1 (gtk_widget_show_now, GtkWidget_val, Unit)
ML_1 (gtk_widget_show_all, GtkWidget_val, Unit)
ML_1 (gtk_widget_hide, GtkWidget_val, Unit)
ML_1 (gtk_widget_hide_all, GtkWidget_val, Unit)
ML_1 (gtk_widget_map, GtkWidget_val, Unit)
ML_1 (gtk_widget_unmap, GtkWidget_val, Unit)
ML_1 (gtk_widget_realize, GtkWidget_val, Unit)
ML_1 (gtk_widget_unrealize, GtkWidget_val, Unit)
ML_1 (gtk_widget_queue_draw, GtkWidget_val, Unit)
ML_1 (gtk_widget_queue_resize, GtkWidget_val, Unit)
ML_2 (gtk_widget_draw, GtkWidget_val, GdkRectangle_val, Unit)
ML_1 (gtk_widget_draw_focus, GtkWidget_val, Unit)
ML_1 (gtk_widget_draw_default, GtkWidget_val, Unit)
/* ML_1 (gtk_widget_draw_children, GtkWidget_val, Unit) */
ML_2 (gtk_widget_event, GtkWidget_val, GdkEvent_val( ), Val_bool)
ML_1 (gtk_widget_activate, GtkWidget_val, Val_bool)
ML_2 (gtk_widget_reparent, GtkWidget_val, GtkWidget_val, Unit)
ML_3 (gtk_widget_popup, GtkWidget_val, Int_val, Int_val, Unit)
value ml_gtk_widget_intersect (value w, value area)
{
    value ret = Val_unit;
    value inter = alloc (Wosizeof(GdkRectangle)+2, Abstract_tag);
    Field(inter,1) = (value) &Field(inter,2);
    if (gtk_widget_intersect (GtkWidget_val(w), GdkRectangle_val(area),
			      GdkRectangle_val(inter)))
    {
	Begin_root(inter);
	ret = alloc_tuple(1);
	Field(ret,0) = inter;
	End_roots ();
    }
    return ret;
}
/* ML_1 (gtk_widget_basic, GtkWidget_val, Val_bool) */
ML_1 (gtk_widget_grab_focus, GtkWidget_val, Unit)
ML_1 (gtk_widget_grab_default, GtkWidget_val, Unit)
ML_2 (gtk_widget_set_name, GtkWidget_val, String_val, Unit)
ML_1 (gtk_widget_get_name, GtkWidget_val, Val_string)
ML_2 (gtk_widget_set_state, GtkWidget_val, State_type_val, Unit)
ML_2 (gtk_widget_set_sensitive, GtkWidget_val, Bool_val, Unit)
ML_3 (gtk_widget_set_uposition, GtkWidget_val, Int_val, Int_val, Unit)
ML_3 (gtk_widget_set_usize, GtkWidget_val, Int_val, Int_val, Unit)
ML_2 (gtk_widget_add_events, GtkWidget_val, Flags_Event_mask_val, Unit)
ML_2 (gtk_widget_set_events, GtkWidget_val, Flags_Event_mask_val, Unit)
ML_2 (gtk_widget_set_extension_events, GtkWidget_val, Extension_events_val,
      Unit)
ML_1 (gtk_widget_get_toplevel, GtkWidget_val, Val_GtkWidget)
ML_2 (gtk_widget_get_ancestor, GtkWidget_val, Int_val, Val_GtkWidget)
ML_1 (gtk_widget_get_colormap, GtkWidget_val, Val_GdkColormap)
ML_1 (gtk_widget_get_visual, GtkWidget_val, (value))
value ml_gtk_widget_get_pointer (value w)
{
    int x,y;
    value ret = alloc_tuple (2);
    gtk_widget_get_pointer (GtkWidget_val(w), &x, &y);
    Field(ret,0) = Val_int(x);
    Field(ret,1) = Val_int(y);
    return ret;
}
ML_2 (gtk_widget_is_ancestor, GtkWidget_val, GtkWidget_val, Val_bool)
/* ML_2 (gtk_widget_is_child, GtkWidget_val, GtkWidget_val, Val_bool) */
ML_2 (gtk_widget_set_style, GtkWidget_val, GtkStyle_val, Unit)
ML_1 (gtk_widget_set_rc_style, GtkWidget_val, Unit)
ML_1 (gtk_widget_ensure_style, GtkWidget_val, Unit)
ML_1 (gtk_widget_get_style, GtkWidget_val, Val_GtkStyle)
ML_1 (gtk_widget_restore_default_style, GtkWidget_val, Unit)

ML_6 (gtk_widget_add_accelerator, GtkWidget_val, Signal_name_val,
      GtkAccelGroup_val, Char_val, OptFlags_GdkModifier_val,
      OptFlags_Accel_flag_val, Unit)
ML_bc6 (ml_gtk_widget_add_accelerator)
ML_4 (gtk_widget_remove_accelerator, GtkWidget_val, GtkAccelGroup_val,
      Char_val, OptFlags_GdkModifier_val, Unit)
ML_1 (gtk_widget_lock_accelerators, GtkWidget_val, Unit)
ML_1 (gtk_widget_unlock_accelerators, GtkWidget_val, Unit)
ML_1 (gtk_widget_accelerators_locked, GtkWidget_val, Val_bool)

Make_Extractor (GtkWidget, GtkWidget_val, window, Val_GdkWindow)
ml_gtk_widget_visible (value w)
{ 
  return Val_bool(GTK_WIDGET_VISIBLE(GtkWidget_val(w)));
}
Make_Extractor (gtk_widget, GtkWidget_val, parent, Val_GtkWidget)

/* gtkcontainer.h */

#define GtkContainer_val(val) check_cast(GTK_CONTAINER,val)
ML_2 (gtk_container_set_border_width, GtkContainer_val, Int_val, Unit)
ML_2 (gtk_container_add, GtkContainer_val, GtkWidget_val, Unit)
ML_2 (gtk_container_remove, GtkContainer_val, GtkWidget_val, Unit)
static void ml_gtk_simple_callback (GtkWidget *w, gpointer data)
{
    value val, clos = (value)data;
    Begin_root(clos);
    val = Val_GtkWidget(w);
    callback (clos, val);
    End_roots();
}
value ml_gtk_container_foreach (value w, value clos)
{
    Begin_roots2 (w, clos);
    gtk_container_foreach (GtkContainer_val(w), ml_gtk_simple_callback,
			   (gpointer)clos);
    End_roots ();
    return Val_unit;
}
ML_1 (gtk_container_register_toplevel, GtkContainer_val, Unit)
ML_1 (gtk_container_unregister_toplevel, GtkContainer_val, Unit)
ML_2 (gtk_container_focus, GtkContainer_val, Direction_type_val, Val_bool)
ML_2 (gtk_container_set_focus_child, GtkContainer_val, GtkWidget_val, Unit)
ML_2 (gtk_container_set_focus_vadjustment, GtkContainer_val,
      GtkAdjustment_val, Unit)
ML_2 (gtk_container_set_focus_hadjustment, GtkContainer_val,
      GtkAdjustment_val, Unit)

/* gtkbin.h */

/* gtkalignment.h */

#define GtkAlignment_val(val) check_cast(GTK_ALIGNMENT,val)
ML_4 (gtk_alignment_new, Float_val, Float_val, Float_val, Float_val,
      Val_GtkWidget_sink)
value ml_gtk_alignment_set (value val, value x, value y,
			   value xscale, value yscale)
{
    GtkAlignment *alignment = GtkAlignment_val(val);
    gtk_alignment_set (alignment,
		       Option_val(x, Float_val, alignment->xalign),
		       Option_val(y, Float_val, alignment->yalign),
		       Option_val(xscale, Float_val, alignment->xscale),
		       Option_val(yscale, Float_val, alignment->xscale));
    return Val_unit;
}

/* gtkeventbox.h */

ML_0 (gtk_event_box_new, Val_GtkWidget_sink)

/* gtkframe.h */

#define GtkFrame_val(val) check_cast(GTK_FRAME,val)
ML_1 (gtk_frame_new, String_val, Val_GtkWidget_sink)
ML_2 (gtk_frame_set_label, GtkFrame_val, String_val, Unit)
ML_3 (gtk_frame_set_label_align, GtkFrame_val, Float_val, Float_val, Unit)
ML_2 (gtk_frame_set_shadow_type, GtkFrame_val, Shadow_type_val, Unit)
Make_Extractor (gtk_frame_get, GtkFrame_val, label_xalign, copy_double)
Make_Extractor (gtk_frame_get, GtkFrame_val, label_yalign, copy_double)

/* gtkaspectframe.h */

#define GtkAspectFrame_val(val) check_cast(GTK_ASPECT_FRAME,val)
ML_5 (gtk_aspect_frame_new, String_val,
      Float_val, Float_val, Float_val, Bool_val, Val_GtkWidget_sink)
ML_5 (gtk_aspect_frame_set, GtkAspectFrame_val, Float_val, Float_val,
      Float_val, Bool_val, Unit)
Make_Extractor (gtk_aspect_frame_get, GtkAspectFrame_val, xalign, copy_double)
Make_Extractor (gtk_aspect_frame_get, GtkAspectFrame_val, yalign, copy_double)
Make_Extractor (gtk_aspect_frame_get, GtkAspectFrame_val, ratio, copy_double)
Make_Extractor (gtk_aspect_frame_get, GtkAspectFrame_val, obey_child, Val_bool)

/* gtkhandlebox.h */

#define GtkHandleBox_val(val) check_cast(GTK_HANDLE_BOX,val)
ML_0 (gtk_handle_box_new, Val_GtkWidget_sink)
ML_2 (gtk_handle_box_set_shadow_type, GtkHandleBox_val, Shadow_type_val, Unit)
ML_2 (gtk_handle_box_set_handle_position, GtkHandleBox_val, Position_val, Unit)
ML_2 (gtk_handle_box_set_snap_edge, GtkHandleBox_val, Position_val, Unit)

/* gtkitem.h */

#define GtkItem_val(val) check_cast(GTK_ITEM,val)
ML_1 (gtk_item_select, GtkItem_val, Unit)
ML_1 (gtk_item_deselect, GtkItem_val, Unit)
ML_1 (gtk_item_toggle, GtkItem_val, Unit)

/* gtklistitem.h */

ML_0 (gtk_list_item_new, Val_GtkWidget_sink)
ML_1 (gtk_list_item_new_with_label, String_val, Val_GtkWidget_sink)

/* gtkmenuitem.h */

#define GtkMenuItem_val(val) check_cast(GTK_MENU_ITEM,val)
ML_0 (gtk_menu_item_new, Val_GtkWidget_sink)
ML_0 (gtk_tearoff_menu_item_new, Val_GtkWidget_sink)
ML_1 (gtk_menu_item_new_with_label, String_val, Val_GtkWidget_sink)
ML_2 (gtk_menu_item_set_submenu, GtkMenuItem_val, GtkWidget_val, Unit)
ML_1 (gtk_menu_item_remove_submenu, GtkMenuItem_val, Unit)
ML_2 (gtk_menu_item_set_placement, GtkMenuItem_val,
      Submenu_placement_val, Unit)
ML_3 (gtk_menu_item_configure, GtkMenuItem_val, Bool_val, Bool_val, Unit)
ML_1 (gtk_menu_item_activate, GtkMenuItem_val, Unit)
ML_1 (gtk_menu_item_right_justify, GtkMenuItem_val, Unit)

/* gtkcheckmenuitem.h */

#define GtkCheckMenuItem_val(val) check_cast(GTK_CHECK_MENU_ITEM,val)
ML_0 (gtk_check_menu_item_new, Val_GtkWidget_sink)
ML_1 (gtk_check_menu_item_new_with_label, String_val, Val_GtkWidget_sink)
ML_2 (gtk_check_menu_item_set_active, GtkCheckMenuItem_val, Bool_val, Unit)
ML_2 (gtk_check_menu_item_set_show_toggle, GtkCheckMenuItem_val,
      Bool_val, Unit)
ML_1 (gtk_check_menu_item_toggled, GtkCheckMenuItem_val, Unit)
Make_Extractor (gtk_check_menu_item_get, GtkCheckMenuItem_val,
		active, Val_bool)

/* gtkradiomenuitem.h */

#define Group_val(val) ((GSList*)Addr_val(val))
#define Val_group Val_addr

#define GtkRadioMenuItem_val(val) check_cast(GTK_RADIO_MENU_ITEM,val)
ML_1 (gtk_radio_menu_item_new, Group_val, Val_GtkWidget_sink)
ML_2 (gtk_radio_menu_item_new_with_label, Group_val,
      String_val, Val_GtkWidget_sink)
ML_1 (gtk_radio_menu_item_group, GtkRadioMenuItem_val, Val_group)
ML_2 (gtk_radio_menu_item_set_group, GtkRadioMenuItem_val, Group_val, Unit)

/* gtktreeitem.h */

#define GtkTreeItem_val(val) check_cast(GTK_TREE_ITEM,val)
ML_0 (gtk_tree_item_new, Val_GtkWidget_sink)
ML_1 (gtk_tree_item_new_with_label, String_val, Val_GtkWidget_sink)
ML_2 (gtk_tree_item_set_subtree, GtkTreeItem_val, GtkWidget_val, Unit)
ML_1 (gtk_tree_item_remove_subtree, GtkTreeItem_val, Unit)
ML_1 (gtk_tree_item_expand, GtkTreeItem_val, Unit)
ML_1 (gtk_tree_item_collapse, GtkTreeItem_val, Unit)
ML_1 (GTK_TREE_ITEM_SUBTREE, GtkTreeItem_val, Val_GtkWidget)

/* gtkviewport.h */

#define GtkViewport_val(val) check_cast(GTK_VIEWPORT,val)
ML_2 (gtk_viewport_new, GtkAdjustment_val, GtkAdjustment_val,
      Val_GtkWidget_sink)
ML_1 (gtk_viewport_get_hadjustment, GtkViewport_val, Val_GtkWidget_sink)
ML_1 (gtk_viewport_get_vadjustment, GtkViewport_val, Val_GtkWidget)
ML_2 (gtk_viewport_set_hadjustment, GtkViewport_val, GtkAdjustment_val, Unit)
ML_2 (gtk_viewport_set_vadjustment, GtkViewport_val, GtkAdjustment_val, Unit)
ML_2 (gtk_viewport_set_shadow_type, GtkViewport_val, Shadow_type_val, Unit)

/* gtkdialog.h */

static void window_unref (GtkObject *w)
{
    /* If the window is still not visible, then unreference it.
       This should be enough to destroy it. */
    if (!GTK_WIDGET_VISIBLE(GTK_WIDGET(w))) gtk_object_unref (w);
    gtk_object_unref (w);
}
Make_Val_final_pointer (GtkObject, _window, gtk_object_ref, window_unref)
#define Val_GtkWidget_window(w) Val_GtkObject_window((GtkObject*)w)

#define GtkDialog_val(val) check_cast(GTK_DIALOG,val)
ML_0 (gtk_dialog_new, Val_GtkWidget_window)
Make_Extractor (GtkDialog, GtkDialog_val, action_area, Val_GtkWidget)
Make_Extractor (GtkDialog, GtkDialog_val, vbox, Val_GtkWidget)

/* gtkinputdialog.h */

ML_0 (gtk_input_dialog_new, Val_GtkWidget_window)

/* gtkfileselection.h */

#define GtkFileSelection_val(val) check_cast(GTK_FILE_SELECTION,val)
ML_1 (gtk_file_selection_new, String_val, Val_GtkWidget_window)
ML_2 (gtk_file_selection_set_filename, GtkFileSelection_val, String_val, Unit)
ML_1 (gtk_file_selection_get_filename, GtkFileSelection_val, Val_string)
ML_1 (gtk_file_selection_show_fileop_buttons, GtkFileSelection_val, Unit)
ML_1 (gtk_file_selection_hide_fileop_buttons, GtkFileSelection_val, Unit)
Make_Extractor (gtk_file_selection_get, GtkFileSelection_val, ok_button,
		Val_GtkWidget)
Make_Extractor (gtk_file_selection_get, GtkFileSelection_val, cancel_button,
		Val_GtkWidget)
Make_Extractor (gtk_file_selection_get, GtkFileSelection_val, help_button,
		Val_GtkWidget)

/* gtkwindow.h */

#define GtkWindow_val(val) check_cast(GTK_WINDOW,val)
ML_1 (gtk_window_new, Window_type_val, Val_GtkWidget_window)
ML_2 (gtk_window_set_title, GtkWindow_val, String_val, Unit)
ML_3 (gtk_window_set_wmclass, GtkWindow_val, String_val, String_val, Unit)
Make_Extractor (gtk_window_get, GtkWindow_val, wmclass_name, Val_string)
Make_Extractor (gtk_window_get, GtkWindow_val, wmclass_class, Val_string)
ML_2 (gtk_window_set_focus, GtkWindow_val, GtkWidget_val, Unit)
ML_2 (gtk_window_set_default, GtkWindow_val, GtkWidget_val, Unit)
ML_4 (gtk_window_set_policy, GtkWindow_val, Bool_val, Bool_val, Bool_val, Unit)
Make_Extractor (gtk_window_get, GtkWindow_val, allow_shrink, Val_bool)
Make_Extractor (gtk_window_get, GtkWindow_val, allow_grow, Val_bool)
Make_Extractor (gtk_window_get, GtkWindow_val, auto_shrink, Val_bool)
ML_2 (gtk_window_add_accel_group, GtkWindow_val,
      GtkAccelGroup_val, Unit)
ML_2 (gtk_window_remove_accel_group, GtkWindow_val,
      GtkAccelGroup_val, Unit)
ML_1 (gtk_window_activate_focus, GtkWindow_val, Val_bool)
ML_1 (gtk_window_activate_default, GtkWindow_val, Val_bool)
ML_2 (gtk_window_set_modal, GtkWindow_val, Bool_val, Unit)
ML_3 (gtk_window_set_default_size, GtkWindow_val, Int_val, Int_val, Unit)
ML_2 (gtk_window_set_position, GtkWindow_val, Window_position_val, Unit)
ML_2 (gtk_window_set_transient_for, GtkWindow_val, GtkWindow_val, Unit)

/* gtkcolorsel.h */

#define GtkColorSelection_val(val) check_cast(GTK_COLOR_SELECTION,val)
#define GtkColorSelectionDialog_val(val) check_cast(GTK_COLOR_SELECTION_DIALOG,val)
ML_0 (gtk_color_selection_new, Val_GtkWidget_sink)
ML_2 (gtk_color_selection_set_update_policy, GtkColorSelection_val,
      Update_type_val, Unit)
ML_2 (gtk_color_selection_set_opacity, GtkColorSelection_val,
      Bool_val, Unit)
enum
{
  COLOR_HUE,
  COLOR_SATURATION,
  COLOR_VALUE,
  COLOR_RED,
  COLOR_GREEN,
  COLOR_BLUE,
  COLOR_OPACITY,
  COLOR_NUM_CHANNELS
};
value ml_gtk_color_selection_set_color (value w, value red, value green,
					value blue, value opacity)
{
    double color[COLOR_NUM_CHANNELS];
    color[COLOR_RED] = Double_val(red);
    color[COLOR_GREEN] = Double_val(green);
    color[COLOR_BLUE] = Double_val(blue);
    color[COLOR_OPACITY] = Option_val(opacity,Double_val,0.0);
    gtk_color_selection_set_color (GtkColorSelection_val(w), color);
    return Val_unit;
}
value ml_gtk_color_selection_get_color (value w)
{
    value ret;
    double color[COLOR_NUM_CHANNELS];
    color[COLOR_OPACITY] = 0.0;
    gtk_color_selection_get_color (GtkColorSelection_val(w), color);
    ret = alloc (4*Double_wosize, Double_array_tag);
    Store_double_field (ret, 0, color[COLOR_RED]);
    Store_double_field (ret, 1, color[COLOR_GREEN]);
    Store_double_field (ret, 2, color[COLOR_BLUE]);
    Store_double_field (ret, 3, color[COLOR_OPACITY]);
    return ret;
}
ML_1 (gtk_color_selection_dialog_new, String_val, Val_GtkWidget_window)
Make_Extractor (gtk_color_selection_dialog, GtkColorSelectionDialog_val, ok_button, Val_GtkWidget)
Make_Extractor (gtk_color_selection_dialog, GtkColorSelectionDialog_val, cancel_button, Val_GtkWidget)
Make_Extractor (gtk_color_selection_dialog, GtkColorSelectionDialog_val, help_button, Val_GtkWidget)
Make_Extractor (gtk_color_selection_dialog, GtkColorSelectionDialog_val, colorsel, Val_GtkWidget)


/* gtkbox.h */

#define GtkBox_val(val) check_cast(GTK_BOX,val)
ML_5 (gtk_box_pack_start, GtkBox_val, GtkWidget_val, Bool_val, Bool_val,
      Int_val, Unit)
ML_5 (gtk_box_pack_end, GtkBox_val, GtkWidget_val, Bool_val, Bool_val,
      Int_val, Unit)
ML_2 (gtk_box_set_homogeneous, GtkBox_val, Bool_val, Unit)
ML_2 (gtk_box_set_spacing, GtkBox_val, Int_val, Unit)
ML_3 (gtk_box_reorder_child, GtkBox_val, GtkWidget_val, Int_val, Unit)
value ml_gtk_box_query_child_packing (value box, value child)
{
    int expand, fill;
    unsigned int padding;
    GtkPackType pack_type;
    value ret;
    gtk_box_query_child_packing (GtkBox_val(box), GtkWidget_val(child),
				 &expand, &fill, &padding, &pack_type);
    ret = alloc_tuple(4);
    Field(ret,0) = Val_bool(expand);
    Field(ret,1) = Val_bool(fill);
    Field(ret,2) = Val_int(padding);
    Field(ret,3) = Val_pack_type(pack_type);
    return ret;
}
value ml_gtk_box_set_child_packing (value vbox, value vchild, value vexpand,
				    value vfill, value vpadding, value vpack)
{
    GtkBox *box = GtkBox_val(vbox);
    GtkWidget *child = GtkWidget_val(vchild);
    int expand, fill;
    unsigned int padding;
    GtkPackType pack;
    gtk_box_query_child_packing (box, child, &expand, &fill, &padding, &pack);
    gtk_box_set_child_packing (box, child,
			       Option_val(vexpand, Bool_val, expand),
			       Option_val(vfill, Bool_val, fill),
			       Option_val(vpadding, Int_val, padding),
			       Option_val(vpack, Pack_type_val, pack));
    return Val_unit;
}
ML_bc6 (ml_gtk_box_set_child_packing)

ML_2 (gtk_hbox_new, Bool_val, Int_val, Val_GtkWidget_sink)
ML_2 (gtk_vbox_new, Bool_val, Int_val, Val_GtkWidget_sink)

/* gtkbbox.h */
    
#define GtkButtonBox_val(val) check_cast(GTK_BUTTON_BOX,val)
Make_Extractor (gtk_button_box_get, GtkButtonBox_val, spacing, Val_int)
Make_Extractor (gtk_button_box_get, GtkButtonBox_val, child_min_width, Val_int)
Make_Extractor (gtk_button_box_get, GtkButtonBox_val, child_min_height,
		Val_int)
Make_Extractor (gtk_button_box_get, GtkButtonBox_val, child_ipad_x, Val_int)
Make_Extractor (gtk_button_box_get, GtkButtonBox_val, child_ipad_y, Val_int)
Make_Extractor (gtk_button_box_get, GtkButtonBox_val, layout_style,
		Val_button_box_style)
ML_2 (gtk_button_box_set_spacing, GtkButtonBox_val, Int_val, Unit)
ML_3 (gtk_button_box_set_child_size, GtkButtonBox_val,
      Int_val, Int_val, Unit)
ML_3 (gtk_button_box_set_child_ipadding, GtkButtonBox_val,
      Int_val, Int_val, Unit)
ML_2 (gtk_button_box_set_layout, GtkButtonBox_val, Button_box_style_val, Unit)
ML_2 (gtk_button_box_set_child_size_default, Int_val, Int_val, Unit)
ML_2 (gtk_button_box_set_child_ipadding_default, Int_val, Int_val, Unit)

ML_0 (gtk_hbutton_box_new, Val_GtkWidget_sink)
ML_0 (gtk_vbutton_box_new, Val_GtkWidget_sink)

/* gtklist.h */

#define GtkList_val(val) check_cast(GTK_LIST,val)
ML_0 (gtk_list_new, Val_GtkWidget_sink)
value ml_gtk_list_insert_item (value list, value item, value pos)
{
    GList *tmp_list = g_list_alloc ();
    tmp_list->data = GtkWidget_val(item);
    tmp_list->next = NULL;
    tmp_list->prev = NULL;
    gtk_list_insert_items (GtkList_val(list), tmp_list, Int_val(pos));
    return Val_unit;
}
ML_3 (gtk_list_clear_items, GtkList_val, Int_val, Int_val, Unit)
ML_2 (gtk_list_select_item, GtkList_val, Int_val, Unit)
ML_2 (gtk_list_unselect_item, GtkList_val, Int_val, Unit)
ML_2 (gtk_list_select_child, GtkList_val, GtkWidget_val, Unit)
ML_2 (gtk_list_unselect_child, GtkList_val, GtkWidget_val, Unit)
ML_2 (gtk_list_child_position, GtkList_val, GtkWidget_val, Val_int)
ML_2 (gtk_list_set_selection_mode, GtkList_val, Selection_mode_val, Unit)

/* gtkcombo.h */

#define GtkCombo_val(val) check_cast(GTK_COMBO,val)
ML_0 (gtk_combo_new, Val_GtkWidget_sink)
ML_3 (gtk_combo_set_value_in_list, GtkCombo_val,
      Option_val(arg2, Bool_val, GtkCombo_val(arg1)->value_in_list) Ignore,
      Option_val(arg3, Bool_val, GtkCombo_val(arg1)->ok_if_empty) Ignore,
      Unit)
ML_2 (gtk_combo_set_use_arrows, GtkCombo_val, Bool_val, Unit)
ML_2 (gtk_combo_set_use_arrows_always, GtkCombo_val, Bool_val, Unit)
ML_2 (gtk_combo_set_case_sensitive, GtkCombo_val, Bool_val, Unit)
ML_3 (gtk_combo_set_item_string, GtkCombo_val, GtkItem_val, String_val, Unit)
ML_1 (gtk_combo_disable_activate, GtkCombo_val, Unit)
Make_Extractor (gtk_combo, GtkCombo_val, entry, Val_GtkWidget)
Make_Extractor (gtk_combo, GtkCombo_val, list, Val_GtkWidget)

/* gtkstatusbar.h */

#define GtkStatusbar_val(val) check_cast(GTK_STATUSBAR,val)
ML_0 (gtk_statusbar_new, Val_GtkWidget_sink)
ML_2 (gtk_statusbar_get_context_id, GtkStatusbar_val, String_val, Val_int)
ML_3 (gtk_statusbar_push, GtkStatusbar_val, Int_val, String_val, Val_int)
ML_2 (gtk_statusbar_pop, GtkStatusbar_val, Int_val, Unit)
ML_3 (gtk_statusbar_remove, GtkStatusbar_val, Int_val, Int_val, Unit)

/* gtkgamma.h */

#define GtkGammaCurve_val(val) check_cast(GTK_GAMMA_CURVE,val)
ML_0 (gtk_gamma_curve_new, Val_GtkWidget_sink)
Make_Extractor (gtk_gamma_curve_get, GtkGammaCurve_val, gamma, copy_double)

/* gtkbutton.h */

#define GtkButton_val(val) check_cast(GTK_BUTTON,val)
ML_0 (gtk_button_new, Val_GtkWidget_sink)
ML_1 (gtk_button_new_with_label, String_val, Val_GtkWidget_sink)
ML_1 (gtk_button_pressed, GtkButton_val, Unit)
ML_1 (gtk_button_released, GtkButton_val, Unit)
ML_1 (gtk_button_clicked, GtkButton_val, Unit)
ML_1 (gtk_button_enter, GtkButton_val, Unit)
ML_1 (gtk_button_leave, GtkButton_val, Unit)

/* gtkoptionmenu.h */

#define GtkOptionMenu_val(val) check_cast(GTK_OPTION_MENU,val)
ML_0 (gtk_option_menu_new, Val_GtkWidget_sink)
ML_1 (gtk_option_menu_get_menu, GtkOptionMenu_val, Val_GtkWidget_sink)
ML_2 (gtk_option_menu_set_menu, GtkOptionMenu_val, GtkWidget_val, Unit)
ML_1 (gtk_option_menu_remove_menu, GtkOptionMenu_val, Unit)
ML_2 (gtk_option_menu_set_history, GtkOptionMenu_val, Int_val, Unit)

/* gtktogglebutton.h */

#define GtkToggleButton_val(val) check_cast(GTK_TOGGLE_BUTTON,val)
ML_0 (gtk_toggle_button_new, Val_GtkWidget_sink)
ML_1 (gtk_toggle_button_new_with_label, String_val, Val_GtkWidget_sink)
ML_2 (gtk_toggle_button_set_mode, GtkToggleButton_val, Bool_val, Unit)
ML_2 (gtk_toggle_button_set_active, GtkToggleButton_val, Bool_val, Unit)
ML_1 (gtk_toggle_button_toggled, GtkToggleButton_val, Unit)
Make_Extractor (gtk_toggle_button_get, GtkToggleButton_val, active, Val_bool)

/* gtkcheckbutton.h */

#define GtkCheckButton_val(val) check_cast(GTK_CHECK_BUTTON,val)
ML_0 (gtk_check_button_new, Val_GtkWidget_sink)
ML_1 (gtk_check_button_new_with_label, String_val, Val_GtkWidget_sink)

/* gtkradiobutton.h */

#define GtkRadioButton_val(val) check_cast(GTK_RADIO_BUTTON,val)
ML_1 (gtk_radio_button_new, Group_val, Val_GtkWidget_sink)
ML_2 (gtk_radio_button_new_with_label, Group_val, String_val,
      Val_GtkWidget_sink)
ML_1 (gtk_radio_button_group, GtkRadioButton_val, Val_group)
ML_2 (gtk_radio_button_set_group, GtkRadioButton_val, Group_val, Unit)

/* gtkclist.h */

#define GtkCList_val(val) check_cast(GTK_CLIST,val)
ML_1 (gtk_clist_new, Int_val, Val_GtkWidget_sink)
ML_1 (gtk_clist_new_with_titles, Insert(Wosize_val(arg1)) (char **),
      Val_GtkWidget_sink)
Make_Extractor (gtk_clist_get, GtkCList_val, rows, Val_int)
Make_Extractor (gtk_clist_get, GtkCList_val, columns, Val_int)
ML_2 (gtk_clist_set_hadjustment, GtkCList_val, GtkAdjustment_val, Unit)
ML_2 (gtk_clist_set_vadjustment, GtkCList_val, GtkAdjustment_val, Unit)
ML_1 (gtk_clist_get_hadjustment, GtkCList_val, Val_GtkAny)
ML_1 (gtk_clist_get_vadjustment, GtkCList_val, Val_GtkAny)
ML_2 (gtk_clist_set_shadow_type, GtkCList_val, Shadow_type_val, Unit)
ML_2 (gtk_clist_set_selection_mode, GtkCList_val, Selection_mode_val, Unit)
ML_2 (gtk_clist_set_reorderable, GtkCList_val, Bool_val, Unit)
ML_2 (gtk_clist_set_use_drag_icons, GtkCList_val, Bool_val, Unit)
ML_3 (gtk_clist_set_button_actions, GtkCList_val, Int_val,
      Flags_Button_action_val, Unit)
ML_1 (gtk_clist_freeze, GtkCList_val, Unit)
ML_1 (gtk_clist_thaw, GtkCList_val, Unit)
ML_1 (gtk_clist_column_titles_show, GtkCList_val, Unit)
ML_1 (gtk_clist_column_titles_hide, GtkCList_val, Unit)
ML_2 (gtk_clist_column_title_active, GtkCList_val, Int_val, Unit)
ML_2 (gtk_clist_column_title_passive, GtkCList_val, Int_val, Unit)
ML_1 (gtk_clist_column_titles_active, GtkCList_val, Unit)
ML_1 (gtk_clist_column_titles_passive, GtkCList_val, Unit)
ML_3 (gtk_clist_set_column_title, GtkCList_val, Int_val, String_val, Unit)
ML_2 (gtk_clist_get_column_title, GtkCList_val, Int_val, Val_string)
ML_3 (gtk_clist_set_column_widget, GtkCList_val, Int_val, GtkWidget_val, Unit)
ML_2 (gtk_clist_get_column_widget, GtkCList_val, Int_val, Val_GtkWidget)
ML_3 (gtk_clist_set_column_justification, GtkCList_val, Int_val,
      Justification_val, Unit)
ML_3 (gtk_clist_set_column_visibility, GtkCList_val, Int_val, Bool_val, Unit)
ML_3 (gtk_clist_set_column_resizeable, GtkCList_val, Int_val, Bool_val, Unit)
ML_3 (gtk_clist_set_column_auto_resize, GtkCList_val, Int_val, Bool_val, Unit)
ML_1 (gtk_clist_columns_autosize, GtkCList_val, Unit)
ML_2 (gtk_clist_optimal_column_width, GtkCList_val, Int_val, Val_int)
ML_3 (gtk_clist_set_column_width, GtkCList_val, Int_val, Int_val, Unit)
ML_3 (gtk_clist_set_column_min_width, GtkCList_val, Int_val, Int_val, Unit)
ML_3 (gtk_clist_set_column_max_width, GtkCList_val, Int_val, Int_val, Unit)
ML_2 (gtk_clist_set_row_height, GtkCList_val, Int_val, Unit)
ML_5 (gtk_clist_moveto, GtkCList_val, Int_val, Int_val,
      Double_val, Double_val, Unit)
ML_2 (gtk_clist_row_is_visible, GtkCList_val, Int_val, Val_visibility)
ML_3 (gtk_clist_get_cell_type, GtkCList_val, Int_val, Int_val, Val_cell_type)
ML_4 (gtk_clist_set_text, GtkCList_val, Int_val, Int_val, String_val, Unit)
value ml_gtk_clist_get_text (value clist, value row, value column)
{
    char *text;
    if (!gtk_clist_get_text (GtkCList_val(clist), Int_val(row),
			     Int_val(column), &text))
	invalid_argument ("Gtk.Clist.get_text");
    return Val_string(text);
}
ML_5 (gtk_clist_set_pixmap, GtkCList_val, Int_val, Int_val, GdkPixmap_val,
      GdkBitmap_val, Unit)
value ml_gtk_clist_get_pixmap (value clist, value row, value column)
{
    GdkPixmap *pixmap;
    GdkBitmap *bitmap;
    value ret = Val_unit, vpixmap = Val_unit, vbitmap = Val_unit;
    if (!gtk_clist_get_pixmap (GtkCList_val(clist), Int_val(row),
			       Int_val(column), &pixmap, &bitmap))
	invalid_argument ("Gtk.Clist.get_pixmap");
    Begin_roots3 (ret,vpixmap,vbitmap);
    vpixmap = Val_GdkPixmap(pixmap);
    if (bitmap) {
	vbitmap = alloc (1,0);
	ret = Val_GdkBitmap(bitmap);
	Field(vbitmap,0) = ret;
    }
    ret = alloc_tuple (2);
    Field(ret,0) = vpixmap;
    Field(ret,1) = vbitmap;
    End_roots ();
    return ret;
}
ML_7 (gtk_clist_set_pixtext, GtkCList_val, Int_val, Int_val, String_val,
      Int_val, GdkPixmap_val, GdkBitmap_val, Unit)
ML_bc7 (ml_gtk_clist_set_pixtext)
ML_3 (gtk_clist_set_foreground, GtkCList_val, Int_val, GdkColor_val, Unit)
ML_3 (gtk_clist_set_background, GtkCList_val, Int_val, GdkColor_val, Unit)
ML_3 (gtk_clist_set_selectable, GtkCList_val, Int_val, Bool_val, Unit)
ML_2 (gtk_clist_get_selectable, GtkCList_val, Int_val, Val_bool)
ML_5 (gtk_clist_set_shift, GtkCList_val, Int_val, Int_val, Int_val, Int_val,
      Unit)
ML_2 (gtk_clist_append, GtkCList_val, (char **), Val_int)
ML_3 (gtk_clist_insert, GtkCList_val, Int_val, (char **), Unit)
ML_2 (gtk_clist_remove, GtkCList_val, Int_val, Unit)
ML_3 (gtk_clist_select_row, GtkCList_val, Int_val, Int_val, Unit)
ML_3 (gtk_clist_unselect_row, GtkCList_val, Int_val, Int_val, Unit)
ML_1 (gtk_clist_clear, GtkCList_val, Unit)
value ml_gtk_clist_get_selection_info (value clist, value x, value y)
{
    int row, column;
    value ret;
    if (!gtk_clist_get_selection_info (GtkCList_val(clist), Int_val(x),
			     Int_val(y), &row, &column))
	invalid_argument ("Gtk.Clist.get_selection_info");
    ret = alloc_tuple (2);
    Field(ret,0) = row;
    Field(ret,1) = column;
    return ret;
}
ML_1 (gtk_clist_select_all, GtkCList_val, Unit)
ML_1 (gtk_clist_unselect_all, GtkCList_val, Unit)
ML_3 (gtk_clist_swap_rows, GtkCList_val, Int_val, Int_val, Unit)
ML_3 (gtk_clist_row_move, GtkCList_val, Int_val, Int_val, Unit)
ML_2 (gtk_clist_set_sort_column, GtkCList_val, Int_val, Unit)
ML_2 (gtk_clist_set_sort_type, GtkCList_val, Sort_type_val, Unit)
ML_1 (gtk_clist_sort, GtkCList_val, Unit)
ML_2 (gtk_clist_set_auto_sort, GtkCList_val, Bool_val, Unit)

/* gtkfixed.h */

#define GtkFixed_val(val) check_cast(GTK_FIXED,val)
ML_0 (gtk_fixed_new, Val_GtkWidget_sink)
ML_4 (gtk_fixed_put, GtkFixed_val, GtkWidget_val, Int_val, Int_val, Unit)
ML_4 (gtk_fixed_move, GtkFixed_val, GtkWidget_val, Int_val, Int_val, Unit)

/* gtklayout.h */

#define GtkLayout_val(val) check_cast(GTK_LAYOUT,val)
ML_2 (gtk_layout_new, GtkAdjustment_val, GtkAdjustment_val, Val_GtkWidget_sink)
ML_4 (gtk_layout_put, GtkLayout_val, GtkWidget_val, Int_val, Int_val, Unit)
ML_4 (gtk_layout_move, GtkLayout_val, GtkWidget_val, Int_val, Int_val, Unit)
ML_3 (gtk_layout_set_size, GtkLayout_val, Int_val, Int_val, Unit)
ML_1 (gtk_layout_get_hadjustment, GtkLayout_val, Val_GtkAny)
ML_1 (gtk_layout_get_vadjustment, GtkLayout_val, Val_GtkAny)
ML_2 (gtk_layout_set_hadjustment, GtkLayout_val, GtkAdjustment_val, Unit)
ML_2 (gtk_layout_set_vadjustment, GtkLayout_val, GtkAdjustment_val, Unit)
ML_1 (gtk_layout_freeze, GtkLayout_val, Unit)
ML_1 (gtk_layout_thaw, GtkLayout_val, Unit)
Make_Extractor (gtk_layout_get, GtkLayout_val, width, Val_int)
Make_Extractor (gtk_layout_get, GtkLayout_val, height, Val_int)

/* gtkmenushell.h */

#define GtkMenuShell_val(val) check_cast(GTK_MENU_SHELL,val)
ML_2 (gtk_menu_shell_append, GtkMenuShell_val, GtkWidget_val, Unit)
ML_2 (gtk_menu_shell_prepend, GtkMenuShell_val, GtkWidget_val, Unit)
ML_3 (gtk_menu_shell_insert, GtkMenuShell_val, GtkWidget_val, Int_val, Unit)
ML_1 (gtk_menu_shell_deactivate, GtkMenuShell_val, Unit)

/* gtkmenu.h */

#define GtkMenu_val(val) check_cast(GTK_MENU,val)
ML_0 (gtk_menu_new, Val_GtkWidget_sink)
ML_5 (gtk_menu_popup, GtkMenu_val, GtkWidget_val, GtkWidget_val,
      Insert(NULL) Insert(NULL) Int_val, Int_val, Unit)
ML_1 (gtk_menu_popdown, GtkMenu_val, Unit)
ML_1 (gtk_menu_get_active, GtkMenu_val, Val_GtkWidget)
ML_2 (gtk_menu_set_active, GtkMenu_val, Int_val, Unit)
ML_2 (gtk_menu_set_accel_group, GtkMenu_val, GtkAccelGroup_val, Unit)
ML_1 (gtk_menu_get_accel_group, GtkMenu_val, Val_GtkAccelGroup)
value ml_gtk_menu_attach_to_widget (value menu, value widget)
{
    gtk_menu_attach_to_widget (GtkMenu_val(menu), GtkWidget_val(widget), NULL);
    return Val_unit;
}
ML_1 (gtk_menu_get_attach_widget, GtkMenu_val, Val_GtkWidget)
ML_1 (gtk_menu_detach, GtkMenu_val, Unit)

/* gtkmenubar.h */

#define GtkMenuBar_val(val) check_cast(GTK_MENU_BAR,val)
ML_0 (gtk_menu_bar_new, Val_GtkWidget_sink)

/* gtknotebook.h */

#define GtkNotebook_val(val) check_cast(GTK_NOTEBOOK,val)
ML_0 (gtk_notebook_new, Val_GtkWidget_sink)

ML_5 (gtk_notebook_insert_page_menu, GtkNotebook_val, GtkWidget_val,
      GtkWidget_val, GtkWidget_val, Int_val, Unit)
ML_2 (gtk_notebook_remove_page, GtkNotebook_val, Int_val, Unit)

ML_2 (gtk_notebook_set_tab_pos, GtkNotebook_val, Position_val, Unit)
ML_2 (gtk_notebook_set_homogeneous_tabs, GtkNotebook_val, Bool_val, Unit)
ML_2 (gtk_notebook_set_show_tabs, GtkNotebook_val, Bool_val, Unit)
ML_2 (gtk_notebook_set_show_border, GtkNotebook_val, Bool_val, Unit)
ML_2 (gtk_notebook_set_scrollable, GtkNotebook_val, Bool_val, Unit)
ML_2 (gtk_notebook_set_tab_border, GtkNotebook_val, Int_val, Unit)
ML_1 (gtk_notebook_popup_enable, GtkNotebook_val, Unit)
ML_1 (gtk_notebook_popup_disable, GtkNotebook_val, Unit)

ML_1 (gtk_notebook_get_current_page, GtkNotebook_val, Val_int)
ML_2 (gtk_notebook_set_page, GtkNotebook_val, Int_val, Unit)
ML_2 (gtk_notebook_get_nth_page, GtkNotebook_val, Int_val, Val_GtkWidget)
ML_2 (gtk_notebook_page_num, GtkNotebook_val, GtkWidget_val, Val_int)
ML_1 (gtk_notebook_next_page, GtkNotebook_val, Unit)
ML_1 (gtk_notebook_prev_page, GtkNotebook_val, Unit)

ML_2 (gtk_notebook_get_tab_label, GtkNotebook_val, GtkWidget_val,
      Val_GtkWidget)
ML_3 (gtk_notebook_set_tab_label, GtkNotebook_val, GtkWidget_val,
      GtkWidget_val, Unit)
ML_2 (gtk_notebook_get_menu_label, GtkNotebook_val, GtkWidget_val,
      Val_GtkWidget)
ML_3 (gtk_notebook_set_menu_label, GtkNotebook_val, GtkWidget_val,
      GtkWidget_val, Unit)
ML_3 (gtk_notebook_reorder_child, GtkNotebook_val, GtkWidget_val,
      Int_val, Unit)


/* gtkpacker.h */

Make_OptFlags_val(Packer_options_val)

#define GtkPacker_val(val) check_cast(GTK_PACKER,val)
ML_0 (gtk_packer_new, Val_GtkWidget_sink)
ML_10 (gtk_packer_add, GtkPacker_val, GtkWidget_val,
       Option_val(arg3,Side_type_val,GTK_SIDE_TOP) Ignore,
       Option_val(arg4,Anchor_type_val,GTK_ANCHOR_CENTER) Ignore,
       OptFlags_Packer_options_val,
       Option_val(arg6,Int_val,GtkPacker_val(arg1)->default_border_width) Ignore,
       Option_val(arg7,Int_val,GtkPacker_val(arg1)->default_pad_x) Ignore,
       Option_val(arg8,Int_val,GtkPacker_val(arg1)->default_pad_y) Ignore,
       Option_val(arg9,Int_val,GtkPacker_val(arg1)->default_i_pad_x) Ignore,
       Option_val(arg10,Int_val,GtkPacker_val(arg1)->default_i_pad_y) Ignore,
       Unit)
ML_bc10 (ml_gtk_packer_add)
ML_5 (gtk_packer_add_defaults, GtkPacker_val, GtkWidget_val,
       Option_val(arg3,Side_type_val,GTK_SIDE_TOP) Ignore,
       Option_val(arg4,Anchor_type_val,GTK_ANCHOR_CENTER) Ignore,
       OptFlags_Packer_options_val, Unit)
ML_10 (gtk_packer_set_child_packing, GtkPacker_val, GtkWidget_val,
       Option_val(arg3,Side_type_val,GTK_SIDE_TOP) Ignore,
       Option_val(arg4,Anchor_type_val,GTK_ANCHOR_CENTER) Ignore,
       OptFlags_Packer_options_val,
       Option_val(arg6,Int_val,GtkPacker_val(arg1)->default_border_width) Ignore,
       Option_val(arg7,Int_val,GtkPacker_val(arg1)->default_pad_x) Ignore,
       Option_val(arg8,Int_val,GtkPacker_val(arg1)->default_pad_y) Ignore,
       Option_val(arg9,Int_val,GtkPacker_val(arg1)->default_i_pad_x) Ignore,
       Option_val(arg10,Int_val,GtkPacker_val(arg1)->default_i_pad_y) Ignore,
       Unit)
ML_bc10 (ml_gtk_packer_set_child_packing)
ML_3 (gtk_packer_reorder_child, GtkPacker_val, GtkWidget_val,
      Int_val, Unit)
ML_2 (gtk_packer_set_spacing, GtkPacker_val, Int_val, Unit)
value ml_gtk_packer_set_defaults (value w, value border_width,
				  value pad_x, value pad_y,
				  value i_pad_x, value i_pad_y)
{
    GtkPacker *p = GtkPacker_val(w);
    if (Is_block(border_width))
	gtk_packer_set_default_border_width (p,Int_val(Field(border_width,0)));
    if (Is_block(pad_x) || Is_block(pad_y))
	gtk_packer_set_default_pad
	    (p, Option_val(pad_x,Int_val,p->default_pad_x),
	        Option_val(pad_y,Int_val,p->default_pad_y));
    if (Is_block(i_pad_x) || Is_block(i_pad_y))
	gtk_packer_set_default_ipad
	    (p, Option_val(pad_x,Int_val,p->default_i_pad_x),
	        Option_val(pad_y,Int_val,p->default_i_pad_y));
    return Val_unit;
}
ML_bc6 (ml_gtk_packer_set_defaults)

/* gtkpaned.h */

#define GtkPaned_val(val) check_cast(GTK_PANED,val)
ML_0 (gtk_hpaned_new, Val_GtkWidget_sink)
ML_0 (gtk_vpaned_new, Val_GtkWidget_sink)
ML_2 (gtk_paned_add1, GtkPaned_val, GtkWidget_val, Unit)
ML_2 (gtk_paned_add2, GtkPaned_val, GtkWidget_val, Unit)
ML_2 (gtk_paned_set_handle_size, GtkPaned_val, Int_val, Unit)
ML_2 (gtk_paned_set_gutter_size, GtkPaned_val, Int_val, Unit)

/* gtkscrolledwindow.h */

#define GtkScrolledWindow_val(val) check_cast(GTK_SCROLLED_WINDOW,val)
ML_2 (gtk_scrolled_window_new, GtkAdjustment_val ,GtkAdjustment_val,
      Val_GtkWidget_sink)
ML_2 (gtk_scrolled_window_set_hadjustment, GtkScrolledWindow_val ,
      GtkAdjustment_val, Unit)
ML_2 (gtk_scrolled_window_set_vadjustment, GtkScrolledWindow_val ,
      GtkAdjustment_val, Unit)
ML_1 (gtk_scrolled_window_get_hadjustment, GtkScrolledWindow_val,
      Val_GtkWidget)
ML_1 (gtk_scrolled_window_get_vadjustment, GtkScrolledWindow_val,
      Val_GtkWidget)
ML_3 (gtk_scrolled_window_set_policy, GtkScrolledWindow_val,
      Policy_type_val, Policy_type_val, Unit)
Make_Extractor (gtk_scrolled_window_get, GtkScrolledWindow_val,
		hscrollbar_policy, Val_policy_type)
Make_Extractor (gtk_scrolled_window_get, GtkScrolledWindow_val,
		vscrollbar_policy, Val_policy_type)
ML_2 (gtk_scrolled_window_set_placement, GtkScrolledWindow_val,
      Corner_type_val, Unit)
ML_2 (gtk_scrolled_window_add_with_viewport, GtkScrolledWindow_val,
      GtkWidget_val, Unit)

/* gtktable.h */

#define GtkTable_val(val) check_cast(GTK_TABLE,val)
ML_3 (gtk_table_new, Int_val, Int_val, Int_val, Val_GtkWidget_sink)
ML_10 (gtk_table_attach, GtkTable_val, GtkWidget_val,
       Int_val, Int_val, Int_val, Int_val,
       Flags_Attach_options_val, Flags_Attach_options_val,
       Int_val, Int_val, Unit)
ML_bc10 (ml_gtk_table_attach)
ML_3 (gtk_table_set_row_spacing, GtkTable_val, Int_val, Int_val, Unit)
ML_3 (gtk_table_set_col_spacing, GtkTable_val, Int_val, Int_val, Unit)
ML_2 (gtk_table_set_row_spacings, GtkTable_val, Int_val, Unit)
ML_2 (gtk_table_set_col_spacings, GtkTable_val, Int_val, Unit)
ML_2 (gtk_table_set_homogeneous, GtkTable_val, Bool_val, Unit)

/* gtktoolbar.h */

#define GtkToolbar_val(val) check_cast(GTK_TOOLBAR,val)
ML_2 (gtk_toolbar_new, Orientation_val, Toolbar_style_val, Val_GtkWidget_sink)
ML_2 (gtk_toolbar_insert_space, GtkToolbar_val, Int_val, Unit)
ML_7 (gtk_toolbar_insert_element, GtkToolbar_val, Toolbar_child_val,
      Insert(NULL) String_val, String_val, String_val, GtkWidget_val,
      Insert(NULL) Insert(NULL) Int_val, Val_GtkWidget)
ML_bc7 (ml_gtk_toolbar_insert_element)
ML_5 (gtk_toolbar_insert_widget, GtkToolbar_val, GtkWidget_val,
      String_val, String_val, Int_val, Unit)
ML_2 (gtk_toolbar_set_orientation, GtkToolbar_val, Orientation_val, Unit)
ML_2 (gtk_toolbar_set_style, GtkToolbar_val, Toolbar_style_val, Unit)
ML_2 (gtk_toolbar_set_space_size, GtkToolbar_val, Int_val, Unit)
ML_2 (gtk_toolbar_set_space_style, GtkToolbar_val, Toolbar_space_style_val, Unit)
ML_2 (gtk_toolbar_set_tooltips, GtkToolbar_val, Bool_val, Unit)
ML_2 (gtk_toolbar_set_button_relief, GtkToolbar_val, Relief_type_val, Unit)
ML_1 (gtk_toolbar_get_button_relief, GtkToolbar_val, Val_relief_type)

/* gtktree.h */

#define GtkTree_val(val) check_cast(GTK_TREE,val)
ML_0 (gtk_tree_new, Val_GtkWidget_sink)
ML_3 (gtk_tree_insert, GtkTree_val, GtkWidget_val, Int_val, Unit)
ML_3 (gtk_tree_clear_items, GtkTree_val, Int_val, Int_val, Unit)
ML_2 (gtk_tree_select_item, GtkTree_val, Int_val, Unit)
ML_2 (gtk_tree_unselect_item, GtkTree_val, Int_val, Unit)
ML_2 (gtk_tree_child_position, GtkTree_val, GtkWidget_val, Val_int)
ML_2 (gtk_tree_set_selection_mode, GtkTree_val, Selection_mode_val, Unit)
ML_2 (gtk_tree_set_view_mode, GtkTree_val, Tree_view_mode_val, Unit)
ML_2 (gtk_tree_set_view_lines, GtkTree_val, Bool_val, Unit)

static value val_gtkany (gpointer p) { return Val_GtkAny(p); }
value ml_gtk_tree_selection (value tree)
{
  GList *selection = GTK_TREE_SELECTION(GtkTree_val(tree));
  return Val_GList(selection, val_gtkany);
}
static gpointer gtkobject_val (value val) { return GtkObject_val(val); }
value ml_gtk_tree_remove_items (value tree, value items)
{
  GList *items_list = GList_val (items, gtkobject_val);
  gtk_tree_remove_items (GtkTree_val(tree), items_list);
  return Val_unit;
}

/* gtkcalendar.h */

#define GtkCalendar_val(val) check_cast(GTK_CALENDAR,val)
ML_0 (gtk_calendar_new, Val_GtkWidget_sink)
ML_3 (gtk_calendar_select_month, GtkCalendar_val, Int_val, Int_val, Unit)
ML_2 (gtk_calendar_select_day, GtkCalendar_val, Int_val, Unit)
ML_2 (gtk_calendar_mark_day, GtkCalendar_val, Int_val, Unit)
ML_2 (gtk_calendar_unmark_day, GtkCalendar_val, Int_val, Unit)
ML_1 (gtk_calendar_clear_marks, GtkCalendar_val, Unit)
Make_Flags_val (Calendar_display_options_val)
ML_2 (gtk_calendar_display_options, GtkCalendar_val,
      Flags_Calendar_display_options_val, Unit)
value ml_gtk_calendar_get_date (value w)
{
    guint year, month, day;
    value ret = Val_unit;

    gtk_calendar_get_date (GtkCalendar_val(w), &year, &month, &day);
    ret = alloc (3, 0);
    Field(ret,0) = Val_int(year);
    Field(ret,1) = Val_int(month);
    Field(ret,2) = Val_int(day);
    return ret;
}
ML_1 (gtk_calendar_freeze, GtkCalendar_val, Unit)
ML_1 (gtk_calendar_thaw, GtkCalendar_val, Unit)

/* gtkdrawingarea.h */

#define GtkDrawingArea_val(val) check_cast(GTK_DRAWING_AREA,val)
ML_0 (gtk_drawing_area_new, Val_GtkWidget_sink)
ML_3 (gtk_drawing_area_size, GtkDrawingArea_val, Int_val, Int_val, Unit)

/* gtkeditable.h */

#define GtkEditable_val(val) check_cast(GTK_EDITABLE,val)
ML_3 (gtk_editable_select_region, GtkEditable_val, Int_val, Int_val, Unit)
value ml_gtk_editable_insert_text (value w, value s, value pos)
{
    int position = Int_val(pos);
    gtk_editable_insert_text (GtkEditable_val(w), String_val(s),
			      string_length(s), &position);
    return Val_int(position);
}
ML_3 (gtk_editable_delete_text, GtkEditable_val, Int_val, Int_val, Unit)
ML_3 (gtk_editable_get_chars, GtkEditable_val, Int_val, Int_val,
      copy_string_and_free)
ML_1 (gtk_editable_cut_clipboard, GtkEditable_val, Unit)
ML_1 (gtk_editable_copy_clipboard, GtkEditable_val, Unit)
ML_1 (gtk_editable_paste_clipboard, GtkEditable_val, Unit)
ML_3 (gtk_editable_claim_selection, GtkEditable_val, Bool_val, Int_val, Unit)
ML_1 (gtk_editable_delete_selection, GtkEditable_val, Unit)
ML_1 (gtk_editable_changed, GtkEditable_val, Unit)
ML_2 (gtk_editable_set_position, GtkEditable_val, Int_val, Unit)
ML_1 (gtk_editable_get_position, GtkEditable_val, Val_int)
ML_2 (gtk_editable_set_editable, GtkEditable_val, Bool_val, Unit)
Make_Extractor (gtk_editable, GtkEditable_val, selection_start_pos, Val_int)
Make_Extractor (gtk_editable, GtkEditable_val, selection_end_pos, Val_int)
Make_Extractor (gtk_editable, GtkEditable_val, has_selection, Val_bool)

/* gtkentry.h */

#define GtkEntry_val(val) check_cast(GTK_ENTRY,val)
ML_0 (gtk_entry_new, Val_GtkWidget_sink)
ML_1 (gtk_entry_new_with_max_length, Int_val, Val_GtkWidget_sink)
ML_2 (gtk_entry_set_text, GtkEntry_val, String_val, Unit)
ML_2 (gtk_entry_append_text, GtkEntry_val, String_val, Unit)
ML_2 (gtk_entry_prepend_text, GtkEntry_val, String_val, Unit)
ML_1 (gtk_entry_get_text, GtkEntry_val, Val_string)
ML_3 (gtk_entry_select_region, GtkEntry_val, Int_val, Int_val, Unit)
ML_2 (gtk_entry_set_visibility, GtkEntry_val, Bool_val, Unit)
ML_2 (gtk_entry_set_max_length, GtkEntry_val, Bool_val, Unit)
Make_Extractor (GtkEntry, GtkEntry_val, text_length, Val_int)

/* gtkspinbutton.h */

#define GtkSpinButton_val(val) check_cast(GTK_SPIN_BUTTON,val)
ML_3 (gtk_spin_button_new, GtkAdjustment_val,
      Float_val, Int_val, Val_GtkWidget_sink)
ML_2 (gtk_spin_button_set_adjustment, GtkSpinButton_val, GtkAdjustment_val,
      Unit)
ML_1 (gtk_spin_button_get_adjustment, GtkSpinButton_val, Val_GtkAny)
ML_2 (gtk_spin_button_set_digits, GtkSpinButton_val, Int_val, Unit)
ML_1 (gtk_spin_button_get_value_as_float, GtkSpinButton_val, copy_double)
ML_2 (gtk_spin_button_set_value, GtkSpinButton_val, Float_val, Unit)
ML_2 (gtk_spin_button_set_update_policy, GtkSpinButton_val,
      Update_type_val, Unit)
ML_2 (gtk_spin_button_set_numeric, GtkSpinButton_val, Bool_val, Unit)
ML_2 (gtk_spin_button_spin, GtkSpinButton_val,
      Insert (Is_long(arg2) ? Spin_type_val(arg2) : GTK_SPIN_USER_DEFINED)
      (Is_long(arg2) ? 0.0 : Float_val(Field(arg2,1))) Ignore, Unit)
ML_2 (gtk_spin_button_set_wrap, GtkSpinButton_val, Bool_val, Unit)
ML_2 (gtk_spin_button_set_shadow_type, GtkSpinButton_val, Shadow_type_val, Unit)
ML_2 (gtk_spin_button_set_snap_to_ticks, GtkSpinButton_val, Bool_val, Unit)
ML_4 (gtk_spin_button_configure, GtkSpinButton_val, GtkAdjustment_val,
      Float_val, Int_val, Unit)
ML_1 (gtk_spin_button_update, GtkSpinButton_val, Unit)

/* gtktext.h */

#define GtkText_val(val) check_cast(GTK_TEXT,val)
ML_2 (gtk_text_new, GtkAdjustment_val, GtkAdjustment_val, Val_GtkWidget_sink)
ML_2 (gtk_text_set_word_wrap, GtkText_val, Bool_val, Unit)
ML_3 (gtk_text_set_adjustments, GtkText_val,
      Option_val(arg2,GtkAdjustment_val,GtkText_val(arg1)->hadj) Ignore,
      Option_val(arg3,GtkAdjustment_val,GtkText_val(arg1)->vadj) Ignore,
      Unit)
Make_Extractor (gtk_text_get, GtkText_val, hadj, Val_GtkWidget)
Make_Extractor (gtk_text_get, GtkText_val, vadj, Val_GtkWidget)
ML_2 (gtk_text_set_point, GtkText_val, Int_val, Unit)
ML_1 (gtk_text_get_point, GtkText_val, Val_int)
ML_1 (gtk_text_get_length, GtkText_val, Val_int)
ML_1 (gtk_text_freeze, GtkText_val, Unit)
ML_1 (gtk_text_thaw, GtkText_val, Unit)
value ml_gtk_text_insert (value text, value font, value fore, value back,
			  value str)
{
    gtk_text_insert (GtkText_val(text),
		     Option_val(font,GdkFont_val,NULL),
		     Option_val(fore,GdkColor_val,NULL),
		     Option_val(back,GdkColor_val,NULL),
		     String_val(str), string_length(str));
    return Val_unit;
}
ML_2 (gtk_text_forward_delete, GtkText_val, Int_val, Val_int)
ML_2 (gtk_text_backward_delete, GtkText_val, Int_val, Val_int)

/* gtkmisc.h */

#define GtkMisc_val(val) check_cast(GTK_MISC,val)
ML_3 (gtk_misc_set_alignment, GtkMisc_val, Double_val, Double_val, Unit)
ML_3 (gtk_misc_set_padding, GtkMisc_val, Int_val, Int_val, Unit)
Make_Extractor (gtk_misc_get, GtkMisc_val, xalign, copy_double)
Make_Extractor (gtk_misc_get, GtkMisc_val, yalign, copy_double)
Make_Extractor (gtk_misc_get, GtkMisc_val, xpad, Val_int)
Make_Extractor (gtk_misc_get, GtkMisc_val, ypad, Val_int)

/* gtkarrow.h */

#define GtkArrow_val(val) check_cast(GTK_ARROW,val)
ML_2 (gtk_arrow_new, Arrow_type_val, Shadow_type_val, Val_GtkWidget_sink)
ML_3 (gtk_arrow_set, GtkArrow_val, Arrow_type_val, Shadow_type_val, Unit)

/* gtkimage.h */

#define GtkImage_val(val) check_cast(GTK_IMAGE,val)
ML_2 (gtk_image_new, GdkImage_val,
      Option_val (arg2, GdkBitmap_val, NULL) Ignore, Val_GtkWidget_sink)
ML_3 (gtk_image_set, GtkImage_val, GdkImage_val,
      Option_val (arg2, GdkBitmap_val, NULL) Ignore, Unit)

/* gtklabel.h */

#define GtkLabel_val(val) check_cast(GTK_LABEL,val)
ML_1 (gtk_label_new, String_val, Val_GtkWidget_sink)
ML_2 (gtk_label_set_text, GtkLabel_val, String_val, Unit)
ML_2 (gtk_label_set_pattern, GtkLabel_val, String_val, Unit)
ML_2 (gtk_label_set_justify, GtkLabel_val, Justification_val, Unit)
ML_2 (gtk_label_set_line_wrap, GtkLabel_val, Bool_val, Unit)
Make_Extractor (gtk_label_get, GtkLabel_val, label, Val_string)

/* gtktipsquery.h */

#define GtkTipsQuery_val(val) check_cast(GTK_TIPS_QUERY,val)
ML_0 (gtk_tips_query_new, Val_GtkWidget_sink)
ML_1 (gtk_tips_query_start_query, GtkTipsQuery_val, Unit)
ML_1 (gtk_tips_query_stop_query, GtkTipsQuery_val, Unit)
ML_2 (gtk_tips_query_set_caller, GtkTipsQuery_val, GtkWidget_val, Unit)
ML_3 (gtk_tips_query_set_labels, GtkTipsQuery_val,
      String_val, String_val, Unit)
value ml_gtk_tips_query_set_emit_always (value w, value arg)
{
    GtkTipsQuery_val(w)->emit_always = Bool_val(arg);
    return Val_unit;
}
Make_Extractor (gtk_tips_query_get, GtkTipsQuery_val, emit_always, Val_bool)
Make_Extractor (gtk_tips_query_get, GtkTipsQuery_val, caller, Val_GtkWidget)
Make_Extractor (gtk_tips_query_get, GtkTipsQuery_val, label_inactive,
		Val_string)
Make_Extractor (gtk_tips_query_get, GtkTipsQuery_val, label_no_tip,
		Val_string)

/* gtkpixmap.h */

#define GtkPixmap_val(val) check_cast(GTK_PIXMAP,val)
ML_2 (gtk_pixmap_new, GdkPixmap_val,
      Option_val (arg2, GdkBitmap_val, NULL) Ignore,
      Val_GtkWidget_sink)
value ml_gtk_pixmap_set (value val, value pixmap, value mask)
{
    GtkPixmap *w = GtkPixmap_val(val);
    gtk_pixmap_set (w, Option_val(pixmap,GdkPixmap_val,w->pixmap),
		    Option_val(mask,GdkBitmap_val,w->mask));
    return Val_unit;
}
Make_Extractor (GtkPixmap, GtkPixmap_val, pixmap, Val_GdkPixmap)
Make_Extractor (GtkPixmap, GtkPixmap_val, mask, Val_GdkBitmap)

/* gtkpreview.h */
/*
#define GtkPreview_val(val) GTK_PREVIEW(Pointer_val(val))
ML_1 (gtk_preview_new, Preview_val, Val_GtkWidget_sink)
ML_3 (gtk_preview_size, GtkPreview_val, Int_val, Int_val, Unit)
ML_9 (gtk_preview_put, GtkPreview_val, GdkWindow_val, GdkGC_val,
      Int_val, Int_val, Int_val, Int_val, Int_val, Int_val, Unit)
ML_bc9 (ml_gtk_preview_put)
*/

/* gtkprogress.h */

#define GtkProgress_val(val) check_cast(GTK_PROGRESS,val)
ML_2 (gtk_progress_set_show_text, GtkProgress_val, Bool_val, Unit)
ML_3 (gtk_progress_set_text_alignment, GtkProgress_val,
      Option_val(arg2,Float_val,(GtkProgress_val(arg1))->x_align) Ignore,
      Option_val(arg3,Float_val,(GtkProgress_val(arg1))->y_align) Ignore, Unit)
ML_2 (gtk_progress_set_format_string, GtkProgress_val, String_val, Unit)
ML_2 (gtk_progress_set_adjustment, GtkProgress_val, GtkAdjustment_val, Unit)
ML_4 (gtk_progress_configure, GtkProgress_val,
      Float_val, Float_val, Float_val, Unit)
ML_2 (gtk_progress_set_percentage, GtkProgress_val, Float_val, Unit)
ML_2 (gtk_progress_set_value, GtkProgress_val, Float_val, Unit)
ML_1 (gtk_progress_get_value, GtkProgress_val, copy_double)
ML_1 (gtk_progress_get_current_percentage, GtkProgress_val, copy_double)
ML_2 (gtk_progress_set_activity_mode, GtkProgress_val, Bool_val, Unit)
ML_1 (gtk_progress_get_current_text, GtkProgress_val, Val_string)
Make_Extractor (gtk_progress_get, GtkProgress_val, adjustment,
		Val_GtkAny)

/* gtkprogressbar.h */

#define GtkProgressBar_val(val) check_cast(GTK_PROGRESS_BAR,val)
ML_0 (gtk_progress_bar_new, Val_GtkWidget_sink)
ML_1 (gtk_progress_bar_new_with_adjustment, GtkAdjustment_val,
      Val_GtkWidget_sink)
ML_2 (gtk_progress_bar_set_bar_style, GtkProgressBar_val,
      Progress_bar_style_val, Unit)
ML_2 (gtk_progress_bar_set_discrete_blocks, GtkProgressBar_val, Int_val, Unit)
ML_2 (gtk_progress_bar_set_activity_step, GtkProgressBar_val, Int_val, Unit)
ML_2 (gtk_progress_bar_set_activity_blocks, GtkProgressBar_val, Int_val, Unit)
ML_2 (gtk_progress_bar_set_orientation, GtkProgressBar_val,
      Progress_bar_orientation_val, Unit)
/* ML_2 (gtk_progress_bar_update, GtkProgressBar_val, Float_val, Unit) */

/* gtkrange.h */

#define GtkRange_val(val) check_cast(GTK_RANGE,val)
ML_1 (gtk_range_get_adjustment, GtkRange_val, Val_GtkAny)
ML_2 (gtk_range_set_adjustment, GtkRange_val, GtkAdjustment_val, Unit)
ML_2 (gtk_range_set_update_policy, GtkRange_val, Update_type_val, Unit)

/* gtkscale.h */

#define GtkScale_val(val) check_cast(GTK_SCALE,val)
ML_2 (gtk_scale_set_digits, GtkScale_val, Int_val, Unit)
ML_2 (gtk_scale_set_draw_value, GtkScale_val, Bool_val, Unit)
ML_2 (gtk_scale_set_value_pos, GtkScale_val, Position_val, Unit)
ML_1 (gtk_scale_get_value_width, GtkScale_val, Val_int)
ML_1 (gtk_scale_draw_value, GtkScale_val, Unit)
ML_1 (gtk_hscale_new, GtkAdjustment_val, Val_GtkWidget_sink)
ML_1 (gtk_vscale_new, GtkAdjustment_val, Val_GtkWidget_sink)

/* gtkscrollbar.h */

ML_1 (gtk_hscrollbar_new, GtkAdjustment_val, Val_GtkWidget_sink)
ML_1 (gtk_vscrollbar_new, GtkAdjustment_val, Val_GtkWidget_sink)

/* gtkruler.h */

#define GtkRuler_val(val) check_cast(GTK_RULER,val)
ML_2 (gtk_ruler_set_metric, GtkRuler_val, Metric_type_val, Unit)
ML_5 (gtk_ruler_set_range, GtkRuler_val, Float_val,
      Float_val, Float_val, Float_val, Unit)
Make_Extractor (gtk_ruler_get, GtkRuler_val, lower, copy_double)
Make_Extractor (gtk_ruler_get, GtkRuler_val, upper, copy_double)
Make_Extractor (gtk_ruler_get, GtkRuler_val, position, copy_double)
Make_Extractor (gtk_ruler_get, GtkRuler_val, max_size, copy_double)
ML_1 (gtk_ruler_draw_ticks, GtkRuler_val, Unit)
ML_1 (gtk_ruler_draw_pos, GtkRuler_val, Unit)
ML_0 (gtk_hruler_new, Val_GtkWidget_sink)
ML_0 (gtk_vruler_new, Val_GtkWidget_sink)

/* gtk[hv]separator.h */

ML_0 (gtk_hseparator_new, Val_GtkWidget_sink)
ML_0 (gtk_vseparator_new, Val_GtkWidget_sink)

/* gtkmain.h */

value ml_gtk_init (value argv)
{
    int argc = Wosize_val(argv);
    value copy = (argc ? alloc_shr (argc, Abstract_tag) : Atom(0));
    value ret;
    int i;
    for (i = 0; i < argc; i++) Field(copy,i) = Field(argv,i);
    gtk_init (&argc, (char ***)&copy);
    ret = (argc ? alloc_shr (argc, 0) : Atom(0));
    Begin_root (ret);
    for (i = 0; i < argc; i++) initialize(&Field(ret,i), Field(copy,i));
    End_roots ();
    return ret;
}
ML_1 (gtk_exit, Int_val, Unit)
ML_0 (gtk_set_locale, Val_string)
ML_0 (gtk_main, Unit)
ML_1 (gtk_main_iteration_do, Bool_val, Val_bool)
ML_0 (gtk_main_quit, Unit)
ML_1 (gtk_grab_add, GtkWidget_val, Unit)
ML_1 (gtk_grab_remove, GtkWidget_val, Unit)
ML_0 (gtk_grab_get_current, Val_GtkWidget)
value ml_gtk_get_version (value unit)
{
    value ret = alloc_tuple(3);
    Field(ret,0) = Val_int(gtk_major_version);
    Field(ret,1) = Val_int(gtk_minor_version);
    Field(ret,2) = Val_int(gtk_micro_version);
    return ret;
}

/* Marshalling */

void ml_gtk_callback_marshal (GtkObject *object, gpointer data,
			       guint nargs, GtkArg *args)
{
    value vargs = alloc_tuple(3);
    value vobject;

    Begin_root (vargs);
    Field(vargs,0) = (value) object;
    Field(vargs,1) = Val_int(nargs);
    Field(vargs,2) = (value) args;

    callback (*(value*)data, vargs);

    Field(vargs,0) = Val_int(-1);
    Field(vargs,1) = Val_int(-1);
    End_roots ();
}

value ml_gtk_arg_shift (GtkArg *args, value index)
{
    return (value) (&args[Int_val(index)]);
}

value ml_gtk_arg_get_type (GtkArg *arg)
{
    return Val_int (arg->type);
}

value ml_gtk_arg_get_char (GtkArg *arg)
{
    if (GTK_FUNDAMENTAL_TYPE(arg->type) != GTK_TYPE_CHAR)
	ml_raise_gtk ("argument type mismatch");
    return Val_char (GTK_VALUE_CHAR(*arg));
}

value ml_gtk_arg_get_bool (GtkArg *arg)
{
    if (GTK_FUNDAMENTAL_TYPE(arg->type) != GTK_TYPE_BOOL)
	ml_raise_gtk ("argument type mismatch");
    return Val_bool (GTK_VALUE_BOOL(*arg));
}

value ml_gtk_arg_get_int (GtkArg *arg)
{
    switch (GTK_FUNDAMENTAL_TYPE(arg->type)) {
    case GTK_TYPE_INT:
    case GTK_TYPE_UINT:
	return Val_int (GTK_VALUE_INT(*arg));
    case GTK_TYPE_LONG:
    case GTK_TYPE_ULONG:
	return Val_long (GTK_VALUE_LONG(*arg));
    case GTK_TYPE_ENUM:
	return Val_int (GTK_VALUE_ENUM(*arg));
    case GTK_TYPE_FLAGS:
	return Val_int (GTK_VALUE_FLAGS(*arg));
    default:
	ml_raise_gtk ("argument type mismatch");
    }
}

value ml_gtk_arg_get_float (GtkArg *arg)
{
    switch (GTK_FUNDAMENTAL_TYPE(arg->type)) {
    case GTK_TYPE_FLOAT:
	return copy_double ((double)GTK_VALUE_FLOAT(*arg));
    case GTK_TYPE_DOUBLE:
	return copy_double (GTK_VALUE_DOUBLE(*arg));
    default:
	ml_raise_gtk ("argument type mismatch");
    }
}

value ml_gtk_arg_get_string (GtkArg *arg)
{
    if (GTK_FUNDAMENTAL_TYPE(arg->type) != GTK_TYPE_STRING)
	ml_raise_gtk ("argument type mismatch");
    return Val_string (GTK_VALUE_STRING(*arg));
}

value ml_gtk_arg_get_pointer (GtkArg *arg)
{
    switch (GTK_FUNDAMENTAL_TYPE(arg->type)) {
    case GTK_TYPE_BOXED:
	return Val_pointer(GTK_VALUE_BOXED(*arg));
    case GTK_TYPE_POINTER:
	return Val_pointer(GTK_VALUE_POINTER(*arg));
    default:
	ml_raise_gtk ("argument type mismatch");
    }
}

value ml_gtk_arg_get_object (GtkArg *arg)
{
    if (GTK_FUNDAMENTAL_TYPE(arg->type) != GTK_TYPE_OBJECT)
	ml_raise_gtk ("argument type mismatch");
    /* Val_GtkObject checks for null pointer */
    return Val_GtkObject (GTK_VALUE_OBJECT(*arg));
}

value ml_gtk_arg_set_char (GtkArg *arg, value val)
{
    if (GTK_FUNDAMENTAL_TYPE(arg->type) != GTK_TYPE_CHAR)
	ml_raise_gtk ("argument type mismatch");
    *GTK_RETLOC_CHAR(*arg) = Char_val(val);
    return Val_unit;
}

value ml_gtk_arg_set_bool (GtkArg *arg, value val)
{
    if (GTK_FUNDAMENTAL_TYPE(arg->type) != GTK_TYPE_BOOL)
	ml_raise_gtk ("argument type mismatch");
    *GTK_RETLOC_BOOL(*arg) = Bool_val(val);
    return Val_unit;
}

value ml_gtk_arg_set_int (GtkArg *arg, value val)
{
    switch (GTK_FUNDAMENTAL_TYPE(arg->type)) {
    case GTK_TYPE_INT:
    case GTK_TYPE_UINT:
	*GTK_RETLOC_INT(*arg) = Int_val(val); break;
    case GTK_TYPE_LONG:
    case GTK_TYPE_ULONG:
	*GTK_RETLOC_LONG(*arg) = Long_val(val); break;
    case GTK_TYPE_ENUM:
	*GTK_RETLOC_ENUM(*arg) = Int_val(val); break;
    case GTK_TYPE_FLAGS:
	*GTK_RETLOC_FLAGS(*arg) = Int_val(val); break;
    default:
	ml_raise_gtk ("argument type mismatch");
    }
    return Val_unit;
}

value ml_gtk_arg_set_float (GtkArg *arg, value val)
{
    switch (GTK_FUNDAMENTAL_TYPE(arg->type)) {
    case GTK_TYPE_FLOAT:
	*GTK_RETLOC_FLOAT(*arg) = (float) Double_val(val); break;
    case GTK_TYPE_DOUBLE:
	*GTK_RETLOC_DOUBLE(*arg) = Double_val(val); break;
    default:
	ml_raise_gtk ("argument type mismatch");
    }
    return Val_unit;
}

value ml_gtk_arg_set_string (GtkArg *arg, value val)
{
    if (GTK_FUNDAMENTAL_TYPE(arg->type) != GTK_TYPE_STRING)
	ml_raise_gtk ("argument type mismatch");
    *GTK_RETLOC_STRING(*arg) = String_val(val);
    return Val_unit;
}

value ml_gtk_arg_set_pointer (GtkArg *arg, value val)
{
    switch (GTK_FUNDAMENTAL_TYPE(arg->type)) {
    case GTK_TYPE_BOXED:
	*GTK_RETLOC_BOXED(*arg) = Pointer_val(val); break;
    case GTK_TYPE_POINTER:
	*GTK_RETLOC_POINTER(*arg) = Pointer_val(val); break;
    default:
	ml_raise_gtk ("argument type mismatch");
    }
    return Val_unit;
}

value ml_gtk_arg_set_object (GtkArg *arg, value val)
{
    if (GTK_FUNDAMENTAL_TYPE(arg->type) != GTK_TYPE_OBJECT)
	ml_raise_gtk ("argument type mismatch");
    *GTK_RETLOC_OBJECT(*arg) = GtkObject_val(val);
    return Val_unit;
}

void ml_gtk_callback_destroy (gpointer data)
{
    remove_global_root ((value *)data);
    stat_free (data);
}

/* gtksignal.h */

value ml_gtk_signal_connect (value object, value name, value clos, value after)
{
    value *clos_p = stat_alloc (sizeof(value));
    *clos_p = clos;
    register_global_root (clos_p);
    return Val_int (gtk_signal_connect_full
		    (GtkObject_val(object), String_val(name), NULL,
		     ml_gtk_callback_marshal, clos_p,
		     ml_gtk_callback_destroy, FALSE, Bool_val(after)));
}

ML_2 (gtk_signal_disconnect, GtkObject_val, Int_val, Unit)
ML_2 (gtk_signal_emit_by_name, GtkObject_val, String_val, Unit)
ML_2 (gtk_signal_emit_stop_by_name, GtkObject_val, String_val, Unit)
ML_2 (gtk_signal_handler_block, GtkObject_val, Int_val, Unit)
ML_2 (gtk_signal_handler_unblock, GtkObject_val, Int_val, Unit)

/* gtkmain.h (again) */

value ml_gtk_timeout_add (value interval, value clos)
{
    value *clos_p = stat_alloc (sizeof(value));
    *clos_p = clos;
    register_global_root (clos_p);
    return Val_int (gtk_timeout_add_full
		    (Int_val(interval), NULL, ml_gtk_callback_marshal, clos_p,
		     ml_gtk_callback_destroy));
}
ML_1 (gtk_timeout_remove, Int_val, Unit)

/*
#include "ml_gtkcaller.h"
ML_0 (gtk_caller_new, Val_GtkWidget)
*/

value ml_class_init=0;

void class_init (value class)
{
  callback(ml_class_init, class);
}


value set_ml_class_init (value class_func)
{
  if (!ml_class_init) register_global_root (&ml_class_init);
  ml_class_init = class_func;
  return Val_unit;
}

value ml_gtk_type_new (value type)
{
  return Val_GtkWidget_sink(gtk_type_new(Int_val(type)));
}


struct widget_info {
  guint size;
  guint class_size;
  guint (*get_type_func)(void);
}
widget_info_array[] = {
  { sizeof(GtkObject), sizeof(GtkObjectClass), gtk_object_get_type },
  { sizeof(GtkWidget), sizeof(GtkWidgetClass), gtk_widget_get_type },
  { sizeof(GtkMisc), sizeof(GtkMiscClass), gtk_misc_get_type },
  { sizeof(GtkLabel), sizeof(GtkLabelClass), gtk_label_get_type },
  { sizeof(GtkAccelLabel), sizeof(GtkAccelLabelClass), gtk_accel_label_get_type },
  { sizeof(GtkTipsQuery), sizeof(GtkTipsQueryClass), gtk_tips_query_get_type },
  { sizeof(GtkArrow), sizeof(GtkArrowClass), gtk_arrow_get_type },
  { sizeof(GtkImage), sizeof(GtkImageClass), gtk_image_get_type },
  { sizeof(GtkPixmap), sizeof(GtkPixmapClass), gtk_pixmap_get_type },
  { sizeof(GtkContainer), sizeof(GtkContainerClass), gtk_container_get_type },
  { sizeof(GtkBin), sizeof(GtkBinClass), gtk_bin_get_type },
  { sizeof(GtkAlignment), sizeof(GtkAlignmentClass), gtk_alignment_get_type },
  { sizeof(GtkFrame), sizeof(GtkFrameClass), gtk_frame_get_type },
  { sizeof(GtkAspectFrame), sizeof(GtkAspectFrameClass), gtk_aspect_frame_get_type },
  { sizeof(GtkButton), sizeof(GtkButtonClass), gtk_button_get_type },
  { sizeof(GtkToggleButton), sizeof(GtkToggleButtonClass), gtk_toggle_button_get_type },
  { sizeof(GtkCheckButton), sizeof(GtkCheckButtonClass), gtk_check_button_get_type },
  { sizeof(GtkRadioButton), sizeof(GtkRadioButtonClass), gtk_radio_button_get_type },
  { sizeof(GtkOptionMenu), sizeof(GtkOptionMenuClass), gtk_option_menu_get_type },
  { sizeof(GtkItem), sizeof(GtkItemClass), gtk_item_get_type },
  { sizeof(GtkMenuItem), sizeof(GtkMenuItemClass), gtk_menu_item_get_type },
  { sizeof(GtkCheckMenuItem), sizeof(GtkCheckMenuItemClass), gtk_check_menu_item_get_type },
  { sizeof(GtkRadioMenuItem), sizeof(GtkRadioMenuItemClass), gtk_radio_menu_item_get_type },
  { sizeof(GtkTearoffMenuItem), sizeof(GtkTearoffMenuItemClass), gtk_tearoff_menu_item_get_type },
  { sizeof(GtkListItem), sizeof(GtkListItemClass), gtk_list_item_get_type },
  { sizeof(GtkTreeItem), sizeof(GtkTreeItemClass), gtk_tree_item_get_type },
  { sizeof(GtkWindow), sizeof(GtkWindowClass), gtk_window_get_type },
  { sizeof(GtkColorSelectionDialog), sizeof(GtkColorSelectionDialogClass), gtk_color_selection_dialog_get_type },
  { sizeof(GtkDialog), sizeof(GtkDialogClass), gtk_dialog_get_type },
  { sizeof(GtkInputDialog), sizeof(GtkInputDialogClass), gtk_input_dialog_get_type },
  { sizeof(GtkFileSelection), sizeof(GtkFileSelectionClass), gtk_file_selection_get_type },
  { sizeof(GtkFontSelectionDialog), sizeof(GtkFontSelectionDialogClass), gtk_font_selection_dialog_get_type },
  { sizeof(GtkPlug), sizeof(GtkPlugClass), gtk_plug_get_type },
  { sizeof(GtkEventBox), sizeof(GtkEventBoxClass), gtk_event_box_get_type },
  { sizeof(GtkHandleBox), sizeof(GtkHandleBoxClass), gtk_handle_box_get_type },
  { sizeof(GtkScrolledWindow), sizeof(GtkScrolledWindowClass), gtk_scrolled_window_get_type },
  { sizeof(GtkViewport), sizeof(GtkViewportClass), gtk_viewport_get_type },
  { sizeof(GtkBox), sizeof(GtkBoxClass), gtk_box_get_type },
  { sizeof(GtkButtonBox), sizeof(GtkButtonBoxClass), gtk_button_box_get_type },
  { sizeof(GtkHButtonBox), sizeof(GtkHButtonBoxClass), gtk_hbutton_box_get_type },
  { sizeof(GtkVButtonBox), sizeof(GtkVButtonBoxClass), gtk_vbutton_box_get_type },
  { sizeof(GtkVBox), sizeof(GtkVBoxClass), gtk_vbox_get_type },
  { sizeof(GtkColorSelection), sizeof(GtkColorSelectionClass), gtk_color_selection_get_type },
  { sizeof(GtkGammaCurve), sizeof(GtkGammaCurveClass), gtk_gamma_curve_get_type },
  { sizeof(GtkHBox), sizeof(GtkHBoxClass), gtk_hbox_get_type },
  { sizeof(GtkCombo), sizeof(GtkComboClass), gtk_combo_get_type },
  { sizeof(GtkStatusbar), sizeof(GtkStatusbarClass), gtk_statusbar_get_type },
  { sizeof(GtkCList), sizeof(GtkCListClass), gtk_clist_get_type },
  { sizeof(GtkCTree), sizeof(GtkCTreeClass), gtk_ctree_get_type },
  { sizeof(GtkFixed), sizeof(GtkFixedClass), gtk_fixed_get_type },
  { sizeof(GtkNotebook), sizeof(GtkNotebookClass), gtk_notebook_get_type },
  { sizeof(GtkFontSelection), sizeof(GtkFontSelectionClass), gtk_font_selection_get_type },
  { sizeof(GtkPaned), sizeof(GtkPanedClass), gtk_paned_get_type },
  { sizeof(GtkHPaned), sizeof(GtkHPanedClass), gtk_hpaned_get_type },
  { sizeof(GtkVPaned), sizeof(GtkVPanedClass), gtk_vpaned_get_type },
  { sizeof(GtkLayout), sizeof(GtkLayoutClass), gtk_layout_get_type },
  { sizeof(GtkList), sizeof(GtkListClass), gtk_list_get_type },
  { sizeof(GtkMenuShell), sizeof(GtkMenuShellClass), gtk_menu_shell_get_type },
  { sizeof(GtkMenuBar), sizeof(GtkMenuBarClass), gtk_menu_bar_get_type },
  { sizeof(GtkMenu), sizeof(GtkMenuClass), gtk_menu_get_type },
  { sizeof(GtkPacker), sizeof(GtkPackerClass), gtk_packer_get_type },
  { sizeof(GtkSocket), sizeof(GtkSocketClass), gtk_socket_get_type },
  { sizeof(GtkTable), sizeof(GtkTableClass), gtk_table_get_type },
  { sizeof(GtkToolbar), sizeof(GtkToolbarClass), gtk_toolbar_get_type },
  { sizeof(GtkTree), sizeof(GtkTreeClass), gtk_tree_get_type },
  { sizeof(GtkCalendar), sizeof(GtkCalendarClass), gtk_calendar_get_type },
  { sizeof(GtkDrawingArea), sizeof(GtkDrawingAreaClass), gtk_drawing_area_get_type },
  { sizeof(GtkCurve), sizeof(GtkCurveClass), gtk_curve_get_type },
  { sizeof(GtkEditable), sizeof(GtkEditableClass), gtk_editable_get_type },
  { sizeof(GtkEntry), sizeof(GtkEntryClass), gtk_entry_get_type },
  { sizeof(GtkSpinButton), sizeof(GtkSpinButtonClass), gtk_spin_button_get_type },
  { sizeof(GtkText), sizeof(GtkTextClass), gtk_text_get_type },
  { sizeof(GtkRuler), sizeof(GtkRulerClass), gtk_ruler_get_type },
  { sizeof(GtkHRuler), sizeof(GtkHRulerClass), gtk_hruler_get_type },
  { sizeof(GtkVRuler), sizeof(GtkVRulerClass), gtk_vruler_get_type },
  { sizeof(GtkRange), sizeof(GtkRangeClass), gtk_range_get_type },
  { sizeof(GtkScale), sizeof(GtkScaleClass), gtk_scale_get_type },
  { sizeof(GtkHScale), sizeof(GtkHScaleClass), gtk_hscale_get_type },
  { sizeof(GtkVScale), sizeof(GtkVScaleClass), gtk_vscale_get_type },
  { sizeof(GtkScrollbar), sizeof(GtkScrollbarClass), gtk_scrollbar_get_type },
  { sizeof(GtkHScrollbar), sizeof(GtkHScrollbarClass), gtk_hscrollbar_get_type },
  { sizeof(GtkVScrollbar), sizeof(GtkVScrollbarClass), gtk_vscrollbar_get_type },
  { sizeof(GtkSeparator), sizeof(GtkSeparatorClass), gtk_separator_get_type },
  { sizeof(GtkHSeparator), sizeof(GtkHSeparatorClass), gtk_hseparator_get_type },
  { sizeof(GtkVSeparator), sizeof(GtkVSeparatorClass), gtk_vseparator_get_type },
  { sizeof(GtkPreview), sizeof(GtkPreviewClass), gtk_preview_get_type },
  { sizeof(GtkProgress), sizeof(GtkProgressClass), gtk_progress_get_type },
  { sizeof(GtkProgressBar), sizeof(GtkProgressBarClass), gtk_progress_bar_get_type },
  { sizeof(GtkData), sizeof(GtkDataClass), gtk_data_get_type },
  { sizeof(GtkAdjustment), sizeof(GtkAdjustmentClass), gtk_adjustment_get_type },
  { sizeof(GtkTooltips), sizeof(GtkTooltipsClass), gtk_tooltips_get_type },
  { sizeof(GtkItemFactory), sizeof(GtkItemFactoryClass), gtk_item_factory_get_type }
};


value ml_gtk_type_unique (value name, value parent, value nsignals)
{
  struct widget_info * wi;
  GtkTypeInfo ttt_info;

  wi = widget_info_array + Int_val(parent);
  ttt_info.type_name = String_val(name);
  ttt_info.object_size = wi->size;
  ttt_info.class_size = wi->class_size + Int_val(nsignals)*sizeof(void *);
  ttt_info.class_init_func = (GtkClassInitFunc) class_init;
  ttt_info.object_init_func = (GtkObjectInitFunc) NULL;
  ttt_info.reserved_1 = NULL;
  ttt_info.reserved_2 = NULL;
  ttt_info.base_class_init_func = (GtkClassInitFunc) NULL;

  return Val_int(gtk_type_unique(wi->get_type_func (), &ttt_info));
}

guint sig[100];

value ml_gtk_object_class_add_signals (value class, value signals,
				       value nsignals)
{
  int i;
  for (i=0; i<nsignals; i++)
    sig[i] = Int_val(Field(signals, i));
  gtk_object_class_add_signals ((GtkObjectClass *)class,
	       sig, Int_val(nsignals));
  return Val_unit;
}

value ml_gtk_signal_new (value name, value run_type, value classe,
			 value parent, value num)
{
  struct widget_info * wi;
  int offset;

  wi = widget_info_array + Int_val(parent);
  offset = wi->class_size+Int_val(num)*sizeof(void *);
  return Val_int(gtk_signal_new (String_val(name), Int_val(run_type),
		   ((GtkObjectClass *)classe)->type, offset,
		   gtk_signal_default_marshaller, GTK_TYPE_NONE, 0));
  *(((int *)classe)+offset) = 0;
}


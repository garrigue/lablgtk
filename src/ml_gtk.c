/* $Id$ */

#include <gtk/gtk.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>

#include "wrappers.h"
#include "ml_glib.h"
#include "ml_gdk.h"
#include "ml_gtk.h"
#include "gtk_tags.h"

extern void raise_with_string (value tag, const char * msg) Noreturn;

void ml_raise_gtk (const char *errmsg)
{
  static value * exn = NULL;
  if (exn == NULL)
      exn = caml_named_value ("gtkerror");
  raise_with_string (*exn, errmsg);
}

value copy_string_and_free (char *str)
{
    value res = copy_string (str);
    g_free (str);
    return res;
}

/* conversion functions */

#include "gtk_tags.c"

ML_1 (Val_direction, Int_val, )
ML_1 (Val_orientation, Int_val, )
ML_1 (Val_toolbar_style, Int_val, )
ML_1 (Val_state, Int_val, )

Make_Flags_val (Attach_val)

/* gtkobject.h */

Make_Val_final_pointer(GtkObject, gtk_object_ref, gtk_object_unref)

/* gtkaccelerator.h */

#define GtkAcceleratorTable_val(val) ((GtkAcceleratorTable*)Pointer_val(val))
Make_Val_final_pointer (GtkAcceleratorTable, gtk_accelerator_table_ref, gtk_accelerator_table_unref)

ML_0 (gtk_accelerator_table_new, Val_GtkAcceleratorTable_no_ref)

/* gtkstyle.h */

#define GtkStyle_val(val) ((GtkStyle*)Pointer_val(val))
Make_Val_final_pointer (GtkStyle, gtk_style_ref, gtk_style_unref)
ML_0 (gtk_style_new, Val_GtkStyle_no_ref)
ML_1 (gtk_style_copy, GtkStyle_val, Val_GtkStyle_no_ref)
ML_2 (gtk_style_attach, GtkStyle_val, GdkWindow_val, Val_GtkStyle)
ML_1 (gtk_style_detach, GtkStyle_val, Unit)
ML_3 (gtk_style_set_background, GtkStyle_val, GdkWindow_val, State_val, Unit)
ML_6 (gtk_draw_hline, GtkStyle_val, GdkWindow_val, State_val,
      Int_val, Int_val, Int_val, Unit)
ML_bc6 (ml_gtk_draw_hline)
ML_6 (gtk_draw_vline, GtkStyle_val, GdkWindow_val, State_val,
      Int_val, Int_val, Int_val, Unit)
ML_bc6 (ml_gtk_draw_vline)
value ml_gtk_style_get_bg (value style, value state)
{
    return (value)&GtkStyle_val(style)->bg[State_val(state)];
}
Make_Extractor (gtk_style_get, GtkStyle_val, colormap, Val_GdkColormap)

/* gtktypeutils.h */

ML_1 (gtk_type_name, Int_val, copy_string)
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
value ml_gtk_class_type (GtkObjectClass *cl)
{
    return Val_int (cl->type);
}
ML_1 (gtk_object_destroy, GtkObject_val, Unit)

/* gtkdata.h */

/* gtkadjustment.h */

#define GtkAdjustment_val(val) GTK_ADJUSTMENT(Pointer_val(val))
ML_6 (gtk_adjustment_new, Float_val, Float_val, Float_val, Float_val,
      Float_val, Float_val, Val_GtkObject)
ML_bc6 (ml_gtk_adjustment_new)
ML_2 (gtk_adjustment_set_value, GtkAdjustment_val, Float_val, Unit)
ML_3 (gtk_adjustment_clamp_page, GtkAdjustment_val,
      Float_val, Float_val, Unit)

/* gtktooltips.h */

#define GtkWidget_val(val) GTK_WIDGET(Pointer_val(val))
#define Val_GtkWidget(w) Val_GtkObject((GtkObject*)w)

#define GtkTooltips_val(val) GTK_TOOLTIPS(Pointer_val(val))
ML_0 (gtk_tooltips_new, Val_GtkWidget)
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
ML_2 (gtk_widget_draw, GtkWidget_val, (GdkRectangle*), Unit)
ML_1 (gtk_widget_draw_focus, GtkWidget_val, Unit)
ML_1 (gtk_widget_draw_default, GtkWidget_val, Unit)
ML_1 (gtk_widget_draw_children, GtkWidget_val, Unit)
ML_2 (gtk_widget_event, GtkWidget_val, GdkEvent_val( ), Unit)
ML_1 (gtk_widget_activate, GtkWidget_val, Unit)
ML_2 (gtk_widget_reparent, GtkWidget_val, GtkWidget_val, Unit)
ML_3 (gtk_widget_popup, GtkWidget_val, Int_val, Int_val, Unit)
value ml_gtk_widget_intersect (value w, GdkRectangle *area)
{
    value ret = Val_unit;
    value inter = alloc (Wosizeof(GdkRectangle), Abstract_tag);
    if (gtk_widget_intersect (GtkWidget_val(w), area, (GdkRectangle*)inter)) {
	Begin_root(inter);
	ret = alloc_tuple(1);
	Field(ret,0) = inter;
	End_roots ();
    }
    return ret;
}
ML_1 (gtk_widget_basic, GtkWidget_val, Val_bool)
ML_1 (gtk_widget_grab_focus, GtkWidget_val, Unit)
ML_1 (gtk_widget_grab_default, GtkWidget_val, Unit)
ML_2 (gtk_widget_set_name, GtkWidget_val, String_val, Unit)
ML_1 (gtk_widget_get_name, GtkWidget_val, copy_string)
ML_2 (gtk_widget_set_state, GtkWidget_val, State_val, Unit)
ML_2 (gtk_widget_set_sensitive, GtkWidget_val, Bool_val, Unit)
ML_3 (gtk_widget_set_uposition, GtkWidget_val, Int_val, Int_val, Unit)
ML_3 (gtk_widget_set_usize, GtkWidget_val, Int_val, Int_val, Unit)
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
ML_2 (gtk_widget_is_child, GtkWidget_val, GtkWidget_val, Val_bool)
ML_2 (gtk_widget_set_style, GtkWidget_val, GtkStyle_val, Unit)
ML_1 (gtk_widget_set_rc_style, GtkWidget_val, Unit)
ML_1 (gtk_widget_ensure_style, GtkWidget_val, Unit)
ML_1 (gtk_widget_get_style, GtkWidget_val, Val_GtkStyle)
ML_1 (gtk_widget_restore_default_style, GtkWidget_val, Unit)

Make_Extractor (GtkWidget, GtkWidget_val, window, Val_GdkWindow)

/* gtkcontainer.h */

#define GtkContainer_val(val) GTK_CONTAINER(Pointer_val(val))
ML_2 (gtk_container_border_width, GtkContainer_val, Int_val, Unit)
ML_2 (gtk_container_add, GtkContainer_val, GtkWidget_val, Unit)
ML_2 (gtk_container_remove, GtkContainer_val, GtkWidget_val, Unit)
ML_1 (gtk_container_disable_resize, GtkContainer_val, Unit)
ML_1 (gtk_container_enable_resize, GtkContainer_val, Unit)
ML_1 (gtk_container_block_resize, GtkContainer_val, Unit)
ML_1 (gtk_container_unblock_resize, GtkContainer_val, Unit)
ML_1 (gtk_container_need_resize, GtkContainer_val, Val_bool)
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
ML_2 (gtk_container_focus, GtkContainer_val, Direction_val, Val_bool)
ML_2 (gtk_container_set_focus_child, GtkContainer_val, GtkWidget_val, Unit)
ML_2 (gtk_container_set_focus_vadjustment, GtkContainer_val,
      GtkAdjustment_val, Unit)
ML_2 (gtk_container_set_focus_hadjustment, GtkContainer_val,
      GtkAdjustment_val, Unit)

/* gtkbin.h */

/* gtkalignment.h */

#define GtkAlignment_val(val) GTK_ALIGNMENT(Pointer_val(val))
ML_4 (gtk_alignment_new, Float_val, Float_val, Float_val, Float_val,
      Val_GtkWidget)
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

ML_0 (gtk_event_box_new, Val_GtkWidget)

/* gtkframe.h */

#define GtkFrame_val(val) GTK_FRAME(Pointer_val(val))
ML_1 (gtk_frame_new, String_val, Val_GtkWidget)
ML_2 (gtk_frame_set_label, GtkFrame_val, String_val, Unit)
ML_3 (gtk_frame_set_label_align, GtkFrame_val, Float_val, Float_val, Unit)
ML_2 (gtk_frame_set_shadow_type, GtkFrame_val, Shadow_val, Unit)

/* gtkaspectframe.h */

#define GtkAspectFrame_val(val) GTK_ASPECT_FRAME(Pointer_val(val))
ML_5 (gtk_aspect_frame_new, String_val, Float_val, Float_val,
      Float_val, Bool_val, Val_GtkWidget)
ML_5 (gtk_aspect_frame_set, GtkAspectFrame_val, Float_val, Float_val,
      Float_val, Bool_val, Unit)

/* gtkhandlebox.h */

ML_0 (gtk_handle_box_new, Val_GtkWidget)

/* gtkitem.h */

#define GtkItem_val(val) GTK_ITEM(Pointer_val(val))
ML_1 (gtk_item_select, GtkItem_val, Unit)
ML_1 (gtk_item_deselect, GtkItem_val, Unit)
ML_1 (gtk_item_toggle, GtkItem_val, Unit)

/* gtklistitem.h */

ML_0 (gtk_list_item_new, Val_GtkWidget)
ML_1 (gtk_list_item_new_with_label, String_val, Val_GtkWidget)

/* gtkmenuitem.h */

#define GtkMenuItem_val(val) GTK_MENU_ITEM(Pointer_val(val))
ML_0 (gtk_menu_item_new, Val_GtkWidget)
ML_1 (gtk_menu_item_new_with_label, String_val, Val_GtkWidget)
ML_2 (gtk_menu_item_set_submenu, GtkMenuItem_val, GtkWidget_val, Unit)
ML_1 (gtk_menu_item_remove_submenu, GtkMenuItem_val, Unit)
ML_2 (gtk_menu_item_set_placement, GtkMenuItem_val,
      Submenu_placement_val, Unit)
ML_1 (gtk_menu_item_accelerator_size, GtkMenuItem_val, Unit)
ML_2 (gtk_menu_item_accelerator_text, GtkMenuItem_val, String_val, Unit)
ML_3 (gtk_menu_item_configure, GtkMenuItem_val, Bool_val, Bool_val, Unit)
ML_1 (gtk_menu_item_activate, GtkMenuItem_val, Unit)
ML_1 (gtk_menu_item_right_justify, GtkMenuItem_val, Unit)

/* gtkcheckmenuitem.h */

#define GtkCheckMenuItem_val(val) GTK_CHECK_MENU_ITEM(Pointer_val(val))
ML_0 (gtk_check_menu_item_new, Val_GtkWidget)
ML_1 (gtk_check_menu_item_new_with_label, String_val, Val_GtkWidget)
ML_2 (gtk_check_menu_item_set_state, GtkCheckMenuItem_val, Bool_val, Unit)
ML_2 (gtk_check_menu_item_set_show_toggle, GtkCheckMenuItem_val,
      Bool_val, Unit)
ML_1 (gtk_check_menu_item_toggled, GtkCheckMenuItem_val, Unit)

/* gtkradiomenuitem.h */

#define GtkRadioMenuItem_val(val) GTK_RADIO_MENU_ITEM(Pointer_val(val))
ML_1 (gtk_radio_menu_item_new, (GSList *), Val_GtkWidget)
ML_2 (gtk_radio_menu_item_new_with_label, (GSList *),
      String_val, Val_GtkWidget)
ML_1 (gtk_radio_menu_item_group, GtkRadioMenuItem_val, Val_any)
ML_2 (gtk_radio_menu_item_set_group, GtkRadioMenuItem_val, (GSList *), Unit)

/* gtktreeitem.h */

#define GtkTreeItem_val(val) GTK_TREE_ITEM(Pointer_val(val))
ML_0 (gtk_tree_item_new, Val_GtkWidget)
ML_1 (gtk_tree_item_new_with_label, String_val, Val_GtkWidget)
ML_2 (gtk_tree_item_set_subtree, GtkTreeItem_val, GtkWidget_val, Unit)
ML_1 (gtk_tree_item_remove_subtree, GtkTreeItem_val, Unit)
ML_1 (gtk_tree_item_expand, GtkTreeItem_val, Unit)
ML_1 (gtk_tree_item_collapse, GtkTreeItem_val, Unit)

/* gtkviewport.h */

#define GtkViewport_val(val) GTK_VIEWPORT(Pointer_val(val))
ML_2 (gtk_viewport_new, Option_val(arg1,GtkAdjustment_val,NULL) Ignore,
      Option_val(arg2,GtkAdjustment_val,NULL) Ignore, Val_GtkWidget)
ML_1 (gtk_viewport_get_hadjustment, GtkViewport_val, Val_GtkWidget)
ML_1 (gtk_viewport_get_vadjustment, GtkViewport_val, Val_GtkWidget)
ML_2 (gtk_viewport_set_hadjustment, GtkViewport_val, GtkAdjustment_val, Unit)
ML_2 (gtk_viewport_set_vadjustment, GtkViewport_val, GtkAdjustment_val, Unit)
ML_2 (gtk_viewport_set_shadow_type, GtkViewport_val, Shadow_val, Unit)

/* gtkdialog.h */

#define GtkDialog_val(val) GTK_DIALOG(Pointer_val(val))
ML_0 (gtk_dialog_new, Val_GtkWidget)
Make_Extractor (GtkDialog, GtkDialog_val, action_area, Val_GtkWidget)
Make_Extractor (GtkDialog, GtkDialog_val, vbox, Val_GtkWidget)

/* gtkinputdialog.h */

ML_0 (gtk_input_dialog_new, Val_GtkWidget)

/* gtkfileselection.h */

#define GtkFileSelection_val(val) GTK_FILE_SELECTION(Pointer_val(val))
ML_1 (gtk_file_selection_new, String_val, Val_GtkWidget)
ML_2 (gtk_file_selection_set_filename, GtkFileSelection_val, String_val, Unit)
ML_1 (gtk_file_selection_get_filename, GtkFileSelection_val, copy_string)
ML_1 (gtk_file_selection_show_fileop_buttons, GtkFileSelection_val, Unit)
ML_1 (gtk_file_selection_hide_fileop_buttons, GtkFileSelection_val, Unit)

/* gtkwindow.h */

#define GtkWindow_val(val) GTK_WINDOW(Pointer_val(val))
ML_1 (gtk_window_new, Window_type_val, Val_GtkWidget)
ML_2 (gtk_window_set_title, GtkWindow_val, String_val, Unit)
ML_3 (gtk_window_set_wmclass, GtkWindow_val, String_val, String_val, Unit)
ML_2 (gtk_window_set_focus, GtkWindow_val, GtkWidget_val, Unit)
ML_2 (gtk_window_set_default, GtkWindow_val, GtkWidget_val, Unit)
ML_4 (gtk_window_set_policy, GtkWindow_val, Bool_val, Bool_val, Bool_val, Unit)
ML_2 (gtk_window_add_accelerator_table, GtkWindow_val,
      GtkAcceleratorTable_val, Unit)
ML_2 (gtk_window_remove_accelerator_table, GtkWindow_val,
      GtkAcceleratorTable_val, Unit)
ML_2 (gtk_window_position, GtkWindow_val,
      Window_position_val, Unit)
ML_1 (gtk_window_activate_focus, GtkWindow_val, Val_bool)
ML_1 (gtk_window_activate_default, GtkWindow_val, Val_bool)

/* gtkcolorsel.h */

#define GtkColorSelection_val(val) GTK_COLOR_SELECTION(Pointer_val(val))
ML_0 (gtk_color_selection_new, Val_GtkWidget)
ML_2 (gtk_color_selection_set_update_policy, GtkColorSelection_val,
      Update_val, Unit)
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
ML_1 (gtk_color_selection_dialog_new, String_val, Val_GtkWidget)

/* gtkbox.h */

#define GtkBox_val(val) GTK_BOX(Pointer_val(val))
ML_5 (gtk_box_pack_start, GtkBox_val, GtkWidget_val, Bool_val, Bool_val,
      Int_val, Unit)
ML_5 (gtk_box_pack_end, GtkBox_val, GtkWidget_val, Bool_val, Bool_val,
      Int_val, Unit)
ML_2 (gtk_box_set_homogeneous, GtkBox_val, Bool_val, Unit)
ML_2 (gtk_box_set_spacing, GtkBox_val, Int_val, Unit)
ML_3 (gtk_box_reorder_child, GtkBox_val, GtkWidget_val, Int_val, Unit)
value ml_gtk_box_query_child_packing (value box, value child)
{
    int expand, fill, padding;
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
    int expand, fill, padding;
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

ML_2 (gtk_hbox_new, Bool_val, Int_val, Val_GtkWidget)
ML_2 (gtk_vbox_new, Bool_val, Int_val, Val_GtkWidget)

/* gtkbbox.h */
    
#define GtkButtonBox_val(val) GTK_BUTTON_BOX(Pointer_val(val))
Make_Extractor (gtk_button_box, GtkButtonBox_val, spacing, Val_int)
Make_Extractor (gtk_button_box, GtkButtonBox_val, child_min_width, Val_int)
Make_Extractor (gtk_button_box, GtkButtonBox_val, child_min_height, Val_int)
Make_Extractor (gtk_button_box, GtkButtonBox_val, child_ipad_x, Val_int)
Make_Extractor (gtk_button_box, GtkButtonBox_val, child_ipad_y, Val_int)
Make_Extractor (gtk_button_box, GtkButtonBox_val, layout_style, Val_bbox_style)
ML_2 (gtk_button_box_set_spacing, GtkButtonBox_val, Int_val, Unit)
ML_3 (gtk_button_box_set_child_size, GtkButtonBox_val,
      Int_val, Int_val, Unit)
ML_3 (gtk_button_box_set_child_ipadding, GtkButtonBox_val,
      Int_val, Int_val, Unit)
ML_2 (gtk_button_box_set_layout, GtkButtonBox_val, Bbox_style_val, Unit)

ML_0 (gtk_hbutton_box_new, Val_GtkWidget)
ML_0 (gtk_vbutton_box_new, Val_GtkWidget)

/* gtklist.h */

#define GtkList_val(val) GTK_LIST(Pointer_val(val))
ML_0 (gtk_list_new, Val_GtkWidget)
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
ML_2 (gtk_list_set_selection_mode, GtkList_val, Selection_val, Unit)

/* gtkcombo.h */

#define GtkCombo_val(val) GTK_COMBO(Pointer_val(val))
ML_0 (gtk_combo_new, Val_GtkWidget)
ML_3 (gtk_combo_set_value_in_list, GtkCombo_val, Bool_val, Bool_val, Unit)
ML_2 (gtk_combo_set_use_arrows, GtkCombo_val, Bool_val, Unit)
ML_2 (gtk_combo_set_use_arrows_always, GtkCombo_val, Bool_val, Unit)
ML_2 (gtk_combo_set_case_sensitive, GtkCombo_val, Bool_val, Unit)
ML_3 (gtk_combo_set_item_string, GtkCombo_val, GtkItem_val, String_val, Unit)
ML_1 (gtk_combo_disable_activate, GtkCombo_val, Unit)
Make_Extractor (gtk_combo, GtkCombo_val, entry, Val_GtkWidget)
Make_Extractor (gtk_combo, GtkCombo_val, list, Val_GtkWidget)

/* gtkstatusbar.h */

#define GtkStatusbar_val(val) GTK_STATUSBAR(Pointer_val(val))
ML_0 (gtk_statusbar_new, Val_GtkWidget)
ML_2 (gtk_statusbar_get_context_id, GtkStatusbar_val, String_val, Val_int)
ML_3 (gtk_statusbar_push, GtkStatusbar_val, Int_val, String_val, Val_int)
ML_2 (gtk_statusbar_pop, GtkStatusbar_val, Int_val, Unit)
ML_3 (gtk_statusbar_remove, GtkStatusbar_val, Int_val, Int_val, Unit)

/* gtkgamma.h */

#define GtkGammaCurve_val(val) GTK_GAMMA_CURVE(Pointer_val(val))
ML_0 (gtk_gamma_curve_new, Val_GtkWidget)
Make_Extractor (gtk_gamma_curve_get, GtkGammaCurve_val, gamma, copy_double)

/* gtkbutton.h */

#define GtkButton_val(val) GTK_BUTTON(Pointer_val(val))
ML_0 (gtk_button_new, Val_GtkWidget)
ML_1 (gtk_button_new_with_label, String_val, Val_GtkWidget)
ML_1 (gtk_button_pressed, GtkButton_val, Unit)
ML_1 (gtk_button_released, GtkButton_val, Unit)
ML_1 (gtk_button_clicked, GtkButton_val, Unit)
ML_1 (gtk_button_enter, GtkButton_val, Unit)
ML_1 (gtk_button_leave, GtkButton_val, Unit)

/* gtkoptionmenu.h */

#define GtkOptionMenu_val(val) GTK_OPTION_MENU(Pointer_val(val))
ML_0 (gtk_option_menu_new, Val_GtkWidget)
ML_1 (gtk_option_menu_get_menu, GtkOptionMenu_val, Val_GtkWidget)
ML_2 (gtk_option_menu_set_menu, GtkOptionMenu_val, GtkWidget_val, Unit)
ML_1 (gtk_option_menu_remove_menu, GtkOptionMenu_val, Unit)
ML_2 (gtk_option_menu_set_history, GtkOptionMenu_val, Int_val, Unit)

/* gtktogglebutton.h */

#define GtkToggleButton_val(val) GTK_TOGGLE_BUTTON(Pointer_val(val))
ML_0 (gtk_toggle_button_new, Val_GtkWidget)
ML_1 (gtk_toggle_button_new_with_label, String_val, Val_GtkWidget)
ML_2 (gtk_toggle_button_set_mode, GtkToggleButton_val, Bool_val, Unit)
ML_2 (gtk_toggle_button_set_state, GtkToggleButton_val, Bool_val, Unit)
ML_1 (gtk_toggle_button_toggled, GtkToggleButton_val, Unit)
Make_Extractor (GtkToggleButton, GtkToggleButton_val, active, Val_bool)

/* gtkcheckbutton.h */

#define GtkCheckButton_val(val) GTK_CHECK_BUTTON(Pointer_val(val))
ML_0 (gtk_check_button_new, Val_GtkWidget)
ML_1 (gtk_check_button_new_with_label, String_val, Val_GtkWidget)

/* gtkradiobutton.h */

#define GtkRadioButton_val(val) GTK_RADIO_BUTTON(Pointer_val(val))
ML_1 (gtk_radio_button_new, (GSList*), Val_GtkWidget)
ML_2 (gtk_radio_button_new_with_label, (GSList*), String_val, Val_GtkWidget)
ML_1 (gtk_radio_button_group, GtkRadioButton_val, (value))
ML_2 (gtk_radio_button_set_group, GtkRadioButton_val, (GSList*), Unit)

/* gtkclist.h */

#define GtkClist_val(val) GTK_CLIST(Pointer_val(val))
ML_1 (gtk_clist_new, Int_val, Val_GtkWidget)
ML_1 (gtk_clist_new_with_titles, Insert(Wosize_val(arg1)) (char **),
      Val_GtkWidget)
ML_2 (gtk_clist_set_border, GtkClist_val, Shadow_val, Unit)
ML_2 (gtk_clist_set_selection_mode, GtkClist_val, Selection_val, Unit)
ML_3 (gtk_clist_set_policy, GtkClist_val, Policy_val, Policy_val, Unit)
ML_1 (gtk_clist_freeze, GtkClist_val, Unit)
ML_1 (gtk_clist_thaw, GtkClist_val, Unit)
ML_1 (gtk_clist_column_titles_show, GtkClist_val, Unit)
ML_1 (gtk_clist_column_titles_hide, GtkClist_val, Unit)
ML_2 (gtk_clist_column_title_active, GtkClist_val, Int_val, Unit)
ML_2 (gtk_clist_column_title_passive, GtkClist_val, Int_val, Unit)
ML_1 (gtk_clist_column_titles_active, GtkClist_val, Unit)
ML_1 (gtk_clist_column_titles_passive, GtkClist_val, Unit)
ML_3 (gtk_clist_set_column_title, GtkClist_val, Int_val, String_val, Unit)
ML_3 (gtk_clist_set_column_widget, GtkClist_val, Int_val, GtkWidget_val, Unit)
ML_3 (gtk_clist_set_column_justification, GtkClist_val, Int_val,
      Justification_val, Unit)
ML_3 (gtk_clist_set_column_width, GtkClist_val, Int_val, Int_val, Unit)
ML_2 (gtk_clist_set_row_height, GtkClist_val, Int_val, Unit)
ML_5 (gtk_clist_moveto, GtkClist_val, Int_val, Int_val,
      Double_val, Double_val, Unit)
ML_2 (gtk_clist_row_is_visible, GtkClist_val, Int_val, Val_visibility)
ML_3 (gtk_clist_get_cell_type, GtkClist_val, Int_val, Int_val, Val_cell_type)
ML_4 (gtk_clist_set_text, GtkClist_val, Int_val, Int_val, String_val, Unit)
value ml_gtk_clist_get_text (value clist, value row, value column)
{
    char *text;
    if (!gtk_clist_get_text (GtkClist_val(clist), Int_val(row),
			     Int_val(column), &text))
	invalid_argument ("Gtk.Clist.get_text");
    return copy_string(text);
}
ML_5 (gtk_clist_set_pixmap, GtkClist_val, Int_val, Int_val, GdkPixmap_val,
      GdkBitmap_val, Unit)
value ml_gtk_clist_get_pixmap (value clist, value row, value column)
{
    GdkPixmap *pixmap;
    GdkBitmap *bitmap;
    value ret, vpixmap = Val_unit, vbitmap = Val_unit;
    if (!gtk_clist_get_pixmap (GtkClist_val(clist), Int_val(row),
			       Int_val(column), &pixmap, &bitmap))
	invalid_argument ("Gtk.Clist.get_pixmap");
    Begin_roots2 (vpixmap, vbitmap);
    vpixmap = Val_GdkPixmap(pixmap);
    vbitmap = Val_GdkBitmap(bitmap);
    ret = alloc_tuple (2);
    Field(ret,0) = vpixmap;
    Field(ret,1) = vbitmap;
    End_roots ();
    return ret;
}
ML_7 (gtk_clist_set_pixtext, GtkClist_val, Int_val, Int_val, String_val,
      Int_val, GdkPixmap_val, GdkBitmap_val, Unit)
ML_bc7 (ml_gtk_clist_set_pixtext)
value ml_gtk_clist_get_pixtext (value clist, value row, value column)
{
    char *text;
    guint8 spacing;
    GdkPixmap *pixmap;
    GdkBitmap *bitmap;
    value ret, vtext = Val_unit, vpixmap = Val_unit, vbitmap = Val_unit;
    if (!gtk_clist_get_pixtext (GtkClist_val(clist),
				Int_val(row), Int_val(column),
				&text, &spacing, &pixmap, &bitmap))
	invalid_argument ("Gtk.Clist.get_pixtext");
    Begin_roots2 (vpixmap, vbitmap);
    vtext = copy_string (text);
    vpixmap = Val_GdkPixmap(pixmap);
    vbitmap = Val_GdkBitmap(bitmap);
    ret = alloc_tuple (4);
    Field(ret,0) = vtext;
    Field(ret,1) = Val_int(spacing);
    Field(ret,2) = vpixmap;
    Field(ret,3) = vbitmap;
    End_roots ();
    return ret;
}
ML_3 (gtk_clist_set_foreground, GtkClist_val, Int_val, GdkColor_val, Unit)
ML_3 (gtk_clist_set_background, GtkClist_val, Int_val, GdkColor_val, Unit)
ML_5 (gtk_clist_set_shift, GtkClist_val, Int_val, Int_val, Int_val, Int_val,
      Unit)
ML_2 (gtk_clist_append, GtkClist_val, (char **), Val_int)
ML_3 (gtk_clist_insert, GtkClist_val, Int_val, (char **), Unit)
ML_2 (gtk_clist_remove, GtkClist_val, Int_val, Unit)
ML_3 (gtk_clist_select_row, GtkClist_val, Int_val, Int_val, Unit)
ML_3 (gtk_clist_unselect_row, GtkClist_val, Int_val, Int_val, Unit)
ML_1 (gtk_clist_clear, GtkClist_val, Unit)
value ml_gtk_clist_get_selection_info (value clist, value x, value y)
{
    int row, column;
    value ret;
    if (!gtk_clist_get_selection_info (GtkClist_val(clist), Int_val(x),
			     Int_val(y), &row, &column))
	invalid_argument ("Gtk.Clist.get_selection_info");
    ret = alloc_tuple (2);
    Field(ret,0) = row;
    Field(ret,1) = column;
    return ret;
}

/* gtkfixed.h */

#define GtkFixed_val(val) GTK_FIXED(Pointer_val(val))
ML_0 (gtk_fixed_new, Val_GtkWidget)
ML_4 (gtk_fixed_put, GtkFixed_val, GtkWidget_val, Int_val, Int_val, Unit)
ML_4 (gtk_fixed_move, GtkFixed_val, GtkWidget_val, Int_val, Int_val, Unit)

/* gtkmenushell.h */

#define GtkMenuShell_val(val) GTK_MENU_SHELL(Pointer_val(val))
ML_2 (gtk_menu_shell_append, GtkMenuShell_val, GtkWidget_val, Unit)
ML_2 (gtk_menu_shell_prepend, GtkMenuShell_val, GtkWidget_val, Unit)
ML_3 (gtk_menu_shell_insert, GtkMenuShell_val, GtkWidget_val, Int_val, Unit)
ML_1 (gtk_menu_shell_deactivate, GtkMenuShell_val, Unit)

/* gtkmenu.h */

#define GtkMenu_val(val) GTK_MENU(Pointer_val(val))
ML_0 (gtk_menu_new, Val_GtkWidget)
ML_5 (gtk_menu_popup, GtkMenu_val,
      Option_val(arg2, GtkWidget_val, NULL) Ignore,
      Option_val(arg3, GtkWidget_val, NULL) Ignore,
      Insert(NULL) Insert(NULL) Int_val, Int_val, Unit)
ML_1 (gtk_menu_popdown, GtkMenu_val, Unit)
ML_1 (gtk_menu_get_active, GtkMenu_val, Val_GtkWidget)
ML_2 (gtk_menu_set_active, GtkMenu_val, Int_val, Unit)
ML_2 (gtk_menu_set_accelerator_table, GtkMenu_val,
      GtkAcceleratorTable_val, Unit)
value ml_gtk_menu_attach_to_widget (value menu, value widget)
{
    gtk_menu_attach_to_widget (GtkMenu_val(menu), GtkWidget_val(widget), NULL);
    return Val_unit;
}
ML_1 (gtk_menu_get_attach_widget, GtkMenu_val, Val_GtkWidget)
ML_1 (gtk_menu_detach, GtkMenu_val, Unit)

/* gtkmenubar.h */

#define GtkMenuBar_val(val) GTK_MENU_BAR(Pointer_val(val))
ML_0 (gtk_menu_bar_new, Val_GtkWidget)

/* gtknotebook.h */

#define GtkNotebook_val(val) GTK_NOTEBOOK(Pointer_val(val))
ML_0 (gtk_notebook_new, Val_GtkWidget)
ML_5 (gtk_notebook_insert_page_menu, GtkNotebook_val, GtkWidget_val,
      GtkWidget_val, Option_val(arg4,GtkWidget_val,NULL) Ignore,
      Option_val(arg5,Int_val,-1) Ignore, Unit)
ML_2 (gtk_notebook_remove_page, GtkNotebook_val, Int_val, Unit)
ML_1 (gtk_notebook_current_page, GtkNotebook_val, Val_int)
ML_2 (gtk_notebook_set_page, GtkNotebook_val, Int_val, Unit)
ML_2 (gtk_notebook_set_tab_pos, GtkNotebook_val, Position_val, Unit)
ML_2 (gtk_notebook_set_show_tabs, GtkNotebook_val, Bool_val, Unit)
ML_2 (gtk_notebook_set_show_border, GtkNotebook_val, Bool_val, Unit)
ML_2 (gtk_notebook_set_scrollable, GtkNotebook_val, Bool_val, Unit)
ML_2 (gtk_notebook_set_tab_border, GtkNotebook_val, Int_val, Unit)
ML_1 (gtk_notebook_popup_enable, GtkNotebook_val, Unit)
ML_1 (gtk_notebook_popup_disable, GtkNotebook_val, Unit)

/* gtkpaned.h */

#define GtkPaned_val(val) GTK_PANED(Pointer_val(val))
ML_0 (gtk_hpaned_new, Val_GtkWidget)
ML_0 (gtk_vpaned_new, Val_GtkWidget)
ML_2 (gtk_paned_add1, GtkPaned_val, GtkWidget_val, Unit)
ML_2 (gtk_paned_add2, GtkPaned_val, GtkWidget_val, Unit)
ML_2 (gtk_paned_handle_size, GtkPaned_val, Int_val, Unit)
ML_2 (gtk_paned_gutter_size, GtkPaned_val, Int_val, Unit)

/* gtkscrolledwindow.h */

#define GtkScrolledWindow_val(val) GTK_SCROLLED_WINDOW(Pointer_val(val))
ML_2 (gtk_scrolled_window_new, Option_val(arg1,GtkAdjustment_val,NULL) Ignore,
      Option_val(arg2,GtkAdjustment_val,NULL) Ignore, Val_GtkWidget)
ML_1 (gtk_scrolled_window_get_hadjustment, GtkScrolledWindow_val,
      Val_GtkWidget)
ML_1 (gtk_scrolled_window_get_vadjustment, GtkScrolledWindow_val,
      Val_GtkWidget)
ML_3 (gtk_scrolled_window_set_policy, GtkScrolledWindow_val,
      Policy_val, Policy_val, Unit)

/* gtktable.h */

#define GtkTable_val(val) GTK_TABLE(Pointer_val(val))
ML_3 (gtk_table_new, Int_val, Int_val, Int_val, Val_GtkWidget)
ML_10 (gtk_table_attach, GtkTable_val, GtkWidget_val,
       Int_val, Int_val, Int_val, Int_val,
       Flags_Attach_val, Flags_Attach_val, Int_val, Int_val, Unit)
ML_bc10 (ml_gtk_table_attach)

/* gtktoolbar.h */

#define GtkToolbar_val(val) GTK_TOOLBAR(Pointer_val(val))
ML_2 (gtk_toolbar_new, Orientation_val, Toolbar_style_val, Val_GtkWidget)
ML_2 (gtk_toolbar_insert_space, GtkToolbar_val,
      Option_val (arg2, Int_val, -1) Ignore, Unit)
ML_7 (gtk_toolbar_insert_element, GtkToolbar_val,
      Option_val (arg1, Toolbar_child_val, GTK_TOOLBAR_CHILD_BUTTON) Ignore,
      Insert(NULL) String_option_val, String_option_val, String_option_val,
      Option_val (arg6, GtkWidget_val, NULL) Ignore,
      Insert(NULL) Insert(NULL) Option_val(arg7, Int_val, -1) Ignore,
      Val_GtkWidget)
ML_bc7 (ml_gtk_toolbar_insert_element)
ML_5 (gtk_toolbar_insert_widget, GtkToolbar_val, GtkWidget_val,
      String_option_val, String_option_val,
      Option_val (arg5, Int_val, -1) Ignore, Unit)

/* gtktree.h */

#define GtkTree_val(val) GTK_TREE(Pointer_val(val))
ML_0 (gtk_tree_new, Val_GtkWidget)
ML_3 (gtk_tree_insert, GtkTree_val, GtkWidget_val,
      Option_val (arg3, Int_val, -1) Ignore, Unit)
ML_3 (gtk_tree_clear_items, GtkTree_val, Int_val, Int_val, Unit)
ML_2 (gtk_tree_select_item, GtkTree_val, Int_val, Unit)
ML_2 (gtk_tree_unselect_item, GtkTree_val, Int_val, Unit)
ML_2 (gtk_tree_child_position, GtkTree_val, GtkWidget_val, Val_int)
ML_2 (gtk_tree_set_selection_mode, GtkTree_val, Selection_val, Unit)
ML_2 (gtk_tree_set_view_mode, GtkTree_val, Tree_view_mode_val, Unit)
ML_2 (gtk_tree_set_view_lines, GtkTree_val, Bool_val, Unit)

/* gtkdrawingarea.h */
/*
#define GtkDrawingArea_val(val) GTK_DRAWING_AREA(Pointer_val(val))
ML_0 (gtk_drawing_area_new, Val_GtkWidget)
ML_3 (gtk_drawing_area_size, GtkTree_val, Int_val, Int_val, Unit)
*/

/* gtkeditable.h */

#define GtkEditable_val(val) GTK_EDITABLE(Pointer_val(val))
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
ML_2 (gtk_editable_cut_clipboard, GtkEditable_val, Int_val, Unit)
ML_2 (gtk_editable_copy_clipboard, GtkEditable_val, Int_val, Unit)
ML_2 (gtk_editable_paste_clipboard, GtkEditable_val, Int_val, Unit)
ML_3 (gtk_editable_claim_selection, GtkEditable_val, Bool_val, Int_val, Unit)
ML_1 (gtk_editable_delete_selection, GtkEditable_val, Unit)
ML_1 (gtk_editable_changed, GtkEditable_val, Unit)

/* gtkentry.h */

#define GtkEntry_val(val) GTK_ENTRY(Pointer_val(val))
ML_0 (gtk_entry_new, Val_GtkWidget)
ML_1 (gtk_entry_new_with_max_length, Int_val, Val_GtkWidget)
ML_2 (gtk_entry_set_text, GtkEntry_val, String_val, Unit)
ML_2 (gtk_entry_append_text, GtkEntry_val, String_val, Unit)
ML_2 (gtk_entry_prepend_text, GtkEntry_val, String_val, Unit)
ML_2 (gtk_entry_set_position, GtkEntry_val, Int_val, Unit)
ML_1 (gtk_entry_get_text, GtkEntry_val, copy_string)
ML_3 (gtk_entry_select_region, GtkEntry_val, Int_val, Int_val, Unit)
ML_2 (gtk_entry_set_visibility, GtkEntry_val, Bool_val, Unit)
ML_2 (gtk_entry_set_editable, GtkEntry_val, Bool_val, Unit)
ML_2 (gtk_entry_set_max_length, GtkEntry_val, Bool_val, Unit)
Make_Extractor (GtkEntry, GtkEntry_val, text_length, Val_int)

/* gtkspinbutton.h */

#define GtkSpinButton_val(val) GTK_SPIN_BUTTON(Pointer_val(val))
ML_3 (gtk_spin_button_new, Option_val(arg1,GtkAdjustment_val,NULL) Ignore,
      Float_val, Int_val, Val_GtkWidget)
ML_2 (gtk_spin_button_set_adjustment, GtkSpinButton_val, GtkAdjustment_val,
      Unit)
ML_1 (gtk_spin_button_get_adjustment, GtkSpinButton_val, Val_GtkWidget)
ML_2 (gtk_spin_button_set_digits, GtkSpinButton_val, Int_val, Unit)
ML_1 (gtk_spin_button_get_value_as_float, GtkSpinButton_val, copy_double)
ML_2 (gtk_spin_button_set_value, GtkSpinButton_val, Float_val, Unit)
ML_2 (gtk_spin_button_set_update_policy, GtkSpinButton_val,
      Spin_button_update_policy_val, Unit)
ML_2 (gtk_spin_button_set_numeric, GtkSpinButton_val, Bool_val, Unit)
ML_3 (gtk_spin_button_spin, GtkSpinButton_val, Arrow_val, Float_val, Unit)
ML_2 (gtk_spin_button_set_wrap, GtkSpinButton_val, Bool_val, Unit)

/* gtktext.h */

#define GtkText_val(val) GTK_TEXT(Pointer_val(val))
ML_2 (gtk_text_new, Option_val(arg1,GtkAdjustment_val,NULL) Ignore,
      Option_val(arg2,GtkAdjustment_val,NULL) Ignore, Val_GtkWidget)
ML_2 (gtk_text_set_editable, GtkText_val, Bool_val, Unit)
ML_2 (gtk_text_set_word_wrap, GtkText_val, Bool_val, Unit)
ML_3 (gtk_text_set_adjustments, GtkText_val, GtkAdjustment_val,
      GtkAdjustment_val, Unit)
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

#define GtkMisc_val(val) GTK_MISC(Pointer_val(val))
ML_3 (gtk_misc_set_alignment, GtkMisc_val, Double_val, Double_val, Unit)
ML_3 (gtk_misc_set_padding, GtkMisc_val, Int_val, Int_val, Unit)

/* gtkarrow.h */

#define GtkArrow_val(val) GTK_ARROW(Pointer_val(val))
ML_2 (gtk_arrow_new, Arrow_val, Shadow_val, Val_GtkWidget)
ML_3 (gtk_arrow_set, GtkArrow_val, Arrow_val, Shadow_val, Unit)

/* gtkimage.h */

#define GtkImage_val(val) GTK_IMAGE(Pointer_val(val))
ML_2 (gtk_image_new, GdkImage_val,
      Option_val (arg2, GdkBitmap_val, NULL) Ignore, Val_GtkWidget)
ML_3 (gtk_image_set, GtkImage_val, GdkImage_val,
      Option_val (arg2, GdkBitmap_val, NULL) Ignore, Unit)

/* gtklabel.h */

#define GtkLabel_val(val) GTK_LABEL(Pointer_val(val))
ML_1 (gtk_label_new, String_val, Val_GtkWidget)
ML_2 (gtk_label_set, GtkLabel_val, String_val, Unit)
ML_2 (gtk_label_set_justify, GtkLabel_val, Justification_val, Unit)
Make_Extractor (GtkLabel, GtkLabel_val, label, copy_string)

/* gtktipsquery.h */

#define GtkTipsQuery_val(val) GTK_TIPS_QUERY(Pointer_val(val))
ML_0 (gtk_tips_query_new, Val_GtkWidget)
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
		copy_string)
Make_Extractor (gtk_tips_query_get, GtkTipsQuery_val, label_no_tip,
		copy_string)

/* gtkpixmap.h */

#define GtkPixmap_val(val) GTK_PIXMAP(Pointer_val(val))
ML_2 (gtk_pixmap_new, GdkPixmap_val, GdkBitmap_val, Val_GtkWidget)
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
ML_1 (gtk_preview_new, Preview_val, Val_GtkWidget)
ML_3 (gtk_preview_size, GtkPreview_val, Int_val, Int_val, Unit)
ML_9 (gtk_preview_put, GtkPreview_val, GdkWindow_val, GdkGC_val,
      Int_val, Int_val, Int_val, Int_val, Int_val, Int_val, Unit)
ML_bc9 (ml_gtk_preview_put)
*/

/* gtkprogressbar.h */

#define GtkProgressBar_val(val) GTK_PROGRESS_BAR(Pointer_val(val))
ML_0 (gtk_progress_bar_new, Val_GtkWidget)
ML_2 (gtk_progress_bar_update, GtkProgressBar_val, Float_val, Unit)
Make_Extractor (GtkProgressBar, GtkProgressBar_val, percentage, copy_double)

/* gtkrange.h */

#define GtkRange_val(val) GTK_RANGE(Pointer_val(val))
ML_1 (gtk_range_get_adjustment, GtkRange_val, Val_GtkWidget)
ML_2 (gtk_range_set_adjustment, GtkRange_val, GtkAdjustment_val, Unit)
ML_2 (gtk_range_set_update_policy, GtkRange_val, Update_val, Unit)

/* gtkscale.h */

#define GtkScale_val(val) GTK_SCALE(Pointer_val(val))
ML_2 (gtk_scale_set_digits, GtkScale_val, Int_val, Unit)
ML_2 (gtk_scale_set_draw_value, GtkScale_val, Bool_val, Unit)
ML_2 (gtk_scale_set_value_pos, GtkScale_val, Position_val, Unit)
ML_1 (gtk_scale_value_width, GtkScale_val, Val_int)
ML_1 (gtk_scale_draw_value, GtkScale_val, Unit)
ML_1 (gtk_hscale_new, GtkAdjustment_val, Val_GtkWidget)
ML_1 (gtk_vscale_new, GtkAdjustment_val, Val_GtkWidget)

/* gtkscrollbar.h */

ML_1 (gtk_hscrollbar_new, GtkAdjustment_val, Val_GtkWidget)
ML_1 (gtk_vscrollbar_new, GtkAdjustment_val, Val_GtkWidget)

/* gtkruler.h */

#define GtkRuler_val(val) GTK_RULER(Pointer_val(val))
ML_2 (gtk_ruler_set_metric, GtkRuler_val, Metric_val, Unit)
ML_5 (gtk_ruler_set_range, GtkRuler_val, Float_val,
      Float_val, Float_val, Float_val, Unit)
Make_Extractor (gtk_ruler_get, GtkRuler_val, lower, copy_double)
Make_Extractor (gtk_ruler_get, GtkRuler_val, upper, copy_double)
Make_Extractor (gtk_ruler_get, GtkRuler_val, position, copy_double)
Make_Extractor (gtk_ruler_get, GtkRuler_val, max_size, copy_double)
ML_1 (gtk_ruler_draw_ticks, GtkRuler_val, Unit)
ML_1 (gtk_ruler_draw_pos, GtkRuler_val, Unit)
ML_0 (gtk_hruler_new, Val_GtkWidget)
ML_0 (gtk_vruler_new, Val_GtkWidget)

/* gtk[hv]separator.h */

ML_0 (gtk_hseparator_new, Val_GtkWidget)
ML_0 (gtk_vseparator_new, Val_GtkWidget)

/* gtkmain.h */

value ml_gtk_init (value argv)
{
    int argc = Wosize_val(argv);
    value copy = alloc_shr (argc, Abstract_tag);
    value ret;
    int i;
    for (i = 0; i < argc; i++) Field(copy,i) = Field(argv,i);
    gtk_init (&argc, (char ***)&copy);
    ret = alloc_shr (argc, 0);
    Begin_root (ret);
    for (i = 0; i < argc; i++) initialize(&Field(ret,i), Field(copy,i));
    End_roots ();
    return ret;
}
ML_1 (gtk_exit, Int_val, Unit)
ML_0 (gtk_set_locale, copy_string)
ML_0 (gtk_main, Unit)
ML_1 (gtk_main_iteration_do, Bool_val, Val_bool)
ML_0 (gtk_main_quit, Unit)
ML_1 (gtk_grab_add, GtkWidget_val, Unit)
ML_1 (gtk_grab_remove, GtkWidget_val, Unit)
ML_0 (gtk_grab_get_current, Val_GtkWidget)
value ml_gtk_get_version (value unit)
{
    value ret = alloc_tuple(3);
    Field(ret,0) = gtk_major_version;
    Field(ret,1) = gtk_minor_version;
    Field(ret,0) = gtk_micro_version;
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
    return copy_string (GTK_VALUE_STRING(*arg));
}

value ml_gtk_arg_get_pointer (GtkArg *arg)
{
    switch (GTK_FUNDAMENTAL_TYPE(arg->type)) {
    case GTK_TYPE_BOXED:
	return (value) GTK_VALUE_BOXED(*arg);
    case GTK_TYPE_POINTER:
	return (value) GTK_VALUE_POINTER(*arg);
    default:
	ml_raise_gtk ("argument type mismatch");
    }
}

value ml_gtk_arg_get_object (GtkArg *arg)
{
    if (GTK_FUNDAMENTAL_TYPE(arg->type) != GTK_TYPE_OBJECT)
	ml_raise_gtk ("argument type mismatch");
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
	*GTK_RETLOC_BOXED(*arg) = (gpointer) val; break;
    case GTK_TYPE_POINTER:
	*GTK_RETLOC_POINTER(*arg) = (gpointer) val; break;
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
    return Val_int (gtk_signal_connect_interp
		    (GtkObject_val(object), String_val(name),
		     ml_gtk_callback_marshal, clos_p,
		     ml_gtk_callback_destroy, Bool_val(after)));
}

ML_2 (gtk_signal_disconnect, GtkObject_val, Int_val, Unit)

/* gtkmain.h (again) */

value ml_gtk_timeout_add (value interval, value clos)
{
    value *clos_p = stat_alloc (sizeof(value));
    *clos_p = clos;
    register_global_root (clos_p);
    return Val_int (gtk_timeout_add_interp
		    (Int_val(interval), ml_gtk_callback_marshal, clos_p,
		     ml_gtk_callback_destroy));
}
ML_1 (gtk_timeout_remove, Int_val, Unit)

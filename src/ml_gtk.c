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

value ml_get_null (value unit) { return 0L; }

value copy_string_and_free (char *str)
{
    value res = copy_string (str);
    g_free (str);
    return res;
}

/* conversion functions */

#include "gtk_tags.c"

Make_Flags_val (Attach_val)

/* gtkobject.h */

Make_Val_final_pointer(GtkObject, gtk_object_ref, gtk_object_unref)

/* gtkaccelerator.h */

#define GtkAcceleratorTable_val(val) ((GtkAcceleratorTable*)Pointer_val(val))
Make_Val_final_pointer (GtkAcceleratorTable, gtk_accelerator_table_ref, gtk_accelerator_table_unref)

ML_0 (gtk_accelerator_table_new, Val_GtkAcceleratorTable)

/* gtkstyle.h */

#define GtkStyle_val(val) ((GtkStyle*)Pointer_val(val))
Make_Val_final_pointer (GtkStyle, gtk_style_ref, gtk_style_unref)
ML_0 (gtk_style_new, Val_GtkStyle)
ML_1 (gtk_style_copy, GtkStyle_val, Val_GtkStyle)
ML_2 (gtk_style_attach, GtkStyle_val, GdkWindow_val, Val_GtkStyle)
ML_1 (gtk_style_detach, GtkStyle_val, Unit)
ML_3 (gtk_style_set_background, GtkStyle_val, GdkWindow_val, State_val, Unit)
ML_6 (gtk_draw_hline, GtkStyle_val, GdkWindow_val, State_val,
      Int_val, Int_val, Int_val, Unit)
ML_bc6 (ml_gtk_draw_hline)
ML_6 (gtk_draw_vline, GtkStyle_val, GdkWindow_val, State_val,
      Int_val, Int_val, Int_val, Unit)
ML_bc6 (ml_gtk_draw_vline)

value ml_GtkStyle_bg (value style, value state)
{
    return (value)&GtkStyle_val(style)->bg[State_val(state)];
}

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
ML_1 (gtk_widget_destroy, GtkWidget_val, Unit)
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
ML_2 (gtk_widget_event, GtkWidget_val, (GdkEvent*), Unit)
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

/* gtkbutton.h */

#define GtkButton_val(val) GTK_BUTTON(Pointer_val(val))
ML_0 (gtk_button_new, Val_GtkWidget)
ML_1 (gtk_button_new_with_label, String_val, Val_GtkWidget)
ML_1 (gtk_button_pressed, GtkButton_val, Unit)
ML_1 (gtk_button_released, GtkButton_val, Unit)
ML_1 (gtk_button_clicked, GtkButton_val, Unit)
ML_1 (gtk_button_enter, GtkButton_val, Unit)
ML_1 (gtk_button_leave, GtkButton_val, Unit)

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

/* gtktable.h */

#define GtkTable_val(val) GTK_TABLE(Pointer_val(val))
ML_3 (gtk_table_new, Int_val, Int_val, Int_val, Val_GtkWidget)
ML_10 (gtk_table_attach, GtkTable_val, GtkWidget_val,
       Int_val, Int_val, Int_val, Int_val,
       Flags_Attach_val, Flags_Attach_val, Int_val, Int_val, Unit)
ML_bc10 (ml_gtk_table_attach)

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

/* gtklabel.h */

#define GtkLabel_val(val) GTK_LABEL(Pointer_val(val))
ML_1 (gtk_label_new, String_val, Val_GtkWidget)
ML_2 (gtk_label_set, GtkLabel_val, String_val, Unit)
ML_2 (gtk_label_set_justify, GtkLabel_val, Justification_val, Unit)
Make_Extractor (GtkLabel, GtkLabel_val, label, copy_string)

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

/* gtkprogressbar.h */

#define GtkProgressBar_val(val) GTK_PROGRESS_BAR(Pointer_val(val))
ML_0 (gtk_progress_bar_new, Val_GtkWidget)
ML_2 (gtk_progress_bar_update, GtkProgressBar_val, Float_val, Unit)
Make_Extractor (GtkProgressBar, GtkProgressBar_val, percentage, copy_double)

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
    return (value) (args+Int_val(index));
}

value ml_gtk_arg_get_type (GtkArg *arg)
{
    return Val_int (arg->type);
}

value ml_gtk_arg_get_char (GtkArg *arg)
{
    if (arg->type != GTK_TYPE_CHAR)
	ml_raise_gtk ("argument type mismatch");
    return Val_char (GTK_VALUE_CHAR(*arg));
}

value ml_gtk_arg_get_bool (GtkArg *arg)
{
    if (arg->type != GTK_TYPE_BOOL)
	ml_raise_gtk ("argument type mismatch");
    return Val_bool (GTK_VALUE_BOOL(*arg));
}

value ml_gtk_arg_get_int (GtkArg *arg)
{
    switch (arg->type) {
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
    switch (arg->type) {
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
    if (arg->type != GTK_TYPE_STRING)
	ml_raise_gtk ("argument type mismatch");
    return copy_string (GTK_VALUE_STRING(*arg));
}

value ml_gtk_arg_get_pointer (GtkArg *arg)
{
    switch (arg->type) {
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
    if (arg->type != GTK_TYPE_CHAR)
	ml_raise_gtk ("argument type mismatch");
    *GTK_RETLOC_CHAR(*arg) = Char_val(val);
    return Val_unit;
}

value ml_gtk_arg_set_bool (GtkArg *arg, value val)
{
    if (arg->type != GTK_TYPE_BOOL)
	ml_raise_gtk ("argument type mismatch");
    *GTK_RETLOC_BOOL(*arg) = Bool_val(val);
    return Val_unit;
}

value ml_gtk_arg_set_int (GtkArg *arg, value val)
{
    switch (arg->type) {
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
    switch (arg->type) {
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
    if (arg->type != GTK_TYPE_STRING)
	ml_raise_gtk ("argument type mismatch");
    *GTK_RETLOC_STRING(*arg) = String_val(val);
    return Val_unit;
}

value ml_gtk_arg_set_pointer (GtkArg *arg, value val)
{
    switch (arg->type) {
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

/* $Id$ */

#include <string.h>
#include <gtk/gtk.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>
#include <caml/fail.h>

#include "wrappers.h"
#include "ml_glib.h"
#include "ml_gobject.h"
#include "ml_gdk.h"
#include "ml_gtk.h"
#include "gtk_tags.h"

static Make_Flags_val (Attach_options_val)

/* gtkbox.h */

#define GtkBox_val(val) check_cast(GTK_BOX,val)
ML_5 (gtk_box_pack_start, GtkBox_val, GtkWidget_val, Bool_val, Bool_val,
      Int_val, Unit)
ML_5 (gtk_box_pack_end, GtkBox_val, GtkWidget_val, Bool_val, Bool_val,
      Int_val, Unit)
ML_2 (gtk_box_set_homogeneous, GtkBox_val, Bool_val, Unit)
ML_2 (gtk_box_set_spacing, GtkBox_val, Int_val, Unit)
ML_1 (gtk_box_get_spacing, GtkBox_val, Val_int)
ML_3 (gtk_box_reorder_child, GtkBox_val, GtkWidget_val, Int_val, Unit)
CAMLprim value ml_gtk_box_query_child_packing (value box, value child)
{
    int expand, fill;
    unsigned int padding;
    GtkPackType pack_type;
    value ret;
    gtk_box_query_child_packing (GtkBox_val(box), GtkWidget_val(child),
				 &expand, &fill, &padding, &pack_type);
    ret = alloc_small(4,0);
    Field(ret,0) = Val_bool(expand);
    Field(ret,1) = Val_bool(fill);
    Field(ret,2) = Val_int(padding);
    Field(ret,3) = Val_pack_type(pack_type);
    return ret;
}
CAMLprim value ml_gtk_box_set_child_packing (value vbox, value vchild, value vexpand,
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
Make_Extractor (gtk_button_box_get, GtkButtonBox_val, child_min_width, Val_int)
Make_Extractor (gtk_button_box_get, GtkButtonBox_val, child_min_height,
		Val_int)
Make_Extractor (gtk_button_box_get, GtkButtonBox_val, child_ipad_x, Val_int)
Make_Extractor (gtk_button_box_get, GtkButtonBox_val, child_ipad_y, Val_int)
Make_Extractor (gtk_button_box_get, GtkButtonBox_val, layout_style,
		Val_button_box_style)
ML_3 (gtk_button_box_set_child_size, GtkButtonBox_val,
      Int_val, Int_val, Unit)
ML_3 (gtk_button_box_set_child_ipadding, GtkButtonBox_val,
      Int_val, Int_val, Unit)
ML_2 (gtk_button_box_set_layout, GtkButtonBox_val, Button_box_style_val, Unit)

ML_0 (gtk_hbutton_box_new, Val_GtkWidget_sink)
ML_0 (gtk_vbutton_box_new, Val_GtkWidget_sink)

/* gtkfixed.h */

#define GtkFixed_val(val) check_cast(GTK_FIXED,val)
ML_0 (gtk_fixed_new, Val_GtkWidget_sink)
ML_4 (gtk_fixed_put, GtkFixed_val, GtkWidget_val, (gint16)Long_val, (gint16)Long_val, Unit)
ML_4 (gtk_fixed_move, GtkFixed_val, GtkWidget_val, (gint16)Long_val, (gint16)Long_val, Unit)
ML_2 (gtk_fixed_set_has_window, GtkFixed_val, Int_val, Unit)
ML_1 (gtk_fixed_get_has_window, GtkFixed_val, Val_bool)

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
/*
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
CAMLprim value ml_gtk_packer_set_defaults (value w, value border_width,
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
*/

/* gtkpaned.h */

#define GtkPaned_val(val) check_cast(GTK_PANED,val)
ML_0 (gtk_hpaned_new, Val_GtkWidget_sink)
ML_0 (gtk_vpaned_new, Val_GtkWidget_sink)
ML_2 (gtk_paned_add1, GtkPaned_val, GtkWidget_val, Unit)
ML_2 (gtk_paned_add2, GtkPaned_val, GtkWidget_val, Unit)
ML_2 (gtk_paned_set_position, GtkPaned_val, Int_val, Unit)
ML_4 (gtk_paned_pack1, GtkPaned_val, GtkWidget_val, Int_val, Int_val, Unit)
ML_4 (gtk_paned_pack2, GtkPaned_val, GtkWidget_val, Int_val, Int_val, Unit)
Make_Extractor (gtk_paned, GtkPaned_val, child1, Val_GtkWidget)
Make_Extractor (gtk_paned, GtkPaned_val, child2, Val_GtkWidget)

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

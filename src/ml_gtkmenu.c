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

/* gtkmenuitem.h */

#define GtkMenuItem_val(val) check_cast(GTK_MENU_ITEM,val)
ML_0 (gtk_menu_item_new, Val_GtkWidget_sink)
ML_0 (gtk_tearoff_menu_item_new, Val_GtkWidget_sink)
ML_1 (gtk_menu_item_new_with_label, String_val, Val_GtkWidget_sink)
ML_2 (gtk_menu_item_set_submenu, GtkMenuItem_val, GtkWidget_val, Unit)
ML_1 (gtk_menu_item_remove_submenu, GtkMenuItem_val, Unit)
/*
ML_2 (gtk_menu_item_set_placement, GtkMenuItem_val,
      Submenu_placement_val, Unit)
ML_3 (gtk_menu_item_configure, GtkMenuItem_val, Bool_val, Bool_val, Unit)
*/
ML_1 (gtk_menu_item_activate, GtkMenuItem_val, Unit)
ML_2 (gtk_menu_item_set_right_justified, GtkMenuItem_val, Bool_val, Unit)
ML_1 (gtk_menu_item_get_right_justified, GtkMenuItem_val, Val_bool)

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

#define GtkRadioMenuItem_val(val) check_cast(GTK_RADIO_MENU_ITEM,val)
static GSList* item_group_val(value val)
{
    return (val == Val_unit ? NULL :
            gtk_radio_menu_item_group(GtkRadioMenuItem_val(Field(val,0))));
}
ML_1 (gtk_radio_menu_item_new, item_group_val, Val_GtkWidget_sink)
ML_2 (gtk_radio_menu_item_new_with_label, item_group_val,
      String_val, Val_GtkWidget_sink)
ML_2 (gtk_radio_menu_item_set_group, GtkRadioMenuItem_val,
      item_group_val, Unit)

/* gtkoptionmenu.h */

#define GtkOptionMenu_val(val) check_cast(GTK_OPTION_MENU,val)
ML_0 (gtk_option_menu_new, Val_GtkWidget_sink)
ML_1 (gtk_option_menu_get_menu, GtkOptionMenu_val, Val_GtkWidget_sink)
ML_2 (gtk_option_menu_set_menu, GtkOptionMenu_val, GtkWidget_val, Unit)
ML_1 (gtk_option_menu_remove_menu, GtkOptionMenu_val, Unit)
ML_2 (gtk_option_menu_set_history, GtkOptionMenu_val, Int_val, Unit)

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
      Insert(NULL) Insert(NULL) Int_val, Int32_val, Unit)
ML_1 (gtk_menu_popdown, GtkMenu_val, Unit)
ML_1 (gtk_menu_get_active, GtkMenu_val, Val_GtkWidget)
ML_2 (gtk_menu_set_active, GtkMenu_val, Int_val, Unit)
ML_2 (gtk_menu_set_accel_group, GtkMenu_val, GtkAccelGroup_val, Unit)
ML_1 (gtk_menu_get_accel_group, GtkMenu_val, Val_GtkAccelGroup)
CAMLprim value ml_gtk_menu_attach_to_widget (value menu, value widget)
{
    gtk_menu_attach_to_widget (GtkMenu_val(menu), GtkWidget_val(widget), NULL);
    return Val_unit;
}
ML_1 (gtk_menu_get_attach_widget, GtkMenu_val, Val_GtkWidget)
ML_1 (gtk_menu_detach, GtkMenu_val, Unit)

/* gtkmenubar.h */

#define GtkMenuBar_val(val) check_cast(GTK_MENU_BAR,val)
ML_0 (gtk_menu_bar_new, Val_GtkWidget_sink)

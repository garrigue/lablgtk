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
#include "ml_gdk.h"
#include "ml_gtk.h"
#include "gtk_tags.h"

/* gtkbutton.h */

#define GtkButton_val(val) check_cast(GTK_BUTTON,val)
ML_0 (gtk_button_new, Val_GtkWidget_sink)
ML_1 (gtk_button_new_with_label, String_val, Val_GtkWidget_sink)
ML_1 (gtk_button_pressed, GtkButton_val, Unit)
ML_1 (gtk_button_released, GtkButton_val, Unit)
ML_1 (gtk_button_clicked, GtkButton_val, Unit)
ML_1 (gtk_button_enter, GtkButton_val, Unit)
ML_1 (gtk_button_leave, GtkButton_val, Unit)
ML_2 (gtk_button_set_relief, GtkButton_val, Relief_style_val, Unit)
ML_1 (gtk_button_get_relief, GtkButton_val, Val_relief_style)

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
static GSList* button_group_val(value val)
{
    return (val == Val_unit ? NULL :
            gtk_radio_button_group(GtkRadioButton_val(Field(val,0))));
}
ML_1 (gtk_radio_button_new, button_group_val,
      Val_GtkWidget_sink)
ML_2 (gtk_radio_button_new_with_label, button_group_val,
      String_val, Val_GtkWidget_sink)
ML_2 (gtk_radio_button_set_group, GtkRadioButton_val, button_group_val, Unit)

/* gtktoolbar.h */

#define GtkToolbar_val(val) check_cast(GTK_TOOLBAR,val)
ML_2 (gtk_toolbar_new, Orientation_val, Toolbar_style_val, Val_GtkWidget_sink)
ML_2 (gtk_toolbar_insert_space, GtkToolbar_val, Int_val, Unit)
ML_7 (gtk_toolbar_insert_element, GtkToolbar_val, Toolbar_child_val,
      Insert(NULL) Optstring_val, Optstring_val, Optstring_val, GtkWidget_val,
      Insert(NULL) Insert(NULL) Int_val, Val_GtkWidget)
ML_bc7 (ml_gtk_toolbar_insert_element)
ML_5 (gtk_toolbar_insert_widget, GtkToolbar_val, GtkWidget_val,
      Optstring_val, Optstring_val, Int_val, Unit)
ML_2 (gtk_toolbar_set_orientation, GtkToolbar_val, Orientation_val, Unit)
ML_2 (gtk_toolbar_set_style, GtkToolbar_val, Toolbar_style_val, Unit)
ML_2 (gtk_toolbar_set_space_size, GtkToolbar_val, Int_val, Unit)
ML_2 (gtk_toolbar_set_space_style, GtkToolbar_val, Toolbar_space_style_val, Unit)
ML_2 (gtk_toolbar_set_tooltips, GtkToolbar_val, Bool_val, Unit)
ML_2 (gtk_toolbar_set_button_relief, GtkToolbar_val, Relief_style_val, Unit)
ML_1 (gtk_toolbar_get_button_relief, GtkToolbar_val, Val_relief_style)

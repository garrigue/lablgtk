/* $Id$ */

#include <gtk/gtk.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>

#include "wrappers.h"
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

#include "gtk_tags.c"

inline value Val_pointer (void *p)
{
    value ret = alloc_shr (2, Abstract_tag);
    initialize (&Field(ret,1), (value) p);
    return ret;
}

Make_Val_final_pointer(GtkObject, gtk_object_ref, gtk_object_unref)
Make_Val_final_pointer(GdkColormap, gdk_colormap_ref, gdk_colormap_unref)

/* gtkaccelerator.h */

#define GtkAcceleratorTable_val(val) ((GtkAcceleratorTable*)Pointer_val(val))
Make_Val_final_pointer (GtkAcceleratorTable, gtk_accelerator_table_ref, gtk_accelerator_table_unref)

ML_0 (gtk_accelerator_table_new, Val_GtkAcceleratorTable)

/* gtktypeutils.h */

ML_1 (gtk_type_name, Int_val, copy_string)
ML_1 (gtk_type_from_name, String_val, Val_int)
ML_1 (gtk_type_parent, Int_val, Val_int)
ML_1 (gtk_type_class, Int_val, (value))
ML_1 (gtk_type_parent_class, Int_val, (value))
ML_2 (gtk_type_is_a, Int_val, Int_val, Val_bool)

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

/* gtkwidget.h */

#define GtkWidget_val(val) GTK_WIDGET(Pointer_val(val))
#define Val_GtkWidget(w) Val_GtkObject((GtkObject*)w)
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
    
/* gtkbutton.h */

#define GtkButton_val(val) GTK_BUTTON(Pointer_val(val))
ML_0 (gtk_button_new, Val_GtkWidget)
ML_1 (gtk_button_new_with_label, String_val, Val_GtkWidget)
ML_1 (gtk_button_pressed, GtkButton_val, Unit)
ML_1 (gtk_button_released, GtkButton_val, Unit)
ML_1 (gtk_button_clicked, GtkButton_val, Unit)
ML_1 (gtk_button_enter, GtkButton_val, Unit)
ML_1 (gtk_button_leave, GtkButton_val, Unit)

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

/* gtksignal.h */

void ml_gtk_callback_marshal (GtkObject *object, gpointer data,
			       guint nargs, GtkArg *args)
{
    int i;
    value ret = Val_unit, last = Val_unit, aux;

    Begin_roots2 (ret, last);
    for (i = nargs-1; i >= 0; i--) {
	switch (GTK_FUNDAMENTAL_TYPE(args[i].type)) {
	case GTK_TYPE_INVALID:
	    ret = Val_int(0); break;
	case GTK_TYPE_NONE:
	    ret = Val_int(1); break;
	case GTK_TYPE_CHAR:
	    ret = alloc (1, 0);
	    Field(ret,0) = Val_char (GTK_VALUE_CHAR(args[i]));
	    break;
	case GTK_TYPE_BOOL:
	    ret = alloc (1, 1);
	    Field(ret,0) = Val_bool (GTK_VALUE_BOOL(args[i]));
	    break;
	case GTK_TYPE_INT:
	case GTK_TYPE_UINT:
	    ret = alloc (1, 2);
	    Field(ret,0) = Val_int (GTK_VALUE_INT(args[i]));
	    break;
	case GTK_TYPE_LONG:
	case GTK_TYPE_ULONG:
	    ret = alloc (1, 2);
	    Field(ret,0) = Val_long (GTK_VALUE_LONG(args[i]));
	    break;
	case GTK_TYPE_FLOAT:
	    ret = alloc (1, 3);
	    aux = copy_double ((double)GTK_VALUE_FLOAT(args[i]));
	    Field(ret,0) = aux;
	    break;
	case GTK_TYPE_DOUBLE:
	    ret = alloc (1, 3);
	    aux = copy_double (GTK_VALUE_DOUBLE(args[i]));
	    Field(ret,0) = aux;
	    break;
	case GTK_TYPE_STRING:
	    ret = alloc (1, 4);
	    aux = copy_string (GTK_VALUE_STRING(args[i]));
	    Field(ret,0) = aux;
	    break;
	case GTK_TYPE_ENUM:
	    ret = alloc (1, 5);
	    Field(ret,0) = Val_int (GTK_VALUE_INT(args[i]));
	    break;
	case GTK_TYPE_FLAGS:
	    ret = alloc (1, 6);
	    Field(ret,0) = Val_int (GTK_VALUE_INT(args[i]));
	    break;
	case GTK_TYPE_BOXED:
	    ret = alloc (1, 7);
	    Field(ret,0) = (value) (GTK_VALUE_BOXED(args[i]));
	    break;
  	case GTK_TYPE_POINTER:
	    ret = alloc (1, 8);
	    Field(ret,0) = (value) (GTK_VALUE_POINTER(args[i]));
	    break;
	case GTK_TYPE_OBJECT:
	    ret = alloc (1, 9);
	    aux = Val_GtkObject (GTK_VALUE_OBJECT(args[i]));
	    Field(ret,0) = aux;
	    break;
	case GTK_TYPE_FOREIGN:
	case GTK_TYPE_CALLBACK:
	case GTK_TYPE_ARGS:
	case GTK_TYPE_SIGNAL:
	case GTK_TYPE_C_CALLBACK:
	    ret = Val_int(2); break;
	}
	aux = alloc_tuple(2);
	Field(aux,0) = ret;
	Field(aux,1) = last;
	last = aux;
    }
    End_roots ();

    ret = callback (*(value*)data, last);

    if (Is_long(ret))
	switch (GTK_FUNDAMENTAL_TYPE(args[nargs].type)) {
	case GTK_TYPE_INVALID:
	case GTK_TYPE_NONE:
	    break;
	default:
	    ml_raise_gtk ("ml_gtk_callback_marshall : invalid return value");
	}
    else {
	int type = Tag_val(ret);
	ret = Field(ret,0);
	switch (GTK_FUNDAMENTAL_TYPE(args[nargs].type)) {
	case GTK_TYPE_CHAR:
	    if (type != 0)
		ml_raise_gtk ("ml_gtk_callback_marshall : unexpected type");
	    GTK_VALUE_CHAR(args[nargs]) = Char_val(ret);
	    break;
	case GTK_TYPE_BOOL:
	    if (type != 1)
		ml_raise_gtk ("ml_gtk_callback_marshall : unexpected type");
	    GTK_VALUE_BOOL(args[nargs]) = Bool_val(ret);
	    break;
	case GTK_TYPE_INT:
	case GTK_TYPE_UINT:
	    if (type != 2)
		ml_raise_gtk ("ml_gtk_callback_marshall : unexpected type");
	    GTK_VALUE_INT(args[nargs]) = Int_val(ret);
	    break;
	case GTK_TYPE_LONG:
	case GTK_TYPE_ULONG:
	    if (type != 2)
		ml_raise_gtk ("ml_gtk_callback_marshall : unexpected type");
	    GTK_VALUE_LONG(args[nargs]) = Long_val(ret);
	    break;
	case GTK_TYPE_FLOAT:
	    if (type != 3)
		ml_raise_gtk ("ml_gtk_callback_marshall : unexpected type");
	    GTK_VALUE_FLOAT(args[nargs]) = (float)Double_val(ret);
	    break;
	case GTK_TYPE_DOUBLE:
	    if (type != 3)
		ml_raise_gtk ("ml_gtk_callback_marshall : unexpected type");
	    GTK_VALUE_DOUBLE(args[nargs]) = Double_val(ret);
	    break;
	case GTK_TYPE_STRING:
	    if (type != 4)
		ml_raise_gtk ("ml_gtk_callback_marshall : unexpected type");
	    /* Memory leak
	    aux = (char *) stat_alloc(string_length(ret));
	    */
	    GTK_VALUE_STRING(args[nargs]) = String_val(ret);
	    break;
	case GTK_TYPE_ENUM:
	    if (type != 5)
		ml_raise_gtk ("ml_gtk_callback_marshall : unexpected type");
	    GTK_VALUE_ENUM(args[nargs]) = Int_val(ret);
	    break;
	case GTK_TYPE_FLAGS:
	    if (type != 6)
		ml_raise_gtk ("ml_gtk_callback_marshall : unexpected type");
	    GTK_VALUE_FLAGS(args[nargs]) = Int_val(ret);
	    break;
	case GTK_TYPE_BOXED:
	    if (type != 7)
		ml_raise_gtk ("ml_gtk_callback_marshall : unexpected type");
	    GTK_VALUE_BOXED(args[nargs]) = (gpointer)ret;
	    break;
	case GTK_TYPE_POINTER:
	    if (type != 8)
		ml_raise_gtk ("ml_gtk_callback_marshall : unexpected type");
	    GTK_VALUE_POINTER(args[nargs]) = (gpointer)ret;
	    break;
	case GTK_TYPE_OBJECT:
	    if (type != 9)
		ml_raise_gtk ("ml_gtk_callback_marshall : unexpected type");
	    if (GTK_OBJECT_TYPE(GtkObject_val(ret)) != args[nargs].type)
		ml_raise_gtk ("ml_gtk_callback_marshall : bad object type");
	    GTK_VALUE_OBJECT(args[nargs]) = GtkObject_val(ret);
	    break;
	default:
	    ml_raise_gtk ("ml_gtk_callback_marshall : type not implemented");
	}
    }
}

void ml_gtk_callback_destroy (gpointer data)
{
    remove_global_root ((value *)data);
    stat_free (data);
}

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

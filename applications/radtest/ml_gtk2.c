/* $Id$ */

#include <gtk/gtk.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>
#include <caml/fail.h>

#include "../../wrappers.h"
#include "../../ml_glib.h"
#include "../../ml_gdk.h"
#include "../../ml_gtk.h"
#include "../../gtk_tags.h"

#include "gtktree2.h"
#include "gtktreeitem2.h"


/* conversion functions */
/*
#include "../../gtk_tags.c"
*/

/* gtkobject.h */
/*
Make_Val_final_pointer(GtkObject, , gtk_object_ref, gtk_object_unref)

#define gtk_object_ref_and_sink(w) (gtk_object_ref(w), gtk_object_sink(w))
Make_Val_final_pointer(GtkObject, _sink , gtk_object_ref_and_sink,
		       gtk_object_unref)
*/
#define Val_GtkAny(w) Val_GtkObject((GtkObject*)w)
#define Val_GtkAny_sink(w) Val_GtkObject_sink((GtkObject*)w)

#define GtkWidget_val(val) check_cast(GTK_WIDGET,val)

/* gtkwidget.h */

#define Val_GtkWidget Val_GtkAny
#define Val_GtkWidget_sink Val_GtkAny_sink


/* gtktreeitem2.h */

#define GtkTreeItem2_val(val) check_cast(GTK_TREE_ITEM2,val)
ML_0 (gtk_tree_item2_new, Val_GtkWidget_sink)
ML_1 (gtk_tree_item2_new_with_label, String_val, Val_GtkWidget_sink)
ML_2 (gtk_tree_item2_set_subtree, GtkTreeItem2_val, GtkWidget_val, Unit)
ML_1 (gtk_tree_item2_remove_subtree, GtkTreeItem2_val, Unit)
ML_1 (gtk_tree_item2_expand, GtkTreeItem2_val, Unit)
ML_1 (gtk_tree_item2_collapse, GtkTreeItem2_val, Unit)
ML_1 (GTK_TREE_ITEM2_SUBTREE, GtkTreeItem2_val, Val_GtkWidget)

/* gtktree2.h */

#define GtkTree2_val(val) check_cast(GTK_TREE2,val)
ML_0 (gtk_tree2_new, Val_GtkWidget_sink)
ML_3 (gtk_tree2_insert, GtkTree2_val, GtkWidget_val, Int_val, Unit)
ML_3 (gtk_tree2_clear_items, GtkTree2_val, Int_val, Int_val, Unit)
ML_2 (gtk_tree2_select_item, GtkTree2_val, Int_val, Unit)
ML_2 (gtk_tree2_unselect_item, GtkTree2_val, Int_val, Unit)
ML_2 (gtk_tree2_child_position, GtkTree2_val, GtkWidget_val, Val_int)

/*
ML_2 (gtk_tree2_set_selection_mode, GtkTree2_val, Selection_mode_val, Unit)
ML_2 (gtk_tree2_set_view_mode, GtkTree2_val, Tree_view_mode_val, Unit)
*/

ML_2 (gtk_tree2_set_view_lines, GtkTree2_val, Bool_val, Unit)

static value val_gtkany (gpointer p) { return Val_GtkAny(p); }
value ml_gtk_tree2_selection (value tree)
{
  GList *selection = GTK_TREE2_SELECTION(GtkTree2_val(tree));
  return Val_GList(selection, val_gtkany);
}
static gpointer gtkobject_val (value val) { return GtkObject_val(val); }
value ml_gtk_tree2_remove_items (value tree, value items)
{
  GList *items_list = GList_val (items, gtkobject_val);
  gtk_tree2_remove_items (GtkTree2_val(tree), items_list);
  return Val_unit;
}

value ml_gtk_tree2_children (value tree)
{
  GList *children = (GtkTree2_val(tree))->children;
  return Val_GList(children, val_gtkany);
}


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

/* gtktreeitem.h */

#define GtkTreeItem_val(val) check_cast(GTK_TREE_ITEM,val)
ML_0 (gtk_tree_item_new, Val_GtkWidget_sink)
ML_1 (gtk_tree_item_new_with_label, String_val, Val_GtkWidget_sink)
ML_2 (gtk_tree_item_set_subtree, GtkTreeItem_val, GtkWidget_val, Unit)
ML_1 (gtk_tree_item_remove_subtree, GtkTreeItem_val, Unit)
ML_1 (gtk_tree_item_expand, GtkTreeItem_val, Unit)
ML_1 (gtk_tree_item_collapse, GtkTreeItem_val, Unit)
ML_1 (GTK_TREE_ITEM_SUBTREE, GtkTreeItem_val, Val_GtkWidget)

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
CAMLprim value ml_gtk_tree_selection (value tree)
{
  GList *selection = GTK_TREE_SELECTION(GtkTree_val(tree));
  return Val_GList(selection, val_gtkany);
}
static gpointer gtkobject_val (value val) { return GtkObject_val(val); }
CAMLprim value ml_gtk_tree_remove_items (value tree, value items)
{
  GList *items_list = GList_val (items, gtkobject_val);
  gtk_tree_remove_items (GtkTree_val(tree), items_list);
  return Val_unit;
}

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

#include <stdio.h>

value Val_GtkObject_sink (GtkObject *);

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
ML_2 (gtk_tree2_select_child, GtkTree2_val, GtkWidget_val, Unit)
ML_2 (gtk_tree2_unselect_child, GtkTree2_val, GtkWidget_val, Unit)
ML_2 (gtk_tree2_child_position, GtkTree2_val, GtkWidget_val, Val_int)

/*
ML_2 (gtk_tree2_set_selection_mode, GtkTree2_val, Selection_mode_val, Unit)
ML_2 (gtk_tree2_set_view_mode, GtkTree2_val, Tree_view_mode_val, Unit)
*/

ML_2 (gtk_tree2_set_view_lines, GtkTree2_val, Bool_val, Unit)
ML_2 (gtk_tree2_item_up, GtkTree2_val, Int_val, Unit)
ML_3 (gtk_tree2_select_next_child, GtkTree2_val, GtkWidget_val, Bool_val, Unit)
ML_2 (gtk_tree2_select_prev_child, GtkTree2_val, GtkWidget_val, Unit)

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



#define GtkToolbar_val(val) check_cast(GTK_TOOLBAR,val)
value ml_gtk_toolbar2_set_text (value toolbar, value text, value pos)
{
  GtkToolbar *t = GtkToolbar_val(toolbar);
  gpointer ch = g_list_nth_data (t->children, Int_val(pos));
  gtk_label_set_text (GTK_LABEL(((GtkToolbarChild *)ch)->label),
		      String_val(text));
  return Val_unit;
}

value ml_gtk_toolbar2_set_icon (value toolbar, value icon, value pos)
{
  GtkToolbar *t = GtkToolbar_val(toolbar);
  GtkToolbarChild * ch =
    (GtkToolbarChild *)g_list_nth_data (t->children, Int_val(pos));
  GtkWidget *vbox = GTK_BIN(ch->widget)->child;
  gtk_container_remove (GTK_CONTAINER(vbox), ch->icon);
  ch->icon = GtkWidget_val(icon);
  gtk_box_pack_end (GTK_BOX (vbox), ch->icon, FALSE, FALSE, 0);
  if (t->style != GTK_TOOLBAR_TEXT)
    gtk_widget_show (ch->icon);
  
  return Val_unit;
}

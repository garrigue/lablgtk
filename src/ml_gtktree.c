/* $Id$ */

/* GtkTree is obsolete, but we keep it for a while */

#define GTK_ENABLE_BROKEN 1

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

#define Tree_view_mode_val(val) \
  (val == MLTAG_ITEM ? GTK_TREE_VIEW_ITEM : GTK_TREE_VIEW_LINE)

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
  GList *selection = GTK_TREE_SELECTION_OLD(GtkTree_val(tree));
  return Val_GList(selection, val_gtkany);
}
static gpointer gtkobject_val (value val) { return GtkObject_val(val); }
CAMLprim value ml_gtk_tree_remove_items (value tree, value items)
{
  GList *items_list = GList_val (items, gtkobject_val);
  gtk_tree_remove_items (GtkTree_val(tree), items_list);
  return Val_unit;
}

/* gtktreemodel.h */

/* "Lighter" version: allocate in the ocaml heap */
#define GtkTreeIter_val(val) ((GtkTreeIter*)MLPointer_val(val))
#define Val_GtkTreeIter(it) (copy_memblock_indirected(it,sizeof(GtkTreeIter)))
CAMLprim value ml_gtk_tree_iter_copy (value it) {
  /* Only valid if in old generation and compaction off */
  return Val_GtkTreeIter(GtkTreeIter_val(it));
}
CAMLprim value ml_alloc_GtkTreeIter(value v) {
  return alloc_memblock_indirected(sizeof(GtkTreeIter));
}

#define GtkTreeModel_val(val) check_cast(GTK_TREE_MODEL,val)

Make_Val_final_pointer (GtkTreePath, Ignore, gtk_tree_path_free, 1)
#define Val_GtkTreePath_copy(p) (Val_GtkTreePath(gtk_tree_path_copy(p)))
#define GtkTreePath_val(val) ((GtkTreePath*)Pointer_val(val))

Make_Val_final_pointer (GtkTreeRowReference, Ignore,
                        gtk_tree_row_reference_free, 5)
#define GtkTreeRowReference_val(val) ((GtkTreeRowReference*)Pointer_val(val))

/* TreePath */
ML_0 (gtk_tree_path_new, Val_GtkTreePath)
ML_1 (gtk_tree_path_to_string, GtkTreePath_val, copy_string_g_free)
ML_2 (gtk_tree_path_append_index, GtkTreePath_val, Int_val, Unit)
ML_2 (gtk_tree_path_prepend_index, GtkTreePath_val, Int_val, Unit)
ML_1 (gtk_tree_path_get_depth, GtkTreePath_val, Val_int)
CAMLprim value ml_gtk_tree_path_get_indices(value p)
{
  gint *indices = gtk_tree_path_get_indices(GtkTreePath_val(p));
  gint i, depth = gtk_tree_path_get_depth(GtkTreePath_val(p));
  value ret = alloc_tuple(depth);
  for (i = 0; i < depth; i++) Field(ret,i) = Val_int(indices[i]);
  return ret;
} 
ML_1 (gtk_tree_path_copy, GtkTreePath_val, Val_GtkTreePath)
ML_1 (gtk_tree_path_next, GtkTreePath_val, Unit)
ML_1 (gtk_tree_path_prev, GtkTreePath_val, Unit)
ML_1 (gtk_tree_path_up, GtkTreePath_val, Val_bool)
ML_1 (gtk_tree_path_down, GtkTreePath_val, Unit)
ML_2 (gtk_tree_path_is_ancestor, GtkTreePath_val, GtkTreePath_val, Val_bool)

/* RowReference */
ML_2 (gtk_tree_row_reference_new, GtkTreeModel_val, GtkTreePath_val,
      Val_GtkTreeRowReference)
ML_1 (gtk_tree_row_reference_valid, GtkTreeRowReference_val, Val_bool)
ML_1 (gtk_tree_row_reference_get_path, GtkTreeRowReference_val,
      Val_GtkTreePath) /* already copied! */

/* TreeModel */
ML_1 (gtk_tree_model_get_n_columns, GtkTreeModel_val, Val_int)
ML_2 (gtk_tree_model_get_column_type, GtkTreeModel_val, Int_val, Val_GType)
ML_3 (gtk_tree_model_get_iter, GtkTreeModel_val, GtkTreeIter_val,
      GtkTreePath_val, Val_bool)
ML_2 (gtk_tree_model_get_path, GtkTreeModel_val, GtkTreeIter_val,
      Val_GtkTreePath)
ML_4 (gtk_tree_model_get_value, GtkTreeModel_val, GtkTreeIter_val, Int_val,
      GValue_val, Unit)
ML_2 (gtk_tree_model_iter_next, GtkTreeModel_val, GtkTreeIter_val,
      Val_bool)
ML_3 (gtk_tree_model_iter_children, GtkTreeModel_val, GtkTreeIter_val,
      GtkTreeIter_val, Val_bool)
ML_2 (gtk_tree_model_iter_n_children, GtkTreeModel_val, GtkTreeIter_val,
      Val_int)
ML_3 (gtk_tree_model_iter_parent, GtkTreeModel_val, GtkTreeIter_val,
      GtkTreeIter_val, Val_bool)

/* gtktreestore.h */

#define GtkTreeStore_val(val) check_cast(GTK_TREE_STORE,val)
CAMLprim value ml_gtk_tree_store_newv(value arr)
{
  CAMLparam1(arr);
  int n_columns = Wosize_val(arr);
  int i;
  GType *types = (GType*)
    alloc (Wosize_asize(n_columns * sizeof(GType)), Abstract_tag);
  for (i=0; i<n_columns; i++)
    types[i] = GType_val(Field(arr,i));
  CAMLreturn (Val_GObject_new(&gtk_tree_store_newv(n_columns, types)->parent));
}

ML_4 (gtk_tree_store_set_value, GtkTreeStore_val, GtkTreeIter_val,
      Int_val, GValue_val, Unit)
#ifdef HASGTK22
ML_2 (gtk_tree_store_remove, GtkTreeStore_val, GtkTreeIter_val, Val_bool)
#else
ML_2 (gtk_tree_store_remove, GtkTreeStore_val, GtkTreeIter_val, Val_false Ignore)
#endif

ML_4 (gtk_tree_store_insert, GtkTreeStore_val, GtkTreeIter_val,
      Option_val(arg3,GtkTreeIter_val,NULL) Ignore, Int_val, Unit)
ML_4 (gtk_tree_store_insert_before, GtkTreeStore_val, GtkTreeIter_val,
      Option_val(arg3,GtkTreeIter_val,NULL) Ignore, GtkTreeIter_val, Unit)
ML_4 (gtk_tree_store_insert_after, GtkTreeStore_val, GtkTreeIter_val,
      Option_val(arg3,GtkTreeIter_val,NULL) Ignore, GtkTreeIter_val, Unit)
ML_3 (gtk_tree_store_append, GtkTreeStore_val, GtkTreeIter_val,
      Option_val(arg3,GtkTreeIter_val,NULL) Ignore, Unit)
ML_3 (gtk_tree_store_prepend, GtkTreeStore_val, GtkTreeIter_val,
      Option_val(arg3,GtkTreeIter_val,NULL) Ignore, Unit)
ML_3 (gtk_tree_store_is_ancestor, GtkTreeStore_val, GtkTreeIter_val,
      GtkTreeIter_val, Val_bool)
ML_2 (gtk_tree_store_iter_depth, GtkTreeStore_val, GtkTreeIter_val, Val_int)
ML_1 (gtk_tree_store_clear, GtkTreeStore_val, Unit)

#ifdef HASGTK22
ML_2 (gtk_tree_store_iter_is_valid, GtkTreeStore_val, GtkTreeIter_val,
      Val_bool)
ML_3 (gtk_tree_store_swap, GtkTreeStore_val, GtkTreeIter_val,
      GtkTreeIter_val, Unit)
ML_3 (gtk_tree_store_move_before, GtkTreeStore_val, GtkTreeIter_val,
      GtkTreeIter_val, Unit)
ML_3 (gtk_tree_store_move_after, GtkTreeStore_val, GtkTreeIter_val,
      GtkTreeIter_val, Unit)
#else
Unsupported(gtk_tree_store_iter_is_valid)
Unsupported(gtk_tree_store_swap)
Unsupported(gtk_tree_store_move_before)
Unsupported(gtk_tree_store_move_after)
#endif

/* GtkListStore */

#define GtkListStore_val(val) check_cast(GTK_LIST_STORE,val)
CAMLprim value ml_gtk_list_store_newv(value arr)
{
  CAMLparam1(arr);
  int n_columns = Wosize_val(arr);
  int i;
  GType *types = (GType*)
    alloc (Wosize_asize(n_columns * sizeof(GType)), Abstract_tag);
  for (i=0; i<n_columns; i++)
    types[i] = GType_val(Field(arr,i));
  CAMLreturn (Val_GObject_new(&gtk_list_store_newv(n_columns, types)->parent));
}

ML_4 (gtk_list_store_set_value, GtkListStore_val, GtkTreeIter_val,
      Int_val, GValue_val, Unit)

#ifdef HASGTK22
ML_2 (gtk_list_store_remove, GtkListStore_val, GtkTreeIter_val, Val_bool)
#else
ML_2 (gtk_list_store_remove, GtkListStore_val, GtkTreeIter_val, Val_false Ignore)
#endif

ML_3 (gtk_list_store_insert, GtkListStore_val, GtkTreeIter_val, Int_val, Unit)
ML_3 (gtk_list_store_insert_before, GtkListStore_val, GtkTreeIter_val,
      GtkTreeIter_val, Unit)
ML_3 (gtk_list_store_insert_after, GtkListStore_val, GtkTreeIter_val,
      GtkTreeIter_val, Unit)
ML_2 (gtk_list_store_append, GtkListStore_val, GtkTreeIter_val,
      Unit)
ML_2 (gtk_list_store_prepend, GtkListStore_val, GtkTreeIter_val, Unit)
ML_1 (gtk_list_store_clear, GtkListStore_val, Unit)
#ifdef HASGTK22
ML_2 (gtk_list_store_iter_is_valid, GtkListStore_val, GtkTreeIter_val,
      Val_bool)
ML_3 (gtk_list_store_swap, GtkListStore_val, GtkTreeIter_val,
      GtkTreeIter_val, Unit)
ML_3 (gtk_list_store_move_before, GtkListStore_val, GtkTreeIter_val,
      GtkTreeIter_val, Unit)
ML_3 (gtk_list_store_move_after, GtkListStore_val, GtkTreeIter_val,
      GtkTreeIter_val, Unit)
#else
Unsupported(gtk_list_store_iter_is_valid)
Unsupported(gtk_list_store_swap)
Unsupported(gtk_list_store_move_before)
Unsupported(gtk_list_store_move_after)
#endif

/* GtkTreeSelection */

#define GtkTreeSelection_val(val) check_cast(GTK_TREE_SELECTION,val)
ML_2 (gtk_tree_selection_set_mode, GtkTreeSelection_val, Selection_mode_val,
      Unit)
ML_1 (gtk_tree_selection_get_mode, GtkTreeSelection_val, Val_selection_mode)
static gboolean tree_selection_func(GtkTreeSelection *s, GtkTreeModel *m,
                                    GtkTreePath *p, gboolean cs,
                                    gpointer clos_p)
{ return callback2(*(value*)clos_p, Val_GtkTreePath_copy(p), Val_bool(cs)); }
CAMLprim value ml_gtk_tree_selection_set_select_function (value s, value clos)
{
  value *clos_p = ml_global_root_new(clos);
  gtk_tree_selection_set_select_function (GtkTreeSelection_val(s),
                                          tree_selection_func,
                                          clos_p,
                                          ml_global_root_destroy);
  return Val_unit;
}
#ifdef HASGTK22
CAMLprim value ml_gtk_tree_selection_get_selected_rows (value s)
{
  return Val_GList_free (gtk_tree_selection_get_selected_rows
                         (GtkTreeSelection_val(s), NULL),
                         (value_in)Val_GtkTreePath);
}
ML_1 (gtk_tree_selection_count_selected_rows, GtkTreeSelection_val, Val_int)
#else
Unsupported(gtk_tree_selection_get_selected_rows)
Unsupported(gtk_tree_selection_count_selected_rows)
#endif

ML_2 (gtk_tree_selection_select_path, GtkTreeSelection_val, GtkTreePath_val,
      Unit)
ML_2 (gtk_tree_selection_unselect_path, GtkTreeSelection_val, GtkTreePath_val,
      Unit)
ML_2 (gtk_tree_selection_select_iter, GtkTreeSelection_val, GtkTreeIter_val,
      Unit)
ML_2 (gtk_tree_selection_unselect_iter, GtkTreeSelection_val, GtkTreeIter_val,
      Unit)
ML_2 (gtk_tree_selection_path_is_selected, GtkTreeSelection_val,
      GtkTreePath_val, Val_bool)
ML_2 (gtk_tree_selection_iter_is_selected, GtkTreeSelection_val,
      GtkTreeIter_val, Val_bool)
ML_1 (gtk_tree_selection_select_all, GtkTreeSelection_val, Unit)
ML_1 (gtk_tree_selection_unselect_all, GtkTreeSelection_val, Unit)
ML_3 (gtk_tree_selection_select_range, GtkTreeSelection_val, GtkTreePath_val,
      GtkTreePath_val, Unit)

#ifdef HASGTK22
ML_3 (gtk_tree_selection_unselect_range, GtkTreeSelection_val, GtkTreePath_val,
      GtkTreePath_val, Unit)
#else
Unsupported(gtk_tree_selection_unselect_range)
#endif

/* GtkCellRenderer{Text,...} */

#define GtkCellRenderer_val(val) check_cast(GTK_CELL_RENDERER,val)
ML_0 (gtk_cell_renderer_text_new, Val_GtkAny_sink)

/* GtkTreeViewColumn */

#define GtkTreeViewColumn_val(val) check_cast(GTK_TREE_VIEW_COLUMN,val)
ML_0 (gtk_tree_view_column_new, Val_GtkWidget_sink)
ML_3 (gtk_tree_view_column_pack_start, GtkTreeViewColumn_val,
      GtkCellRenderer_val, Int_val, Unit)
ML_3 (gtk_tree_view_column_pack_end, GtkTreeViewColumn_val,
      GtkCellRenderer_val, Int_val, Unit)
ML_4 (gtk_tree_view_column_add_attribute, GtkTreeViewColumn_val,
      GtkCellRenderer_val, String_val, Int_val, Unit)
ML_2 (gtk_tree_view_column_set_title, GtkTreeViewColumn_val, String_val, Unit)

/* GtkTreeView */

#define GtkTreeView_val(val) check_cast(GTK_TREE_VIEW,val)
ML_0 (gtk_tree_view_new, Val_GtkWidget_sink)
ML_1 (gtk_tree_view_new_with_model, GtkTreeModel_val, Val_GtkWidget_sink)
ML_2 (gtk_tree_view_append_column, GtkTreeView_val, GtkTreeViewColumn_val,
      Val_int)
ML_1 (gtk_tree_view_get_selection, GtkTreeView_val, Val_GtkWidget)


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

/* Init all */

CAMLprim value ml_gtktree_init(value unit)
{
    /* Since these are declared const, must force gcc to call them! */
    GType t =
        gtk_tree_item_get_type() +
        gtk_tree_get_type() +
        gtk_tree_view_get_type() +
        gtk_tree_view_column_get_type() +
        gtk_tree_store_get_type() +
        gtk_cell_renderer_pixbuf_get_type() +
        gtk_cell_renderer_text_get_type() +
        gtk_cell_renderer_toggle_get_type () +
        gtk_list_store_get_type() +
        gtk_tree_model_sort_get_type()
#ifdef HASGTK24
        + gtk_tree_model_filter_get_type()
#endif
        ;
    return Val_GType(t);
}

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

Make_Val_final_pointer_compare (GtkTreePath, Ignore, gtk_tree_path_compare, gtk_tree_path_free, 1)
#define Val_GtkTreePath_copy(p) (Val_GtkTreePath(gtk_tree_path_copy(p)))
#define GtkTreePath_val(val) ((GtkTreePath*)Pointer_val(val))

Make_Val_final_pointer (GtkTreeRowReference, Ignore,
                        gtk_tree_row_reference_free, 5)
#define GtkTreeRowReference_val(val) ((GtkTreeRowReference*)Pointer_val(val))

/* TreePath */
ML_0 (gtk_tree_path_new, Val_GtkTreePath)
ML_1 (gtk_tree_path_new_from_string, String_val, Val_GtkTreePath)
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
#define Val_TreeModel_flags(f) ml_lookup_flags_getter(ml_table_tree_model_flags,f)
ML_1 (gtk_tree_model_get_flags, GtkTreeModel_val, Val_TreeModel_flags)
ML_1 (gtk_tree_model_get_n_columns, GtkTreeModel_val, Val_int)
ML_2 (gtk_tree_model_get_column_type, GtkTreeModel_val, Int_val, Val_GType)
ML_3 (gtk_tree_model_get_iter, GtkTreeModel_val, GtkTreeIter_val,
      GtkTreePath_val, Val_bool)
ML_2 (gtk_tree_model_get_path, GtkTreeModel_val, GtkTreeIter_val,
      Val_GtkTreePath)
ML_4 (gtk_tree_model_get_value, GtkTreeModel_val, GtkTreeIter_val, Int_val,
      GValue_val, Unit)
ML_2 (gtk_tree_model_get_iter_first, GtkTreeModel_val, GtkTreeIter_val, Val_bool)
ML_2 (gtk_tree_model_iter_next, GtkTreeModel_val, GtkTreeIter_val,
      Val_bool)
ML_2 (gtk_tree_model_iter_has_child, GtkTreeModel_val, GtkTreeIter_val, Val_bool)
ML_2 (gtk_tree_model_iter_n_children, GtkTreeModel_val, GtkTreeIter_val,
      Val_int)
ML_4 (gtk_tree_model_iter_nth_child, GtkTreeModel_val, GtkTreeIter_val, 
      GtkTreeIter_val, Int_val, Val_bool)
ML_3 (gtk_tree_model_iter_parent, GtkTreeModel_val, GtkTreeIter_val,
      GtkTreeIter_val, Val_bool)
static gboolean gtk_tree_model_foreach_func(GtkTreeModel *model, 
					    GtkTreePath *path, GtkTreeIter *iter, 
					    gpointer data)
{
  value *closure = data;
  CAMLparam0();
  CAMLlocal3(vpath, viter, vret);
  vpath = Val_GtkTreePath_copy(path);
  viter = Val_GtkTreeIter(iter);
  vret = callback2_exn(*closure, vpath, viter);
  if (Is_exception_result(vret)) {
    CAML_EXN_LOG("gtk_tree_model_foreach_func");
    CAMLreturn(FALSE);
  }
  CAMLreturn(Bool_val(vret));
}
CAMLprim value ml_gtk_tree_model_foreach(value m, value cb)
{
  CAMLparam1(cb);
  gtk_tree_model_foreach(GtkTreeModel_val(m),
			 gtk_tree_model_foreach_func,
			 &cb);
  CAMLreturn(Val_unit);
}
ML_3 (gtk_tree_model_row_changed, GtkTreeModel_val, GtkTreePath_val, GtkTreeIter_val, Unit)

/* gtktreestore.h */

#define GtkTreeStore_val(val) check_cast(GTK_TREE_STORE,val)
CAMLprim value ml_gtk_tree_store_newv(value arr)
{
  CAMLparam1(arr);
  int n_columns = Wosize_val(arr);
  int i;
  GType *types = (GType*)
    (n_columns ? alloc (Wosize_asize(n_columns * sizeof(GType)), Abstract_tag)
     : 0);
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
    (n_columns ? alloc (Wosize_asize(n_columns * sizeof(GType)), Abstract_tag)
     : 0);
  for (i=0; i<n_columns; i++)
    types[i] = GType_val(Field(arr,i));
  CAMLreturn (Val_GObject_new(&gtk_list_store_newv(n_columns, types)->parent));
}

ML_4 (gtk_list_store_set_value, GtkListStore_val, GtkTreeIter_val,
      Int_val, GValue_val, Unit)

#ifdef HASGTK22
ML_2 (gtk_list_store_remove, GtkListStore_val, GtkTreeIter_val, Val_bool)
#else
ML_2 (gtk_list_store_remove, GtkListStore_val, GtkTreeIter_val, Unit)
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
static gboolean gtk_tree_selection_func(GtkTreeSelection *s, GtkTreeModel *m,
					GtkTreePath *p, gboolean cs,
					gpointer clos_p)
{
  value vp = Val_GtkTreePath_copy(p);
  value ret = callback2_exn(*(value*)clos_p, vp, Val_bool(cs));
  if (Is_exception_result(ret)) {
    CAML_EXN_LOG("gtk_tree_selection_func");
    return TRUE;
  }
  return Bool_val(ret); 
}
CAMLprim value ml_gtk_tree_selection_set_select_function (value s, value clos)
{
  value *clos_p = ml_global_root_new(clos);
  gtk_tree_selection_set_select_function (GtkTreeSelection_val(s),
                                          gtk_tree_selection_func,
                                          clos_p,
                                          ml_global_root_destroy);
  return Val_unit;
}
static void gtk_tree_selection_foreach_func(GtkTreeModel      *model,
					    GtkTreePath       *path,
					    GtkTreeIter       *iter,
					    gpointer           data)
{ 
  value p = Val_GtkTreePath_copy(path);
  value ret = callback_exn(*(value*)data, p);
  if (Is_exception_result(ret)) 
    CAML_EXN_LOG("gtk_tree_selection_foreach_func");
}
CAMLprim value ml_gtk_tree_selection_selected_foreach (value s, value clos)
{
  CAMLparam1(clos);
  gtk_tree_selection_selected_foreach(GtkTreeSelection_val(s),
                                      gtk_tree_selection_foreach_func,
                                      &clos);
  CAMLreturn(Val_unit);
}
#ifdef HASGTK22
ML_1 (gtk_tree_selection_count_selected_rows, GtkTreeSelection_val, Val_int)
#else
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
#define GtkCellRendererText_val(val) check_cast(GTK_CELL_RENDERER_TEXT,val)
ML_0 (gtk_cell_renderer_pixbuf_new, Val_GtkAny_sink)
ML_0 (gtk_cell_renderer_text_new, Val_GtkAny_sink)
ML_2 (gtk_cell_renderer_text_set_fixed_height_from_font,
      GtkCellRendererText_val, Int_val, Unit)
ML_0 (gtk_cell_renderer_toggle_new, Val_GtkAny_sink)

/* GtkTreeViewColumn */

#define GtkTreeViewColumn_val(val) check_cast(GTK_TREE_VIEW_COLUMN,val)
ML_0 (gtk_tree_view_column_new, Val_GtkWidget_sink)
ML_1 (gtk_tree_view_column_clear, GtkTreeViewColumn_val, Unit)
ML_3 (gtk_tree_view_column_pack_start, GtkTreeViewColumn_val,
      GtkCellRenderer_val, Int_val, Unit)
ML_3 (gtk_tree_view_column_pack_end, GtkTreeViewColumn_val,
      GtkCellRenderer_val, Int_val, Unit)
ML_2 (gtk_tree_view_column_clear_attributes, GtkTreeViewColumn_val, 
      GtkCellRenderer_val, Unit)
ML_4 (gtk_tree_view_column_add_attribute, GtkTreeViewColumn_val,
      GtkCellRenderer_val, String_val, Int_val, Unit)
ML_2 (gtk_tree_view_column_set_sort_column_id, GtkTreeViewColumn_val,
      Int_val, Unit)
ML_1 (gtk_tree_view_column_get_sort_column_id, GtkTreeViewColumn_val, Val_int)
static void gtk_tree_cell_data_func(GtkTreeViewColumn *tree_column, GtkCellRenderer *cell,
				    GtkTreeModel *tree_model, GtkTreeIter *iter, gpointer data)
{
  value *closure = data;
  CAMLparam0();
  CAMLlocal3(vmod,vit,ret);
  vmod  = Val_GAnyObject(tree_model);
  vit   = Val_GtkTreeIter(iter);
  ret = callback2_exn(*closure, vmod, vit);
  if (Is_exception_result(ret)) 
    CAML_EXN_LOG("gtk_tree_cell_data_func");
  CAMLreturn0;
}
CAMLprim value ml_gtk_tree_view_column_set_cell_data_func(value vcol, value cr, value cb)
{
  value *glob_root = NULL;
  if (Is_block(cb))
    glob_root = ml_global_root_new(Field(cb, 0));
  gtk_tree_view_column_set_cell_data_func(GtkTreeViewColumn_val(vcol),
					  GtkCellRenderer_val(cr),
					  (Is_block(cb) ? gtk_tree_cell_data_func : NULL),
					  glob_root,
					  ml_global_root_destroy);
  return Val_unit;
}

/* GtkTreeView */

#define GtkTreeView_val(val) check_cast(GTK_TREE_VIEW,val)
ML_0 (gtk_tree_view_new, Val_GtkWidget_sink)
ML_1 (gtk_tree_view_new_with_model, GtkTreeModel_val, Val_GtkWidget_sink)
ML_1 (gtk_tree_view_get_selection, GtkTreeView_val, Val_GtkWidget)
ML_1 (gtk_tree_view_columns_autosize, GtkTreeView_val, Unit)
ML_2 (gtk_tree_view_append_column, GtkTreeView_val, GtkTreeViewColumn_val,
      Val_int)
ML_2 (gtk_tree_view_remove_column, GtkTreeView_val, GtkTreeViewColumn_val,
      Val_int)
ML_3 (gtk_tree_view_insert_column, GtkTreeView_val, GtkTreeViewColumn_val,
      Int_val, Val_int)
ML_2 (gtk_tree_view_get_column, GtkTreeView_val, Int_val, Val_GtkWidget)
ML_3 (gtk_tree_view_move_column_after, GtkTreeView_val, GtkTreeViewColumn_val,
      GtkTreeViewColumn_val, Unit)
ML_3 (gtk_tree_view_scroll_to_point, GtkTreeView_val, Int_val, Int_val, Unit)
ML_4 (gtk_tree_view_scroll_to_cell, GtkTreeView_val, GtkTreePath_val,
      GtkTreeViewColumn_val, Insert(Bool_val(arg4))
      Insert(Bool_val(arg4) ? Float_val(Field(Field(arg4,0),0)) : 0)
      (Bool_val(arg4) ? Float_val(Field(Field(arg4,0),1)) : 0) Ignore,
      Unit)
ML_3 (gtk_tree_view_row_activated, GtkTreeView_val, GtkTreePath_val,
      GtkTreeViewColumn_val, Unit)
ML_1 (gtk_tree_view_expand_all, GtkTreeView_val, Unit)
ML_1 (gtk_tree_view_collapse_all, GtkTreeView_val, Unit)
ML_3 (gtk_tree_view_expand_row, GtkTreeView_val, GtkTreePath_val,
      Bool_val, Unit)
ML_2 (gtk_tree_view_collapse_row, GtkTreeView_val, GtkTreePath_val, Unit)
ML_2 (gtk_tree_view_row_expanded, GtkTreeView_val, GtkTreePath_val, Val_bool)
ML_4 (gtk_tree_view_set_cursor, GtkTreeView_val, GtkTreePath_val,
      GtkTreeViewColumn_val, Bool_val, Unit)

#ifdef HASGTK22
ML_5 (gtk_tree_view_set_cursor_on_cell, GtkTreeView_val, GtkTreePath_val,
      GtkTreeViewColumn_val, GtkCellRenderer_val, Bool_val, Unit)
#else
Unsupported(gtk_tree_view_set_cursor_on_cell)
#endif

CAMLprim value ml_gtk_tree_view_get_cursor (value arg)
{
  CAMLparam0();
  CAMLlocal1(ret);
  GtkTreePath *path;
  GtkTreeViewColumn *col;
  gtk_tree_view_get_cursor(GtkTreeView_val(arg), &path, &col);
  ret = alloc_tuple(2);
  Store_field(ret,0,Val_option(path,Val_GtkTreePath));
  Store_field(ret,1,Val_option(col,Val_GtkWidget));
  CAMLreturn(ret);
}

CAMLprim value ml_gtk_tree_view_get_path_at_pos(value treeview,
                                                value x, value y)
{
  gint cell_x;
  gint cell_y;
  GtkTreePath *gpath;
  GtkTreeViewColumn *gcolumn;

  if (gtk_tree_view_get_path_at_pos( GtkTreeView_val(treeview), 
				     Int_val(x), 
				     Int_val(y), 
				     &gpath,
				     &gcolumn,
				     &cell_x, &cell_y))
  { /* return Some */
    CAMLparam0 ();
    CAMLlocal1(tup);

    tup = alloc_tuple(4);
    Store_field(tup,0,Val_GtkTreePath(gpath));
    Store_field(tup,1,Val_GtkAny(gcolumn));
    Store_field(tup,2,Val_int(cell_x));
    Store_field(tup,3,Val_int(cell_y));
    CAMLreturn(ml_some (tup));
  }
  return Val_unit;
}

/* GtkCellLayout */
#ifdef HASGTK24
#define GtkCellLayout_val(val) check_cast(GTK_CELL_LAYOUT,val)
ML_3 (gtk_cell_layout_pack_start, GtkCellLayout_val, GtkCellRenderer_val, Bool_val, Unit)
ML_3 (gtk_cell_layout_pack_end,   GtkCellLayout_val, GtkCellRenderer_val, Bool_val, Unit)
ML_1 (gtk_cell_layout_clear, GtkCellLayout_val, Unit)
ML_4 (gtk_cell_layout_add_attribute, GtkCellLayout_val, GtkCellRenderer_val, String_val, Int_val, Unit)
ML_2 (gtk_cell_layout_clear_attributes, GtkCellLayout_val, GtkCellRenderer_val, Unit)
#else
Unsupported_24(gtk_cell_layout_pack_start)
Unsupported_24(gtk_cell_layout_pack_end)
Unsupported_24(gtk_cell_layout_clear)
Unsupported_24(gtk_cell_layout_add_attribute)
Unsupported_24(gtk_cell_layout_clear_attributes)
#endif

/* TreeModelSort */
#define GtkTreeModelSort_val(val) check_cast(GTK_TREE_MODEL_SORT,val)
ML_2 (gtk_tree_model_sort_convert_child_path_to_path, GtkTreeModelSort_val, GtkTreePath_val, Val_GtkTreePath)
CAMLprim value ml_gtk_tree_model_sort_convert_child_iter_to_iter(value m, value it)
{
  GtkTreeIter dst_it;
  gtk_tree_model_sort_convert_child_iter_to_iter(GtkTreeModelSort_val(m), &dst_it, GtkTreeIter_val(it));
  return Val_GtkTreeIter(&dst_it);
}
ML_2 (gtk_tree_model_sort_convert_path_to_child_path, GtkTreeModelSort_val, GtkTreePath_val, Val_GtkTreePath)
CAMLprim value ml_gtk_tree_model_sort_convert_iter_to_child_iter(value m, value it)
{
  GtkTreeIter dst_it;
  gtk_tree_model_sort_convert_iter_to_child_iter(GtkTreeModelSort_val(m), &dst_it, GtkTreeIter_val(it));
  return Val_GtkTreeIter(&dst_it);
}
ML_1 (gtk_tree_model_sort_reset_default_sort_func, GtkTreeModelSort_val, Unit)
ML_2 (gtk_tree_model_sort_iter_is_valid, GtkTreeModelSort_val, GtkTreeIter_val, Val_bool)

/* TreeSortable */
#define GtkTreeSortable_val(val) check_cast(GTK_TREE_SORTABLE,val)
ML_1 (gtk_tree_sortable_sort_column_changed, GtkTreeSortable_val, Unit)
CAMLprim value ml_gtk_tree_sortable_get_sort_column_id(value m)
{
  gint sort_column_id;
  GtkSortType order;
  if (! gtk_tree_sortable_get_sort_column_id(GtkTreeSortable_val(m), 
					     &sort_column_id, &order))
    return Val_unit;
  {
    value vo, ret;
    vo = Val_sort_type(order);
    ret = alloc_small(2, 0);
    Field(ret, 0) = Val_int(sort_column_id);
    Field(ret, 1) = vo;
    return ml_some(ret);
  }
}
ML_3 (gtk_tree_sortable_set_sort_column_id, GtkTreeSortable_val, Int_val, Sort_type_val, Unit)

static gint gtk_tree_iter_compare_func(GtkTreeModel *model,
				       GtkTreeIter  *a,
				       GtkTreeIter  *b,
				       gpointer      user_data)
{
  value *clos = user_data;
  CAMLparam0();
  CAMLlocal4(ret, obj, iter_a, iter_b);
  iter_a = Val_GtkTreeIter(a);
  iter_b = Val_GtkTreeIter(b);
  obj = Val_GAnyObject(model);
  ret = callback3_exn(*clos, obj, iter_a, iter_b);
  if (Is_exception_result(ret)) {
    CAML_EXN_LOG("gtk_tree_iter_compare_func");
    CAMLreturn(0);
  }
  CAMLreturn(Int_val(ret));
}

CAMLprim value ml_gtk_tree_sortable_set_sort_func(value m, value id, value sort_fun)
{
  value *clos = ml_global_root_new(sort_fun);
  gtk_tree_sortable_set_sort_func(GtkTreeSortable_val(m), Int_val(id), 
				  gtk_tree_iter_compare_func,
				  clos, ml_global_root_destroy);
  return Val_unit;
}

CAMLprim value ml_gtk_tree_sortable_set_default_sort_func(value m, value sort_fun)
{
  value *clos = ml_global_root_new(sort_fun);
  gtk_tree_sortable_set_default_sort_func(GtkTreeSortable_val(m),
					  gtk_tree_iter_compare_func,
					  clos, ml_global_root_destroy);
  return Val_unit;
}

ML_1 (gtk_tree_sortable_has_default_sort_func, GtkTreeSortable_val, Val_bool)

/* TreeModelFilter */
#ifdef HASGTK24
#define GtkTreeModelFilter_val(val) check_cast(GTK_TREE_MODEL_FILTER,val)

static gboolean gtk_tree_model_filter_visible_func(GtkTreeModel *model,
						   GtkTreeIter  *iter,
						   gpointer      data)
{
  value *clos = data;
  CAMLparam0();
  CAMLlocal3(ret, obj, it);
  it  = Val_GtkTreeIter(iter);
  obj = Val_GAnyObject(model);
  ret = callback2_exn(*clos, obj, it);
  if (Is_exception_result(ret)) {
    CAML_EXN_LOG("gtk_tree_model_filter_visible_func");
    CAMLreturn(FALSE);
  }
  CAMLreturn(Bool_val(ret));
}

CAMLprim value ml_gtk_tree_model_filter_set_visible_func(value m, value f)
{
  gtk_tree_model_filter_set_visible_func(GtkTreeModelFilter_val(m), 
					 gtk_tree_model_filter_visible_func,
					 ml_global_root_new(f),
					 ml_global_root_destroy);
  return Val_unit;
}

ML_2 (gtk_tree_model_filter_set_visible_column, GtkTreeModelFilter_val, Int_val, Unit)
ML_1 (gtk_tree_model_filter_refilter, GtkTreeModelFilter_val, Unit)

ML_2 (gtk_tree_model_filter_convert_child_path_to_path, GtkTreeModelFilter_val, 
      GtkTreePath_val, Val_GtkTreePath)
CAMLprim value ml_gtk_tree_model_filter_convert_child_iter_to_iter(value m, value it)
{
  GtkTreeIter dst_it;
  gtk_tree_model_filter_convert_child_iter_to_iter(GtkTreeModelFilter_val(m), 
						   &dst_it, GtkTreeIter_val(it));
  return Val_GtkTreeIter(&dst_it);
}
ML_2 (gtk_tree_model_filter_convert_path_to_child_path, GtkTreeModelFilter_val, 
      GtkTreePath_val, Val_GtkTreePath)
CAMLprim value ml_gtk_tree_model_filter_convert_iter_to_child_iter(value m, value it)
{
  GtkTreeIter dst_it;
  gtk_tree_model_filter_convert_iter_to_child_iter(GtkTreeModelFilter_val(m),
						   &dst_it, GtkTreeIter_val(it));
  return Val_GtkTreeIter(&dst_it);
}

#else

Unsupported_24 (gtk_tree_model_filter_set_visible_func)
Unsupported_24 (gtk_tree_model_filter_set_visible_column)
Unsupported_24 (gtk_tree_model_filter_refilter)
Unsupported_24 (gtk_tree_model_filter_convert_child_path_to_path)
Unsupported_24 (gtk_tree_model_filter_convert_child_iter_to_iter)
Unsupported_24 (gtk_tree_model_filter_convert_path_to_child_path)
Unsupported_24 (gtk_tree_model_filter_convert_iter_to_child_iter)

#endif /* HASGTK24 */

/**************************************************************************/
/*                Lablgtk                                                 */
/*                                                                        */
/*    This program is free software; you can redistribute it              */
/*    and/or modify it under the terms of the GNU Library General         */
/*    Public License as published by the Free Software Foundation         */
/*    version 2, with the exception described in file COPYING which       */
/*    comes with the library.                                             */
/*                                                                        */
/*    This program is distributed in the hope that it will be useful,     */
/*    but WITHOUT ANY WARRANTY; without even the implied warranty of      */
/*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       */
/*    GNU Library General Public License for more details.                */
/*                                                                        */
/*    You should have received a copy of the GNU Library General          */
/*    Public License along with this program; if not, write to the        */
/*    Free Software Foundation, Inc., 59 Temple Place, Suite 330,         */
/*    Boston, MA 02111-1307  USA                                          */
/*                                                                        */
/*                                                                        */
/**************************************************************************/

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
#include "ml_gtktree.h"

/* Init all */

CAMLprim value ml_gtktree_init(value unit)
{
    /* Since these are declared const, must force gcc to call them! */
    GType t =
        gtk_tree_view_get_type() +
        gtk_tree_view_column_get_type() +
        gtk_tree_store_get_type() +
        gtk_cell_renderer_pixbuf_get_type() +
        gtk_cell_renderer_text_get_type() +
        gtk_cell_renderer_toggle_get_type () +
        gtk_list_store_get_type() +
        gtk_tree_model_sort_get_type() +
        gtk_tree_path_get_type()
#ifdef HASGTK24
        + gtk_tree_model_filter_get_type()
#endif
#ifdef HASGTK26
        + gtk_cell_renderer_progress_get_type()
        + gtk_cell_renderer_combo_get_type()
        + gtk_icon_view_get_type()
#endif
        ;
    return Val_GType(t);
}

/* gtktreemodel.h */

/* "Lighter" version: allocate in the ocaml heap */
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
ML_1 (gtk_tree_path_prev, GtkTreePath_val, Val_bool)
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
ML_2 (gtk_tree_model_iter_n_children, GtkTreeModel_val, GtkTreeIter_optval,
      Val_int)
ML_4 (gtk_tree_model_iter_nth_child, GtkTreeModel_val, GtkTreeIter_val,
      GtkTreeIter_optval, Int_val, Val_bool)
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
CAMLprim value
ml_gtk_tree_view_column_get_button (value vcol)
{
  return (Val_GtkWidget(GtkTreeViewColumn_val(vcol)->button));
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
#ifdef HASGTK22
ML_2 (gtk_tree_view_expand_to_path, GtkTreeView_val, GtkTreePath_val, Unit)
#else
Unsupported(gtk_tree_view_expand_to_path)
#endif
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

CAMLprim value
ml_gtk_tree_view_get_cell_area(value treeview, value path, value col)
{
  CAMLparam0 ();
  GdkRectangle grect;

  gtk_tree_view_get_cell_area(
    GtkTreeView_val(treeview),
    Option_val(path,GtkTreePath_val,NULL),
    Option_val(col,GtkTreeViewColumn_val,NULL),
    &grect);
  CAMLreturn (Val_copy (grect));
}

CAMLprim value
ml_gtk_tree_view_enable_model_drag_dest (value tv, value t, value a)
{
  CAMLparam3 (tv,t,a);
  GtkTargetEntry *targets = NULL;
  int i, n_targets = Wosize_val(t);
  
  if (n_targets)
    targets = (GtkTargetEntry *) alloc
      ( Wosize_asize(n_targets * sizeof(GtkTargetEntry))
      , Abstract_tag );
  for (i=0; i<n_targets; i++)
  {
    targets[i].target = String_val(Field(Field(t, i), 0));
    targets[i].flags  = Flags_Target_flags_val(Field(Field(t, i), 1));
    targets[i].info   = Int_val(Field(Field(t, i), 2));
  }
  gtk_tree_view_enable_model_drag_dest
    ( GtkTreeView_val(tv)
    , targets
    , n_targets
    , Flags_GdkDragAction_val(a) );
  CAMLreturn(Val_unit);
}
ML_1 (gtk_tree_view_unset_rows_drag_dest, GtkTreeView_val, Unit)

CAMLprim value
ml_gtk_tree_view_enable_model_drag_source (value tv, value m, value t, value a)
{
  CAMLparam4 (tv,m,t,a);
  GtkTargetEntry *targets = NULL;
  int i, n_targets = Wosize_val(t);
  
  if (n_targets)
    targets = (GtkTargetEntry *) alloc
      ( Wosize_asize(n_targets * sizeof(GtkTargetEntry))
      , Abstract_tag );
  for (i=0; i<n_targets; i++)
  {
    targets[i].target = String_val(Field(Field(t, i), 0));
    targets[i].flags  = Flags_Target_flags_val(Field(Field(t, i), 1));
    targets[i].info   = Int_val(Field(Field(t, i), 2));
  }
  gtk_tree_view_enable_model_drag_source
    ( GtkTreeView_val(tv)
    , OptFlags_GdkModifier_val(m)
    , targets
    , n_targets
    , Flags_GdkDragAction_val(a) );
  CAMLreturn(Val_unit);
}
ML_1 (gtk_tree_view_unset_rows_drag_source, GtkTreeView_val, Unit)

CAMLprim value
ml_gtk_tree_view_get_dest_row_at_pos (value treeview, value x, value y)
{
  GtkTreePath *path;
  GtkTreeViewDropPosition pos;

  if (gtk_tree_view_get_dest_row_at_pos(
    GtkTreeView_val(treeview),
    Int_val(x), Int_val(y),
    &path, &pos))
  { /* return Some */
    CAMLparam0 ();
    CAMLlocal1(tup);

    tup = alloc_tuple(2);
    Store_field(tup,0,Val_GtkTreePath(path));
    Store_field(tup,1,Val_tree_view_drop_position(pos));
    CAMLreturn(ml_some (tup));
  }
  return Val_unit;
}

#ifdef HASGTK26
gboolean
ml_gtk_row_separator_func (GtkTreeModel *model,
			   GtkTreeIter *iter,
			   gpointer data)
{
  gboolean ret = FALSE;
  value *closure = data;
  CAMLparam0();
  CAMLlocal3 (arg1, arg2, mlret);
  arg1 = Val_GAnyObject (model);
  arg2 = Val_GtkTreeIter (iter);
  mlret = callback2_exn (*closure, arg1, arg2);
  if (Is_exception_result (ret))
    CAML_EXN_LOG ("gtk_row_separator_func");
  else
    ret = Bool_val (mlret);
  CAMLreturn (ret);
}

CAMLprim value
ml_gtk_tree_view_set_row_separator_func (value cb, value fun_o)
{
  gpointer data;
  GtkDestroyNotify dnotify;
  GtkTreeViewRowSeparatorFunc func;
  if (Is_long (fun_o))
    {
      data = NULL;
      dnotify = NULL;
      func = NULL;
    }
  else
    {
      data = ml_global_root_new (Field (fun_o, 0));
      dnotify = ml_global_root_destroy;
      func = ml_gtk_row_separator_func;
    }
  gtk_tree_view_set_row_separator_func (GtkTreeView_val (cb), func, data, dnotify);
  return Val_unit;
}
#else
Unsupported_26 (gtk_tree_view_set_row_separator_func)
#endif /* HASGTK26 */

#ifdef HASGTK212
CAMLprim value
ml_gtk_tree_view_set_tooltip_cell (value treeview, value tooltip,
                                   value path, value col, value cell,
                                   value unit)
{
  gtk_tree_view_set_tooltip_cell (
    GtkTreeView_val(treeview),
    GtkTooltip_val(tooltip),
    GtkTreePath_optval(path),
    GtkTreeViewColumn_optval(col),
    GtkCellRenderer_optval(cell) );
  return (Val_unit);
} /* All those lines because of that: http://caml.inria.fr/mantis/view.php?id=4396 */
ML_bc6(ml_gtk_tree_view_set_tooltip_cell)
ML_3 (gtk_tree_view_set_tooltip_row, GtkTreeView_val, GtkTooltip_val, GtkTreePath_val, Unit)
CAMLprim value
ml_gtk_tree_view_get_tooltip_context (value treeview, value x, value y, value kbd)
{
  CAMLparam4 (treeview, x, y, kbd);
  CAMLlocal3(tup, opt, sub);
  gint _x = Int_val(x);
  gint _y = Int_val(y);
  GtkTreeModel *model;
  GtkTreePath *path;
  GtkTreeIter iter;
  gboolean boo;
  
  boo = gtk_tree_view_get_tooltip_context (
    GtkTreeView_val(treeview),
    &_x, &_y, Bool_val(kbd),
    &model, &path, &iter );
  
  tup = alloc_tuple(3);
  Store_field(tup, 0, Val_int(_x));
  Store_field(tup, 1, Val_int(_y));
  opt = Val_unit;
  if (boo) {
    sub = alloc_tuple(3);
    Store_field(sub, 0, Val_GAnyObject(model));
    Store_field(sub, 1, Val_GtkTreePath(path));
    Store_field(sub, 2, Val_GtkTreeIter(&iter));
    opt = ml_some(sub);
  }
  Store_field(tup, 2, opt);
  
  CAMLreturn (tup);
}
ML_1 (gtk_tree_view_get_tooltip_column, GtkTreeView_val, Val_int)
ML_2 (gtk_tree_view_set_tooltip_column, GtkTreeView_val, Int_val, Unit)
#else
Unsupported_212 (gtk_tree_view_set_tooltip_cell)
Unsupported_212 (gtk_tree_view_set_tooltip_row)
Unsupported_212 (gtk_tree_view_get_tooltip_context)
Unsupported_212 (gtk_tree_view_get_tooltip_column)
Unsupported_212 (gtk_tree_view_set_tooltip_column)
#endif /* HASGTK212 */

/* GtkCellLayout */
#ifdef HASGTK24
#define GtkCellLayout_val(val) check_cast(GTK_CELL_LAYOUT,val)
ML_3 (gtk_cell_layout_pack_start, GtkCellLayout_val, GtkCellRenderer_val, Bool_val, Unit)
ML_3 (gtk_cell_layout_pack_end,   GtkCellLayout_val, GtkCellRenderer_val, Bool_val, Unit)
ML_3 (gtk_cell_layout_reorder,   GtkCellLayout_val, GtkCellRenderer_val, Int_val, Unit)
ML_1 (gtk_cell_layout_clear, GtkCellLayout_val, Unit)
ML_4 (gtk_cell_layout_add_attribute, GtkCellLayout_val, GtkCellRenderer_val, String_val, Int_val, Unit)
ML_2 (gtk_cell_layout_clear_attributes, GtkCellLayout_val, GtkCellRenderer_val, Unit)

CAMLprim value ml_gtk_cell_layout_set_cell_data_func(value lay, value cr, value cb)
{
  if (Is_block(cb)) {
    value *glob_root = ml_global_root_new(Field(cb, 0));
    gtk_cell_layout_set_cell_data_func (GtkCellLayout_val(lay),
				        GtkCellRenderer_val(cr),
				        (GtkCellLayoutDataFunc) gtk_tree_cell_data_func,
					glob_root,
					ml_global_root_destroy);
  }
  else
    gtk_cell_layout_set_cell_data_func (GtkCellLayout_val(lay), GtkCellRenderer_val(cr), 
					NULL, NULL, NULL);

  return Val_unit;
}

#else
Unsupported_24(gtk_cell_layout_pack_start)
Unsupported_24(gtk_cell_layout_pack_end)
Unsupported_24(gtk_cell_layout_reorder)
Unsupported_24(gtk_cell_layout_clear)
Unsupported_24(gtk_cell_layout_add_attribute)
Unsupported_24(gtk_cell_layout_clear_attributes)
Unsupported_24(gtk_cell_layout_set_cell_data_func)
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
#ifdef HASGTK22
ML_2 (gtk_tree_model_sort_iter_is_valid, GtkTreeModelSort_val, GtkTreeIter_val, Val_bool)
#else
Unsupported(gtk_tree_model_sort_iter_is_valid)
#endif

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

CAMLprim value ml_gtk_tree_sortable_set_sort_func(value m, value id,
						  value sort_fun)
{
  value *clos = ml_global_root_new(sort_fun);
  gtk_tree_sortable_set_sort_func(GtkTreeSortable_val(m), Int_val(id), 
				  gtk_tree_iter_compare_func,
				  clos, ml_global_root_destroy);
  return Val_unit;
}

CAMLprim value ml_gtk_tree_sortable_set_default_sort_func(value m,
							  value sort_fun)
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

ML_2 (gtk_tree_model_filter_set_visible_column, GtkTreeModelFilter_val,
      Int_val, Unit)
ML_1 (gtk_tree_model_filter_refilter, GtkTreeModelFilter_val, Unit)
ML_2 (gtk_tree_model_filter_convert_child_path_to_path, GtkTreeModelFilter_val,
      GtkTreePath_val, Val_GtkTreePath)
CAMLprim value ml_gtk_tree_model_filter_convert_child_iter_to_iter(value m,
								   value it)
{
  GtkTreeIter dst_it;
  gtk_tree_model_filter_convert_child_iter_to_iter(GtkTreeModelFilter_val(m), 
						   &dst_it,
						   GtkTreeIter_val(it));
  return Val_GtkTreeIter(&dst_it);
}
ML_2 (gtk_tree_model_filter_convert_path_to_child_path, GtkTreeModelFilter_val,
      GtkTreePath_val, Val_GtkTreePath)
CAMLprim value ml_gtk_tree_model_filter_convert_iter_to_child_iter(value m,
								   value it)
{
  GtkTreeIter dst_it;
  gtk_tree_model_filter_convert_iter_to_child_iter(GtkTreeModelFilter_val(m),
						   &dst_it,
						   GtkTreeIter_val(it));
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

/* GtkIconView */
#ifdef HASGTK26
#define GtkIconView_val(val) check_cast(GTK_ICON_VIEW,val)
#define Val_option_GtkTreePath(v) Val_option(v,Val_GtkTreePath)
ML_3 (gtk_icon_view_get_path_at_pos, GtkIconView_val, Int_val, Int_val, Val_option_GtkTreePath)
static void ml_iconview_foreach (GtkIconView *icon_view, GtkTreePath *path, gpointer data)
{
  value *cb = data;
  value p;
  p = Val_GtkTreePath_copy(path);
  callback_exn(*cb, p);
}
CAMLprim value ml_gtk_icon_view_selected_foreach (value i, value cb)
{
  CAMLparam2(i, cb);
  gtk_icon_view_selected_foreach (GtkIconView_val(i), ml_iconview_foreach, &cb);
  CAMLreturn(Val_unit);
}
ML_2 (gtk_icon_view_select_path, GtkIconView_val, GtkTreePath_val, Unit)
ML_2 (gtk_icon_view_unselect_path, GtkIconView_val, GtkTreePath_val, Unit)
ML_2 (gtk_icon_view_path_is_selected, GtkIconView_val, GtkTreePath_val, Val_bool)
CAMLprim value ml_gtk_icon_view_get_selected_items (value i)
{
  CAMLparam1(i);
  CAMLlocal3(path, cell, list);
  GList *l, *head;
  head = gtk_icon_view_get_selected_items (GtkIconView_val(i));
  l = g_list_last (head);
  list = Val_emptylist;
  while (l) {
    GtkTreePath *p = l->data;
    path = Val_GtkTreePath(p);
    cell = alloc_small(2, Tag_cons);
    Field(cell, 0) = path;
    Field(cell, 1) = list;
    list = cell;
    l=l->prev;
  }
  g_list_free(head);
  CAMLreturn(list);
}
ML_1 (gtk_icon_view_select_all, GtkIconView_val, Unit)
ML_1 (gtk_icon_view_unselect_all, GtkIconView_val, Unit)
ML_2 (gtk_icon_view_item_activated, GtkIconView_val, GtkTreePath_val, Unit)

#else

Unsupported_26(gtk_icon_view_get_path_at_pos)
Unsupported_26(gtk_icon_view_selected_foreach)
Unsupported_26(gtk_icon_view_select_path)
Unsupported_26(gtk_icon_view_unselect_path)
Unsupported_26(gtk_icon_view_path_is_selected)
Unsupported_26(gtk_icon_view_get_selected_items)
Unsupported_26(gtk_icon_view_select_all)
Unsupported_26(gtk_icon_view_unselect_all)
Unsupported_26(gtk_icon_view_item_activated)

#endif /* HASGTK26 */

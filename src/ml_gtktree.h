#define GtkTreeIter_val(val) ((GtkTreeIter*)MLPointer_val(val))
#define Val_GtkTreeIter(it) (copy_memblock_indirected(it,sizeof(GtkTreeIter)))

gboolean ml_gtk_row_separator_func (GtkTreeModel *model,
				    GtkTreeIter *iter,
				    gpointer data);

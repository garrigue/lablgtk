/* GTK - The GIMP Toolkit
 * Copyright (C) 1995-1997 Peter Mattis, Spencer Kimball and Josh MacDonald
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 */

/*
 * Modified by the GTK+ Team and others 1997-1999.  See the AUTHORS
 * file for a list of people on the GTK+ Team.  See the ChangeLog
 * files for a list of changes.  These files are distributed with
 * GTK+ at ftp://ftp.gtk.org/pub/gtk/. 
 */

#ifndef __GTK_TREE_ITEM2_H__
#define __GTK_TREE_ITEM2_H__


#include <gdk/gdk.h>
#include <gtk/gtkitem.h>


#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */


#define GTK_TYPE_TREE_ITEM2              (gtk_tree_item2_get_type ())
#define GTK_TREE_ITEM2(obj)              (GTK_CHECK_CAST ((obj), GTK_TYPE_TREE_ITEM2, GtkTreeItem2))
#define GTK_TREE_ITEM2_CLASS(klass)      (GTK_CHECK_CLASS_CAST ((klass), GTK_TYPE_TREE_ITEM2, GtkTreeItem2Class))
#define GTK_IS_TREE_ITEM2(obj)           (GTK_CHECK_TYPE ((obj), GTK_TYPE_TREE_ITEM2))
#define GTK_IS_TREE_ITEM2_CLASS(klass)   (GTK_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TREE_ITEM2))

#define GTK_TREE_ITEM2_SUBTREE(obj)      (GTK_TREE_ITEM2(obj)->subtree)


typedef struct _GtkTreeItem2       GtkTreeItem2;
typedef struct _GtkTreeItem2Class  GtkTreeItem2Class;

struct _GtkTreeItem2
{
  GtkItem item;

  GtkWidget *subtree;
  GtkWidget *pixmaps_box;
  GtkWidget *plus_pix_widget, *minus_pix_widget;

  GList *pixmaps;		/* pixmap node for this items color depth */

  guint expanded : 1;
};

struct _GtkTreeItem2Class
{
  GtkItemClass parent_class;

  void (* expand)   (GtkTreeItem2 *tree_item);
  void (* collapse) (GtkTreeItem2 *tree_item);
};


GtkType    gtk_tree_item2_get_type       (void);
GtkWidget* gtk_tree_item2_new            (void);
GtkWidget* gtk_tree_item2_new_with_label (gchar       *label);
void       gtk_tree_item2_set_subtree    (GtkTreeItem2 *tree_item,
					 GtkWidget   *subtree);
void       gtk_tree_item2_remove_subtree (GtkTreeItem2 *tree_item);
void       gtk_tree_item2_select         (GtkTreeItem2 *tree_item);
void       gtk_tree_item2_deselect       (GtkTreeItem2 *tree_item);
void       gtk_tree_item2_expand         (GtkTreeItem2 *tree_item);
void       gtk_tree_item2_collapse       (GtkTreeItem2 *tree_item);


#ifdef __cplusplus
}
#endif /* __cplusplus */


#endif /* __GTK_TREE_ITEM2_H__ */

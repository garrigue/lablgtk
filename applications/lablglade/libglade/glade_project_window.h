/*  Gtk+ User Interface Builder
 *  Copyright (C) 1998-1999  Damon Chaplin
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*/
#ifndef __GLADE_PROJECT_WINDOW_H__
#define __GLADE_PROJECT_WINDOW_H__

#include <gtk/gtkvbox.h>
#include "glade_project_view.h"

#ifdef __cplusplus
extern "C" {
#pragma }
#endif /* __cplusplus */

/*
 * GladeProjectWindow is the main project window, containing a mennubar,
 * toolbar, statusbar and a GladeProjectView to show the project components.
 * It is not a widget, it just creates a window. I did it this way because
 * for Gnome we need to use a GnomeApp instead of a GtkWindow, and I didn't
 * want to use conditional code to subsclass the different widgets.
 */

/* These are used to contain the size of the window manager borders around our
   windows, and are used to show/hide windows in the same positions.
   If they are -ve then don't use them. FIXME: Not needed in GTK 1.1. */
extern gint windows_x_offset;
extern gint windows_y_offset;

#define GLADE_PROJECT_WINDOW(obj) GTK_CHECK_CAST (obj, glade_project_window_get_type (), GladeProjectWindow)
#define GLADE_PROJECT_WINDOW_CLASS(klass) GTK_CHECK_CLASS_CAST (klass, glade_project_window_get_type (), GladeProjectWindowClass)
#define GLADE_IS_PROJECT_WINDOW(obj)       GTK_CHECK_TYPE (obj, glade_project_window_get_type ())


typedef struct _GladeProjectWindow       GladeProjectWindow;
typedef struct _GladeProjectWindowClass  GladeProjectWindowClass;

struct _GladeProjectWindow
{
  /* The main GtkWindow/GnomeApp. */
/* kagawa
  GtkWidget *window;
*/
  GtkVBox vbox;
  /* The GladeProjectView, showing the components in the project. */
  GtkWidget *title;
  GtkWidget *project_view;

  /* The statusbar, for status messages, e.g. 'Project Saved'. */
  GtkWidget *statusbar;

  /* The current directory, for opening projects. */
  gchar *current_directory;
};

struct _GladeProjectWindowClass
{
  GtkVBoxClass parent_class;
};

guint	glade_project_window_get_type (void);

/* GladeProjectWindow */ GtkWidget* glade_project_window_new	(void);

void	    glade_project_window_open_project	(GladeProjectWindow *project_window,
						 gchar              *filename);

void	    glade_project_window_set_project	(GladeProjectWindow *project_window,
						 GladeProject       *project);

void glade_project_window_new_project (GtkWidget *widget);
void glade_project_window_on_open_project (GtkWidget *widget);
void glade_project_window_open_project (GladeProjectWindow *project_window,
				   gchar              *filename);
void glade_project_window_edit_options (GtkWidget *widget);
void glade_project_window_save_project (GtkWidget *widget);
void glade_project_window_on_save_project_as (GtkWidget *widget);
void glade_project_window_write_source (GtkWidget *widget);
/*
void glade_project_window_quit (GtkWidget *widget);
*/
void glade_project_window_cut (GtkWidget *widget);
void glade_project_window_copy (GtkWidget *widget);
void glade_project_window_paste (GtkWidget *widget);
void glade_project_window_delete (GtkWidget *widget);
void glade_project_window_show_palette (GtkWidget *widget);
void glade_project_window_show_property_editor (GtkWidget *widget);
void glade_project_window_show_widget_tree (GtkWidget *widget);
void glade_project_window_show_clipboard (GtkWidget *widget);
void glade_project_window_toggle_tooltips (GtkWidget *widget);
void glade_project_window_toggle_grid (GtkWidget *widget);
void glade_project_window_edit_grid_settings (GtkWidget *widget);
void glade_project_window_toggle_snap (GtkWidget *widget);
void glade_project_window_edit_snap_settings (GtkWidget *widget);
void glade_project_window_about (GtkWidget *widget);


#ifdef __cplusplus
}
#endif /* __cplusplus */

#endif /* __GLADE_PROJECT_WINDOW_H__ */

/*  Gtk+ User Interface Builder
 *  Copyright (C) 1998  Damon Chaplin
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

#include <string.h>
#include <locale.h>

#include <gtk/gtk.h>
#include <gdk/gdkkeysyms.h>

#include "gladeconfig.h"

#undef USE_GNOME 	/* kagawa */

#ifdef USE_GNOME
#include <gnome.h>
#endif

#include "glade.h"
#include "glade_clipboard.h"
#include "glade_project_options.h"
#include "glade_project_window.h"
#include "editor.h"
#include "gbwidget.h"
#include "load.h"
#include "utils.h"


/* This is used to store a pointer to a GladeProjectWindow in the main window.
 */
/* static gchar *GladeProjectWindowKey = "GladeProjectWindowKey"; */


/* FIXME: The position of the main project window, used for determining window
   manager borders. For GTK 1.1 we don't need these. */
/*
static gint win_main_x = 0;
static gint win_main_y = 0;
*/
/* These are used to contain the size of the window manager borders around
   our windows, and are used to show/hide windows in the same positions. */
gint windows_x_offset = -1;
gint windows_y_offset = -1;

/* Used to set a flag on file selections to indicate that we want the source
   code to be written after the project is saved. */
static gchar *GladeProjectWriteSourceKey = "GladeProjectWriteSourceKey";


static void glade_project_window_on_new_project_ok (GtkWidget *button,
						    GladeProjectWindow *project_window);
static void glade_project_window_real_open_project (GtkWidget          *widget,
						    GladeProjectWindow *project_window);
static void glade_project_window_show_loading_errors (GladeProjectWindow *project_window,
						      GList		 *errors);
static void glade_project_window_save_project_as (GladeProjectWindow *project_window,
						  gboolean write_source_after);
static void glade_project_window_save_as_callback (GtkWidget          *widget,
						   GladeProjectWindow *project_window);
static GladeStatusCode glade_project_window_real_save_project (GladeProjectWindow *project_window,
						    gboolean            warn_before_overwrite);
static void glade_project_window_write_source_callback (GtkWidget          *widget,
							GladeProjectWindow *project_window);
static void glade_project_window_real_write_source (GladeProjectWindow *project_window);
static void glade_project_window_real_delete (GladeProjectWindow *project_window);

static gint glade_project_window_key_press_event (GtkWidget * widget,
						  GdkEventKey * event,
						  gpointer data);

static void glade_project_window_options_ok (GtkWidget	    *widget,
					     GladeProjectWindow *project_window);
static void glade_project_window_update_title (GladeProjectWindow *project_window);



static void glade_project_window_class_init (GladeProjectWindowClass *class)
{
  /* nothing */
}

static void
glade_project_window_init (GladeProjectWindow *project_window);

guint
glade_project_window_get_type (void)
{
  static guint glade_project_window_type = 0;

  if (!glade_project_window_type)
    {
      GtkTypeInfo glade_project_window_info =
      {
	"GladeProjectWindow",
	sizeof (GladeProjectWindow),
	sizeof (GladeProjectWindowClass),
	(GtkClassInitFunc) glade_project_window_class_init,
	(GtkObjectInitFunc) glade_project_window_init,
	/* reserved_1 */ NULL,
	/* reserved_2 */ NULL,
#ifdef GTK_HAVE_FEATURES_1_1_0
	(GtkClassInitFunc) NULL,
#endif
      };

      glade_project_window_type = gtk_type_unique (gtk_vbox_get_type (),
						   &glade_project_window_info);
    }
  return glade_project_window_type;
}



GtkWidget*
glade_project_window_new () 
{
  return GTK_WIDGET (gtk_type_new(glade_project_window_get_type ()));
}


static void
glade_project_window_init (GladeProjectWindow *project_window)
{
  GtkWidget *vbox_main = GTK_WIDGET(project_window);

  /* override glade_project.c */
  GladeLanguages[0] = "O'Labl";

  project_window->current_directory = NULL;

  /* Create title lable */
  project_window->title = gtk_label_new("Glade");
  gtk_label_set_justify(GTK_LABEL(project_window->title), GTK_JUSTIFY_LEFT);
  gtk_box_pack_start (GTK_BOX (vbox_main), project_window->title,
		      FALSE, FALSE, 0);
  gtk_widget_show (project_window->title);


  /* Save a pointer to the GladeProjectWindow, so we can find it in callbacks.
   */
  gtk_signal_connect_after (GTK_OBJECT (project_window/*->window*/),
			    "key_press_event",
			    GTK_SIGNAL_FUNC (glade_project_window_key_press_event),
			    NULL);
  
  /* Create list of components */
  project_window->project_view = glade_project_view_new ();
  gtk_clist_column_titles_hide (GTK_CLIST (project_window->project_view));
  gtk_clist_set_row_height (GTK_CLIST (project_window->project_view), 20);
  gtk_clist_set_column_width (GTK_CLIST (project_window->project_view),
			      0, 140);
  gtk_widget_show (project_window->project_view);

#ifdef GTK_HAVE_FEATURES_1_1_4
  /* IN GTK 1.1.4+ the size doesn't include the scrollbars. */
  gtk_widget_set_usize (project_window->project_view, 172, 100);
#else
  gtk_widget_set_usize (project_window->project_view, 190, 120);
#endif

  gb_box_clist_auto_policy (vbox_main, project_window->project_view);

  /* Create status bar. */
  project_window->statusbar = gtk_statusbar_new ();
  gtk_box_pack_start (GTK_BOX (vbox_main), project_window->statusbar,
		      FALSE, FALSE, 0);
  gtk_widget_show (project_window->statusbar);

  /* return project_window; */
}


void
glade_project_window_new_project (GtkWidget *widget/* ,
				  gpointer   data */)
{
  GladeProjectWindow *project_window;
  GtkWidget *dialog;
  gchar *buttons[] = { N_("OK"), N_("Cancel") };
  GtkSignalFunc handlers[] = { glade_project_window_on_new_project_ok, NULL };

  project_window = GLADE_PROJECT_WINDOW(widget); /* get_glade_project_window (widget); */
  g_return_if_fail (project_window != NULL);

  dialog = glade_util_create_dialog_with_buttons (_("Are you sure you want to create a new project?"), 2, buttons, 2, handlers, project_window);
  gtk_window_position (GTK_WINDOW (dialog), GTK_WIN_POS_MOUSE);
#ifdef GTK_HAVE_FEATURES_1_1_6
  /*
  gtk_window_set_transient_for (GTK_WINDOW (dialog),
				GTK_WINDOW (project_window->window));
*/
  gtk_window_set_modal (GTK_WINDOW (dialog), TRUE);
#endif
  gtk_widget_show (dialog);
}


static void
glade_project_window_on_new_project_ok (GtkWidget *button,
					GladeProjectWindow *project_window)
{
  GladeProject *project;

  project = glade_project_new ();
  g_free(project->main_source_file);
  project->main_source_file = g_strdup ("gladesrc.ml");
  g_free(project->main_header_file);
  project->main_header_file = g_strdup ("gladesrc.mli");
  g_free(project->handler_source_file);
  project->handler_source_file = g_strdup ("gladesig.ml");
  g_free(project->handler_header_file);
  project->handler_header_file = g_strdup ("gladesig.mli");

  glade_project_view_set_project (GLADE_PROJECT_VIEW (project_window->project_view), project);
  glade_project_window_update_title (project_window);

  gtk_statusbar_pop (GTK_STATUSBAR (project_window->statusbar), 1);
  gtk_statusbar_push (GTK_STATUSBAR (project_window->statusbar), 1,
		      _("New project created."));
}


void
glade_project_window_on_open_project (GtkWidget *widget/* ,
				      gpointer   data */)
{
  GladeProjectWindow *project_window;
  GtkWidget *filesel;

  project_window = GLADE_PROJECT_WINDOW(widget); /*get_glade_project_window (widget); */
  g_return_if_fail (project_window != NULL);

  filesel = gtk_file_selection_new (_("Open Project"));
  gtk_window_position (GTK_WINDOW (filesel), GTK_WIN_POS_MOUSE);
  if (project_window->current_directory)
    gtk_file_selection_set_filename (GTK_FILE_SELECTION (filesel),
				     project_window->current_directory);

  gtk_signal_connect (GTK_OBJECT (GTK_FILE_SELECTION (filesel)->ok_button),
		      "clicked",
		      GTK_SIGNAL_FUNC (glade_project_window_real_open_project),
		      project_window);
  gtk_signal_connect_object (GTK_OBJECT (GTK_FILE_SELECTION (filesel)->cancel_button),
			     "clicked", GTK_SIGNAL_FUNC (gtk_widget_destroy),
			     GTK_OBJECT (filesel));
  gtk_widget_show (filesel);
}


static void
glade_project_window_real_open_project (GtkWidget          *widget,
					GladeProjectWindow *project_window)
{
  GtkWidget *filesel;
  gchar *filename;

  filesel = gtk_widget_get_toplevel (widget);
  filename = gtk_file_selection_get_filename (GTK_FILE_SELECTION (filesel));

  glade_project_window_open_project (project_window, filename);
  gtk_widget_destroy (filesel);
}


void
glade_project_window_open_project (GladeProjectWindow *project_window,
				   gchar              *filename)
{
  GladeProject *project;
  GladeStatusCode status;
  GList *errors;

  g_free (project_window->current_directory);
  project_window->current_directory = glade_util_dirname (filename);

  status = glade_project_open (filename, &project, &errors);
  if (errors)
    glade_project_window_show_loading_errors (project_window, errors);

  gtk_statusbar_pop (GTK_STATUSBAR (project_window->statusbar), 1);
  if (status == GLADE_STATUS_OK)
    {
      glade_project_view_set_project (GLADE_PROJECT_VIEW (project_window->project_view), project);
      gtk_statusbar_push (GTK_STATUSBAR (project_window->statusbar), 1,
			  _("Project opened."));
    }
  else
    {
      /* FIXME: We have to do this at present to reset everything. */
      project = glade_project_new ();
      glade_project_view_set_project (GLADE_PROJECT_VIEW (project_window->project_view), project);
      gtk_statusbar_push (GTK_STATUSBAR (project_window->statusbar), 1,
			  _("Error opening project."));
    }
  glade_project_window_update_title (project_window);
}


/* This shows the errors in a dialog, and frees them. */
static void
glade_project_window_show_loading_errors (GladeProjectWindow *project_window,
					  GList		     *errors)
{
  GtkWidget *dialog, *vbox, *text, *hbbox, *ok_button;
  GList *element;
  gchar *message, buf[16];
  gint pos = 0;
#ifdef GTK_HAVE_FEATURES_1_1_4
  GtkWidget *scrolled_win;
#endif

  dialog = gtk_window_new (GTK_WINDOW_DIALOG);
  gtk_window_set_title (GTK_WINDOW (dialog), _("Errors opening project file"));
  gtk_window_position (GTK_WINDOW (dialog), GTK_WIN_POS_MOUSE);
  gtk_container_border_width (GTK_CONTAINER (dialog), 2);

  vbox = gtk_vbox_new (FALSE, 4);
  gtk_widget_show (vbox);
  gtk_container_add (GTK_CONTAINER (dialog), vbox);

  text = gtk_text_new (NULL, NULL);
  gtk_widget_show (text);
  gtk_widget_set_usize (text, 400, 150);
  gtk_text_set_editable (GTK_TEXT (text), FALSE);
  GTK_WIDGET_UNSET_FLAGS (text, GTK_CAN_FOCUS);

#ifdef GTK_HAVE_FEATURES_1_1_4
  scrolled_win = gtk_scrolled_window_new (NULL, NULL);
  gtk_container_add (GTK_CONTAINER (scrolled_win), text);
  gtk_scrolled_window_set_policy (GTK_SCROLLED_WINDOW (scrolled_win),
				  GTK_POLICY_NEVER, GTK_POLICY_AUTOMATIC);
  gtk_box_pack_start (GTK_BOX (vbox), scrolled_win, TRUE, TRUE, 0);
  gtk_widget_show(scrolled_win);
#else
  gtk_box_pack_start (GTK_BOX (vbox), text, TRUE, TRUE, 0);
#endif

  hbbox = gtk_hbutton_box_new ();
  gtk_widget_show (hbbox);
  gtk_button_box_set_layout (GTK_BUTTON_BOX (hbbox), GTK_BUTTONBOX_END);
  gtk_box_pack_start (GTK_BOX (vbox), hbbox, FALSE, TRUE, 0);

  ok_button = gtk_button_new_with_label (_("OK"));
  gtk_widget_show (ok_button);
  GTK_WIDGET_SET_FLAGS (ok_button, GTK_CAN_DEFAULT);
  gtk_container_add (GTK_CONTAINER (hbbox), ok_button);
  gtk_widget_grab_default (ok_button);
  gtk_signal_connect_object (GTK_OBJECT (ok_button), "clicked",
			     GTK_SIGNAL_FUNC (gtk_widget_destroy),
			     GTK_OBJECT (dialog));

  gtk_text_freeze (GTK_TEXT (text));
  sprintf (buf, "\n%i", g_list_length (errors));
  gtk_editable_insert_text (GTK_EDITABLE (text), buf, strlen (buf), &pos);

  message = _(" errors opening project file:");
  gtk_editable_insert_text (GTK_EDITABLE (text), message, strlen (message),
			    &pos);
  gtk_editable_insert_text (GTK_EDITABLE (text), "\n\n", 2, &pos);

  element = errors;
  while (element)
    {
      message = (gchar*) element->data;
      gtk_editable_insert_text (GTK_EDITABLE (text), message, strlen (message),
				&pos);
      g_free (message);
      element = element->next;
    }
  g_list_free (errors);
  gtk_text_thaw (GTK_TEXT (text));

  gtk_widget_show (dialog);
}


void
glade_project_window_edit_options (GtkWidget *widget/* ,
				   gpointer   data */)
{
  GladeProjectWindow *project_window;
  GladeProject *project;
  GtkWidget *project_options;

  project_window = GLADE_PROJECT_WINDOW(widget); /*get_glade_project_window (widget);*/
  g_return_if_fail (project_window != NULL);

  project = glade_project_view_get_project (GLADE_PROJECT_VIEW (project_window->project_view));
  if (project)
    {
      project_options = glade_project_options_new (project);
      gtk_signal_connect (GTK_OBJECT (GLADE_PROJECT_OPTIONS (project_options)->ok_button),
			  "clicked",
			  GTK_SIGNAL_FUNC (glade_project_window_options_ok),
			  project_window);
      gtk_widget_show (project_options);
    }
}


void
glade_project_window_save_project (GtkWidget *widget/* ,
				   gpointer   data */)
{
  GladeProjectWindow *project_window;
  GladeProject *project;
  gchar *xml_filename = NULL;

  project_window = GLADE_PROJECT_WINDOW(widget); /* get_glade_project_window (widget);*/
  g_return_if_fail (project_window != NULL);

  project = glade_project_view_get_project (GLADE_PROJECT_VIEW (project_window->project_view));
  if (project)
    {
      xml_filename = glade_project_get_xml_filename (project);

      if (xml_filename == NULL || xml_filename[0] == '\0')
	glade_project_window_save_project_as (project_window, FALSE);
      else
	glade_project_window_real_save_project (project_window, FALSE);
    }
}


void
glade_project_window_on_save_project_as (GtkWidget *widget/* ,
					 gpointer   data */)
{
  GladeProjectWindow *project_window;

  project_window = GLADE_PROJECT_WINDOW(widget); /*get_glade_project_window (widget);*/
  g_return_if_fail (project_window != NULL);

  glade_project_window_save_project_as (project_window, FALSE);
}


static void
glade_project_window_save_project_as (GladeProjectWindow *project_window,
				      gboolean write_source_after)
{
  GtkWidget *filesel;

  filesel = gtk_file_selection_new (_("Save Project"));
  gtk_window_position (GTK_WINDOW (filesel), GTK_WIN_POS_MOUSE);
  if (project_window->current_directory)
    gtk_file_selection_set_filename (GTK_FILE_SELECTION (filesel),
				     project_window->current_directory);
  gtk_signal_connect (GTK_OBJECT (GTK_FILE_SELECTION (filesel)->ok_button),
		      "clicked",
		      GTK_SIGNAL_FUNC (glade_project_window_save_as_callback),
		      project_window);
  gtk_signal_connect_object (GTK_OBJECT (GTK_FILE_SELECTION (filesel)->cancel_button),
			     "clicked", GTK_SIGNAL_FUNC (gtk_widget_destroy),
			     GTK_OBJECT (filesel));
  /* Set a flag to indicate if we want the source code to be built after
     saving the project. */
  if (write_source_after)
    gtk_object_set_data (GTK_OBJECT (filesel), GladeProjectWriteSourceKey,
			 GINT_TO_POINTER (TRUE));

  gtk_widget_show (filesel);
}


static void
glade_project_window_save_as_callback (GtkWidget          *widget,
				       GladeProjectWindow *project_window)
{
  GladeProject *project;
  GtkWidget *filesel;
  gchar *filename;
  GladeStatusCode status;

  filesel = gtk_widget_get_toplevel (widget);
  filename = gtk_file_selection_get_filename (GTK_FILE_SELECTION (filesel));

  g_free (project_window->current_directory);
  project_window->current_directory = glade_util_dirname (filename);

  project = glade_project_view_get_project (GLADE_PROJECT_VIEW (project_window->project_view));
  if (project)
    {
      glade_project_set_xml_filename (project, filename);
      status = glade_project_window_real_save_project (project_window, TRUE);

      if (status == GLADE_STATUS_OK
	  && gtk_object_get_data (GTK_OBJECT (filesel),
				  GladeProjectWriteSourceKey))
	glade_project_window_real_write_source (project_window);
    }
  gtk_widget_destroy (filesel);
}


static GladeStatusCode
glade_project_window_real_save_project (GladeProjectWindow *project_window,
					gboolean            warn_before_overwrite)
{
  GladeProject *project;
  GladeStatusCode status;

  project = glade_project_view_get_project (GLADE_PROJECT_VIEW (project_window->project_view));
  g_return_val_if_fail (project != NULL, GLADE_STATUS_ERROR);

  status = glade_project_save (project);

  gtk_statusbar_pop (GTK_STATUSBAR (project_window->statusbar), 1);
  if (status != GLADE_STATUS_OK)
    {
      glade_util_show_message_box (_("Error saving file"));
      MSG1 ("Error saving file:%i", status);
      gtk_statusbar_push (GTK_STATUSBAR (project_window->statusbar), 1,
			  _("Error saving project."));
    }
  else
    gtk_statusbar_push (GTK_STATUSBAR (project_window->statusbar), 1,
			_("Project saved."));
  return status;
}


void
glade_project_window_write_source (GtkWidget *widget/* ,
				   gpointer   data */)
{
  GladeProjectWindow *project_window;
  GladeProject *project;
  GtkWidget *filesel;
  gchar *xml_filename, *source_directory;

  project_window = GLADE_PROJECT_WINDOW(widget); /*get_glade_project_window (widget);*/
  g_return_if_fail (project_window != NULL);

  project = glade_project_view_get_project (GLADE_PROJECT_VIEW (project_window->project_view));
  g_return_if_fail (project != NULL);

  /* First we need to make sure the XML is saved. */
  xml_filename = glade_project_get_xml_filename (project);

  if (xml_filename == NULL || xml_filename[0] == '\0')
    {
      glade_project_window_save_project_as (project_window, TRUE);
      return;
    }
  else
    glade_project_window_real_save_project (project_window, FALSE);

  /* Now make sure we have a source directory. */
  source_directory = glade_project_get_source_directory (project);

  if (source_directory == NULL || source_directory[0] == '\0')
    {
      filesel = gtk_file_selection_new (_("Select source directory"));
      gtk_window_position (GTK_WINDOW (filesel), GTK_WIN_POS_MOUSE);

      gtk_signal_connect (GTK_OBJECT (GTK_FILE_SELECTION (filesel)->ok_button),
			  "clicked",
			  GTK_SIGNAL_FUNC (glade_project_window_write_source_callback),
			  project_window);
      gtk_signal_connect_object (GTK_OBJECT (GTK_FILE_SELECTION (filesel)->cancel_button),
				 "clicked",
				 GTK_SIGNAL_FUNC (gtk_widget_destroy),
				 GTK_OBJECT (filesel));
      gtk_widget_show (filesel);
    }
  else
    glade_project_window_real_write_source (project_window);
}


static void
glade_project_window_write_source_callback (GtkWidget          *widget,
					    GladeProjectWindow *project_window)
{
  GladeProject *project;
  GtkWidget *filesel;
  gchar *directory;

  filesel = gtk_widget_get_toplevel (widget);
  directory = gtk_file_selection_get_filename (GTK_FILE_SELECTION (filesel));

  project = glade_project_view_get_project (GLADE_PROJECT_VIEW (project_window->project_view));
  if (project)
    {
      glade_project_set_source_directory (project, directory);
      glade_project_window_real_write_source (project_window);
    }
  gtk_widget_destroy (filesel);
}


static void
glade_project_window_real_write_source (GladeProjectWindow *project_window)
{
  GladeProject *project;
  GladeStatusCode status;

  project = glade_project_view_get_project (GLADE_PROJECT_VIEW (project_window->project_view));
  g_return_if_fail (project != NULL);

  status = glade_project_write_source (project);

  gtk_statusbar_pop (GTK_STATUSBAR (project_window->statusbar), 1);
  if (status != GLADE_STATUS_OK)
    {
      glade_util_show_message_box (_("Error writing source"));
      MSG1 ("Error saving file:%i", status);
      gtk_statusbar_push (GTK_STATUSBAR (project_window->statusbar), 1,
			  _("Error writing source."));
      return;
    }

  gtk_statusbar_push (GTK_STATUSBAR (project_window->statusbar), 1,
		      _("Source code written."));
}


void
glade_project_window_cut (GtkWidget *widget/* ,
			  gpointer   user_data */)
{
  GladeProjectWindow *project_window;
  GladeProject *project;

  project_window = GLADE_PROJECT_WINDOW(widget); /*get_glade_project_window (widget);*/
  g_return_if_fail (project_window != NULL);

  project = glade_project_view_get_project (GLADE_PROJECT_VIEW (project_window->project_view));
  if (project == NULL)
    return;

  glade_clipboard_cut (GLADE_CLIPBOARD (glade_clipboard), project, NULL);
}


void
glade_project_window_copy (GtkWidget *widget/* ,
			   gpointer   data */)
{
  GladeProjectWindow *project_window;
  GladeProject *project;

  project_window = GLADE_PROJECT_WINDOW(widget); /*get_glade_project_window (widget);*/
  g_return_if_fail (project_window != NULL);

  project = glade_project_view_get_project (GLADE_PROJECT_VIEW (project_window->project_view));
  if (project == NULL)
    return;

  glade_clipboard_copy (GLADE_CLIPBOARD (glade_clipboard), project, NULL);
}


void
glade_project_window_paste (GtkWidget *widget/* ,
			    gpointer  user_data */)
{
  GladeProjectWindow *project_window;
  GladeProject *project;

  project_window = GLADE_PROJECT_WINDOW(widget); /*get_glade_project_window (widget);*/
  g_return_if_fail (project_window != NULL);

  project = glade_project_view_get_project (GLADE_PROJECT_VIEW (project_window->project_view));
  if (project == NULL)
    return;

  glade_clipboard_paste (GLADE_CLIPBOARD (glade_clipboard), project, NULL);
}


void
glade_project_window_delete (GtkWidget *widget/* ,
			     gpointer   data */)
{
  GladeProjectWindow *project_window;

  project_window = GLADE_PROJECT_WINDOW(widget); /*get_glade_project_window (widget);*/
  g_return_if_fail (project_window != NULL);

  glade_project_window_real_delete (project_window);
}


/* If one or more items in the project view is selected, we delete them.
   If not, we delete any widgets selected in the interface.
   FIXME: I'm not sure of the correct way to handle the Delete key. Should we
   be using X selections to determine what is currently selected? */
static void
glade_project_window_real_delete (GladeProjectWindow *project_window)
{
  if (glade_project_view_has_selection (GLADE_PROJECT_VIEW (project_window->project_view)))
    glade_project_view_delete_selection (GLADE_PROJECT_VIEW (project_window->project_view));
  else
    editor_on_delete ();
}


void
glade_project_window_show_palette (GtkWidget *widget/* ,
				   gpointer   data */)
{
  glade_show_palette ();
}


void
glade_project_window_show_property_editor (GtkWidget *widget/* ,
					   gpointer   data */)
{
  glade_show_property_editor ();
}


#ifdef GTK_HAVE_FEATURES_1_1_0
void
glade_project_window_show_widget_tree (GtkWidget *widget/* ,
				       gpointer   data */)
{
  glade_show_widget_tree ();
}
#endif


void
glade_project_window_show_clipboard (GtkWidget *widget/* ,
				     gpointer   data */)
{
  glade_show_clipboard ();
}


void
glade_project_window_toggle_tooltips (GtkWidget *widget/* ,
				      gpointer   data */)
{
  gboolean show_tooltips;

  show_tooltips =  GTK_CHECK_MENU_ITEM (widget)->active;
  gb_widget_set_show_tooltips (show_tooltips);
}


void
glade_project_window_toggle_grid (GtkWidget *widget/* ,
				  gpointer   data */)
{
  gboolean show_grid;

  show_grid = GTK_CHECK_MENU_ITEM (widget)->active;
  editor_set_show_grid (show_grid);
}


void
glade_project_window_edit_grid_settings (GtkWidget *widget/* ,
					 gpointer   data */)
{
  editor_show_grid_settings_dialog ();
}


void
glade_project_window_toggle_snap (GtkWidget *widget/* ,
				  gpointer   data */)
{
  gboolean snap_to_grid;

  snap_to_grid = GTK_CHECK_MENU_ITEM (widget)->active;
  editor_set_snap_to_grid (snap_to_grid);
}


void
glade_project_window_edit_snap_settings (GtkWidget *widget/* ,
					 gpointer   data */)
{
  editor_show_snap_settings_dialog ();
}


void
glade_project_window_about (GtkWidget *widget/* ,
			    gpointer   data */)
{
#ifdef USE_GNOME
  const gchar *author[] = {"Damon Chaplin <glade@glade.pn.org>", NULL };
  GtkWidget *about;
#else
  /* I hope the translations don't overflow the buffer! */
  gchar buf[1024];
#endif

  /* VERSION comes from configure.in - the only place it should be defined */
#ifdef USE_GNOME
  about = gnome_about_new ("Glade",
  			VERSION,
			"Copyright 1998 Damon Chaplin",
			author,
			"A GTK+ User Interface Builder\n"
			"Web: http://glade.pn.org\n",
			NULL); /* TODO: we need a logo ;) */
	gtk_window_set_modal (GTK_WINDOW (about), TRUE);
	gtk_widget_show (about);
#else
  sprintf (buf,
	   _("G L A D E\n\n"
	     "A GTK+ User Interface Builder\n\n"
	     "Version %s\n\n"
	     "By Damon Chaplin\n\n"
	     "Email: glade@glade.pn.org\n"
	     "Web: http://glade.pn.org\n"),
	   VERSION);
  glade_util_show_message_box (buf);
#endif
}


static gint
glade_project_window_key_press_event (GtkWidget * widget,
				      GdkEventKey * event,
				      gpointer data)
{
  GladeProjectWindow *project_window;

  project_window = GLADE_PROJECT_WINDOW(widget); /*get_glade_project_window (widget);*/
  g_return_val_if_fail (project_window != NULL, FALSE);

  switch (event->keyval)
    {
    case GDK_Delete:
      glade_project_window_real_delete (project_window);
      break;
    }
  return TRUE;
}


/* FIXME: GTK 1.0 workaround. Take out when we drop support, and replace with
   GTK 1.1. functions. */

void
glade_project_window_set_project	(GladeProjectWindow *project_window,
					 GladeProject       *project)
{
  glade_project_view_set_project (GLADE_PROJECT_VIEW (project_window->project_view),
				  project);
  glade_project_window_update_title (project_window);
}


static void
glade_project_window_options_ok (GtkWidget	    *widget,
				 GladeProjectWindow *project_window)
{
  glade_project_window_update_title (project_window);
}


static void
glade_project_window_update_title	(GladeProjectWindow *project_window)
{
  GladeProject *project;
  gchar title[256], *project_name;

  project = glade_project_view_get_project (GLADE_PROJECT_VIEW (project_window->project_view));
  if (project == NULL)
    strcpy (title, "Glade");
  else
    {
      strcpy (title, "Glade: ");
      project_name = glade_project_get_name (project);
      if (project_name && strlen (project_name) < 200)
	strcat (title, project_name);
    }
  /*  gtk_window_set_title (GTK_WINDOW (project_window->window), title); */
  gtk_label_set_text(GTK_LABEL (project_window->title), title);
}

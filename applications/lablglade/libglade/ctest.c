#include <gtk/gtk.h>
#include "glade.h"
#include "glade_project.h"
#include "my_project_window.h"

void delete_event (GtkWidget *widget, GdkEvent *event, gpointer data) {
  gtk_main_quit ();
}

int main (int argc, char **argv) {
  GtkWidget *window, *view;

  gtk_init (&argc, &argv);
  glade_init();  
  window = gtk_window_new (GTK_WINDOW_TOPLEVEL);

  gtk_signal_connect (GTK_OBJECT (window), "delete_event",
		      GTK_SIGNAL_FUNC(delete_event), NULL);
  view = glade_project_window_new ();
  gtk_container_add (GTK_CONTAINER (window), view);
  gtk_widget_show(view);
  gtk_widget_show(window);

  glade_show_palette ();
  glade_show_property_editor ();

  glade_project_new ();
  glade_project_window_set_project (GLADE_PROJECT_WINDOW(view),
				     current_project);
  gtk_main ();
  

  return 0;
}

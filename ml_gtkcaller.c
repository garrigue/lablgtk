/* $Id$ */

#include "ml_gtkcaller.h"
#include <gtk/gtksignal.h>


enum {
  CALL,
  LAST_SIGNAL
};


static void gtk_caller_class_init (GtkCallerClass *klass);

static guint caller_signals[LAST_SIGNAL] = { 0 };

GtkType
gtk_caller_get_type (void)
{
  static GtkType caller_type = 0;

  if (!caller_type)
    {
      GtkTypeInfo caller_info =
      {
	"GtkCaller",
	sizeof (GtkCaller),
	sizeof (GtkCallerClass),
	(GtkClassInitFunc) gtk_caller_class_init,
	(GtkObjectInitFunc) NULL,
	(GtkArgSetFunc) NULL,
        (GtkArgGetFunc) NULL,
      };

      caller_type = gtk_type_unique (gtk_object_get_type (), &caller_info);
    }

  return caller_type;
}

static void
gtk_caller_class_init (GtkCallerClass *class)
{
  GtkObjectClass *object_class;

  object_class = (GtkObjectClass*) class;

  caller_signals[CALL] =
    gtk_signal_new ("call",
                    GTK_RUN_FIRST,
                    object_class->type,
                    GTK_SIGNAL_OFFSET (GtkCallerClass, call),
                    gtk_signal_default_marshaller,
		    GTK_TYPE_NONE, 0);

  gtk_object_class_add_signals (object_class, caller_signals, LAST_SIGNAL);
}

GtkObject *gtk_caller_new ()
{
    return GTK_OBJECT (gtk_type_new (gtk_caller_get_type ()));
}

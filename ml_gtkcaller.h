/* $Id$ */

#ifndef __GTK_CALLER_H__
#define __GTK_CALLER_H__


#include <gdk/gdk.h>
#include <gtk/gtkobject.h>


#ifdef __cplusplus
extern "C" {
#pragma }
#endif /* __cplusplus */


#define GTK_TYPE_CALLER		(gtk_caller_get_type ())
#define GTK_CALLER(obj)		(GTK_CHECK_CAST ((obj), GTK_TYPE_CALLER, GtkCaller))
#define GTK_CALLER_CLASS(klass) (GTK_CHECK_CLASS_CAST ((klass), GTK_TYPE_CALLER, GtkCallerClass))
#define GTK_IS_CALLER(obj)	(GTK_CHECK_TYPE ((obj), GTK_TYPE_CALLER))
#define GTK_IS_CALLER_CLASS(klass)  (GTK_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CALLER))


typedef struct _GtkCaller       GtkCaller;
typedef struct _GtkCallerClass  GtkCallerClass;

struct _GtkCaller
{
  GtkObject object;
};

struct _GtkCallerClass
{
  GtkObjectClass parent_class;

  void (* call) (GtkCaller *caller);
};


GtkType gtk_caller_get_type (void);


#ifdef __cplusplus
}
#endif /* __cplusplus */


#endif /* __GTK_CALLER_H__ */

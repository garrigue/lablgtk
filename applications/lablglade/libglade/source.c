#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdarg.h>
#include <errno.h>
#include <ctype.h>
#include <locale.h>

#include <gtk/gtk.h>
#include "gladeconfig.h"

#include "gbwidget.h"
#include "glade_project.h"
#include "source.h"
#include "utils.h"
#ifdef HAVE_OS2_H
#include "source_os2.h"
#endif

#define GB_SOURCE_BUFFER_INCREMENT	8192
#define GB_SOURCE_BUFFER_ENSURE_SPACE	4096

#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>

#include <wrappers.h>
#include <ml_glib.h>
#include <ml_gdk.h>
#include <ml_gtk.h>

GladeStatusCode
source_write (GladeProject *project)
{

  FILE* cfp=NULL;
  static value * ml_source_write = NULL;
  char* str;
  value components = Val_GList(project->components,
			       (value (*)(gpointer))Val_GtkObject);
  struct stat filestat;

  if (stat (project->source_directory, &filestat) != 0)
    {
      if (errno == ENOENT)
	{
	  if (mkdir (project->source_directory, 0777) != 0)
	    return GLADE_STATUS_MKDIR_ERROR;
	}
      else
	return GLADE_STATUS_FILE_STAT_ERROR;
    }
  else if (!S_ISDIR (filestat.st_mode))
    g_warning ("Source directory is not a directory");

  if (chdir (project->source_directory) == -1)
    return GLADE_STATUS_CHDIR_ERROR;

  
  if(ml_source_write==NULL) {
    ml_source_write=caml_named_value("source_write");
  }
  
  str = String_val(callback(*ml_source_write, components));

  /*
  printf(str);
  printf("%s\n", project->main_source_file);
  */
  cfp = fopen (project->main_source_file, "w");
  fprintf(cfp, str);
  fclose(cfp);
  return GLADE_STATUS_OK;
}


FILE *
create_file_if_not_exist (gchar *filename, GladeStatusCode  *status)
{
  FILE *fp;

  if (glade_util_file_exists (filename))
    return NULL;

  fp = fopen (filename, "wt");
  if (fp == NULL)
    {
      *status = GLADE_STATUS_FILE_OPEN_ERROR;
      return NULL;
    }
  return (fp);
}

void
source_write_subcomponent_create (GtkWidget * component,
                               GbWidgetWriteSourceData * data)
{
  /*  va_list args; */
}

static void
gb_realloc_buffer_if_needed (GbBuffControl * p)
{
  if (p->space - p->pos < GB_SOURCE_BUFFER_ENSURE_SPACE)
    {
      p->space += GB_SOURCE_BUFFER_INCREMENT;
      p->ptr = g_realloc (p->ptr, p->space);
    }
}


void
source_add (GbWidgetWriteSourceData * data, gchar * fmt,...)
{
  va_list args;

  gb_realloc_buffer_if_needed (&data->buffer);

  va_start (args, fmt);
  vsprintf (data->buffer.ptr + data->buffer.pos, fmt, args);
  data->buffer.pos += strlen (data->buffer.ptr + data->buffer.pos);
  va_end (args);
}

void
source_add_decl (GbWidgetWriteSourceData * data, gchar * fmt,...)
{
  va_list args;

  gb_realloc_buffer_if_needed (&data->decl_buffer);
 
  va_start (args, fmt);
  vsprintf (data->decl_buffer.ptr + data->decl_buffer.pos, fmt, args);
  data->decl_buffer.pos += strlen (data->decl_buffer.ptr + data->decl_buffer.pos);
  va_end (args);
}


gchar *
source_create_valid_identifier (gchar * name)
{
  return NULL;
}

gchar *
source_make_string (gchar * text,
		    gboolean translatable)
{
  return NULL;
}


void
source_create_pixmap (GbWidgetWriteSourceData * data,
		      gchar                   * identifier,
		      gchar                   * filename)
{
}

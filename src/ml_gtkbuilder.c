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
#include <caml/printexc.h>
#include "wrappers.h"
#include "ml_glib.h"
#include "ml_gobject.h"
#include "ml_gdk.h"
#include "ml_gtk.h"
#include "gtk_tags.h"
#include "ml_gtkbuilder.h"

/* Init all */

CAMLprim value ml_gtkbuilder_init(value unit)
{
    /* Since these are declared const, must force gcc to call them! */
    GType t = gtk_builder_get_type();
    return Val_GType(t);
}

#define GtkBuilder_val(val) check_cast(GTK_BUILDER,val)

//#define GtkBuilder_val(val) ((GtkBuilder*)Pointer_val(val))
#define Val_GtkBuilder(val) Val_GObject((GObject*)val)

ML_1 (gtk_builder_new_from_file, String_val, Val_GtkBuilder)
ML_2 (gtk_builder_get_object, GtkBuilder_val, String_val, Val_GObject)

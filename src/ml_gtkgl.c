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
/* #include "gtkgl_tags.h" */

/* Conversion functions */
/* #include "gtkgl_tags.c" */

#define GtkGLArea_val(val) check_cast(GTK_GL_AREA,val)

ML_0 (gtk_gl_area_new, Val_GtkWidget_sink)
ML_1 (gtk_gl_area_make_current, GtkGLArea_val, Unit)

ML_2 (gtk_gl_area_set_has_alpha, GtkGLArea_val, Bool_val, Unit)
ML_1 (gtk_gl_area_get_has_alpha, GtkGLArea_val, Bool_val)

ML_2 (gtk_gl_area_set_has_depth_buffer, GtkGLArea_val, Bool_val, Unit)
ML_1 (gtk_gl_area_get_has_depth_buffer, GtkGLArea_val, Bool_val)

ML_2 (gtk_gl_area_set_has_stencil_buffer, GtkGLArea_val, Bool_val, Unit)
ML_1 (gtk_gl_area_get_has_stencil_buffer, GtkGLArea_val, Bool_val)

ML_2 (gtk_gl_area_set_auto_render, GtkGLArea_val, Bool_val, Unit)
ML_1 (gtk_gl_area_get_auto_render, GtkGLArea_val, Bool_val)

ML_3 (gtk_gl_area_set_required_version, GtkGLArea_val, Int_val, Int_val, Unit)  
CAMLprim value ml_gtk_gl_area_get_required_version(value area)
{
  int major, minor;
  value res = alloc_tuple(2);
  gtk_gl_area_get_required_version(GtkGLArea_val(area), &major, &minor);
  Field(res,0) = Val_int(major);
  Field(res,1) = Val_int(minor);
  return res;
}

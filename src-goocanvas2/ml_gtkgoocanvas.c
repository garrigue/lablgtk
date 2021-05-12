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

#include <assert.h>
#include <goocanvas.h>

#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>
#include <caml/fail.h>
#include <caml/custom.h>
#include <caml/callback.h>

#include "wrappers.h"
#include "ml_glib.h"
#include "ml_gdk.h"
#include "ml_gtk.h"
#include "ml_gobject.h"
#include "ml_gdkpixbuf.h"
#include "ml_pango.h"
#include "gtk_tags.h"
#include "gdk_tags.h"
#include "goocanvas_tags.h"
#include <string.h>
#include "goocanvas_tags.c"

static inline value goo_copy_double_array(double *a, size_t len)
{
  value v;
  register unsigned int i;
  v = alloc(len * Double_wosize, Double_array_tag);
  for(i=0; i<len; i++)
    Store_double_field(v, i, a[i]);
  return v;
}
static inline value goo_copy_bounds(GooCanvasBounds b)
{
  value v;
  v = alloc(4 * Double_wosize, Double_array_tag);
  Store_double_field(v, 0, b.x1);
  Store_double_field(v, 1, b.y1);
  Store_double_field(v, 2, b.x2);
  Store_double_field(v, 3, b.y2);
  return v;
}
static inline value double_pair(double x, double y)
{
  value v ;
  v = caml_alloc_tuple(2) ;
  Store_field(v, 0, caml_copy_double (x)) ;
  Store_field(v, 1, caml_copy_double (y)) ;
  return v ;
}
#define GooCanvas_val(val)      check_cast(GOO_CANVAS,val)
#define GooCanvasGroup_val(val) check_cast(GOO_CANVAS_GROUP,val)
#define GooCanvasItemSimple_val(val)  check_cast(GOO_CANVAS_ITEM_SIMPLE,val)
#define GooCanvasItem_val(val)  check_cast(GOO_CANVAS_ITEM,val)
#define GooCanvasItem_optval(v) Option_val(v, GooCanvasItem_val, NULL)
#define Val_GooCanvasItem(val)  Val_GtkAny(val)
static Make_Val_option(GooCanvasItem)

#define GooCanvasText_val(val)  check_cast(GOO_CANVAS_TEXT,val)
#define Val_GooCanvasText_new(val)  (Val_GObject((GObject*)val))

#define GooCanvasRect_val(val)  check_cast(GOO_CANVAS_RECT,val)
#define Val_GooCanvasRect_new(val)  (Val_GObject((GObject*)val))

#define GooCanvasWidget_val(val)  check_cast(GOO_CANVAS_WIDGET,val)
#define Val_GooCanvasWidget_new(val)  (Val_GObject((GObject*)val))

#define GooCanvasGroup_val(val)  check_cast(GOO_CANVAS_GROUP,val)
#define Val_GooCanvasGroup_new(val)  (Val_GObject((GObject*)val))

#define GooCanvasPolyline_val(val)  check_cast(GOO_CANVAS_GROUP,val)
#define Val_GooCanvasPolyline_new(val)  (Val_GObject((GObject*)val))

#define Val_GooCanvasPoints_new(val)  (Val_pointer(val))

ML_0 (goo_canvas_new, Val_GtkWidget_sink)
ML_1 (goo_canvas_get_root_item, GooCanvas_val, Val_GtkAny)
ML_2 (goo_canvas_set_root_item, GooCanvas_val, GooCanvasItem_val, Unit)

ML_1 (goo_canvas_get_scale, GooCanvas_val, copy_double)
ML_2 (goo_canvas_set_scale, GooCanvas_val, Double_val, Unit)

ML_4 (goo_canvas_get_item_at, GooCanvas_val, Double_val, Double_val, Bool_val, Val_option_GooCanvasItem)
ML_3 (goo_canvas_scroll_to, GooCanvas_val, Double_val, Double_val, Unit)

ML_5 (goo_canvas_set_bounds, GooCanvas_val, Double_val, Double_val, Double_val, Double_val, Unit)

CAMLprim value ml_goo_canvas_get_bounds(value c)
{
  double p[4];
  goo_canvas_get_bounds(GooCanvas_val(c), &p[0], &p[1], &p[2], &p[3]);
  return goo_copy_double_array(p, 4);
}

CAMLprim value ml_goo_canvas_convert_to_item_space(value c, value i, value vx, value vy)
{
  gdouble x = Double_val(vx) ;
  gdouble y = Double_val(vy) ;
  /* this function does not seem to work... so let's compute coordinates ourselves
    goo_canvas_convert_to_item_space(GooCanvas_val(c), GooCanvasItem_val(i), &x, &y) ;
  */
  /* FIXME: we should take anchor into account */
  gdouble v = 0.;
  GooCanvasItem* parent = goo_canvas_item_get_parent (GooCanvasItem_val(i)) ;
  while (parent) {
    g_object_get (parent, "x", &v, NULL);
    x = x - v ;
    g_object_get (parent, "y", &v, NULL);
    y = y - v ;
    parent = goo_canvas_item_get_parent (parent) ;
  }
  return double_pair(x, y);
}


CAMLprim value ml_goo_canvas_convert_from_item_space(value c, value i, value vx, value vy)
{
  gdouble x = Double_val(vx);
  gdouble y = Double_val(vy) ;
  /* this function does not seem to work... so let's compute coordinates ourselves
     goo_canvas_convert_from_item_space(GooCanvas_val(c), GooCanvasItem_val(i), &x, &y) ;
  */
  /* FIXME: we should take anchor into account */
  gdouble v = 0.;
  GooCanvasItem* parent = goo_canvas_item_get_parent (GooCanvasItem_val(i)) ;
  while (parent) {
    g_object_get (parent, "x", &v, NULL);
    x = x + v ;
    g_object_get (parent, "y", &v, NULL);
    y = y + v ;
    parent = goo_canvas_item_get_parent (parent) ;
  }
  return double_pair(x, y);
}

CAMLprim value ml_goo_canvas_convert_to_pixels(value c, value vx, value vy)
{
  gdouble x = Double_val(vx) ;
  gdouble y = Double_val(vy) ;
  goo_canvas_convert_to_pixels(GooCanvas_val(c), &x, &y);
  return (double_pair(x,y));
}
CAMLprim value ml_goo_canvas_convert_from_pixels(value c, value vx, value vy)
{
  gdouble x = Double_val(vx) ;
  gdouble y = Double_val(vy) ;
  goo_canvas_convert_from_pixels(GooCanvas_val(c), &x, &y);
  return (double_pair(x,y));
}

CAMLprim value ml_goo_canvas_text_new(value p, value text, value x, value y, value w)
{
  return Val_GooCanvasText_new(
    goo_canvas_text_new(
      GooCanvasItem_val(p),
      String_val(text),
      Double_val(x), Double_val(y), Double_val(w), GOO_CANVAS_ANCHOR_CENTER,
      NULL));
}

ML_1 (goo_canvas_item_remove, GooCanvasItem_val, Unit)
ML_2 (goo_canvas_item_raise, GooCanvasItem_val, GooCanvasItem_optval, Unit)

ML_1 (goo_canvas_item_get_n_children, GooCanvasItem_val, Val_int)
ML_2 (goo_canvas_item_remove_child, GooCanvasItem_val, Int_val, Unit)

CAMLprim value ml_goo_canvas_item_get_bounds(value c)
{
  GooCanvasBounds b;
  goo_canvas_item_get_bounds(GooCanvasItem_val(c),  &b);
  return goo_copy_bounds(b) ;
}

CAMLprim value ml_goo_canvas_item_set_parent(value i, value p)
{
  g_object_set (GooCanvasItem_val(i), "parent", GooCanvasItem_val(p), NULL) ;
}


CAMLprim value ml_goo_canvas_rect_new(value p, value x, value y, value w, value h)
{
  return Val_GooCanvasRect_new(
    goo_canvas_rect_new(
      GooCanvasItem_val(p),
      Double_val(x), Double_val(y), Double_val(w), Double_val(h),
      NULL));
}

CAMLprim value ml_goo_canvas_widget_new(value p, value wid, value x, value y, value w, value h)
{
  return Val_GooCanvasWidget_new(
    goo_canvas_widget_new(
      GooCanvasItem_val(p),
      GtkWidget_val(wid),
      Double_val(x), Double_val(y), Double_val(w), Double_val(h),
      NULL));
}
ML_bc6(ml_goo_canvas_widget_new)

CAMLprim value ml_goo_canvas_group_new(value p)
{
  GooCanvasItem *parent = Option_val(p, GooCanvasItem_val, NULL) ;
  return Val_GooCanvasGroup_new(
    goo_canvas_group_new(
      parent,
      NULL));
}

CAMLprim value ml_goo_canvas_points_new(value len, value points)
{
  int n = Int_val (len) ;
  GooCanvasPoints* p = goo_canvas_points_new(n) ;
  for (int i = 0 ; i < n ; i ++) { p->coords[i] = Double_field(points,i) ; }
  return Val_GooCanvasPoints_new(p);
}

CAMLprim value ml_goo_canvas_polyline_new(value p, value close_path)
{
  return Val_GooCanvasPolyline_new(
    goo_canvas_polyline_new(GooCanvasItem_val(p), Bool_val(close_path), 0, NULL));
}

CAMLprim value ml_goo_canvas_polyline_new_line(value p,
  value x1, value y1, value x2, value y2)
{
  return Val_GooCanvasPolyline_new(
    goo_canvas_polyline_new_line(GooCanvasItem_val(p),
              Double_val(x1), Double_val(y1), Double_val(x2), Double_val(y2), NULL));
}
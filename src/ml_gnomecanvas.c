/* $Id$ */

#include <string.h>

#include <gtk/gtk.h>
#include <libgnomecanvas/libgnomecanvas.h>

#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>
#include <caml/fail.h>

#include "wrappers.h"
#include "ml_gobject.h"
#include "ml_gdk.h"
#include "ml_gtk.h"

static inline value copy_two_doubles(double a, double b)
{
  CAMLparam0();
  CAMLlocal3(va, vb, v);
  va = copy_double(a);
  vb = copy_double(b);
  v = alloc_small(2, 0);
  Field(v, 0) = va;
  Field(v, 1) = vb;
  return v;
}

static inline value copy_double_array(double *a, size_t len)
{
  value v;
  register int i;
  v = alloc_small(len * Double_wosize, Double_array_tag);
  for(i=0; i<len; i++)
    Store_double_field(v, i, a[i]);
  return v;
}


/* Types stuff */
CAMLprim value ml_gnome_canvas_register_types(value unit)
{
  GType tid[15];
  value v = alloc_small(15, 0);
  Field(v,  0) = Val_GType(GNOME_TYPE_CANVAS);
  Field(v,  1) = Val_GType(GNOME_TYPE_CANVAS_BPATH);
  Field(v,  2) = Val_GType(GNOME_TYPE_CANVAS_WIDGET);
  Field(v,  3) = Val_GType(GNOME_TYPE_CANVAS_ELLIPSE);
  Field(v,  4) = Val_GType(GNOME_TYPE_CANVAS_GROUP);
  Field(v,  5) = Val_GType(GNOME_TYPE_CANVAS_ITEM);
  Field(v,  6) = Val_GType(GNOME_TYPE_CANVAS_LINE);
  Field(v,  7) = Val_GType(GNOME_TYPE_CANVAS_PIXBUF);
  Field(v,  8) = Val_GType(GNOME_TYPE_CANVAS_POINTS);
  Field(v,  9) = Val_GType(GNOME_TYPE_CANVAS_POLYGON);
  Field(v, 10) = Val_GType(GNOME_TYPE_CANVAS_RE);
  Field(v, 11) = Val_GType(GNOME_TYPE_CANVAS_RECT);
  Field(v, 12) = Val_GType(GNOME_TYPE_CANVAS_RICH_TEXT);
  Field(v, 13) = Val_GType(GNOME_TYPE_CANVAS_SHAPE);
  Field(v, 14) = Val_GType(GNOME_TYPE_CANVAS_TEXT);
  /* GNOME_TYPE_CANVAS_CLIPGROUP; */
  return v;
}


/* GnomeCanvas */

#define GnomeCanvas_val(val)      check_cast(GNOME_CANVAS,val)
#define GnomeCanvasGroup_val(val) check_cast(GNOME_CANVAS_GROUP,val)
#define GnomeCanvasItem_val(val)  check_cast(GNOME_CANVAS_ITEM,val)

ML_0 (gnome_canvas_new, Val_GtkWidget_sink)
ML_0 (gnome_canvas_new_aa, Val_GtkWidget_sink)
ML_1 (gnome_canvas_root, GnomeCanvas_val, Val_GtkAny)
ML_5 (gnome_canvas_set_scroll_region, GnomeCanvas_val, Double_val, Double_val, Double_val, Double_val, Unit)

CAMLprim value ml_gnome_canvas_get_scroll_region(value c)
{
  double p[4];
  gnome_canvas_get_scroll_region(GnomeCanvas_val(c),  &p[0], &p[1], &p[2], &p[3]);
  return copy_double_array(p, 4);
}

ML_2 (gnome_canvas_set_center_scroll_region, GnomeCanvas_val, Bool_val, Unit)
ML_1 (gnome_canvas_get_center_scroll_region, GnomeCanvas_val, Val_bool)

ML_2 (gnome_canvas_set_pixels_per_unit, GnomeCanvas_val, Double_val, Unit)

ML_3 (gnome_canvas_scroll_to, GnomeCanvas_val, Int_val, Int_val, Unit)
CAMLprim value ml_gnome_canvas_get_scroll_offsets(value c)
{
  value v;
  int cx, cy;
  gnome_canvas_get_scroll_offsets(GnomeCanvas_val(c), &cx, &cy);
  v = alloc_small(2, 0);
  Field(v, 0) = Val_int(cx);
  Field(v, 1) = Val_int(cy);
  return v;
}

ML_1 (gnome_canvas_update_now, GnomeCanvas_val, Unit)

CAMLprim value ml_gnome_canvas_get_item_at(value c, value x, value y)
{
  GnomeCanvasItem *it = gnome_canvas_get_item_at(GnomeCanvas_val(c), Double_val(x), Double_val(y));
  if(! it)
    raise_not_found();
  return Val_GtkAny(it);
}
  
/* gnome_canvas_request_redraw_uta */
/* gnome_canvas_request_redraw */

CAMLprim value ml_gnome_canvas_w2c_affine(value c)
{
  GnomeCanvas *canvas = GnomeCanvas_val(c);
  value v = alloc_small(6 * Double_wosize, Double_array_tag);
  gnome_canvas_w2c_affine(canvas, (double *)v);
  return v;
}

CAMLprim value ml_gnome_canvas_w2c(value c, value wx, value wy)
{
  value v;
  int cx, cy;
  gnome_canvas_w2c(GnomeCanvas_val(c), Double_val(wx), Double_val(wy), &cx, &cy);
  v = alloc_small(2, 0);
  Field(v, 0) = Val_int(cx);
  Field(v, 1) = Val_int(cy);
  return v;
}

CAMLprim value ml_gnome_canvas_w2c_d(value c, value wx, value wy)
{
  double cx, cy;
  gnome_canvas_w2c_d(GnomeCanvas_val(c), Double_val(wx), Double_val(wy), &cx, &cy);
  return copy_two_doubles(cx, cy);
}

CAMLprim value ml_gnome_canvas_c2w(value c, value cx, value cy)
{
  double wx, wy;
  gnome_canvas_w2c_d(GnomeCanvas_val(c), Int_val(cx), Int_val(cy), &wx, &wy);
  return copy_two_doubles(wx, wy);
}

CAMLprim value ml_gnome_canvas_window_to_world(value c, value winx, value winy)
{
  double wox, woy;
  gnome_canvas_window_to_world(GnomeCanvas_val(c), Double_val(winx), Double_val(winy), &wox, &woy);
  return copy_two_doubles(wox, woy);
}

CAMLprim value ml_gnome_canvas_world_to_window(value c, value wox, value woy)
{
  double winx, winy;
  gnome_canvas_world_to_window(GnomeCanvas_val(c), Double_val(wox), Double_val(woy), &winx, &winy);
  return copy_two_doubles(winx, winy);
}

/* gnome_canvas_get_color */
/* gnome_canvas_get_color_pixel */
/* gnome_canvas_set_stipple_origin */
/* gnome_canvas_set_dither */
/* gnome_canvas_get_dither */


/* GnomeCanvasItem */

CAMLprim value ml_gnome_canvas_item_new(value p, value type)
{
  return Val_GtkAny_sink(gnome_canvas_item_new(GnomeCanvasGroup_val(p), GType_val(type), NULL));
}

Make_Extractor (gnome_canvas_item, GnomeCanvasItem_val, parent, Val_GtkAny)

CAMLprim value ml_gnome_canvas_item_set(value i, value key_v_list)
{
  GnomeCanvasItem *item = GnomeCanvasItem_val(i);
  value l = key_v_list;
  while(Is_block(l)) {
    value cell = Field(l, 0);
    const char *key   = String_val(Field(cell, 0));
    const GValue *arg = GValue_val(Field(cell, 1));
    g_object_set_property(G_OBJECT(item), key, arg);
    l = Field(l, 1);
  }
  gnome_canvas_item_set(GnomeCanvasItem_val(i), NULL);
  return Val_unit;
}

ML_3 (gnome_canvas_item_move, GnomeCanvasItem_val, Double_val, Double_val, Unit)
/* gnome_canvas_item_affine_relative */
/* gnome_canvas_item_affine_absolute */
ML_2 (gnome_canvas_item_raise, GnomeCanvasItem_val, Int_val, Unit)
ML_2 (gnome_canvas_item_lower, GnomeCanvasItem_val, Int_val, Unit)
ML_1 (gnome_canvas_item_raise_to_top, GnomeCanvasItem_val, Unit)
ML_1 (gnome_canvas_item_lower_to_bottom, GnomeCanvasItem_val, Unit)
ML_1 (gnome_canvas_item_show, GnomeCanvasItem_val, Unit)
ML_1 (gnome_canvas_item_hide, GnomeCanvasItem_val, Unit)

ML_4 (gnome_canvas_item_grab, GnomeCanvasItem_val, Flags_Event_mask_val, GdkCursor_val, Int32_val, Unit)
ML_2 (gnome_canvas_item_ungrab, GnomeCanvasItem_val, Int32_val, Unit)

CAMLprim value ml_gnome_canvas_item_w2i(value i, value x, value y)
{
  double ox = Double_val(x);
  double oy = Double_val(y);
  gnome_canvas_item_w2i(GnomeCanvasItem_val(i), &ox, &oy);
  return copy_two_doubles(ox, oy);
}

CAMLprim value ml_gnome_canvas_item_i2w(value i, value x, value y)
{
  double ox = Double_val(x);
  double oy = Double_val(y);
  gnome_canvas_item_i2w(GnomeCanvasItem_val(i), &ox, &oy);
  return copy_two_doubles(ox, oy);
}
/* gnome_canvas_item_i2w_affine */
/* gnome_canvas_item_i2c_affine */
ML_2 (gnome_canvas_item_reparent, GnomeCanvasItem_val, GnomeCanvasGroup_val, Unit)
ML_1 (gnome_canvas_item_grab_focus, GnomeCanvasItem_val, Unit)

CAMLprim value ml_gnome_canvas_item_get_bounds(value i)
{
  double p[4];
  gnome_canvas_item_get_bounds(GnomeCanvasItem_val(i), &p[0], &p[1], &p[2], &p[3]);
  return copy_double_array(p, 4);
}
/* gnome_canvas_item_request_update */


/* GnomeCanvasGroup */

CAMLprim value ml_gnome_canvas_group_get_items(value cg)
{
  CAMLparam0();
  CAMLlocal1(v);
  GList *item_list = GnomeCanvasGroup_val(cg)->item_list_end;
  v = Val_int(0);
  while(item_list) {
    value tmp = alloc_small(2, 0);
    Field(tmp, 0) = Val_GtkAny(item_list->data);
    Field(tmp, 1) = v;
    v = tmp;
    item_list = item_list->prev;
  }
  CAMLreturn(v);
}


/* Converion functions for properties */
#include "gtk_tags.h"

CAMLprim value ml_gnome_canvas_convert_tags(value tag)
{
  lookup_info *tables[] = { ml_table_anchor_type };
  return Val_int(ml_lookup_to_c( tables[ Tag_val(tag) ], Field(tag, 0)));
}

CAMLprim value ml_gnome_canvas_convert_points(value arr)
{
  int len = Wosize_val(arr) / Double_wosize;
  GnomeCanvasPoints *p;
  GValue *v;
  if(len % 2)
    invalid_argument("odd number of coords");
  p = gnome_canvas_points_new(len / 2);
  memcpy(p->coords, (double *)arr, Wosize_val(arr) * sizeof (value));
  v = g_malloc(sizeof *v);
  v->g_type = 0;
  g_value_init(v, GNOME_TYPE_CANVAS_POINTS);
  g_value_set_boxed_take_ownership(v, p);
  return Val_GValue_new(v);
}

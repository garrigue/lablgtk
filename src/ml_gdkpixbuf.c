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
#include <gdk/gdk.h>
#include <gdk-pixbuf/gdk-pixbuf.h>
#include <gdk-pixbuf/gdk-pixdata.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>
#include <caml/fail.h>
#include <caml/intext.h>

#include "wrappers.h"
#include "ml_glib.h"
#include "ml_gpointer.h"
#include "ml_gobject.h"
#include "ml_gdk.h"
#include "ml_gdkpixbuf.h"
#include "gdk_tags.h"
#include "gdkpixbuf_tags.h"

#include "gdkpixbuf_tags.c"

/* custom block with serialization for GdkPixbufs */
static void ml_final_GdkPixbuf (value val)
{ 
  ml_g_object_unref_later (GObject_val(val)); 
}

static gboolean pixbuf_marshal_use_rle;

CAMLprim value ml_gdk_pixbuf_set_marshal_use_rle (value v)
{
  pixbuf_marshal_use_rle = Bool_val (v);
  return Val_unit;
}

static void ml_GdkPixbuf_serialize (value v, unsigned long *wsize_32, unsigned long *wsize_64)
{
  GdkPixbuf *pb = GdkPixbuf_val(v);
  GdkPixdata pixdata;
  guint8 *stream, *pixels;
  guint len;
  pixels = gdk_pixdata_from_pixbuf (&pixdata, pb, pixbuf_marshal_use_rle);
  stream = gdk_pixdata_serialize (&pixdata, &len);
  serialize_int_4 (len);
  serialize_block_1 (stream, len);
  g_free (stream);
  g_free (pixels);
  *wsize_32 = 4;
  *wsize_64 = 8;
}

static unsigned long ml_GdkPixbuf_deserialize (void *dst)
{
  GError *error = NULL;
  GdkPixdata pixdata;
  GdkPixbuf *pb;
  guint8 *stream;
  guint len;

  len = deserialize_uint_4();
  stream = stat_alloc (len);
  deserialize_block_1 (stream, len);
  gdk_pixdata_deserialize (&pixdata, len, stream, &error);
  if (error) goto out;
  pb = gdk_pixbuf_from_pixdata (&pixdata, TRUE, &error);
  if (error) goto out;
  *(GdkPixbuf **)dst = pb;

 out:
  stat_free (stream);
  if (error != NULL)
    {
      char *msg;
      GEnumClass *class = G_ENUM_CLASS (g_type_class_peek (GDK_TYPE_PIXBUF_ERROR));
      GEnumValue *val   = g_enum_get_value (class, error->code);
      msg = val ? (char*)val->value_name : "";
      g_error_free (error);
      deserialize_error (msg);
    }
  return sizeof pb;
}

static struct custom_operations ml_custom_GdkPixbuf = { 
  "GdkPixbuf/2.0/",
  ml_final_GdkPixbuf,
  custom_compare_default,
  custom_hash_default,
  ml_GdkPixbuf_serialize, ml_GdkPixbuf_deserialize
};

value Val_GdkPixbuf_ (GdkPixbuf *pb, gboolean ref)
{ 
  GdkPixbuf **p;
  value ret; 
  if (pb == NULL) ml_raise_null_pointer(); 
  ret = alloc_custom (&ml_custom_GdkPixbuf, sizeof pb, 
		      100, 1000);
  p = Data_custom_val (ret);
  *p = ref ? g_object_ref (pb) : pb;
  return ret; 
}

CAMLprim value ml_gdkpixbuf_init(value unit)
{
  ml_register_exn_map (GDK_PIXBUF_ERROR, "gdk_pixbuf_error");
  register_custom_operations (&ml_custom_GdkPixbuf);
  return Val_unit;
}

/* GdkPixbuf accessors */
ML_1(gdk_pixbuf_get_n_channels, GdkPixbuf_val, Val_int)
ML_1(gdk_pixbuf_get_has_alpha, GdkPixbuf_val, Val_bool)
ML_1(gdk_pixbuf_get_bits_per_sample, GdkPixbuf_val, Val_int)
ML_1(gdk_pixbuf_get_width, GdkPixbuf_val, Val_int)
ML_1(gdk_pixbuf_get_height, GdkPixbuf_val, Val_int)
ML_1(gdk_pixbuf_get_rowstride, GdkPixbuf_val, Val_int)

CAMLprim value ml_gdk_pixbuf_get_pixels (value pixbuf)
{
    long pixels = (long)gdk_pixbuf_get_pixels (GdkPixbuf_val(pixbuf));
    unsigned int ofs = pixels & (sizeof(value)-1);
    value ret = alloc_small(2,0);
    Field(ret,0) = (value)(pixels - ofs);
    Field(ret,1) = Val_int(ofs);
    return ret;
}

/* Creation */

ML_5(gdk_pixbuf_new, GDK_COLORSPACE_RGB Ignore, Int_val, Int_val,
     Int_val, Int_val, Val_GdkPixbuf_new)
ML_1(gdk_pixbuf_copy, GdkPixbuf_val, Val_GdkPixbuf_new)
CAMLprim value ml_gdk_pixbuf_new_from_file(value f)
{
    GError *err = NULL;
    GdkPixbuf *res = gdk_pixbuf_new_from_file(String_val(f), &err);
    if (err) ml_raise_gerror(err);
    return Val_GdkPixbuf_new(res);
}
#ifdef HASGTK24
CAMLprim value ml_gdk_pixbuf_new_from_file_at_size(value f, value w, value h)
{
    GError *err = NULL;
    GdkPixbuf *res = gdk_pixbuf_new_from_file_at_size(String_val(f), 
						      Int_val(w), Int_val(h), 
						      &err);
    if (err) ml_raise_gerror(err);
    return Val_GdkPixbuf_new(res);
}

CAMLprim value ml_gdk_pixbuf_get_file_info(value f)
{
  CAMLparam0();
  CAMLlocal1(v);
  gint w, h;
  GdkPixbufFormat *fmt;
  fmt = gdk_pixbuf_get_file_info (String_val (f), &w, &h);
  v = alloc_tuple(3);
  Store_field(v, 0, copy_string(gdk_pixbuf_format_get_name(fmt)));
  Store_field(v, 1, Val_int(w));
  Store_field(v, 2, Val_int(h));
  CAMLreturn(v);
}
#else
Unsupported_24 (gdk_pixbuf_new_from_file_at_size)
Unsupported_24 (gdk_pixbuf_get_file_info)
#endif
ML_1(gdk_pixbuf_new_from_xpm_data, (const char**), Val_GdkPixbuf_new)

static void ml_gdk_pixbuf_destroy_notify (guchar *pixels, gpointer data)
{
    ml_global_root_destroy(data);
}
CAMLprim value ml_gdk_pixbuf_new_from_data(value data, value has_alpha,
				 value bits, value w, value h, value rs)
{
    value *root = ml_global_root_new(data);
    GdkPixbuf *pixbuf =
	gdk_pixbuf_new_from_data(ml_gpointer_base(*root), GDK_COLORSPACE_RGB,
				 Int_val(has_alpha), Int_val(bits),
				 Int_val(w), Int_val(h), Int_val(rs),
				 ml_gdk_pixbuf_destroy_notify, root);
    return Val_GdkPixbuf_new(pixbuf);
}
ML_bc6(ml_gdk_pixbuf_new_from_data)

/* Adding an alpha channel */
ML_5(gdk_pixbuf_add_alpha, GdkPixbuf_val, Int_val, Int_val, Int_val, Int_val,
     Val_GdkPixbuf_new)

/* Fill a pixbuf */
ML_2(gdk_pixbuf_fill, GdkPixbuf_val, Int32_val, Unit)

/* Modifies saturation and optionally pixelates */
ML_4(gdk_pixbuf_saturate_and_pixelate, GdkPixbuf_val, GdkPixbuf_val, Double_val, Bool_val, Unit)

/* Copy an area */
ML_8(gdk_pixbuf_copy_area, GdkPixbuf_val, Int_val, Int_val, Int_val, Int_val,
     GdkPixbuf_val, Int_val, Int_val, Unit)
ML_bc8(ml_gdk_pixbuf_copy_area)

/* Create a sub-region */
ML_5(gdk_pixbuf_new_subpixbuf, GdkPixbuf_val, Int_val, Int_val, Int_val, Int_val, Val_GdkPixbuf_new)


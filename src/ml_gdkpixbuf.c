/* $Id$ */

#include <string.h>
#include <gdk/gdk.h>
#include <gdk-pixbuf/gdk-pixbuf.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>
#include <caml/fail.h>

#include "wrappers.h"
#include "ml_glib.h"
#include "ml_gpointer.h"
#include "ml_gobject.h"
#include "ml_gdk.h"
#include "ml_gdkpixbuf.h"
#include "gdk_tags.h"
#include "gdkpixbuf_tags.h"

#include "gdkpixbuf_tags.c"


/* Reference counting (use GObject) */
#define Val_GdkPixbuf_noref(val) (Val_GObject_new((GObject*)(val)))

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
    unsigned int ofs = pixels % sizeof(value);
    value ret = alloc_small(2,0);
    Field(ret,0) = pixels - ofs;
    Field(ret,1) = Val_int(ofs);
    return ret;
}

/* Creation */

ML_5(gdk_pixbuf_new, GDK_COLORSPACE_RGB Ignore, Int_val, Int_val,
     Int_val, Int_val, Val_GdkPixbuf_noref)
ML_1(gdk_pixbuf_copy, GdkPixbuf_val, Val_GdkPixbuf_noref)
CAMLprim value ml_gdk_pixbuf_new_from_file(value f)
{
    GError *err = NULL;
    GdkPixbuf *res = gdk_pixbuf_new_from_file(String_val(f), &err);
    if (err) ml_raise_gerror(err);
    return Val_GdkPixbuf(res);
}
ML_1(gdk_pixbuf_new_from_xpm_data, (const char**), Val_GdkPixbuf_noref)

void ml_gdk_pixbuf_destroy_notify (guchar *pixels, gpointer data)
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
    return Val_GdkPixbuf_noref(pixbuf);
}
ML_bc6(ml_gdk_pixbuf_new_from_data)

/* Adding an alpha channel */
ML_5(gdk_pixbuf_add_alpha, GdkPixbuf_val, Int_val, Int_val, Int_val, Int_val,
     Val_GdkPixbuf_noref)

/* Copy an area */
ML_8(gdk_pixbuf_copy_area, GdkPixbuf_val, Int_val, Int_val, Int_val, Int_val,
     GdkPixbuf_val, Int_val, Int_val, Unit)
ML_bc8(ml_gdk_pixbuf_copy_area)

/* Rendering to a drawable */
ML_9(gdk_pixbuf_render_threshold_alpha, GdkPixbuf_val, GdkBitmap_val,
     Int_val, Int_val, Int_val, Int_val, Int_val, Int_val, Int_val, Unit)
ML_bc9(ml_gdk_pixbuf_render_threshold_alpha)
ML_12(gdk_pixbuf_render_to_drawable, GdkPixbuf_val, GdkDrawable_val,
      GdkGC_val, Int_val, Int_val, Int_val, Int_val, Int_val, Int_val,
      GdkRgbDither_val, Int_val, Int_val, Unit)
ML_bc12(ml_gdk_pixbuf_render_to_drawable)
ML_13(gdk_pixbuf_render_to_drawable_alpha, GdkPixbuf_val, GdkDrawable_val,
      Int_val, Int_val, Int_val, Int_val, Int_val, Int_val,
      Alpha_mode_val, Int_val, GdkRgbDither_val, Int_val, Int_val, Unit)
ML_bc13(ml_gdk_pixbuf_render_to_drawable_alpha)

CAMLprim value ml_gdk_pixbuf_render_pixmap_and_mask (value pixbuf, value thr)
{
    CAMLparam0();
    CAMLlocal2(vpm,vmask);
    value ret;
    GdkPixmap *pm;
    GdkBitmap *mask;
    gdk_pixbuf_render_pixmap_and_mask(GdkPixbuf_val(pixbuf), &pm, &mask,
				      Int_val(thr));
    vpm = Val_GdkPixmap_no_ref(pm);
    vmask = Val_option(mask,Val_GdkBitmap_no_ref);
    ret = alloc_small(2,0);
    Field(ret,0) = vpm;
    Field(ret,1) = vmask;
    CAMLreturn(ret);
}

/* Fetching a region from a drawable */
ML_9(gdk_pixbuf_get_from_drawable, GdkPixbuf_val, GdkDrawable_val,
     GdkColormap_val, Int_val, Int_val, Int_val, Int_val, Int_val, Int_val,
     Unit)
ML_bc9(ml_gdk_pixbuf_get_from_drawable)

/* Scaling */
ML_11(gdk_pixbuf_scale, GdkPixbuf_val, GdkPixbuf_val, Int_val, Int_val,
      Int_val, Int_val, Double_val, Double_val, Double_val, Double_val,
      Interpolation_val, Unit)
ML_bc11(ml_gdk_pixbuf_scale)
ML_12(gdk_pixbuf_composite, GdkPixbuf_val, GdkPixbuf_val, Int_val, Int_val,
      Int_val, Int_val, Double_val, Double_val, Double_val, Double_val,
      Interpolation_val, Int_val, Unit)
ML_bc12(ml_gdk_pixbuf_composite)

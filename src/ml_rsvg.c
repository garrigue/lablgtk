/* $Id$ */
/* Author: Olivier Andrieu */

#include <gdk-pixbuf/gdk-pixbuf.h>
#include <librsvg/rsvg.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>
#include <caml/fail.h>

#include "wrappers.h"
#include "ml_gdkpixbuf.h"
#include "ml_gobject.h"

static
void ml_rsvg_size_callback(gint *w, gint *h, gpointer user_data)
{
  value *cb = user_data;
  value r;
  r = callback2(*cb, Val_int(*w), Val_int(*h));
  *w = Int_val(Field(r, 0));
  *h = Int_val(Field(r, 1));
}

ML_0(rsvg_handle_new, Val_pointer)

#define RsvgHandle_val(val) ((RsvgHandle *)Pointer_val(val))

CAMLprim value ml_rsvg_handle_set_size_callback(value vh, value cb)
{
  RsvgHandle *h = RsvgHandle_val(vh);
  value *u_data = ml_global_root_new(cb);
  rsvg_handle_set_size_callback(h, ml_rsvg_size_callback, u_data, ml_global_root_destroy);
  return Val_unit;
}

ML_1(rsvg_handle_free, RsvgHandle_val, Unit)

CAMLprim value ml_rsvg_handle_close(value h)
{
  if(rsvg_handle_close(RsvgHandle_val(h), NULL) != TRUE)
    failwith("rsvg_handle_close");
  return Val_unit;
}

static inline 
void check_substring(value s, value o, value l)
{
  if(Int_val(o) < 0 || Int_val(l) < 0 || 
     Int_val(o) + Int_val(l) > string_length(s))
    invalid_argument("bad substring");
}

CAMLprim value ml_rsvg_handle_write(value h, value s, value off, value len)
{
  check_substring(s, off, len);
  if(rsvg_handle_write(RsvgHandle_val(h), 
		       String_val(s)+Int_val(off), Int_val(len), NULL) != TRUE)
    failwith("rsvg_handle_write");
  return Val_unit;
}

ML_1(rsvg_handle_get_pixbuf, RsvgHandle_val, Val_GdkPixbuf)

ML_2(rsvg_handle_set_dpi, RsvgHandle_val, Double_val, Unit)
ML_1(rsvg_set_default_dpi, Double_val, Unit)

/* File: cairo_pango_stubs.c

   Copyright (C) 2018-

     Christophe Troestler <Christophe.Troestler@umons.ac.be>
     WWW: http://math.umons.ac.be/an/software/

   This library is free software; you can redistribute it and/or modify
   it under the terms of the GNU Lesser General Public License version 3 or
   later as published by the Free Software Foundation.  See the file
   LICENCE for more details.

   This library is distributed in the hope that it will be useful, but
   WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the file
   LICENSE for more details. */

#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/fail.h>
#include <caml/custom.h>

#include <gdk/gdk.h>
/* OCaml labgtk stubs */
#include "wrappers.h"
#include "ml_gobject.h"
#include "ml_pango.h"

/* OCaml Cairo bindings */
#include "cairo_ocaml.h"

/* https://developer.gnome.org/pango/stable/pango-Cairo-Rendering.html */

#define ALLOC(name) alloc_custom(&caml_##name##_ops, sizeof(void*), 1, 50)

#define DO2_NOALLOC(fn, of_val1, of_val2)                               \
  CAMLexport value caml_##fn (value v1, value v2)                       \
  {                                                                     \
    /* noalloc */                                                       \
    fn(of_val1(v1), of_val2(v2));                                       \
    return(Val_unit);                                                   \
  }

#define DO5_NOALLOC(fn, of_val1, of_val2, of_val3, of_val4, of_val5)    \
  CAMLexport value caml_##fn (value v1, value v2, value v3, value v4,   \
                              value v5)                                 \
  {                                                                     \
    /* noalloc */                                                       \
    fn(of_val1(v1), of_val2(v2), of_val3(v3), of_val4(v4), of_val5(v5)); \
    return(Val_unit);                                                   \
  }

#define PANGO_CAIRO_FONT_MAP_VAL(v) check_cast(PANGO_CAIRO_FONT_MAP, v)
#define VAL_PANGO_CAIRO_FONT_MAP Val_GAnyObject

#define PANGO_CAIRO_FONT_VAL(v) check_cast(PANGO_CAIRO_FONT, v)
#define VAL_PANGO_CAIRO_FONT Val_GAnyObject

CAMLexport value caml_pango_cairo_font_map_get_default(value unit)
{
  PangoFontMap *fm;
  fm = pango_cairo_font_map_get_default();
  return(Val_PangoFontMap(fm));
}

CAMLexport value caml_pango_cairo_font_map_set_default(value vfm)
{
  /* noalloc */
  pango_cairo_font_map_set_default(PANGO_CAIRO_FONT_MAP_VAL(vfm));
  return(Val_unit);
}

CAMLexport value caml_pango_cairo_font_map_new(value unit)
{
  CAMLparam1(unit);
  PangoFontMap *fm = pango_cairo_font_map_new();
  CAMLreturn(Val_PangoFontMap(fm));
}

CAMLexport value caml_pango_cairo_font_map_new_for_font_type(value vft)
{
  CAMLparam1(vft);
  PangoFontMap *fm =
    pango_cairo_font_map_new_for_font_type(FONT_TYPE_VAL(vft));
  CAMLreturn(Val_PangoFontMap(fm));
}

CAMLexport value caml_pango_cairo_font_map_get_font_type (value vfm)
{
  CAMLparam1(vfm);
  cairo_font_type_t ft =
    pango_cairo_font_map_get_font_type(PANGO_CAIRO_FONT_MAP_VAL(vfm));
  CAMLreturn(VAL_FONT_TYPE(ft));
}

DO2_NOALLOC(pango_cairo_font_map_set_resolution,
            PANGO_CAIRO_FONT_MAP_VAL, Double_val)

CAMLexport value caml_pango_cairo_font_map_get_resolution (value vfm)
{
  CAMLparam1(vfm);
  double dpi =
    pango_cairo_font_map_get_resolution(PANGO_CAIRO_FONT_MAP_VAL(vfm));
  CAMLreturn(caml_copy_double(dpi));
}

CAMLexport value caml_cairo_pango_font_map_create_context (value vfm)
{
  CAMLparam1(vfm);
  /* 'pango_cairo_font_map_create_context' is deprecated in favor of
   * 'pango_font_map_create_context' */
  PangoContext *c =
    pango_font_map_create_context(PangoFontMap_val(vfm));
  CAMLreturn(Val_PangoContext(c));
}

CAMLexport value caml_pango_cairo_font_get_scaled_font (value vfont)
{
  CAMLparam1(vfont);
  CAMLlocal1(vf);
  cairo_scaled_font_t *f =
    pango_cairo_font_get_scaled_font(PANGO_CAIRO_FONT_VAL(vfont));
  vf = ALLOC(scaled_font);
  SCALED_FONT_VAL(vf) = f;
  CAMLreturn(vf);
}

DO2_NOALLOC(pango_cairo_context_set_resolution,PangoContext_val, Double_val)

CAMLexport value caml_pango_cairo_context_get_resolution (value vc)
{
  CAMLparam1(vc);
  double dpi = pango_cairo_context_get_resolution(PangoContext_val(vc));
  CAMLreturn(caml_copy_double(dpi));
}

DO2_NOALLOC(pango_cairo_context_set_font_options,
            PangoContext_val, FONT_OPTIONS_VAL)

CAMLexport value caml_pango_cairo_context_get_font_options (value vc)
{
  CAMLparam1(vc);
  CAMLlocal1(vfo);
  const cairo_font_options_t *fo =
    pango_cairo_context_get_font_options(PangoContext_val(vc));
  vfo = ALLOC(font_options);
  FONT_OPTIONS_VAL(vfo) = (cairo_font_options_t *) fo;
  CAMLreturn(vfo);
}

CAMLexport value caml_pango_cairo_create_context (value vcr)
{
  CAMLparam1(vcr);
  PangoContext *c = pango_cairo_create_context(CAIRO_VAL(vcr));
  CAMLreturn(Val_PangoContext(c));
}

DO2_NOALLOC(pango_cairo_update_context, CAIRO_VAL, PangoContext_val)

CAMLexport value caml_pango_cairo_create_layout (value vcr)
{
  CAMLparam1(vcr);
  PangoLayout *l = pango_cairo_create_layout(CAIRO_VAL(vcr));
  CAMLreturn(Val_PangoLayout(l));
}

DO2_NOALLOC(pango_cairo_update_layout, CAIRO_VAL, PangoLayout_val)

DO2_NOALLOC(pango_cairo_show_layout, CAIRO_VAL, PangoLayout_val)

DO5_NOALLOC(pango_cairo_show_error_underline,
            CAIRO_VAL, Double_val, Double_val, Double_val, Double_val)

DO2_NOALLOC(pango_cairo_layout_path, CAIRO_VAL, PangoLayout_val)

DO5_NOALLOC(pango_cairo_error_underline_path,
            CAIRO_VAL, Double_val, Double_val, Double_val, Double_val)

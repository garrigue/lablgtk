/* $Id$ */


#include <pango/pango.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>
#include <caml/fail.h>
#include <caml/custom.h>
#include "wrappers.h"
#include "pango_tags.h"


#define PangoFontDescription_val(val) ((PangoFontDescription*)Pointer_val(val))
value Val_PangoFontDescription(PangoFontDescription* it);

value ml_PangoStyle_Val (value val) ;

/* $Id$ */


#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>
#include <caml/fail.h>
#include <caml/custom.h>

#include "wrappers.h"
#include <pango/pango.h>

#define PangoFontDescription_val(val) ((PangoFontDescription*)Pointer_val(val))
value Val_PangoFontDescription(PangoFontDescription* it);

/* $Id$ */

#include <strings.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>

#include "wrappers.h"

value copy_memblock (void *src, asize_t size)
{
    value ret = alloc_shr ((size-1)/sizeof(value)+1, Abstract_tag);
    memcpy ((void *)ret, src, size);
    return ret;
}

void ml_raise_null_pointer ()
{
  static value * exn = NULL;
  if (exn == NULL)
      exn = caml_named_value ("null_pointer");
  raise_constant (*exn);
}   

/* $Id$ */

#include <strings.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>

#include "wrappers.h"

value copy_memblock_indirected (void *src, asize_t size)
{
    value ret = alloc_shr ((size-1)/sizeof(value)+3, Abstract_tag);
    if (!src) ml_raise_null_pointer ();
    
    Field(ret,1) = (value)&Field(ret,2);
    memcpy (&Field(ret,2), src, size);
    return ret;
}

void ml_raise_null_pointer ()
{
  static value * exn = NULL;
  if (exn == NULL)
      exn = caml_named_value ("null_pointer");
  raise_constant (*exn);
}   

value Val_pointer (void *ptr)
{
    value ret = alloc (2, Abstract_tag);
    if (!ptr) ml_raise_null_pointer ();
    Field(ret,1) = (value)ptr;
    return ret;
}

value copy_string_check (const char*str)
{
    if (!str) ml_raise_null_pointer ();
    return copy_string ((char*) str);
}

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

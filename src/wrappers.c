/* $Id$ */

#include <strings.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>
#include <caml/fail.h>

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

value ml_lookup_from_c (lookup_info *table, int data)
{
    int i;
    for (i = 1; i < table[0].data; i++)
	if (table[i].data == data) return table[i].key;
    invalid_argument ("ml_lookup_from_c");
}
    
int ml_lookup_to_c (lookup_info *table, value key)
{
    int first = 1, last = table[0].data, current;

    while (last - first > 4) {
	current = (first+last)/2;
	if (table[current].key == key) return table[current].data;
	if (table[current].key > key) last = current - 1;
	else first = current + 1;
    }
    for ( ; first <= last; first++)
	if (table[first].key == key) return table[first].data;
    invalid_argument ("ml_lookup_to_c");
}

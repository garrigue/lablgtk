/* $Id$ */

#include <string.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>
#include <caml/fail.h>
#include <glib.h>

#include "wrappers.h"

value copy_memblock_indirected (void *src, asize_t size)
{
    value ret = alloc (Wosize_asize(size)+2, Abstract_tag);
    if (!src) ml_raise_null_pointer ();
    
    Field(ret,1) = 2;
    memcpy (&Field(ret,2), src, size);
    return ret;
}

value alloc_memblock_indirected (asize_t size)
{
    value ret = alloc (Wosize_asize(size)+2, Abstract_tag);
    Field(ret,1) = 2;
    return ret;
}

value copy_memblock_indirected_shr (void *src, asize_t size)
{
    value ret = alloc_shr (Wosize_asize(size)+2, Abstract_tag);
    if (!src) ml_raise_null_pointer ();
    
    Field(ret,1) = 2;
    memcpy (&Field(ret,2), src, size);
    return ret;
}

value ml_some (value v)
{
     CAMLparam1(v);
     value ret = alloc_small(1,0);
     Field(ret,0) = v;
     CAMLreturn(ret);
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
    value ret = alloc_small (2, Abstract_tag);
    if (!ptr) ml_raise_null_pointer ();
    Field(ret,1) = (value)ptr;
    return ret;
}

value copy_string_check (const char*str)
{
    if (!str) ml_raise_null_pointer ();
    return copy_string ((char*) str);
}

value copy_string_or_null (const char*str)
{
    return copy_string (str ? (char*) str : "");
}

value copy_string_g_free (char *str)
{
    value ret = copy_string (str);
    g_free (str);
    return ret;
}

value *ml_global_root_new (value v)
{
    value *p = stat_alloc(sizeof(value));
    *p = v;
    register_global_root (p);
    return p;
}

void ml_global_root_destroy (void *data)
{
    remove_global_root ((value *)data);
    stat_free (data);
}

value ml_lookup_from_c (lookup_info *table, int data)
{
    int i;
    for (i = table[0].data; i > 0; i--)
	if (table[i].data == data) return table[i].key;
    invalid_argument ("ml_lookup_from_c");
}
    
int ml_lookup_to_c (lookup_info *table, value key)
{
    int first = 1, last = table[0].data, current;
    while (first < last) {
	current = (first+last)/2;
	if (table[current].key >= key) last = current;
	else first = current + 1;
    }
    if (table[first].key == key) return table[first].data;
    invalid_argument ("ml_lookup_to_c");
}

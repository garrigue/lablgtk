/* $Id$ */

#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>
#include <string.h>

#include "wrappers.h"
#include "ml_gpointer.h"

CAMLprim value ml_get_null (value unit) { return 0L; }

CAMLprim value ml_string_at_pointer (value ofs, value len, value ptr)
{
    char *start = ((char*)Pointer_val(ptr)) + Option_val(ofs, Int_val, 0);
    int length = Option_val(len, Int_val, strlen(start));
    value ret = alloc_string(length);
    memcpy ((char*)ret, start, length);
    return ret;
}

CAMLprim value ml_int_at_pointer (value ptr)
{
    return Val_int(*(int*)Pointer_val(ptr));
}


unsigned char* ml_gpointer_base (value region)
{
    int i;
    value ptr = RegData_val(region);
    value path = RegPath_val(region);

    if (Is_block(path))
        for (i = 0; i < Wosize_val(path); i++)
            ptr = Field(ptr, Int_val(Field(path, i)));

    return (unsigned char*) ptr+RegOffset_val(region);
}

CAMLprim value ml_gpointer_get_char (value region, value pos)
{
    return Val_int(*(ml_gpointer_base (region) + Long_val(pos)));
}

CAMLprim value ml_gpointer_set_char (value region, value pos, value ch)
{
    *(ml_gpointer_base (region) + Long_val(pos)) = Int_val(ch);
    return Val_unit;
}

CAMLprim value ml_gpointer_blit (value region1, value region2)
{
    void *base1 = ml_gpointer_base (region1);
    void *base2 = ml_gpointer_base (region2);

    memcpy (base2, base1, RegLength_val(region1));
    return Val_unit;
}

CAMLprim value ml_gpointer_get_addr (value region)
{
    return copy_nativeint ((long)ml_gpointer_base (region));
}

/* $Id$ */

#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>
#include <string.h>

#include "ml_gpointer.h"

value ml_get_null (value unit) { return 0L; }


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

value ml_gpointer_get_char (value region, value pos)
{
    return Val_int(*(ml_gpointer_base (region) + Long_val(pos)));
}

value ml_gpointer_set_char (value region, value pos, value ch)
{
    *(ml_gpointer_base (region) + Long_val(pos)) = Int_val(ch);
    return Val_unit;
}

value ml_gpointer_blit (value region1, value region2)
{
    void *base1 = ml_gpointer_base (region1);
    void *base2 = ml_gpointer_base (region2);

    memcpy (base2, base1, RegLength_val(region1));
    return Val_unit;
}

value ml_gpointer_get_addr (value region)
{
    return copy_nativeint ((long)ml_gpointer_base (region));
}

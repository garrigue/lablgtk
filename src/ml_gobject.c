/* $Id$ */

#include <gobject.h>

#include "wrappers.h"
#include "gobject_tags.h"
#include "gobject_tags.c"

/* gtype.h */

ML_1 (g_type_name, Int_val, Val_string)
ML_1 (g_type_from_name, String_val, Val_int)
ML_1 (g_type_parent, Int_val, Val_int)
ML_1 (g_type_depth, Int_val, Val_int)
ML_2 (g_type_is_a, Int_val, Int_val, Val_bool)
value ml_g_type_fundamental (value type)
{
    return Val_fundamental_type (G_TYPE_FUNDAMENTAL (Int_val(type)));
}
ML_1 (Fundamental_type_val, Int_val, )

/* gclosure.h */

Make_Val_final_pointer(GClosure, g_closure_ref, g_closure_unref, 0)

#define g_closure_ref_and_sink(w) (g_closure_ref(w), g_closure_sink(w))
Make_Val_final_pointer_ext(GClosure, _sink , g_closure_ref_and_sink,
                           g_closure_unref, 20)

static void notify_destroy(gpointer clos_p, GClosure *c)
{
    remove_global_root((value*)clos_p);
}

value ml_g_closure_new (value clos)
{
    GClosure* gclos = g_closure_new_simple(sizeof(GClosure), clos);
    register_global_root((value*)&gclos->data);
    g_closure_add_finalize_notifier(gclos, &gclos->data, notify_destroy);
    return Val_GClosure_sink(gclos);
}

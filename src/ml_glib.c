/* $Id$ */

#include <glib.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>

#include "wrappers.h"
#include "ml_glib.h"
#include "glib_tags.h"

#include "glib_tags.c"

/* Utility functions */
value copy_string_and_free (char *str)
{
    value res;
    res = copy_string_check (str);
    g_free (str);
    return res;
}

value Val_GList (GList *list, value (*func)(gpointer))
{
    value new_cell, result, last_cell, cell;

    if (list == NULL) return Val_unit;

    last_cell = cell = Val_unit;
    result = func(list->data);
    Begin_roots3 (last_cell, cell, result);
    cell = last_cell = alloc_small(2,0);
    Field(cell,0) = result;
    Field(cell,1) = Val_unit;
    list = list->next;
    while (list != NULL) {
	result = func(list->data);
	new_cell = alloc_small(2,0);
	Field(new_cell,0) = result;
	Field(new_cell,1) = Val_unit;
	modify(&Field(last_cell,1), new_cell);
	last_cell = new_cell;
	list = list->next;
    }
    End_roots ();
    return cell;
}

GList *GList_val (value list, gpointer (*func)(value))
{
    CAMLparam1(list);
    GList *res = NULL;
    if (list == Val_unit) CAMLreturn (res);
    for (; Is_block(list); list = Field(list,1))
      res = g_list_append (res, func(Field(list,0)));
    CAMLreturn (res);
}

/* Redirect printer */

static value ml_print_handler = 0L;

static void ml_print_wrapper (const gchar *msg)
{
    value arg = copy_string ((char*)msg);
    callback (ml_print_handler, arg);
}
    
CAMLprim value ml_g_set_print_handler (value clos)
{
    value old_handler = ml_print_handler ? ml_print_handler : clos;
    if (!ml_print_handler) register_global_root (&ml_print_handler);
    g_set_print_handler (ml_print_wrapper);
    ml_print_handler = clos;
    return old_handler;
}

/* Main loop handling */

/* for 1.3 compatibility */
#ifdef g_main_new
#undef g_main_new
#define	g_main_new(is_running)	g_main_loop_new (NULL, is_running)
#endif

#define GMainLoop_val(val) ((GMainLoop*)Addr_val(val))
ML_1 (g_main_new, Bool_val, Val_addr)
ML_1 (g_main_iteration, Bool_val, Val_bool)
ML_0 (g_main_pending, Val_bool)
ML_1 (g_main_is_running, GMainLoop_val, Val_bool)
ML_1 (g_main_quit, GMainLoop_val, Unit)
ML_1 (g_main_destroy, GMainLoop_val, Unit)


/* GIOChannel */

Make_Val_final_pointer (GIOChannel, g_io_channel_ref, g_io_channel_unref, 0)
Make_Val_final_pointer_ext (GIOChannel, _noref, Ignore, g_io_channel_unref, 20)
#define GIOChannel_val(val) ((GIOChannel*)Pointer_val(val))

#ifndef _WIN32
ML_1 (g_io_channel_unix_new, Int_val, Val_GIOChannel_noref)
#else
CAMLprim value ml_g_io_channel_unix_new(value v)
{  invalid_argument("Glib.channel_unix_new: not implemented"); return 1; }
#endif

gboolean ml_g_io_channel_watch(GIOChannel *s, GIOCondition c, gpointer data)
{
    value *clos_p = (value*)data;
    return Bool_val(callback(*clos_p, Val_unit));
}
void ml_g_destroy_notify(gpointer data)
{
    ml_global_root_destroy(data);
}

CAMLprim value ml_g_io_add_watch(value cond, value clos, value prio, value io)
{
    g_io_add_watch_full(GIOChannel_val(io),
                        Option_val(prio,Int_val,0),
                        Io_condition_val(cond),
                        ml_g_io_channel_watch,
                        ml_global_root_new(clos),
                        ml_g_destroy_notify);
    return Val_unit;
}

/* Thread initialization ? */
/*
ML_1(g_thread_init, NULL Ignore, Unit)
ML_0(gdk_threads_enter, Unit)
ML_0(gdk_threads_leave, Unit)
*/

/* This is not used, but could be someday... */
/*
CAMLprim value Val_GSList (GSList *list, value (*func)(gpointer))
{
    value new_cell, result, last_cell, cell;

    if (list == NULL) return Val_unit;

    last_cell = cell = Val_unit;
    result = func(list->data);
    Begin_roots3 (last_cell, cell, result);
    cell = last_cell = alloc_tuple (2);
    Field(cell,0) = result;
    Field(cell,1) = Val_unit;
    list = list->next;
    while (list != NULL) {
	result = func(list->data);
	new_cell = alloc_tuple(2);
	Field(new_cell,0) = result;
	Field(new_cell,1) = Val_unit;
	modify(&Field(last_cell,1), new_cell);
	last_cell = new_cell;
	list = list->next;
    }
    End_roots ();
    return cell;
}

GSList *GSList_val (value list, gpointer (*func)(value))
{
    GSList *res = NULL;
    GSList **current = &res;
    value cell = list;
    if (list == Val_unit) return res;
    Begin_root (cell);
    while (cell != Val_unit) {
	*current = g_slist_alloc ();
	(*current)->data = func(Field(cell,0));
	cell = Field(cell,1);
	current = &(*current)->next;
    }
    End_roots ();
    return res;
}
*/

/* $Id$ */

#include <glib.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>

#include "wrappers.h"
#include "ml_glib.h"

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

/* Redirect printers */
/* Currently broken for warning */
static value ml_warning_handler = 0L;

static void ml_warning_wrapper (const gchar *msg)
{
    value arg = copy_string ((char*)msg);
    callback (ml_warning_handler, arg);
}
    
value ml_g_set_warning_handler (value clos)
{
    value old_handler = ml_warning_handler ? ml_warning_handler : clos;
    if (!ml_warning_handler) register_global_root (&ml_warning_handler);
    g_set_warning_handler (ml_warning_wrapper);
    ml_warning_handler = clos;
    return old_handler;
}

static value ml_print_handler = 0L;

static void ml_print_wrapper (const gchar *msg)
{
    value arg = copy_string ((char*)msg);
    callback (ml_print_handler, arg);
}
    
value ml_g_set_print_handler (value clos)
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




/* This is not used, but could be someday... */
/*
value Val_GSList (GSList *list, value (*func)(gpointer))
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

/* $Id$ */

#include <glib.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>

#include "wrappers.h"
#include "ml_glib.h"

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

static value ml_warning_handler = 0L;

static void ml_warning_wrapper (char *msg)
{
    value arg = copy_string (msg);
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

static void ml_print_wrapper (char *msg)
{
    value arg = copy_string (msg);
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

value ml_get_null (value unit) { return 0L; }

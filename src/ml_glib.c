/* $Id$ */

#include <locale.h>
#ifdef _WIN32
#include "win32.h"
#endif
#include <glib.h>
#include <gtk/gtk.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>

#include "wrappers.h"
#include "ml_glib.h"
#include "glib_tags.h"

#include "glib_tags.c"

/* Not from glib! */
ML_2(setlocale, Locale_category_val, String_option_val, Val_optstring)

/* Utility functions */
value copy_string_g_free (char *str)
{
    value res = copy_string_check (str);
    g_free (str);
    return res;
}

value Val_GList (GList *list, value (*func)(gpointer))
{
  CAMLparam0 ();
  CAMLlocal4 (new_cell, result, last_cell, cell);

  last_cell = cell = Val_unit;
  while (list != NULL) {
    result = func(list->data);
    new_cell = alloc_small(2,0);
    Field(new_cell,0) = result;
    Field(new_cell,1) = Val_unit;
    if (last_cell == Val_unit) cell = new_cell;
    else modify(&Field(last_cell,1), new_cell);
    last_cell = new_cell;
    list = list->next;
  }
  CAMLreturn (cell);
}

value Val_GList_free (GList *list, value (*func)(gpointer))
{
  value res = Val_GList (list, func);
  g_list_free (list);
  return res;
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

/* Error handling */

void ml_raise_gerror(GError *err)
{
  static value * exn = NULL;
  if (exn == NULL)
      exn = caml_named_value ("gerror");
  raise_with_string (*exn, err->message);
}

void ml_g_log_func(const gchar *log_domain,
                   GLogLevelFlags log_level,
                   const gchar *message,
                   gpointer data)
{
    value *clos_p = (value*)data;
    callback2(*clos_p, Val_int(log_level), Val_string(message));
}

ML_1 (Log_level_val, , Val_int)

value ml_g_log_set_handler (value domain, value levels, value clos)
{
    value *clos_p = ml_global_root_new (clos);
    int id = g_log_set_handler (String_val(domain), Int_val(levels),
                                ml_g_log_func, clos_p);
    CAMLparam1(domain);
    value ret = alloc_small(3,0);
    Field(ret,0) = domain;
    Field(ret,1) = Int_val(id);
    Field(ret,2) = (value)clos_p;
    CAMLreturn(ret);
}

value ml_g_log_remove_handler (value hnd)
{
    if (Field(hnd,2) != 0) {
        g_log_remove_handler (String_val(Field(hnd,0)), Int_val(Field(hnd,1)));
        ml_global_root_destroy ((value*)Field(hnd,2));
        Field(hnd,2) = 0;
    }
    return Val_unit;
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

gboolean ml_g_source_func (gpointer data)
{
    return Bool_val (callback (*(value*)data, Val_unit));
}

value ml_g_timeout_add (value interval, value clos)
{
    value *clos_p = ml_global_root_new (clos);
    return Val_int
        (g_timeout_add_full (G_PRIORITY_DEFAULT, Long_val(interval),
                             ml_g_source_func, clos_p,
                             ml_global_root_destroy));
}

value ml_g_idle_add (value clos)
{
    value *clos_p = ml_global_root_new (clos);
    return Val_int
      (g_idle_add_full (G_PRIORITY_DEFAULT_IDLE,
			ml_g_source_func, clos_p,
			ml_global_root_destroy));
}

ML_1 (g_source_remove, Int_val, Unit)

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

/* The day has come .... */
CAMLprim value Val_GSList (GSList *list, value (*func)(gpointer))
{
  CAMLparam0();
  CAMLlocal4 (new_cell, result, last_cell, cell);
  
  last_cell = cell = Val_unit;
  while (list != NULL) {
    result = func(list->data);
    new_cell = alloc_small(2,0);
    Field(new_cell,0) = result;
    Field(new_cell,1) = Val_unit;
    if (last_cell == Val_unit) cell = new_cell;
    else modify(&Field(last_cell,1), new_cell);
    last_cell = new_cell;
    list = list->next;
  }
  CAMLreturn(cell);
}

value Val_GSList_free (GSList *list, value (*func)(gpointer))
{
  value res = Val_GSList (list, func);
  g_slist_free (list);
  return res;
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

/* Character Set Conversion */

CAMLprim value ml_g_convert(value str, value to, value from)
{
  gsize br=0,bw=0;
  gchar* c_res;
  GError *error=NULL;
  c_res = g_convert(String_val(str),string_length(str),
                    String_val(to),String_val(from),
                    &br,&bw,&error);
  if (error != NULL) ml_raise_gerror(error);
  return Val_string(c_res);
}

#define Make_conversion(cname) \
CAMLprim value ml_##cname(value str) { \
  gsize br=0,bw=0; \
  gchar* c_res; \
  GError *error=NULL; \
  c_res = cname(String_val(str),string_length(str),&br,&bw,&error); \
  if (error != NULL) ml_raise_gerror(error); \
  return Val_string(c_res); \
}

Make_conversion(g_locale_to_utf8)
Make_conversion(g_filename_to_utf8)
Make_conversion(g_locale_from_utf8)
Make_conversion(g_filename_from_utf8)

CAMLprim value ml_g_get_charset()
{
  CAMLparam0();
  CAMLlocal1(couple);
  gboolean r;
  G_CONST_RETURN char *c="";
  r = g_get_charset(&c);
  couple = alloc_tuple(2);
  Store_field(couple,0,Val_bool(r));
  Store_field(couple,1,Val_string(c));
  CAMLreturn(couple);
}

CAMLprim value ml_g_utf8_validate(value s)
{
  const gchar *c=NULL;
  return Val_bool(g_utf8_validate(SizedString_val(s),&c));
}

ML_1 (g_unichar_tolower, Int_val, Val_int)
ML_1 (g_unichar_toupper, Int_val, Val_int)
ML_1 (g_utf8_strlen, SizedString_val, Val_int)

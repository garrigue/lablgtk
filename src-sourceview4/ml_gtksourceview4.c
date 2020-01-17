/**************************************************************************/
/*                Lablgtk                                                 */
/*                                                                        */
/*    This program is free software; you can redistribute it              */
/*    and/or modify it under the terms of the GNU Library General         */
/*    Public License as published by the Free Software Foundation         */
/*    version 2, with the exception described in file COPYING which       */
/*    comes with the library.                                             */
/*                                                                        */
/*    This program is distributed in the hope that it will be useful,     */
/*    but WITHOUT ANY WARRANTY; without even the implied warranty of      */
/*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       */
/*    GNU Library General Public License for more details.                */
/*                                                                        */
/*    You should have received a copy of the GNU Library General          */
/*    Public License along with this program; if not, write to the        */
/*    Free Software Foundation, Inc., 59 Temple Place, Suite 330,         */
/*    Boston, MA 02111-1307  USA                                          */
/*                                                                        */
/*                                                                        */
/**************************************************************************/

#include <assert.h>
#include <gtksourceview/gtksource.h>

#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>
#include <caml/fail.h>
#include <caml/custom.h>
#include <caml/callback.h>

#include <wrappers.h>
#include <ml_glib.h>
#include <ml_gdk.h>
#include <ml_gtk.h>
#include <ml_gobject.h>
#include <ml_gdkpixbuf.h>
#include <ml_pango.h>
#include <ml_gtktext.h>
#include <gtk_tags.h>
#include <gdk_tags.h>
#include "sourceView4_tags.h"
#include "sourceView4_tags.c"

#include <string.h>

/* Not in gtksourceview 3.0
Make_OptFlags_val(Source_search_flag_val)
*/

/* Already in ml_gobject.c
Make_Val_final_pointer_ext(GObject, _sink, g_object_ref_sink, ml_g_object_unref_later, 20)
*/

CAMLprim value ml_gtk_source_view_init(value unit)
{       /* Since these are declared const, must force gcc to call them! */
    GType t =
      gtk_source_completion_get_type() +
      gtk_source_completion_context_get_type() +
      gtk_source_completion_provider_get_type() +
      gtk_source_completion_proposal_get_type() +
      gtk_source_completion_info_get_type() +
      gtk_source_completion_item_get_type() +
      gtk_source_completion_provider_get_type() +
      gtk_source_style_scheme_get_type() +
      gtk_source_style_scheme_manager_get_type() +
      gtk_source_language_get_type() +
      gtk_source_language_manager_get_type() +
      gtk_source_mark_attributes_get_type() +
      gtk_source_buffer_get_type() +
      gtk_source_view_get_type();
    return Val_GType(t);
}

static gpointer string_val(value v)
{
	return String_val(v);
}

GSList *ml_gslist_of_string_list(value list)
{
	return GSList_val(list, string_val);
}

#define GtkSourceCompletionProvider_val(val) check_cast(GTK_SOURCE_COMPLETION_PROVIDER,val)
#define Val_GtkSourceCompletionProvider(val) (Val_GObject((GObject*)val))
#define Val_GtkSourceCompletionProvider_new(val) (Val_GObject_new((GObject*)val))

#define GtkSourceCompletionItem_val(val) check_cast(GTK_SOURCE_COMPLETION_ITEM,val)
#define Val_GtkSourceCompletionItem(val) (Val_GObject((GObject*)val))
#define Val_GtkSourceCompletionItem_new(val) (Val_GObject_new((GObject*)val))

#define GtkSourceCompletionProposal_val(val) check_cast(GTK_SOURCE_COMPLETION_PROPOSAL,val)
#define Val_GtkSourceCompletionProposal(val) (Val_GObject((GObject*)val))
#define Val_GtkSourceCompletionProposal_new(val) (Val_GObject_new((GObject*)val))

#define GtkSourceCompletionInfo_val(val) check_cast(GTK_SOURCE_COMPLETION_INFO,val)
#define Val_GtkSourceCompletionInfo(val) (Val_GObject((GObject*)val))
#define Val_GtkSourceCompletionInfo_new(val) (Val_GObject_sink((GObject*)val))

#define GtkSourceCompletionContext_val(val) check_cast(GTK_SOURCE_COMPLETION_CONTEXT,val)
#define Val_GtkSourceCompletionContext(val) (Val_GObject((GObject*)val))
#define Val_GtkSourceCompletionContext_new(val) (Val_GObject_sink((GObject*)val))
// static Make_Val_option(GtkSourceCompletionContext)

#define GtkSourceCompletion_val(val) check_cast(GTK_SOURCE_COMPLETION,val)
#define Val_GtkSourceCompletion(val) (Val_GObject((GObject*)val))
#define Val_GtkSourceCompletion_new(val) (Val_GObject_sink((GObject*)val))
// static Make_Val_option(GtkSourceCompletion)

#define GtkSourceStyleScheme_val(val) check_cast(GTK_SOURCE_STYLE_SCHEME,val)
#define Val_GtkSourceStyleScheme(val) (Val_GObject((GObject*)val))
#define Val_GtkSourceStyleScheme_new(val) (Val_GObject_new((GObject*)val))
static Make_Val_option(GtkSourceStyleScheme)

#define GtkSourceStyleSchemeManager_val(val) \
     check_cast(GTK_SOURCE_STYLE_SCHEME_MANAGER,val)
#define Val_GtkSourceStyleSchemeManager(val) (Val_GObject((GObject*)val))

#define Val_GtkSourceLanguage(val)  (Val_GObject((GObject*)val))
static Make_Val_option(GtkSourceLanguage)

#define GtkSourceLanguage_val(val) check_cast(GTK_SOURCE_LANGUAGE,val)
#define GtkSourceLanguageManager_val(val)\
	check_cast(GTK_SOURCE_LANGUAGE_MANAGER,val)
#define Val_GtkSourceLanguageManager(val)  (Val_GObject((GObject*)val))

#define GtkSourceTagStyle_val(val) Pointer_val(val)

#define GtkSourceMark_val(val) check_cast(GTK_SOURCE_MARK,val)
#define Val_GtkSourceMark(val)  (Val_GObject((GObject*)val))
#define Val_GtkSourceMark_new(val) (Val_GObject_new((GObject*)val))
static Make_Val_option(GtkSourceMark)

#define GtkSourceMarkAttributes_val(val) check_cast(GTK_SOURCE_MARK_ATTRIBUTES,val)
#define Val_GtkSourceMarkAttributes(val)  (Val_GObject((GObject*)val))
#define Val_GtkSourceMarkAttributes_new(val) (Val_GObject_new((GObject*)val))

#define GtkSourceUndoManager_val(val) check_cast(GTK_SOURCE_UNDO_MANAGER,val)
#define Val_GtkSourceUndoManager(val) (Val_GObject((GObject*)val))
#define Val_GtkSourceUndoManager_new(val) (Val_GObject_new((GObject*)val))

#define GtkSourceBuffer_val(val) check_cast(GTK_SOURCE_BUFFER,val)
#define Val_GtkSourceBuffer(val) (Val_GObject((GObject*)val))
#define Val_GtkSourceBuffer_new(val) (Val_GObject_new((GObject*)val))
#define GtkSourceView_val(val) check_cast(GTK_SOURCE_VIEW,val)
#define GtkTextIter_val(val) ((GtkTextIter*)MLPointer_val(val))
#define Val_GtkTextIter(it) (copy_memblock_indirected(it,sizeof(GtkTextIter)))
#define string_list_of_GSList(l) Val_GSList(l, (value_in) Val_string)

#define GdkPixbuf_option_val(val) Option_val(val, GdkPixbuf_val, NULL)
#define GdkColor_option_val(val) Option_val(val, GdkColor_val, NULL)

static value val_gtksourcemark(gpointer v)
{
  return Val_GtkSourceMark(v);
}

value source_marker_list_of_GSList(gpointer list)
{
  return Val_GSList(list, val_gtksourcemark);
}

static value val_gtksourcelanguage(gpointer v)
{
  return Val_GtkSourceLanguage(v);
}

value source_language_list_of_GSList(gpointer list)
{
  return Val_GSList(list, val_gtksourcelanguage);
}

// Completion

Make_Flags_val(Source_completion_activation_flags_val)
#define Val_Activation_flags(val) \
     ml_lookup_flags_getter(ml_table_source_completion_activation_flags, val)

// Completion provider

typedef struct _CustomObject CustomCompletionProvider;
typedef struct _CustomObjectClass CustomCompletionProviderClass;

struct _CustomObject
{
  GObject parent;      /* this MUST be the first member */
  value* caml_object;
};

struct _CustomObjectClass
{
  GObjectClass parent;      /* this MUST be the first member */
};

typedef struct _CustomObject CustomObject;
typedef struct _CustomObjectClass CustomObjectClass;

static void custom_object_finalize (GObject *object) {
  GObjectClass *parent_class;
  CustomObject* custom = (CustomObject*) object;
  parent_class = (GObjectClass*) g_type_class_peek_parent (object);
  ml_global_root_destroy(custom->caml_object);
  (*parent_class->finalize)(object);
}

GType custom_completion_provider_get_type();

#define TYPE_CUSTOM_COMPLETION_PROVIDER (custom_completion_provider_get_type ())
#define IS_CUSTOM_COMPLETION_PROVIDER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), TYPE_CUSTOM_COMPLETION_PROVIDER))
#define METHOD(obj, n) (Field(*(obj->caml_object), n))
// #define METHOD(obj, name) (callback(caml_get_public_method(obj->caml_object, hash_variant(name)), obj->caml_object))
#define METHOD1(obj, n, arg1) (callback(Field(*(obj->caml_object), n), arg1))
#define METHOD2(obj, n, arg1, arg2) (callback2(Field(*(obj->caml_object), n), arg1, arg2))
#define METHOD3(obj, n, arg1, arg2, arg3) (callback3(Field(*(obj->caml_object), n), arg1, arg2, arg3))

CAMLprim value ml_custom_completion_provider_new (value obj) {
  CAMLparam1(obj);
  CustomCompletionProvider* p = (CustomCompletionProvider*) g_object_new (TYPE_CUSTOM_COMPLETION_PROVIDER, NULL);
  g_assert (p != NULL);
  p->caml_object = ml_global_root_new(obj);
  CAMLreturn (Val_GtkSourceCompletionProvider_new(p));
}

gchar* custom_completion_provider_get_name (GtkSourceCompletionProvider* p) {
  g_return_val_if_fail (IS_CUSTOM_COMPLETION_PROVIDER(p), NULL);
  CustomCompletionProvider *obj = (CustomCompletionProvider *) p;
  return g_strdup(string_val (METHOD1(obj, 0, Val_unit)));
}

GdkPixbuf* custom_completion_provider_get_icon (GtkSourceCompletionProvider* p) {
  g_return_val_if_fail (IS_CUSTOM_COMPLETION_PROVIDER(p), NULL);
  CustomCompletionProvider *obj = (CustomCompletionProvider *) p;
  return GdkPixbuf_option_val (METHOD1(obj, 1, Val_unit));
}

void custom_completion_provider_populate (GtkSourceCompletionProvider* p, GtkSourceCompletionContext *context) {
  g_return_if_fail (IS_CUSTOM_COMPLETION_PROVIDER(p));
  CustomCompletionProvider *obj = (CustomCompletionProvider *) p;
  METHOD1(obj, 2, Val_GtkSourceCompletionContext(context));
}

GtkSourceCompletionActivation custom_completion_provider_get_activation (GtkSourceCompletionProvider* p) {
  g_return_val_if_fail (IS_CUSTOM_COMPLETION_PROVIDER(p), 0);
  CustomCompletionProvider *obj = (CustomCompletionProvider *) p;
  return Flags_Source_completion_activation_flags_val (METHOD1(obj, 3, Val_unit));
}

gboolean custom_completion_provider_match (GtkSourceCompletionProvider* p, GtkSourceCompletionContext *context) {
  g_return_val_if_fail (IS_CUSTOM_COMPLETION_PROVIDER(p), FALSE);
  CustomCompletionProvider *obj = (CustomCompletionProvider *) p;
  return Bool_val (METHOD1(obj, 4, Val_GtkSourceCompletionContext(context)));
}

GtkWidget* custom_completion_provider_get_info_widget (GtkSourceCompletionProvider* p, GtkSourceCompletionProposal *proposal) {
  g_return_val_if_fail (IS_CUSTOM_COMPLETION_PROVIDER(p), NULL);
  CustomCompletionProvider *obj = (CustomCompletionProvider *) p;
  return Option_val (METHOD1(obj, 5, Val_GtkSourceCompletionProposal(proposal)), GtkWidget_val, NULL);
}

void custom_completion_provider_update_info
  (GtkSourceCompletionProvider* p, GtkSourceCompletionProposal *proposal, GtkSourceCompletionInfo *info) {
  g_return_if_fail (IS_CUSTOM_COMPLETION_PROVIDER(p));
  CustomCompletionProvider *obj = (CustomCompletionProvider *) p;
  METHOD2(obj, 6, Val_GtkSourceCompletionProposal(proposal), Val_GtkSourceCompletionInfo(info));
}

gboolean custom_completion_provider_get_start_iter
  (GtkSourceCompletionProvider* p, GtkSourceCompletionContext *context, GtkSourceCompletionProposal *proposal, GtkTextIter *iter) {
  g_return_val_if_fail (IS_CUSTOM_COMPLETION_PROVIDER(p), FALSE);
  CustomCompletionProvider *obj = (CustomCompletionProvider *) p;
  return Bool_val (METHOD3(obj, 7, Val_GtkSourceCompletionContext(context), Val_GtkSourceCompletionProposal(proposal), Val_GtkTextIter(iter)));
}

gboolean custom_completion_provider_activate_proposal
  (GtkSourceCompletionProvider* p, GtkSourceCompletionProposal *proposal, GtkTextIter *iter) {
  g_return_val_if_fail (IS_CUSTOM_COMPLETION_PROVIDER(p), FALSE);
  CustomCompletionProvider *obj = (CustomCompletionProvider *) p;
  return Bool_val (METHOD2(obj, 8, Val_GtkSourceCompletionProposal(proposal), Val_GtkTextIter(iter)));
}

gint custom_completion_provider_get_interactive_delay (GtkSourceCompletionProvider* p) {
  g_return_val_if_fail (IS_CUSTOM_COMPLETION_PROVIDER(p), 0);
  CustomCompletionProvider *obj = (CustomCompletionProvider *) p;
  return Int_val (METHOD1(obj, 9, Val_unit));
}

gint custom_completion_provider_get_priority (GtkSourceCompletionProvider* p) {
  g_return_val_if_fail (IS_CUSTOM_COMPLETION_PROVIDER(p), 0);
  CustomCompletionProvider *obj = (CustomCompletionProvider *) p;
  return Int_val (METHOD1(obj, 10, Val_unit));
}

static void custom_completion_provider_interface_init (GtkSourceCompletionProviderIface *iface, gpointer data)
{
  iface->get_name = custom_completion_provider_get_name;
  iface->get_icon = custom_completion_provider_get_icon;
  iface->populate = custom_completion_provider_populate;
  iface->match = custom_completion_provider_match;
  iface->get_activation = custom_completion_provider_get_activation;
  iface->get_info_widget = custom_completion_provider_get_info_widget;
  iface->update_info = custom_completion_provider_update_info;
  iface->get_start_iter = custom_completion_provider_get_start_iter;
  iface->activate_proposal = custom_completion_provider_activate_proposal;
  iface->get_interactive_delay = custom_completion_provider_get_interactive_delay;
  iface->get_priority = custom_completion_provider_get_priority;
}

static void custom_completion_provider_class_init (CustomCompletionProviderClass *c)
{
  GObjectClass *object_class;
  object_class = (GObjectClass*) c;
  object_class->finalize = custom_object_finalize;
}

GType custom_completion_provider_get_type (void)
{
  /* Some boilerplate type registration stuff */
  static GType custom_completion_provider_type = 0;

  if (custom_completion_provider_type == 0)
  {
    const GTypeInfo custom_completion_provider_info =
    {
      sizeof (CustomCompletionProviderClass),
      NULL,                                         /* base_init */
      NULL,                                         /* base_finalize */
      (GClassInitFunc) custom_completion_provider_class_init,
      NULL,                                         /* class finalize */
      NULL,                                         /* class_data */
      sizeof (CustomCompletionProvider),
      0,                                           /* n_preallocs */
      NULL
    };

    static const GInterfaceInfo source_completion_provider_info =
    {
      (GInterfaceInitFunc) custom_completion_provider_interface_init,
      NULL,
      NULL
    };

    custom_completion_provider_type = g_type_register_static (G_TYPE_OBJECT, "custom_completion_provider",
                                               &custom_completion_provider_info, (GTypeFlags)0);

    /* Here we register our GtkTreeModel interface with the type system */
    g_type_add_interface_static (custom_completion_provider_type, GTK_SOURCE_TYPE_COMPLETION_PROVIDER, &source_completion_provider_info);
  }

  return custom_completion_provider_type;
}

ML_1 (gtk_source_completion_provider_get_name, GtkSourceCompletionProvider_val, Val_string)
ML_1 (gtk_source_completion_provider_get_icon, GtkSourceCompletionProvider_val, Val_option_GdkPixbuf)
ML_2 (gtk_source_completion_provider_populate, GtkSourceCompletionProvider_val, GtkSourceCompletionContext_val, Unit)
ML_1 (gtk_source_completion_provider_get_activation, GtkSourceCompletionProvider_val,
      Val_Activation_flags)
ML_2 (gtk_source_completion_provider_match, GtkSourceCompletionProvider_val,
      GtkSourceCompletionContext_val, Val_bool)
// FIXME : this should return a widget option?
ML_2 (gtk_source_completion_provider_get_info_widget,
      GtkSourceCompletionProvider_val, GtkSourceCompletionProposal_val, Val_GtkWidget)
ML_3 (gtk_source_completion_provider_update_info, GtkSourceCompletionProvider_val,
      GtkSourceCompletionProposal_val, GtkSourceCompletionInfo_val, Unit)
CAMLprim value ml_gtk_source_completion_provider_get_start_iter (value provider, value context, value proposal) {
  CAMLparam3(provider, context, proposal);
  GtkTextIter res;
  gtk_source_completion_provider_get_start_iter(GtkSourceCompletionProvider_val(provider),
    GtkSourceCompletionContext_val(context), GtkSourceCompletionProposal_val(proposal), &res);
  CAMLreturn(Val_GtkTextIter(&res));
}
ML_3 (gtk_source_completion_provider_activate_proposal, GtkSourceCompletionProvider_val,
      GtkSourceCompletionProposal_val, GtkTextIter_val, Val_bool)
ML_1 (gtk_source_completion_provider_get_interactive_delay, GtkSourceCompletionProvider_val,
      Val_int)
ML_1 (gtk_source_completion_provider_get_priority, GtkSourceCompletionProvider_val,
      Val_int)

// Completion proposal

ML_0 (gtk_source_completion_item_new, Val_GtkSourceCompletionItem_new)

// Completion info

ML_3 (gtk_source_completion_info_move_to_iter,
      GtkSourceCompletionInfo_val, GtkTextView_val, GtkTextIter_val, Unit)

// Completion context

CAMLexport value Val_GtkSourceCompletionProposal_func(gpointer w) {
  return Val_GtkSourceCompletionProposal(w);
}

CAMLexport gpointer GtkSourceCompletionProposal_val_func(value val) {
  CAMLparam1(val);
  CAMLreturnT (gpointer, GtkSourceCompletionProposal_val(val));
}

#define Val_Proposals(val) Val_GList(val, Val_GtkSourceCompletionProposal_func)
#define Proposals_val(val) GList_val(val, GtkSourceCompletionProposal_val_func)

CAMLexport value ml_gtk_source_completion_context_set_activation (value context, value flags) {
  g_object_set (GtkSourceCompletionContext_val(context),
                "activation", Flags_Source_completion_activation_flags_val(flags), NULL);
  return Val_unit;
}

ML_1 (gtk_source_completion_context_get_activation,
      GtkSourceCompletionContext_val, Val_Activation_flags)
ML_4 (gtk_source_completion_context_add_proposals,
      GtkSourceCompletionContext_val, GtkSourceCompletionProvider_val, Proposals_val, Bool_val, Unit)

ML_1 (gtk_source_completion_block_interactive, GtkSourceCompletion_val, Unit)

CAMLexport value Val_GtkSourceCompletionProvider_func(gpointer w) {
  return Val_GtkSourceCompletionProvider(w);
}

CAMLexport gpointer GtkSourceCompletionProvider_val_func(value val) {
  return GtkSourceCompletionProvider_val(val);
}

#define Val_Providers(val) Val_GList(val, Val_GtkSourceCompletionProvider_func)
#define Providers_val(val) GList_val(val, GtkSourceCompletionProvider_val_func)

CAMLexport value ml_gtk_source_completion_add_provider (value completion, value provider) {
  return Val_bool (gtk_source_completion_add_provider
    (GtkSourceCompletion_val(completion), GtkSourceCompletionProvider_val(provider), NULL));
}

CAMLexport value ml_gtk_source_completion_remove_provider (value completion, value provider) {
  return Val_bool (gtk_source_completion_remove_provider
    (GtkSourceCompletion_val(completion), GtkSourceCompletionProvider_val(provider), NULL));
}

ML_1 (gtk_source_completion_get_providers, GtkSourceCompletion_val, Val_Providers)
ML_1 (gtk_source_completion_hide, GtkSourceCompletion_val, Unit)

// gtk_source_completion_get_info_window
ML_1 (gtk_source_completion_get_view, GtkSourceCompletion_val, Val_GtkSourceBuffer)
ML_2 (gtk_source_completion_create_context, GtkSourceCompletion_val, GtkTextIter_val, Val_GtkSourceCompletionContext_new)
ML_1 (gtk_source_completion_unblock_interactive, GtkSourceCompletion_val, Unit)

// Style

ML_1 (gtk_source_style_scheme_get_name, GtkSourceStyleScheme_val, Val_string)
ML_1 (gtk_source_style_scheme_get_description, GtkSourceStyleScheme_val, Val_string)

ML_0 (gtk_source_style_scheme_manager_new, Val_GtkAny_sink)
ML_0 (gtk_source_style_scheme_manager_get_default,
      Val_GtkSourceStyleSchemeManager)
ML_2 (gtk_source_style_scheme_manager_get_scheme,
      GtkSourceStyleSchemeManager_val, String_val,
      Val_option_GtkSourceStyleScheme)
ML_1 (gtk_source_style_scheme_manager_get_scheme_ids,
      GtkSourceStyleSchemeManager_val, string_list_of_strv)
ML_1 (gtk_source_style_scheme_manager_get_search_path,
      GtkSourceStyleSchemeManager_val, string_list_of_strv)
ML_2 (gtk_source_style_scheme_manager_set_search_path,
      GtkSourceStyleSchemeManager_val, strv_of_string_list, Unit)
ML_2 (gtk_source_style_scheme_manager_prepend_search_path,
      GtkSourceStyleSchemeManager_val, String_val, Unit)
ML_2 (gtk_source_style_scheme_manager_append_search_path,
      GtkSourceStyleSchemeManager_val, String_val, Unit)
ML_1 (gtk_source_style_scheme_manager_force_rescan,
      GtkSourceStyleSchemeManager_val, Unit)

ML_1 (gtk_source_language_get_id, GtkSourceLanguage_val, Val_string)
ML_1 (gtk_source_language_get_name, GtkSourceLanguage_val, Val_string)
ML_1 (gtk_source_language_get_section, GtkSourceLanguage_val, Val_string)
ML_1 (gtk_source_language_get_hidden, GtkSourceLanguage_val, Val_bool)

ML_2 (gtk_source_language_get_metadata, GtkSourceLanguage_val,
      String_option_val, Val_optstring)

ML_1 (gtk_source_language_get_mime_types, GtkSourceLanguage_val,
      string_list_of_strv2)
ML_1 (gtk_source_language_get_globs, GtkSourceLanguage_val,
      string_list_of_strv2)

ML_2 (gtk_source_language_get_style_name, GtkSourceLanguage_val, String_val,
      Val_optstring)

ML_1 (gtk_source_language_get_style_ids, GtkSourceLanguage_val,
      string_list_of_strv2)


ML_0 (gtk_source_language_manager_new, Val_GtkAny_sink)

ML_0(gtk_source_language_manager_get_default,Val_GtkSourceLanguageManager)

/* This function leaks the strv. It needs to be freed before returning. */
ML_2(gtk_source_language_manager_set_search_path,GtkSourceLanguageManager_val,
     strv_of_string_list,Unit)

#if 0
// I need to find a test for this code
CAMLprim value ml_gtk_source_language_manager_set_search_path(value lm, value sl)
{
  gchar** strv = strv_of_string_list(sl);
  gchar **index = strv;
  gtk_source_language_manager_set_search_path(GtkSourceLanguageManager_val(lm),strv);

  while(*index != NULL) {g_free(*strv); strv++; };
  g_free(strv);
  return Val_unit;
}
#endif

ML_1(gtk_source_language_manager_get_search_path,GtkSourceLanguageManager_val,
     string_list_of_strv)
ML_1(gtk_source_language_manager_get_language_ids,GtkSourceLanguageManager_val,
     string_list_of_strv)
ML_2(gtk_source_language_manager_get_language,GtkSourceLanguageManager_val,
     String_val,Val_option_GtkSourceLanguage)
ML_3 (gtk_source_language_manager_guess_language, GtkSourceLanguageManager_val,
      String_option_val, String_option_val, Val_option_GtkSourceLanguage)


ML_2 (gtk_source_mark_new, String_val, String_val, Val_GtkSourceMark_new)

ML_1 (gtk_source_mark_get_category, GtkSourceMark_val, Val_string)
ML_2 (gtk_source_mark_next, GtkSourceMark_val, String_option_val, Val_option_GtkSourceMark)
ML_2 (gtk_source_mark_prev, GtkSourceMark_val, String_option_val, Val_option_GtkSourceMark)

// SourceMarkAttributes

ML_0(gtk_source_mark_attributes_new, Val_GtkSourceMarkAttributes_new)
ML_4(gtk_source_view_set_mark_attributes, GtkSourceView_val, String_val,
     GtkSourceMarkAttributes_val, Int_val, Unit)

CAMLprim value ml_gtk_source_view_get_mark_attributes(
  value obj, value category) {
  CAMLparam2(obj,category);
  CAMLlocal2(attr_opt,result);
  GtkSourceMarkAttributes* attributes;
  int prio;
  attributes =
    gtk_source_view_get_mark_attributes(
      GtkSourceView_val(obj), String_val(category), &prio);
  if (attributes) {
    attr_opt = Val_copy(attributes);
    result = alloc_small(1,0);
    Field(result,0) = attr_opt;
  }
  else
    result = Val_unit;
  CAMLreturn(result);
}

CAMLprim value ml_gtk_source_view_get_mark_priority(
  value obj, value category) {
  CAMLparam2(obj, category);
  int prio = 0;
  gtk_source_view_get_mark_attributes(
    GtkSourceView_val(obj), String_val(category), &prio);
  CAMLreturn(Val_int(prio));
}

// SourceUndoManager

// Defining a custom one: boilerplate

typedef struct _CustomObject CustomUndoManager;
typedef struct _CustomObjectClass CustomUndoManagerClass;

GType custom_undo_manager_get_type();

#define TYPE_CUSTOM_UNDO_MANAGER (custom_undo_manager_get_type ())
#define IS_CUSTOM_UNDO_MANAGER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), TYPE_CUSTOM_UNDO_MANAGER))

CAMLprim value ml_custom_undo_manager_new (value obj) {
  CAMLparam1(obj);
  CustomUndoManager* p = (CustomUndoManager*) g_object_new (TYPE_CUSTOM_UNDO_MANAGER, NULL);
  g_assert (p != NULL);
  p->caml_object = ml_global_root_new(obj);
  CAMLreturn (Val_GtkSourceUndoManager_new(p));
}

gboolean custom_undo_manager_can_undo (GtkSourceUndoManager* p) {
  g_return_val_if_fail (IS_CUSTOM_UNDO_MANAGER(p), FALSE);
  CustomUndoManager *obj = (CustomUndoManager *) p;
  return Bool_val (METHOD1(obj, 0, Val_unit));
}

gboolean custom_undo_manager_can_redo (GtkSourceUndoManager* p) {
  g_return_val_if_fail (IS_CUSTOM_UNDO_MANAGER(p), FALSE);
  CustomUndoManager *obj = (CustomUndoManager *) p;
  return Bool_val (METHOD1(obj, 1, Val_unit));
}

void custom_undo_manager_undo (GtkSourceUndoManager* p) {
  g_return_if_fail (IS_CUSTOM_UNDO_MANAGER(p));
  CustomUndoManager *obj = (CustomUndoManager *) p;
  METHOD1(obj, 2, Val_unit);
}

void custom_undo_manager_redo (GtkSourceUndoManager* p) {
  g_return_if_fail (IS_CUSTOM_UNDO_MANAGER(p));
  CustomUndoManager *obj = (CustomUndoManager *) p;
  METHOD1(obj, 3, Val_unit);
}

void custom_undo_manager_begin_not_undoable_action (GtkSourceUndoManager* p) {
  g_return_if_fail (IS_CUSTOM_UNDO_MANAGER(p));
  CustomUndoManager *obj = (CustomUndoManager *) p;
  METHOD1(obj, 4, Val_unit);
}

void custom_undo_manager_end_not_undoable_action (GtkSourceUndoManager* p) {
  g_return_if_fail (IS_CUSTOM_UNDO_MANAGER(p));
  CustomUndoManager *obj = (CustomUndoManager *) p;
  METHOD1(obj, 5, Val_unit);
}

void custom_undo_manager_can_undo_changed (GtkSourceUndoManager* p) {
  g_return_if_fail (IS_CUSTOM_UNDO_MANAGER(p));
  CustomUndoManager *obj = (CustomUndoManager *) p;
  METHOD1(obj, 6, Val_unit);
}

void custom_undo_manager_can_redo_changed (GtkSourceUndoManager* p) {
  g_return_if_fail (IS_CUSTOM_UNDO_MANAGER(p));
  CustomUndoManager *obj = (CustomUndoManager *) p;
  METHOD1(obj, 7, Val_unit);
}

void custom_undo_manager_class_init (CustomUndoManagerClass* c) {
  GObjectClass *object_class;
  object_class = (GObjectClass*) c;
  object_class->finalize = custom_object_finalize;
}

void custom_undo_manager_interface_init (GtkSourceUndoManagerIface *iface, gpointer data) {
  iface->can_undo = custom_undo_manager_can_undo;
  iface->can_redo = custom_undo_manager_can_redo;
  iface->undo = custom_undo_manager_undo;
  iface->redo = custom_undo_manager_redo;
  iface->begin_not_undoable_action = custom_undo_manager_begin_not_undoable_action;
  iface->end_not_undoable_action = custom_undo_manager_end_not_undoable_action;
  iface->can_undo_changed = custom_undo_manager_can_undo_changed;
  iface->can_redo_changed = custom_undo_manager_can_redo_changed;
}

GType custom_undo_manager_get_type (void)
{
  /* Some boilerplate type registration stuff */
  static GType custom_undo_manager_type = 0;

  if (custom_undo_manager_type == 0)
  {
    const GTypeInfo custom_undo_manager_info =
    {
      sizeof (CustomUndoManagerClass),
      NULL,                                         /* base_init */
      NULL,                                         /* base_finalize */
      (GClassInitFunc) custom_undo_manager_class_init,
      NULL,                                         /* class finalize */
      NULL,                                         /* class_data */
      sizeof (CustomUndoManager),
      0,                                           /* n_preallocs */
      NULL
    };

    static const GInterfaceInfo source_undo_manager_info =
    {
      (GInterfaceInitFunc) custom_undo_manager_interface_init,
      NULL,
      NULL
    };

    custom_undo_manager_type = g_type_register_static (G_TYPE_OBJECT, "custom_undo_manager",
                                               &custom_undo_manager_info, (GTypeFlags)0);

    /* Here we register our GtkTreeModel interface with the type system */
    g_type_add_interface_static (custom_undo_manager_type, GTK_SOURCE_TYPE_UNDO_MANAGER, &source_undo_manager_info);
  }

  return custom_undo_manager_type;
}


ML_1 (gtk_source_undo_manager_can_undo, GtkSourceUndoManager_val, Val_bool)
ML_1 (gtk_source_undo_manager_can_redo, GtkSourceUndoManager_val, Val_bool)
ML_1 (gtk_source_undo_manager_undo, GtkSourceUndoManager_val, Unit)
ML_1 (gtk_source_undo_manager_redo, GtkSourceUndoManager_val, Unit)
ML_1 (gtk_source_undo_manager_begin_not_undoable_action, GtkSourceUndoManager_val, Unit)
ML_1 (gtk_source_undo_manager_end_not_undoable_action, GtkSourceUndoManager_val, Unit)
ML_1 (gtk_source_undo_manager_can_undo_changed, GtkSourceUndoManager_val, Unit)
ML_1 (gtk_source_undo_manager_can_redo_changed, GtkSourceUndoManager_val, Unit)

// SourceBuffer

ML_1 (gtk_source_buffer_new, GtkTextTagTable_val, Val_GtkSourceBuffer_new)
ML_1 (gtk_source_buffer_new_with_language, GtkSourceLanguage_val, Val_GtkAny_sink)
ML_1 (gtk_source_buffer_can_undo, GtkSourceBuffer_val, Val_bool)
ML_1 (gtk_source_buffer_can_redo, GtkSourceBuffer_val, Val_bool)
ML_1 (gtk_source_buffer_undo, GtkSourceBuffer_val, Unit)
ML_1 (gtk_source_buffer_redo, GtkSourceBuffer_val, Unit)
ML_1 (gtk_source_buffer_begin_not_undoable_action, GtkSourceBuffer_val, Unit)
ML_1 (gtk_source_buffer_end_not_undoable_action, GtkSourceBuffer_val, Unit)
ML_4 (gtk_source_buffer_create_source_mark, GtkSourceBuffer_val,
      String_option_val, String_option_val, GtkTextIter_val, Val_GtkSourceMark)
ML_4 (gtk_source_buffer_remove_source_marks, GtkSourceBuffer_val,
      GtkTextIter_val, GtkTextIter_val, String_option_val, Unit)
ML_3 (gtk_source_buffer_get_source_marks_at_iter, GtkSourceBuffer_val,
      GtkTextIter_val,String_option_val, source_marker_list_of_GSList)
ML_3 (gtk_source_buffer_get_source_marks_at_line, GtkSourceBuffer_val,
      Int_val,String_option_val, source_marker_list_of_GSList)

ML_3 (gtk_source_buffer_forward_iter_to_source_mark, GtkSourceBuffer_val, GtkTextIter_val, String_option_val, Val_bool)
ML_3 (gtk_source_buffer_backward_iter_to_source_mark, GtkSourceBuffer_val, GtkTextIter_val, String_option_val, Val_bool)

ML_3 (gtk_source_buffer_iter_has_context_class, GtkSourceBuffer_val,
      GtkTextIter_val, String_val, Val_bool)
ML_3 (gtk_source_buffer_iter_forward_to_context_class_toggle,
      GtkSourceBuffer_val, GtkTextIter_val, String_val, Val_bool)
ML_3 (gtk_source_buffer_iter_backward_to_context_class_toggle,
      GtkSourceBuffer_val, GtkTextIter_val, String_val, Val_bool)

ML_3 (gtk_source_buffer_ensure_highlight, GtkSourceBuffer_val,
      GtkTextIter_val, GtkTextIter_val, Unit)

ML_2 (gtk_source_buffer_set_highlight_matching_brackets, GtkSourceBuffer_val, Bool_val, Unit);


ML_0 (gtk_source_view_new, Val_GtkWidget_sink)
ML_1 (gtk_source_view_new_with_buffer, GtkSourceBuffer_val, Val_GtkWidget_sink)

/* The following are apparently removed in gtksourceview3, replaced by gtk_source_view_get_mark_category (TODO?)
ML_2 (gtk_source_view_get_mark_category_priority,
      GtkSourceView_val, String_val, Val_int)
ML_3 (gtk_source_view_set_mark_category_priority,
      GtkSourceView_val, String_val, Int_val, Unit)
ML_3 (gtk_source_view_set_mark_category_pixbuf, GtkSourceView_val,
      String_val, GdkPixbuf_option_val, Unit)
ML_2 (gtk_source_view_get_mark_category_pixbuf, GtkSourceView_val,
      String_val, Val_option_GdkPixbuf)
ML_3 (gtk_source_view_set_mark_category_background,
      GtkSourceView_val, String_val, GdkColor_option_val, Unit)

CAMLprim value ml_gtk_source_view_get_mark_category_background
(value sv, value s, value c) {
     CAMLparam3(sv, s, c);
     CAMLlocal2(color, result);
     GdkColor dest;

     if (gtk_source_view_get_mark_category_background(
	      GtkSourceView_val(sv), String_val(s), &dest)) {
	  color = Val_copy(dest);
	  result = alloc_small(1, 0);
	  Field(result, 0) = color;
     }
     else
	  result = Val_unit;

     CAMLreturn(result);
}
*/

ML_1 (gtk_source_view_get_completion, GtkSourceView_val, Val_GtkSourceCompletion)

/* Make_Flags_val(Source_draw_spaces_flags_val) */
/* #define Val_flags_Draw_spaces_flags(val) \ */
/*      ml_lookup_flags_getter(ml_table_source_draw_spaces_flags, val) */

/* XXX */
/* ML_1 (gtk_source_view_get_draw_spaces, */
/*       GtkSourceView_val, Val_flags_Draw_spaces_flags) */

/* ML_2 (gtk_source_view_set_draw_spaces, */
/*       GtkSourceView_val, Flags_Source_draw_spaces_flags_val, Unit) */

/* This code was taken from gedit */
/* assign a unique name */
static G_CONST_RETURN gchar *
get_widget_name (GtkWidget *w)
{
        const gchar *name;

        name = gtk_widget_get_name (w);
        g_return_val_if_fail (name != NULL, NULL);

        if (strcmp (name, g_type_name (G_OBJECT_TYPE (w))) == 0)
        {
                static guint d = 0;
                gchar *n;

                n = g_strdup_printf ("%s_%u_%u", name, d, g_random_int());
                d++;

                gtk_widget_set_name (w, n);
                g_free (n);

                name = gtk_widget_get_name (w);
        }

        return name;
}
/* There is no clean way to set the cursor-color, so we are stuck
 * with the following hack: set the name of each widget and parse
 * a gtkrc string.
 */
static void
gtk_modify_cursor_color (GtkWidget *textview,
                     GdkColor  *color)
{
        static const char cursor_color_rc[] =
                "style \"svs-cc\"\n"
                "{\n"
                        "GtkSourceView::cursor-color=\"#%04x%04x%04x\"\n"
                "}\n"
                "widget \"*.%s\" style : application \"svs-cc\"\n";

        const gchar *name;
        gchar *rc_temp;

        name = get_widget_name (textview);
        g_return_if_fail (name != NULL);

        if (color != NULL)
        {
                rc_temp = g_strdup_printf (cursor_color_rc,
                                           color->red,
                                           color->green,
                                           color->blue,
                                           name);
        }
        else
        {
                GtkRcStyle *rc_style;

                rc_style = gtk_widget_get_modifier_style (textview);

                rc_temp = g_strdup_printf (cursor_color_rc,
                                           rc_style->text [GTK_STATE_NORMAL].red,
                                           rc_style->text [GTK_STATE_NORMAL].green,
                                           rc_style->text [GTK_STATE_NORMAL].blue,
                                           name);
        }

        gtk_rc_parse_string (rc_temp);
        gtk_widget_reset_rc_styles (textview);

        g_free (rc_temp);
}
/* end of gedit code */

ML_2(gtk_modify_cursor_color,GtkWidget_val,GdkColor_val,Unit);

/* Not anymore in gtksourceview3; ml_gtk_source_iter_*_search told to be now in gtk+
#define Make_search(dir) \
CAMLprim value ml_gtk_source_iter_##dir##_search (value ti,\
                                                value str,\
                                                value flag,\
                                                value ti_stop,\
                                                value ti_start,\
                                                value ti_lim)\
{ CAMLparam5(ti,str,flag,ti_start,ti_stop);\
  CAMLxparam1(ti_lim);\
  CAMLlocal2(res,coup);\
  GtkTextIter* ti1,*ti2;\
  gboolean b;\
  ti1=gtk_text_iter_copy(GtkTextIter_val(ti_start));\
  ti2=gtk_text_iter_copy(GtkTextIter_val(ti_stop));\
  b=gtk_source_iter_##dir##_search(GtkTextIter_val(ti),\
                                 String_val(str),\
                                 OptFlags_Source_search_flag_val(flag),\
                                 ti1,\
                                 ti2,\
                                 Option_val(ti_lim,GtkTextIter_val,NULL));\
  if (!b) res = Val_unit;\
  else \
    { res = alloc(1,0);\
      coup = alloc_tuple(2);\
      Store_field(coup,0,Val_GtkTextIter(ti1));\
      Store_field(coup,1,Val_GtkTextIter(ti2));\
      Store_field(res,0,coup);};\
  CAMLreturn(res);}

Make_search(forward);
Make_search(backward);
ML_bc6(ml_gtk_source_iter_forward_search);
ML_bc6(ml_gtk_source_iter_backward_search);
*/

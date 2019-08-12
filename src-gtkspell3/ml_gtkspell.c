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

#include <gtk/gtk.h>
#include <gtkspell/gtkspell.h>

#include <caml/mlvalues.h>

#include <wrappers.h>
#include <ml_gobject.h>
#include <ml_glib.h>

CAMLprim value
ml_gtkspell_init (value unit)
{
  ml_register_exn_map (GTK_SPELL_ERROR, "gtkspell_error");
  return Val_unit;
}

CAMLprim value
ml_gtkspell_new_attach (value textview)
{
  GtkSpellChecker *sc = gtk_spell_checker_new();
  if (!gtk_spell_checker_attach (sc, check_cast(GTK_TEXT_VIEW, textview))) {
    g_object_unref(sc);
    failwith("GtkSpell.attach");
  }
  return Val_GAnyObject(sc);
}

CAMLprim value
ml_gtkspell_is_attached (value textview)
{
  return Val_bool (gtk_spell_checker_get_from_text_view
                     (check_cast(GTK_TEXT_VIEW, textview)));
} 

CAMLprim value
ml_gtkspell_get_from_text_view (value view)
{
  GtkSpellChecker *s;
  s = gtk_spell_checker_get_from_text_view (check_cast(GTK_TEXT_VIEW, view));
  return s ? ml_some (Val_GAnyObject (s)) : Val_unit;
}

#define GtkSpell_val(v) (GtkSpellChecker *)GObject_val(v)

ML_1 (gtk_spell_checker_detach, GtkSpell_val, Unit)

CAMLprim value
ml_gtkspell_set_language (value spell, value lang)
{
  GError *err = NULL;
  if (! gtk_spell_checker_set_language (GtkSpell_val (spell),
			       String_option_val (lang), &err))
    ml_raise_gerror (err);
  return Val_unit;
}

ML_1 (gtk_spell_checker_recheck_all, GtkSpell_val, Unit)

(**************************************************************************)
(*                Lablgtk                                                 *)
(*                                                                        *)
(*    This program is free software; you can redistribute it              *)
(*    and/or modify it under the terms of the GNU Library General         *)
(*    Public License as published by the Free Software Foundation         *)
(*    version 2, with the exception described in file COPYING which       *)
(*    comes with the library.                                             *)
(*                                                                        *)
(*    This program is distributed in the hope that it will be useful,     *)
(*    but WITHOUT ANY WARRANTY; without even the implied warranty of      *)
(*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       *)
(*    GNU Library General Public License for more details.                *)
(*                                                                        *)
(*    You should have received a copy of the GNU Library General          *)
(*    Public License along with this program; if not, write to the        *)
(*    Free Software Foundation, Inc., 59 Temple Place, Suite 330,         *)
(*    Boston, MA 02111-1307  USA                                          *)
(*                                                                        *)
(*                                                                        *)
(**************************************************************************)

open GtkSourceView3_types
open Gaux
open Gobject
open Gtk
open Tags
open SourceView3Enums
open GtkSourceView3Props
open GtkBase

module SourceStyleScheme =
struct
  include SourceStyleScheme
  external get_name: source_style_scheme obj -> string =
    "ml_gtk_source_style_scheme_get_name"
  external get_description: source_style_scheme obj -> string =
    "ml_gtk_source_style_scheme_get_description"
end

module SourceCompletionItem =
struct
  include SourceCompletionItem

  external new_:
    string -> string -> GdkPixbuf.pixbuf option -> string option -> source_completion_proposal obj =
    "ml_gtk_source_completion_item_new"
  external new_with_markup:
    string -> string -> GdkPixbuf.pixbuf option -> string option -> source_completion_proposal obj =
    "ml_gtk_source_completion_item_new_with_markup"
  external new_from_stock:
    string -> string -> string -> string -> source_completion_proposal obj =
    "ml_gtk_source_completion_item_new_from_stock" 

end

module SourceCompletionProvider =
struct
  include SourceCompletionProvider

  type provider = {
    provider_name : unit -> string;
    provider_icon : unit -> GdkPixbuf.pixbuf option;
    provider_populate : source_completion_context obj -> unit;
    provider_activation : unit -> source_completion_activation_flags list;
    provider_match : source_completion_context obj -> bool;
    provider_info_widget : source_completion_proposal obj -> widget obj option;
    provider_update_info : source_completion_proposal obj -> source_completion_info obj -> unit;
    provider_start_iter : source_completion_context obj -> source_completion_proposal obj -> text_iter -> bool;
    provider_activate_proposal : source_completion_proposal obj -> text_iter -> bool;
    provider_interactive_delay : unit -> int;
    provider_priority : unit -> int;
  }

  external match_ : source_completion_provider obj -> source_completion_context obj -> bool =
    "ml_gtk_source_completion_provider_match"
  external new_ : provider -> source_completion_provider obj =
    "ml_custom_completion_provider_new"

end

module SourceCompletionContext = SourceCompletionContext

module SourceCompletionInfo = SourceCompletionInfo

module SourceCompletion = SourceCompletion

module SourceStyleSchemeManager =
struct
  include SourceStyleSchemeManager

  external new_ : unit -> source_style_scheme_manager obj =
    "ml_gtk_source_style_scheme_manager_new"
  external default : unit -> source_style_scheme_manager obj =
    "ml_gtk_source_style_scheme_manager_get_default"
end

module SourceLanguage =
struct
  include SourceLanguage

  external get_id : [>`sourcelanguage] obj -> string
    = "ml_gtk_source_language_get_id"
  external get_name : [>`sourcelanguage] obj -> string
    = "ml_gtk_source_language_get_name"
  external get_section : [>`sourcelanguage] obj -> string
    = "ml_gtk_source_language_get_section"
  external get_hidden : [>`sourcelanguage] obj -> bool
    = "ml_gtk_source_language_get_hidden"

  external metadata: [>`sourcelanguage] obj -> string -> string option=
    "ml_gtk_source_language_get_metadata"
  external mime_types: [>`sourcelanguage] obj -> string list =
    "ml_gtk_source_language_get_mime_types"
  external globs: [>`sourcelanguage] obj -> string list =
    "ml_gtk_source_language_get_globs"
  external style_name: [>`sourcelanguage] obj -> string -> string option =
    "ml_gtk_source_language_get_style_name"
  external style_ids: [>`sourcelanguage] obj -> string list =
    "ml_gtk_source_language_get_style_ids"
end

module SourceLanguageManager =
struct
  include SourceLanguageManager
  external new_: unit -> source_language_manager obj =
    "ml_gtk_source_language_manager_new"

  external default: unit -> source_language_manager obj
    = "ml_gtk_source_language_manager_get_default"

  external set_search_path:
    [>`sourcelanguagemanager] obj -> string list -> unit
    = "ml_gtk_source_language_manager_set_search_path"

  external search_path:
    [>`sourcelanguagemanager] obj -> string list
    = "ml_gtk_source_language_manager_get_search_path"

  external language_ids:
    [>`sourcelanguagemanager] obj -> string list
    = "ml_gtk_source_language_manager_get_language_ids"

  external language:
    [>`sourcelanguagemanager] obj -> string -> source_language obj option
    = "ml_gtk_source_language_manager_get_language"

  external guess_language:
    [>`sourcelanguagemanager] obj ->
    string option -> string option -> source_language obj option
    = "ml_gtk_source_language_manager_guess_language"

end

module SourceUndoManager =
struct
  include SourceUndoManager

  type undo_manager = {
    can_undo : unit -> bool;
    can_redo : unit -> bool;
    undo : unit -> unit;
    redo : unit -> unit;
    begin_not_undoable_action : unit -> unit;
    end_not_undoable_action : unit -> unit;
    can_undo_changed : unit -> unit;
    can_redo_changed : unit -> unit;
  }

  external new_ : undo_manager -> [`sourceundomanager] obj =
    "ml_custom_undo_manager_new"

end

module SourceBuffer =
struct
  include SourceBuffer
   external new_: [`texttagtable] obj -> source_buffer obj = "ml_gtk_source_buffer_new"
   external new_with_langage: [>`sourcelanguage] obj -> source_buffer obj =
    "ml_gtk_source_buffer_new_with_language"
  external undo: [>`sourcebuffer] obj -> unit = "ml_gtk_source_buffer_undo"
  external redo: [>`sourcebuffer] obj -> unit = "ml_gtk_source_buffer_redo"
  external begin_not_undoable_action: [>`sourcebuffer] obj -> unit =
    "ml_gtk_source_buffer_begin_not_undoable_action"
  external end_not_undoable_action: [>`sourcebuffer] obj -> unit =
    "ml_gtk_source_buffer_end_not_undoable_action"
  external set_highlight_matching_brackets: [>`sourcebuffer] obj -> bool -> unit =
    "ml_gtk_source_buffer_set_highlight_matching_brackets"
  external create_source_mark:
      [>`sourcebuffer] obj -> string option -> string option -> Gtk.text_iter ->
      source_mark obj =
      "ml_gtk_source_buffer_create_source_mark"
  external remove_source_marks:
      [>`sourcebuffer] obj
    -> Gtk.text_iter -> Gtk.text_iter -> string option -> unit =
    "ml_gtk_source_buffer_remove_source_marks"
  external get_source_marks_at_line:
      [>`sourcebuffer] obj -> int -> string option -> source_mark obj list =
      "ml_gtk_source_buffer_get_source_marks_at_line"
  external get_source_marks_at_iter:
    [>`sourcebuffer] obj -> Gtk.text_iter -> string option ->
    source_mark obj list =
    "ml_gtk_source_buffer_get_source_marks_at_iter"
  external forward_iter_to_source_mark:
    [>`sourcebuffer] obj -> Gtk.text_iter -> string option -> bool =
    "ml_gtk_source_buffer_forward_iter_to_source_mark"
  external backward_iter_to_source_mark:
    [>`sourcebuffer] obj -> Gtk.text_iter -> string option -> bool =
    "ml_gtk_source_buffer_backward_iter_to_source_mark"

  external iter_has_context_class:
    [>`sourcebuffer] obj -> Gtk.text_iter -> string -> bool =
    "ml_gtk_source_buffer_iter_has_context_class"
  external iter_forward_to_context_class_toggle:
    [>`sourcebuffer] obj -> Gtk.text_iter -> string -> bool =
    "ml_gtk_source_buffer_iter_forward_to_context_class_toggle"
  external iter_backward_to_context_class_toggle:
    [>`sourcebuffer] obj -> Gtk.text_iter -> string -> bool =
    "ml_gtk_source_buffer_iter_backward_to_context_class_toggle"


  external ensure_highlight:
    [>`sourcebuffer] obj -> Gtk.text_iter -> Gtk.text_iter -> unit =
    "ml_gtk_source_buffer_ensure_highlight"
end

module SourceView =
struct
  include SourceView
  external new_: unit -> source_view obj = "ml_gtk_source_view_new"
  external new_with_buffer: [>`sourcebuffer] obj -> source_view obj =
    "ml_gtk_source_view_new_with_buffer"
(*
  external set_mark_category_pixbuf:  [>`sourceview] obj -> string -> GdkPixbuf.pixbuf option -> unit =
    "ml_gtk_source_view_set_mark_category_pixbuf"
  external get_mark_category_pixbuf:  [>`sourceview] obj -> string -> GdkPixbuf.pixbuf option =
    "ml_gtk_source_view_get_mark_category_pixbuf"
*)

  external get_mark_attributes:
    [>`sourceview] obj -> category:string -> source_mark_attributes obj option =
    "ml_gtk_source_view_get_mark_attributes"

  external get_mark_priority: [>`sourceview] obj -> category:string -> int =
    "ml_gtk_source_view_get_mark_priority"

  (* Should probably not exist *)
  external set_cursor_color:   [>`sourceview] obj -> Gdk.color -> unit =
    "ml_gtk_modify_cursor_color"
end

module SourceMark =
struct
  include SourceMark
  external next: [> `sourcemark] obj -> string option -> source_mark obj option
    = "ml_gtk_source_mark_next"
  external prev: [> `sourcemark] obj -> string option -> source_mark obj option
    = "ml_gtk_source_mark_prev"
end

module SourceMarkAttributes =
struct
  include SourceMarkAttributes
  external new_attribute: unit -> source_mark_attributes obj =
    "ml_gtk_source_mark_attributes_new"
end

module SourceViewMisc =
struct
(*
  external iter_backward_search:
       Gtk.text_iter -> string -> SourceView2Enums.source_search_flag list ->
	start: Gtk.text_iter -> stop: Gtk.text_iter -> Gtk.text_iter option ->
	(Gtk.text_iter * Gtk.text_iter) option =
    "ml_gtk_source_iter_backward_search_bc" "ml_gtk_source_iter_backward_search"
  external iter_forward_search:
      Gtk.text_iter -> string -> SourceView2Enums.source_search_flag list ->
	start: Gtk.text_iter -> stop: Gtk.text_iter -> Gtk.text_iter option ->
	(Gtk.text_iter * Gtk.text_iter) option =
    "ml_gtk_source_iter_forward_search_bc" "ml_gtk_source_iter_forward_search"
*)
end

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

(** {2 GtkSourceView interface} *)

open Gtk
open GText
open SourceView2Enums

(** {2 GtkSourceStyleScheme} *)

class source_style_scheme :
  GtkSourceView2_types.source_style_scheme obj ->
  object
    method as_source_style_scheme :
      GtkSourceView2_types.source_style_scheme obj
    method name : string
    method description : string
  end


(** {2 GtkSourceStyleSchemeManager} *)

class source_style_scheme_manager :
  GtkSourceView2_types.source_style_scheme_manager obj ->
  object
    method search_path: string list
    method set_search_path: string list -> unit
    method append_search_path: string -> unit
    method prepend_search_path: string -> unit
    method style_scheme_ids: string list
    method style_scheme: string -> source_style_scheme option
    method force_rescan: unit -> unit
  end

val source_style_scheme_manager : default:bool -> source_style_scheme_manager

(** {2 GtkSourceCompletionInfo} *)

class source_completion_info_signals :
  (GtkSourceView2_types.source_completion_info as 'b) obj ->
  object ('a)
    inherit GContainer.container_signals
    method before_show : callback:(unit -> unit) -> GtkSignal.id
    method notify_max_height : callback:(int -> unit) -> GtkSignal.id
    method notify_max_width : callback:(int -> unit) -> GtkSignal.id
    method notify_shrink_height : callback:(bool -> unit) -> GtkSignal.id
    method notify_shrink_width : callback:(bool -> unit) -> GtkSignal.id
  end

class source_completion_info :
  ([> GtkSourceView2_types.source_completion_info ] as 'a) obj ->
  object
    inherit GWindow.window
    val obj : 'a obj
    method as_source_completion_info : GtkSourceView2_types.source_completion_info obj
    method max_height : int
    method max_width : int
    method process_resize : unit -> unit
    method set_max_height : int -> unit
    method set_max_width : int -> unit
    method set_shrink_height : bool -> unit
    method set_shrink_width : bool -> unit
    method set_sizing :
      width:int ->
      height:int -> shrink_width:bool -> shrink_height:bool -> unit
    method set_widget : GObj.widget -> unit
    method shrink_height : bool
    method shrink_width : bool
    method widget : GObj.widget
  end

(** {2 GtkSourceCompletionProposal} *)

class source_completion_proposal_signals :
  GtkSourceView2_types.source_completion_proposal obj ->
  object ('a)
    method after : 'a
    method changed : callback:(unit -> unit) -> GtkSignal.id
    method notify_icon : callback:(GdkPixbuf.pixbuf -> unit) -> GtkSignal.id
    method notify_info : callback:(string -> unit) -> GtkSignal.id
    method notify_label : callback:(string -> unit) -> GtkSignal.id
    method notify_markup : callback:(string -> unit) -> GtkSignal.id
    method notify_text : callback:(string -> unit) -> GtkSignal.id
  end

class source_completion_proposal :
  GtkSourceView2_types.source_completion_proposal obj ->
  object
    method as_source_completion_proposal : GtkSourceView2_types.source_completion_proposal obj
    method connect : source_completion_proposal_signals
    method icon : GdkPixbuf.pixbuf
    method info : string
    method label : string
    method markup : string
    method text : string
  end

class source_completion_item :
  GtkSourceView2_types.source_completion_proposal obj ->
  object
    inherit source_completion_proposal
    method set_icon : GdkPixbuf.pixbuf -> unit
    method set_info : string -> unit
    method set_label : string -> unit
    method set_markup : string -> unit
    method set_text : string -> unit
  end

val source_completion_item :
  ?label:string ->
  ?text:string ->
  ?icon:GdkPixbuf.pixbuf ->
  ?info:string -> unit -> source_completion_item

val source_completion_item_with_markup :
  ?label:string ->
  ?text:string ->
  ?icon:GdkPixbuf.pixbuf ->
  ?info:string -> unit -> source_completion_item

val source_completion_item_from_stock :
  ?label:string ->
  ?text:string ->
  stock:GtkStock.id -> info:string -> unit -> source_completion_item

(** {2 GtkSourceCompletionProvider} *)

class source_completion_provider :
  GtkSourceView2_types.source_completion_provider obj ->
  object
    method as_source_completion_provider : GtkSourceView2_types.source_completion_provider obj
    method icon : GdkPixbuf.pixbuf option
    method name : string
    method populate : source_completion_context -> unit
    method activation : source_completion_activation_flags list
    method matched : source_completion_context -> bool
    method info_widget : source_completion_proposal -> GObj.widget option
    method update_info : source_completion_proposal -> source_completion_info -> unit
    method start_iter : source_completion_context -> source_completion_proposal -> GText.iter
    method activate_proposal : source_completion_proposal -> GText.iter -> bool
    method interactive_delay : int
    method priority : int
  end

(** {2 GtkSourceCompletionContext} *)

and source_completion_context_signals :
  GtkSourceView2_types.source_completion_context obj ->
  object ('a)
    method after : 'a
    method cancelled : callback:(unit -> unit) -> GtkSignal.id
  end

and source_completion_context :
  GtkSourceView2_types.source_completion_context obj ->
  object
    method as_source_completion_context : GtkSourceView2_types.source_completion_context obj
    method activation : source_completion_activation_flags list
    method add_proposals :
      source_completion_provider ->
      source_completion_proposal list -> bool -> unit
    method connect : source_completion_context_signals
    method iter : GText.iter
    method set_iter : GText.iter -> unit
    method set_activation : source_completion_activation_flags list -> unit
  end

class type custom_completion_provider =
  object
    method name : string
    method icon : GdkPixbuf.pixbuf option
    method populate : source_completion_context -> unit
    method matched : source_completion_context -> bool
    method activation : source_completion_activation_flags list
    method info_widget : source_completion_proposal -> GObj.widget option
    method update_info : source_completion_proposal -> source_completion_info -> unit
    method start_iter : source_completion_context -> source_completion_proposal -> GText.iter -> bool
    method activate_proposal : source_completion_proposal -> GText.iter -> bool
    method interactive_delay : int
    method priority : int
  end

val source_completion_provider : custom_completion_provider -> source_completion_provider

(** {2 GtkSourceCompletion} *)

class source_completion_signals :
  GtkSourceView2_types.source_completion obj ->
  object ('a)
    method after : 'a
    method activate_proposal : callback:(unit -> unit) -> GtkSignal.id
    method hide : callback:(unit -> unit) -> GtkSignal.id
    method move_cursor :
      callback:(GtkEnums.scroll_step -> int -> unit) -> GtkSignal.id
    method move_page :
      callback:(GtkEnums.scroll_step -> int -> unit) -> GtkSignal.id
    method populate_context :
      callback:(source_completion_context -> unit) -> GtkSignal.id
    method show : callback:(unit -> unit) -> GtkSignal.id
    method notify_accelerators : callback:(int -> unit) -> GtkSignal.id
    method notify_auto_complete_delay : callback:(int -> unit) -> GtkSignal.id
    method notify_proposal_page_size : callback:(int -> unit) -> GtkSignal.id
    method notify_provider_page_size : callback:(int -> unit) -> GtkSignal.id
    method notify_remember_info_visibility :
      callback:(bool -> unit) -> GtkSignal.id
    method notify_select_on_show : callback:(bool -> unit) -> GtkSignal.id
    method notify_show_headers : callback:(bool -> unit) -> GtkSignal.id
    method notify_show_icons : callback:(bool -> unit) -> GtkSignal.id
  end

class source_completion :
  GtkSourceView2_types.source_completion obj ->
  object
    method accelerators : int
    method add_provider : source_completion_provider -> bool
    method as_source_completion : GtkSourceView2_types.source_completion obj
    method auto_complete_delay : int
    method block_interactive : unit -> unit
    method connect : source_completion_signals
    method create_context : GText.iter -> source_completion_context
    method hide : unit -> unit
    method move_window : GText.iter -> unit
    method proposal_page_size : int
    method providers : source_completion_provider list
    method provider_page_size : int
    method remember_info_visibility : bool
    method remove_provider : source_completion_provider -> bool
    method select_on_show : bool
    method set_accelerators : int -> unit
    method set_auto_complete_delay : int -> unit
    method set_proposal_page_size : int -> unit
    method set_provider_page_size : int -> unit
    method set_remember_info_visibility : bool -> unit
    method set_select_on_show : bool -> unit
    method set_show_headers : bool -> unit
    method set_show_icons : bool -> unit
    method show :
      source_completion_provider list -> source_completion_context -> bool
    method show_headers : bool
    method show_icons : bool
    method unblock_interactive : unit -> unit
  end

(** {2 GtkSourceLanguage} *)

class source_language:
  GtkSourceView2_types.source_language obj ->
  object
    method as_source_language: GtkSourceView2_types.source_language obj
    method misc: GObj.gobject_ops

    method hidden: bool
    method id: string
    method name: string
    method section: string

    method metadata: string -> string option
    method mime_types: string list
    method globs: string list
    method style_name: string -> string option
    method style_ids: string list
  end

(** {2 GtkSourceLanguageManager} *)

class source_language_manager:
  GtkSourceView2_types.source_language_manager obj ->
  object
    method get_oid: int
    method as_source_language_manager:
      GtkSourceView2_types.source_language_manager obj

    method set_search_path : string list -> unit
    method search_path : string list
    method language_ids : string list
    method language : string -> source_language option
    method guess_language:
      ?filename:string -> ?content_type:string -> unit -> source_language option
  end

val source_language_manager : default:bool -> source_language_manager


(** {2 GtkSourceMark} *)

class source_mark: ((GtkSourceView2_types.source_mark obj) as 'a) ->
object
  method as_source_mark : 'a
  method coerce: GText.mark
  method category: string option
  method next: ?category:string -> unit -> source_mark option
  method prev: ?category:string -> unit -> source_mark option
end

val source_mark : ?category:string -> unit -> source_mark

(** {2 GtkSourceUndoManager} *)

class source_undo_manager_signals :
  (GtkSourceView2_types.source_undo_manager as 'b) obj ->
object ('a)
  method after : 'a
  method can_redo_changed : callback:(unit -> unit) -> GtkSignal.id
  method can_undo_changed : callback:(unit -> unit) -> GtkSignal.id
end

class source_undo_manager: (GtkSourceView2_types.source_undo_manager as 'b) obj ->
  object
    val obj : 'b obj
    method as_source_undo_manager : GtkSourceView2_types.source_undo_manager obj
    method begin_not_undoable_action : unit -> unit
    method connect : source_undo_manager_signals
    method can_redo : bool
    method can_redo_changed : unit -> unit
    method can_undo : bool
    method can_undo_changed : unit -> unit
    method end_not_undoable_action : unit -> unit
    method redo : unit -> unit
    method undo : unit -> unit
  end

class type custom_undo_manager =
  object
    method can_undo : bool
    method can_redo : bool
    method undo : unit -> unit
    method redo : unit -> unit
    method begin_not_undoable_action : unit -> unit
    method end_not_undoable_action : unit -> unit
    method can_undo_changed : unit -> unit
    method can_redo_changed : unit -> unit
  end

val source_undo_manager : custom_undo_manager -> source_undo_manager

(** {2 GtkSourceBuffer} *)

class source_buffer_signals:
  (GtkSourceView2_types.source_buffer as 'b) obj ->
object ('a)
  inherit ['b] GText.buffer_signals_type
  method changed : callback:(unit -> unit) -> GtkSignal.id
  method highlight_updated:
    callback:(Gtk.text_iter -> Gtk.text_iter -> unit) -> GtkSignal.id
  method source_mark_updated: callback:(GtkSourceView2_types.source_mark obj -> unit) -> GtkSignal.id
  method notify_can_redo : callback:(bool -> unit) -> GtkSignal.id
  method notify_can_undo : callback:(bool -> unit) -> GtkSignal.id
  method notify_highlight_matching_brackets : callback:(bool -> unit) -> GtkSignal.id
  method notify_highlight_syntax : callback:(bool -> unit) -> GtkSignal.id
  method notify_max_undo_levels : callback:(int -> unit) -> GtkSignal.id
end

and source_buffer: GtkSourceView2_types.source_buffer obj ->
object
  inherit GText.buffer_skel
  val obj: GtkSourceView2_types.source_buffer obj
  method as_source_buffer: GtkSourceView2_types.source_buffer obj
  method connect: source_buffer_signals
  method misc: GObj.gobject_ops

  method highlight_syntax: bool
  method set_highlight_syntax: bool -> unit
  method language: source_language option
  method set_language: source_language option -> unit
  method highlight_matching_brackets: bool
  method set_highlight_matching_brackets: bool -> unit
  method style_scheme: source_style_scheme option
  method set_style_scheme: source_style_scheme option -> unit
  method max_undo_levels: int
  method set_max_undo_levels: int -> unit
  method undo: unit -> unit
  method redo: unit -> unit
  method can_undo: bool
  method can_redo: bool
  method begin_not_undoable_action: unit -> unit
  method end_not_undoable_action: unit -> unit

  method create_source_mark: ?name:string -> ?category:string -> GText.iter
    -> source_mark
  method source_marks_at_line: ?category:string -> int
    -> source_mark list
  method source_marks_at_iter: ?category:string -> GText.iter
    -> source_mark list
  method remove_source_marks :
    ?category:string -> start:GText.iter -> stop:GText.iter -> unit -> unit

  method forward_iter_to_source_mark: ?category:string -> GText.iter -> bool
  method backward_iter_to_source_mark: ?category:string -> GText.iter -> bool

  method iter_has_context_class: GText.iter -> string -> bool
  method iter_forward_to_context_class_toggle: GText.iter -> string -> bool
  method iter_backward_to_context_class_toggle: GText.iter -> string -> bool

  method ensure_highlight: start:GText.iter -> stop:GText.iter -> unit

  method undo_manager : source_undo_manager

  method set_undo_manager : source_undo_manager -> unit

end

val source_buffer:
  ?language:source_language ->
  ?style_scheme:source_style_scheme ->
  ?tag_table:GText.tag_table ->
  ?text:string ->
  ?undo_manager:source_undo_manager ->
  ?highlight_matching_brackets:bool ->
  ?highlight_syntax:bool ->
  ?max_undo_levels:int ->
  unit -> source_buffer

(** {2 GtkSourceView} *)

class source_view_signals:
  ([> GtkSourceView2_types.source_view ] as 'b) obj ->
  object ('a)
    inherit GText.view_signals
    method line_mark_activated :
      callback:(Gtk.text_iter -> GdkEvent.any -> unit) -> GtkSignal.id
    method move_lines : callback:(bool -> int -> unit) -> GtkSignal.id
    method move_words : callback:(int -> unit) -> GtkSignal.id
    method redo: callback:(unit -> unit) -> GtkSignal.id
    method show_completion : callback:(unit -> unit) -> GtkSignal.id
    method smart_home_end :
      callback:(Gtk.text_iter -> int -> unit) -> GtkSignal.id
    method undo: callback:(unit -> unit) -> GtkSignal.id
    method notify_auto_indent : callback:(bool -> unit) -> GtkSignal.id
    method notify_highlight_current_line : callback:(bool -> unit) -> GtkSignal.id
    method notify_indent_on_tab : callback:(bool -> unit) -> GtkSignal.id
    method notify_indent_width : callback:(int -> unit) -> GtkSignal.id
    method notify_insert_spaces_instead_of_tabs : callback:(bool -> unit) -> GtkSignal.id
    method notify_right_margin_position : callback:(int -> unit) -> GtkSignal.id
    method notify_show_line_marks : callback:(bool -> unit) -> GtkSignal.id
    method notify_show_line_numbers : callback:(bool -> unit) -> GtkSignal.id
    method notify_show_right_margin : callback:(bool -> unit) -> GtkSignal.id
    method notify_smart_home_end :
      callback:(SourceView2Enums.source_smart_home_end_type -> unit) -> GtkSignal.id
    method notify_tab_width : callback:(int -> unit) -> GtkSignal.id

  end

class source_view:
  GtkSourceView2_types.source_view obj ->
object
  inherit GText.view_skel
  inherit OgtkSourceView2Props.source_view_props
  val obj: GtkSourceView2_types.source_view obj
  method completion : source_completion
  method connect: source_view_signals
  method source_buffer: source_buffer
  method set_show_line_numbers: bool -> unit
  method show_line_numbers: bool
  method set_highlight_current_line: bool -> unit
  method highlight_current_line: bool
  method set_tab_width: int -> unit
  method tab_width: int
  method set_auto_indent: bool -> unit
  method auto_indent: bool
  method set_insert_spaces_instead_of_tabs: bool -> unit
  method insert_spaces_instead_of_tabs: bool
  method set_cursor_color: Gdk.color -> unit
  method set_cursor_color_by_name: string -> unit

  method draw_spaces:
    source_draw_spaces_flags list
  method set_draw_spaces:
    source_draw_spaces_flags list -> unit

  method get_mark_category_priority:
    category:string -> int
  method set_mark_category_priority:
    category:string -> int -> unit
  method get_mark_category_pixbuf:
    category:string -> GdkPixbuf.pixbuf option
  method set_mark_category_pixbuf:
    category:string -> GdkPixbuf.pixbuf option -> unit
  method get_mark_category_background:
    category:string -> Gdk.color option
  method set_mark_category_background:
    category:string -> Gdk.color option -> unit
end

val source_view :
  ?source_buffer:source_buffer ->
  ?draw_spaces:source_draw_spaces_flags list ->
  ?auto_indent:bool ->
  ?highlight_current_line:bool ->
  ?indent_on_tab:bool ->
  ?indent_width:int ->
  ?insert_spaces_instead_of_tabs:bool ->
  ?right_margin_position:int ->
  ?show_line_marks:bool ->
  ?show_line_numbers:bool ->
  ?show_right_margin:bool ->
  ?smart_home_end:source_smart_home_end_type ->
  ?tab_width:int ->
  ?editable:bool ->
  ?cursor_visible:bool ->
  ?justification:GtkEnums.justification ->
  ?wrap_mode:GtkEnums.wrap_mode ->
  ?accepts_tab:bool ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(GObj.widget -> unit) -> ?show:bool -> unit -> source_view


(** {2 Misc} *)

val iter_forward_search :
  GText.iter ->
  source_search_flag list ->
  start:< as_iter : Gtk.text_iter; .. > ->
  stop:< as_iter : Gtk.text_iter; .. > ->
  ?limit:< as_iter : Gtk.text_iter; .. > ->
  string -> (GText.iter * GText.iter) option

val iter_backward_search :
  GText.iter ->
  source_search_flag list ->
  start:< as_iter : Gtk.text_iter; .. > ->
  stop:< as_iter : Gtk.text_iter; .. > ->
  ?limit:< as_iter : Gtk.text_iter; .. > ->
  string -> (GText.iter * GText.iter) option

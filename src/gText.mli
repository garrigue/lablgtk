(* $Id$ *)

open Gtk

type mark = [`INSERT | `SEL_BOUND | `NAME of string | `MARK of textmark]

class child_anchor : textchildanchor ->
object
  val obj : textchildanchor
  method as_childanchor : textchildanchor
  method deleted : bool
  method get_oid : int
  method widgets : widget list
end
val child_anchor : unit -> child_anchor

class tag_signals : ([> `texttag] as 'b) obj ->
object ('a)
  val after : bool
  val obj : 'b obj
  method after : 'a
  method event :
    callback:(origin:unit Gobject.obj -> GdkEvent.any -> textiter -> unit) ->
    GtkSignal.id
end

class tag : texttag ->
object
  val obj : texttag
  method as_tag : texttag
  method connect : tag_signals
  method event : 'a obj -> GdkEvent.any -> textiter -> bool
  method get_oid : int
  method priority : int
  method set_priority : int -> unit
  method set_properties : GtkText.Tag.property list -> unit
  method set_property : GtkText.Tag.property -> unit
end
val tag : string -> tag

type contents =
  [ `CHAR of Glib.unichar
  | `PIXBUF of GdkPixbuf.pixbuf
  | `CHILD of child_anchor
  | `UNKNOWN ]

(* 
   Movement functions returning an iter are truly functional i.e. the returned iter shares nothing 
   with the originale one.
   If you need to move some iter in an imperative way use [#nocopy#...].
*)

class nocopy_iter : 
  textiter -> 
object
  val it : Gtk.textiter
  method backward_char : bool
  method backward_chars : int -> bool
  method backward_cursor_position : bool
  method backward_cursor_positions : int -> bool
  method backward_find_char : ?limit:iter -> (Glib.unichar -> bool) -> bool
  method backward_line : bool
  method backward_lines : int -> bool
  method backward_sentence_start : bool
  method backward_sentence_starts : int -> bool
  method backward_to_tag_toggle : tag option -> bool
  method backward_word_start : bool
  method backward_word_starts : int -> bool
  method forward_char : bool
  method forward_chars : int -> bool
  method forward_cursor_position : bool
  method forward_cursor_positions : int -> bool
  method forward_find_char : ?limit:iter -> (Glib.unichar -> bool) -> bool
  method forward_line : bool
  method forward_lines : int -> bool
  method forward_sentence_end : bool
  method forward_sentence_ends : int -> bool
  method forward_to_end : unit
  method forward_to_tag_toggle : tag option -> bool
  method forward_word_end : bool
  method forward_word_ends : int -> bool
  method forward_to_line_end : bool
  method set_line : int -> unit
  method set_line_index : int -> unit
  method set_line_offset : int -> unit
  method set_offset : int -> unit
  method set_visible_line_index : int -> unit
  method set_visible_line_offset : int -> unit
end 

and iter :
  textiter ->
object ('self)
  val it : textiter
  val nocopy : nocopy_iter
  method as_textiter : textiter
  method copy : iter
  method nocopy : nocopy_iter
  method backward_char : iter
  method backward_chars : int -> iter
  method backward_cursor_position : iter
  method backward_cursor_positions : int -> iter
  method backward_find_char : ?limit:iter -> (Glib.unichar -> bool) -> iter
  method backward_line : iter
  method backward_lines : int -> iter
  method backward_search : ?flags:Gtk.Tags.text_search_flag list ->
    ?limit:iter -> string -> (iter * iter) option
  method backward_sentence_start : iter
  method backward_sentence_starts : int -> iter
  method backward_to_tag_toggle : tag option -> iter
  method backward_word_start : iter
  method backward_word_starts : int -> iter
  method begins_tag : tag option -> bool
  method buffer : textbuffer
  method bytes_in_line : int
  method can_insert : default:bool -> bool
  method char : Glib.unichar
  method chars_in_line : int
  method compare : iter -> int
  method contents : contents
  method editable : default:bool -> bool
  method ends_line : bool
  method ends_sentence : bool
  method ends_tag : tag option -> bool
  method ends_word : bool
  method equal : iter -> bool
  method forward_char : iter
  method forward_chars : int -> iter
  method forward_cursor_position : iter
  method forward_cursor_positions : int -> iter
  method forward_find_char : ?limit:iter -> (Glib.unichar -> bool) -> iter
  method forward_line : iter
  method forward_lines : int -> iter
  method forward_search : ?flags:Gtk.Tags.text_search_flag list ->
    ?limit:iter -> string -> (iter * iter) option
  method forward_sentence_end : iter
  method forward_sentence_ends : int -> iter
  method forward_to_end : iter
  method forward_to_line_end : iter
  method forward_to_tag_toggle : tag option -> iter
  method forward_word_end : iter
  method forward_word_ends : int -> iter
  method get_slice : stop:iter -> string
  method get_text : stop:iter -> string
  method get_toggled_tags : bool -> tag list
  method get_visible_slice : stop:iter -> string
  method get_visible_text : stop:iter -> string
  method has_tag : tag -> bool
  method in_range : start:iter -> stop:iter -> bool
  method inside_sentence : bool
  method inside_word : bool
  method is_cursor_position : bool
  method is_end : bool
  method is_start : bool
  method language : string
  method line : int
  method line_index : int
  method line_offset : int
  method marks : textmark list
  method offset : int
  method set_line : int -> iter
  method set_line_index : int -> iter
  method set_line_offset : int -> iter
  method set_offset : int -> iter
  method set_visible_line_index : int -> iter
  method set_visible_line_offset : int -> iter
  method starts_line : bool
  method starts_sentence : bool
  method starts_word : bool
  method tags : tag list
  method toggles_tag : tag option -> bool
  method visible_line_index : int
  method visible_line_offset : int
end

val as_textiter : iter -> textiter

class tagtable_signals : ([> `texttagtable] as 'b) obj ->
object ('a)
  val after : bool
  val obj : 'b obj
  method after : 'a
  method tag_added : callback:(texttag -> unit) -> GtkSignal.id
  method tag_changed : callback:(texttag -> bool -> unit) -> GtkSignal.id
  method tag_removed : callback:(texttag -> unit) -> GtkSignal.id
end

class tagtable : texttagtable ->
object
  val obj : texttagtable
  method add : texttag -> unit
  method as_tagtable : texttagtable
  method connect : tagtable_signals
  method get_oid : int
  method lookup : string -> texttag option
  method remove : texttag -> unit
  method size : int
end
val tagtable : unit -> tagtable

class buffer_signals : ([> `textbuffer] as 'b) obj ->
object ('a)
  val after : bool
  val obj : 'b obj
  method after : 'a
  method apply_tag :
    callback:(tag -> start:iter -> stop:iter -> unit) -> GtkSignal.id
  method begin_user_action : callback:(unit -> unit) -> GtkSignal.id
  method changed : callback:(unit -> unit) -> GtkSignal.id
  method delete_range :
    callback:(start:iter -> stop:iter -> unit) -> GtkSignal.id
  method end_user_action : callback:(unit -> unit) -> GtkSignal.id
  method insert_child_anchor :
    callback:(iter -> textchildanchor -> unit) -> GtkSignal.id
  method insert_pixbuf :
    callback:(iter -> GdkPixbuf.pixbuf -> unit) -> GtkSignal.id
  method insert_text : callback:(iter -> string -> unit) -> GtkSignal.id
  method mark_deleted : callback:(textmark -> unit) -> GtkSignal.id
  method mark_set : callback:(iter -> textmark -> unit) -> GtkSignal.id
  method modified_changed : callback:(unit -> unit) -> GtkSignal.id
  method remove_tag :
    callback:(tag -> start:iter -> stop:iter -> unit) -> GtkSignal.id
end

exception No_such_mark of string

type position =
    [ `OFFSET of int | `LINE of int
    | `LINECHAR of int * int | `LINEBYTE of int * int
    | `START | `END | `ITER of iter | mark ]

class buffer : textbuffer ->
object
  val obj : textbuffer
  method add_selection_clipboard : Gtk.clipboard -> unit
  method apply_tag : tag -> start:iter -> stop:iter -> unit
  method apply_tag_by_name : string -> start:iter -> stop:iter -> unit
  method as_buffer : textbuffer
  method begin_user_action : unit -> unit
  method bounds : iter * iter
  method char_count : int
  method connect : buffer_signals
  method copy_clipboard : Gtk.clipboard -> unit
  method create_child_anchor : iter -> child_anchor
  method create_mark :
    ?name:string -> ?left_gravity:bool -> iter -> textmark
  method create_tag :
    ?name:string -> GtkText.Tag.property list -> tag
  method cut_clipboard : ?default_editable:bool -> Gtk.clipboard -> unit
  method delete : start:iter -> stop:iter -> unit
  method delete_interactive :
    start:iter ->
    stop:iter -> ?default_editable:bool -> unit -> bool
  method delete_mark : mark -> unit
  method delete_selection :
    ?interactive:bool -> ?default_editable:bool -> unit -> bool
  method end_iter : iter
  method end_user_action : unit -> unit
  method get_iter : position -> iter
  method get_iter_at_char : ?line:int -> int -> iter
  method get_iter_at_byte : line:int -> int -> iter
  method get_iter_at_mark : mark -> iter
  method get_mark : mark -> textmark
  method get_oid : int
  method get_text :
    ?start:iter -> ?stop:iter -> ?slice:bool -> ?visible:bool -> unit -> string
  method insert :
    ?iter:iter -> ?tag_names:string list -> ?tags:tag list 
    -> string -> unit
  method insert_child_anchor : iter -> child_anchor -> unit
  method insert_interactive :
    ?iter:iter -> ?default_editable:bool -> string -> bool
  method insert_pixbuf : iter:iter -> pixbuf:GdkPixbuf.pixbuf -> unit
  method insert_range :
    iter:iter -> start:iter -> stop:iter -> unit
  method insert_range_interactive :
    iter:iter -> start:iter -> stop:iter ->
    ?default_editable:bool -> unit -> bool
  method line_count : int
  method modified : bool
  method move_mark : mark -> where:iter -> unit
  method paste_clipboard : 
    ?iter:iter -> ?default_editable:bool -> Gtk.clipboard -> unit
  method place_cursor : where:iter -> unit
  method remove_all_tags : start:iter -> stop:iter -> unit
  method remove_selection_clipboard : Gtk.clipboard -> unit
  method remove_tag : tag -> start:iter -> stop:iter -> unit
  method remove_tag_by_name : string -> start:iter -> stop:iter -> unit
  method selection_bounds : iter * iter
  method set_modified : bool -> unit
  method set_text : string -> unit
  method start_iter : iter
  method tag_table : texttagtable
end
val buffer : ?tagtable:tagtable -> ?text:string -> unit -> buffer

class view_signals : ([> Gtk.textview] as 'b) obj ->
object ('a)
  val after : bool
  val obj : 'b obj
  method after : 'a
  method copy_clipboard : callback:(unit -> unit) -> GtkSignal.id
  method cut_clipboard : callback:(unit -> unit) -> GtkSignal.id
  method delete_from_cursor :
    callback:(Tags.delete_type -> int -> unit) -> GtkSignal.id
  method destroy : callback:(unit -> unit) -> GtkSignal.id
  method insert_at_cursor : callback:(string -> unit) -> GtkSignal.id
  method move_cursor :
    callback:(Tags.movement_step -> int -> bool -> unit) -> GtkSignal.id
  method move_focus :
    callback:(Tags.direction_type -> unit) -> GtkSignal.id
  method page_horizontally : callback:(int -> bool -> unit) -> GtkSignal.id
  method paste_clipboard : callback:(unit -> unit) -> GtkSignal.id
  method populate_popup :
    callback:(menu obj -> unit) -> GtkSignal.id
  method set_anchor : callback:(unit -> unit) -> GtkSignal.id
  method set_scroll_adjustments :
    callback:(adjustment obj -> adjustment obj -> unit) -> GtkSignal.id
  method toggle_overwrite : callback:(unit -> unit) -> GtkSignal.id
end

class view : textview obj ->
object
  val obj : textview obj
  method add_child_at_anchor : GObj.widget -> child_anchor -> unit
  method add_child_in_window :
    child:GObj.widget ->
    which_window:Tags.text_window_type -> x:int -> y:int -> unit
  method as_view : textview obj
  method as_widget : widget obj
  method backward_display_line : iter -> bool
  method backward_display_line_start : iter -> bool
  method buffer : buffer
  method buffer_to_window_coords :
    tag:Tags.text_window_type -> x:int -> y:int -> int * int
  method coerce : GObj.widget
  method connect : view_signals
  method cursor_visible : bool
  method destroy : unit -> unit
  method drag : GObj.drag_ops
  method editable : bool
  method event : GObj.event_ops
  method forward_display_line : iter -> bool
  method forward_display_line_end : iter -> bool
  method get_border_window_size : [ `BOTTOM | `LEFT | `RIGHT | `TOP] -> int
  method get_iter_at_location : x:int -> y:int -> iter
  method get_iter_location : iter -> Gdk.Rectangle.t
  method get_line_at_y : int -> iter * int
  method get_line_yrange : iter -> int * int
  method get_oid : int
  method get_window : Tags.text_window_type -> Gdk.window option
  method get_window_type : Gdk.window -> Tags.text_window_type
  method indent : int
  method justification : Tags.justification
  method left_margin : int
  method misc : GObj.misc_ops
  method move_child : child:GObj.widget -> x:int -> y:int -> unit
  method move_mark_onscreen : mark -> bool
  method move_visually : iter -> int -> bool
  method pixels_above_lines : int
  method pixels_below_lines : int
  method pixels_inside_wrap : int
  method place_cursor_onscreen : unit -> bool
  method right_margin : int
  method scroll_mark_onscreen : mark -> unit
  method scroll_to_iter :
    ?within_margin:float ->
    ?use_align:bool ->
    ?xalign:float -> ?yalign:float -> iter -> bool
  method scroll_to_mark :
    ?within_margin:float ->
    ?use_align:bool -> ?xalign:float -> ?yalign:float -> mark -> unit
  method set_border_window_size :
    typ:[ `BOTTOM | `LEFT | `RIGHT | `TOP] -> size:int -> unit
  method set_buffer : buffer -> unit
  method set_cursor_visible : bool -> unit
  method set_editable : bool -> unit
  method set_indent : int -> unit
  method set_justification : Tags.justification -> unit
  method set_left_margin : int -> unit
  method set_pixels_above_lines : int -> unit
  method set_pixels_below_lines : int -> unit
  method set_pixels_inside_wrap : int -> unit
  method set_right_margin : int -> unit
  method set_wrap_mode : Tags.wrap_mode -> unit
  method starts_display_line : iter -> bool
  method visible_rect : Gdk.Rectangle.t
  method window_to_buffer_coords :
    tag:Tags.text_window_type -> x:int -> y:int -> int * int
  method wrap_mode : Tags.wrap_mode
end
val view :
  ?buffer:buffer ->
  ?editable:bool ->
  ?cursor_visible:bool ->
  ?wrap_mode:Gtk.Tags.wrap_mode ->
  ?packing:(GObj.widget -> unit) -> ?show:bool -> unit -> view

open Gaux
open Gobject
open Gtk
open Tags
open GtkBase

module Mark = struct
  let cast w : textmark obj = Object.try_cast w "GtkTextMark"
  external set_visible : textmark obj -> bool -> unit 
    = "ml_gtk_text_mark_set_visible"
  external get_visible : textmark obj -> bool = "ml_gtk_text_mark_get_visible"
  external get_deleted : textmark obj -> bool = "ml_gtk_text_mark_get_deleted"
  external get_name : textmark obj -> string = "ml_gtk_text_mark_get_name"
  external get_buffer : textmark obj -> textbuffer obj 
    = "ml_gtk_text_mark_get_buffer"
  external get_left_gravity : textmark obj -> bool 
    = "ml_gtk_text_mark_get_left_gravity"
end

module Tag = struct
  let cast w : texttag obj = Object.try_cast w "GtkTextTag"
  external create : string -> texttag obj = "ml_gtk_text_tag_new"
  external get_priority : texttag obj -> int = "ml_gtk_text_tag_get_priority"
  external set_priority : texttag obj -> int -> unit 
    = "ml_gtk_text_tag_set_priority"
  external event : texttag obj -> 'a obj -> 'a Gdk.event -> textiter -> bool
    = "ml_gtk_text_tag_event"
  type property = 
    | Name of string
    | Background of string
    | Foreground of string 
    | Background_gdk of GDraw.color
    | Foreground_gdk of  GDraw.color
    | Background_stipple of Gdk.pixmap
    | Foreground_stipple of Gdk.pixmap
    | Font of string
	(*    | Font_desc of Pango.Font.description *)
    | Family of string
	(*    | Style of Pango.style 
	      | Variant of Pango.variant *)
    | Weight of int
	(*    | Stretch of Pango.stretch *)
    | Size of int
    | Size_points of float
    | Scale of float
    | Pixels_above_lines of int
    | Pixels_below_lines of int
    | Pixels_inside_wrap of int
    | Editable of bool
    | Wrap_mode of Gtk.Tags.wrap_mode
    | Justification of Gtk.Tags.justification
    | Direction of Gtk.Tags.text_direction
    | Left_margin of int
    | Indent of int
    | Strikethrough of bool
    | Right_margin of int
	(*    | Underline of Pango.underline *)
    | Rise of int
    | Background_full_height of bool
    | Language of string
	(*    | Tabs of Pango.TabArray.t *)
    | Invisible of bool
    | Background_set of bool
    | Foreground_set of bool
    | Background_stipple_set of bool
    | Foreground_stipple_set of bool
    | Family_set of bool
    | Style_set of bool
    | Variant_set of bool 
    | Weight_set of bool
    | Stretch_set of bool
    | Size_set of bool             
    | Scale_set of bool            
    | Pixels_above_lines_set of bool 
    | Pixels_below_lines_set of bool 
    | Pixels_inside_wrap_set of bool 
    | Editable_set of bool         
    | Wrap_mode_set of bool        
    | Justification_set of bool    
    | Left_margin_set of bool      
    | Indent_set of bool
    | Strikethrough_set of bool    
    | Right_margin_set of bool     
    | Underline_set of bool        
    | Rise_set of bool             
    | Background_full_height_set of bool 
    | Language_set of bool         
    | Tabs_set of bool             
    | Invisible_set of bool

  let property_to_string p = match p with
    | Name _ -> "name"
    | Background _ -> "background"
    | Foreground _ -> "foreground"
    | Background_gdk _ -> "background-gdk"
    | Foreground_gdk _ -> "foreground-gdk"
    | Background_stipple _ -> "background-stipple"
    | Foreground_stipple _ -> "foreground-stipple"
    | Font _ -> "font"
	(*    | Font_desc _ -> "font-desc" *)
    | Family _ -> "family"
	(*    | Style _ -> "style"
	      | Variant _ -> "variant" *)
    | Weight _ -> "weight"
	(*    | Stretch _ -> "stretch" *)
    | Size _ -> "size"
    | Size_points _ -> "size-points"
    | Scale _ -> "scale"
    | Pixels_above_lines _ -> "pixels-above-lines"
    | Pixels_below_lines _ -> "pixels-below-lines"
    | Pixels_inside_wrap _ -> "pixels-inside-wrap"
    | Editable _ -> "editable"
    | Wrap_mode _ -> "wrap-mode"
    | Justification _ -> "justification"
    | Direction _ -> "direction"
    | Left_margin _ -> "left-margin"
    | Indent _ -> "indent"
    | Strikethrough _ -> "strikethrough"
    | Right_margin _ -> "right-margin"
	(*    | Underline _ -> "underline" *)
    | Rise _ -> "rise"
    | Background_full_height _ -> "background-full-height"
    | Language _ -> "language"
	(*    | Tabs _ -> "tabs" *)
    | Invisible _ -> "invisible"
    | Background_set _ -> "background-set"
    | Foreground_set _ -> "foreground-set"
    | Background_stipple_set _ -> "background-stipple-set"
    | Foreground_stipple_set _ -> "foreground-stipple-set"
    | Family_set _ -> "family-set"
    | Style_set _ -> "style-set"
    | Variant_set _ -> "variant-set" 
    | Weight_set _ -> "weight-set"
    | Stretch_set _ -> "stretch-set"
    | Size_set _ -> "size-set"
    | Scale_set _ -> "scale-set"
    | Pixels_above_lines_set _ -> "pixels-above-lines-set"
    | Pixels_below_lines_set _ -> "pixels-below-lines-set"
    | Pixels_inside_wrap_set _ -> "pixels-inside-wrap-set"
    | Editable_set _ -> "editable-set"
    | Wrap_mode_set _ -> "wrap-mode-set"
    | Justification_set _ -> "justification-set"
    | Left_margin_set _ -> "left-margin-set"
    | Indent_set _ -> "indent-set"
    | Strikethrough_set _ -> "strikethrough-set"
    | Right_margin_set _ -> "right-margin-set"
    | Underline_set _ -> "underline-set"
    | Rise_set _ -> "rise-set"
    | Background_full_height_set _ -> "background-full-height-set"
    | Language_set _ -> "language-set"
    | Tabs_set _ -> "tabs-set"
    | Invisible_set _ -> "invisible-set"

  let set_property o p = match p with 
    | Name s | Background s | Foreground s | Font s | Family s 
    | Language s -> 
	let gtyp = Gobject.Type.of_fundamental `STRING in 
	let v = Gobject.Value.create gtyp in 
	  Gobject.Value.set v (`STRING (Some s)); 
	  Gobject.set_property o (property_to_string p) v 
    | Editable b | Strikethrough b | Background_full_height b 
    | Invisible b | Background_set b | Foreground_set b 
    | Background_stipple_set b | Foreground_stipple_set b 
    | Family_set b | Style_set b | Variant_set b
    | Weight_set b | Stretch_set b | Size_set b | Scale_set b
    | Pixels_above_lines_set b | Pixels_below_lines_set b 
    | Pixels_inside_wrap_set b | Editable_set b | Wrap_mode_set b 
    | Justification_set b | Left_margin_set b | Indent_set b 
    | Strikethrough_set b | Right_margin_set b | Underline_set b 
    | Rise_set b | Background_full_height_set b | Language_set b 
    | Tabs_set b | Invisible_set b -> 
	let gtyp = Gobject.Type.of_fundamental `BOOLEAN in 
	let v = Gobject.Value.create gtyp in 
	  Gobject.Value.set v (`BOOL b); 
	  Gobject.set_property o (property_to_string p) v 
	    
    | Rise b | Right_margin b | Indent b | Left_margin b 
    | Pixels_inside_wrap b 
    | Pixels_below_lines b | Pixels_above_lines b 
    | Size b | Weight b ->
	let gtyp = Gobject.Type.of_fundamental `INT in 
	let v = Gobject.Value.create gtyp in 
	  Gobject.Value.set v (`INT b); 
	  Gobject.set_property o (property_to_string p) v 
    | Size_points b | Scale b   -> 
	let gtyp = Gobject.Type.of_fundamental `FLOAT in 
	let v = Gobject.Value.create gtyp in 
	  Gobject.Value.set v (`FLOAT b); 
	  Gobject.set_property o (property_to_string p) v 
    | Foreground_stipple b | Background_stipple b ->
	assert false
    | Foreground_gdk b | Background_gdk b  -> assert false
    | Wrap_mode b  -> assert false
    | Direction b  -> assert false
    | Justification b -> assert false

end

module TagTable = struct
  let cast w : texttagtable obj = Object.try_cast w "GtkTextTagTable"
  external create : unit -> texttagtable obj = "ml_gtk_text_tag_table_new"
  external get_size : texttagtable obj -> int = "ml_gtk_text_tag_table_get_size"
end

module Buffer = struct
  let cast w : textbuffer obj = Object.try_cast w "GtkTextBuffer"
  external create : texttagtable obj option 
    -> textbuffer obj = "ml_gtk_text_buffer_new"
  external get_line_count : textbuffer obj -> int 
    = "ml_gtk_text_buffer_get_line_count"
  external get_char_count : textbuffer obj -> int 
    = "ml_gtk_text_buffer_get_char_count"
  external get_tag_table : textbuffer obj -> texttagtable obj 
    = "ml_gtk_text_buffer_get_tag_table"
  external insert : textbuffer obj -> textiter -> string -> int 
    -> unit = "ml_gtk_text_buffer_insert"
  external insert_at_cursor : textbuffer obj -> string -> int 
    -> unit = "ml_gtk_text_buffer_insert_at_cursor"
  external insert_interactive : textbuffer obj -> textiter -> string -> int 
    -> bool -> bool = "ml_gtk_text_buffer_insert_interactive"
  external insert_interactive_at_cursor : textbuffer obj -> string -> int
    -> bool -> bool = "ml_gtk_text_buffer_insert_interactive_at_cursor"
  external insert_range : textbuffer obj -> textiter -> textiter
    -> textiter -> unit = "ml_gtk_text_buffer_insert_range"
  external insert_range_interactive : textbuffer obj -> textiter -> textiter
    -> textiter -> bool -> bool = "ml_gtk_text_buffer_insert_range_interactive"
  external delete : textbuffer obj -> textiter -> textiter -> unit
    = "ml_gtk_text_buffer_insert_range_interactive"
  external delete_interactive : textbuffer obj -> textiter -> textiter 
    -> bool -> bool = "ml_gtk_text_buffer_insert_range_interactive"
  external set_text : textbuffer obj -> string -> int 
    -> unit = "ml_gtk_text_buffer_set_text"
  external get_text : textbuffer obj -> textiter -> textiter -> 
    bool -> string = "ml_gtk_text_buffer_get_text"
  external get_slice : textbuffer obj -> textiter -> textiter -> 
    bool -> string = "ml_gtk_text_buffer_get_slice"
  external insert_pixbuf : textbuffer obj -> textiter -> GdkPixbuf.pixbuf
    -> unit = "ml_gtk_text_buffer_insert_pixbuf"
  external create_mark : textbuffer obj -> string option -> textiter
    -> bool -> textmark obj = "ml_gtk_text_buffer_create_mark"
  external move_mark : textbuffer obj -> textmark obj -> textiter
   -> unit  = "ml_gtk_text_buffer_move_mark"
  external move_mark_by_name : textbuffer obj -> string -> textiter
   -> unit  = "ml_gtk_text_buffer_move_mark_by_name"
  external delete_mark : textbuffer obj -> textmark obj 
    -> unit  = "ml_gtk_text_buffer_delete_mark"
  external delete_mark_by_name : textbuffer obj -> string
   -> unit  = "ml_gtk_text_buffer_delete_mark_by_name"
  external get_mark : textbuffer obj -> string -> textmark obj 
    = "ml_gtk_text_buffer_get_mark"
  external get_insert : textbuffer obj -> textmark obj 
    = "ml_gtk_text_buffer_get_insert"
  external get_selection_bound : textbuffer obj -> textmark obj 
    = "ml_gtk_text_buffer_get_selection_bound"
  external place_cursor : textbuffer obj -> textiter -> unit 
    = "ml_gtk_text_buffer_place_cursor"
  external apply_tag : textbuffer obj -> texttag obj -> textiter -> textiter 
    -> unit = "ml_gtk_text_buffer_apply_tag"
  external remove_tag : textbuffer obj -> texttag obj -> textiter -> textiter 
    -> unit = "ml_gtk_text_buffer_remove_tag"
  external apply_tag_by_name : textbuffer obj -> string -> textiter -> textiter 
    -> unit = "ml_gtk_text_buffer_apply_tag_by_name"
  external remove_tag_by_name : textbuffer obj -> string -> textiter -> textiter 
    -> unit = "ml_gtk_text_buffer_remove_tag_by_name"
  external remove_all_tags : textbuffer obj -> textiter -> textiter 
    -> unit = "ml_gtk_text_buffer_remove_all_tags"
  external create_tag_0 : textbuffer obj -> string option 
    -> texttag obj = "ml_gtk_text_buffer_create_tag_0"
  external create_tag_2 : textbuffer obj -> string option 
    -> string -> string -> texttag obj = "ml_gtk_text_buffer_create_tag_2"
  external get_iter_at_line_offset : textbuffer obj -> int -> int -> textiter
    = "ml_gtk_text_buffer_get_iter_at_line_offset"
  external get_iter_at_offset : textbuffer obj -> int -> textiter
    = "ml_gtk_text_buffer_get_iter_at_offset"
  external get_iter_at_line : textbuffer obj ->  int -> textiter
    = "ml_gtk_text_buffer_get_iter_at_line"
  external get_iter_at_line_index : textbuffer obj ->  int -> int -> textiter
    = "ml_gtk_text_buffer_get_iter_at_line_index"
  external get_iter_at_mark : textbuffer obj -> textmark obj -> textiter
    = "ml_gtk_text_buffer_get_iter_at_mark"
  external get_start_iter : textbuffer obj 
    -> textiter = "ml_gtk_text_buffer_get_start_iter"
  external get_end_iter : textbuffer obj 
    -> textiter = "ml_gtk_text_buffer_get_end_iter"
  external get_bounds : textbuffer obj -> textiter * textiter
    = "ml_gtk_text_buffer_get_bounds"
  external get_modified : textbuffer obj -> bool
    = "ml_gtk_text_buffer_get_modified"
  external set_modified : textbuffer obj -> bool -> unit
    = "ml_gtk_text_buffer_set_modified"
  external delete_selection : textbuffer obj ->  bool -> bool -> unit
    = "ml_gtk_text_buffer_delete_selection"
  external get_selection_bounds : textbuffer obj ->  textiter * textiter
    = "ml_gtk_text_buffer_get_selection_bounds"
  external begin_user_action : textbuffer obj -> unit
    = "ml_gtk_text_buffer_begin_user_action"
  external end_user_action : textbuffer obj -> unit
    = "ml_gtk_text_buffer_end_user_action"
  module Signals = struct
  open GtkSignal
  let begin_user_action = 
    { name = "begin_user_action"; 
      classe = `textbuffer;
      marshaller = marshal_unit }
  let changed = 
    { name = "changed"; 
      classe = `textbuffer;
      marshaller = marshal_unit }
  let end_user_action = 
    { name = "end_user_action"; 
      classe = `textbuffer;
      marshaller = marshal_unit }
  let modified_changed = 
    { name = "modified-changed"; 
      classe = `textbuffer;
      marshaller = marshal_unit }
end    
end

module View = struct
  let cast w : textview obj = Object.try_cast w "GtkTextView"
  external create : unit -> textview obj = "ml_gtk_text_view_new"
  external create_with_buffer : textbuffer obj -> textview obj = "ml_gtk_text_view_new_with_buffer"
  external set_buffer : textview obj -> textbuffer obj -> unit = "ml_gtk_text_view_set_buffer"
  external get_buffer : textview obj -> textbuffer obj = "ml_gtk_text_view_get_buffer"
end

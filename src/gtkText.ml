open Gaux
open Gobject
open Gtk
open Tags
open GtkBase

(* This function helps one to guess the type of the arguments of signals *)
let marshal_what f _ = function 
  | `OBJECT _ :: _  -> invalid_arg "OBJECT"
  | `BOOL _ ::_ -> invalid_arg "BOOL"  
  | `CHAR _::_ -> invalid_arg "CHAR"
  | `FLOAT _::_ -> invalid_arg "FLOAT"
  | `INT _::_ -> invalid_arg "INT"
  | `INT64 _::_ -> invalid_arg "INT64"
  | `NONE::_ -> invalid_arg "NONE"
  | `POINTER _::_ -> invalid_arg "POINTER"
  | `STRING _::_  -> invalid_arg "STRING"
  | [] -> invalid_arg "NO ARGUMENTS"

module Mark = struct
  let cast w : textmark obj = Object.try_cast w "GtkTextMark"
  exception No_such_mark of string
  external set_visible : textmark obj -> bool -> unit 
    = "ml_gtk_text_mark_set_visible"
  external get_visible : textmark obj -> bool = "ml_gtk_text_mark_get_visible"
  external get_deleted : textmark obj -> bool = "ml_gtk_text_mark_get_deleted"
  external get_name : textmark obj -> string option = "ml_gtk_text_mark_get_name"
  external get_buffer : textmark obj -> textbuffer obj option
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
  external event : texttag obj -> 'a obj ->  'b Gdk.event -> textiter -> bool
    = "ml_gtk_text_tag_event"
  type property = 
      [ | `NAME of string
      | `BACKGROUND of string
      | `FOREGROUND of string 
      | `BACKGROUND_GDK of GDraw.color
      | `FOREGROUND_GDK of  GDraw.color
      | `BACKGROUND_STIPPLE of Gdk.pixmap
      | `FOREGROUND_STIPPLE of Gdk.pixmap
      | `FONT of string
      | `FONT_DESC of Pango.Font.description
      | `FAMILY of string
	  (*    | `STYLE of Pango.style 
		| `VARIANT of Pango.variant *)
      | `WEIGHT of int
	  (*    | `STRETCH of Pango.stretch *)
      | `SIZE of int
      | `SIZE_POINTS of float
      | `SCALE of float
      | `PIXELS_ABOVE_LINES of int
      | `PIXELS_BELOW_LINES of int
      | `PIXELS_INSIDE_WRAP of int
      | `EDITABLE of bool
      | `WRAP_MODE of Gtk.Tags.wrap_mode
      | `JUSTIFICATION of Gtk.Tags.justification
      | `DIRECTION of Gtk.Tags.text_direction
      | `LEFT_MARGIN of int
      | `INDENT of int
      | `STRIKETHROUGH of bool
      | `RIGHT_MARGIN of int
	  (*    | `UNDERLINE of Pango.underline *)
      | `RISE of int
      | `BACKGROUND_FULL_HEIGHT of bool
      | `LANGUAGE of string
	  (*    | `TABS of Pango.TabArray.t *)
      | `INVISIBLE of bool
      | `BACKGROUND_SET of bool
      | `FOREGROUND_SET of bool
      | `BACKGROUND_STIPPLE_SET of bool
      | `FOREGROUND_STIPPLE_SET of bool
      | `FAMILY_SET of bool
      | `STYLE_SET of bool
      | `VARIANT_SET of bool 
      | `WEIGHT_SET of bool
      | `STRETCH_SET of bool
      | `SIZE_SET of bool             
      | `SCALE_SET of bool            
      | `PIXELS_ABOVE_LINES_SET of bool 
      | `PIXELS_BELOW_LINES_SET of bool 
      | `PIXELS_INSIDE_WRAP_SET of bool 
      | `EDITABLE_SET of bool         
      | `WRAP_MODE_SET of bool        
      | `JUSTIFICATION_SET of bool    
      | `LEFT_MARGIN_SET of bool      
      | `INDENT_SET of bool
      | `STRIKETHROUGH_SET of bool    
      | `RIGHT_MARGIN_SET of bool     
      | `UNDERLINE_SET of bool        
      | `RISE_SET of bool             
      | `BACKGROUND_FULL_HEIGHT_SET of bool 
      | `LANGUAGE_SET of bool         
      | `TABS_SET of bool             
      | `INVISIBLE_SET of bool
      ]
  let property_to_string (p:property) = match p with
    | `NAME _ -> "name"
    | `BACKGROUND _ -> "background"
    | `FOREGROUND _ -> "foreground"
    | `BACKGROUND_GDK _ -> "background-gdk"
    | `FOREGROUND_GDK _ -> "foreground-gdk"
    | `BACKGROUND_STIPPLE _ -> "background-stipple"
    | `FOREGROUND_STIPPLE _ -> "foreground-stipple"
    | `FONT _ -> "font"
    | `FONT_DESC _ -> "font-desc"
    | `FAMILY _ -> "family"
	(*    | `STYLE _ -> "style"
	      | `VARIANT _ -> "variant" *)
    | `WEIGHT _ -> "weight"
	(*    | `STRETCH _ -> "stretch" *)
    | `SIZE _ -> "size"
    | `SIZE_POINTS _ -> "size-points"
    | `SCALE _ -> "scale"
    | `PIXELS_ABOVE_LINES _ -> "pixels-above-lines"
    | `PIXELS_BELOW_LINES _ -> "pixels-below-lines"
    | `PIXELS_INSIDE_WRAP _ -> "pixels-inside-wrap"
    | `EDITABLE _ -> "editable"
    | `WRAP_MODE _ -> "wrap-mode"
    | `JUSTIFICATION _ -> "justification"
    | `DIRECTION _ -> "direction"
    | `LEFT_MARGIN _ -> "left-margin"
    | `INDENT _ -> "indent"
    | `STRIKETHROUGH _ -> "strikethrough"
    | `RIGHT_MARGIN _ -> "right-margin"
	(*    | `UNDERLINE _ -> "underline" *)
    | `RISE _ -> "rise"
    | `BACKGROUND_FULL_HEIGHT _ -> "background-full-height"
    | `LANGUAGE _ -> "language"
	(*    | `TABS _ -> "tabs" *)
    | `INVISIBLE _ -> "invisible"
    | `BACKGROUND_SET _ -> "background-set"
    | `FOREGROUND_SET _ -> "foreground-set"
    | `BACKGROUND_STIPPLE_SET _ -> "background-stipple-set"
    | `FOREGROUND_STIPPLE_SET _ -> "foreground-stipple-set"
    | `FAMILY_SET _ -> "family-set"
    | `STYLE_SET _ -> "style-set"
    | `VARIANT_SET _ -> "variant-set" 
    | `WEIGHT_SET _ -> "weight-set"
    | `STRETCH_SET _ -> "stretch-set"
    | `SIZE_SET _ -> "size-set"
    | `SCALE_SET _ -> "scale-set"
    | `PIXELS_ABOVE_LINES_SET _ -> "pixels-above-lines-set"
    | `PIXELS_BELOW_LINES_SET _ -> "pixels-below-lines-set"
    | `PIXELS_INSIDE_WRAP_SET _ -> "pixels-inside-wrap-set"
    | `EDITABLE_SET _ -> "editable-set"
    | `WRAP_MODE_SET _ -> "wrap-mode-set"
    | `JUSTIFICATION_SET _ -> "justification-set"
    | `LEFT_MARGIN_SET _ -> "left-margin-set"
    | `INDENT_SET _ -> "indent-set"
    | `STRIKETHROUGH_SET _ -> "strikethrough-set"
    | `RIGHT_MARGIN_SET _ -> "right-margin-set"
    | `UNDERLINE_SET _ -> "underline-set"
    | `RISE_SET _ -> "rise-set"
    | `BACKGROUND_FULL_HEIGHT_SET _ -> "background-full-height-set"
    | `LANGUAGE_SET _ -> "language-set"
    | `TABS_SET _ -> "tabs-set"
    | `INVISIBLE_SET _ -> "invisible-set"

  let set_property o (p:property) = match p with 
    | `NAME s | `BACKGROUND s | `FOREGROUND s | `FONT s | `FAMILY s 
    | `LANGUAGE s -> 
	let gtyp = Gobject.Type.of_fundamental `STRING in 
	let v = Gobject.Value.create gtyp in 
	Gobject.Value.set v (`STRING (Some s)); 
	Gobject.set_property o (property_to_string p) v 
    | `EDITABLE b | `STRIKETHROUGH b | `BACKGROUND_FULL_HEIGHT b 
    | `INVISIBLE b | `BACKGROUND_SET b | `FOREGROUND_SET b 
    | `BACKGROUND_STIPPLE_SET b | `FOREGROUND_STIPPLE_SET b 
    | `FAMILY_SET b | `STYLE_SET b | `VARIANT_SET b
    | `WEIGHT_SET b | `STRETCH_SET b | `SIZE_SET b | `SCALE_SET b
    | `PIXELS_ABOVE_LINES_SET b | `PIXELS_BELOW_LINES_SET b 
    | `PIXELS_INSIDE_WRAP_SET b | `EDITABLE_SET b | `WRAP_MODE_SET b 
    | `JUSTIFICATION_SET b | `LEFT_MARGIN_SET b | `INDENT_SET b 
    | `STRIKETHROUGH_SET b | `RIGHT_MARGIN_SET b | `UNDERLINE_SET b 
    | `RISE_SET b | `BACKGROUND_FULL_HEIGHT_SET b | `LANGUAGE_SET b 
    | `TABS_SET b | `INVISIBLE_SET b -> 
	let gtyp = Gobject.Type.of_fundamental `BOOLEAN in 
	let v = Gobject.Value.create gtyp in 
	Gobject.Value.set v (`BOOL b);
	Gobject.set_property o (property_to_string p) v 
	  
    | `RISE b | `RIGHT_MARGIN b | `INDENT b | `LEFT_MARGIN b 
    | `PIXELS_INSIDE_WRAP b 
    | `PIXELS_BELOW_LINES b | `PIXELS_ABOVE_LINES b 
    | `SIZE b | `WEIGHT b ->
	let gtyp = Gobject.Type.of_fundamental `INT in 
	let v = Gobject.Value.create gtyp in 
	Gobject.Value.set v (`INT b); 
	Gobject.set_property o (property_to_string p) v 
    | `SIZE_POINTS b | `SCALE b   -> 
	let gtyp = Gobject.Type.of_fundamental `FLOAT in 
	let v = Gobject.Value.create gtyp in 
	Gobject.Value.set v (`FLOAT b); 
	Gobject.set_property o (property_to_string p) v 
    | `FOREGROUND_STIPPLE b | `BACKGROUND_STIPPLE b -> assert false
    | `FOREGROUND_GDK b | `BACKGROUND_GDK b  -> assert false
    | `WRAP_MODE b  -> assert false;
	let gtyp = Gobject.Type.from_name "GtkWrapMode" in 
	let v = Gobject.Value.create gtyp in 
	Gobject.Value.set 
	  v 
	  (`INT (Obj.magic b)); (* some lookup is needed to translate...*) 
	Gobject.set_property o (property_to_string p) v 

    | `DIRECTION b  -> assert false
    | `JUSTIFICATION b -> assert false
    | `FONT_DESC f ->
	let gtyp = Gobject.Type.from_name "PangoFontDescription" in 
	let v = Gobject.Value.create gtyp in 
	Gobject.Value.set 
	  v 
	  (`POINTER (Some (Obj.magic (Pango.Font.copy f))));
	(* Copying the font is COMPULSARY. 
	   Otherwise it's freed by the value itself...*)
	Gobject.set_property o (property_to_string p) v
  module Signals = struct
    open GtkSignal
    let marshal_event f _ = function
      |`OBJECT(Some p)::`POINTER(Some ev)::`POINTER(Some ti)::_ ->
	 f ~origin:p (GdkEvent.unsafe_copy ev : GdkEvent.any)
	  (Obj.magic ti:textiter)
      | _ -> invalid_arg "GtkText.Tag.Signals.marshal_event"
	  
    let event = 
      {
	name = "event";
	classe = `texttag;
	marshaller = marshal_event
      }
  end
end

module TagTable = struct
  let cast w : texttagtable obj = Object.try_cast w "GtkTextTagTable"
  external create : unit -> texttagtable obj = "ml_gtk_text_tag_table_new"
  external add : texttagtable obj -> texttag obj -> unit = "ml_gtk_text_tag_table_add"
  external remove : texttagtable obj -> texttag obj -> unit = "ml_gtk_text_tag_table_remove"
  external lookup : texttagtable obj -> string -> (texttag obj) option 
    = "ml_gtk_text_tag_table_add"
  external get_size : texttagtable obj -> int = "ml_gtk_text_tag_table_get_size"
  module Signals = struct
  open GtkSignal

  let marshal_texttag f _ = function 
    |`OBJECT(Some p)::_ ->
       f (Obj.magic p:texttag)
    | _ -> invalid_arg "GtkText.Buffer.Signals.marshal_texttag"

  let marshal_tag_changed f _ = function 
    | `OBJECT(Some p)::`BOOL b::_ ->
       f (Obj.magic p:texttag) b
    | _ -> invalid_arg "GtkText.Buffer.Signals.marshal_tag_changed"

  let tag_added = 
      {
	name = "tag-added";
	classe = `texttagtable;
	marshaller = marshal_texttag
      }
  let tag_changed = 
      {
	name = "tag-changed";
	classe = `texttagtable;
	marshaller = marshal_tag_changed
      }
  let tag_removed = 
      {
	name = "tag-removed";
	classe = `texttagtable;
	marshaller = marshal_texttag
      }
  end
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
    = "ml_gtk_text_buffer_delete"
  external delete_interactive : textbuffer obj -> textiter -> textiter 
    -> bool -> bool = "ml_gtk_text_buffer_delete_interactive"
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
  external get_mark : textbuffer obj -> string -> textmark obj option 
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

  let marshal_apply_tag f _ = function 
    |`OBJECT(Some p)::`POINTER(Some ti1)::`POINTER(Some ti2)::_ ->
       f (Obj.magic p:texttag) ~start:(Obj.magic ti1:textiter) 
	~stop:(Obj.magic ti2:textiter)
    | _ -> invalid_arg "GtkText.Buffer.Signals.marshal_apply_tag"

  let marshal_delete_range f _ = function 
    | `POINTER(Some ti1)::`POINTER(Some ti2)::_ ->
       f ~start:(Obj.magic ti1:textiter) 
	~stop:(Obj.magic ti2:textiter)
    | _ -> invalid_arg "GtkText.Buffer.Signals.marshal_delete_range"
  let marshal_insert_child_anchor f _ = function 
    | `POINTER(Some ti)::`POINTER(Some tca)::_ ->
       f (Obj.magic ti:textiter) 
	(Obj.magic tca:textchildanchor)
    | _ -> invalid_arg "GtkText.Buffer.Signals.marshal_insert_child_anchor"


  let marshal_insert_pixbuf f _ = function 
    | `POINTER(Some ti)::`POINTER(Some pb)::_ ->
       f (Obj.magic ti:textiter) (Obj.magic pb:GdkPixbuf.pixbuf)
    | _ -> invalid_arg "GtkText.Buffer.Signals.marshal_insert_pixbuf"

  let marshal_insert_text f _ = function 
    | `POINTER(Some ti)::`STRING(Some s)::`INT i::_  ->
       f (Obj.magic ti:textiter) s i
    | _ -> invalid_arg "GtkText.Buffer.Signals.marshal_insert_text"

  let marshal_textmark f _ = function 
    | `OBJECT(Some tm)::_ -> 
	f (Obj.magic tm:textmark)
    | _ -> invalid_arg "GtkText.Buffer.Signals.marshal_textmark"

  let marshal_mark_set f _ = function 
    | `POINTER(Some ti)::`OBJECT(Some tm)::_ -> 
	f (Obj.magic ti:textiter) (Obj.magic tm:textmark) 
    | _ -> invalid_arg "GtkText.Buffer.Signals.marshal_mark_set"
  
  let marshal_remove_tag f _ = function 
    |`OBJECT(Some p)::`POINTER(Some ti1)::`POINTER(Some ti2)::_ ->
       f (Obj.magic p:texttag) 
	~start:(Obj.magic ti1:textiter) 
	~stop:(Obj.magic ti2:textiter)
    | _ -> invalid_arg "GtkText.Buffer.Signals.marshal_remove_tag"

  let apply_tag = 
      {
	name = "apply_tag";
	classe = `textbuffer;
	marshaller = marshal_apply_tag
      }
    let begin_user_action = 
      { name = "begin_user_action"; 
	classe = `textbuffer;
	marshaller = marshal_unit }
    let changed = 
      { name = "changed"; 
	classe = `textbuffer;
	marshaller = marshal_unit }
    let delete_range =
      { name = "delete-range";
	classe = `textbuffer;
	marshaller = marshal_delete_range }
    let end_user_action = 
      { name = "end_user_action"; 
	classe = `textbuffer;
	marshaller = marshal_unit }
    let insert_child_anchor =
      { name = "insert-child-anchor";
	classe = `textbuffer;
	marshaller = marshal_insert_child_anchor}
    let insert_pixbuf =
      {name = "insert-pixbuf";
       classe = `textbuffer;
       marshaller = marshal_insert_pixbuf
      }
    let insert_text =
      {name = "insert-text";
       classe = `textbuffer;
       marshaller = marshal_insert_text
      }
    let mark_deleted =
      {name = "mark-deleted";
       classe = `textbuffer;
       marshaller = marshal_textmark
      }
    let mark_set = 
      {name = "mark-set";
       classe = `textbuffer;
       marshaller = marshal_mark_set
      }
    let modified_changed = 
      { name = "modified-changed"; 
	classe = `textbuffer;
	marshaller = marshal_unit }
    let remove_tag = 
      { name = "remove-tag"; 
	classe = `textbuffer;
	marshaller = marshal_remove_tag }
end    
end

module Child_Anchor = struct
  let cast w : textchildanchor obj = Object.try_cast w "GtkTextChildAnchor"
  external create : unit -> textchildanchor obj =
	"ml_gtk_text_child_anchor_new"
  external get_widgets : textchildanchor obj -> widget list =
	"ml_gtk_text_child_anchor_get_widgets"
  external get_deleted : textchildanchor obj -> bool =
	"ml_gtk_text_child_anchor_get_deleted"
end

module View = struct
  let cast w : textview obj = Object.try_cast w "GtkTextView"
  external create : unit -> textview obj = "ml_gtk_text_view_new"
  external create_with_buffer : textbuffer obj -> textview obj = "ml_gtk_text_view_new_with_buffer"
  external set_buffer : textview obj -> textbuffer obj -> unit = "ml_gtk_text_view_set_buffer"
  external get_buffer : textview obj -> textbuffer obj = "ml_gtk_text_view_get_buffer"
  external scroll_to_mark : textview obj -> textmark obj -> float -> bool -> float -> float -> unit = 
	    "ml_gtk_text_view_scroll_to_mark_bc" "ml_gtk_text_view_scroll_to_mark"
  external scroll_to_iter : textview obj -> textiter -> float -> bool -> float -> float -> bool = 
	    "ml_gtk_text_view_scroll_to_iter_bc" "ml_gtk_text_view_scroll_to_iter"
  external scroll_mark_onscreen : textview obj -> textmark obj -> unit = 
	   "ml_gtk_text_view_scroll_mark_onscreen"
  external move_mark_onscreen : textview obj -> textmark obj -> bool = 
	   "ml_gtk_text_view_move_mark_onscreen"
  external place_cursor_onscreen : textview obj -> bool = 
	   "ml_gtk_text_view_place_cursor_onscreen"
  external get_visible_rect : textview obj -> Gdk.Rectangle.t = 
	   "ml_gtk_text_view_get_visible_rect"
  external get_iter_location : textview obj -> textiter -> Gdk.Rectangle.t = 
	   "ml_gtk_text_view_get_iter_location"
  external get_line_at_y : textview obj -> int -> textiter*int = 
	   "ml_gtk_text_view_get_line_at_y"
  external get_line_yrange : textview obj -> textiter -> int*int = 
	   "ml_gtk_text_view_get_line_yrange"
  external get_iter_at_location : textview obj -> int -> int -> textiter = 
	   "ml_gtk_text_view_get_iter_at_location"
  external buffer_to_window_coords : textview obj -> Gtk.Tags.text_window_type -> int -> int -> int*int =
	   "ml_gtk_text_view_buffer_to_window_coords"
  external window_to_buffer_coords : textview obj -> Gtk.Tags.text_window_type -> int -> int -> int*int =
	   "ml_gtk_text_view_window_to_buffer_coords"
  external get_window : textview obj -> Gtk.Tags.text_window_type -> Gdk.window option =
	   "ml_gtk_text_view_get_window"
  external get_window_type : textview obj -> Gdk.window -> Gtk.Tags.text_window_type =
	   "ml_gtk_text_view_get_window_type"
  external set_border_window_size : textview obj -> [`LEFT | `RIGHT | `TOP | `BOTTOM ] -> int -> unit =
	   "ml_gtk_text_view_set_border_window_size"
  external get_border_window_size : textview obj ->  [`LEFT | `RIGHT | `TOP | `BOTTOM ] -> int =
	   "ml_gtk_text_view_get_border_window_size"
  external forward_display_line : textview obj -> textiter -> bool =
	   "ml_gtk_text_view_forward_display_line"
  external backward_display_line : textview obj -> textiter -> bool =
	   "ml_gtk_text_view_backward_display_line"
  external forward_display_line_end : textview obj -> textiter -> bool =
	   "ml_gtk_text_view_forward_display_line_end"
  external backward_display_line_start : textview obj -> textiter -> bool =
	   "ml_gtk_text_view_backward_display_line_start"
  external starts_display_line : textview obj -> textiter -> bool =
	   "ml_gtk_text_view_starts_display_line"
  external move_visually : textview obj -> textiter -> int -> bool =
	   "ml_gtk_text_view_move_visually"
  external add_child_at_anchor : 
    textview obj -> widget obj -> textchildanchor obj -> unit =
	   "ml_gtk_text_view_add_child_at_anchor"
  external add_child_in_window : 
    textview obj -> widget obj -> text_window_type -> int -> int -> unit =
	   "ml_gtk_text_view_add_child_in_window"
  external move_child : 
    textview obj -> widget obj -> int -> int -> unit =
	   "ml_gtk_text_view_move_child"
  external set_wrap_mode : textview obj -> wrap_mode -> unit =
	   "ml_gtk_text_view_set_wrap_mode"
  external get_wrap_mode : textview obj -> wrap_mode =
	   "ml_gtk_text_view_get_wrap_mode"
  external set_editable : textview obj -> bool -> unit =
	   "ml_gtk_text_view_set_editable"
  external get_editable : textview obj -> bool =
	   "ml_gtk_text_view_get_editable"
  external set_cursor_visible : textview obj -> bool -> unit =
	   "ml_gtk_text_view_set_cursor_visible"
  external get_cursor_visible : textview obj -> bool =
	   "ml_gtk_text_view_get_cursor_visible"

  external set_pixels_above_lines : textview obj -> int -> unit =
	   "ml_gtk_text_view_set_pixels_above_lines"
  external get_pixels_above_lines : textview obj -> int  =
	   "ml_gtk_text_view_get_pixels_above_lines"


  external set_pixels_below_lines : textview obj -> int -> unit =
	   "ml_gtk_text_view_set_pixels_below_lines"
  external get_pixels_below_lines : textview obj -> int  =
	   "ml_gtk_text_view_get_pixels_below_lines"


  external set_pixels_inside_wrap : textview obj -> int -> unit =
	   "ml_gtk_text_view_set_pixels_inside_wrap"
  external get_pixels_inside_wrap : textview obj -> int  =
	   "ml_gtk_text_view_get_pixels_inside_wrap"

  external set_justification : textview obj -> justification -> unit =
	   "ml_gtk_text_view_set_justification"
  external get_justification : textview obj -> justification =
	   "ml_gtk_text_view_get_justification"

  external set_left_margin : textview obj -> int -> unit =
	   "ml_gtk_text_view_set_left_margin"
  external get_left_margin : textview obj -> int =
	   "ml_gtk_text_view_get_left_margin"
  external set_right_margin : textview obj -> int -> unit =
	   "ml_gtk_text_view_set_right_margin"
  external get_right_margin : textview obj -> int =
	   "ml_gtk_text_view_get_right_margin"
  external set_indent : textview obj -> int -> unit =
	   "ml_gtk_text_view_set_indent"
  external get_indent : textview obj -> int =
	   "ml_gtk_text_view_get_indent"
  module Signals = struct
    open GtkSignal

    let marshal_delete_from_cursor f _ = function 
      |`POINTER(Some p)::`INT(i)::_ ->
	 f (Obj.magic p:delete_type) i
      | _ -> invalid_arg "GtkText.View.Signals.marshal_delete_from_cursor"
    let marshal_move_cursor f _ = function 
      |`POINTER(Some p)::(`INT i)::(`BOOL b)::_ ->
	 f (Obj.magic p:movement_step) i b
      | _ -> invalid_arg "GtkText.View.Signals.marshal_move_cursor"
    let marshal_move_focus f _ = function 
      |`POINTER(Some p)::_ ->
	 f (Obj.magic p:direction_type) 
      | _ -> invalid_arg "GtkText.View.Signals.marshal_move_focus"
    let marshal_page_horizontally f _ = function 
      | (`INT i)::(`BOOL b)::_ ->
	 f i b
      | _ -> invalid_arg "GtkText.View.Signals.marshal_page_horizontally"
    let marshal_populate_popup f _ = function 
      |`OBJECT(Some p)::_ ->
	 f (Obj.magic p: menu obj) 
      | _ -> invalid_arg "GtkText.View.Signals.marshal_populate_popup"
    
    let marshal_set_scroll_adjustments f _ = function 
      |`OBJECT(Some p1)::`OBJECT(Some p2)::_ ->
	 f (Obj.magic p1: adjustment) (Obj.magic p2: adjustment) 
      | _ -> invalid_arg "GtkText.View.Signals.marshal_set_scroll_adjustments"


    let copy_clipboard = 
      {
	name = "copy-clipboard";
	classe = `textview;
	marshaller = marshal_unit
      }
    let cut_clipboard = 
      {
	name = "cut-clipboard";
	classe = `textview;
	marshaller = marshal_unit
      }
    let delete_from_cursor = 
      {
	name = "delete-from-cursor";
	classe = `textview;
	marshaller = marshal_delete_from_cursor
      }
    let insert_at_cursor = 
      {
	name = "insert-at-cursor";
	classe = `textview;
	marshaller = marshal_string
      }
    let move_cursor = 
      {
	name = "move-cursor";
	classe = `textview;
	marshaller = marshal_move_cursor
      }
    let move_focus = 
      {
	name = "move-focus";
	classe = `textview;
	marshaller = marshal_move_focus
      }
    let page_horizontally = 
      {
	name = "page-horizontally";
	classe = `textview;
	marshaller = marshal_page_horizontally
      }
    let paste_clipboard = 
      {
	name = "paste-clipboard";
	classe = `textview;
	marshaller = marshal_unit
      }
    let populate_popup = 
      {
	name = "populate-popup";
	classe = `textview;
	marshaller = marshal_populate_popup
      }
    let set_anchor = 
      {
	name = "set-anchor";
	classe = `textview;
	marshaller = marshal_unit
      }
    let set_scroll_adjustments = 
      {
	name = "set-scroll-adjustments";
	classe = `textview;
	marshaller = marshal_set_scroll_adjustments
      }
    let toggle_overwrite = 
      {
	name = "toggle-overwrite";
	classe = `textview;
	marshaller = marshal_unit
      }
  end
end

module Iter = struct
  external copy : textiter -> textiter = "ml_gtk_text_iter_copy"
  external get_buffer : textiter -> textbuffer obj = "ml_gtk_text_iter_get_buffer"
  external get_offset : textiter -> int = "ml_gtk_text_iter_get_offset"
  external get_line : textiter -> int = "ml_gtk_text_iter_get_line"
  external get_line_offset : textiter -> int = "ml_gtk_text_iter_get_line_offset"
  external get_line_index : textiter -> int = "ml_gtk_text_iter_get_line_index"
  external get_visible_line_index : textiter -> int = "ml_gtk_text_iter_get_visible_line_index"
  external get_visible_line_offset : textiter -> int = "ml_gtk_text_iter_get_visible_line_offset"
  external get_char : textiter -> char = "ml_gtk_text_iter_get_char"
  external get_slice : textiter -> textiter -> string = "ml_gtk_text_iter_get_slice"
  external get_text : textiter -> textiter -> string = "ml_gtk_text_iter_get_text"
  external get_visible_slice : textiter -> textiter -> string = 
	   "ml_gtk_text_iter_get_visible_slice"
  external get_visible_text : textiter -> textiter -> string = "ml_gtk_text_iter_get_visible_text"
  external get_pixbuf : textiter -> GdkPixbuf.pixbuf = "ml_gtk_text_iter_get_pixbuf"
  external get_marks : textiter -> textmark obj list = "ml_gtk_text_iter_get_marks"
  external get_toggled_tags : textiter -> bool -> texttag obj list = "ml_gtk_text_iter_get_marks"
  external get_child_anchor : textiter -> textchildanchor option ="ml_gtk_text_iter_get_child_anchor"
  external begins_tag : textiter -> texttag obj option -> bool = "ml_gtk_text_iter_begins_tag"
  external ends_tag : textiter -> texttag obj option -> bool = "ml_gtk_text_iter_ends_tag"
  external toggles_tag : textiter -> texttag obj option -> bool = "ml_gtk_text_iter_toggles_tag"
  external has_tag : textiter -> texttag obj -> bool = "ml_gtk_text_iter_has_tag"
  external get_tags : textiter -> texttag obj list = "ml_gtk_text_iter_get_tags"
  external editable : textiter -> bool -> bool = "ml_gtk_text_iter_editable"
  external can_insert : textiter -> bool -> bool = "ml_gtk_text_iter_can_insert"
  external starts_word : textiter -> bool = "ml_gtk_text_iter_starts_word"
  external ends_word : textiter -> bool = "ml_gtk_text_iter_ends_word"
  external inside_word : textiter -> bool = "ml_gtk_text_iter_inside_word"
  external starts_line : textiter -> bool = "ml_gtk_text_iter_starts_line"
  external ends_line : textiter -> bool = "ml_gtk_text_iter_ends_line"
  external starts_sentence : textiter -> bool = "ml_gtk_text_iter_starts_sentence"
  external ends_sentence : textiter -> bool = "ml_gtk_text_iter_ends_sentence"
  external inside_sentence : textiter -> bool = "ml_gtk_text_iter_inside_sentence"
  external is_cursor_position : textiter -> bool = "ml_gtk_text_iter_is_cursor_position"
  external get_chars_in_line : textiter -> int = "ml_gtk_text_iter_get_chars_in_line"
  external get_bytes_in_line : textiter -> int = "ml_gtk_text_iter_get_bytes_in_line"
  external is_end : textiter -> bool = "ml_gtk_text_iter_is_end"
  external is_start : textiter -> bool = "ml_gtk_text_iter_is_start"
  external forward_char : textiter -> bool = "ml_gtk_text_iter_forward_char"
  external backward_char : textiter -> bool = "ml_gtk_text_iter_backward_char"
  external forward_chars : textiter -> int -> bool = "ml_gtk_text_iter_forward_chars"
  external backward_chars : textiter -> int -> bool = "ml_gtk_text_iter_backward_chars"
  external forward_line : textiter -> bool = "ml_gtk_text_iter_forward_line"
  external backward_line : textiter -> bool = "ml_gtk_text_iter_backward_line"
  external forward_lines : textiter -> int -> bool = "ml_gtk_text_iter_forward_lines"
  external backward_lines : textiter -> int -> bool = "ml_gtk_text_iter_backward_lines"
  external forward_word_end : textiter -> bool = "ml_gtk_text_iter_forward_word_end"
  external forward_word_ends : textiter -> int -> bool = "ml_gtk_text_iter_forward_word_ends"
  external backward_word_start : textiter -> bool = "ml_gtk_text_iter_backward_word_start"
  external backward_word_starts : textiter -> int -> bool = "ml_gtk_text_iter_backward_word_starts"
  external forward_cursor_position : textiter -> bool = "ml_gtk_text_iter_forward_cursor_position"
  external backward_cursor_position : textiter -> bool = "ml_gtk_text_iter_backward_cursor_position"
  external forward_cursor_positions : textiter -> int -> bool = "ml_gtk_text_iter_forward_cursor_positions"
  external backward_cursor_positions : textiter -> int -> bool = "ml_gtk_text_iter_backward_cursor_positions"
  external forward_sentence_end : textiter -> bool = "ml_gtk_text_iter_forward_sentence_end"
  external backward_sentence_start : textiter -> bool = "ml_gtk_text_iter_backward_sentence_start"
  external forward_sentence_ends : textiter -> int -> bool = "ml_gtk_text_iter_forward_sentence_ends"
  external backward_sentence_starts : textiter -> int -> bool = "ml_gtk_text_iter_backward_sentence_starts"
  external set_offset : textiter -> int -> unit = "ml_gtk_text_iter_set_offset"
  external set_line : textiter -> int -> unit = "ml_gtk_text_iter_set_line"
  external set_line_offset : textiter -> int -> unit = "ml_gtk_text_iter_set_line_offset"
  external set_line_index : textiter -> int -> unit = "ml_gtk_text_iter_set_line_index"
  external set_visible_line_index : textiter -> int -> unit = "ml_gtk_text_iter_set_visible_line_index"
  external set_visible_line_offset : textiter -> int -> unit = "ml_gtk_text_iter_set_visible_line_offset"
  external forward_to_end : textiter -> unit = "ml_gtk_text_iter_forward_to_end"
  external forward_to_line_end : textiter -> bool = "ml_gtk_text_iter_forward_to_line_end"
  external forward_to_tag_toggle : textiter -> texttag obj -> bool = "ml_gtk_text_iter_forward_to_tag_toggle"
  external backward_to_tag_toggle : textiter -> texttag obj -> bool = "ml_gtk_text_iter_backward_to_tag_toggle"
  external equal : textiter -> textiter -> bool = "ml_gtk_text_iter_equal"
  external compare : textiter -> textiter -> int = "ml_gtk_text_iter_compare"
  external in_range : textiter -> textiter -> textiter -> int = "ml_gtk_text_iter_in_range"
  external order : textiter -> textiter -> unit = "ml_gtk_text_iter_order"
end

(* $Id$ *)

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


let textiter_of_pointer = ref (fun _ -> failwith "textiter_of_pointer")

module Mark = struct
  let cast w : textmark = Object.try_cast w "GtkTextMark"
  exception No_such_mark of string
  external set_visible : textmark -> bool -> unit 
    = "ml_gtk_text_mark_set_visible"
  external get_visible : textmark -> bool = "ml_gtk_text_mark_get_visible"
  external get_deleted : textmark -> bool = "ml_gtk_text_mark_get_deleted"
  external get_name : textmark -> string option = "ml_gtk_text_mark_get_name"
  external get_buffer : textmark -> textbuffer option
    = "ml_gtk_text_mark_get_buffer"
  external get_left_gravity : textmark -> bool 
    = "ml_gtk_text_mark_get_left_gravity"
end

module Tag = struct
  let cast w : texttag = Object.try_cast w "GtkTextTag"
  external create : string -> texttag = "ml_gtk_text_tag_new"
  external get_priority : texttag -> int = "ml_gtk_text_tag_get_priority"
  external set_priority : texttag -> int -> unit 
    = "ml_gtk_text_tag_set_priority"
  external event : texttag -> 'a obj ->  'b Gdk.event -> textiter -> bool
    = "ml_gtk_text_tag_event"
  type property = 
      [ `NAME of string
      | `BACKGROUND of string
      | `FOREGROUND of string 
      | `BACKGROUND_GDK of Gdk.Color.t
      | `FOREGROUND_GDK of  Gdk.Color.t
      | `BACKGROUND_STIPPLE of Gdk.bitmap
      | `FOREGROUND_STIPPLE of Gdk.bitmap
      | `FONT of string
      | `FONT_DESC of Pango.font_description
      | `FAMILY of string
      | `STYLE of Pango.Tags.style 
      | `VARIANT of Pango.Tags.variant
      | `WEIGHT of Pango.Tags.weight
      | `STRETCH of Pango.Tags.stretch
      | `SIZE of int
      | `SIZE_POINTS of float
      | `SCALE of Pango.Tags.scale
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
      | `UNDERLINE of Pango.Tags.underline
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
    | `STYLE _ -> "style"
    | `VARIANT _ -> "variant" 
    | `WEIGHT _ -> "weight"
    | `STRETCH _ -> "stretch"
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
    | `UNDERLINE _ -> "underline"
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

  external wrap_mode : Gtk.Tags.wrap_mode -> int = "ml_Wrap_mode_val"

  let set_property o (p:property) =
    let data = match p with 
    | `NAME s | `BACKGROUND s | `FOREGROUND s | `FONT s | `FAMILY s 
    | `LANGUAGE s -> 
	`STRING (Some s)

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
	`BOOL b

    | `RISE b | `RIGHT_MARGIN b | `INDENT b | `LEFT_MARGIN b 
    | `PIXELS_INSIDE_WRAP b 
    | `PIXELS_BELOW_LINES b | `PIXELS_ABOVE_LINES b 
    | `SIZE b ->
	`INT b

    | `WEIGHT b -> `INT (Pango.Tags.weight_to_int b)

    | `SIZE_POINTS b -> `FLOAT b

    | `SCALE b  ->  `FLOAT (Pango.Tags.scale_to_float b) 

    | `FOREGROUND_STIPPLE b | `BACKGROUND_STIPPLE b -> 
        `OBJECT (Some b)

    | `FOREGROUND_GDK b | `BACKGROUND_GDK b  ->
 	`POINTER (Some (Obj.magic (b : Gdk.Color.t)))

    | `WRAP_MODE b -> `INT (wrap_mode b)

    | `STYLE b  -> `INT (Pango.Tags.style_to_int b)

    | `UNDERLINE u -> `INT (Pango.Tags.underline_to_int u)

    | `STRETCH s ->  `INT (Pango.Tags.stretch_to_int s)
    
    | `VARIANT s ->  `INT (Pango.Tags.variant_to_int s)

    | `DIRECTION b  -> `INT (Pango.Tags.text_direction_to_int b)

    | `JUSTIFICATION b -> `INT (Pango.Tags.justification_to_int b)

    | `FONT_DESC f ->
        `POINTER (Some (Obj.magic (f : Pango.font_description)))
        (* Copy is handled by the marshalling code *)
    in
    Gobject.Property.set_dyn o (property_to_string p) data

  module Signals = struct
    open GtkSignal
    let marshal_event f _ = function
      |`OBJECT(Some p)::`POINTER(Some ev)::`POINTER(Some ti)::_ ->
	 f ~origin:p 
	  (GdkEvent.unsafe_copy ev : GdkEvent.any)
	  (!textiter_of_pointer ti)
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
  let cast w : texttagtable = Object.try_cast w "GtkTextTagTable"
  external create : unit -> texttagtable = "ml_gtk_text_tag_table_new"
  external add : texttagtable -> texttag -> unit = "ml_gtk_text_tag_table_add"
  external remove : texttagtable -> texttag -> unit = "ml_gtk_text_tag_table_remove"
  external lookup : texttagtable -> string -> texttag option 
    = "ml_gtk_text_tag_table_add"
  external get_size : texttagtable -> int = "ml_gtk_text_tag_table_get_size"
  module Signals = struct
  open GtkSignal

  let marshal_texttag f _ = function 
    |`OBJECT(Some p)::_ ->
       f (Gobject.unsafe_cast p : texttag)
    | _ -> invalid_arg "GtkText.Buffer.Signals.marshal_texttag"

  let marshal_tag_changed f _ = function 
    | `OBJECT(Some p)::`BOOL b::_ ->
       f (Gobject.unsafe_cast p : texttag) b
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
  open Gpointer
  let cast w : textbuffer = Object.try_cast w "GtkTextBuffer"
  external create : texttagtable option 
    -> textbuffer = "ml_gtk_text_buffer_new"
  external get_line_count : textbuffer -> int 
    = "ml_gtk_text_buffer_get_line_count"
  external get_char_count : textbuffer -> int 
    = "ml_gtk_text_buffer_get_char_count"
  external get_tag_table : textbuffer -> texttagtable 
    = "ml_gtk_text_buffer_get_tag_table"
  external insert : textbuffer -> textiter -> string stable -> unit
    = "ml_gtk_text_buffer_insert"
  let insert a b c = insert a b (stable_copy c)
  external insert_at_cursor : textbuffer -> string stable -> unit
    = "ml_gtk_text_buffer_insert_at_cursor"
  let insert_at_cursor a b = insert_at_cursor a (stable_copy b)
  external insert_interactive :
    textbuffer -> textiter -> string stable -> bool -> bool
    = "ml_gtk_text_buffer_insert_interactive"
  let insert_interactive a b c = insert_interactive a b (stable_copy c)
  external insert_interactive_at_cursor :
    textbuffer -> string stable -> bool -> bool
    = "ml_gtk_text_buffer_insert_interactive_at_cursor"
  let insert_interactive_at_cursor a b =
    insert_interactive_at_cursor a (stable_copy b)
  external insert_range : textbuffer -> textiter -> textiter
    -> textiter -> unit = "ml_gtk_text_buffer_insert_range"
  external insert_range_interactive : textbuffer -> textiter -> textiter
    -> textiter -> bool -> bool = "ml_gtk_text_buffer_insert_range_interactive"
  external delete : textbuffer -> textiter -> textiter -> unit
    = "ml_gtk_text_buffer_delete"
  external delete_interactive : textbuffer -> textiter -> textiter 
    -> bool -> bool = "ml_gtk_text_buffer_delete_interactive"
  external set_text : textbuffer -> string stable -> unit
    = "ml_gtk_text_buffer_set_text"
  let set_text b s = set_text b (stable_copy s)
  external get_text : textbuffer -> textiter -> textiter -> 
    bool -> string = "ml_gtk_text_buffer_get_text"
  external get_slice : textbuffer -> textiter -> textiter -> 
    bool -> string = "ml_gtk_text_buffer_get_slice"
  external insert_pixbuf : textbuffer -> textiter -> GdkPixbuf.pixbuf
    -> unit = "ml_gtk_text_buffer_insert_pixbuf"
  external create_mark : textbuffer -> string option -> textiter
    -> bool -> textmark = "ml_gtk_text_buffer_create_mark"
  external move_mark : textbuffer -> textmark -> textiter
   -> unit  = "ml_gtk_text_buffer_move_mark"
  external move_mark_by_name : textbuffer -> string -> textiter
   -> unit  = "ml_gtk_text_buffer_move_mark_by_name"
  external delete_mark : textbuffer -> textmark 
    -> unit  = "ml_gtk_text_buffer_delete_mark"
  external delete_mark_by_name : textbuffer -> string
   -> unit  = "ml_gtk_text_buffer_delete_mark_by_name"
  external get_mark : textbuffer -> string -> textmark option 
    = "ml_gtk_text_buffer_get_mark"
  external get_insert : textbuffer -> textmark 
    = "ml_gtk_text_buffer_get_insert"
  external get_selection_bound : textbuffer -> textmark 
    = "ml_gtk_text_buffer_get_selection_bound"
  external place_cursor : textbuffer -> textiter -> unit 
    = "ml_gtk_text_buffer_place_cursor"
  external apply_tag : textbuffer -> texttag -> textiter -> textiter 
    -> unit = "ml_gtk_text_buffer_apply_tag"
  external remove_tag : textbuffer -> texttag -> textiter -> textiter 
    -> unit = "ml_gtk_text_buffer_remove_tag"
  external apply_tag_by_name : textbuffer -> string -> textiter -> textiter 
    -> unit = "ml_gtk_text_buffer_apply_tag_by_name"
  external remove_tag_by_name : textbuffer -> string -> textiter -> textiter 
    -> unit = "ml_gtk_text_buffer_remove_tag_by_name"
  external remove_all_tags : textbuffer -> textiter -> textiter 
    -> unit = "ml_gtk_text_buffer_remove_all_tags"
  external create_tag_0 : textbuffer -> string option 
    -> texttag = "ml_gtk_text_buffer_create_tag_0"
  external create_tag_2 : textbuffer -> string option 
    -> string -> string -> texttag = "ml_gtk_text_buffer_create_tag_2"
  external get_iter_at_line_offset : textbuffer -> int -> int -> textiter
    = "ml_gtk_text_buffer_get_iter_at_line_offset"
  external get_iter_at_offset : textbuffer -> int -> textiter
    = "ml_gtk_text_buffer_get_iter_at_offset"
  external get_iter_at_line : textbuffer ->  int -> textiter
    = "ml_gtk_text_buffer_get_iter_at_line"
  external get_iter_at_line_index : textbuffer ->  int -> int -> textiter
    = "ml_gtk_text_buffer_get_iter_at_line_index"
  external get_iter_at_mark : textbuffer -> textmark -> textiter
    = "ml_gtk_text_buffer_get_iter_at_mark"
  external get_start_iter : textbuffer 
    -> textiter = "ml_gtk_text_buffer_get_start_iter"
  external get_end_iter : textbuffer 
    -> textiter = "ml_gtk_text_buffer_get_end_iter"
  external get_bounds : textbuffer -> textiter * textiter
    = "ml_gtk_text_buffer_get_bounds"
  external get_modified : textbuffer -> bool
    = "ml_gtk_text_buffer_get_modified"
  external set_modified : textbuffer -> bool -> unit
    = "ml_gtk_text_buffer_set_modified"
  external delete_selection : textbuffer ->  bool -> bool -> bool
    = "ml_gtk_text_buffer_delete_selection"
  external get_selection_bounds : textbuffer ->  textiter * textiter
    = "ml_gtk_text_buffer_get_selection_bounds"
  external begin_user_action : textbuffer -> unit
    = "ml_gtk_text_buffer_begin_user_action"
  external end_user_action : textbuffer -> unit
    = "ml_gtk_text_buffer_end_user_action"
  external create_child_anchor : textbuffer 
    -> textiter -> textchildanchor
    = "ml_gtk_text_buffer_create_child_anchor"
  external insert_child_anchor : 
    textbuffer -> textiter -> textchildanchor -> unit
    = "ml_gtk_text_buffer_insert_child_anchor"
  external paste_clipboard :
    textbuffer -> clipboard -> textiter option -> bool -> unit
    = "ml_gtk_text_buffer_paste_clipboard"
  external copy_clipboard :
    textbuffer -> clipboard -> unit
    = "ml_gtk_text_buffer_copy_clipboard"
  external cut_clipboard :
    textbuffer -> clipboard -> bool -> unit
    = "ml_gtk_text_buffer_cut_clipboard"
  external add_selection_clipboard :
    textbuffer -> clipboard -> unit
    = "ml_gtk_text_buffer_add_selection_clipboard"
  external remove_selection_clipboard :
    textbuffer -> clipboard -> unit
    = "ml_gtk_text_buffer_remove_selection_clipboard"
  module Signals = struct
  open GtkSignal

  let marshal_apply_tag f _ = function 
    |`OBJECT(Some p)::`POINTER(Some ti1)::`POINTER(Some ti2)::_ ->
       f (Gobject.unsafe_cast p : texttag)
        ~start:(!textiter_of_pointer ti1) 
	~stop:(!textiter_of_pointer ti2)
    | _ -> invalid_arg "GtkText.Buffer.Signals.marshal_apply_tag"

  let marshal_delete_range f _ = function 
    | `POINTER(Some ti1)::`POINTER(Some ti2)::_ ->
       f ~start:(!textiter_of_pointer ti1) 
	~stop:(!textiter_of_pointer ti2)
    | _ -> invalid_arg "GtkText.Buffer.Signals.marshal_delete_range"
  let marshal_insert_child_anchor f _ = function 
    | `POINTER(Some ti)::`OBJECT(Some tca)::_ ->
       f (!textiter_of_pointer ti) 
	(Gobject.unsafe_cast tca : textchildanchor)
    | _ -> invalid_arg "GtkText.Buffer.Signals.marshal_insert_child_anchor"


  let marshal_insert_pixbuf f _ = function 
    | `POINTER(Some ti)::`OBJECT(Some pb)::_ ->
       f (!textiter_of_pointer ti) (Gobject.unsafe_cast pb : GdkPixbuf.pixbuf)
    | _ -> invalid_arg "GtkText.Buffer.Signals.marshal_insert_pixbuf"

  let marshal_insert_text f argv = function 
    | `POINTER(Some ti)::`STRING(Some s)::`INT len::_  ->
(*        let s' =
          if len = -1 then (prerr_endline "HERE -1";s) else
            (prerr_endline "HERE NOW";
	     Gpointer.peek_string ~pos:0 ~len
               (Gobject.Closure.get_pointer argv ~pos:2))
        in
*)
	f (!textiter_of_pointer ti) s
    | _ -> invalid_arg "GtkText.Buffer.Signals.marshal_insert_text"
	
  let marshal_textmark f _ = function 
    | `OBJECT(Some tm)::_ -> 
	f (Gobject.unsafe_cast tm : textmark)
    | _ -> invalid_arg "GtkText.Buffer.Signals.marshal_textmark"

  let marshal_mark_set f _ = function 
    | `POINTER(Some ti)::`OBJECT(Some tm)::_ -> 
	f (!textiter_of_pointer ti) (Gobject.unsafe_cast tm : textmark) 
    | _ -> invalid_arg "GtkText.Buffer.Signals.marshal_mark_set"
  
  let marshal_remove_tag f _ = function 
    |`OBJECT(Some p)::`POINTER(Some ti1)::`POINTER(Some ti2)::_ ->
       f (Gobject.unsafe_cast p : texttag) 
	~start:(!textiter_of_pointer ti1) 
	~stop:(!textiter_of_pointer ti2)
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
  let cast w : textchildanchor = Object.try_cast w "GtkTextChildAnchor"
  external create : unit -> textchildanchor =
	"ml_gtk_text_child_anchor_new"
  external get_widgets : textchildanchor -> widget list =
	"ml_gtk_text_child_anchor_get_widgets"
  external get_deleted : textchildanchor -> bool =
	"ml_gtk_text_child_anchor_get_deleted"
end

module View = struct
  let cast w : textview obj = Object.try_cast w "GtkTextView"
  external create : unit -> textview obj = "ml_gtk_text_view_new"
  external create_with_buffer : textbuffer -> textview obj = "ml_gtk_text_view_new_with_buffer"
  external set_buffer : [>`textview] obj -> textbuffer -> unit = "ml_gtk_text_view_set_buffer"
  external get_buffer : [>`textview] obj -> textbuffer = "ml_gtk_text_view_get_buffer"
  external scroll_to_mark : [>`textview] obj -> textmark -> float -> bool -> float -> float -> unit = 
	    "ml_gtk_text_view_scroll_to_mark_bc" "ml_gtk_text_view_scroll_to_mark"
  external scroll_to_iter : [>`textview] obj -> textiter -> float -> bool -> float -> float -> bool = 
	    "ml_gtk_text_view_scroll_to_iter_bc" "ml_gtk_text_view_scroll_to_iter"
  external scroll_mark_onscreen : [>`textview] obj -> textmark -> unit = 
	   "ml_gtk_text_view_scroll_mark_onscreen"
  external move_mark_onscreen : [>`textview] obj -> textmark -> bool = 
	   "ml_gtk_text_view_move_mark_onscreen"
  external place_cursor_onscreen : [>`textview] obj -> bool = 
	   "ml_gtk_text_view_place_cursor_onscreen"
  external get_visible_rect : [>`textview] obj -> Gdk.Rectangle.t = 
	   "ml_gtk_text_view_get_visible_rect"
  external get_iter_location : [>`textview] obj -> textiter -> Gdk.Rectangle.t = 
	   "ml_gtk_text_view_get_iter_location"
  external get_line_at_y : [>`textview] obj -> int -> textiter*int = 
	   "ml_gtk_text_view_get_line_at_y"
  external get_line_yrange : [>`textview] obj -> textiter -> int*int = 
	   "ml_gtk_text_view_get_line_yrange"
  external get_iter_at_location : [>`textview] obj -> int -> int -> textiter = 
	   "ml_gtk_text_view_get_iter_at_location"
  external buffer_to_window_coords : [>`textview] obj -> Gtk.Tags.text_window_type -> int -> int -> int*int =
	   "ml_gtk_text_view_buffer_to_window_coords"
  external window_to_buffer_coords : [>`textview] obj -> Gtk.Tags.text_window_type -> int -> int -> int*int =
	   "ml_gtk_text_view_window_to_buffer_coords"
  external get_window : [>`textview] obj -> Gtk.Tags.text_window_type -> Gdk.window option =
	   "ml_gtk_text_view_get_window"
  external get_window_type : [>`textview] obj -> Gdk.window -> Gtk.Tags.text_window_type =
	   "ml_gtk_text_view_get_window_type"
  external set_border_window_size : [>`textview] obj -> [`LEFT | `RIGHT | `TOP | `BOTTOM ] -> int -> unit =
	   "ml_gtk_text_view_set_border_window_size"
  external get_border_window_size : [>`textview] obj ->  [`LEFT | `RIGHT | `TOP | `BOTTOM ] -> int =
	   "ml_gtk_text_view_get_border_window_size"
  external forward_display_line : [>`textview] obj -> textiter -> bool =
	   "ml_gtk_text_view_forward_display_line"
  external backward_display_line : [>`textview] obj -> textiter -> bool =
	   "ml_gtk_text_view_backward_display_line"
  external forward_display_line_end : [>`textview] obj -> textiter -> bool =
	   "ml_gtk_text_view_forward_display_line_end"
  external backward_display_line_start : [>`textview] obj -> textiter -> bool =
	   "ml_gtk_text_view_backward_display_line_start"
  external starts_display_line : [>`textview] obj -> textiter -> bool =
	   "ml_gtk_text_view_starts_display_line"
  external move_visually : [>`textview] obj -> textiter -> int -> bool =
	   "ml_gtk_text_view_move_visually"
  external add_child_at_anchor : 
    [>`textview] obj -> [>`widget] obj -> textchildanchor -> unit =
	   "ml_gtk_text_view_add_child_at_anchor"
  external add_child_in_window : 
    [>`textview] obj -> [>`widget] obj -> text_window_type -> int -> int -> unit =
	   "ml_gtk_text_view_add_child_in_window"
  external move_child : 
    [>`textview] obj -> [>`widget] obj -> int -> int -> unit =
	   "ml_gtk_text_view_move_child"
  external set_wrap_mode : [>`textview] obj -> wrap_mode -> unit =
	   "ml_gtk_text_view_set_wrap_mode"
  external get_wrap_mode : [>`textview] obj -> wrap_mode =
	   "ml_gtk_text_view_get_wrap_mode"
  external set_editable : [>`textview] obj -> bool -> unit =
	   "ml_gtk_text_view_set_editable"
  external get_editable : [>`textview] obj -> bool =
	   "ml_gtk_text_view_get_editable"
  external set_cursor_visible : [>`textview] obj -> bool -> unit =
	   "ml_gtk_text_view_set_cursor_visible"
  external get_cursor_visible : [>`textview] obj -> bool =
	   "ml_gtk_text_view_get_cursor_visible"

  external set_pixels_above_lines : [>`textview] obj -> int -> unit =
	   "ml_gtk_text_view_set_pixels_above_lines"
  external get_pixels_above_lines : [>`textview] obj -> int  =
	   "ml_gtk_text_view_get_pixels_above_lines"


  external set_pixels_below_lines : [>`textview] obj -> int -> unit =
	   "ml_gtk_text_view_set_pixels_below_lines"
  external get_pixels_below_lines : [>`textview] obj -> int  =
	   "ml_gtk_text_view_get_pixels_below_lines"


  external set_pixels_inside_wrap : [>`textview] obj -> int -> unit =
	   "ml_gtk_text_view_set_pixels_inside_wrap"
  external get_pixels_inside_wrap : [>`textview] obj -> int  =
	   "ml_gtk_text_view_get_pixels_inside_wrap"

  external set_justification : [>`textview] obj -> justification -> unit =
	   "ml_gtk_text_view_set_justification"
  external get_justification : [>`textview] obj -> justification =
	   "ml_gtk_text_view_get_justification"

  external set_left_margin : [>`textview] obj -> int -> unit =
	   "ml_gtk_text_view_set_left_margin"
  external get_left_margin : [>`textview] obj -> int =
	   "ml_gtk_text_view_get_left_margin"
  external set_right_margin : [>`textview] obj -> int -> unit =
	   "ml_gtk_text_view_set_right_margin"
  external get_right_margin : [>`textview] obj -> int =
	   "ml_gtk_text_view_get_right_margin"
  external set_indent : [>`textview] obj -> int -> unit =
	   "ml_gtk_text_view_set_indent"
  external get_indent : [>`textview] obj -> int =
	   "ml_gtk_text_view_get_indent"
  external val_delete_type : int -> delete_type = "ml_Val_delete_type"
  external val_movement_step : int -> movement_step = "ml_Val_movement_step"
  external val_direction_type : int -> direction_type = "ml_Val_direction_type"

  let set ?editable ?cursor_visible ?wrap_mode w =
    may editable ~f:(set_editable w);
    may cursor_visible ~f:(set_cursor_visible w);
    may wrap_mode ~f:(set_wrap_mode w)

  module Signals = struct
    open GtkSignal

    let marshal_delete_from_cursor f _ = function 
      |`INT ty ::`INT i ::_ ->
	 f (val_delete_type ty) i
      | _ -> invalid_arg "GtkText.View.Signals.marshal_delete_from_cursor"
    let marshal_move_cursor f _ = function 
      |`INT step :: `INT i :: `BOOL b :: _ ->
	 f (val_movement_step step) i b
      | _ -> invalid_arg "GtkText.View.Signals.marshal_move_cursor"
    let marshal_move_focus f _ = function 
      |`INT dir :: _ ->
	 f (val_direction_type dir)
      | _ -> invalid_arg "GtkText.View.Signals.marshal_move_focus"
    let marshal_page_horizontally f _ = function 
      | (`INT i)::(`BOOL b)::_ ->
	 f i b
      | _ -> invalid_arg "GtkText.View.Signals.marshal_page_horizontally"
    let marshal_populate_popup f _ = function 
      |`OBJECT(Some p)::_ ->
	 f (Gobject.unsafe_cast p : menu obj) 
      | _ -> invalid_arg "GtkText.View.Signals.marshal_populate_popup"
    
    let marshal_set_scroll_adjustments f _ = function 
      |`OBJECT(Some p1)::`OBJECT(Some p2)::_ ->
	  f (Gobject.unsafe_cast p1 : adjustment obj)
            (Gobject.unsafe_cast p2 : adjustment obj) 
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
  let () =
    textiter_of_pointer := (fun (p : Gpointer.boxed) -> copy (Obj.magic p))
  external get_buffer : textiter -> textbuffer = "ml_gtk_text_iter_get_buffer"
  external get_offset : textiter -> int = "ml_gtk_text_iter_get_offset"
  external get_line : textiter -> int = "ml_gtk_text_iter_get_line"
  external get_line_offset : textiter -> int = "ml_gtk_text_iter_get_line_offset"
  external get_line_index : textiter -> int = "ml_gtk_text_iter_get_line_index"
  external get_visible_line_index : textiter -> int = "ml_gtk_text_iter_get_visible_line_index"
  external get_visible_line_offset : textiter -> int = "ml_gtk_text_iter_get_visible_line_offset"
  external get_char : textiter -> Glib.unichar = "ml_gtk_text_iter_get_char"
  external get_slice : textiter -> textiter -> string = "ml_gtk_text_iter_get_slice"
  external get_text : textiter -> textiter -> string = "ml_gtk_text_iter_get_text"
  external get_visible_slice : textiter -> textiter -> string = 
	   "ml_gtk_text_iter_get_visible_slice"
  external get_visible_text : textiter -> textiter -> string = "ml_gtk_text_iter_get_visible_text"
  external get_pixbuf : textiter -> GdkPixbuf.pixbuf option = "ml_gtk_text_iter_get_pixbuf"
  external get_marks : textiter -> textmark list = "ml_gtk_text_iter_get_marks"
  external get_toggled_tags : textiter -> bool -> texttag list = "ml_gtk_text_iter_get_marks"
  external get_child_anchor : textiter -> textchildanchor option ="ml_gtk_text_iter_get_child_anchor"
  external begins_tag : textiter -> texttag option -> bool = "ml_gtk_text_iter_begins_tag"
  external ends_tag : textiter -> texttag option -> bool = "ml_gtk_text_iter_ends_tag"
  external toggles_tag : textiter -> texttag option -> bool = "ml_gtk_text_iter_toggles_tag"
  external has_tag : textiter -> texttag -> bool = "ml_gtk_text_iter_has_tag"
  external get_tags : textiter -> texttag list = "ml_gtk_text_iter_get_tags"
  external editable : textiter -> default:bool -> bool = "ml_gtk_text_iter_editable"
  external can_insert : textiter -> default:bool -> bool = "ml_gtk_text_iter_can_insert"
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
  external get_language : textiter -> Pango.language = 
   "ml_gtk_text_iter_get_language"
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
  external forward_to_tag_toggle : textiter -> texttag option -> bool = "ml_gtk_text_iter_forward_to_tag_toggle"
  external backward_to_tag_toggle : textiter -> texttag option -> bool = "ml_gtk_text_iter_backward_to_tag_toggle"
  external equal : textiter -> textiter -> bool = "ml_gtk_text_iter_equal"
  external compare : textiter -> textiter -> int = "ml_gtk_text_iter_compare"
  external in_range : textiter -> textiter -> textiter -> bool = "ml_gtk_text_iter_in_range"
  external order : textiter -> textiter -> unit = "ml_gtk_text_iter_order"

  external forward_search :
    textiter -> string -> ?flags:text_search_flag list ->
    textiter option -> (textiter * textiter) option 
    = "ml_gtk_text_iter_forward_search"
  external backward_search :
    textiter -> string -> ?flags:text_search_flag list ->
    textiter option -> (textiter * textiter) option 
    = "ml_gtk_text_iter_backward_search"
  external forward_find_char : 
    textiter -> (Glib.unichar -> bool) -> textiter option -> bool
      = "ml_gtk_text_iter_forward_find_char"
  external backward_find_char : 
    textiter -> (Glib.unichar -> bool) -> textiter option -> bool
      = "ml_gtk_text_iter_backward_find_char"
end

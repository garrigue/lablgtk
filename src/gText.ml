 (* $Id$ *)

open StdLabels
open Gaux
open Gtk
open GtkBase
open GtkText
open GObj

type mark_name = [`INSERT | `SEL_BOUND | `NAME of string]
let mark_name = function
    `INSERT -> "insert"
  | `SEL_BOUND -> "selection_bound"
  | `NAME s -> s

type mark = [mark_name | `MARK of textmark obj]

class child_anchor obj =
object
  val obj = obj
  method get_oid = Gobject.get_oid obj
  method as_childanchor = obj
  method widgets = Child_Anchor.get_widgets obj
  method deleted = Child_Anchor.get_deleted obj
end

let child_anchor () = new child_anchor (Child_Anchor.create ())


class tag_signals obj = object
  val obj = obj
  val after = false
  method after = {< after = true >}
  method event = 
    GtkSignal.connect ~sgn:Tag.Signals.event ~after obj
end

class tag obj =
object (self)
  val obj = obj
  method get_oid = Gobject.get_oid obj
  method as_tag = obj
  method connect = new tag_signals obj
  method priority () = Tag.get_priority obj
  method set_priority p = Tag.set_priority obj p
  (* [BM] my very first polymorphic method in OCaml...*)
  method event : 'a. 'a Gtk.obj -> GdkEvent.any -> Gtk.textiter -> bool = 
    Tag.event obj 
  method set_property p = 
    Tag.set_property obj p
  method set_properties l = 
    List.iter self#set_property l
end

let tag s = new tag(Tag.create s)

class iter it =
object
  val it = (it: textiter)
  method as_textiter = it
  method copy = new iter (Iter.copy it)
  method buffer = Iter.get_buffer it
  method offset = Iter.get_offset it
  method line = Iter.get_line it
  method line_offset = Iter.get_line_offset it
  method line_index = Iter.get_line_index it
  method visible_line_index = Iter.get_visible_line_index it
  method visible_line_offset = Iter.get_visible_line_offset it
  method char = Iter.get_char it
  method get_slice ~(stop:iter) = Iter.get_slice it stop#as_textiter
  method get_text ~(stop:iter) = Iter.get_text it stop#as_textiter
  method get_visible_slice ~(stop:iter) = 
    Iter.get_visible_slice it stop#as_textiter
  method get_visible_text ~(stop:iter) = 
    Iter.get_visible_text it stop#as_textiter
  method pixbuf = Iter.get_pixbuf it
  method marks = Iter.get_marks it
  method get_toggled_tags b = List.map (fun x -> new tag x) 
			      (Iter.get_toggled_tags it b)
  method child_anchor  = 
    match (Iter.get_child_anchor it)
    with 
      |None -> None
      |Some c -> Some (new child_anchor c)
  method begins_tag ?(tag:tag option) () = 
    Iter.begins_tag it (match tag with | None -> None 
			  | Some t -> Some t#as_tag)
  method ends_tag ?(tag:tag option) () = 
    Iter.ends_tag it (match tag with | None -> None 
			  | Some t -> Some t#as_tag)
					   
  method toggles_tag ?(tag:tag option) () = 
    Iter.toggles_tag it (match tag with None -> None | Some t -> Some t#as_tag)
  method has_tag (t:tag) = Iter.has_tag it t#as_tag
  method tags = List.map (fun t -> new tag t) (Iter.get_tags it)
  method editable = Iter.editable it
  method can_insert = Iter.can_insert it
  method starts_word = Iter.starts_word it
  method ends_word = Iter.ends_word it
  method inside_word = Iter.inside_word it
  method starts_line = Iter.starts_line it
  method ends_line = Iter.ends_line it
  method starts_sentence = Iter.starts_sentence it
  method ends_sentence = Iter.ends_sentence it
  method inside_sentence = Iter.inside_sentence it
  method is_cursor_position = Iter.is_cursor_position it
  method chars_in_line = Iter.get_chars_in_line it
  method bytes_in_line = Iter.get_bytes_in_line it
  method is_end = Iter.is_end it
  method is_start = Iter.is_start it
  method forward_char () = Iter.forward_char it
  method backward_char () = Iter.backward_char it
  method forward_chars = Iter.forward_chars it
  method backward_chars  = Iter.backward_chars it
  method forward_line () = Iter.forward_line it
  method backward_line () = Iter.backward_line it
  method forward_lines  = Iter.forward_lines it
  method backward_lines  = Iter.backward_lines it
  method forward_word_end () = Iter.forward_word_end it
  method forward_word_ends  = Iter.forward_word_ends it
  method backward_word_start () = Iter.backward_word_start it
  method backward_word_starts  = Iter.backward_word_starts it
  method forward_cursor_position () = Iter.forward_cursor_position it
  method backward_cursor_position () = Iter.backward_cursor_position it
  method forward_cursor_positions  = Iter.forward_cursor_positions it
  method backward_cursor_positions  = Iter.backward_cursor_positions it
  method forward_sentence_end () = Iter.forward_sentence_end it
  method backward_sentence_start () = Iter.backward_sentence_start it
  method forward_sentence_ends  = Iter.forward_sentence_ends it
  method backward_sentence_starts  = Iter.backward_sentence_starts it
  method set_offset  = Iter.set_offset it
  method set_line  = Iter.set_line it
  method set_line_offset  = Iter.set_line_offset it
  method set_line_index  = Iter.set_line_index it
  method set_visible_line_index  = Iter.set_visible_line_index it
  method set_visible_line_offset  = Iter.set_visible_line_offset it
  method forward_to_end () = Iter.forward_to_end it
  method forward_to_line_end () = Iter.forward_to_line_end it
  method forward_to_tag_toggle ?(tag:tag option) () = 
    Iter.forward_to_tag_toggle it 
      (match tag with None -> None | Some t -> Some t#as_tag) 
  method backward_to_tag_toggle ?(tag:tag option) () = 
    Iter.backward_to_tag_toggle it 
      (match tag with None -> None | Some t -> Some t#as_tag) 
  method equal (a:iter) = Iter.equal it a#as_textiter
  method compare (a:iter) = Iter.compare it a#as_textiter
  method in_range ~(start:iter) ~(stop:iter)  = 
    Iter.in_range it start#as_textiter stop#as_textiter
  method forward_search ~flag ?(limit:iter option) s =
    let r = Iter.forward_search it s flag (match limit with None -> None 
					     | Some i -> Some i#as_textiter ) 
    in
    match r with 
	Some(s,t) -> Some((new iter s),(new iter t))
      | _ -> None
  method backward_search ~flag ?(limit:iter option) s =
    let r = Iter.backward_search it s flag (match limit with None -> None 
				   | Some i -> Some i#as_textiter ) in
    match r with 
	Some(s,t) -> Some((new iter s),(new iter t))
      | _ -> None
  method forward_find_char ?(limit:iter option) f = 
    Iter.forward_find_char it f (match limit with None -> None 
				   | Some i -> Some i#as_textiter )
  method backward_find_char ?(limit:iter option) f = 
    Iter.backward_find_char it f  (match limit with None -> None 
				     | Some i -> Some i#as_textiter )
end

(* let iter i = new iter (Iter.copy i) *)
let as_textiter (it : iter) = it#as_textiter

class tagtable_signals obj = object
  val obj = obj
  val after = false
  method after = {< after = true >}
  method tag_added = 
     GtkSignal.connect ~sgn:TagTable.Signals.tag_added ~after obj
  method tag_changed = 
     GtkSignal.connect ~sgn:TagTable.Signals.tag_changed ~after obj
  method tag_removed = 
     GtkSignal.connect ~sgn:TagTable.Signals.tag_removed ~after obj
end

class tagtable obj = 
object
  val obj = obj
  method get_oid = Gobject.get_oid obj
  method as_tagtable = obj
  method connect = new tagtable_signals obj
  method add =  TagTable.add obj
  method remove =  TagTable.remove obj
  method lookup =  TagTable.lookup obj

  method size () = TagTable.get_size obj
end

let tagtable () = 
  new tagtable (TagTable.create ())

class buffer_signals obj = object
  val obj = obj
  val after = false
  method after = {< after = true >}
  method apply_tag ~callback = 
    GtkSignal.connect ~sgn:Buffer.Signals.apply_tag ~after obj
      ~callback:(fun tag ~start ~stop ->
        callback (new tag tag) ~start:(new iter start) ~stop:(new iter stop))
  method begin_user_action = 
    GtkSignal.connect ~sgn:Buffer.Signals.begin_user_action ~after obj
  method changed = 
    GtkSignal.connect ~sgn:Buffer.Signals.changed ~after obj
  method delete_range ~callback = 
    GtkSignal.connect ~sgn:Buffer.Signals.delete_range ~after obj
      ~callback:(fun ~start ~stop ->
        callback ~start:(new iter start) ~stop:(new iter stop))
  method end_user_action = 
    GtkSignal.connect ~sgn:Buffer.Signals.end_user_action ~after obj
  method insert_child_anchor ~callback = 
    GtkSignal.connect ~sgn:Buffer.Signals.insert_child_anchor ~after obj
      ~callback:(fun iter -> callback (new iter iter))
  method insert_pixbuf ~callback = 
    GtkSignal.connect ~sgn:Buffer.Signals.insert_pixbuf ~after obj
      ~callback:(fun iter -> callback (new iter iter))
  method insert_text ~callback = 
    GtkSignal.connect ~sgn:Buffer.Signals.insert_text ~after obj
      ~callback:(fun iter -> callback (new iter iter))
  method mark_deleted =
    GtkSignal.connect ~sgn:Buffer.Signals.mark_deleted ~after obj
  method mark_set ~callback = 
    GtkSignal.connect ~sgn:Buffer.Signals.mark_set ~after obj
      ~callback:(fun it -> callback (new iter it))
  method modified_changed = 
    GtkSignal.connect ~sgn:Buffer.Signals.modified_changed ~after obj
  method remove_tag ~callback = 
    GtkSignal.connect ~sgn:Buffer.Signals.remove_tag ~after obj
      ~callback:(fun tag ~start ~stop ->
        callback (new tag tag) ~start:(new iter start) ~stop:(new iter stop))
end

exception No_such_mark of string

class buffer obj = object(self)
  val obj = obj
  method get_oid = Gobject.get_oid obj
  method as_buffer = obj
  method connect = new buffer_signals obj
  method line_count = Buffer.get_line_count obj
  method char_count = Buffer.get_char_count obj
  method tag_table =  Buffer.get_tag_table obj
  method insert
    ?iter 
    ?(tag_names : string list = [])
    ?(tags : tag list = []) 
    text
    =  
    match tags,tag_names with
      | [],[] -> 
	  begin match iter with
	  | None      -> Buffer.insert_at_cursor obj text
	  | Some iter -> Buffer.insert obj (as_textiter iter) text
	  end
      | _ ->
          begin match iter with
	  | None -> 
	      let insert_iter () =
                self#get_iter_at_mark `INSERT in
	      let start_offset = (insert_iter ())#offset in
	      Buffer.insert_at_cursor obj text;
	      let start = self#get_iter_at_char start_offset in
	      List.iter tags ~f:(self#apply_tag ~start ~stop:(insert_iter ()));
	      List.iter tag_names 
		~f:(self#apply_tag_by_name ~start ~stop:(insert_iter ())) 
	  | Some iter -> 
	      let start_offset = iter#offset in
	      Buffer.insert obj (as_textiter iter) text;
	      let start = self#get_iter_at_char start_offset in
	      List.iter tags ~f:(self#apply_tag ~start ~stop:iter);
	      List.iter tag_names 
		~f:(self#apply_tag_by_name ~start ~stop:iter)
	end
  method insert_interactive ?iter ?(default_editable = true) text = 
    match iter with
    | None -> 
	Buffer.insert_interactive_at_cursor obj text default_editable
    | Some iter -> 
	Buffer.insert_interactive obj (as_textiter iter) text default_editable
  method insert_range ~iter ~start ~stop = 
    Buffer.insert_range obj
      (as_textiter iter) (as_textiter start) (as_textiter stop)
  method insert_range_interactive ~iter ~start ~stop
      ?(default_editable = true) () = 
    Buffer.insert_range_interactive obj (as_textiter iter) (as_textiter start)
      (as_textiter stop)  default_editable
  method delete ~start ~stop = Buffer.delete obj (as_textiter start) 
				 (as_textiter stop)
  method delete_interactive ~start ~stop ?(default_editable = true) () = 
    Buffer.delete_interactive obj (as_textiter start) 
      (as_textiter stop) default_editable
  method set_text text = 
    Buffer.set_text obj text
  method get_text ?start ?stop ?(slice=false) ?(include_hidden=false) () =
    let start,stop = 
      match start,stop with 
	| None,None -> Buffer.get_bounds obj
	| Some start,None -> as_textiter start, Buffer.get_start_iter obj
	| None,Some stop -> Buffer.get_end_iter obj, as_textiter stop
	| Some start,Some stop -> as_textiter start, as_textiter stop
    in
    (if slice then Buffer.get_slice else Buffer.get_text)
      obj start stop include_hidden
  method insert_pixbuf ~iter ~pixbuf = 
    Buffer.insert_pixbuf obj (as_textiter iter) pixbuf
  method create_mark ?name ?(left_gravity=true) iter = 
    Buffer.create_mark obj name (as_textiter iter) left_gravity
  method get_mark : mark -> _ = function
      `MARK mark -> mark
    | #mark_name as  mark ->
        let name = mark_name mark in
        match Buffer.get_mark obj name with 
        | None -> raise (No_such_mark name)
	| Some m -> m
  method move_mark mark ~where =
    Buffer.move_mark obj (self#get_mark mark) (as_textiter where)
  method delete_mark mark = Buffer.delete_mark obj (self#get_mark mark)
  method place_cursor ~where = 
    Buffer.place_cursor obj (as_textiter where)
  method apply_tag (tag : tag) ~start ~stop = 
    Buffer.apply_tag obj tag#as_tag (as_textiter start) (as_textiter stop)
  method remove_tag (tag : tag) ~start ~stop = 
    Buffer.remove_tag obj tag#as_tag (as_textiter start) (as_textiter stop)
  method apply_tag_by_name name ~start ~stop = 
    Buffer.apply_tag_by_name obj name (as_textiter start) (as_textiter stop)
  method remove_tag_by_name name ~start ~stop = 
    Buffer.remove_tag_by_name obj name (as_textiter start) (as_textiter stop)
  method remove_all_tags ~start ~stop =
    Buffer.remove_all_tags obj (as_textiter start) (as_textiter stop)
  method create_tag ?name (properties: Tag.property list) =
    let t = new tag (Buffer.create_tag_0 obj name) in
    if properties <> [] then t#set_properties properties;
    t
  method get_iter_at_char ?line char_offset =
    match line,char_offset with
    | Some v, 0   -> new iter (Buffer.get_iter_at_line obj v)
    | None  , v -> new iter (Buffer.get_iter_at_offset obj v)
    | Some l, c -> new iter (Buffer.get_iter_at_line_offset obj l c)
  method get_iter_at_byte ?(line=0) index =
    new iter (Buffer.get_iter_at_line_index  obj line index)
  method get_iter_at_mark mark = 
    new iter (Buffer.get_iter_at_mark obj (self#get_mark mark))
  method start_iter = new iter (Buffer.get_start_iter obj)
  method end_iter = new iter (Buffer.get_end_iter obj)
  method bounds = 
    let s,t=Buffer.get_bounds obj in
    new iter s,new iter t
				
  method modified = Buffer.get_modified  obj
  method set_modified setting = Buffer.set_modified  obj setting
  method delete_selection ?(interactive=true) ?(default_editable=true) () = 
    Buffer.delete_selection obj interactive default_editable
  method selection_bounds =
    let start, stop = Buffer.get_selection_bounds obj in
    (new iter start, new iter stop)
  method begin_user_action () = Buffer.begin_user_action obj
  method end_user_action () = Buffer.end_user_action obj
  method create_child_anchor (iter:iter) = 
    new child_anchor (Buffer.create_child_anchor obj iter#as_textiter)
  method insert_child_anchor (iter:iter) (child_anchor:child_anchor) = 
    Buffer.insert_child_anchor obj iter#as_textiter child_anchor#as_childanchor
  method paste_clipboard ?(iter:iter option) ?(default_editable=true)
    clipboard = 
    Buffer.paste_clipboard obj clipboard 
      (match iter with None -> None | Some i -> Some i#as_textiter)
      default_editable
  method copy_clipboard = Buffer.copy_clipboard obj
  method cut_clipboard ?(default_editable=true) clipboard = 
    Buffer.cut_clipboard obj clipboard default_editable
  method add_selection_clipboard = Buffer.add_selection_clipboard obj
  method remove_selection_clipboard = Buffer.remove_selection_clipboard obj
end

let buffer ?(tagtable:tagtable option) ?text () =
  let b = 
    match tagtable with 
      | None -> new buffer (Buffer.create None)
      | Some t -> new buffer (Buffer.create (Some t#as_tagtable))
  in
    match text with | None -> b | Some t -> b#set_text t; b
 

class view_signals obj = object
  inherit gtkobj_signals (obj : [> Gtk.textview] obj)
  method copy_clipboard = 
     GtkSignal.connect ~sgn:View.Signals.copy_clipboard ~after obj
  method cut_clipboard = 
     GtkSignal.connect ~sgn:View.Signals.cut_clipboard ~after obj
  method delete_from_cursor = 
     GtkSignal.connect ~sgn:View.Signals.delete_from_cursor ~after obj
  method insert_at_cursor = 
     GtkSignal.connect ~sgn:View.Signals.insert_at_cursor ~after obj
  method move_cursor = 
     GtkSignal.connect ~sgn:View.Signals.move_cursor ~after obj
  method move_focus = 
     GtkSignal.connect ~sgn:View.Signals.move_focus ~after obj
  method page_horizontally = 
     GtkSignal.connect ~sgn:View.Signals.page_horizontally ~after obj
  method paste_clipboard = 
     GtkSignal.connect ~sgn:View.Signals.paste_clipboard ~after obj
  method populate_popup = 
     GtkSignal.connect ~sgn:View.Signals.populate_popup ~after obj
  method set_anchor = 
     GtkSignal.connect ~sgn:View.Signals.set_anchor ~after obj
  method set_scroll_adjustments = 
     GtkSignal.connect ~sgn:View.Signals.set_scroll_adjustments ~after obj
  method toggle_overwrite = 
     GtkSignal.connect ~sgn:View.Signals.toggle_overwrite ~after obj
end

class view obj = object (self)
  inherit widget (obj : Gtk.textview obj)
  method event = new GObj.event_ops obj
  method connect = new view_signals obj
  method as_view = obj
  method set_buffer (b:buffer) = View.set_buffer obj (b#as_buffer)
  method buffer = new buffer (View.get_buffer obj)
  method scroll_to_mark 
    ?(within_margin=0.) ?(use_align=false)  
    ?(xalign=0.) ?(yalign=0.) mark =  
    View.scroll_to_mark obj (self#buffer#get_mark mark)
      within_margin use_align xalign yalign
  method scroll_to_iter  ?(within_margin=0.) ?(use_align=false)
      ?(xalign=0.) ?(yalign=0.) iter =
    View.scroll_to_iter obj (as_textiter iter) within_margin
      use_align xalign yalign
  method scroll_mark_onscreen mark =  
    View.scroll_mark_onscreen obj (self#buffer#get_mark mark)
  method move_mark_onscreen mark =  
    View.move_mark_onscreen obj (self#buffer#get_mark mark)
  method place_cursor_onscreen () =  
    View.place_cursor_onscreen obj
  method visible_rect =  View.get_visible_rect obj
  method get_iter_location iter = View.get_iter_location obj (as_textiter iter)
  method get_line_at_y y =
    let it, n = View.get_line_at_y obj y in (new iter it, n)
  method get_line_yrange iter = View.get_line_yrange obj (as_textiter iter)
  method get_iter_at_location ~x ~y =
    new iter (View.get_iter_at_location obj x y)
  method buffer_to_window_coords ~tag ~x ~y =
    View.buffer_to_window_coords obj tag x y
  method window_to_buffer_coords  ~tag ~x ~y =
    View.window_to_buffer_coords obj tag x y
  method get_window win = 
    View.get_window obj win
  method get_window_type win = 
    View.get_window_type obj win
  method set_border_window_size ~typ ~size =
    View.set_border_window_size obj typ size
  method get_border_window_size typ = 
    View.get_border_window_size obj typ
  method forward_display_line iter =
    View.forward_display_line obj (as_textiter iter)
  method backward_display_line iter =
    View.backward_display_line obj (as_textiter iter)
  method forward_display_line_end iter =
    View.forward_display_line_end obj (as_textiter iter)
  method backward_display_line_start iter =
    View.backward_display_line_start obj (as_textiter iter)
  method starts_display_line iter =
    View.starts_display_line obj (as_textiter iter)
  method move_visually iter count =
    View.move_visually obj (as_textiter iter) count
  method add_child_at_anchor (w : widget) (anchor : child_anchor) =
    View.add_child_at_anchor obj w#as_widget anchor#as_childanchor
  method add_child_in_window ~(child : widget) ~which_window ~x ~y =
    View.add_child_in_window obj child#as_widget which_window x y
  method move_child ~(child : widget) ~x ~y =
    View.move_child obj child#as_widget x y
  method set_wrap_mode wr = View.set_wrap_mode obj wr
  method wrap_mode = View.get_wrap_mode obj
  method set_editable b = View.set_editable obj b
  method editable = View.get_editable obj
  method set_cursor_visible b = View.set_cursor_visible obj b
  method cursor_visible = View.get_cursor_visible obj
  method pixels_above_lines = View.get_pixels_above_lines obj 
  method set_pixels_above_lines n = View.set_pixels_above_lines obj n
  method pixels_below_lines = View.get_pixels_below_lines obj 
  method set_pixels_below_lines n = View.set_pixels_below_lines obj n
  method pixels_inside_wrap = View.get_pixels_inside_wrap obj 
  method set_pixels_inside_wrap n = View.set_pixels_inside_wrap obj n
  method justification = View.get_justification obj 
  method set_justification j = View.set_justification obj j
  method left_margin = View.get_left_margin obj 
  method set_left_margin n = View.set_left_margin obj n
  method right_margin = View.get_right_margin obj 
  method set_right_margin n = View.set_right_margin obj n
  method indent = View.get_indent obj 
  method set_indent n = View.set_indent obj n
end


let view ?(buffer:buffer option) ?packing ?show () = 
    let w = match buffer with 
      | None -> View.create ()
      | Some b -> View.create_with_buffer b#as_buffer
    in
    pack_return (new view w) ~packing ~show


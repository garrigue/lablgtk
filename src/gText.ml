open Gaux
open Gtk
open GtkBase
open GtkText
open GObj

class mark obj =
object
  inherit gtkobj (obj :Gtk.textmark obj)
  method as_mark = obj
  method set_visible b = Mark.set_visible obj b
  method get_visible () = Mark.get_visible obj
  method get_deleted () = Mark.get_deleted obj
  method get_name () = Mark.get_name obj
  method get_buffer () = Mark.get_buffer obj
  method get_left_gravity () = Mark.get_left_gravity obj
end

class child_anchor obj =
object
  inherit gtkobj (obj :Gtk.textchildanchor obj)
  method as_childanchor = obj
  method get_widgets () = Child_Anchor.get_widgets obj
  method get_deleted () = Child_Anchor.get_deleted obj
end

let child_anchor () = new child_anchor(Child_Anchor.create ())

class iter it =
object
  val it = (it: textiter)
  method as_textiter = it
  method get_buffer () = GtkText.Iter.get_buffer it
  method get_offset () = GtkText.Iter.get_offset it
  method get_line () = GtkText.Iter.get_line it
  method get_line_offset () = GtkText.Iter.get_line_offset it
  method get_line_index () = GtkText.Iter.get_line_index it
  method get_visible_line_index () = GtkText.Iter.get_visible_line_index it
  method get_visible_line_offset () = GtkText.Iter.get_visible_line_offset it
  method get_char () = GtkText.Iter.get_char it
  method get_slice ~stop = GtkText.Iter.get_slice it stop
  method get_text ~stop = GtkText.Iter.get_text it stop
  method get_visible_slice ~stop = GtkText.Iter.get_visible_slice it stop
  method get_visible_text  ~stop = GtkText.Iter.get_visible_text it stop
  method get_pixbuf () = GtkText.Iter.get_pixbuf it
  method get_marks () = GtkText.Iter.get_marks it
  method get_toggled_tags  = GtkText.Iter.get_toggled_tags it
  method get_child_anchor  = GtkText.Iter.get_child_anchor it
  method begins_tag  = GtkText.Iter.begins_tag it
  method ends_tag  = GtkText.Iter.ends_tag it
  method toggles_tag  = GtkText.Iter.toggles_tag it
  method has_tag  = GtkText.Iter.has_tag it
  method get_tags () = GtkText.Iter.get_tags it
  method editable  = GtkText.Iter.editable it
  method can_insert  = GtkText.Iter.can_insert it
  method starts_word () = GtkText.Iter.starts_word it
  method ends_word () = GtkText.Iter.ends_word it
  method inside_word () = GtkText.Iter.inside_word it
  method starts_line () = GtkText.Iter.starts_line it
  method ends_line () = GtkText.Iter.ends_line it
  method starts_sentence () = GtkText.Iter.starts_sentence it
  method ends_sentence () = GtkText.Iter.ends_sentence it
  method inside_sentence () = GtkText.Iter.inside_sentence it
  method is_cursor_position () = GtkText.Iter.is_cursor_position it
  method get_chars_in_line () = GtkText.Iter.get_chars_in_line it
  method get_bytes_in_line () = GtkText.Iter.get_bytes_in_line it
  method is_end () = GtkText.Iter.is_end it
  method is_start () = GtkText.Iter.is_start it
  method forward_char () = GtkText.Iter.forward_char it
  method backward_char () = GtkText.Iter.backward_char it
  method forward_chars = GtkText.Iter.forward_chars it
  method backward_chars  = GtkText.Iter.backward_chars it
  method forward_line () = GtkText.Iter.forward_line it
  method backward_line () = GtkText.Iter.backward_line it
  method forward_lines  = GtkText.Iter.forward_lines it
  method backward_lines  = GtkText.Iter.backward_lines it
  method forward_word_end () = GtkText.Iter.forward_word_end it
  method forward_word_ends  = GtkText.Iter.forward_word_ends it
  method backward_word_start () = GtkText.Iter.backward_word_start it
  method backward_word_starts  = GtkText.Iter.backward_word_starts it
  method forward_cursor_position () = GtkText.Iter.forward_cursor_position it
  method backward_cursor_position () = GtkText.Iter.backward_cursor_position it
  method forward_cursor_positions  = GtkText.Iter.forward_cursor_positions it
  method backward_cursor_positions  = GtkText.Iter.backward_cursor_positions it
  method forward_sentence_end () = GtkText.Iter.forward_sentence_end it
  method backward_sentence_start () = GtkText.Iter.backward_sentence_start it
  method forward_sentence_ends  = GtkText.Iter.forward_sentence_ends it
  method backward_sentence_starts  = GtkText.Iter.backward_sentence_starts it
  method set_offset  = GtkText.Iter.set_offset it
  method set_line  = GtkText.Iter.set_line it
  method set_line_offset  = GtkText.Iter.set_line_offset it
  method set_line_index  = GtkText.Iter.set_line_index it
  method set_visible_line_index  = GtkText.Iter.set_visible_line_index it
  method set_visible_line_offset  = GtkText.Iter.set_visible_line_offset it
  method forward_to_end () = GtkText.Iter.forward_to_end it
  method forward_to_line_end () = GtkText.Iter.forward_to_line_end it
  method forward_to_tag_toggle  = GtkText.Iter.forward_to_tag_toggle it
  method backward_to_tag_toggle  = GtkText.Iter.backward_to_tag_toggle it
  method equal  = GtkText.Iter.equal it
  method compare  = GtkText.Iter.compare it
  method in_range ~start ~stop  = GtkText.Iter.in_range it start stop
end

class tag_signals obj = object
  inherit gtkobj_signals obj
  method event = 
    GtkSignal.connect ~sgn:GtkText.Tag.Signals.event ~after obj
end

class tag obj =
object (self)
  inherit gtkobj (obj :Gtk.texttag obj)
  method as_tag = obj
  method connect = new tag_signals obj
  method get_priority () = Tag.get_priority obj
  method set_priority p = Tag.set_priority obj p
  (* [BM] my very first polymorphic method in OCaml...*)
  method event : 'a. 'a Gtk.obj -> 'a Gdk.event -> Gtk.textiter -> bool = 
    Tag.event obj 
  method set_property p = 
    Tag.set_property obj p
  method set_properties l = 
    List.iter self#set_property l
end

let tag s = new tag(Tag.create s)


class tagtable_signals obj = object
  inherit gtkobj_signals obj
  method tag_added = 
     GtkSignal.connect ~sgn:GtkText.TagTable.Signals.tag_added ~after obj
  method tag_changed = 
     GtkSignal.connect ~sgn:GtkText.TagTable.Signals.tag_changed ~after obj
  method tag_removed = 
     GtkSignal.connect ~sgn:GtkText.TagTable.Signals.tag_removed ~after obj
end

class tagtable obj = 
object
  inherit gtkobj (obj :Gtk.texttagtable obj)
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
  inherit gtkobj_signals obj
  method apply_tag = 
     GtkSignal.connect ~sgn:GtkText.Buffer.Signals.apply_tag ~after obj
  method begin_user_action = 
     GtkSignal.connect ~sgn:GtkText.Buffer.Signals.begin_user_action ~after obj
  method changed = 
     GtkSignal.connect ~sgn:GtkText.Buffer.Signals.changed ~after obj
  method delete_range = 
     GtkSignal.connect ~sgn:GtkText.Buffer.Signals.delete_range ~after obj
  method end_user_action = 
     GtkSignal.connect ~sgn:GtkText.Buffer.Signals.end_user_action ~after obj
  method insert_child_anchor = 
     GtkSignal.connect ~sgn:GtkText.Buffer.Signals.insert_child_anchor ~after obj
  method insert_pixbuf = 
     GtkSignal.connect ~sgn:GtkText.Buffer.Signals.insert_pixbuf ~after obj
  method insert_text = 
     GtkSignal.connect ~sgn:GtkText.Buffer.Signals.insert_text ~after obj
  method mark_deleted = 
     GtkSignal.connect ~sgn:GtkText.Buffer.Signals.mark_deleted ~after obj
  method mark_set = 
     GtkSignal.connect ~sgn:GtkText.Buffer.Signals.mark_set ~after obj
  method modified_changed = 
     GtkSignal.connect ~sgn:GtkText.Buffer.Signals.modified_changed ~after obj
  method remove_tag = 
     GtkSignal.connect ~sgn:GtkText.Buffer.Signals.remove_tag ~after obj
end

class buffer obj = object(self)
  inherit gtkobj (obj: Gtk.textbuffer obj)
  method as_buffer = obj
  method connect = new buffer_signals obj
  method get_line_count = GtkText.Buffer.get_line_count obj
  method get_char_count = GtkText.Buffer.get_char_count obj
  method get_tag_table =  GtkText.Buffer.get_tag_table obj
  method insert ~text ?iter ?(length = (-1)) () = 
    match iter with
      | None -> 
	  GtkText.Buffer.insert_at_cursor obj text length
      | Some iter -> 
	  GtkText.Buffer.insert obj iter text length
  method insert_interactive ~text ?iter ?(length = -1) ?(default_editable = true) () = 
    match iter with
      | None -> 
	  GtkText.Buffer.insert_interactive_at_cursor obj text length default_editable
      | Some iter -> 
	  GtkText.Buffer.insert_interactive obj iter text length default_editable
  method insert_range ~iter ~start ~stop () = 
    GtkText.Buffer.insert_range obj iter start stop
  method insert_range_interactive ~iter ~start ~stop ?(default_editable = true) () = 
    GtkText.Buffer.insert_range_interactive obj iter start stop default_editable
  method delete ~start ~stop = GtkText.Buffer.delete obj start stop
  method delete_interactive ~start ~stop ?(default_editable = true) () = 
    GtkText.Buffer.delete_interactive obj start stop default_editable
  method set_text ?(length = (-1)) ~text () = 
    GtkText.Buffer.set_text obj text length
  method get_text ?(include_hidden_chars=false) ?start ?stop () =
    let start,stop = 
      match start,stop with 
	| None,None -> self#get_bounds ()
	| Some start,None -> start,self#get_start_iter ()
	| None,Some stop -> self#get_end_iter (),stop
	| Some start,Some stop -> start,stop
    in
      GtkText.Buffer.get_text obj start stop include_hidden_chars 
  method get_slice ?(include_hidden_chars=false) ~start ~stop () =
    GtkText.Buffer.get_slice obj start stop include_hidden_chars 
  method insert_pixbuf ~iter ~pixbuf = GtkText.Buffer.insert_pixbuf obj iter pixbuf
  method create_mark ?name ~iter ?(left_gravity=true) () = 
    new mark (GtkText.Buffer.create_mark obj name iter left_gravity)
  method get_mark ~name = new mark (GtkText.Buffer.get_mark obj name)
  method move_mark ~(mark:mark) ~where = GtkText.Buffer.move_mark obj mark#as_mark where
  method move_mark_by_name ~name ~where = GtkText.Buffer.move_mark_by_name obj name where
  method delete_mark ~(mark:mark) = GtkText.Buffer.delete_mark obj mark#as_mark
  method delete_mark_by_name ~name = GtkText.Buffer.delete_mark_by_name obj name
  method get_mark ~name = new mark (GtkText.Buffer.get_mark obj name)
  method get_insert () = new mark (GtkText.Buffer.get_insert obj)
  method get_selection_bound () = new mark (GtkText.Buffer.get_selection_bound obj)
  method place_cursor ~where = GtkText.Buffer.place_cursor obj where
  method apply_tag ~(tag:tag) ~start ~stop = GtkText.Buffer.apply_tag obj tag#as_tag start stop
  method remove_tag ~(tag:tag) ~start ~stop = GtkText.Buffer.remove_tag obj tag#as_tag start stop
  method apply_tag_by_name ~name ~start ~stop = 
    GtkText.Buffer.apply_tag_by_name obj name start stop
  method remove_tag_by_name ~name ~start ~stop = 
    GtkText.Buffer.remove_tag_by_name obj name start stop
  method remove_all_tags ~start ~stop =
    GtkText.Buffer.remove_all_tags obj start stop
  method create_tag ?name ~(properties: GtkText.Tag.property list) () =
    let t =  new tag (GtkText.Buffer.create_tag_0 obj name) in
      t#set_properties properties;
      t
  method get_iter_at ?line_number ?char_offset () =
    match line_number,char_offset with
      | None,None -> raise (Invalid_argument
	  "?line_number and/or ?char_offset missing for get_iter_at")
      | Some v,None -> GtkText.Buffer.get_iter_at_line obj v
      | None, Some v -> GtkText.Buffer.get_iter_at_offset obj v
      | Some l, Some c -> GtkText.Buffer.get_iter_at_line_offset obj l c
  method get_iter_at_line_index ~line_number ~line_index = 
    GtkText.Buffer.get_iter_at_line_index  obj line_number line_index
  method get_iter_at_mark ~(mark:mark) = GtkText.Buffer.get_iter_at_mark obj mark#as_mark
  method get_start_iter () = GtkText.Buffer.get_start_iter obj
  method get_end_iter () = GtkText.Buffer.get_end_iter obj
  method get_bounds () = GtkText.Buffer.get_bounds obj
  method get_modified () = GtkText.Buffer.get_modified  obj
  method set_modified ~setting = GtkText.Buffer.set_modified  obj setting
  method delete_selection ?(interactive=true) ?(default_editable=true) () = 
    GtkText.Buffer.delete_selection obj interactive default_editable
  method get_selection_bounds () = GtkText.Buffer.get_selection_bounds obj
  method begin_user_action () = GtkText.Buffer.begin_user_action obj
  method end_user_action () = GtkText.Buffer.end_user_action obj
end

let buffer ?(tagtable:tagtable option) ?text () =
  let b = 
    match tagtable with 
      | None -> new buffer (Buffer.create None)
      | Some t -> new buffer (Buffer.create (Some t#as_tagtable))
  in
    match text with | None -> b | Some t -> b#set_text ~text:t () ; b
 

class view_signals obj = object
  inherit gtkobj_signals obj
  method copy_clipboard = 
     GtkSignal.connect ~sgn:GtkText.View.Signals.copy_clipboard ~after obj
  method cut_clipboard = 
     GtkSignal.connect ~sgn:GtkText.View.Signals.cut_clipboard ~after obj
  method delete_from_cursor = 
     GtkSignal.connect ~sgn:GtkText.View.Signals.delete_from_cursor ~after obj
  method insert_at_cursor = 
     GtkSignal.connect ~sgn:GtkText.View.Signals.insert_at_cursor ~after obj
  method move_cursor = 
     GtkSignal.connect ~sgn:GtkText.View.Signals.move_cursor ~after obj
  method move_focus = 
     GtkSignal.connect ~sgn:GtkText.View.Signals.move_focus ~after obj
  method page_horizontally = 
     GtkSignal.connect ~sgn:GtkText.View.Signals.page_horizontally ~after obj
  method paste_clipboard = 
     GtkSignal.connect ~sgn:GtkText.View.Signals.paste_clipboard ~after obj
  method populate_popup = 
     GtkSignal.connect ~sgn:GtkText.View.Signals.populate_popup ~after obj
  method set_anchor = 
     GtkSignal.connect ~sgn:GtkText.View.Signals.set_anchor ~after obj
  method set_scroll_adjustments = 
     GtkSignal.connect ~sgn:GtkText.View.Signals.set_scroll_adjustments ~after obj
  method toggle_overwrite = 
     GtkSignal.connect ~sgn:GtkText.View.Signals.toggle_overwrite ~after obj
end

class view obj = object
  inherit widget (obj : Gtk.textview obj)
  method event = new GObj.event_ops obj
  method connect = new view_signals obj
  method as_view = obj
  method set_buffer (b:buffer) = GtkText.View.set_buffer obj (b#as_buffer)
  method get_buffer () = new buffer (GtkText.View.get_buffer obj)
  method scroll_to_mark 
    ?(within_margin=0.) ?(use_align=false)  
    ?(xalign=0.) ?(yalign=0.) (mark:mark) =  
    GtkText.View.scroll_to_mark obj mark#as_mark within_margin use_align xalign yalign
  method scroll_to_iter  ?(within_margin=0.) ?(use_align=false)  ?(xalign=0.) ?(yalign=0.) iter =
    GtkText.View.scroll_to_iter obj iter within_margin use_align xalign yalign
  method scroll_mark_onscreen (mark:mark) =  
    GtkText.View.scroll_mark_onscreen obj mark#as_mark
  method move_mark_onscreen (mark:mark) =  
    GtkText.View.move_mark_onscreen obj mark#as_mark
  method place_cursor_onscreen () =  
    GtkText.View.place_cursor_onscreen obj
  method get_visible_rect () = 
    GtkText.View.get_visible_rect obj
  method get_iter_location iter = 
    GtkText.View.get_iter_location obj iter
  method get_line_at_y y = 
    GtkText.View.get_line_at_y obj y
  method get_line_yrange iter = 
    GtkText.View.get_line_yrange obj iter
  method get_iter_at_location ~x ~y =
    GtkText.View.get_iter_at_location obj x y
  method buffer_to_window_coords ~tag ~x ~y =
    GtkText.View.buffer_to_window_coords obj tag x y
  method window_to_buffer_coords  ~tag ~x ~y =
    GtkText.View.window_to_buffer_coords obj tag x y
  method get_window win = 
    GtkText.View.get_window obj win
  method get_window_type win = 
    GtkText.View.get_window_type obj win
  method set_border_window_size ~typ ~size =
    GtkText.View.set_border_window_size obj typ size
  method get_border_window_size typ = 
    GtkText.View.get_border_window_size obj typ
  method forward_display_line iter =
    GtkText.View.forward_display_line obj iter
  method backward_display_line iter =
    GtkText.View.backward_display_line obj iter
  method forward_display_line_end iter =
    GtkText.View.forward_display_line_end obj iter
  method backward_display_line_start iter =
    GtkText.View.backward_display_line_start obj iter
  method starts_display_line iter =
    GtkText.View.starts_display_line obj iter
  method move_visually iter count =
    GtkText.View.move_visually obj iter count
  method add_child_at_anchor (w : widget) (anchor : child_anchor) =
    GtkText.View.add_child_at_anchor obj w#as_widget anchor#as_childanchor
  method add_child_in_window ~(child : widget) ~which_window ~x ~y =
    GtkText.View.add_child_in_window obj child#as_widget which_window x y
  method move_child ~(child : widget) ~x ~y =
    GtkText.View.move_child obj child#as_widget x y
  method set_wrap_mode wr =
    GtkText.View.set_wrap_mode obj wr
  method get_wrap_mode () =
    GtkText.View.get_wrap_mode obj
  method set_editable b =
    GtkText.View.set_editable obj b
  method get_editable () =
    GtkText.View.get_editable obj
  method set_cursor_visible b =
    GtkText.View.set_cursor_visible obj b
  method get_cursor_visible () =
    GtkText.View.get_cursor_visible obj
  method get_pixels_above_lines () = 
    GtkText.View.get_pixels_above_lines obj 
  method set_pixels_above_lines n = 
    GtkText.View.set_pixels_above_lines obj n
  method get_pixels_below_lines () = 
    GtkText.View.get_pixels_below_lines obj 
  method set_pixels_below_lines n = 
    GtkText.View.set_pixels_below_lines obj n
  method get_pixels_inside_wrap () = 
    GtkText.View.get_pixels_inside_wrap obj 
  method set_pixels_inside_wrap n = 
    GtkText.View.set_pixels_inside_wrap obj n
  method get_justification () = 
    GtkText.View.get_justification obj 
  method set_justification j = 
    GtkText.View.set_justification obj j
  method get_left_margin () = 
    GtkText.View.get_left_margin obj 
  method set_left_margin n = 
    GtkText.View.set_left_margin obj n
  method get_right_margin () = 
    GtkText.View.get_right_margin obj 
  method set_right_margin n = 
    GtkText.View.set_right_margin obj n
  method get_indent () = 
    GtkText.View.get_indent obj 
  method set_indent n = 
    GtkText.View.set_indent obj n
end


let view ?(buffer:buffer option) ?packing ?show () = 
    let w = match buffer with 
      | None -> View.create ()
      | Some b -> View.create_with_buffer b#as_buffer
    in
    pack_return (new view w) ~packing ~show


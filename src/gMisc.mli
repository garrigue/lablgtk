(* $Id$ *)

open Gtk

class separator :
  Tags.orientation ->
  ?width:int ->
  ?height:int ->
  ?packing:(separator -> unit) -> ?show:bool ->
  object
    inherit GObj.widget_wrapper
    val obj : Gtk.separator obj
  end
class separator_wrapper : Gtk.separator obj -> separator

class statusbar_context :
  Gtk.statusbar obj ->
  Gtk.statusbar_context ->
  object
    method context : Gtk.statusbar_context
    method flash : string -> ?delay:int -> unit
    method pop : unit -> unit
    method push : string -> statusbar_message
    method remove : statusbar_message -> unit
  end

class statusbar :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(statusbar -> unit) -> ?show:bool ->
  object
    inherit GContainer.container_wrapper
    val obj : Gtk.statusbar obj
    method new_context : name:string -> statusbar_context
  end
class statusbar_wrapper : Gtk.statusbar obj -> statusbar

class calendar_signals :
  'a[> calendar widget] Gtk.obj ->
  object
    inherit GObj.widget_signals
    val obj : 'a Gtk.obj
    method day_selected :
	callback:(unit -> unit) -> ?after:bool -> GtkSignal.id
    method day_selected_double_click :
	callback:(unit -> unit) -> ?after:bool -> GtkSignal.id
    method month_changed :
	callback:(unit -> unit) -> ?after:bool -> GtkSignal.id
    method next_month : callback:(unit -> unit) -> ?after:bool -> GtkSignal.id
    method next_year : callback:(unit -> unit) -> ?after:bool -> GtkSignal.id
    method prev_month : callback:(unit -> unit) -> ?after:bool -> GtkSignal.id
    method prev_year : callback:(unit -> unit) -> ?after:bool -> GtkSignal.id
  end
class calendar :
  ?options:Tags.calendar_display_options list ->
  ?width:int -> ?height:int ->
  ?packing:(calendar -> unit) -> ?show:bool ->
  object
    inherit GObj.widget
    val obj : Gtk.calendar obj
    method add_events : Gdk.Tags.event_mask list -> unit
    method connect : calendar_signals
    method clear_marks : unit
    method date : int * int * int
    method display_options : Tags.calendar_display_options list -> unit
    method freeze : unit -> unit
    method mark_day : int -> unit
    method select_day : int -> unit
    method select_month : month:int -> year:int -> unit
    method thaw : unit -> unit
    method unmark_day : int -> unit
  end
class calendar_wrapper : Gtk.calendar obj -> calendar

class drawing_area :
  ?width:int ->
  ?height:int ->
  ?packing:(drawing_area -> unit) -> ?show:bool ->
  object
    inherit GObj.widget_wrapper
    val obj : Gtk.drawing_area obj
    method add_events : Gdk.Tags.event_mask list -> unit
    method set_size : width:int -> height:int -> unit
  end
class drawing_area_wrapper : Gtk.drawing_area obj -> drawing_area

class misc :
  'a[> misc widget] obj ->
  object
    inherit GObj.widget
    val obj : 'a obj
    method set_alignment : ?x:float -> ?y:float -> unit
    method set_padding : ?x:int -> ?y:int -> unit
  end

class label_skel :
  'a[> label misc widget] obj ->
  object
    inherit misc
    val obj : 'a obj
    method set_justify : Tags.justification -> unit
    method set_line_wrap : bool -> unit 
    method set_pattern : string -> unit
    method set_text : string -> unit
    method text : string
  end

class label :
  ?text:string ->
  ?justify:Tags.justification ->
  ?line_wrap:bool ->
  ?pattern:string ->
  ?xalign:float ->
  ?yalign:float ->
  ?xpad:int ->
  ?ypad:int ->
  ?width:int -> ?height:int ->
  ?packing:(label -> unit) -> ?show:bool ->
  object
    inherit label_skel
    val obj : Gtk.label obj
    method connect : GObj.widget_signals
  end
class label_wrapper : ([> label]) obj -> label

class tips_query_signals :
  'a[> tipsquery widget] obj ->
  object
    inherit GObj.widget_signals
    val obj : 'a obj
    method widget_entered :
      callback:(GObj.widget_wrapper option ->
                text:string option -> private:string option -> unit) ->
      ?after:bool -> GtkSignal.id
    method widget_selected :
      callback:(GObj.widget_wrapper option ->
                text:string option ->
		private:string option -> GdkEvent.Button.t -> bool) ->
      ?after:bool -> GtkSignal.id
  end

class tips_query :
  ?caller:#GObj.is_widget ->
  ?emit_always:bool ->
  ?label_inactive:string ->
  ?label_no_tip:string ->
  ?width:int -> ?height:int ->
  ?packing:(tips_query -> unit) -> ?show:bool ->
  object
    inherit label_skel
    val obj : Gtk.tips_query obj
    method connect : tips_query_signals
    method set_caller : #GObj.is_widget -> unit
    method set_emit_always : bool -> unit
    method set_label_inactive : string -> unit
    method set_label_no_tip : string -> unit
    method start : unit -> unit
    method stop : unit -> unit
  end
class tips_query_wrapper : Gtk.tips_query obj -> tips_query

class notebook_signals :
  'a[> container notebook widget] Gtk.obj ->
  object
    inherit GContainer.container_signals
    val obj : 'a Gtk.obj
    method switch_page : callback:(int -> unit) -> ?after:bool -> GtkSignal.id
  end

class notebook :
  ?tab_pos:Tags.position ->
  ?tab_border:int ->
  ?show_tabs:bool ->
  ?homogeneous_tabs:bool ->
  ?show_border:bool ->
  ?scrollable:bool ->
  ?popup:bool ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(notebook -> unit) ->
  ?show:bool ->
  object
    inherit GContainer.container
    val obj : Gtk.notebook obj
    method add_events : Gdk.Tags.event_mask list -> unit
    method connect : notebook_signals
    method append_page :
      #GObj.is_widget ->
      ?tab_label:#GObj.is_widget -> ?menu_label:#GObj.is_widget -> unit
    method current_page : int
    method goto_page : int -> unit
    method insert_page :
      #GObj.is_widget -> ?tab_label:#GObj.is_widget ->
      ?menu_label:#GObj.is_widget -> pos:int -> unit
    method next_page : unit -> unit
    method nth_page : int -> GObj.widget
    method page_num : #GObj.is_widget -> int
    method prepend_page :
      #GObj.is_widget ->
      ?tab_label:#GObj.is_widget -> ?menu_label:#GObj.is_widget -> unit
    method previous_page : unit -> unit
    method remove_page : int -> unit
    method set_tab_pos : Tags.position -> unit
    method set_show_tabs : bool -> unit
    method set_homogeneous_tabs : bool -> unit
    method set_show_border : bool -> unit
    method set_scrollable : bool -> unit
    method set_tab_border : int -> unit
    method set_popup : bool -> unit
    method set_page :
      #GObj.is_widget ->
      ?tab_label:#GObj.is_widget -> ?menu_label:#GObj.is_widget -> unit
  end
class notebook_wrapper : Gtk.notebook obj -> notebook

class color_selection :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(color_selection -> unit) -> ?show:bool ->
  object
    inherit GObj.widget_wrapper
    val obj : Gtk.color_selection obj
    method get_color : color
    method set_color :
      red:float -> green:float -> blue:float -> ?opacity:float -> unit
    method set_update_policy : Tags.update_type -> unit
    method set_opacity : bool -> unit
  end
class color_selection_wrapper : Gtk.color_selection obj -> color_selection

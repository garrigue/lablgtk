(* $Id$ *)

open Gtk

class separator :
  Tags.orientation ->
  ?packing:(separator -> unit) ->
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
  ?packing:(statusbar -> unit) ->
  object
    inherit GContainer.container_wrapper
    val obj : Gtk.statusbar obj
    method new_context : name:string -> statusbar_context
  end
class statusbar_wrapper : Gtk.statusbar obj -> statusbar

class drawing_area :
  ?width:int ->
  ?height:int ->
  ?packing:(drawing_area -> unit) ->
  object
    inherit GObj.widget_wrapper
    val obj : Gtk.drawing_area obj
    method set_size : width:int -> height:int -> unit
  end
class drawing_area_wrapper : Gtk.drawing_area obj -> drawing_area

class misc :
  'a[> misc widget] obj ->
  object
    inherit GObj.widget
    val obj : 'a obj
    method set_alignment : x:float -> y:float -> unit
    method set_padding : x:int -> y:int -> unit
  end

class label_skel :
  'a[> label misc widget] obj ->
  object
    inherit misc
    val obj : 'a obj
    method set_justify : Tags.justification -> unit
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
  ?packing:(label -> unit) ->
  object
    inherit label_skel
    val obj : Gtk.label obj
    method connect : ?after:bool -> GObj.widget_signals
  end
class label_wrapper : ([> label]) obj -> label

class tips_query_signals :
  'a[> tipsquery widget] obj -> ?after:bool ->
  object
    inherit GObj.widget_signals
    val obj : 'a obj
    method widget_entered :
      callback:(GObj.widget_wrapper option ->
                string option -> string option -> unit) -> GtkSignal.id
    method widget_selected :
      callback:(GObj.widget_wrapper option ->
                string option ->
		string option -> Gdk.Event.Button.t -> bool) -> GtkSignal.id
  end

class tips_query :
  ?caller:[> widget] obj ->
  ?emit_always:bool ->
  ?label_inactive:string ->
  ?label_no_tip:string ->
  ?packing:(tips_query -> unit) ->
  object
    inherit label_skel
    val obj : Gtk.tips_query obj
    method connect : ?after:bool -> tips_query_signals
    method set_labels : inactive:string -> no_tip:string -> unit
    method set_caller : #GObj.is_widget -> unit
    method start : unit -> unit
    method stop : unit -> unit
  end
class tips_query_wrapper : Gtk.tips_query obj -> tips_query

class color_selection :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(color_selection -> unit) ->
  object
    inherit GPack.box_wrapper
    val obj : Gtk.color_selection obj
    method get_color : color
    method set_color :
      red:float -> green:float -> blue:float -> ?opacity:float -> unit
    method set_update_policy : Tags.update_type -> unit
    method set_opacity : bool -> unit
  end
class color_selection_wrapper : Gtk.color_selection obj -> color_selection

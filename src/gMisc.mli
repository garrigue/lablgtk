(* $Id$ *)

open Gtk
open GObj
open GContainer

val separator :
  Tags.orientation ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> widget_full

class statusbar_context :
  Gtk.statusbar obj -> Gtk.statusbar_context ->
  object
    val context : Gtk.statusbar_context
    val obj : Gtk.statusbar obj
    method context : Gtk.statusbar_context
    method flash : ?delay:int -> string -> unit
    method pop : unit -> unit
    method push : string -> statusbar_message
    method remove : statusbar_message -> unit
  end

class statusbar : Gtk.statusbar obj ->
  object
    inherit container_full
    val obj : Gtk.statusbar obj
    method new_context : name:string -> statusbar_context
  end
val statusbar :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> statusbar

class calendar_signals : 'a obj ->
  object
    inherit widget_signals
    constraint 'a = [>`calendar|`widget]
    val obj : 'a obj
    method day_selected : callback:(unit -> unit) -> GtkSignal.id
    method day_selected_double_click :
      callback:(unit -> unit) -> GtkSignal.id
    method month_changed : callback:(unit -> unit) -> GtkSignal.id
    method next_month : callback:(unit -> unit) -> GtkSignal.id
    method next_year : callback:(unit -> unit) -> GtkSignal.id
    method prev_month : callback:(unit -> unit) -> GtkSignal.id
    method prev_year : callback:(unit -> unit) -> GtkSignal.id
  end

class calendar : Gtk.calendar obj ->
  object
    inherit widget
    val obj : Gtk.calendar obj
    method event : event_ops
    method clear_marks : unit
    method connect : calendar_signals
    method date : int * int * int
    method display_options : Tags.calendar_display_options list -> unit
    method freeze : unit -> unit
    method mark_day : int -> unit
    method select_day : int -> unit
    method select_month : month:int -> year:int -> unit
    method thaw : unit -> unit
    method unmark_day : int -> unit
  end
val calendar :
  ?options:Tags.calendar_display_options list ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> calendar

class drawing_area : Gtk.drawing_area obj ->
  object
    inherit widget_full
    val obj : Gtk.drawing_area obj
    method event : event_ops
    method set_size : width:int -> height:int -> unit
  end
val drawing_area :
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> drawing_area

class misc : 'a obj ->
  object
    inherit widget
    constraint 'a = [>`misc|`widget]
    val obj : 'a obj
    method set_alignment : ?x:float -> ?y:float -> unit -> unit
    method set_padding : ?x:int -> ?y:int -> unit -> unit
  end

class arrow : 'a obj ->
  object
    inherit misc
    constraint 'a = [>`arrow|`misc|`widget]
    val obj : 'a obj
    method set_arrow : Tags.arrow_type -> shadow:Tags.shadow_type -> unit
  end

val arrow :
  kind:Tags.arrow_type ->
  shadow:Tags.shadow_type ->
  ?xalign:float ->
  ?yalign:float ->
  ?xpad:int ->
  ?ypad:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> arrow

class image : 'a obj ->
  object
    inherit misc
    constraint 'a = [>`image|`misc|`widget]
    val obj : 'a obj
    method set_image : ?mask:Gdk.bitmap -> Gdk.image -> unit
  end

val image :
  Gdk.image ->
  ?mask:Gdk.bitmap ->
  ?xalign:float ->
  ?yalign:float ->
  ?xpad:int ->
  ?ypad:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> image

class label_skel : 'a obj ->
  object
    inherit misc
    constraint 'a = [>`label|`misc|`widget]
    val obj : 'a obj
    method set_justify : Tags.justification -> unit
    method set_line_wrap : bool -> unit
    method set_pattern : string -> unit
    method set_text : string -> unit
    method text : string
  end

class label : Gtk.label obj ->
  object
    inherit label_skel
    val obj : Gtk.label obj
    method connect : widget_signals
  end
val label :
  ?text:string ->
  ?justify:Tags.justification ->
  ?line_wrap:bool ->
  ?pattern:string ->
  ?xalign:float ->
  ?yalign:float ->
  ?xpad:int ->
  ?ypad:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> label
val label_cast : < as_widget : 'a obj ; .. > -> label

class tips_query_signals : 'a obj ->
  object
    inherit widget_signals
    constraint 'a = [>`tipsquery|`widget]
    val obj : 'a obj
    method widget_entered :
      callback:(widget option ->
                text:string option -> privat:string option -> unit) ->
      GtkSignal.id
    method widget_selected :
      callback:(widget option -> text:string option ->
                privat:string option -> GdkEvent.Button.t option -> bool) ->
      GtkSignal.id
  end

class tips_query : Gtk.tips_query obj ->
  object
    inherit label_skel
    val obj : Gtk.tips_query obj
    method connect : tips_query_signals
    method set_caller : #widget -> unit
    method set_emit_always : bool -> unit
    method set_label_inactive : string -> unit
    method set_label_no_tip : string -> unit
    method start : unit -> unit
    method stop : unit -> unit
  end
val tips_query :
  ?caller:#widget ->
  ?emit_always:bool ->
  ?label_inactive:string ->
  ?label_no_tip:string ->
  ?xalign:float ->
  ?yalign:float ->
  ?xpad:int ->
  ?ypad:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> tips_query

class pixmap : Gtk.pixmap Gtk.obj ->
  object
    inherit misc
    val obj : Gtk.pixmap Gtk.obj
    method connect : GObj.widget_signals
    method pixmap : GDraw.pixmap
    method set_pixmap : GDraw.pixmap -> unit
  end
val pixmap :
  #GDraw.pixmap ->
  ?xalign:float ->
  ?yalign:float ->
  ?xpad:int ->
  ?ypad:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> pixmap

class color_selection : Gtk.color_selection obj ->
  object
    inherit widget_full
    val obj : Gtk.color_selection obj
    method get_color : Gtk.color
    method set_color :
      red:float -> green:float -> blue:float -> ?opacity:float -> unit -> unit
    method set_opacity : bool -> unit
    method set_update_policy : Tags.update_type -> unit
  end
val color_selection :
  ?update_policy:Tags.update_type ->
  ?opacity:bool ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> color_selection

class font_selection : Gtk.font_selection obj ->
  object
    inherit widget_full
    val obj : Gtk.font_selection obj
    method event : event_ops
    method notebook : GPack.notebook
    method font : Gdk.font option
    method font_name : string option
    method preview_text : string
    method set_filter :
      ?kind:Tags.font_type list ->
      ?foundry:string list ->
      ?weight:string list ->
      ?slant:string list ->
      ?setwidth:string list ->
      ?spacing:string list ->
      ?charset:string list -> Tags.font_filter_type -> unit
    method set_font_name : string -> unit
    method set_preview_text : string -> unit
  end
val font_selection :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> font_selection

(* $Id$ *)

open Gtk

class separator :
  Tags.orientation ->
  ?packing:(separator -> unit) ->
  object
    inherit GObj.widget_wrapper
    val obj : Separator.t obj
  end
class separator_wrapper : ([> separator] obj) -> separator

class statusbar_context :
  Statusbar.t obj ->
  Statusbar.context ->
  object
    method context : Statusbar.context
    method flash : string -> ?delay:int -> unit
    method pop : unit -> unit
    method push : string -> Statusbar.message
    method remove : Statusbar.message -> unit
  end

class statusbar :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(statusbar -> unit) ->
  object
    inherit GCont.container_wrapper
    val obj : Statusbar.t obj
    method new_context : name:string -> statusbar_context
  end
class statusbar_wrapper : Statusbar.t obj -> statusbar

class drawing_area :
  ?width:int ->
  ?height:int ->
  ?packing:(drawing_area -> unit) ->
  object
    inherit GObj.widget_wrapper
    val obj : DrawingArea.t obj
    method set_size : width:int -> height:int -> unit
  end
class drawing_area_wrapper : DrawingArea.t obj -> drawing_area

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
    val obj : Label.t obj
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
                string option -> string option -> unit) -> Signal.id
    method widget_selected :
      callback:(GObj.widget_wrapper option ->
                string option ->
		string option -> Gdk.Event.Button.t -> bool) -> Signal.id
  end

class tips_query :
  ?caller:[> widget] obj ->
  ?emit_always:bool ->
  ?label_inactive:string ->
  ?label_no_tip:string ->
  ?packing:(tips_query -> unit) ->
  object
    inherit label_skel
    val obj : TipsQuery.t obj
    method connect : ?after:bool -> tips_query_signals
    method set_labels : inactive:string -> no_tip:string -> unit
    method set_caller : #GObj.is_widget -> unit
    method start : unit -> unit
    method stop : unit -> unit
  end
class tips_query_wrapper : TipsQuery.t obj -> tips_query

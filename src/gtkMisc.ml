(* $Id$ *)

open Gaux
open Gtk
open Tags
open GtkBase

module GammaCurve = struct
  let cast w : gamma_curve obj = Object.try_cast w "GtkGammaCurve"
  external create : unit -> gamma_curve obj = "ml_gtk_gamma_curve_new"
  external get_gamma : [>`gamma] obj -> float = "ml_gtk_gamma_curve_get_gamma"
end

module ColorSelection = struct
  let cast w : color_selection obj = Object.try_cast w "GtkColorSelection"
  external create : unit -> color_selection obj = "ml_gtk_color_selection_new"
  external create_dialog : string -> color_selection_dialog obj
      = "ml_gtk_color_selection_dialog_new"
  external set_update_policy : [>`colorsel] obj -> update_type -> unit
      = "ml_gtk_color_selection_set_update_policy"
  external set_opacity : [>`colorsel] obj -> bool -> unit
      = "ml_gtk_color_selection_set_opacity"
  let set ?update_policy ?opacity w =
    may update_policy ~f:(set_update_policy w);
    may opacity ~f:(set_opacity w)
  external set_color :
      [>`colorsel] obj ->
      red:float -> green:float -> blue:float -> ?opacity:float -> unit
      = "ml_gtk_color_selection_set_color"
  external get_color : [>`colorsel] obj -> color
      = "ml_gtk_color_selection_get_color"

  external ok_button : [>`colorseldialog] obj -> button obj =
    "ml_gtk_color_selection_dialog_ok_button"
  external cancel_button : [>`colorseldialog] obj -> button obj =
    "ml_gtk_color_selection_dialog_cancel_button"
  external help_button : [>`colorseldialog] obj -> button obj =
    "ml_gtk_color_selection_dialog_help_button"
  external colorsel : [>`colorseldialog] obj -> color_selection obj =
    "ml_gtk_color_selection_dialog_colorsel"
  module Signals = struct
    open GtkSignal
    let color_changed : ([>`colorsel],_) t =
      { name = "color_changed"; marshaller = marshal_unit }
  end
end

module Statusbar = struct
  let cast w : statusbar obj = Object.try_cast w "GtkStatusbar"
  external create : unit -> statusbar obj = "ml_gtk_statusbar_new"
  external get_context : [>`statusbar] obj -> string -> statusbar_context
      = "ml_gtk_statusbar_get_context_id"
  external push :
      [>`statusbar] obj ->
      statusbar_context -> text:string -> statusbar_message
      = "ml_gtk_statusbar_push"
  external pop : [>`statusbar] obj -> statusbar_context ->  unit
      = "ml_gtk_statusbar_pop"
  external remove :
      [>`statusbar] obj -> statusbar_context -> statusbar_message -> unit
      = "ml_gtk_statusbar_remove"
  module Signals = struct
    open GtkSignal
    let text_pushed : ([>`statusbar],_) t =
      let marshal f argv =
	f (Obj.magic (GtkArgv.get_int argv ~pos:0) : statusbar_context)
	  (GtkArgv.get_string argv ~pos:1)
      in
      { name = "text_pushed"; marshaller = marshal }
  end
end

module Calendar = struct
  let cast w : calendar obj = Object.try_cast w "GtkCalendar"
  external create : unit -> calendar obj = "ml_gtk_calendar_new"
  external select_month : [>`calendar] obj -> month:int -> year:int -> unit
      = "ml_gtk_calendar_select_month"
  external select_day : [>`calendar] obj -> int -> unit
      = "ml_gtk_calendar_select_day"
  external mark_day : [>`calendar] obj -> int -> unit
      = "ml_gtk_calendar_mark_day"
  external unmark_day : [>`calendar] obj -> int -> unit
      = "ml_gtk_calendar_unmark_day"
  external clear_marks : [>`calendar] obj -> unit
      = "ml_gtk_calendar_clear_marks"
  external display_options :
      [>`calendar] obj -> Tags.calendar_display_options list -> unit
      = "ml_gtk_calendar_display_options"
  external get_date : [>`calendar] obj -> int * int * int
      = "ml_gtk_calendar_get_date"   (* year * month * day *)
  external freeze : [>`calendar] obj -> unit
      = "ml_gtk_calendar_freeze"
  external thaw : [>`calendar] obj -> unit
      = "ml_gtk_calendar_thaw"
  module Signals = struct
    open GtkSignal
    let month_changed : ([>`calendar],_) t =
      { name = "month_changed"; marshaller = marshal_unit }
    let day_selected : ([>`calendar],_) t =
      { name = "day_selected"; marshaller = marshal_unit }
    let day_selected_double_click : ([>`calendar],_) t =
      { name = "day_selected_double_click"; marshaller = marshal_unit }
    let prev_month : ([>`calendar],_) t =
      { name = "prev_month"; marshaller = marshal_unit }
    let next_month : ([>`calendar],_) t =
      { name = "next_month"; marshaller = marshal_unit }
    let prev_year : ([>`calendar],_) t =
      { name = "prev_year"; marshaller = marshal_unit }
    let next_year : ([>`calendar],_) t =
      { name = "next_year"; marshaller = marshal_unit }
  end
end

module DrawingArea = struct
  let cast w : drawing_area obj = Object.try_cast w "GtkDrawingArea"
  external create : unit -> drawing_area obj = "ml_gtk_drawing_area_new"
  external size : [>`drawing] obj -> width:int -> height:int -> unit
      = "ml_gtk_drawing_area_size"
end

(* Does not seem very useful ...
module Curve = struct
  type t = [widget drawing curve] obj
  let cast w : t = Object.try_cast w "GtkCurve"
  external create : unit -> t = "ml_gtk_curve_new"
  external reset : [>`curve] obj -> unit = "ml_gtk_curve_reset"
  external set_gamma : [>`curve] obj -> float -> unit
      = "ml_gtk_curve_set_gamma"
  external set_range :
      [>`curve] obj -> min_x:float -> max_x:float ->
      min_y:float -> max_y:float -> unit
      = "ml_gtk_curve_set_gamma"
end
*)

module Misc = struct
  let cast w : misc obj = Object.try_cast w "GtkMisc"
  external coerce : [>`misc] obj -> misc obj = "%identity"
  external set_alignment : [>`misc] obj -> x:float -> y:float -> unit
      = "ml_gtk_misc_set_alignment"
  external set_padding : [>`misc] obj -> x:int -> y:int -> unit
      = "ml_gtk_misc_set_padding"
  external get_xalign : [>`misc] obj -> float = "ml_gtk_misc_get_xalign"
  external get_yalign : [>`misc] obj -> float = "ml_gtk_misc_get_yalign"
  external get_xpad : [>`misc] obj -> int = "ml_gtk_misc_get_xpad"
  external get_ypad : [>`misc] obj -> int = "ml_gtk_misc_get_ypad"
  let set_alignment w ?x ?y () =
    set_alignment w ~x:(may_default get_xalign w ~opt:x)
      ~y:(may_default get_yalign w ~opt:y)
  let set_padding w ?x ?y () =
    set_padding w ~x:(may_default get_xpad w ~opt:x)
      ~y:(may_default get_ypad w ~opt:y)
  let set ?xalign ?yalign ?xpad ?ypad ?(width = -2) ?(height = -2) w =
    if xalign <> None || yalign <> None then
      set_alignment w ?x:xalign ?y:yalign ();
    if xpad <> None || ypad <> None then
      set_padding w ?x:xpad ?y:ypad ();
    if width <> -2 || height <> -2 then Widget.set_usize w ~width ~height
end

module Arrow = struct
  let cast w : arrow obj = Object.try_cast w "GtkArrow"
  external create : kind:arrow_type -> shadow:shadow_type -> arrow obj
      = "ml_gtk_arrow_new"
  external set : [>`arrow] obj -> kind:arrow_type -> shadow:shadow_type -> unit
      = "ml_gtk_arrow_set"
end

module Image = struct
  let cast w : image obj = Object.try_cast w "GtkImage"
  external create : Gdk.image -> ?mask:Gdk.bitmap -> image obj
      = "ml_gtk_image_new"
  let create ?mask img = create img ?mask
  external set : [>`image] obj -> Gdk.image -> ?mask:Gdk.bitmap -> unit
      = "ml_gtk_image_set"
end

module Label = struct
  let cast w : label obj = Object.try_cast w "GtkLabel"
  external coerce : [>`label] obj -> label obj = "%identity"
  external create : string -> label obj = "ml_gtk_label_new"
  external set_text : [>`label] obj -> string -> unit = "ml_gtk_label_set_text"
  external set_justify : [>`label] obj -> justification -> unit
      = "ml_gtk_label_set_justify"
  external set_pattern : [>`label] obj -> string -> unit
      = "ml_gtk_label_set_pattern"
  external set_line_wrap : [>`label] obj -> bool -> unit
      = "ml_gtk_label_set_line_wrap"
  let set ?text ?justify ?line_wrap ?pattern w =
    may ~f:(set_text w) text;
    may ~f:(set_justify w) justify;
    may ~f:(set_line_wrap w) line_wrap;
    may ~f:(set_pattern w) pattern
  external get_text : [>`label] obj -> string = "ml_gtk_label_get_label"
end

module TipsQuery = struct
  let cast w : tips_query obj = Object.try_cast w "GtkTipsQuery"
  external create : unit -> tips_query obj = "ml_gtk_tips_query_new"
  external start : [>`tipsquery] obj -> unit = "ml_gtk_tips_query_start_query"
  external stop : [>`tipsquery] obj -> unit = "ml_gtk_tips_query_stop_query"
  external set_caller : [>`tipsquery] obj -> [>`widget] obj -> unit
      = "ml_gtk_tips_query_set_caller"
  external set_labels :
      [>`tipsquery] obj -> inactive:string -> no_tip:string -> unit
      = "ml_gtk_tips_query_set_labels"
  external set_emit_always : [>`tipsquery] obj -> bool -> unit
      = "ml_gtk_tips_query_set_emit_always"
  external get_caller : [>`tipsquery] obj -> widget obj
      = "ml_gtk_tips_query_get_caller"
  external get_label_inactive : [>`tipsquery] obj -> string
      = "ml_gtk_tips_query_get_label_inactive"
  external get_label_no_tip : [>`tipsquery] obj -> string
      = "ml_gtk_tips_query_get_label_no_tip"
  external get_emit_always : [>`tipsquery] obj -> bool
      = "ml_gtk_tips_query_get_emit_always"
  let set_labels ?inactive ?no_tip w =
    set_labels w
      ~inactive:(may_default get_label_inactive w ~opt:inactive)
      ~no_tip:(may_default get_label_no_tip w ~opt:no_tip)
  let set ?caller ?emit_always ?label_inactive ?label_no_tip w =
    may caller ~f:(set_caller w);
    may emit_always ~f:(set_emit_always w);
    if label_inactive <> None || label_no_tip <> None then
      set_labels w ?inactive:label_inactive ?no_tip:label_no_tip
  module Signals = struct
    open GtkSignal
    let start_query : ([>`tipsquery],_) t =
      { name = "start_query"; marshaller = marshal_unit }
    let stop_query : ([>`tipsquery],_) t =
      { name = "stop_query"; marshaller = marshal_unit }
    let widget_entered :
	([>`tipsquery],
	 widget obj option ->
	 text:string option -> privat:string option -> unit) t =
      let marshal f argv =
	f (may_map ~f:Widget.cast (GtkArgv.get_object argv ~pos:0))
	  ~text:(GtkArgv.get_string argv ~pos:1)
	  ~privat:(GtkArgv.get_string argv ~pos:2)
      in
      { name = "widget_entered"; marshaller = marshal }
    let widget_selected :
	([>`tipsquery],
	 widget obj option ->
	 text:string option ->
	 privat:string option -> GdkEvent.Button.t option -> bool) t =
      let marshal f argv =
	let stop = 
	  f (may_map ~f:Widget.cast (GtkArgv.get_object argv ~pos:0))
	    ~text:(GtkArgv.get_string argv ~pos:1)
	    ~privat:(GtkArgv.get_string argv ~pos:2)
	    (may_map ~f:GdkEvent.unsafe_copy
	       (GtkArgv.get_pointer argv ~pos:3)) in
	GtkArgv.set_result_bool argv stop in
      { name = "widget_selected"; marshaller = marshal }
  end
end

module Pixmap = struct
  let cast w : pixmap obj = Object.try_cast w "GtkPixmap"
  external create : Gdk.pixmap -> ?mask:Gdk.bitmap -> pixmap obj
      = "ml_gtk_pixmap_new"
  let create ?mask img = create img ?mask
  external set :
      [>`pixmap] obj -> ?pixmap:Gdk.pixmap -> ?mask:Gdk.bitmap -> unit
      = "ml_gtk_pixmap_set"
  external pixmap : [>`pixmap] obj -> Gdk.pixmap = "ml_GtkPixmap_pixmap"
  external mask : [>`pixmap] obj -> Gdk.bitmap = "ml_GtkPixmap_mask"
end

module Separator = struct
  let cast w : separator obj = Object.try_cast w "GtkSeparator"
  external hseparator_new : unit -> separator obj = "ml_gtk_hseparator_new"
  external vseparator_new : unit -> separator obj = "ml_gtk_vseparator_new"
  let create (dir : Tags.orientation) =
    if dir = `HORIZONTAL then hseparator_new () else vseparator_new ()
end

module FontSelection = struct
  type null_terminated
  let null_terminated arg : null_terminated =
    match arg with None -> Obj.magic Gpointer.raw_null
    | Some l ->
	let len = List.length l in
	let arr = Array.create (len + 1) "" in
	let rec loop i = function
	    [] -> arr.(i) <- Obj.magic Gpointer.raw_null
	  | s::l -> arr.(i) <- s; loop (i+1) l
	in loop 0 l;
	Obj.magic (arr : string array)
  let cast w : font_selection obj =
    Object.try_cast w "GtkFontSelection"
  external create : unit -> font_selection obj
      = "ml_gtk_font_selection_new"
  external get_font : [>`fontsel] obj -> Gdk.font
      = "ml_gtk_font_selection_get_font"
  let get_font w =
    try Some (get_font w) with Gpointer.Null -> None
  external get_font_name : [>`fontsel] obj -> string
      = "ml_gtk_font_selection_get_font_name"
  let get_font_name w =
    try Some (get_font_name w) with Gpointer.Null -> None
  external set_font_name : [>`fontsel] obj -> string -> unit
      = "ml_gtk_font_selection_set_font_name"
  external set_filter :
    [>`fontsel] obj -> font_filter_type -> font_type list ->
    null_terminated -> null_terminated -> null_terminated ->
    null_terminated -> null_terminated -> null_terminated -> unit
    = "ml_gtk_font_selection_set_filter_bc"
      "ml_gtk_font_selection_set_filter"
  let set_filter w ?kind:(tl=[`ALL]) ?foundry
      ?weight ?slant ?setwidth ?spacing ?charset filter =
    set_filter w filter tl (null_terminated foundry)
      (null_terminated weight) (null_terminated slant)
      (null_terminated setwidth) (null_terminated spacing)
      (null_terminated charset)
  external get_preview_text : [>`fontsel] obj -> string
      = "ml_gtk_font_selection_get_preview_text"
  external set_preview_text : [>`fontsel] obj -> string -> unit
      = "ml_gtk_font_selection_set_preview_text"
end

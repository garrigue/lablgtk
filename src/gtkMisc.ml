(* $Id$ *)

open Gaux
open Gobject
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
    let color_changed =
      { name = "color_changed"; classe = `colorsel; marshaller = marshal_unit }
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
    let text_pushed =
      let marshal f _ = function
        | `INT ctx :: `STRING s :: _ ->
	    f (Obj.magic ctx : statusbar_context) s
        | _ -> invalid_arg "GtkMisc.Statusbar.Signals.marshal_text"
      in
      { name = "text_pushed"; classe = `statusbar; marshaller = marshal }
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
    let month_changed =
      { name = "month_changed"; classe = `calendar; marshaller = marshal_unit }
    let day_selected =
      { name = "day_selected"; classe = `calendar; marshaller = marshal_unit }
    let day_selected_double_click =
      { name = "day_selected_double_click"; classe = `calendar; marshaller = marshal_unit }
    let prev_month =
      { name = "prev_month"; classe = `calendar; marshaller = marshal_unit }
    let next_month =
      { name = "next_month"; classe = `calendar; marshaller = marshal_unit }
    let prev_year =
      { name = "prev_year"; classe = `calendar; marshaller = marshal_unit }
    let next_year =
      { name = "next_year"; classe = `calendar; marshaller = marshal_unit }
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
  external create : unit -> image obj
      = "ml_gtk_image_new"
  external set_image : [>`image] obj -> Gdk.image -> ?mask:Gdk.bitmap -> unit
      = "ml_gtk_image_set_from_image"
  external set_pixmap : [>`image] obj -> Gdk.pixmap -> ?mask:Gdk.bitmap -> unit
      = "ml_gtk_image_set_from_pixmap"
  external set_file : [>`image] obj -> string -> unit
      = "ml_gtk_image_set_from_file"
  external set_pixbuf : [>`image] obj -> GdkPixbuf.pixbuf -> unit
      = "ml_gtk_image_set_from_pixbuf"
  external set_stock : [>`image] obj -> string -> size:int -> unit
      = "ml_gtk_image_set_from_stock"
  let from_image ?mask img =
    let w = create () in set_image w img ?mask; w
  let from_pixmap ?mask img =
    let w = create () in set_pixmap w img ?mask; w
  let from_file s =
    let w = create () in set_file w s; w
  let from_pixbuf s =
    let w = create () in set_pixbuf w s; w
  let from_stock s ~size =
    let w = create () in set_stock w s ~size; w
end

module Label = struct
  let cast w : label obj = Object.try_cast w "GtkLabel"
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
    let start_query =
      { name = "start_query"; classe = `tipsquery; marshaller = marshal_unit }
    let stop_query =
      { name = "stop_query"; classe = `tipsquery; marshaller = marshal_unit }
    let widget_entered :
	([>`tipsquery],
	 widget obj option ->
	 text:string option -> privat:string option -> unit) t =
      let marshal f _ = function
        | `OBJECT opt :: `STRING text :: `STRING privat :: _ ->
	    f (may_map ~f:Widget.cast opt) ~text ~privat
        | _ -> invalid_arg "GtkMisc.TipsQuery.Signals.marshal_entered"
      in
      { name = "widget_entered"; classe = `tipsquery; marshaller = marshal }
    let widget_selected :
	([>`tipsquery],
	 widget obj option ->
	 text:string option ->
	 privat:string option -> GdkEvent.Button.t option -> bool) t =
      let marshal f argv = function
        | `OBJECT obj :: `STRING text :: `STRING privat :: `POINTER p :: _ ->
	    let stop = 
	      f (may_map ~f:Widget.cast obj) ~text ~privat
	        (may_map ~f:GdkEvent.unsafe_copy p)
            in Closure.set_result argv (`BOOL stop)
        | _ -> invalid_arg "GtkMisc.TipsQuery.Signals.marshal_selected"
      in
      { name = "widget_selected"; classe = `tipsquery; marshaller = marshal }
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
  external get_preview_text : [>`fontsel] obj -> string
      = "ml_gtk_font_selection_get_preview_text"
  external set_preview_text : [>`fontsel] obj -> string -> unit
      = "ml_gtk_font_selection_set_preview_text"
end

module Preview = struct
  external create : Tags.preview_type -> preview obj
    = "ml_gtk_preview_new"
  external put : 
    [>`preview] obj -> Gdk.window -> Gdk.gc -> 
    xsrc:int -> ysrc:int -> xdest:int -> ydest:int ->
    width:int -> height:int -> unit
    = "ml_gtk_preview_put_bc" "ml_gtk_preview_put"
  let put w  ?(xsrc = 0) ?(ysrc = 0) ?(xdest = 0) ?(ydest = 0) 
    ?(width= -1) ?(height= -1) gdkwin gc =
    put w gdkwin gc ~xsrc ~ysrc ~xdest ~ydest ~width ~height
  external draw_row :
    [>`preview] obj -> data:int array -> x:int -> y:int -> unit
    = "ml_gtk_preview_draw_row"
  external set_size : [>`preview] obj -> width:int -> height:int -> unit
    = "ml_gtk_preview_size"
  external set_expand : [>`preview] obj -> bool -> unit
    = "ml_gtk_preview_set_expand"
  external set_dither : [>`preview] obj -> Gdk.Tags.rgb_dither -> unit
    = "ml_gtk_preview_set_dither"
  external set_gamma : float -> unit
    = "ml_gtk_preview_set_gamma"
end

(* $Id$ *)

open Gaux
open Gobject
open Gtk
open Tags
open GtkProps
open GtkBase

external _gtkmisc_init : unit -> unit = "ml_gtkmisc_init"
let () = _gtkmisc_init ()

module GammaCurve = struct
  include GammaCurve
  external get_gamma : [>`gamma] obj -> float = "ml_gtk_gamma_curve_get_gamma"
end

module ColorSelection = struct
  include ColorSelection
  module Signals = struct
    open GtkSignal
    let color_changed =
      { name = "color_changed"; classe = `colorselection;
        marshaller = marshal_unit }
  end
end

module Statusbar = struct
  include Statusbar
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
  include Misc
  let all_params ~cont =
    make_params ~cont:(Widget.size_params ~cont)
end

module Arrow = Arrow

module Image = Image

module Label = Label

module TipsQuery = struct
  include TipsQuery
  external start : [>`tipsquery] obj -> unit = "ml_gtk_tips_query_start_query"
  external stop : [>`tipsquery] obj -> unit = "ml_gtk_tips_query_stop_query"
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

module Separator = struct
  include Separator
  let create (dir : Tags.orientation) pl =
    Object.make
      (if dir = `HORIZONTAL then "GtkHSeparator" else "GtkVSeparator") pl
end

module FontSelection = FontSelection

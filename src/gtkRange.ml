(* $Id$ *)

open Gaux
open Gtk
open Tags
open GtkBase

module Progress = struct
  let cast w : progress obj = Object.try_cast w "GtkProgress"
  external set_show_text : [>`progress] obj -> bool -> unit
      = "ml_gtk_progress_set_show_text"
  external set_text_alignment :
      [>`progress] obj -> ?x:float -> ?y:float -> unit -> unit
      = "ml_gtk_progress_set_show_text"
  external set_format_string : [>`progress] obj -> string -> unit
      = "ml_gtk_progress_set_format_string"
  external set_adjustment : [>`progress] obj -> [>`adjustment] obj -> unit
      = "ml_gtk_progress_set_adjustment"
  external configure :
      [>`progress] obj -> current:float -> min:float -> max:float -> unit
      = "ml_gtk_progress_configure"
  external set_percentage : [>`progress] obj -> float -> unit
      = "ml_gtk_progress_set_percentage"
  external set_value : [>`progress] obj -> float -> unit
      = "ml_gtk_progress_set_value"
  external get_value : [>`progress] obj -> float
      = "ml_gtk_progress_get_value"
  external get_percentage : [>`progress] obj -> float
      = "ml_gtk_progress_get_current_percentage"
  external set_activity_mode : [>`progress] obj -> bool -> unit
      = "ml_gtk_progress_set_activity_mode"
  external get_current_text : [>`progress] obj -> string
      = "ml_gtk_progress_get_current_text"
  external get_adjustment : [>`progress] obj -> adjustment obj
      = "ml_gtk_progress_get_adjustment"
  let set ?value ?percentage ?activity_mode
      ?show_text ?format_string ?text_xalign ?text_yalign w =
    may value ~f:(set_value w);
    may percentage ~f:(set_percentage w);
    may activity_mode ~f:(set_activity_mode w);
    may show_text ~f:(set_show_text w);
    may format_string ~f:(set_format_string w);
    if text_xalign <> None || text_yalign <> None then
      set_text_alignment w ?x:text_xalign ?y:text_yalign ()
end

module ProgressBar = struct
  let cast w : progress_bar obj = Object.try_cast w "GtkProgressBar"
  external create : unit -> progress_bar obj = "ml_gtk_progress_bar_new"
  external create_with_adjustment : [>`adjustment] obj -> progress_bar obj
      = "ml_gtk_progress_bar_new_with_adjustment"
  external set_bar_style :
      [>`progressbar] obj -> [`CONTINUOUS|`DISCRETE] -> unit
      = "ml_gtk_progress_bar_set_bar_style"
  external set_discrete_blocks : [>`progressbar] obj -> int -> unit
      = "ml_gtk_progress_bar_set_discrete_blocks"
  external set_activity_step : [>`progressbar] obj -> int -> unit
      = "ml_gtk_progress_bar_set_activity_step"
  external set_activity_blocks : [>`progressbar] obj -> int -> unit
      = "ml_gtk_progress_bar_set_activity_blocks"
  external set_orientation :
      [>`progressbar] obj -> Tags.progress_bar_orientation -> unit
      = "ml_gtk_progress_bar_set_orientation"
  let set ?bar_style ?discrete_blocks ?activity_step ?activity_blocks w =
    let may_set f opt = may opt ~f:(f w) in
    may_set set_bar_style bar_style;
    may_set set_discrete_blocks discrete_blocks;
    may_set set_activity_step activity_step;
    may_set set_activity_blocks activity_blocks
end

module Range = struct
  let cast w : range obj = Object.try_cast w "GtkRange"
  external get_adjustment : [>`range] obj -> adjustment obj
      = "ml_gtk_range_get_adjustment"
  external set_adjustment : [>`range] obj -> [>`adjustment] obj -> unit
      = "ml_gtk_range_set_adjustment"
  external set_update_policy : [>`range] obj -> update_type -> unit
      = "ml_gtk_range_set_update_policy"
  let set ?adjustment ?update_policy w =
    may adjustment ~f:(set_adjustment w);
    may update_policy ~f:(set_update_policy w)
end

module Scale = struct
  let cast w : scale obj = Object.try_cast w "GtkScale"
  external hscale_new : [>`adjustment] optobj -> scale obj
      = "ml_gtk_hscale_new"
  external vscale_new : [>`adjustment] optobj -> scale obj
      = "ml_gtk_vscale_new"
  let create ?adjustment (dir : orientation) =
    let create = if dir = `HORIZONTAL then hscale_new else vscale_new  in
    create (Gpointer.optboxed adjustment)
  external set_digits : [>`scale] obj -> int -> unit
      = "ml_gtk_scale_set_digits"
  external set_draw_value : [>`scale] obj -> bool -> unit
      = "ml_gtk_scale_set_draw_value"
  external set_value_pos : [>`scale] obj -> position -> unit
      = "ml_gtk_scale_set_value_pos"
  external get_value_width : [>`scale] obj -> int
      = "ml_gtk_scale_get_value_width"
  external draw_value : [>`scale] obj -> unit
      = "ml_gtk_scale_draw_value"
  let set ?digits ?draw_value ?value_pos w =
    may digits ~f:(set_digits w);
    may draw_value ~f:(set_draw_value w);
    may value_pos ~f:(set_value_pos w)
end

module Scrollbar = struct
  let cast w : scrollbar obj = Object.try_cast w "GtkScrollbar"
  external hscrollbar_new : [>`adjustment] optobj -> scrollbar obj
      = "ml_gtk_hscrollbar_new"
  external vscrollbar_new : [>`adjustment] optobj -> scrollbar obj
      = "ml_gtk_vscrollbar_new"
  let create ?adjustment (dir : orientation) =
    let create = if dir = `HORIZONTAL then hscrollbar_new else vscrollbar_new
    in create (Gpointer.optboxed adjustment)
end

module Ruler = struct
  let cast w : ruler obj = Object.try_cast w "GtkRuler"
  external hruler_new : unit -> ruler obj = "ml_gtk_hruler_new"
  external vruler_new : unit -> ruler obj = "ml_gtk_vruler_new"
  let create (dir : orientation) =
    if dir = `HORIZONTAL then hruler_new () else vruler_new ()
  external set_metric : [>`ruler] obj -> metric_type -> unit
      = "ml_gtk_ruler_set_metric"
  external set_range :
      [>`ruler] obj ->
      lower:float -> upper:float -> position:float -> max_size:float -> unit
      = "ml_gtk_ruler_set_range"
  external get_lower : [>`ruler] obj -> float = "ml_gtk_ruler_get_lower"
  external get_upper : [>`ruler] obj -> float = "ml_gtk_ruler_get_upper"
  external get_position : [>`ruler] obj -> float = "ml_gtk_ruler_get_position"
  external get_max_size : [>`ruler] obj -> float = "ml_gtk_ruler_get_max_size"
  let set_range ?lower ?upper ?position ?max_size w =
    set_range w ~lower:(may_default get_lower w ~opt:lower)
      ~upper:(may_default get_upper w ~opt:upper)
      ~position:(may_default get_position w ~opt:position)
      ~max_size:(may_default get_max_size w ~opt:max_size)
  let set ?metric ?lower ?upper ?position ?max_size w =
    may metric ~f:(set_metric w);
    if lower <> None || upper <> None || position <> None || max_size <> None
    then set_range w ?lower ?upper ?position ?max_size
end

(* $Id$ *)

open Misc
open Gtk
open Tags
open GtkBase

module GammaCurve = struct
  let cast w : gamma_curve obj =
    if Object.is_a w "GtkGammaCurve" then Obj.magic w
    else invalid_arg "Gtk.GammaCurve.cast"
  external create : unit -> gamma_curve obj = "ml_gtk_gamma_curve_new"
  external get_gamma : [> gamma] obj -> float = "ml_gtk_gamma_curve_get_gamma"
end

module ColorSelection = struct
  let cast w : color_selection obj =
    if Object.is_a w "GtkColorSelection" then Obj.magic w
    else invalid_arg "Gtk.ColorSelection.cast"
  external create : unit -> color_selection obj = "ml_gtk_color_selection_new"
  external create_dialog : string -> color_selection_dialog obj
      = "ml_gtk_color_selection_dialog_new"
  external set_update_policy : [> colorsel] obj -> update_type -> unit
      = "ml_gtk_color_selection_set_update_policy"
  external set_opacity : [> colorsel] obj -> bool -> unit
      = "ml_gtk_color_selection_set_opacity"
  let setter w :cont ?:update_policy ?:opacity =
    may update_policy fun:(set_update_policy w);
    may opacity fun:(set_opacity w);
    cont w
  external set_color :
      [> colorsel] obj ->
      red:float -> green:float -> blue:float -> ?opacity:float -> unit
      = "ml_gtk_color_selection_set_color"
  external get_color : [> colorsel] obj -> color
      = "ml_gtk_color_selection_get_color"

  external ok_button : [> colorseldialog] obj -> button obj =
    "ml_gtk_color_selection_dialog_ok_button"
  external cancel_button : [> colorseldialog] obj -> button obj =
    "ml_gtk_color_selection_dialog_cancel_button"
  external help_button : [> colorseldialog] obj -> button obj =
    "ml_gtk_color_selection_dialog_help_button"
  external colorsel : [> colorseldialog] obj -> color_selection obj =
    "ml_gtk_color_selection_dialog_colorsel"
  module Signals = struct
    open GtkSignal
    let color_changed : ([> colorsel],_) t =
      { name = "color_changed"; marshaller = marshal_unit }
  end
end

module Statusbar = struct
  let cast w : statusbar obj =
    if Object.is_a w "GtkStatusbar" then Obj.magic w
    else invalid_arg "Gtk.Statusbar.cast"
  external create : unit -> statusbar obj = "ml_gtk_statusbar_new"
  external get_context : [> statusbar] obj -> string -> statusbar_context
      = "ml_gtk_statusbar_get_context_id"
  external push :
      [> statusbar] obj ->
      statusbar_context -> text:string -> statusbar_message
      = "ml_gtk_statusbar_push"
  external pop : [> statusbar] obj -> statusbar_context ->  unit
      = "ml_gtk_statusbar_pop"
  external remove :
      [> statusbar] obj -> statusbar_context -> statusbar_message -> unit
      = "ml_gtk_statusbar_remove"
  module Signals = struct
    open GtkSignal
    let text_pushed : ([> statusbar],_) t =
      let marshal f argv =
	f (Obj.magic (GtkArgv.get_int argv pos:0) : statusbar_context)
	  (GtkArgv.get_string argv pos:1)
      in
      { name = "text_pushed"; marshaller = marshal }
  end
end

module Notebook = struct
  let cast w : notebook obj =
    if Object.is_a w "GtkNotebook" then Obj.magic w
    else invalid_arg "Gtk.Notebook.cast"
  external create : unit -> notebook obj = "ml_gtk_notebook_new"
  external insert_page :
      [> notebook] obj -> [> widget] obj -> tab_label:[> widget] optobj ->
      menu_label:[> widget] optobj -> pos:int -> unit
      = "ml_gtk_notebook_insert_page_menu"
      (* default is append to end *)
  external remove_page : [> notebook] obj -> int -> unit
      = "ml_gtk_notebook_remove_page"
  external get_current_page : [> notebook] obj -> int
      = "ml_gtk_notebook_get_current_page"
  external set_page : [> notebook] obj -> int -> unit
      = "ml_gtk_notebook_set_page"
  external set_tab_pos : [> notebook] obj -> position -> unit
      = "ml_gtk_notebook_set_tab_pos"
  external set_homogeneous_tabs : [> notebook] obj -> bool -> unit
      = "ml_gtk_notebook_set_homogeneous_tabs"
  external set_show_tabs : [> notebook] obj -> bool -> unit
      = "ml_gtk_notebook_set_show_tabs"
  external set_show_border : [> notebook] obj -> bool -> unit
      = "ml_gtk_notebook_set_show_border"
  external set_scrollable : [> notebook] obj -> bool -> unit
      = "ml_gtk_notebook_set_scrollable"
  external set_tab_border : [> notebook] obj -> int -> unit
      = "ml_gtk_notebook_set_tab_border"
  external popup_enable : [> notebook] obj -> unit
      = "ml_gtk_notebook_popup_enable"
  external popup_disable : [> notebook] obj -> unit
      = "ml_gtk_notebook_popup_disable"
  external get_nth_page : [> notebook] obj -> int -> widget obj
      = "ml_gtk_notebook_get_nth_page"
  external page_num : [> notebook] obj -> [> widget] obj -> int
      = "ml_gtk_notebook_page_num"
  external next_page : [> notebook] obj -> unit
      = "ml_gtk_notebook_next_page"
  external prev_page : [> notebook] obj -> unit
      = "ml_gtk_notebook_prev_page"
  external get_tab_label : [> notebook] obj -> [> widget] obj -> widget obj
      = "ml_gtk_notebook_get_tab_label"
  external set_tab_label :
      [> notebook] obj -> [> widget] obj -> [> widget] obj -> unit
      = "ml_gtk_notebook_set_tab_label"
  external get_menu_label : [> notebook] obj -> [> widget] obj -> widget obj
      = "ml_gtk_notebook_get_menu_label"
  external set_menu_label :
      [> notebook] obj -> [> widget] obj -> [> widget] obj -> unit
      = "ml_gtk_notebook_set_menu_label"
  external reorder_child : [> notebook] obj -> [> widget] obj -> int -> unit
      = "ml_gtk_notebook_reorder_child"

  let setter w :cont ?:page ?:tab_pos ?:show_tabs ?:homogeneous_tabs
      ?:show_border ?:scrollable ?:tab_border ?:popup =
    let may_set f = may fun:(f w) in
    may_set set_page page;
    may_set set_tab_pos tab_pos;
    may_set set_show_tabs show_tabs;
    may_set set_homogeneous_tabs homogeneous_tabs;
    may_set set_show_border show_border;
    may_set set_scrollable scrollable;
    may_set set_tab_border tab_border;
    may popup fun:(fun b -> (if b then popup_enable else popup_disable) w);
    cont w
  module Signals = struct
    open GtkSignal
    let switch_page : ([> notebook],_) t =
      let marshal f argv = f (GtkArgv.get_int argv pos:1) in
      { name = "switch_page"; marshaller = marshal }
  end
end

module Calendar = struct
  let cast w : calendar obj =
    if Object.is_a w "GtkCalendar" then Obj.magic w
    else invalid_arg "Gtk.Calendar.cast"
  external create : unit -> calendar obj = "ml_gtk_calendar_new"
  external select_month : [> calendar] obj -> month:int -> year:int -> unit
      = "ml_gtk_calendar_select_month"
  external select_day : [> calendar] obj -> int -> unit
      = "ml_gtk_calendar_select_day"
  external mark_day : [> calendar] obj -> int -> unit
      = "ml_gtk_calendar_mark_day"
  external unmark_day : [> calendar] obj -> int -> unit
      = "ml_gtk_calendar_unmark_day"
  external clear_marks : [> calendar] obj -> unit
      = "ml_gtk_calendar_clear_marks"
  external display_options :
      [> calendar] obj -> Tags.calendar_display_options list -> unit
      = "ml_gtk_calendar_display_options"
  external get_date : [> calendar] obj -> int * int * int
      = "ml_gtk_calendar_get_date"   (* year * month * day *)
  external freeze : [> calendar] obj -> unit
      = "ml_gtk_calendar_freeze"
  external thaw : [> calendar] obj -> unit
      = "ml_gtk_calendar_thaw"
  module Signals = struct
    open GtkSignal
    let month_changed : ([> calendar],_) t =
      { name = "month_changed"; marshaller = marshal_unit }
    let day_selected : ([> calendar],_) t =
      { name = "day_selected"; marshaller = marshal_unit }
    let day_selected_double_click : ([> calendar],_) t =
      { name = "day_selected_double_click"; marshaller = marshal_unit }
    let prev_month : ([> calendar],_) t =
      { name = "prev_month"; marshaller = marshal_unit }
    let next_month : ([> calendar],_) t =
      { name = "next_month"; marshaller = marshal_unit }
    let prev_year : ([> calendar],_) t =
      { name = "prev_year"; marshaller = marshal_unit }
    let next_year : ([> calendar],_) t =
      { name = "next_year"; marshaller = marshal_unit }
  end
end

module DrawingArea = struct
  let cast w : drawing_area obj =
    if Object.is_a w "GtkDrawingArea" then Obj.magic w
    else invalid_arg "Gtk.DrawingArea.cast"
  external create : unit -> drawing_area obj = "ml_gtk_drawing_area_new"
  external size : [> drawing] obj -> width:int -> height:int -> unit
      = "ml_gtk_drawing_area_size"
end

(* Does not seem very useful ...
module Curve = struct
  type t = [widget drawing curve] obj
  let cast w : t =
    if Object.is_a w "GtkCurve" then Obj.magic w
    else invalid_arg "Gtk.Curve.cast"
  external create : unit -> t = "ml_gtk_curve_new"
  external reset : [> curve] obj -> unit = "ml_gtk_curve_reset"
  external set_gamma : [> curve] obj -> float -> unit
      = "ml_gtk_curve_set_gamma"
  external set_range :
      [> curve] obj -> min_x:float -> max_x:float ->
      min_y:float -> max_y:float -> unit
      = "ml_gtk_curve_set_gamma"
end
*)

module Misc = struct
  let cast w : misc obj =
    if Object.is_a w "GtkMisc" then Obj.magic w
    else invalid_arg "Gtk.Misc.cast"
  external coerce : [> misc] obj -> misc obj = "%identity"
  external set_alignment : [> misc] obj -> x:float -> y:float -> unit
      = "ml_gtk_misc_set_alignment"
  external set_padding : [> misc] obj -> x:int -> y:int -> unit
      = "ml_gtk_misc_set_padding"
  external get_xalign : [> misc] obj -> float = "ml_gtk_misc_get_xalign"
  external get_yalign : [> misc] obj -> float = "ml_gtk_misc_get_yalign"
  external get_xpad : [> misc] obj -> int = "ml_gtk_misc_get_xpad"
  external get_ypad : [> misc] obj -> int = "ml_gtk_misc_get_ypad"
  let setter w :cont ?:xalign ?:yalign ?:xpad ?:ypad =
    if xalign <> None || yalign <> None then
      set_alignment w x:(may_default get_xalign w for:xalign)
	y:(may_default get_yalign w for:yalign);
    if xpad <> None || ypad <> None then
      set_padding w x:(may_default get_xpad w for:xpad)
	y:(may_default get_ypad w for:ypad);
    cont w
  let set = setter ?cont:Widget.set_size
end

module Arrow = struct
  let cast w : arrow obj =
    if Object.is_a w "GtkArrow" then Obj.magic w
    else invalid_arg "Gtk.Arrow.cast"
  external create : type:arrow_type -> shadow:shadow_type -> arrow obj
      = "ml_gtk_arrow_new"
  external set : [> arrow] obj -> type:arrow_type -> shadow:shadow_type -> unit
      = "ml_gtk_arrow_set"
end

module Image = struct
  let cast w : image obj =
    if Object.is_a w "GtkImage" then Obj.magic w
    else invalid_arg "Gtk.Image.cast"
  external create : Gdk.image -> ?mask:Gdk.bitmap -> image obj
      = "ml_gtk_image_new"
  external set : [> image] obj -> Gdk.image -> ?mask:Gdk.bitmap -> unit
      = "ml_gtk_image_set"
end

module Label = struct
  let cast w : label obj =
    if Object.is_a w "GtkLabel" then Obj.magic w
    else invalid_arg "Gtk.Label.cast"
  external coerce : [> label] obj -> label obj = "%identity"
  external create : string -> label obj = "ml_gtk_label_new"
  external set_text : [> label] obj -> string -> unit = "ml_gtk_label_set_text"
  external set_justify : [> label] obj -> justification -> unit
      = "ml_gtk_label_set_justify"
  external set_pattern : [> label] obj -> string -> unit
      = "ml_gtk_label_set_pattern"
  external set_line_wrap : [> label] obj -> bool -> unit
      = "ml_gtk_label_set_line_wrap"
  let setter w :cont ?:text ?:justify ?:line_wrap ?:pattern =
    may fun:(set_text w) text;
    may fun:(set_justify w) justify;
    may fun:(set_line_wrap w) line_wrap;
    may fun:(set_pattern w) pattern;
    cont w
  external get_text : [> label] obj -> string = "ml_gtk_label_get_label"
end

module TipsQuery = struct
  let cast w : tips_query obj =
    if Object.is_a w "GtkTipsQuery" then Obj.magic w
    else invalid_arg "Gtk.TipsQuery.cast"
  external create : unit -> tips_query obj = "ml_gtk_tips_query_new"
  external start : [> tipsquery] obj -> unit = "ml_gtk_tips_query_start_query"
  external stop : [> tipsquery] obj -> unit = "ml_gtk_tips_query_stop_query"
  external set_caller : [> tipsquery] obj -> [> widget] obj -> unit
      = "ml_gtk_tips_query_set_caller"
  external set_labels :
      [> tipsquery] obj -> inactive:string -> no_tip:string -> unit
      = "ml_gtk_tips_query_set_labels"
  external set_emit_always : [> tipsquery] obj -> bool -> unit
      = "ml_gtk_tips_query_set_emit_always"
  external get_caller : [> tipsquery] obj -> widget obj
      = "ml_gtk_tips_query_get_caller"
  external get_label_inactive : [> tipsquery] obj -> string
      = "ml_gtk_tips_query_get_label_inactive"
  external get_label_no_tip : [> tipsquery] obj -> string
      = "ml_gtk_tips_query_get_label_no_tip"
  external get_emit_always : [> tipsquery] obj -> bool
      = "ml_gtk_tips_query_get_emit_always"
  let setter w :cont ?:caller ?:emit_always ?:label_inactive ?:label_no_tip =
    may caller fun:(set_caller w);
    may emit_always fun:(set_emit_always w);
    if label_inactive <> None || label_no_tip <> None then
      set_labels w
	inactive:(may_default get_label_inactive w for:label_inactive)
	no_tip:(may_default get_label_no_tip w for:label_no_tip);
    cont w
  module Signals = struct
    open GtkSignal
    let start_query : ([> tipsquery],_) t =
      { name = "start_query"; marshaller = marshal_unit }
    let stop_query : ([> tipsquery],_) t =
      { name = "stop_query"; marshaller = marshal_unit }
    let widget_entered :
	([> tipsquery],
	 widget obj option-> string option -> string option -> unit) t =
      let marshal f argv =
	f (try Some (Widget.cast (GtkArgv.get_object argv pos:0))
	   with Null_pointer -> None)
	  (try Some(GtkArgv.get_string argv pos:1) with Null_pointer -> None)
	  (try Some(GtkArgv.get_string argv pos:2) with Null_pointer -> None)
      in
      { name = "widget_entered"; marshaller = marshal }
    let widget_selected :
	([> tipsquery],
	 widget obj option ->
	 string option -> string option -> GdkEvent.Button.t -> bool) t =
      let marshal f argv =
	let stop = 
	  f (try Some (Widget.cast (GtkArgv.get_object argv pos:0))
	     with Null_pointer -> None)
	    (try Some(GtkArgv.get_string argv pos:1) with Null_pointer -> None)
	    (try Some(GtkArgv.get_string argv pos:2) with Null_pointer -> None)
	    (GdkEvent.unsafe_copy (GtkArgv.get_pointer argv pos:3)) in
	GtkArgv.set_result_bool argv stop in
      { name = "widget_selected"; marshaller = marshal }
  end
end

module Pixmap = struct
  let cast w : pixmap obj =
    if Object.is_a w "GtkPixmap" then Obj.magic w
    else invalid_arg "Gtk.Pixmap.cast"
  external create : Gdk.pixmap -> ?mask:Gdk.bitmap -> pixmap obj
      = "ml_gtk_pixmap_new"
  external set :
      [> pixmap] obj -> ?pixmap:Gdk.pixmap -> ?mask:Gdk.bitmap -> unit
      = "ml_gtk_pixmap_set"
  let setter w :cont ?:pixmap ?:mask =
    if pixmap <> None || mask <> None then
      set w ?:pixmap ?:mask;
    cont w
  external pixmap : [> pixmap] obj -> Gdk.pixmap = "ml_GtkPixmap_pixmap"
  external mask : [> pixmap] obj -> Gdk.bitmap = "ml_GtkPixmap_mask"
end

module Separator = struct
  let cast w : separator obj =
    if Object.is_a w "GtkSeparator" then Obj.magic w
    else invalid_arg "Gtk.Separator.cast"
  external hseparator_new : unit -> separator obj = "ml_gtk_hseparator_new"
  external vseparator_new : unit -> separator obj = "ml_gtk_vseparator_new"
  let create (dir : Tags.orientation) =
    if dir = `HORIZONTAL then hseparator_new () else vseparator_new ()
end

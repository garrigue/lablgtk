(* $Id$ *)

open Misc
open Gtk
open GtkBase
open GtkRange
open GObj

class progress obj = object
  inherit widget_wrapper obj
  method set_adjustment (adj : GData.adjustment) =
    Progress.set_adjustment obj adj#as_adjustment
  method set_show_text = Progress.set_show_text obj
  method set_format_string = Progress.set_format_string obj
  method set_text_alignment = Progress.set_text_alignment ?obj
  method set_activity_mode = Progress.set_activity_mode obj
  method set_value = Progress.set_value obj
  method set_percentage = Progress.set_percentage obj
  method configure = Progress.configure obj
  method value = Progress.get_value obj
  method percentage = Progress.get_percentage obj
  method current_text = Progress.get_current_text obj
  method adjustment =
    new GData.adjustment_wrapper (Progress.get_adjustment obj)
end

class progress_bar_wrapper obj = object
  inherit progress (obj : Gtk.progress_bar obj)
  method add_events = Widget.add_events obj
  method set_bar_style = ProgressBar.set_bar_style obj
  method set_discrete_blocks = ProgressBar.set_discrete_blocks obj
  method set_activity_step = ProgressBar.set_activity_step obj
  method set_activity_blocks = ProgressBar.set_activity_blocks obj
  method set_orientation = ProgressBar.set_orientation obj
end

class progress_bar ?:adjustment ?:bar_style ?:discrete_blocks
    ?:activity_step ?:activity_blocks ?:value ?:percentage ?:activity_mode
    ?:show_text ?:format_string ?:text_xalign ?:text_yalign ?:packing ?:show =
  let w =
    match adjustment with None -> ProgressBar.create ()
    | Some (adj : GData.adjustment) ->
	ProgressBar.create_with_adjustment adj#as_adjustment
  in
  let () =
    ProgressBar.set w ?:bar_style ?:discrete_blocks
      ?:activity_step ?:activity_blocks;
    Progress.set w ?:value ?:percentage ?:activity_mode
      ?:show_text ?:format_string ?:text_xalign ?:text_yalign
  in
  object (self)
    inherit progress_bar_wrapper w
    initializer pack_return :packing ?:show (self :> progress_bar_wrapper)
  end

class range obj = object
  inherit widget_wrapper obj
  method adjustment = new GData.adjustment_wrapper (Range.get_adjustment obj)
  method set_adjustment (adj : GData.adjustment) =
    Range.set_adjustment obj adj#as_adjustment
  method set_update_policy = Range.set_update_policy obj
end

class scale_wrapper obj = object
  inherit range (obj : scale obj)
  method set_digits = Scale.set_digits obj
  method set_draw_value = Scale.set_draw_value obj
  method set_value_pos = Scale.set_value_pos obj
end

class scale dir ?:adjustment ?:digits ?:draw_value ?:value_pos
    ?:packing ?:show =
  let w =
    Scale.create dir ?adjustment:(GData.adjustment_option adjustment)
  in
  let () = Scale.set w ?:digits ?:draw_value ?:value_pos in
  object (self)
    inherit scale_wrapper w
    initializer pack_return :packing ?:show (self :> scale_wrapper)
  end

class scrollbar_wrapper obj = object
  inherit range (obj : Gtk.scrollbar obj)
  method add_events = Widget.add_events obj
end

class scrollbar dir ?:adjustment ?:update_policy ?:packing ?:show =
  let w = Scrollbar.create dir
      ?adjustment:(GData.adjustment_option adjustment) in
  let () = may update_policy fun:(Range.set_update_policy w) in
  object (self)
    inherit scrollbar_wrapper w
    initializer pack_return :packing ?:show (self :> scrollbar_wrapper)
  end

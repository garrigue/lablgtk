(* $Id$ *)

open Misc
open Gtk
open GtkBase
open GtkRange
open GObj

class progress_bar_wrapper obj = object
  inherit widget_wrapper (obj : Gtk.progress_bar obj)
  method add_events = Widget.add_events obj
  method update percent = ProgressBar.update obj :percent
  method percentage = Progress.get_percentage obj
end

class progress_bar ?:packing ?:show =
  let w = ProgressBar.create () in
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
  method set_display = Scale.setter ?obj ?cont:null_cont
end

class scale dir ?:adjustment ?:digits ?:draw_value ?:value_pos
    ?:packing ?:show =
  let w =
    Scale.create dir ?adjustment:(may_map adjustment fun:GData.adjustment_obj)
  in
  let () = Scale.setter w cont:null_cont ?:digits ?:draw_value ?:value_pos in
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
      ?adjustment:(may_map adjustment fun:GData.adjustment_obj) in
  let () = may update_policy fun:(Range.set_update_policy w) in
  object (self)
    inherit scrollbar_wrapper w
    initializer pack_return :packing ?:show (self :> scrollbar_wrapper)
  end

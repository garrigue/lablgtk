(* $Id$ *)

open Misc
open Gtk
open GUtil
open GObj

class progress_bar_wrapper obj = object
  inherit widget_wrapper (obj : ProgressBar.t obj)
  method update percent = ProgressBar.update obj :percent
  method percentage = Progress.get_percentage obj
end

class progress_bar ?:packing =
  let w = ProgressBar.create () in
  object (self)
    inherit progress_bar_wrapper w
    initializer pack_return :packing (self :> progress_bar_wrapper)
  end

class range obj = object
  inherit widget_wrapper obj
  method adjustment = new GData.adjustment_wrapper (Range.get_adjustment obj)
  method set_adjustment (adj : GData.adjustment) =
    Range.set_adjustment obj adj#as_adjustment
  method set_update_policy = Range.set_update_policy obj
end

class scrollbar_wrapper obj = range (obj : Scrollbar.t obj)

class scrollbar dir ?:adjustment ?:update_policy ?:packing =
  let w = Scrollbar.create dir ?:adjustment in
  let () = may update_policy fun:(Range.set_update_policy w) in
  object (self)
    inherit scrollbar_wrapper w
    initializer pack_return :packing (self :> scrollbar_wrapper)
  end

(* $Id$ *)

open Gaux
open Gtk
open GtkBase
open GtkRange
open GObj

class progress_bar obj = object
  inherit widget_full (obj : Gtk.progress_bar obj)
  method event = new GObj.event_ops obj

  method pulse () = ProgressBar.pulse obj
  method set_text = ProgressBar.set_text obj
  method set_fraction = ProgressBar.set_fraction obj
  method set_pulse_step = ProgressBar.set_pulse_step obj
  method set_orientation = ProgressBar.set_orientation obj
  method get_text = ProgressBar.get_text obj
  method get_fraction = ProgressBar.get_fraction obj
  method get_pulse_step = ProgressBar.get_pulse_step obj
  method get_orientation = ProgressBar.get_orientation obj

end

let progress_bar ?text ?fraction ?pulse_step ?orientation ?packing ?show () =
  let w = ProgressBar.create () in
  ProgressBar.set w ?text ?fraction ?pulse_step ?orientation;
  pack_return (new progress_bar w) ~packing ~show

class range obj = object
  inherit widget_full obj
  method adjustment = new GData.adjustment (Range.get_adjustment obj)
  method set_adjustment adj =
    Range.set_adjustment obj (GData.as_adjustment adj)
  method set_update_policy = Range.set_update_policy obj
end

class scale obj = object
  inherit range (obj : Gtk.scale obj)
  method set_digits = Scale.set_digits obj
  method set_draw_value = Scale.set_draw_value obj
  method set_value_pos = Scale.set_value_pos obj
end

let scale dir ?adjustment ?digits ?draw_value ?value_pos
    ?packing ?show () =
  let w =
    Scale.create dir ?adjustment:(may_map ~f:GData.as_adjustment adjustment)
  in
  let () = Scale.set w ?digits ?draw_value ?value_pos in
  pack_return (new scale w) ~packing ~show

class scrollbar obj = object
  inherit range (obj : Gtk.scrollbar obj)
  method event = new GObj.event_ops obj
end

let scrollbar dir ?adjustment ?update_policy ?packing ?show () =
  let w = Scrollbar.create dir
      ?adjustment:(may_map ~f:GData.as_adjustment adjustment) in
  let () = may update_policy ~f:(Range.set_update_policy w) in
  pack_return (new scrollbar w) ~packing ~show

class ruler obj = object
  inherit widget_full obj
  method set_metric = Ruler.set_metric obj
  method set_range ?lower ?upper ?position ?max_size () =
    Ruler.set_range obj ?lower ?upper ?position ?max_size
  method lower = Ruler.get_lower obj
  method upper = Ruler.get_upper obj
  method position = Ruler.get_position obj
  method max_size = Ruler.get_max_size obj
end

let ruler dir ?metric ?lower ?upper ?position ?max_size ?packing ?show () =
  let w = Ruler.create dir in
  let () = Ruler.set ?metric ?lower ?upper ?position ?max_size w in
  pack_return (new ruler w) ~packing ~show

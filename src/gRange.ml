(* $Id$ *)

open Gaux
open Gtk
open GtkBase
open GtkRange
open OgtkRangeProps
open GObj

class progress_bar obj = object
  inherit [Gtk.progress_bar] widget_impl obj
  method connect = new widget_signals_impl obj
  method event = new GObj.event_ops obj
  inherit progress_bar_props
  method pulse () = ProgressBar.pulse obj
end

let progress_bar =
  ProgressBar.make_params [] ~cont:(fun pl ?packing ?show () ->
    pack_return (new progress_bar (ProgressBar.create pl)) ~packing ~show)

class range_signals obj = object
  inherit widget_signals_impl obj
  inherit range_sigs
end

class range obj = object
  inherit ['a] widget_impl obj
  method connect = new range_signals obj
  method event = new GObj.event_ops obj
  inherit range_props
end

class scale obj = object
  inherit range (obj : Gtk.scale obj)
  inherit scale_props
end

let scale dir ?adjustment =
  Scale.make_params [] ~cont:(
  Range.make_params ?adjustment:(may_map GData.as_adjustment adjustment)
    ~cont:(fun pl ?packing ?show params ->
      pack_return (new scale (Scale.create dir pl)) ~packing ~show))

let scrollbar dir ?adjustment =
  Range.make_params [] ?adjustment:(may_map GData.as_adjustment adjustment)
    ~cont:(fun pl ?packing ?show params ->
      pack_return (new range (Scrollbar.create dir pl)) ~packing ~show)

class ruler obj = object
  inherit ['a] widget_impl obj
  method connect = new widget_signals_impl obj
  method event = new GObj.event_ops obj
  inherit ruler_props
  method set_metric = Ruler.set_metric obj
end

let ruler dir ?metric =
  Ruler.make_params [] ~cont:(fun pl ?packing ?show params ->
    let w = new ruler (Ruler.create dir pl) in
    may w#set_metric metric;
    pack_return w ~packing ~show)

(* $Id$ *)

open Gaux
open Gtk
open Tags
open GtkProps
open GtkBase

external _gtkrange_init : unit -> unit = "ml_gtkrange_init"
let () = _gtkrange_init ()

module ProgressBar = struct
  include ProgressBar
  external pulse : [>`progressbar] obj -> unit = "ml_gtk_progress_bar_pulse"
end

module Range = Range

module Scale = Scale

module Scrollbar = Scrollbar

module Ruler = struct
  include Ruler
  external set_metric : [>`ruler] obj -> metric_type -> unit
      = "ml_gtk_ruler_set_metric"
end

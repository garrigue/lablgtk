(* $Id$ *)

open Gaux
open Gtk
open Tags
open GtkRangeProps
open GtkBase

external _gtkrange_init : unit -> unit = "ml_gtkrange_init"
let () = _gtkrange_init ()

module ProgressBar = ProgressBar

module Range = Range

module Scale = Scale

module Scrollbar = Scrollbar

module Ruler = Ruler

(* $Id$ *)

open Gaux
open Gobject
open Gtk
open Tags
open GtkMiscProps
open GtkBase

external _gtkmisc_init : unit -> unit = "ml_gtkmisc_init"
let () = _gtkmisc_init ()

module GammaCurve = GammaCurve

module ColorSelection = ColorSelection

module Statusbar = Statusbar

module Calendar = Calendar

module DrawingArea = DrawingArea

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

module TipsQuery = TipsQuery

module Separator = Separator

module FontSelection = FontSelection

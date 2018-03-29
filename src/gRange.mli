(**************************************************************************)
(*                Lablgtk                                                 *)
(*                                                                        *)
(*    This program is free software; you can redistribute it              *)
(*    and/or modify it under the terms of the GNU Library General         *)
(*    Public License as published by the Free Software Foundation         *)
(*    version 2, with the exception described in file COPYING which       *)
(*    comes with the library.                                             *)
(*                                                                        *)
(*    This program is distributed in the hope that it will be useful,     *)
(*    but WITHOUT ANY WARRANTY; without even the implied warranty of      *)
(*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       *)
(*    GNU Library General Public License for more details.                *)
(*                                                                        *)
(*    You should have received a copy of the GNU Library General          *)
(*    Public License along with this program; if not, write to the        *)
(*    Free Software Foundation, Inc., 59 Temple Place, Suite 330,         *)
(*    Boston, MA 02111-1307  USA                                          *)
(*                                                                        *)
(*                                                                        *)
(**************************************************************************)

(* $Id$ *)

open Gtk
open GObj

(** Scrollbars, progressbars, etc. *)

(** {3 GtkProgressBar} *)

(** A widget which indicates progress visually
   @gtkdoc gtk GtkProgress
   @gtkdoc gtk GtkProgressBar *)
class progress_bar : Gtk.progress_bar obj ->
  object
    inherit GObj.widget_full
    val obj : Gtk.progress_bar Gtk.obj
    method event : GObj.event_ops
    method inverted : bool
    method pulse : unit -> unit
    method set_inverted : bool -> unit
    method set_fraction : float -> unit
    method set_pulse_step : float -> unit
    method set_show_text : bool -> unit
    method set_text : string -> unit
    method show_text : bool
    method fraction : float
    method pulse_step : float
    method text : string
    method ellipsize : PangoEnums.ellipsize_mode
    method set_ellipsize : PangoEnums.ellipsize_mode -> unit
  end

(** @gtkdoc gtk GtkProgress
    @gtkdoc gtk GtkProgressBar
    @param orientation default value is [`LEFT_TO_RIGHT]
    @param pulse_step default value is [0.1] *)
val progress_bar :
  ?pulse_step:float ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> progress_bar

(** {3 GtkRange} *)

(** @gtkdoc gtk GtkRange *)
class range_signals : [> Gtk.range] obj ->
  object
    inherit GObj.widget_signals
    method adjust_bounds : callback:(float -> unit) -> GtkSignal.id
    method move_slider :
        callback:(Tags.scroll_type -> unit) -> GtkSignal.id
    method change_value :
        callback:(Tags.scroll_type -> float -> unit) -> GtkSignal.id
    method value_changed : callback:(unit -> unit) -> GtkSignal.id
    method notify_adjustment :
        callback:(GData.adjustment -> unit) -> GtkSignal.id
    method notify_fill_level : callback:(float -> unit) -> GtkSignal.id
    method notify_inverted : callback:(bool -> unit) -> GtkSignal.id
    method notify_lower_stepper_sensitivity :
        callback:(Tags.sensitivity_type -> unit) -> GtkSignal.id
    method notify_restrict_to_fill_level :
        callback:(bool -> unit) -> GtkSignal.id
    method notify_round_digits : callback:(int -> unit) -> GtkSignal.id
    method notify_show_fill_level : callback:(bool -> unit) -> GtkSignal.id
    method notify_upper_stepper_sensitivity :
        callback:(Tags.sensitivity_type -> unit) -> GtkSignal.id
  end

(** Base class for widgets which visualize an adjustment
   @gtkdoc gtk GtkRange *)
class range : ([> Gtk.range] as 'a) obj ->
  object
    inherit GObj.widget
    val obj : 'a obj
    method as_range : Gtk.range Gtk.obj
    method connect : range_signals
    method event : GObj.event_ops
    method adjustment : GData.adjustment
    method fill_level : float
    method inverted : bool
    method lower_stepper_sensitivity : Tags.sensitivity_type
    method restrict_to_fill_level : bool
    method round_digits : int
    method set_adjustment : GData.adjustment -> unit
    method set_fill_level : float -> unit
    method set_inverted : bool -> unit
    method set_lower_stepper_sensitivity : Tags.sensitivity_type -> unit
    method set_restrict_to_fill_level : bool -> unit
    method set_round_digits : int -> unit
    method set_show_fill_level : bool -> unit
    method set_upper_stepper_sensitivity : Tags.sensitivity_type -> unit
    method show_fill_level : bool
    method upper_stepper_sensitivity : Tags.sensitivity_type
  end

(** A slider widget for selecting a value from a range
   @gtkdoc gtk GtkScale
   @gtkdoc gtk GtkHScale
   @gtkdoc gtk GtkVScale *)
class scale : Gtk.scale obj ->
  object
    inherit range
    val obj : Gtk.scale obj
    method set_digits : int -> unit
    method set_draw_value : bool -> unit
    method set_has_origin : bool -> unit
    method set_value_pos : Tags.position_type -> unit
    method digits : int
    method draw_value : bool
    method has_origin : bool
    method value_pos : Tags.position_type
  end

(** @gtkdoc gtk GtkScale
    @gtkdoc gtk GtkHScale
    @gtkdoc gtk GtkVScale 
    @param digits default value is [1]
    @param draw_value default value is [false]
    @param value_pos default value is [`LEFT]
    @param inverted default value is [false]
    @param update_policy default value is [`CONTINUOUS] *)
val scale :
  Tags.orientation ->
  ?adjustment:GData.adjustment ->
  ?digits:int ->
  ?draw_value:bool ->
  ?has_origin:bool ->
  ?value_pos:Tags.position_type ->
  ?fill_level:float ->
  ?inverted:bool ->
  ?restrict_to_fill_level:bool ->
  ?round_digits:int ->
  ?show_fill_level:bool ->
  ?lower_stepper_sensitivity:Tags.sensitivity_type ->
  ?upper_stepper_sensitivity:Tags.sensitivity_type ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> scale

(** @gtkdoc gtk GtkScrollbar
    @gtkdoc gtk GtkHScrollbar
    @gtkdoc gtk GtkVScrollbar
    @param inverted default value is [false]
    @param update_policy default value is [`CONTINUOUS] *)
val scrollbar :
  Tags.orientation ->
  ?adjustment:GData.adjustment ->
  ?fill_level:float ->
  ?inverted:bool ->
  ?restrict_to_fill_level:bool ->
  ?round_digits:int ->
  ?show_fill_level:bool ->
  ?lower_stepper_sensitivity:Tags.sensitivity_type ->
  ?upper_stepper_sensitivity:Tags.sensitivity_type ->
  ?packing:(widget -> unit) -> ?show:bool -> unit -> range

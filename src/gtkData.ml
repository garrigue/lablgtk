(* $Id$ *)

open Gaux
open Gtk
open Tags

module AccelGroup = struct
  external create : unit -> accel_group = "ml_gtk_accel_group_new"
(*
  external activate :
      accel_group -> key:Gdk.keysym -> ?modi:Gdk.Tags.modifier list -> bool
      = "ml_gtk_accel_group_activate"
  external groups_activate :
      'a obj -> key:Gdk.keysym -> ?modi:Gdk.Tags.modifier list -> bool
      = "ml_gtk_accel_groups_activate"
  external attach : accel_group -> 'a obj -> unit
      = "ml_gtk_accel_group_attach"
  external detach : accel_group -> 'a obj -> unit
      = "ml_gtk_accel_group_detach"
*)
  external lock : accel_group -> unit
      = "ml_gtk_accel_group_lock"
  external unlock : accel_group -> unit
      = "ml_gtk_accel_group_unlock"
(*
  external lock_entry :
      accel_group -> key:Gdk.keysym -> ?modi:Gdk.Tags.modifier list -> bool
      = "ml_gtk_accel_group_lock_entry"
  external add :
      accel_group -> key:Gdk.keysym -> ?modi:Gdk.Tags.modifier list ->
      ?flags:accel_flag list ->
      call:'a obj -> sgn:('a,unit->unit) GtkSignal.t -> unit
      = "ml_gtk_accel_group_add_bc" "ml_gtk_accel_group_add"
  external remove :
      accel_group ->
      key:Gdk.keysym -> ?modi:Gdk.Tags.modifier list -> call:'a obj -> unit
      = "ml_gtk_accel_group_remove"
  external valid : key:Gdk.keysym -> ?modi:Gdk.Tags.modifier list -> bool
      = "ml_gtk_accelerator_valid"
  external set_default_mod_mask : Gdk.Tags.modifier list option -> unit
      = "ml_gtk_accelerator_set_default_mod_mask"
*)
end

module Style = struct
  external create : unit -> style = "ml_gtk_style_new"
  external copy : style -> style = "ml_gtk_style_copy"
  external attach : style -> Gdk.window -> style = "ml_gtk_style_attach"
  external detach : style -> unit = "ml_gtk_style_detach"
  external set_window_background : style -> Gdk.window -> state_type -> unit
      = "ml_gtk_style_set_background"
  external draw_hline :
      style -> Gdk.window -> state_type -> x:int -> x:int -> y:int -> unit
      = "ml_gtk_draw_hline_bc" "ml_gtk_draw_hline"
  external draw_vline :
      style -> Gdk.window -> state_type -> y:int -> y:int -> x:int -> unit
      = "ml_gtk_draw_vline_bc" "ml_gtk_draw_vline"
  external get_bg : style -> state_type -> Gdk.Color.t
      = "ml_gtk_style_get_bg"
  external set_bg : style -> state_type -> Gdk.Color.t -> unit
      = "ml_gtk_style_set_bg"
  external get_fg : style -> state_type -> Gdk.Color.t
      = "ml_gtk_style_get_fg"
  external set_fg : style -> state_type -> Gdk.Color.t -> unit
      = "ml_gtk_style_set_fg"
  external get_light : style -> state_type -> Gdk.Color.t
      = "ml_gtk_style_get_light"
  external set_light : style -> state_type -> Gdk.Color.t -> unit
      = "ml_gtk_style_set_light"
  external get_dark : style -> state_type -> Gdk.Color.t
      = "ml_gtk_style_get_dark"
  external set_dark : style -> state_type -> Gdk.Color.t -> unit
      = "ml_gtk_style_set_dark"
  external get_mid : style -> state_type -> Gdk.Color.t
      = "ml_gtk_style_get_mid"
  external set_mid : style -> state_type -> Gdk.Color.t -> unit
      = "ml_gtk_style_set_mid"
  external get_base : style -> state_type -> Gdk.Color.t
      = "ml_gtk_style_get_base"
  external set_base : style -> state_type -> Gdk.Color.t -> unit
      = "ml_gtk_style_set_base"
  external get_text : style -> state_type -> Gdk.Color.t
      = "ml_gtk_style_get_text"
  external set_text : style -> state_type -> Gdk.Color.t -> unit
      = "ml_gtk_style_set_text"
  external get_colormap : style -> Gdk.colormap = "ml_gtk_style_get_colormap"
(*
  external get_font : style -> Gdk.font = "ml_gtk_style_get_font"
  external set_font : style -> Gdk.font -> unit = "ml_gtk_style_set_font"
  external get_dark_gc : style -> state:state_type -> Gdk.gc
      = "ml_gtk_style_get_dark_gc"
  external get_light_gc : style -> state:state_type -> Gdk.gc
      = "ml_gtk_style_get_light_gc"
  let set st ?:background ?:font =
    let may_set f = may fun:(f st) in
    may_set set_background background;
    may_set set_font font
*)
end

module Data = struct
  module Signals = struct
    open GtkSignal
    let disconnect =
      { name = "disconnect"; classe = `data; marshaller = marshal_unit }
  end
end

module Adjustment = struct
  external create :
      value:float -> lower:float -> upper:float ->
      step_incr:float -> page_incr:float -> page_size:float -> adjustment obj
      = "ml_gtk_adjustment_new_bc" "ml_gtk_adjustment_new"
  external set_value : [>`adjustment] obj -> float -> unit
      = "ml_gtk_adjustment_set_value"
  external clamp_page :
      [>`adjustment] obj -> lower:float -> upper:float -> unit
      = "ml_gtk_adjustment_clamp_page"
  external get_lower : [>`adjustment] obj -> float
      = "ml_gtk_adjustment_get_lower"
  external get_upper : [>`adjustment] obj -> float
      = "ml_gtk_adjustment_get_upper"
  external get_value : [>`adjustment] obj -> float
      = "ml_gtk_adjustment_get_value"
  external get_step_increment : [>`adjustment] obj -> float
      = "ml_gtk_adjustment_get_step_increment"
  external get_page_increment : [>`adjustment] obj -> float
      = "ml_gtk_adjustment_get_page_increment"
  external get_page_size : [>`adjustment] obj -> float
      = "ml_gtk_adjustment_get_page_size"
  external set : ?lower:float -> ?upper:float -> ?step_incr:float ->
      ?page_incr:float -> ?page_size:float -> [>`adjustment] obj -> unit
      =  "ml_gtk_adjustment_set_bc" "ml_gtk_adjustment_set"
  module Signals = struct
    open GtkSignal
    let changed =
      { name = "changed"; classe = `adjustment; marshaller = marshal_unit }
    let value_changed =
      { name = "value_changed"; classe = `adjustment;
        marshaller = marshal_unit }
  end
  let set_bounds adj ?lower ?upper ?step_incr ?page_incr ?page_size () =
    set adj ?lower ?upper ?step_incr ?page_incr ?page_size;
    GtkSignal.emit_unit adj ~sgn:Signals.changed;
    set_value adj (get_value adj)
end

module Tooltips = struct
  external create : unit -> tooltips obj = "ml_gtk_tooltips_new"
  external enable : [>`tooltips] obj -> unit = "ml_gtk_tooltips_enable"
  external disable : [>`tooltips] obj -> unit = "ml_gtk_tooltips_disable"
  external set_delay : [>`tooltips] obj -> int -> unit
      = "ml_gtk_tooltips_set_delay"
  external set_tip :
      [>`tooltips] obj ->
      [>`widget] obj -> ?text:string -> ?privat:string -> unit
      = "ml_gtk_tooltips_set_tip"
end

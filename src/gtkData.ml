(* $Id$ *)

open Misc
open Gtk
open Tags

module AccelGroup = struct
  external create : unit -> accel_group = "ml_gtk_accel_group_new"
  external activate :
      accel_group -> key:char -> ?mod:Gdk.Tags.modifier list -> bool
      = "ml_gtk_accel_group_activate"
  external groups_activate :
      'a obj -> key:char -> ?mod:Gdk.Tags.modifier list -> bool
      = "ml_gtk_accel_groups_activate"
  external attach : accel_group -> 'a obj -> unit
      = "ml_gtk_accel_group_attach"
  external detach : accel_group -> 'a obj -> unit
      = "ml_gtk_accel_group_detach"
  external lock : accel_group -> unit
      = "ml_gtk_accel_group_lock"
  external unlock : accel_group -> unit
      = "ml_gtk_accel_group_unlock"
  external lock_entry :
      accel_group -> key:char -> ?mod:Gdk.Tags.modifier list -> bool
      = "ml_gtk_accel_group_lock_entry"
  external add :
      accel_group -> key:char -> ?mod:Gdk.Tags.modifier list ->
      ?flags:accel_flag list ->
      call:'a obj -> sig:('a,unit->unit) GtkSignal.t -> unit
      = "ml_gtk_accel_group_add_bc" "ml_gtk_accel_group_add"
  external remove :
      accel_group ->
      key:char -> ?mod:Gdk.Tags.modifier list -> call:'a obj -> unit
      = "ml_gtk_accel_group_remove"
  external valid : key:char -> ?mod:Gdk.Tags.modifier list -> bool
      = "ml_gtk_accelerator_valid"
  external set_default_mod_mask : Gdk.Tags.modifier list option -> unit
      = "ml_gtk_accelerator_set_default_mod_mask"
end

module Style = struct
  external create : unit -> style = "ml_gtk_style_new"
  external copy : style -> style = "ml_gtk_style_copy"
  external attach : style -> Gdk.window -> style = "ml_gtk_style_attach"
  external detach : style -> unit = "ml_gtk_style_detach"
  external set_background : style -> Gdk.window -> state_type -> unit
      = "ml_gtk_style_set_background"
  external draw_hline :
      style -> Gdk.window -> state_type -> x:int -> x:int -> y:int -> unit
      = "ml_gtk_draw_hline_bc" "ml_gtk_draw_hline"
  external draw_vline :
      style -> Gdk.window -> state_type -> y:int -> y:int -> x:int -> unit
      = "ml_gtk_draw_vline_bc" "ml_gtk_draw_vline"
  external get_bg : style -> state:state_type -> Gdk.Color.t
      = "ml_gtk_style_get_bg"
  external set_bg : style -> state:state_type -> color:Gdk.Color.t -> unit
      = "ml_gtk_style_set_bg"
  external get_dark_gc : style -> state:state_type -> Gdk.gc
      = "ml_gtk_style_get_dark_gc"
  external get_light_gc : style -> state:state_type -> Gdk.gc
      = "ml_gtk_style_get_light_gc"
  external get_colormap : style -> Gdk.colormap = "ml_gtk_style_get_colormap"
  external get_font : style -> Gdk.font = "ml_gtk_style_get_font"
  external set_font : style -> Gdk.font -> unit = "ml_gtk_style_set_font"
  let setter st :cont ?:background ?:font =
    let may_set f = may fun:(f st) in
    may_set set_background background;
    may_set set_font font;
    cont st
  let set = setter cont:null_cont
end

module Data = struct
  module Signals = struct
    open GtkSignal
    let disconnect : ([> data],_) t =
      { name = "disconnect"; marshaller = marshal_unit }
  end
end

module Adjustment = struct
  external create :
      value:float -> lower:float -> upper:float ->
      step_incr:float -> page_incr:float -> page_size:float -> adjustment obj
      = "ml_gtk_adjustment_new_bc" "ml_gtk_adjustment_new"
  external set_value : [> adjustment] obj -> float -> unit
      = "ml_gtk_adjustment_set_value"
  external clamp_page :
      [> adjustment] obj -> lower:float -> upper:float -> unit
      = "ml_gtk_adjustment_clamp_page"
  external get_value :
      [> adjustment] obj -> float
      = "ml_GtkAdjustment_value"
  module Signals = struct
    open GtkSignal
    let changed : ([> adjustment],_) t =
      { name = "changed"; marshaller = marshal_unit }
    let value_changed : ([> adjustment],_) t =
      { name = "value_changed"; marshaller = marshal_unit }
  end
end

module Tooltips = struct
  external create : unit -> tooltips obj = "ml_gtk_tooltips_new"
  external enable : [> tooltips] obj -> unit = "ml_gtk_tooltips_enable"
  external disable : [> tooltips] obj -> unit = "ml_gtk_tooltips_disable"
  external set_delay : [> tooltips] obj -> int -> unit
      = "ml_gtk_tooltips_set_delay"
  external set_tip :
      [> tooltips] obj ->
      [> widget] obj -> ?text:string -> ?private:string -> unit
      = "ml_gtk_tooltips_set_tip"
  external set_colors :
      [> tooltips] obj ->
      ?foreground:Gdk.Color.t -> ?background:Gdk.Color.t -> unit
      = "ml_gtk_tooltips_set_colors"
  let setter tt :cont ?:delay ?:foreground ?:background =
    may fun:(set_delay tt) delay;
    if foreground <> None || background <> None then
      set_colors tt ?:foreground ?:background;
    cont tt
  let set = setter cont:null_cont
end


module Selection = struct
  type t
  external selection : t -> Gdk.atom
      = "ml_gtk_selection_data_selection"
  external target : t -> Gdk.atom
      = "ml_gtk_selection_data_target"
  external seltype : t -> Gdk.atom
      = "ml_gtk_selection_data_type"
  external format : t -> int
      = "ml_gtk_selection_data_format"
  external get_data : t -> string
      = "ml_gtk_selection_data_get_data"       (* May raise Null_pointer *)
  external set :
      t -> type:Gdk.atom -> format:int -> ?data:string -> unit
      = "ml_gtk_selection_data_set"
end

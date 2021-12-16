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

open Gaux
open Gobject
open GtkBaseProps
open Gtk
open Tags

module AccelGroup = struct
  external create : unit -> accel_group = "ml_gtk_accel_group_new"
  external lock : accel_group -> unit
      = "ml_gtk_accel_group_lock"
  external unlock : accel_group -> unit
      = "ml_gtk_accel_group_unlock"
  external connect :
      accel_group -> key:Gdk.keysym -> ?modi:Gdk.Tags.modifier list ->
      ?flags:accel_flag list ->  callback:g_closure -> unit
      = "ml_gtk_accel_group_connect"
  let connect ~key ?modi ?flags ~callback g =
    connect g ~key ?modi ?flags
      ~callback:(Closure.create (fun _ -> callback ()))
  external disconnect :
      accel_group -> key:Gdk.keysym -> ?modi:Gdk.Tags.modifier list -> bool
      = "ml_gtk_accel_group_disconnect_key"
  let disconnect ~key ?modi g = disconnect g ~key ?modi
  external groups_activate :
      'a obj -> key:Gdk.keysym -> ?modi:Gdk.Tags.modifier list -> bool
      = "ml_gtk_accel_groups_activate"
  let groups_activate ~key ?modi obj = groups_activate obj ~key ?modi
  (* XXX In the following functions, optional arguments are useless! *)
  (* Should remove the key label in lablgtk3 ? *)
  external valid : key:Gdk.keysym -> ?modi:Gdk.Tags.modifier list -> bool
      = "ml_gtk_accelerator_valid"
  external set_default_mod_mask : Gdk.Tags.modifier list option -> unit
      = "ml_gtk_accelerator_set_default_mod_mask"
  external parse : string -> Gdk.keysym * Gdk.Tags.modifier list
      = "ml_gtk_accelerator_parse"
  external name : key:Gdk.keysym -> ?modi:Gdk.Tags.modifier list -> string
      = "ml_gtk_accelerator_name"
  external get_label : key:Gdk.keysym -> ?modi:Gdk.Tags.modifier list -> string
      = "ml_gtk_accelerator_get_label"
end

module AccelMap = struct
  external load : string -> unit = "ml_gtk_accel_map_load"
  external save : string -> unit = "ml_gtk_accel_map_save"
  external add_entry : 
    string -> 
    key:Gdk.keysym -> 
    ?modi:Gdk.Tags.modifier list -> unit
    = "ml_gtk_accel_map_add_entry"
  let add_entry  ?(key=0) ?modi s = add_entry s ~key ?modi
  external change_entry :
    string -> Gdk.keysym -> Gdk.Tags.modifier list option -> bool -> bool
    = "ml_gtk_accel_map_change_entry"
  let change_entry ?(key=0) ?modi ?(replace=true) s =
    change_entry s key modi replace
  external foreach :
    (path:string -> key:int ->
     modi:Gdk.Tags.modifier list -> changed:bool -> unit) -> unit
    = "ml_gtk_accel_map_foreach"
end

module Style = struct
  external create : unit -> style = "ml_gtk_style_new"
  external copy : style -> style = "ml_gtk_style_copy"
  external attach : style -> Gdk.window -> style = "ml_gtk_style_attach"
  external detach : style -> unit = "ml_gtk_style_detach"
  external set_window_background : style -> Gdk.window -> state_type -> unit
      = "ml_gtk_style_set_background"
(*
  external draw_hline :
      style -> Gdk.window -> state_type -> x:int -> x:int -> y:int -> unit
      = "ml_gtk_draw_hline_bc" "ml_gtk_draw_hline"
  external draw_vline :
      style -> Gdk.window -> state_type -> y:int -> y:int -> x:int -> unit
      = "ml_gtk_draw_vline_bc" "ml_gtk_draw_vline"
*)
  external get_bg : style -> state_type -> Gdk.color
      = "ml_gtk_style_get_bg"
  external set_bg : style -> state_type -> Gdk.color -> unit
      = "ml_gtk_style_set_bg"
  external get_fg : style -> state_type -> Gdk.color
      = "ml_gtk_style_get_fg"
  external set_fg : style -> state_type -> Gdk.color -> unit
      = "ml_gtk_style_set_fg"
  external get_light : style -> state_type -> Gdk.color
      = "ml_gtk_style_get_light"
  external set_light : style -> state_type -> Gdk.color -> unit
      = "ml_gtk_style_set_light"
  external get_dark : style -> state_type -> Gdk.color
      = "ml_gtk_style_get_dark"
  external set_dark : style -> state_type -> Gdk.color -> unit
      = "ml_gtk_style_set_dark"
  external get_mid : style -> state_type -> Gdk.color
      = "ml_gtk_style_get_mid"
  external set_mid : style -> state_type -> Gdk.color -> unit
      = "ml_gtk_style_set_mid"
  external get_base : style -> state_type -> Gdk.color
      = "ml_gtk_style_get_base"
  external set_base : style -> state_type -> Gdk.color -> unit
      = "ml_gtk_style_set_base"
  external get_text : style -> state_type -> Gdk.color
      = "ml_gtk_style_get_text"
  external set_text : style -> state_type -> Gdk.color -> unit
      = "ml_gtk_style_set_text"
(*  external get_colormap : style -> Gdk.colormap = "ml_gtk_style_get_colormap"
  external get_font : style -> Gdk.font = "ml_gtk_style_get_font"
  external set_font : style -> Gdk.font -> unit = "ml_gtk_style_set_font"
  external get_dark_gc : style -> state:state_type -> Gdk.gc
      = "ml_gtk_style_get_dark_gc"
  external get_light_gc : style -> state:state_type -> Gdk.gc
      = "ml_gtk_style_get_light_gc"
  let set st ?:background ?:font =
    let may_set f = may ~f:(f st) in
    may_set set_background background;
    may_set set_font font *)
end

module Adjustment = struct
  include Adjustment
  external create :
      value:float -> lower:float -> upper:float ->
      step_incr:float -> page_incr:float -> page_size:float -> adjustment obj
      = "ml_gtk_adjustment_new_bc" "ml_gtk_adjustment_new"
  external clamp_page :
      [>`adjustment] obj -> lower:float -> upper:float -> unit
      = "ml_gtk_adjustment_clamp_page"
end

module CssProvider = struct
  external create : unit -> css_provider
      = "ml_gtk_css_provider_new"
  external load_from_data : css_provider -> string -> unit
      = "ml_gtk_css_provider_load_from_data"
end

module StyleContext = struct
  module ProviderPriority = struct
    type t = int
    let fallback : t = 1
    let theme : t = 200
    let settings : t = 400
    let application : t = 600
    let user : t = 800
  end

  (** Does not cascade!! *)
  external add_provider : style_context -> css_provider -> ProviderPriority.t -> unit
      = "ml_gtk_style_context_add_provider"
  external add_provider_for_screen : Gdk.screen -> css_provider -> ProviderPriority.t -> unit
      = "ml_gtk_style_context_add_provider_for_screen"
end

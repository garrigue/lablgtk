(* $Id$ *)

open Gaux
open Gtk
open Tags
open GtkProps
open GtkBase

external _gtkbin_init : unit -> unit = "ml_gtkbin_init"
let () = _gtkbin_init ()

module Alignment = struct
  let cast w : alignment obj = Object.try_cast w "GtkAlignment"
  external create :
      x:clampf -> y:clampf -> xscale:clampf -> yscale:clampf -> alignment obj
      = "ml_gtk_alignment_new"
  let create ?(x=0.5) ?(y=0.5) ?(xscale=1.) ?(yscale=1.) () =
    create ~x ~y ~xscale ~yscale
  external set :
      ?x:clampf -> ?y:clampf -> ?xscale:clampf -> ?yscale:clampf ->
      [>`alignment] obj -> unit
      = "ml_gtk_alignment_set"
end

module EventBox = struct
  let cast w : event_box obj = Object.try_cast w "GtkEventBox"
  let create () : event_box obj = Object.make "GtkEventBox" []
end

module Frame = struct
  let cast w : frame obj = Object.try_cast w "GtkFrame"
  let create params : frame obj = Object.make "GtkFrame" params
    
  let make_params ~cont ?label ?label_xalign ?label_yalign ?shadow_type =
    let module P = PFrame in
    let may_cons prop x l =
      match x with Some x -> Gobject.param prop x :: l | None -> l in
    cont (
    may_cons P.label_xalign label_xalign (
    may_cons P.label_yalign label_yalign (
    may_cons P.shadow_type shadow_type (
    may_cons P.label label []))))

  let setter ~cont =
    make_params ~cont:(fun params ->
      cont (fun w -> Gobject.Property.set_params w params))

  let set ?label = setter ~cont:(fun f w -> f w) ?label
end

module AspectFrame = struct
  let cast w : aspect_frame obj = Object.try_cast w "GtkAspectFrame"
  external create :
      label:string -> xalign:clampf ->
      yalign:clampf -> ratio:float -> obey_child:bool -> aspect_frame obj
      = "ml_gtk_aspect_frame_new"
  let create ?(label="") ?(xalign=0.5) ?(yalign=0.5)
      ?(ratio=1.0) ?(obey_child=true) () =
    create ~label ~xalign ~yalign ~ratio ~obey_child
  external set :
      [>`aspect] obj ->
      xalign:clampf -> yalign:clampf -> ratio:float -> obey_child:bool -> unit
      = "ml_gtk_aspect_frame_set"
  external get_xalign : [>`aspect] obj -> clampf
      = "ml_gtk_aspect_frame_get_xalign"
  external get_yalign : [>`aspect] obj -> clampf
      = "ml_gtk_aspect_frame_get_yalign"
  external get_ratio : [>`aspect] obj -> clampf
      = "ml_gtk_aspect_frame_get_ratio"
  external get_obey_child : [>`aspect] obj -> bool
      = "ml_gtk_aspect_frame_get_obey_child"
  let set ?xalign ?yalign ?ratio ?obey_child w =
    if xalign <> None || yalign <> None || ratio <> None || obey_child <> None
    then set w
	~xalign:(may_default get_xalign w ~opt:xalign)
	~yalign:(may_default get_yalign w ~opt:yalign)
	~ratio:(may_default get_ratio w ~opt:ratio)
	~obey_child:(may_default get_obey_child w ~opt:obey_child)
end

module HandleBox = struct
  let cast w : handle_box obj = Object.try_cast w "GtkHandleBox"
  external create : unit -> handle_box obj = "ml_gtk_handle_box_new"
  external set_shadow_type : [>`handlebox] obj -> shadow_type -> unit =
   "ml_gtk_handle_box_set_shadow_type"
  external set_handle_position : [>`handlebox] obj -> position -> unit =
   "ml_gtk_handle_box_set_handle_position"
  external set_snap_edge : [>`handlebox] obj -> position -> unit =
   "ml_gtk_handle_box_set_snap_edge"
  let set ?shadow_type ?handle_position ?snap_edge w =
    may shadow_type ~f:(set_shadow_type w);
    may handle_position ~f:(set_handle_position w);
    may snap_edge ~f:(set_snap_edge w)
  module Signals = struct
    open GtkSignal
    let child_attached =
      { name = "child_attached"; classe = `handlebox;
        marshaller = Widget.Signals.marshal }
    let child_detached =
      { name = "child_detached"; classe = `handlebox;
        marshaller = Widget.Signals.marshal }
  end
end

module Viewport = struct
  let cast w : viewport obj = Object.try_cast w "GtkViewport"
  external create :
      [>`adjustment] optobj -> [>`adjustment] optobj -> viewport obj
      = "ml_gtk_viewport_new"
  let create ?hadjustment ?vadjustment () =
    create (Gpointer.optboxed hadjustment) (Gpointer.optboxed vadjustment)
  external get_hadjustment : [>`viewport] obj -> adjustment obj
      = "ml_gtk_viewport_get_hadjustment"
  external get_vadjustment : [>`viewport] obj -> adjustment obj
      = "ml_gtk_viewport_get_vadjustment"
  external set_hadjustment : [>`viewport] obj -> [>`adjustment] obj -> unit
      = "ml_gtk_viewport_set_hadjustment"
  external set_vadjustment : [>`viewport] obj -> [>`adjustment] obj -> unit
      = "ml_gtk_viewport_set_vadjustment"
  external set_shadow_type : [>`viewport] obj -> shadow_type -> unit
      = "ml_gtk_viewport_set_shadow_type"
  let set ?hadjustment ?vadjustment ?shadow_type w =
    may hadjustment ~f:(set_hadjustment w);
    may vadjustment ~f:(set_vadjustment w);
    may shadow_type ~f:(set_shadow_type w)
end

module ScrolledWindow = struct
  let cast w : scrolled_window obj = Object.try_cast w "GtkScrolledWindow"
  external create :
      [>`adjustment] optobj -> [>`adjustment] optobj -> scrolled_window obj
      = "ml_gtk_scrolled_window_new"
  let create ?hadjustment ?vadjustment () =
    create (Gpointer.optboxed hadjustment) (Gpointer.optboxed vadjustment)
  external set_hadjustment : [>`scrolled] obj -> [>`adjustment] obj -> unit
      = "ml_gtk_scrolled_window_set_hadjustment"
  external set_vadjustment : [>`scrolled] obj -> [>`adjustment] obj -> unit
      = "ml_gtk_scrolled_window_set_vadjustment"
  external get_hadjustment : [>`scrolled] obj -> adjustment obj
      = "ml_gtk_scrolled_window_get_hadjustment"
  external get_vadjustment : [>`scrolled] obj -> adjustment obj
      = "ml_gtk_scrolled_window_get_vadjustment"
  external set_policy : [>`scrolled] obj -> policy_type -> policy_type -> unit
      = "ml_gtk_scrolled_window_set_policy"
  external add_with_viewport : [>`scrolled] obj -> [>`widget] obj -> unit
      = "ml_gtk_scrolled_window_add_with_viewport"
  external get_hscrollbar_policy : [>`scrolled] obj -> policy_type
      = "ml_gtk_scrolled_window_get_hscrollbar_policy"
  external get_vscrollbar_policy : [>`scrolled] obj -> policy_type
      = "ml_gtk_scrolled_window_get_vscrollbar_policy"
  external set_placement : [>`scrolled] obj -> corner_type -> unit
      = "ml_gtk_scrolled_window_set_placement"
  external set_shadow_type : [>`scrolled] obj -> shadow_type -> unit
      = "ml_gtk_scrolled_window_set_shadow_type"
  external get_shadow_type : [>`scrolled] obj -> shadow_type
      = "ml_gtk_scrolled_window_get_shadow_type"
  let set_policy' ?hpolicy ?vpolicy w =
    set_policy w
      (may_default get_hscrollbar_policy w ~opt:hpolicy)
      (may_default get_vscrollbar_policy w ~opt:vpolicy)
  let set ?hpolicy ?vpolicy ?placement ?shadow_type w =
    if hpolicy <> None || vpolicy <> None then
      set_policy' w ?hpolicy ?vpolicy;
    may placement ~f:(set_placement w);
    may shadow_type ~f:(set_shadow_type w)
end

module Socket = struct
  let cast w : socket obj = Object.try_cast w "GtkSocket"
  external create : unit -> socket obj = "ml_gtk_socket_new"
  external steal : [>`socket] obj -> Gdk.xid -> unit = "ml_gtk_socket_steal"
end

(*
module Invisible = struct
  let cast w : socket obj = Object.try_cast w "GtkInvisible"
  external create : unit -> invisible obj = "ml_gtk_invisible_new"
end
*)

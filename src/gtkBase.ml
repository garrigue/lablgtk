(* $Id$ *)

open Gaux
open Gobject
open Gtk
open Tags

module Object = struct
  let try_cast = Gobject.try_cast
  external destroy : 'a obj -> unit = "ml_gtk_object_destroy"
  module Signals = struct
    open GtkSignal
    let destroy =
      { name = "destroy"; classe = `base; marshaller = marshal_unit }
  end
end

module Widget = struct
  let cast w : widget obj = Object.try_cast w "GtkWidget"
  external unparent : [>`widget] obj -> unit = "ml_gtk_widget_unparent"
  external show : [>`widget] obj -> unit = "ml_gtk_widget_show"
  external show_now : [>`widget] obj -> unit = "ml_gtk_widget_show_now"
  external show_all : [>`widget] obj -> unit = "ml_gtk_widget_show_all"
  external hide : [>`widget] obj -> unit = "ml_gtk_widget_hide"
  external hide_all : [>`widget] obj -> unit = "ml_gtk_widget_hide_all"
  external map : [>`widget] obj -> unit = "ml_gtk_widget_map"
  external unmap : [>`widget] obj -> unit = "ml_gtk_widget_unmap"
  external realize : [>`widget] obj -> unit = "ml_gtk_widget_realize"
  external unrealize : [>`widget] obj -> unit = "ml_gtk_widget_unrealize"
  external queue_draw : [>`widget] obj -> unit = "ml_gtk_widget_queue_draw"
  external queue_resize : [>`widget] obj -> unit = "ml_gtk_widget_queue_resize"
  external draw : [>`widget] obj -> Gdk.Rectangle.t option -> unit
      = "ml_gtk_widget_draw"
(*
  external draw_focus : [>`widget] obj -> unit
      = "ml_gtk_widget_draw_focus"
  external draw_default : [>`widget] obj -> unit
      = "ml_gtk_widget_draw_default"
*)
  external event : [>`widget] obj -> 'a Gdk.event -> bool
      = "ml_gtk_widget_event"
  external activate : [>`widget] obj -> bool
      = "ml_gtk_widget_activate"
  external reparent : [>`widget] obj -> [>`widget] obj -> unit
      = "ml_gtk_widget_reparent"
(*
  external popup : [>`widget] obj -> x:int -> y:int -> unit
      = "ml_gtk_widget_popup"
*)
  external intersect :
      [>`widget] obj -> Gdk.Rectangle.t -> Gdk.Rectangle.t option
      = "ml_gtk_widget_intersect"
  external set_can_default : [>`widget] obj -> bool -> unit
      = "ml_gtk_widget_set_can_default"
  external set_can_focus : [>`widget] obj -> bool -> unit
      = "ml_gtk_widget_set_can_focus"
  external grab_focus : [>`widget] obj -> unit
      = "ml_gtk_widget_grab_focus"
  external grab_default : [>`widget] obj -> unit
      = "ml_gtk_widget_grab_default"
  external set_name : [>`widget] obj -> string -> unit
      = "ml_gtk_widget_set_name"
  external get_name : [>`widget] obj -> string
      = "ml_gtk_widget_get_name"
  external set_state : [>`widget] obj -> state_type -> unit
      = "ml_gtk_widget_set_state"
  external set_sensitive : [>`widget] obj -> bool -> unit
      = "ml_gtk_widget_set_sensitive"
  external set_uposition : [>`widget] obj -> x:int -> y:int -> unit
      = "ml_gtk_widget_set_uposition"
  external set_usize : [>`widget] obj -> width:int -> height:int -> unit
      = "ml_gtk_widget_set_usize"
  external add_events : [>`widget] obj -> Gdk.Tags.event_mask list -> unit
      = "ml_gtk_widget_add_events"
  external set_events : [>`widget] obj -> Gdk.Tags.event_mask list -> unit
      = "ml_gtk_widget_set_events"
  external set_extension_events :
      [>`widget] obj -> Gdk.Tags.extension_events -> unit
      = "ml_gtk_widget_set_extension_events"
  external get_toplevel : [>`widget] obj -> widget obj
      = "ml_gtk_widget_get_toplevel"
  external get_ancestor : [>`widget] obj -> g_type -> widget obj
      = "ml_gtk_widget_get_ancestor"
  external get_colormap : [>`widget] obj -> Gdk.colormap
      = "ml_gtk_widget_get_colormap"
  external get_visual : [>`widget] obj -> Gdk.visual
      = "ml_gtk_widget_get_visual"
  external get_pointer : [>`widget] obj -> int * int
      = "ml_gtk_widget_get_pointer"
  external is_ancestor : [>`widget] obj -> [>`widget] obj -> bool
      = "ml_gtk_widget_is_ancestor"
  external set_style : [>`widget] obj -> style -> unit
      = "ml_gtk_widget_set_style"
  external ensure_style : [>`widget] obj -> unit
      = "ml_gtk_widget_ensure_style"
  external get_style : [>`widget] obj -> style
      = "ml_gtk_widget_get_style"
  external modify_fg : [>`widget] obj -> state_type -> Gdk.Color.t -> unit
      = "ml_gtk_widget_modify_fg"
  external modify_bg : [>`widget] obj -> state_type -> Gdk.Color.t -> unit
      = "ml_gtk_widget_modify_bg"
  external modify_text : [>`widget] obj -> state_type -> Gdk.Color.t -> unit
      = "ml_gtk_widget_modify_text"
  external modify_base : [>`widget] obj -> state_type -> Gdk.Color.t -> unit
      = "ml_gtk_widget_modify_base"
  external modify_font : [>`widget] obj -> Pango.Font.description -> unit
      = "ml_gtk_widget_modify_font"
  external add_accelerator :
      ([>`widget] as 'a) obj -> sgn:('a,unit->unit) GtkSignal.t ->
      accel_group -> key:Gdk.keysym -> ?modi:Gdk.Tags.modifier list ->
      ?flags:accel_flag list -> unit
      = "ml_gtk_widget_add_accelerator_bc" "ml_gtk_widget_add_accelerator"
  external remove_accelerator :
      [>`widget] obj -> accel_group ->
      key:Gdk.keysym -> ?modi:Gdk.Tags.modifier list -> unit
      = "ml_gtk_widget_remove_accelerator"
(*
  external lock_accelerators : [>`widget] obj -> unit
      = "ml_gtk_widget_lock_accelerators"
  external unlock_accelerators : [>`widget] obj -> unit
      = "ml_gtk_widget_unlock_accelerators"
  external accelerators_locked : [>`widget] obj -> bool
      = "ml_gtk_widget_accelerators_locked"
*)
  external window : [>`widget] obj -> Gdk.window
      = "ml_GtkWidget_window"
  external visible : [>`widget] obj -> bool
      = "ml_GTK_WIDGET_VISIBLE"
  external has_focus : [>`widget] obj -> bool
      = "ml_GTK_WIDGET_HAS_FOCUS"
  external parent : [>`widget] obj -> widget obj
      = "ml_gtk_widget_parent"
  external set_app_paintable : [>`widget] obj -> bool -> unit
      = "ml_gtk_widget_set_app_paintable"
  external allocation : [>`widget] obj -> rectangle
      = "ml_gtk_widget_allocation"
  external set_colormap : [>`widget] obj -> Gdk.colormap -> unit
      = "ml_gtk_widget_set_colormap"
  external set_visual : [>`widget] obj -> Gdk.visual -> unit
      = "ml_gtk_widget_set_visual"
  external set_default_colormap : Gdk.colormap -> unit
      = "ml_gtk_widget_set_default_colormap"
  external set_default_visual : Gdk.visual -> unit
      = "ml_gtk_widget_set_default_visual"
  external get_default_colormap : unit -> Gdk.colormap
      = "ml_gtk_widget_get_default_colormap"
  external get_default_visual : unit -> Gdk.visual
      = "ml_gtk_widget_get_default_visual"
  external push_colormap : Gdk.colormap -> unit
      = "ml_gtk_widget_push_colormap"
  external push_visual : Gdk.visual -> unit
      = "ml_gtk_widget_push_visual"
  external pop_colormap : unit -> unit
      = "ml_gtk_widget_pop_colormap"
  external pop_visual : unit -> unit
      = "ml_gtk_widget_pop_visual"
  module Signals = struct
    open GtkSignal
    let marshal f _ = function
      | `OBJECT(Some p) :: _ -> f (cast p)
      |	_ -> invalid_arg "GtkBase.Widget.Signals.marshal"
    let marshal_opt f _ = function
      | `OBJECT(Some obj) :: _ -> f (Some (cast obj))
      | `OBJECT None :: _ -> f None
      | _ -> invalid_arg "GtkBase.Widget.Signals.marshal_opt"
    let marshal_style f _ = function
      | `POINTER p :: _ -> f (Obj.magic p : Gtk.style option)
      | _ -> invalid_arg "GtkBase.Widget.Signals.marshal_style"
    external allocation_at_pointer : Gpointer.boxed -> rectangle
        = "ml_Val_GtkAllocation"
    let marshal_allocation f argv = function
      | `POINTER(Some p) :: _ ->
          f (allocation_at_pointer p)
      |	_ -> invalid_arg "GtkBase.Widget.Signals.marshal_allocation"
    let show =
      { name = "show"; classe = `widget; marshaller = marshal_unit }
    let hide =
      { name = "hide"; classe = `widget; marshaller = marshal_unit }
    let map =
      { name = "map"; classe = `widget; marshaller = marshal_unit }
    let unmap =
      { name = "unmap"; classe = `widget; marshaller = marshal_unit }
    let realize =
      { name = "realize"; classe = `widget; marshaller = marshal_unit }
    let draw =
      let marshal f _ = function
	| `POINTER(Some p) :: _ -> f (Obj.magic p : Gdk.Rectangle.t)
	| _ -> invalid_arg "GtkBase.Widget.Signals.marshal_draw"
      in { name = "draw"; classe = `widget; marshaller = marshal }
    let draw_focus =
      { name = "draw_focus"; classe = `widget; marshaller = marshal_unit }
    let draw_default =
      { name = "draw_default"; classe = `widget;
        marshaller = marshal_unit }
    external val_state : int -> state_type = "ml_Val_state_type"
    let state_changed =
      let marshal f = marshal_int (fun x -> f (val_state x)) in
      { name = "state_changed"; classe = `widget; marshaller = marshal }
    let parent_set =
      { name = "parent_set"; classe = `widget; marshaller = marshal_opt }
    let size_allocate =
      { name = "size_allocate"; classe = `widget;
        marshaller = marshal_allocation }
    let style_set =
      { name = "style_set"; classe = `widget; marshaller = marshal_style }

    module Event = struct
      let marshal f argv = function
        | [`POINTER(Some p)] ->
	    let ev = GdkEvent.unsafe_copy p in
            Closure.set_result argv (`BOOL(f ev))
	| _ -> invalid_arg "GtkBase.Widget.Event.marshal"
      let any : ([>`widget], Gdk.Tags.event_type Gdk.event -> bool) t =
	{ name = "event"; classe = `widget; marshaller = marshal }
      let button_press : ([>`widget], GdkEvent.Button.t -> bool) t =
	{ name = "button_press_event"; classe = `widget;
          marshaller = marshal }
      let button_release : ([>`widget], GdkEvent.Button.t -> bool) t =
	{ name = "button_release_event"; classe = `widget;
          marshaller = marshal }
      let motion_notify : ([>`widget], GdkEvent.Motion.t -> bool) t =
	{ name = "motion_notify_event"; classe = `widget;
          marshaller = marshal }
      let delete : ([>`widget], [`DELETE] Gdk.event -> bool) t =
	{ name = "delete_event"; classe = `widget; marshaller = marshal }
      let destroy : ([>`widget], [`DESTROY] Gdk.event -> bool) t =
	{ name = "destroy_event"; classe = `widget; marshaller = marshal }
      let expose : ([>`widget], GdkEvent.Expose.t -> bool) t =
	{ name = "expose_event"; classe = `widget; marshaller = marshal }
      let key_press : ([>`widget], GdkEvent.Key.t -> bool) t =
	{ name = "key_press_event"; classe = `widget;
          marshaller = marshal }
      let key_release : ([>`widget], GdkEvent.Key.t -> bool) t =
	{ name = "key_release_event"; classe = `widget;
          marshaller = marshal }
      let enter_notify : ([>`widget], GdkEvent.Crossing.t -> bool) t =
	{ name = "enter_notify_event"; classe = `widget;
          marshaller = marshal }
      let leave_notify : ([>`widget], GdkEvent.Crossing.t -> bool) t =
	{ name = "leave_notify_event"; classe = `widget;
          marshaller = marshal }
      let configure : ([>`widget], GdkEvent.Configure.t -> bool) t =
	{ name = "configure_event"; classe = `widget;
          marshaller = marshal }
      let focus_in : ([>`widget], GdkEvent.Focus.t -> bool) t =
	{ name = "focus_in_event"; classe = `widget;
          marshaller = marshal }
      let focus_out : ([>`widget], GdkEvent.Focus.t -> bool) t =
	{ name = "focus_out_event"; classe = `widget;
          marshaller = marshal }
      let map : ([>`widget], [`MAP] Gdk.event -> bool) t =
	{ name = "map_event"; classe = `widget; marshaller = marshal }
      let unmap : ([>`widget], [`UNMAP] Gdk.event -> bool) t =
	{ name = "unmap_event"; classe = `widget; marshaller = marshal }
      let property_notify : ([>`widget], GdkEvent.Property.t -> bool) t =
	{ name = "property_notify_event"; classe = `widget;
          marshaller = marshal }
      let selection_clear : ([>`widget], GdkEvent.Selection.t -> bool) t =
	{ name = "selection_clear_event"; classe = `widget;
          marshaller = marshal }
      let selection_request : ([>`widget], GdkEvent.Selection.t -> bool) t =
	{ name = "selection_request_event"; classe = `widget;
          marshaller = marshal }
      let selection_notify : ([>`widget], GdkEvent.Selection.t -> bool) t =
	{ name = "selection_notify_event"; classe = `widget;
          marshaller = marshal }
      let proximity_in : ([>`widget], GdkEvent.Proximity.t -> bool) t =
	{ name = "proximity_in_event"; classe = `widget;
          marshaller = marshal }
      let proximity_out : ([>`widget], GdkEvent.Proximity.t -> bool) t =
	{ name = "proximity_out_event"; classe = `widget;
          marshaller = marshal }
    end
  end
end

module Container = struct
  let cast w : container obj = Object.try_cast w "GtkContainer"
  external coerce : [>`container] obj -> container obj = "%identity"
  external set_border_width : [>`container] obj -> int -> unit
      = "ml_gtk_container_set_border_width"
  external set_resize_mode : [>`container] obj -> resize_mode -> unit
      = "ml_gtk_container_set_resize_mode"
  external get_border_width : [>`container] obj -> int
      = "ml_gtk_container_get_border_width"
  external get_resize_mode : [>`container] obj -> resize_mode
      = "ml_gtk_container_get_resize_mode"
  external add : [>`container] obj -> [>`widget] obj -> unit
      = "ml_gtk_container_add"
  external remove : [>`container] obj -> [>`widget] obj -> unit
      = "ml_gtk_container_remove"
  let set ?border_width ?(width = -2) ?(height = -2) w =
    may border_width ~f:(set_border_width w);
    if width <> -2 || height <> -2 then
      Widget.set_usize w ?width ?height
  external foreach : [>`container] obj -> f:(widget obj-> unit) -> unit
      = "ml_gtk_container_foreach"
  let children w =
    let l = ref [] in
    foreach w ~f:(fun c -> l := c :: !l);
    List.rev !l
(*
  external focus : [>`container] obj -> direction_type -> bool
      = "ml_gtk_container_focus"
*)
  (* Called by Widget.grab_focus *)
  external set_focus_child : [>`container] obj -> [>`widget] optobj -> unit
      = "ml_gtk_container_set_focus_child"
  external set_focus_vadjustment :
      [>`container] obj -> [>`adjustment] optobj -> unit
      = "ml_gtk_container_set_focus_vadjustment"
  external set_focus_hadjustment :
      [>`container] obj -> [>`adjustment] optobj -> unit
      = "ml_gtk_container_set_focus_hadjustment"
  module Signals = struct
    open GtkSignal
    let add =
      { name = "add"; classe = `container;
        marshaller = Widget.Signals.marshal }
    let remove =
      { name = "remove"; classe = `container;
        marshaller = Widget.Signals.marshal }
    let need_resize =
      let marshal f argv _ = Closure.set_result argv (`BOOL(f ())) in
      { name = "need_resize"; classe = `container; marshaller = marshal }
    external val_direction : int -> direction_type = "ml_Val_direction_type"
    let focus =
      let marshal f argv = function
        | `INT dir :: _ ->
            Closure.set_result argv (`BOOL(f (val_direction dir)))
        | _ -> invalid_arg "GtkBase.Container.Signals.marshal_focus"
      in { name = "focus"; classe = `container; marshaller = marshal }
  end
end

module Item = struct
  let cast w : item obj = Object.try_cast w "GtkItem"
  external select : [>`item] obj -> unit = "ml_gtk_item_select"
  external deselect : [>`item] obj -> unit = "ml_gtk_item_deselect"
  external toggle : [>`item] obj -> unit = "ml_gtk_item_toggle"
  module Signals = struct
    open GtkSignal
    let select =
      { name = "select"; classe = `item; marshaller = marshal_unit }
    let deselect =
      { name = "deselect"; classe = `item; marshaller = marshal_unit }
    let toggle =
      { name = "toggle"; classe = `item; marshaller = marshal_unit }
  end
end

module Selection = struct
  external selection : selection_data -> Gdk.atom
      = "ml_gtk_selection_data_selection"
  external target : selection_data -> Gdk.atom
      = "ml_gtk_selection_data_target"
  external seltype : selection_data -> Gdk.atom
      = "ml_gtk_selection_data_type"
  external format : selection_data -> int
      = "ml_gtk_selection_data_format"
  external get_data : selection_data -> string
      = "ml_gtk_selection_data_get_data"       (* May raise Gpointer.null *)
  external set :
      selection_data ->
      typ:Gdk.atom -> format:int -> data:string option -> unit
      = "ml_gtk_selection_data_set"

  external owner_set :
    [>`widget] obj -> sel:Gdk.Tags.selection -> time:int -> bool
    = "ml_gtk_selection_owner_set"
  external add_target :
    [>`widget] obj -> sel:Gdk.Tags.selection -> target:Gdk.atom ->
    info:int -> unit
    = "ml_gtk_selection_add_target"
  external convert :
    [> `widget] obj -> sel:Gdk.Tags.selection -> target:Gdk.atom ->
    time:int -> bool
    = "ml_gtk_selection_convert"
  
  module Signals = struct
    open GtkSignal
    let marshal_sel3 f _ = function
      | `POINTER(Some p) :: `INT info :: `INT time :: _ ->
          f (Obj.magic p : selection_data) ~info ~time
      | _ -> invalid_arg "GtkBase.Widget.Signals.marshal_sel3"
    let marshal_sel2 f _ = function
      | `POINTER(Some p) :: `INT time :: _ ->
          f (Obj.magic p : selection_data) ~time
      | _ -> invalid_arg "GtkBase.Widget.Signals.marshal_sel2"
    let selection_get =
      { name = "selection_get"; classe = `widget;
        marshaller = marshal_sel3 }
    let selection_received =
      { name = "selection_received"; classe = `widget;
        marshaller = marshal_sel2 }
  end
end

module DnD = struct
  external dest_set :
      [>`widget] obj -> flags:dest_defaults list ->
      targets:target_entry array -> actions:Gdk.Tags.drag_action list -> unit 
    = "ml_gtk_drag_dest_set"
  external dest_unset : [>`widget] obj -> unit
      = "ml_gtk_drag_dest_unset"
  external finish :
      Gdk.drag_context -> success:bool -> del:bool -> time:int -> unit
      = "ml_gtk_drag_finish"
  external get_data :
      [>`widget] obj -> Gdk.drag_context -> target:Gdk.atom -> time:int -> unit
      = "ml_gtk_drag_get_data"
  external get_source_widget : Gdk.drag_context -> widget obj
      = "ml_gtk_drag_get_source_widget"
  external highlight : [>`widget] obj -> unit = "ml_gtk_drag_highlight"
  external unhighlight : [>`widget] obj -> unit = "ml_gtk_drag_unhighlight"
  external set_icon_widget :
      Gdk.drag_context -> [>`widget] obj -> hot_x:int -> hot_y:int -> unit
      = "ml_gtk_drag_set_icon_widget"
  external set_icon_pixmap :
      Gdk.drag_context -> colormap:Gdk.colormap ->
      Gdk.pixmap -> ?mask:Gdk.bitmap -> hot_x:int -> hot_y:int -> unit
      = "ml_gtk_drag_set_icon_pixmap_bc" "ml_gtk_drag_set_icon_pixmap"
  external set_icon_default : Gdk.drag_context -> unit
      = "ml_gtk_drag_set_icon_default"
  external set_default_icon :
      colormap:Gdk.colormap -> Gdk.pixmap ->
      ?mask:Gdk.bitmap -> hot_x:int -> hot_y:int -> unit
      = "ml_gtk_drag_set_default_icon"
  external source_set :
      [>`widget] obj -> ?modi:Gdk.Tags.modifier list ->
      targets:target_entry array -> actions:Gdk.Tags.drag_action list -> unit
      = "ml_gtk_drag_source_set"
  external source_set_icon :
      [>`widget] obj -> colormap:Gdk.colormap ->
      Gdk.pixmap -> ?mask:Gdk.bitmap -> unit
      = "ml_gtk_drag_source_set_icon"
  external source_unset : [>`widget] obj -> unit
      = "ml_gtk_drag_source_unset"
(*  external dest_handle_event : [>`widget] -> *)
  module Signals = struct
    open GtkSignal
    open Widget.Signals
    let marshal_drag1 f _ = function
      | `POINTER(Some p) :: _ -> f (Obj.magic p : Gdk.drag_context)
      |	_ -> invalid_arg "GtkBase.Widget.Signals.marshal_drag1"
    let marshal_drag2 f _ = function
      | `POINTER(Some p) :: `INT time :: _ ->
	  f (Obj.magic p : Gdk.drag_context) ~time
      |	_ -> invalid_arg "GtkBase.Widget.Signals.marshal_drag2"
    let marshal_drag3 f argv = function
      | `POINTER(Some p) :: `INT x :: `INT y :: `INT time :: _ ->
	  let res = f (Obj.magic p : Gdk.drag_context) ~x ~y ~time
	  in Closure.set_result argv (`BOOL res)
      |	_ -> invalid_arg "GtkBase.Widget.Signals.marshal_drag3"
    let drag_begin =
      { name = "drag_begin"; classe = `widget;
        marshaller = marshal_drag1 }
    let drag_end =
      { name = "drag_end"; classe = `widget;
        marshaller = marshal_drag1 }
    let drag_data_delete =
      { name = "drag_data_delete"; classe = `widget;
        marshaller = marshal_drag1 }
    let drag_leave =
      { name = "drag_leave"; classe = `widget;
        marshaller = marshal_drag2 }
    let drag_motion =
      { name = "drag_motion"; classe = `widget;
        marshaller = marshal_drag3 }
    let drag_drop =
      { name = "drag_drop"; classe = `widget; marshaller = marshal_drag3 }
    let drag_data_get =
      let marshal f argv = function
        | `POINTER(Some p) :: `POINTER(Some q) ::
          `INT info :: `INT time :: _ ->
	    f (Obj.magic p : Gdk.drag_context)
	      (Obj.magic q : selection_data) 
	      ~info
	      ~time
	| _ -> invalid_arg "GtkBase.Widget.Signals.marshal_drag_data_get"
      in
      { name = "drag_data_get"; classe = `widget; marshaller = marshal }
    let drag_data_received =
      let marshal f _ = function
        | `POINTER(Some p) :: `INT x :: `INT y :: `POINTER(Some q) ::
          `INT info :: `INT time :: _ ->
	    f (Obj.magic p : Gdk.drag_context) ~x ~y
              (Obj.magic q : selection_data)
	      ~info ~time
	| _ -> invalid_arg "GtkBase.Widget.Signals.marshal_drag_data_received"
      in
      { name = "drag_data_received"; classe = `widget;
        marshaller = marshal }
  end
end

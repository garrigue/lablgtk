(* $Id$ *)

open Gaux
open Gtk
open Tags

module Type = struct
  external name : gtk_type -> string = "ml_gtk_type_name"
  external from_name : string -> gtk_type = "ml_gtk_type_from_name"
  external parent : gtk_type -> gtk_type = "ml_gtk_type_parent"
  external get_class : gtk_type -> gtk_class = "ml_gtk_type_class"
  external parent_class : gtk_type -> gtk_class = "ml_gtk_type_parent_class"
  external is_a : gtk_type -> gtk_type -> bool = "ml_gtk_type_is_a"
  external fundamental : gtk_type -> fundamental_type
      = "ml_gtk_type_fundamental"
end

module Object = struct
  external get_type : 'a obj -> gtk_type = "ml_gtk_object_type"
  let is_a obj name =
    Type.is_a (get_type obj) (Type.from_name name)
  external destroy : 'a obj -> unit = "ml_gtk_object_destroy"
  external unsafe_cast : 'a obj -> 'b obj = "%identity"
  let try_cast w name =
    if is_a w name then unsafe_cast w
    else raise (Cannot_cast(Type.name(get_type w), name))
  let get_id (obj : 'a obj) : int = (snd (Obj.magic obj) lor 0)
  module Signals = struct
    open GtkSignal
    let destroy : (_,_) t =
      { name = "destroy"; marshaller = marshal_unit }
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
  external draw_focus : [>`widget] obj -> unit
      = "ml_gtk_widget_draw_focus"
  external draw_default : [>`widget] obj -> unit
      = "ml_gtk_widget_draw_default"
  external event : [>`widget] obj -> 'a Gdk.event -> bool
      = "ml_gtk_widget_event"
  external activate : [>`widget] obj -> bool
      = "ml_gtk_widget_activate"
  external reparent : [>`widget] obj -> [>`widget] obj -> unit
      = "ml_gtk_widget_reparent"
  external popup : [>`widget] obj -> x:int -> y:int -> unit
      = "ml_gtk_widget_popup"
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
  external get_ancestor : [>`widget] obj -> gtk_type -> widget obj
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
  external set_rc_style : [>`widget] obj -> unit
      = "ml_gtk_widget_set_rc_style"
  external ensure_style : [>`widget] obj -> unit
      = "ml_gtk_widget_ensure_style"
  external get_style : [>`widget] obj -> style
      = "ml_gtk_widget_get_style"
  external restore_default_style : [>`widget] obj -> unit
      = "ml_gtk_widget_restore_default_style"
  external add_accelerator :
      ([>`widget] as 'a) obj -> sgn:('a,unit->unit) GtkSignal.t ->
      accel_group -> key:Gdk.keysym -> ?modi:Gdk.Tags.modifier list ->
      ?flags:accel_flag list -> unit
      = "ml_gtk_widget_add_accelerator_bc" "ml_gtk_widget_add_accelerator"
  external remove_accelerator :
      [>`widget] obj -> accel_group ->
      key:Gdk.keysym -> ?modi:Gdk.Tags.modifier list -> unit
      = "ml_gtk_widget_remove_accelerator"
  external lock_accelerators : [>`widget] obj -> unit
      = "ml_gtk_widget_lock_accelerators"
  external unlock_accelerators : [>`widget] obj -> unit
      = "ml_gtk_widget_unlock_accelerators"
  external accelerators_locked : [>`widget] obj -> bool
      = "ml_gtk_widget_accelerators_locked"
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
    open GtkArgv
    open GtkSignal
    let marshal f _ = function
      | OBJECT(Some p) :: _ -> f (cast p)
      |	_ -> invalid_arg "GtkBase.Widget.Signals.marshal"
    let marshal_opt f _ = function
      | OBJECT(Some obj) :: _ -> f (Some (cast obj))
      | OBJECT None :: _ -> f None
      | _ -> invalid_arg "GtkBase.Widget.Signals.marshal_opt"
    let marshal_style f _ = function
      | POINTER p :: _ -> f (Obj.magic p : Gtk.style option)
      | _ -> invalid_arg "GtkBase.Widget.Signals.marshal_opt"
    let marshal_drag1 f _ = function
      | POINTER(Some p) :: _ -> f (Obj.magic p : Gdk.drag_context)
      |	_ -> invalid_arg "GtkBase.Widget.Signals.marshal_drag1"
    let marshal_drag2 f _ = function
      | POINTER(Some p) :: INT time :: _ ->
	  f (Obj.magic p : Gdk.drag_context) ~time
      |	_ -> invalid_arg "GtkBase.Widget.Signals.marshal_drag2"
    let marshal_drag3 f argv = function
      | POINTER(Some p) :: INT x :: INT y :: INT time :: _ ->
	  let res = f (Obj.magic p : Gdk.drag_context) ~x ~y ~time
	  in GtkArgv.set_result argv (`BOOL res)
      |	_ -> invalid_arg "GtkBase.Widget.Signals.marshal_drag3"
    external allocation_at_pointer : Gpointer.boxed -> rectangle
        = "ml_Val_GtkAllocation"
    let marshal_allocation f argv = function
      | POINTER(Some p) :: _ ->
          f (allocation_at_pointer p)
      |	_ -> invalid_arg "GtkBase.Widget.Signals.marshal_allocation"
    let show : ([>`widget],_) t =
      { name = "show"; marshaller = marshal_unit }
    let hide : ([>`widget],_) t =
      { name = "hide"; marshaller = marshal_unit }
    let map : ([>`widget],_) t =
      { name = "map"; marshaller = marshal_unit }
    let unmap : ([>`widget],_) t =
      { name = "unmap"; marshaller = marshal_unit }
    let realize : ([>`widget],_) t =
      { name = "realize"; marshaller = marshal_unit }
    let draw : ([>`widget],_) t =
      let marshal f _ = function
	| POINTER(Some p) :: _ -> f (Obj.magic p : Gdk.Rectangle.t)
	| _ -> invalid_arg "GtkBase.Widget.Signals.marshal_draw"
      in { name = "draw"; marshaller = marshal }
    let draw_focus : ([>`widget],_) t =
      { name = "draw_focus"; marshaller = marshal_unit }
    let draw_default : ([>`widget],_) t =
      { name = "draw_default"; marshaller = marshal_unit }
    external val_state : int -> state_type = "ml_Val_state_type"
    let state_changed : ([>`widget],_) t =
      let marshal f = marshal_int (fun x -> f (val_state x)) in
      { name = "state_changed"; marshaller = marshal }
    let parent_set : ([>`widget],_) t =
      { name = "parent_set"; marshaller = marshal_opt }
    let size_allocate : ([`widget],_) t =
      { name = "size_allocate"; marshaller = marshal_allocation }
    let style_set : ([>`widget],_) t =
      { name = "style_set"; marshaller = marshal_style }
    let drag_begin : ([>`widget],_) t =
      { name = "drag_begin"; marshaller = marshal_drag1 }
    let drag_end : ([>`widget],_) t =
      { name = "drag_end"; marshaller = marshal_drag1 }
    let drag_data_delete : ([>`widget],_) t =
      { name = "drag_data_delete"; marshaller = marshal_drag1 }
    let drag_leave : ([>`widget],_) t =
      { name = "drag_leave"; marshaller = marshal_drag2 }
    let drag_motion : ([>`widget],_) t =
      { name = "drag_motion"; marshaller = marshal_drag3 }
    let drag_drop : ([>`widget],_) t =
      { name = "drag_drop"; marshaller = marshal_drag3 }
    let drag_data_get : ([>`widget],_) t =
      let marshal f argv = function
        | POINTER(Some p) :: POINTER(Some q) :: INT info :: INT time :: _ ->
	    f (Obj.magic p : Gdk.drag_context)
	      (Obj.magic q : GtkData.Selection.t) 
	      ~info
	      ~time
	| _ -> invalid_arg "GtkBase.Widget.Signals.marshal_drag_data_get"
      in
      { name = "drag_data_get"; marshaller = marshal }
    let drag_data_received : ([>`widget],_) t =
      let marshal f _ = function
        | POINTER(Some p) :: INT x :: INT y :: POINTER(Some q) ::
          INT info :: INT time :: _ ->
	    f (Obj.magic p : Gdk.drag_context) ~x ~y
              (Obj.magic q : GtkData.Selection.t)
	      ~info ~time
	| _ -> invalid_arg "GtkBase.Widget.Signals.marshal_drag_data_received"
      in
      { name = "drag_data_received"; marshaller = marshal }

    module Event = struct
      let marshal f argv = function
        | [POINTER(Some p)] ->
	    let ev = GdkEvent.unsafe_copy p in
            GtkArgv.set_result argv (`BOOL(f ev))
	| _ -> invalid_arg "GtkBase.Widget.Event.marshal"
      let any : ([>`widget], Gdk.Tags.event_type Gdk.event -> bool) t =
	{ name = "event"; marshaller = marshal }
      let button_press : ([>`widget], GdkEvent.Button.t -> bool) t =
	{ name = "button_press_event"; marshaller = marshal }
      let button_release : ([>`widget], GdkEvent.Button.t -> bool) t =
	{ name = "button_release_event"; marshaller = marshal }
      let motion_notify : ([>`widget], GdkEvent.Motion.t -> bool) t =
	{ name = "motion_notify_event"; marshaller = marshal }
      let delete : ([>`widget], [`DELETE] Gdk.event -> bool) t =
	{ name = "delete_event"; marshaller = marshal }
      let destroy : ([>`widget], [`DESTROY] Gdk.event -> bool) t =
	{ name = "destroy_event"; marshaller = marshal }
      let expose : ([>`widget], GdkEvent.Expose.t -> bool) t =
	{ name = "expose_event"; marshaller = marshal }
      let key_press : ([>`widget], GdkEvent.Key.t -> bool) t =
	{ name = "key_press_event"; marshaller = marshal }
      let key_release : ([>`widget], GdkEvent.Key.t -> bool) t =
	{ name = "key_release_event"; marshaller = marshal }
      let enter_notify : ([>`widget], GdkEvent.Crossing.t -> bool) t =
	{ name = "enter_notify_event"; marshaller = marshal }
      let leave_notify : ([>`widget], GdkEvent.Crossing.t -> bool) t =
	{ name = "leave_notify_event"; marshaller = marshal }
      let configure : ([>`widget], GdkEvent.Configure.t -> bool) t =
	{ name = "configure_event"; marshaller = marshal }
      let focus_in : ([>`widget], GdkEvent.Focus.t -> bool) t =
	{ name = "focus_in_event"; marshaller = marshal }
      let focus_out : ([>`widget], GdkEvent.Focus.t -> bool) t =
	{ name = "focus_out_event"; marshaller = marshal }
      let map : ([>`widget], [`MAP] Gdk.event -> bool) t =
	{ name = "map_event"; marshaller = marshal }
      let unmap : ([>`widget], [`UNMAP] Gdk.event -> bool) t =
	{ name = "unmap_event"; marshaller = marshal }
      let property_notify : ([>`widget], GdkEvent.Property.t -> bool) t =
	{ name = "property_notify_event"; marshaller = marshal }
      let selection_clear : ([>`widget], GdkEvent.Selection.t -> bool) t =
	{ name = "selection_clear_event"; marshaller = marshal }
      let selection_request : ([>`widget], GdkEvent.Selection.t -> bool) t =
	{ name = "selection_request_event"; marshaller = marshal }
      let selection_notify : ([>`widget], GdkEvent.Selection.t -> bool) t =
	{ name = "selection_notify_event"; marshaller = marshal }
      let proximity_in : ([>`widget], GdkEvent.Proximity.t -> bool) t =
	{ name = "proximity_in_event"; marshaller = marshal }
      let proximity_out : ([>`widget], GdkEvent.Proximity.t -> bool) t =
	{ name = "proximity_out_event"; marshaller = marshal }
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
  external focus : [>`container] obj -> direction_type -> bool
      = "ml_gtk_container_focus"
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
    let add : ([>`container],_) t =
      { name = "add"; marshaller = Widget.Signals.marshal }
    let remove : ([>`container],_) t =
      { name = "remove"; marshaller = Widget.Signals.marshal }
    let need_resize : ([>`container],_) t =
      let marshal f argv _ = GtkArgv.set_result argv (`BOOL(f ())) in
      { name = "need_resize"; marshaller = marshal }
    external val_direction : int -> direction_type = "ml_Val_direction_type"
    let focus : ([>`container],_) t =
      let marshal f argv = function
        | GtkArgv.INT dir :: _ ->
            GtkArgv.set_result argv (`BOOL(f (val_direction dir)))
        | _ -> invalid_arg "GtkBase.Container.Signals.marshal_focus"
      in { name = "focus"; marshaller = marshal }
  end
end

module Item = struct
  let cast w : item obj = Object.try_cast w "GtkItem"
  external select : [>`item] obj -> unit = "ml_gtk_item_select"
  external deselect : [>`item] obj -> unit = "ml_gtk_item_deselect"
  external toggle : [>`item] obj -> unit = "ml_gtk_item_toggle"
  module Signals = struct
    open GtkSignal
    let select : ([>`item],_) t =
      { name = "select"; marshaller = marshal_unit }
    let deselect : ([>`item],_) t =
      { name = "deselect"; marshaller = marshal_unit }
    let toggle : ([>`item],_) t =
      { name = "toggle"; marshaller = marshal_unit }
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
end


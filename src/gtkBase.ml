(* $Id$ *)

open Misc
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
  let get_id (obj : 'a obj) : int = (snd (Obj.magic obj) lor 0)
  module Signals = struct
    open GtkSignal
    let destroy : (_,_) t =
      { name = "destroy"; marshaller = marshal_unit }
  end
end

module Widget = struct
  let cast w : widget obj =
    if Object.is_a w "GtkWidget" then Obj.magic w
    else invalid_arg "Gtk.Widget.cast"
  external coerce : [> widget] obj -> widget obj = "%identity"
  external unparent : [> widget] obj -> unit = "ml_gtk_widget_unparent"
  external show : [> widget] obj -> unit = "ml_gtk_widget_show"
  external show_now : [> widget] obj -> unit = "ml_gtk_widget_show_now"
  external show_all : [> widget] obj -> unit = "ml_gtk_widget_show_all"
  external hide : [> widget] obj -> unit = "ml_gtk_widget_hide"
  external hide_all : [> widget] obj -> unit = "ml_gtk_widget_hide_all"
  external map : [> widget] obj -> unit = "ml_gtk_widget_map"
  external unmap : [> widget] obj -> unit = "ml_gtk_widget_unmap"
  external realize : [> widget] obj -> unit = "ml_gtk_widget_realize"
  external unrealize : [> widget] obj -> unit = "ml_gtk_widget_unrealize"
  external queue_draw : [> widget] obj -> unit = "ml_gtk_widget_queue_draw"
  external queue_resize : [> widget] obj -> unit = "ml_gtk_widget_queue_resize"
  external draw : [> widget] obj -> Gdk.Rectangle.t -> unit
      = "ml_gtk_widget_draw"
  external draw_focus : [> widget] obj -> unit
      = "ml_gtk_widget_draw_focus"
  external draw_default : [> widget] obj -> unit
      = "ml_gtk_widget_draw_default"
  external event : [> widget] obj -> 'a Gdk.event -> bool
      = "ml_gtk_widget_event"
  external activate : [> widget] obj -> bool
      = "ml_gtk_widget_activate"
  external reparent : [> widget] obj -> [> widget] obj -> unit
      = "ml_gtk_widget_reparent"
  external popup : [> widget] obj -> x:int -> y:int -> unit
      = "ml_gtk_widget_popup"
  external intersect :
      [> widget] obj -> Gdk.Rectangle.t -> Gdk.Rectangle.t option
      = "ml_gtk_widget_intersect"
  external set_can_default : [> widget] obj -> bool -> unit
      = "ml_gtk_widget_set_can_default"
  external set_can_focus : [> widget] obj -> bool -> unit
      = "ml_gtk_widget_set_can_focus"
  external grab_focus : [> widget] obj -> unit
      = "ml_gtk_widget_grab_focus"
  external grab_default : [> widget] obj -> unit
      = "ml_gtk_widget_grab_default"
  external set_name : [> widget] obj -> string -> unit
      = "ml_gtk_widget_set_name"
  external get_name : [> widget] obj -> string
      = "ml_gtk_widget_get_name"
  external set_state : [> widget] obj -> state_type -> unit
      = "ml_gtk_widget_set_state"
  external set_sensitive : [> widget] obj -> bool -> unit
      = "ml_gtk_widget_set_sensitive"
  external set_uposition : [> widget] obj -> x:int -> y:int -> unit
      = "ml_gtk_widget_set_uposition"
  external set_usize : [> widget] obj -> width:int -> height:int -> unit
      = "ml_gtk_widget_set_usize"
  external add_events : [> widget] obj -> Gdk.Tags.event_mask list -> unit
      = "ml_gtk_widget_add_events"
  external set_events : [> widget] obj -> Gdk.Tags.event_mask list -> unit
      = "ml_gtk_widget_set_events"
  external set_extension_events :
      [> widget] obj -> Gdk.Tags.extension_events -> unit
      = "ml_gtk_widget_set_extension_events"
  external get_toplevel : [> widget] obj -> widget obj
      = "ml_gtk_widget_get_toplevel"
  external get_ancestor : [> widget] obj -> gtk_type -> widget obj
      = "ml_gtk_widget_get_ancestor"
  external get_colormap : [> widget] obj -> Gdk.colormap
      = "ml_gtk_widget_get_colormap"
  external get_visual : [> widget] obj -> Gdk.visual
      = "ml_gtk_widget_get_visual"
  external get_pointer : [> widget] obj -> int * int
      = "ml_gtk_widget_get_pointer"
  external is_ancestor : [> widget] obj -> [> widget] obj -> bool
      = "ml_gtk_widget_is_ancestor"
  external set_style : [> widget] obj -> style -> unit
      = "ml_gtk_widget_set_style"
  external set_rc_style : [> widget] obj -> unit
      = "ml_gtk_widget_set_rc_style"
  external ensure_style : [> widget] obj -> unit
      = "ml_gtk_widget_ensure_style"
  external get_style : [> widget] obj -> style
      = "ml_gtk_widget_get_style"
  external restore_default_style : [> widget] obj -> unit
      = "ml_gtk_widget_restore_default_style"
  external add_accelerator :
      'a[> widget] obj -> sig:('a,unit->unit) GtkSignal.t ->
      accel_group -> key:char -> ?mod:Gdk.Tags.modifier list ->
      ?flags:accel_flag list -> unit
      = "ml_gtk_widget_add_accelerator_bc" "ml_gtk_widget_add_accelerator"
  external remove_accelerator :
      [> widget] obj -> accel_group ->
      key:char -> ?mod:Gdk.Tags.modifier list -> unit
      = "ml_gtk_widget_remove_accelerator"
  external lock_accelerators : [> widget] obj -> unit
      = "ml_gtk_widget_lock_accelerators"
  external unlock_accelerators : [> widget] obj -> unit
      = "ml_gtk_widget_unlock_accelerators"
  external accelerators_locked : [> widget] obj -> bool
      = "ml_gtk_widget_accelerators_locked"
  external window : [> widget] obj -> Gdk.window
      = "ml_GtkWidget_window"
  external visible : [> widget] obj -> bool =
    "ml_gtk_widget_visible"
  external parent : [> widget] obj -> widget obj =
    "ml_gtk_widget_parent"
  let setter w :cont ?:name ?:state ?:sensitive ?:extension_events
      ?:can_default ?:can_focus
      ?:x [< -2 >] ?:y [< -2 >] ?:width [< -1 >] ?:height [< -1 >] ?:style =
    let may_set f arg = may fun:(f w) arg in
    may_set set_name name;
    may_set set_state state;
    may_set set_sensitive sensitive;
    may_set set_extension_events extension_events;
    may_set set_can_default can_default;
    may_set set_can_focus can_focus;
    may_set set_style style;
    if x > -2 || y > -2 then set_uposition w :x :y;
    if width > -1 || height > -1 then set_usize w :width :height;
    cont w
  let set = setter cont:null_cont
  module Signals = struct
    open GtkSignal
    let marshal f argv = f (cast (GtkArgv.get_object argv pos:0))
    let marshal_opt f argv = f (try Some(cast (GtkArgv.get_object argv pos:0))
	                        with Null_pointer -> None)

    let show : ([> widget],_) t =
      { name = "show"; marshaller = marshal_unit }
    let hide : ([> widget],_) t =
      { name = "hide"; marshaller = marshal_unit }
    let map : ([> widget],_) t =
      { name = "map"; marshaller = marshal_unit }
    let unmap : ([> widget],_) t =
      { name = "unmap"; marshaller = marshal_unit }
    let realize : ([> widget],_) t =
      { name = "realize"; marshaller = marshal_unit }
    let draw : ([> widget],_) t =
      let marshal f argv =
	let p = GtkArgv.get_pointer argv pos:0 in
	f (Obj.magic p : Gdk.Rectangle.t)
      in { name = "draw"; marshaller = marshal }
    let draw_focus : ([> widget],_) t =
      { name = "draw_focus"; marshaller = marshal_unit }
    let draw_default : ([> widget],_) t =
      { name = "draw_default"; marshaller = marshal_unit }
    external val_state : int -> state_type = "ml_Val_state_type"
    let state_changed : ([> widget],_) t =
      let marshal f argv = f (val_state (GtkArgv.get_int argv pos:0)) in
      { name = "state_changed"; marshaller = marshal }
    let parent_set : ([> widget],_) t =
      { name = "parent_set"; marshaller = marshal_opt }

    module Event = struct
      let marshal f argv =
	let p = GtkArgv.get_pointer argv pos:0 in
	let ev = Gdk.Event.unsafe_copy p in
	GtkArgv.set_result_bool argv (f ev)
      let any : ([> widget], Gdk.Tags.event_type Gdk.event -> bool) t =
	{ name = "event"; marshaller = marshal }
      let button_press : ([> widget], Gdk.Event.Button.t -> bool) t =
	{ name = "button_press_event"; marshaller = marshal }
      let button_release : ([> widget], Gdk.Event.Button.t -> bool) t =
	{ name = "button_release_event"; marshaller = marshal }
      let motion_notify : ([> widget], Gdk.Event.Motion.t -> bool) t =
	{ name = "motion_notify_event"; marshaller = marshal }
      let delete : ([> widget], [DELETE] Gdk.event -> bool) t =
	{ name = "delete_event"; marshaller = marshal }
      let destroy : ([> widget], [DESTROY] Gdk.event -> bool) t =
	{ name = "destroy_event"; marshaller = marshal }
      let expose : ([> widget], Gdk.Event.Expose.t -> bool) t =
	{ name = "expose_event"; marshaller = marshal }
      let key_press : ([> widget], Gdk.Event.Key.t -> bool) t =
	{ name = "key_press_event"; marshaller = marshal }
      let key_release : ([> widget], Gdk.Event.Key.t -> bool) t =
	{ name = "key_release_event"; marshaller = marshal }
      let enter_notify : ([> widget], Gdk.Event.Crossing.t -> bool) t =
	{ name = "enter_notify_event"; marshaller = marshal }
      let leave_notify : ([> widget], Gdk.Event.Crossing.t -> bool) t =
	{ name = "leave_notify_event"; marshaller = marshal }
      let configure : ([> widget], Gdk.Event.Configure.t -> bool) t =
	{ name = "configure_event"; marshaller = marshal }
      let focus_in : ([> widget], Gdk.Event.Focus.t -> bool) t =
	{ name = "focus_in_event"; marshaller = marshal }
      let focus_out : ([> widget], Gdk.Event.Focus.t -> bool) t =
	{ name = "focus_out_event"; marshaller = marshal }
      let map : ([> widget], [MAP] Gdk.event -> bool) t =
	{ name = "map_event"; marshaller = marshal }
      let unmap : ([> widget], [UNMAP] Gdk.event -> bool) t =
	{ name = "unmap_event"; marshaller = marshal }
      let property_notify : ([> widget], Gdk.Event.Property.t -> bool) t =
	{ name = "property_notify_event"; marshaller = marshal }
      let selection_clear : ([> widget], Gdk.Event.Selection.t -> bool) t =
	{ name = "selection_clear_event"; marshaller = marshal }
      let selection_request : ([> widget], Gdk.Event.Selection.t -> bool) t =
	{ name = "selection_request_event"; marshaller = marshal }
      let selection_notify : ([> widget], Gdk.Event.Selection.t -> bool) t =
	{ name = "selection_notify_event"; marshaller = marshal }
      let proximity_in : ([> widget], Gdk.Event.Proximity.t -> bool) t =
	{ name = "proximity_in_event"; marshaller = marshal }
      let proximity_out : ([> widget], Gdk.Event.Proximity.t -> bool) t =
	{ name = "proximity_out_event"; marshaller = marshal }
    end
  end
end

module Container = struct
  let cast w : container obj =
    if Object.is_a w "GtkContainer" then Obj.magic w
    else invalid_arg "Gtk.Container.cast"
  external coerce : [> container] obj -> container obj = "%identity"
  external set_border_width : [> container] obj -> int -> unit
      = "ml_gtk_container_set_border_width"
  external add : [> container] obj -> [> widget] obj -> unit
      = "ml_gtk_container_add"
  external remove : [> container] obj -> [> widget] obj -> unit
      = "ml_gtk_container_remove"
  let setter w :cont ?:border_width ?:width [< -1 >] ?:height [< -1 >] =
    may border_width fun:(set_border_width w);
    if width > -1 || height > -1 then Widget.set_usize w :width :height;
    cont w
  let set = setter cont:null_cont
  external foreach : [> container] obj -> fun:(widget obj-> unit) -> unit
      = "ml_gtk_container_foreach"
  let children w =
    let l = ref [] in
    foreach w fun:(push on:l);
    List.rev !l
  external focus : [> container] obj -> direction_type -> bool
      = "ml_gtk_container_focus"
  (* Called by Widget.grab_focus *)
  external set_focus_child : [> container] obj -> [> widget] optobj -> unit
      = "ml_gtk_container_set_focus_child"
  external set_focus_vadjustment :
      [> container] obj -> [> adjustment] optobj -> unit
      = "ml_gtk_container_set_focus_vadjustment"
  external set_focus_hadjustment :
      [> container] obj -> [> adjustment] optobj -> unit
      = "ml_gtk_container_set_focus_hadjustment"
  module Signals = struct
    open GtkSignal
    let add : ([> container],_) t =
      { name = "add"; marshaller = Widget.Signals.marshal }
    let remove : ([> container],_) t =
      { name = "remove"; marshaller = Widget.Signals.marshal }
    let need_resize : ([> container],_) t =
      let marshal f argv = GtkArgv.set_result_bool argv (f ()) in
      { name = "need_resize"; marshaller = marshal }
    external val_direction : int -> direction_type = "ml_Val_direction_type"
    let focus : ([> container],_) t =
      let marshal f argv =
	let dir = val_direction (GtkArgv.get_int argv pos:0) in
	GtkArgv.set_result_bool argv (f dir)
      in { name = "focus"; marshaller = marshal }
  end
end

module Item = struct
  let cast w : item obj =
    if Object.is_a w "GtkItem" then Obj.magic w
    else invalid_arg "Gtk.Item.cast"
  external coerce : [> item] obj -> item obj = "%identity"
  external select : [> item] obj -> unit = "ml_gtk_item_select"
  external deselect : [> item] obj -> unit = "ml_gtk_item_deselect"
  external toggle : [> item] obj -> unit = "ml_gtk_item_toggle"
  module Signals = struct
    open GtkSignal
    let select : ([> item],_) t =
      { name = "select"; marshaller = marshal_unit }
    let deselect : ([> item],_) t =
      { name = "deselect"; marshaller = marshal_unit }
    let toggle : ([> item],_) t =
      { name = "toggle"; marshaller = marshal_unit }
  end
end

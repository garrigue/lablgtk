(* $Id$ *)

open Misc
open Gtk

let _ =
  Callback.register_exception "gtkerror" (Error"");
  Callback.register_exception "null_pointer" Null_pointer

type 'a optobj = 'a obj optboxed

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

module GtkArg = struct
  type t
  external shift : t -> pos:int -> t = "ml_gtk_arg_shift"
  external get_type : t -> gtk_type = "ml_gtk_arg_get_type"
  (* Safely get an argument *)
  external get_char : t -> char = "ml_gtk_arg_get_char"
  external get_bool : t -> bool = "ml_gtk_arg_get_bool"
  external get_int : t -> int = "ml_gtk_arg_get_int"
  external get_float : t -> float = "ml_gtk_arg_get_float"
  (* These 3 may raise [Null_pointer] *)
  external get_string : t -> string = "ml_gtk_arg_get_string"
  external get_pointer : t -> pointer = "ml_gtk_arg_get_pointer"
  external get_object : t -> unit obj = "ml_gtk_arg_get_object"
  (* Safely set a result
     Beware: this is not the opposite of get, arguments and results
     are two different ways to use GtkArg. *)
  external set_char : t -> char -> unit = "ml_gtk_arg_set_char"
  external set_bool : t -> bool -> unit = "ml_gtk_arg_set_bool"
  external set_int : t -> int -> unit = "ml_gtk_arg_set_int"
  external set_float : t -> float -> unit = "ml_gtk_arg_set_float"
  external set_string : t -> string -> unit = "ml_gtk_arg_set_string"
  external set_pointer : t -> pointer -> unit = "ml_gtk_arg_set_pointer"
  external set_object : t -> 'a obj -> unit = "ml_gtk_arg_set_object"
end

module Argv = struct
  open GtkArg
  type raw_obj
  type t = { referent: raw_obj; nargs: int; args: GtkArg.t }
  let nth arg :pos =
    if pos < 0 || pos >= arg.nargs then invalid_arg "Argv.nth";
    shift arg.args :pos
  let result arg =
    if arg.nargs < 0 then invalid_arg "Argv.result";
    shift arg.args pos:arg.nargs
  external wrap_object : raw_obj -> unit obj = "Val_GtkObject"
  let referent arg =
    if arg.referent == Obj.magic (-1) then invalid_arg "Argv.referent";
    wrap_object arg.referent
  let get_result_type arg = get_type (result arg)
  let get_type arg :pos = get_type (nth arg :pos)
  let get_char arg :pos = get_char (nth arg :pos)
  let get_bool arg :pos = get_bool (nth arg :pos)
  let get_int arg :pos = get_int (nth arg :pos)
  let get_float arg :pos = get_float (nth arg :pos)
  let get_string arg :pos = get_string (nth arg :pos)
  let get_pointer arg :pos = get_pointer (nth arg :pos)
  let get_object arg :pos = get_object (nth arg :pos)
  let set_result_char arg = set_char (result arg)
  let set_result_bool arg = set_bool (result arg)
  let set_result_int arg = set_int (result arg)
  let set_result_float arg = set_float (result arg)
  let set_result_string arg = set_string (result arg)
  let set_result_pointer arg = set_pointer (result arg)
  let set_result_object arg = set_object (result arg)
end

module Signal = struct
  type id
  type ('a,'b) t = { name: string; marshaller: 'b -> Argv.t -> unit }
  external connect :
      'a obj -> name:string -> callback:(Argv.t -> unit) -> after:bool -> id
      = "ml_gtk_signal_connect"
  let connect : 'a obj -> sig:('a, _) t -> _ =
    fun obj sig:signal :callback ?:after [< false >] ->
      connect obj name:signal.name callback:(signal.marshaller callback) :after
  external disconnect : 'a obj -> id -> unit
      = "ml_gtk_signal_disconnect"
  external emit : 'a obj -> name:string -> unit = "ml_gtk_signal_emit_by_name"
  let emit (obj : 'a obj) sig:(sgn : ('a,unit->unit) t) =
    emit obj name:sgn.name
  external emit_stop_by_name: 'a obj -> name:string -> unit =
    "ml_gtk_signal_emit_stop_by_name"
  external handler_block: 'a obj -> id -> unit
      = "ml_gtk_signal_handler_block"
  external handler_unblock: 'a obj -> id -> unit
      = "ml_gtk_signal_handler_unblock"
  let marshal_unit f _ = f ()
  let marshal_int f argv = f (Argv.get_int argv pos:0)
end

module Event = struct
  module Signals = struct
    open Signal
    let marshal f argv =
      let p = Argv.get_pointer argv pos:0 in
      let ev = Gdk.Event.unsafe_copy p in
      Argv.set_result_bool argv (f ev)
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

module Timeout = struct
  type id
  external add : int -> callback:(Argv.t -> unit) -> id = "ml_gtk_timeout_add"
  let add inter :callback =
    add inter callback:(fun arg -> Argv.set_result_bool arg (callback ()))
  external remove : id -> unit = "ml_gtk_timeout_remove"
end

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
      call:'a obj -> sig:('a,unit->unit) Signal.t -> unit
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
      = "ml_gtk_draw_hline"
  external draw_vline :
      style -> Gdk.window -> state_type -> y:int -> y:int -> c:int -> unit
      = "ml_gtk_draw_vline"
  external get_bg : style -> state:state_type -> Gdk.Color.t
      = "ml_gtk_style_get_bg"
  external set_bg : style -> state:state_type -> color:Gdk.Color.t -> unit
      = "ml_gtk_style_set_bg"
  let get_bg st ?:state [< `NORMAL >] = get_bg st :state
  let set_bg st ?:state [< `NORMAL >] :color = set_bg st :state :color
  external get_colormap : style -> Gdk.colormap = "ml_gtk_style_get_colormap"
  external get_depth : style -> int = "ml_gtk_style_get_depth"
  external get_font : style -> Gdk.font = "ml_gtk_style_get_font"
  external set_font : style -> Gdk.font -> unit = "ml_gtk_style_set_font"
  let setter st :cont ?:background ?:font =
    let may_set f = may fun:(f st) in
    may_set set_background background;
    may_set set_font font;
    cont st
  let set = setter cont:null_cont
end

module Object = struct
  external get_type : 'a obj -> gtk_type = "ml_gtk_object_type"
  let is_a obj name =
    Type.is_a (get_type obj) (Type.from_name name)
  external destroy : 'a obj -> unit = "ml_gtk_object_destroy"
  module Signals = struct
    open Signal
    let destroy : (_,_) t =
      { name = "destroy"; marshaller = marshal_unit }
  end
end

(*
module Caller = struct
  type t = [caller] obj
  external create : unit -> t = "ml_gtk_caller_new"
  module Signals = struct
    open Signal
    let call : ([> caller],unit->unit) t =
      { name = "call"; marshaller = marshal_unit }
  end
  let call = Signal.emit sig:Signals.call
  let create ?:callback ?(_ : unit option) =
    let obj = create () in
    may callback
      fun:(fun callback -> Signal.connect sig:Signals.call obj :callback);
    obj
end
*)

module Data = struct
  module Signals = struct
    open Signal
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
    open Signal
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
      = "ml_gtk_widget_set_can_default"
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
      'a[> widget] obj -> sig:('a,unit->unit) Signal.t ->
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
  let setter w :cont ?:name ?:state ?:sensitive ?:can_default ?:can_focus
      ?:x [< -2 >] ?:y [< -2 >] ?:width [< -1 >] ?:height [< -1 >] ?:style =
    let may_set f arg = may fun:(f w) arg in
    may_set set_name name;
    may_set set_state state;
    may_set set_sensitive sensitive;
    may_set set_can_default can_default;
    may_set set_can_focus can_focus;
    may_set set_style style;
    if x > -2 || y > -2 then set_uposition w :x :y;
    if width > -1 || height > -1 then set_usize w :width :height;
    cont w
  let set = setter cont:null_cont
  module Signals = struct
    open Signal
    let marshal f argv = f (cast (Argv.get_object argv pos:0))

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
	let p = Argv.get_pointer argv pos:0 in
	f (Obj.magic p : Gdk.Rectangle.t)
      in { name = "draw"; marshaller = marshal }
    let draw_focus : ([> widget],_) t =
      { name = "draw_focus"; marshaller = marshal_unit }
    let draw_default : ([> widget],_) t =
      { name = "draw_default"; marshaller = marshal_unit }
    external val_state : int -> state_type = "ml_Val_state_type"
    let state_changed : ([> widget],_) t =
      let marshal f argv = f (val_state (Argv.get_int argv pos:0)) in
      { name = "state_changed"; marshaller = marshal }
    let parent_set : ([> widget],_) t =
      { name = "parent_set"; marshaller = marshal }
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
  external set_focus_child : [> container] obj -> [> widget] obj -> unit
      = "ml_gtk_container_set_focus_child"
  external set_focus_vadjustment :
      [> container] obj -> [> adjustment] obj -> unit
      = "ml_gtk_container_set_focus_vadjustment"
  external set_focus_hadjustment :
      [> container] obj -> [> adjustment] obj -> unit
      = "ml_gtk_container_set_focus_hadjustment"
  module Signals = struct
    open Signal
    let add : ([> container],_) t =
      { name = "add"; marshaller = Widget.Signals.marshal }
    let remove : ([> container],_) t =
      { name = "remove"; marshaller = Widget.Signals.marshal }
    let need_resize : ([> container],_) t =
      let marshal f argv = Argv.set_result_bool argv (f ()) in
      { name = "need_resize"; marshaller = marshal }
    external val_direction : int -> direction_type = "ml_Val_direction_type"
    let focus : ([> container],_) t =
      let marshal f argv =
	let dir = val_direction (Argv.get_int argv pos:0) in
	Argv.set_result_bool argv (f dir)
      in { name = "focus"; marshaller = marshal }
  end
end

module Alignment = struct
  let cast w : alignment obj =
    if Object.is_a w "GtkAlignment" then Obj.magic w
    else invalid_arg "Gtk.Alignment.cast"
  external create :
      x:clampf -> y:clampf -> xscale:clampf -> yscale:clampf -> alignment obj
      = "ml_gtk_alignment_new"
  let create ?:x [< 0.5 >] ?:y [< 0.5 >] ?:xscale [< 1.0 >]
      ?:yscale [< 1.0 >] ?(_ : unit option) =
    create :x :y :xscale :yscale
  external set :
      [> alignment] obj ->
      ?x:clampf -> ?y:clampf -> ?xscale:clampf -> ?yscale:clampf -> unit
      = "ml_gtk_alignment_set"
  let setter w :cont ?:x ?:y ?:xscale ?:yscale =
    if x <> None || y <> None || xscale <> None || yscale <> None then
      set w ?:x ?:y ?:xscale ?:yscale;
    cont w
  let set = setter ?cont:Container.set
end

module EventBox = struct
  let cast w : event_box obj =
    if Object.is_a w "GtkEventBox" then Obj.magic w
    else invalid_arg "Gtk.EventBox.cast"
  external create : unit -> event_box obj = "ml_gtk_event_box_new"
end

module Frame = struct
  let cast w : frame obj =
    if Object.is_a w "GtkFrame" then Obj.magic w
    else invalid_arg "Gtk.Frame.cast"
  external coerce : [> frame] obj -> frame obj = "%identity"
  external create : optstring -> frame obj = "ml_gtk_frame_new"
  let create ?:label ?(_ : unit option) = create (optpointer label)
  external set_label : [> frame] obj -> string -> unit
      = "ml_gtk_frame_set_label"
  external set_label_align : [> frame] obj -> x:clampf -> y:clampf -> unit
      = "ml_gtk_frame_set_label"
  external set_shadow_type : [> frame] obj -> shadow_type -> unit
      = "ml_gtk_frame_set_shadow_type"
  external get_label_xalign : [> frame] obj -> float
      = "ml_gtk_frame_get_label_xalign"
  external get_label_yalign : [> frame] obj -> float
      = "ml_gtk_frame_get_label_yalign"
  let setter w :cont ?:label ?:label_xalign ?:label_yalign ?:shadow_type =
    may label fun:(set_label w);
    if label_xalign <> None || label_yalign <> None then
      set_label_align w
	x:(may_default get_label_xalign w for:label_xalign)
	y:(may_default get_label_yalign w for:label_yalign);
    may shadow_type fun:(set_shadow_type w);
    cont w
  let set = setter ?cont:Container.set
end

module AspectFrame = struct
  let cast w : aspect_frame obj =
    if Object.is_a w "GtkAspectFrame" then Obj.magic w
    else invalid_arg "Gtk.AspectFrame.cast"
  external create :
      label:optstring -> xalign:clampf ->
      yalign:clampf -> ratio:float -> obey_child:bool -> aspect_frame obj
      = "ml_gtk_aspect_frame_new"
  let create ?:label ?:xalign [< 0.5 >] ?:yalign [< 0.5 >]
      ?:ratio [< 1.0 >] ?:obey_child [< true >] ?(_ : unit option) =
    create label:(optpointer label) :xalign :yalign :ratio :obey_child
  external set :
      [> aspect] obj ->
      xalign:clampf -> yalign:clampf -> ratio:float -> obey_child:bool -> unit
      = "ml_gtk_aspect_frame_set"
  external get_xalign : [> aspect] obj -> clampf
      = "ml_gtk_aspect_frame_get_xalign"
  external get_yalign : [> aspect] obj -> clampf
      = "ml_gtk_aspect_frame_get_yalign"
  external get_ratio : [> aspect] obj -> clampf
      = "ml_gtk_aspect_frame_get_ratio"
  external get_obey_child : [> aspect] obj -> bool
      = "ml_gtk_aspect_frame_get_obey_child"
  let setter w :cont ?:xalign ?:yalign ?:ratio ?:obey_child =
    if xalign <> None || yalign <> None || ratio <> None || obey_child <> None
    then set w xalign:(may_default get_xalign w for:xalign)
	yalign:(may_default get_yalign w for:yalign)
	ratio:(may_default get_ratio w for:ratio)
	obey_child:(may_default get_obey_child w for:obey_child);
    cont w
  let set = setter ?cont:Frame.set
end

module HandleBox = struct
  let cast w : handle_box obj =
    if Object.is_a w "GtkHandleBox" then Obj.magic w
    else invalid_arg "Gtk.HandleBox.cast"
  external create : unit -> handle_box obj = "ml_gtk_handle_box_new"
  external set_shadow_type : [> handlebox] obj -> shadow_type -> unit =
   "ml_gtk_handle_box_set_shadow_type"
  external set_handle_position : [> handlebox] obj -> position -> unit =
   "ml_gtk_handle_box_set_handle_position"
  external set_snap_edge : [> handlebox] obj -> position -> unit =
   "ml_gtk_handle_box_set_snap_edge"
  module Signals = struct
    open Signal
    let child_attached : ([> handlebox],_) t =
      { name = "child_attached"; marshaller = Widget.Signals.marshal }
    let child_detached : ([> handlebox],_) t =
      { name = "child_detached"; marshaller = Widget.Signals.marshal }
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
    open Signal
    let select : ([> item],_) t =
      { name = "select"; marshaller = marshal_unit }
    let deselect : ([> item],_) t =
      { name = "deselect"; marshaller = marshal_unit }
    let toggle : ([> item],_) t =
      { name = "toggle"; marshaller = marshal_unit }
  end
end

module ListItem = struct
  let cast w : list_item obj =
    if Object.is_a w "GtkListItem" then Obj.magic w
    else invalid_arg "Gtk.ListItem.cast"
  external create : unit -> list_item obj = "ml_gtk_list_item_new"
  external create_with_label : string -> list_item obj
      = "ml_gtk_list_item_new_with_label"
  let create ?:label ?(_ : unit option) =
    match label with None -> create ()
    | Some label -> create_with_label label
end

module MenuItem = struct
  let cast w : menu_item obj =
    if Object.is_a w "GtkMenuItem" then Obj.magic w
    else invalid_arg "Gtk.MenuItem.cast"
  external coerce : [> menuitem] obj -> menu_item obj = "%identity"
  external create : unit -> menu_item obj = "ml_gtk_menu_item_new"
  external create_with_label : string -> menu_item obj
      = "ml_gtk_menu_item_new_with_label"
  external tearoff_create : unit -> menu_item obj
      = "ml_gtk_tearoff_menu_item_new"
  let create ?:label ?(_ : unit option) =
    match label with None -> create ()
    | Some label -> create_with_label label
  external set_submenu : [> menuitem] obj -> [> menu] obj -> unit
      = "ml_gtk_menu_item_set_submenu"
  external remove_submenu : [> menuitem] obj -> unit
      = "ml_gtk_menu_item_remove_submenu"
  external configure :
      [> menuitem] obj -> show_toggle:bool -> show_indicator:bool -> unit
      = "ml_gtk_menu_item_configure"
  external activate : [> menuitem] obj -> unit
      = "ml_gtk_menu_item_activate"
  external right_justify : [> menuitem] obj -> unit
      = "ml_gtk_menu_item_right_justify"
  module Signals = struct
    open Signal
    let activate : ([> menuitem],_) t =
      { name = "activate"; marshaller = marshal_unit }
  end
end

module CheckMenuItem = struct
  let cast w : check_menu_item obj =
    if Object.is_a w "GtkCheckMenuItem" then Obj.magic w
    else invalid_arg "Gtk.CheckMenuItem.cast"
  external coerce : [> checkmenuitem] obj -> check_menu_item obj = "%identity"
  external create : unit -> check_menu_item obj = "ml_gtk_check_menu_item_new"
  external create_with_label : string -> check_menu_item obj
      = "ml_gtk_check_menu_item_new_with_label"
  let create ?:label ?(_ : unit option) =
    match label with None -> create ()
    | Some label -> create_with_label label
  external set_active : [> checkmenuitem] obj -> bool -> unit
      = "ml_gtk_check_menu_item_set_active"
  external get_active : [> checkmenuitem] obj -> bool
      = "ml_gtk_check_menu_item_get_active"
  external set_show_toggle : [> checkmenuitem] obj -> bool -> unit
      = "ml_gtk_check_menu_item_set_show_toggle"
  let setter w :cont ?:active ?:show_toggle =
    may active fun:(set_active w);
    may show_toggle fun:(set_show_toggle w);
    cont w
  let set = setter ?cont:Container.set
  external toggled : [> checkmenuitem] obj -> unit
      = "ml_gtk_check_menu_item_toggled"
  module Signals = struct
    open Signal
    let toggled : ([> checkmenuitem],_) t =
      { name = "toggled"; marshaller = marshal_unit }
  end
end

module RadioMenuItem = struct
  let cast w : radio_menu_item obj =
    if Object.is_a w "GtkRadioMenuItem" then Obj.magic w
    else invalid_arg "Gtk.RadioMenuItem.cast"
  type group
  external create : group optpointer -> radio_menu_item obj
      = "ml_gtk_radio_menu_item_new"
  external create_with_label :
      group optpointer -> string -> radio_menu_item obj
      = "ml_gtk_radio_menu_item_new_with_label"
  let create ?:group ?:label ?(_ : unit option) =
    let group = optpointer group in
    match label with None -> create group
    | Some label -> create_with_label group label
  external group : [> radiomenuitem] obj -> group
      = "ml_gtk_radio_menu_item_group"
  external set_group : [> radiomenuitem] obj -> group -> unit
      = "ml_gtk_radio_menu_item_set_group"
  let setter w :cont ?:group =
    may group fun:(set_group w);
    cont w
  let set = setter ?cont:CheckMenuItem.set
end

module TreeItem = struct
  let cast w : tree_item obj =
    if Object.is_a w "GtkTreeItem" then Obj.magic w
    else invalid_arg "Gtk.TreeItem.cast"
  external create : unit -> tree_item obj = "ml_gtk_tree_item_new"
  external create_with_label : string -> tree_item obj
      = "ml_gtk_tree_item_new_with_label"
  let create ?:label ?(_ : unit option) =
    match label with None -> create ()
    | Some label -> create_with_label label
  external set_subtree : [> treeitem] obj -> [> widget] obj -> unit
      = "ml_gtk_tree_item_set_subtree"
  let setter w :cont ?:subtree =
    may subtree fun:(set_subtree w);
    cont w
  let set = setter ?cont:Container.set
  external remove_subtree : [> treeitem] obj -> unit
      = "ml_gtk_tree_item_remove_subtree"
  external expand : [> treeitem] obj -> unit
      = "ml_gtk_tree_item_expand"
  external collapse : [> treeitem] obj -> unit
      = "ml_gtk_tree_item_collapse"
  module Signals = struct
    open Signal
    let expand : ([> treeitem],_) t =
      { name = "expand"; marshaller = marshal_unit }
    let collapse : ([> treeitem],_) t =
      { name = "collapse"; marshaller = marshal_unit }
  end
end

module Viewport = struct
  let cast w : viewport obj =
    if Object.is_a w "GtkViewport" then Obj.magic w
    else invalid_arg "Gtk.Viewport.cast"
  external create :
      [> adjustment] optobj -> [> adjustment] optobj -> viewport obj
      = "ml_gtk_viewport_new"
  let create ?:hadjustment ?:vadjustment ?(_ : unit option) =
    create (optboxed hadjustment) (optboxed vadjustment)
  external get_hadjustment : [> viewport] obj -> adjustment obj
      = "ml_gtk_viewport_get_hadjustment"
  external get_vadjustment : [> viewport] obj -> adjustment obj
      = "ml_gtk_viewport_get_vadjustment"
  external set_hadjustment : [> viewport] obj -> [> adjustment] obj -> unit
      = "ml_gtk_viewport_set_hadjustment"
  external set_vadjustment : [> viewport] obj -> [> adjustment] obj -> unit
      = "ml_gtk_viewport_set_vadjustment"
  external set_shadow_type : [> viewport] obj -> shadow_type -> unit
      = "ml_gtk_viewport_set_shadow_type"
  let setter w :cont ?:hadjustment ?:vadjustment ?:shadow_type =
    may hadjustment fun:(set_hadjustment w);
    may vadjustment fun:(set_vadjustment w);
    may shadow_type fun:(set_shadow_type w);
    cont w
  let set = setter ?cont:Container.set
end

module Window = struct
  let cast w : window obj =
    if Object.is_a w "GtkWindow" then Obj.magic w
    else invalid_arg "Gtk.Window.cast"
  external coerce : [> window] obj -> window obj = "%identity"
  external create : window_type -> window obj = "ml_gtk_window_new"
  external set_title : [> window] obj -> string -> unit
      = "ml_gtk_window_set_title"
  external set_wmclass : [> window] obj -> name:string -> class:string -> unit
      = "ml_gtk_window_set_title"
  external get_wmclass_name : [> window] obj -> string
      = "ml_gtk_window_get_wmclass_name"
  external get_wmclass_class : [> window] obj -> string
      = "ml_gtk_window_get_wmclass_class"
  (* set_focus/default are called by Widget.grab_focus/default *)
  external set_focus : [> window] obj -> [> widget] obj -> unit
      = "ml_gtk_window_set_focus"
  external set_default : [> window] obj -> [> widget] obj -> unit
      = "ml_gtk_window_set_default"
  external set_policy :
      [> window] obj ->
      allow_shrink:bool -> allow_grow:bool -> auto_shrink:bool -> unit
      = "ml_gtk_window_set_policy"
  external get_allow_shrink : [> window] obj -> bool
      = "ml_gtk_window_get_allow_shrink"
  external get_allow_grow : [> window] obj -> bool
      = "ml_gtk_window_get_allow_grow"
  external get_auto_shrink : [> window] obj -> bool
      = "ml_gtk_window_get_auto_shrink"
  external activate_focus : [> window] obj -> bool
      = "ml_gtk_window_activate_focus"
  external activate_default : [> window] obj -> bool
      = "ml_gtk_window_activate_default"
  external set_modal : [>window] obj -> bool -> unit =
    "ml_gtk_window_set_modal"
  external set_default_size : [> window] obj -> int -> int -> unit =
    "ml_gtk_window_set_default_size"
  external set_position : [> window] obj -> window_position -> unit =
    "ml_gtk_window_set_position"
  external set_transient_for : [> window] obj ->[> window] obj -> unit =
    "ml_gtk_window_set_transient_for"

  let setter w :cont ?:title ?:wmclass_name ?:wmclass_class ?:position
      ?:allow_shrink ?:allow_grow ?:auto_shrink ?:modal
      ?:x [< -2 >] ?:y [< -2 >] =
    may title fun:(set_title w);
    if wmclass_name <> None || wmclass_class <> None then
      set_wmclass w name:(may_default get_wmclass_name w for:wmclass_name)
	class:(may_default get_wmclass_class w for:wmclass_class);
    may position fun:(set_position w);
    if allow_shrink <> None || allow_grow <> None || auto_shrink <> None then
      set_policy w
	allow_shrink:(may_default get_allow_shrink w for:allow_shrink)
	allow_grow:(may_default get_allow_grow w for:allow_grow)
	auto_shrink:(may_default get_auto_shrink w for:auto_shrink);
    may fun:(set_modal w) modal;
    if x > -2 || y > -2 then Widget.set_uposition w :x :y;
    cont w
  let set = setter ?cont:Container.set
  external add_accel_group : [> window] obj -> accel_group -> unit
      = "ml_gtk_window_add_accel_group"
  external remove_accel_group :
      [> window] obj -> accel_group -> unit
      = "ml_gtk_window_remove_accel_group"
  external activate_focus : [> window] obj -> unit
      = "ml_gtk_window_activate_focus"
  external activate_default : [> window] obj -> unit
      = "ml_gtk_window_activate_default"
  module Signals = struct
    open Signal
    let move_resize : ([> window],_) t =
      { name = "move_resize"; marshaller = marshal_unit }
    let set_focus : ([> window],_) t =
      { name = "set_focus"; marshaller = Widget.Signals.marshal }
  end
end

module Dialog = struct
  let cast w : dialog obj =
    if Object.is_a w "GtkDialog" then Obj.magic w
    else invalid_arg "Gtk.Dialog.cast"
  external create : unit -> dialog obj = "ml_gtk_dialog_new"
  external action_area : [> dialog] obj -> box obj
      = "ml_GtkDialog_action_area"
  external vbox : [> dialog] obj -> box obj
      = "ml_GtkDialog_vbox"
end

module InputDialog = struct
  let cast w : input_dialog obj =
    if Object.is_a w "GtkInputDialog" then Obj.magic w
    else invalid_arg "Gtk.InputDialog.cast"
  external create : unit -> input_dialog obj = "ml_gtk_input_dialog_new"
  module Signals = struct
    open Signal
    let enable_device : ([> inputdialog],_) t =
      { name = "enable_device"; marshaller = marshal_int }
    let disable_device : ([> inputdialog],_) t =
      { name = "disable_device"; marshaller = marshal_int }
  end
end

module FileSelection = struct
  let cast w : file_selection obj =
    if Object.is_a w "GtkFileSelection" then Obj.magic w
    else invalid_arg "Gtk.FileSelection.cast"
  external create : string -> file_selection obj = "ml_gtk_file_selection_new"
  external set_filename : [> filesel] obj -> string -> unit
      = "ml_gtk_file_selection_set_filename"
  external get_filename : [> filesel] obj -> string
      = "ml_gtk_file_selection_get_filename"
  external show_fileop_buttons : [> filesel] obj -> unit
      = "ml_gtk_file_selection_show_fileop_buttons"
  external hide_fileop_buttons : [> filesel] obj -> unit
      = "ml_gtk_file_selection_hide_fileop_buttons"
  external get_ok_button : [> filesel] obj -> button obj
      = "ml_gtk_file_selection_get_ok_button"
  external get_cancel_button : [> filesel] obj -> button obj
      = "ml_gtk_file_selection_get_cancel_button"
  external get_help_button : [> filesel] obj -> button obj
      = "ml_gtk_file_selection_get_help_button"
  let setter w :cont ?:filename ?:fileop_buttons =
    may filename fun:(set_filename w);
    may fileop_buttons fun:
      (fun b -> (if b then show_fileop_buttons else hide_fileop_buttons) w);
    cont w
  let set = setter ?cont:Window.set
end

module Box = struct
  let cast w : box obj =
    if Object.is_a w "GtkBox" then Obj.magic w
    else invalid_arg "Gtk.Box.cast"
  external coerce : [> box] obj -> box obj = "%identity"
  external pack_start :
      [> box] obj -> [> widget] obj ->
      expand:bool -> fill:bool -> padding:int -> unit
      = "ml_gtk_box_pack_start"
  external pack_end :
      [> box] obj -> [> widget] obj ->
      expand:bool -> fill:bool -> padding:int -> unit
      = "ml_gtk_box_pack_end"
  let pack box child ?from:dir [< (`START : pack_type) >]
      ?:expand [< true >] ?:fill [< true >] ?:padding [< 0 >] =
    (match dir with `START -> pack_start | `END -> pack_end)
      box child :expand :fill :padding
  external set_homogeneous : [> box] obj -> bool -> unit
      = "ml_gtk_box_set_homogeneous"
  external set_spacing : [> box] obj -> int -> unit
      = "ml_gtk_box_set_spacing"
  let setter w :cont ?:homogeneous ?:spacing =
    may homogeneous fun:(set_homogeneous w);
    may spacing fun:(set_spacing w);
    cont w
  let set = setter ?cont:Container.set
  type packing =
      { expand: bool; fill: bool; padding: int; pack_type: pack_type }
  external query_child_packing : [> box] obj -> [> widget] obj -> packing
      = "ml_gtk_box_query_child_packing"
  external set_child_packing :
      [> box] obj -> [> widget] obj ->
      ?expand:bool -> ?fill:bool -> ?padding:int -> ?from:pack_type -> unit
      = "ml_gtk_box_set_child_packing_bc" "ml_gtk_box_set_child_packing"
  external hbox_new : homogeneous:bool -> spacing:int -> box obj
      = "ml_gtk_hbox_new"
  external vbox_new : homogeneous:bool -> spacing:int -> box obj
      = "ml_gtk_vbox_new"
  let create (dir : orientation) ?:homogeneous [< false >] ?:spacing [< 0 >] =
    (match dir with `HORIZONTAL -> hbox_new | `VERTICAL -> vbox_new)
      :homogeneous :spacing
end

module BBox = struct
  (* Omitted defaults setting *)
  let cast w : bbox obj =
    if Object.is_a w "GtkBBox" then Obj.magic w
    else invalid_arg "Gtk.BBox.cast"
  external coerce : [> bbox] obj -> bbox obj = "%identity"
  type bbox_style = [ DEFAULT_STYLE SPREAD EDGE START END ]
  external get_spacing : [> bbox] obj -> int = "ml_gtk_button_box_get_spacing"
  external get_child_width : [> bbox] obj -> int
      = "ml_gtk_button_box_get_child_min_width"
  external get_child_height : [> bbox] obj -> int
      = "ml_gtk_button_box_get_child_min_height"
  external get_child_ipadx : [> bbox] obj -> int
      = "ml_gtk_button_box_get_child_ipad_x"
  external get_child_ipady : [> bbox] obj -> int
      = "ml_gtk_button_box_get_child_ipad_y"
  external get_layout : [> bbox] obj -> bbox_style
      = "ml_gtk_button_box_get_layout_style"
  external set_spacing : [> bbox] obj -> int -> unit
      = "ml_gtk_button_box_set_spacing"
  external set_child_size : [> bbox] obj -> width:int -> height:int -> unit
      = "ml_gtk_button_box_set_child_size"
  external set_child_ipadding : [> bbox] obj -> x:int -> y:int -> unit
      = "ml_gtk_button_box_set_child_ipadding"
  external set_layout : [> bbox] obj -> bbox_style -> unit
      = "ml_gtk_button_box_set_layout"
  let setter w :cont ?:spacing ?:child_width ?:child_height ?:child_ipadx
      ?:child_ipady ?:layout =
    may spacing fun:(set_spacing w);
    if child_width <> None || child_height <> None then
      set_child_size w width:(may_default get_child_width w for:child_width)
	height:(may_default get_child_height w for:child_height);
    if child_ipadx <> None || child_ipady <> None then
      set_child_ipadding w
	x:(may_default get_child_ipadx w for:child_ipadx)
	y:(may_default get_child_ipady w for:child_ipady);
    may layout fun:(set_layout w);
    cont w
  let set = setter ?cont:Box.set
  external set_child_size_default : width:int -> height:int -> unit
      = "ml_gtk_button_box_set_child_size_default"
  external set_child_ipadding_default : x:int -> y:int -> unit
      = "ml_gtk_button_box_set_child_ipadding_default"
  external create_hbbox : unit -> bbox obj = "ml_gtk_hbutton_box_new"
  external create_vbbox : unit -> bbox obj = "ml_gtk_vbutton_box_new"
  let create (dir : orientation) =
    if dir = `HORIZONTAL then create_hbbox () else create_vbbox ()
end

module GammaCurve = struct
  let cast w : gamma_curve obj =
    if Object.is_a w "GtkGammaCurve" then Obj.magic w
    else invalid_arg "Gtk.GammaCurve.cast"
  external create : unit -> gamma_curve obj = "ml_gtk_gamma_curve_new"
  external get_gamma : [> gamma] obj -> float = "ml_gtk_gamma_curve_get_gamma"
end

module ColorSelection = struct
  let cast w : color_selection obj =
    if Object.is_a w "GtkColorSelection" then Obj.magic w
    else invalid_arg "Gtk.ColorSelection.cast"
  external create : unit -> color_selection obj = "ml_gtk_color_selection_new"
  external create_dialog : string -> color_selection_dialog obj
      = "ml_gtk_color_selection_dialog_new"
  external set_update_policy : [> colorsel] obj -> update_type -> unit
      = "ml_gtk_color_selection_set_update_policy"
  external set_opacity : [> colorsel] obj -> bool -> unit
      = "ml_gtk_color_selection_set_opacity"
  let setter w :cont ?:update_policy ?:opacity =
    may update_policy fun:(set_update_policy w);
    may opacity fun:(set_opacity w);
    cont w
  let set = setter ?cont:Box.set
  external set_color :
      [> colorsel] obj ->
      red:float -> green:float -> blue:float -> ?opacity:float -> unit
      = "ml_gtk_color_selection_set_color"
  type color = { red: float; green: float; blue: float; opacity: float }
  external get_color : [> colorsel] obj -> color
      = "ml_gtk_color_selection_get_color"

  external ok_button : [> colorseldialog] obj -> button obj =
    "ml_gtk_color_selection_dialog_ok_button"
  external cancel_button : [> colorseldialog] obj -> button obj =
    "ml_gtk_color_selection_dialog_cancel_button"
  external help_button : [> colorseldialog] obj -> button obj =
    "ml_gtk_color_selection_dialog_help_button"
  external colorsel : [> colorseldialog] obj -> color_selection obj =
    "ml_gtk_color_selection_dialog_colorsel"
  module Signals = struct
    open Signal
    let color_changed : ([> colorsel],_) t =
      { name = "color_changed"; marshaller = marshal_unit }
  end
end

module Statusbar = struct
  let cast w : statusbar obj =
    if Object.is_a w "GtkStatusbar" then Obj.magic w
    else invalid_arg "Gtk.Statusbar.cast"
  type context
  type message
  external create : unit -> statusbar obj = "ml_gtk_statusbar_new"
  external get_context : [> statusbar] obj -> string -> context
      = "ml_gtk_statusbar_get_context_id"
  external push : [> statusbar] obj -> context -> text:string -> message
      = "ml_gtk_statusbar_push"
  external pop : [> statusbar] obj -> context ->  unit
      = "ml_gtk_statusbar_pop"
  external remove : [> statusbar] obj -> context -> message -> unit
      = "ml_gtk_statusbar_remove"
  module Signals = struct
    open Signal
    let text_pushed : ([> statusbar],_) t =
      let marshal f argv =
	f (Obj.magic (Argv.get_int argv pos:0) : context)
	  (Argv.get_string argv pos:1)
      in
      { name = "text_pushed"; marshaller = marshal }
  end
end

module Button = struct
  let cast w : button obj =
    if Object.is_a w "GtkButton" then Obj.magic w
    else invalid_arg "Gtk.Button.cast"
  external coerce : [> button] obj -> button obj = "%identity"
  external create : unit -> button obj = "ml_gtk_button_new"
  external create_with_label : string -> button obj
      = "ml_gtk_button_new_with_label"
  let create ?:label ?(_ : unit option) =
    match label with None -> create ()
    | Some x -> create_with_label x
  external pressed : [> button] obj -> unit = "ml_gtk_button_pressed"
  external released : [> button] obj -> unit = "ml_gtk_button_released"
  external clicked : [> button] obj -> unit = "ml_gtk_button_clicked"
  external enter : [> button] obj -> unit = "ml_gtk_button_enter"
  external leave : [> button] obj -> unit = "ml_gtk_button_leave"
  module Signals = struct
    open Signal
    let pressed : ([> button],_) t =
      { name = "pressed"; marshaller = marshal_unit }
    let released : ([> button],_) t =
      { name = "released"; marshaller = marshal_unit }
    let clicked : ([> button],_) t =
      { name = "clicked"; marshaller = marshal_unit }
    let enter : ([> button],_) t =
      { name = "enter"; marshaller = marshal_unit }
    let leave : ([> button],_) t =
      { name = "leave"; marshaller = marshal_unit }
  end
end

module ToggleButton = struct
  let cast w : toggle_button obj =
    if Object.is_a w "GtkToggleButton" then Obj.magic w
    else invalid_arg "Gtk.ToggleButton.cast"
  external coerce : [> toggle] obj -> toggle_button obj = "%identity"
  external toggle_button_create : unit -> toggle_button obj
      = "ml_gtk_toggle_button_new"
  external toggle_button_create_with_label : string -> toggle_button obj
      = "ml_gtk_toggle_button_new_with_label"
  external check_button_create : unit -> toggle_button obj
      = "ml_gtk_check_button_new"
  external check_button_create_with_label : string -> toggle_button obj
      = "ml_gtk_check_button_new_with_label"
  let create_toggle ?:label ?(_ : unit option) =
    match label with None -> toggle_button_create ()
    | Some label -> toggle_button_create_with_label label
  let create_check ?:label ?(_ : unit option) =
    match label with None -> check_button_create ()
    | Some label -> check_button_create_with_label label
  external set_mode : [> toggle] obj -> bool -> unit
      = "ml_gtk_toggle_button_set_mode"
  external set_active : [> toggle] obj -> bool -> unit
      = "ml_gtk_toggle_button_set_active"
  let setter w :cont ?:active ?:draw_indicator =
    may fun:(set_mode w) draw_indicator;
    may fun:(set_active w) active;
    cont w
  let set = setter ?cont:Container.set
  external get_active : [> toggle] obj -> bool
      = "ml_gtk_toggle_button_get_active"
  external toggled : [> toggle] obj -> unit
      = "ml_gtk_toggle_button_toggled"
  module Signals = struct
    open Signal
    let toggled : ([> toggle],_) t =
      { name = "toggled"; marshaller = marshal_unit }
  end
end

module RadioButton = struct
  let cast w : radio_button obj =
    if Object.is_a w "GtkRadioButton" then Obj.magic w
    else invalid_arg "Gtk.RadioButton.cast"
  type group
  external create : group optpointer -> radio_button obj
      = "ml_gtk_radio_button_new"
  external create_with_label : group optpointer -> string -> radio_button obj
      = "ml_gtk_radio_button_new_with_label"
  external group : [> radio] obj -> group = "ml_gtk_radio_button_group"
  external set_group : [> radio] obj -> group -> unit
      = "ml_gtk_radio_button_set_group"
  let setter w :cont ?:group =
    may group fun:(set_group w);
    cont w
  let set = setter ?cont:ToggleButton.set
  let create ?:group ?:label ?(_ : unit option) =
    let group = optpointer group in
    match label with None -> create group
    | Some label -> create_with_label group label
end

module OptionMenu = struct
  let cast w : option_menu obj =
    if Object.is_a w "GtkOptionMenu" then Obj.magic w
    else invalid_arg "Gtk.OptionMenu.cast"
  external create : unit -> option_menu obj = "ml_gtk_option_menu_new"
  external get_menu : [> optionmenu] obj -> menu obj
      = "ml_gtk_option_menu_get_menu"
  external set_menu : [> optionmenu] obj -> [> menu] obj -> unit
      = "ml_gtk_option_menu_set_menu"
  external remove_menu : [> optionmenu] obj -> unit
      = "ml_gtk_option_menu_remove_menu"
  external set_history : [> optionmenu] obj -> int -> unit
      = "ml_gtk_option_menu_set_history"
  let setter w :cont ?:menu ?:history =
    may menu fun:(set_menu w);
    may history fun:(set_history w);
    cont w
  let set = setter ?cont:Container.set
end

module CList = struct
  let cast w : clist obj =
    if Object.is_a w "GtkCList" then Obj.magic w
    else invalid_arg "Gtk.CList.cast"
  external create : cols:int -> clist obj = "ml_gtk_clist_new"
  external create_with_titles : string array -> clist obj
      = "ml_gtk_clist_new_with_titles"
  external set_selection_mode : [> clist] obj -> selection_mode -> unit
      = "ml_gtk_clist_set_selection_mode"
  let setter w :cont ?:selection_mode =
    may selection_mode fun:(set_selection_mode w);
    cont w
  let set = setter ?cont:Container.set
  external freeze : [> clist] obj -> unit = "ml_gtk_clist_freeze"
  external thaw : [> clist] obj -> unit = "ml_gtk_clist_thaw"
  external column_titles_show : [> clist] obj -> unit
      = "ml_gtk_clist_column_titles_show"
  external column_titles_hide : [> clist] obj -> unit
      = "ml_gtk_clist_column_titles_hide"
  external column_title_active : [> clist] obj -> int -> unit
      = "ml_gtk_clist_column_title_active"
  external column_title_passive : [> clist] obj -> int -> unit
      = "ml_gtk_clist_column_title_passive"
  external column_titles_active : [> clist] obj -> unit
      = "ml_gtk_clist_column_titles_active"
  external column_titles_passive : [> clist] obj -> unit
      = "ml_gtk_clist_column_titles_passive"
  external set_column_title : [> clist] obj -> int -> string -> unit
      = "ml_gtk_clist_set_column_title"
  external set_column_widget : [> clist] obj -> int -> [> widget] obj -> unit
      = "ml_gtk_clist_set_column_widget"
  external set_column_justification :
      [> clist] obj -> int -> justification -> unit
      = "ml_gtk_clist_set_column_justification"
  external set_column_width : [> clist] obj -> int -> int -> unit
      = "ml_gtk_clist_set_column_width"
  external set_row_height : [> clist] obj -> int -> unit
      = "ml_gtk_clist_set_row_height"
  external moveto :
      [> clist] obj ->
      int -> int -> row_align:clampf -> col_align:clampf -> unit
      = "ml_gtk_clist_moveto"
  external row_is_visible : [> clist] obj -> int -> visibility
      = "ml_gtk_clist_row_is_visible"
  type cell_type = [ EMPTY TEXT PIXMAP PIXTEXT WIDGET ]
  external get_cell_type : [> clist] obj -> int -> int -> cell_type
      = "ml_gtk_clist_get_cell_type"
  external set_text : [> clist] obj -> int -> int -> string -> unit
      = "ml_gtk_clist_set_text"
  external get_text : [> clist] obj -> int -> int -> string
      = "ml_gtk_clist_get_text"
  external set_pixmap :
      [> clist] obj -> int -> int -> Gdk.pixmap -> Gdk.bitmap -> unit
      = "ml_gtk_clist_set_pixmap"
  external get_pixmap : [> clist] obj -> int -> int -> Gdk.pixmap * Gdk.bitmap
      = "ml_gtk_clist_get_pixmap"
  external set_pixtext :
      [> clist] obj -> int -> int ->
      text:string -> spacing:int ->
      pixmap:Gdk.pixmap -> bitmap:Gdk.bitmap -> unit
      = "ml_gtk_clist_set_pixtext"
  type pixtext =
      { text: string; spacing: int; pixmap: Gdk.pixmap; bitmap: Gdk.bitmap }
  external get_pixtext : [> clist] obj -> int -> int -> pixtext
      = "ml_gtk_clist_get_pixtext"
  external set_foreground : [> clist] obj -> row:int -> Gdk.Color.t -> unit
      = "ml_gtk_clist_set_foreground"
  external set_background : [> clist] obj -> row:int -> Gdk.Color.t -> unit
      = "ml_gtk_clist_set_background"
  external set_shift :
      [> clist] obj -> int -> int -> vertical:int -> horizontal:int -> unit
      = "ml_gtk_clist_set_shift"
  external append : [> clist] obj -> string array -> int
      = "ml_gtk_clist_append"
  external insert : [> clist] obj -> int -> string array -> unit
      = "ml_gtk_clist_insert"
  external remove : [> clist] obj -> int -> unit
      = "ml_gtk_clist_remove"
  external select : [> clist] obj -> int -> int -> unit
      = "ml_gtk_clist_select_row"
  external unselect : [> clist] obj -> int -> int -> unit
      = "ml_gtk_clist_unselect_row"
  external clear : [> clist] obj -> unit = "ml_gtk_clist_clear"
  external get_row_column : [> clist] obj -> x:int -> y:int -> int * int
      = "ml_gtk_clist_get_selection_info"
  module Signals = struct
    open Signal
    let marshal_select f argv =
      let p = Argv.get_pointer argv pos:2 in
      let ev = Gdk.Event.unsafe_copy p in
      f row:(Argv.get_int argv pos:0) column:(Argv.get_pointer argv pos:1) ev
    let select_row : ([> clist],_) t =
      { name = "select_row"; marshaller = marshal_select }
    let unselect_row : ([> clist],_) t =
      { name = "unselect_row"; marshaller = marshal_select }
    let click_column : ([> clist],_) t =
      { name = "unselect_row"; marshaller = marshal_int }
  end
end

module Fixed = struct
  let cast w : fixed obj =
    if Object.is_a w "GtkFixed" then Obj.magic w
    else invalid_arg "Gtk.Fixed.cast"
  external create : unit -> fixed obj = "ml_gtk_fixed_new"
  external put : [> fixed] obj -> [> widget] obj -> x:int -> y:int -> unit
      = "ml_gtk_fixed_put"
  external move : [> fixed] obj -> [> widget] obj -> x:int -> y:int -> unit
      = "ml_gtk_fixed_move"
end

module GtkList = struct
  let cast w : gtk_list obj =
    if Object.is_a w "GtkList" then Obj.magic w
    else invalid_arg "Gtk.GtkList.cast"
  external create : unit -> gtk_list obj = "ml_gtk_list_new"
  external insert_item :
      [> list] obj -> [> listitem] obj -> pos:int -> unit
      = "ml_gtk_list_insert_item"
  let insert_items l wl :pos =
    let wl = if pos < 0 then wl else List.rev wl in
    List.iter wl fun:(insert_item l :pos)
  let append_items l = insert_items l pos:(-1)
  let prepend_items l = insert_items l pos:0
  external clear_items : [> list] obj -> start:int -> end:int -> unit =
    "ml_gtk_list_clear_items"
  external select_item : [> list] obj -> pos:int -> unit
      = "ml_gtk_list_select_item"
  external unselect_item : [> list] obj -> pos:int -> unit
      = "ml_gtk_list_unselect_item"
  external select_child : [> list] obj -> [> listitem] obj -> unit
      = "ml_gtk_list_select_child"
  external unselect_child : [> list] obj -> [> listitem] obj -> unit
      = "ml_gtk_list_unselect_child"
  external child_position : [> list] obj -> [> listitem] obj -> int
      = "ml_gtk_list_child_position"
  external set_selection_mode : [> list] obj -> selection_mode -> unit
      = "ml_gtk_list_set_selection_mode"
  let setter w :cont ?:selection_mode =
    may selection_mode fun:(set_selection_mode w);
    cont w
  let set = setter ?cont:Container.set
  module Signals = struct
    open Signal
    let selection_changed : ([> list],_) t =
      { name = "selection_changed"; marshaller = marshal_unit }
    let select_child : ([> list],_) t =
      { name = "select_child"; marshaller = Widget.Signals.marshal }
    let unselect_child : ([> list],_) t =
      { name = "unselect_child"; marshaller = Widget.Signals.marshal }
  end
end

module Combo = struct
  let cast w : combo obj =
    if Object.is_a w "GtkCombo" then Obj.magic w
    else invalid_arg "Gtk.Combo.cast"
  external create : unit -> combo obj = "ml_gtk_combo_new"
  external set_value_in_list :
      [> combo] obj -> bool -> ok_if_empty:bool -> unit
      = "ml_gtk_combo_set_value_in_list"
  external set_use_arrows : [> combo] obj -> bool -> unit
      = "ml_gtk_combo_set_use_arrows"
  external set_use_arrows_always : [> combo] obj -> bool -> unit
      = "ml_gtk_combo_set_use_arrows_always"
  external set_case_sensitive : [> combo] obj -> bool -> unit
      = "ml_gtk_combo_set_case_sensitive"
  external set_item_string : [> combo] obj -> [> item] obj -> string -> unit
      = "ml_gtk_combo_set_item_string"
  external entry : [> combo] obj -> entry obj= "ml_gtk_combo_entry"
  external list : [> combo] obj -> gtk_list obj= "ml_gtk_combo_list"
  let set_popdown_strings combo strings =
    GtkList.clear_items (list combo) start:0 end:(-1);
    List.iter strings fun:
      begin fun s ->
	let li = ListItem.create_with_label s in
	Widget.show li;
	Container.add (list combo) li
      end
  let setter w :cont ?:popdown_strings ?:use_arrows ?:use_arrows_always
      ?:case_sensitive =
    may popdown_strings fun:(set_popdown_strings w);
    may use_arrows fun:(set_use_arrows w);
    may use_arrows_always fun:(set_use_arrows_always w);
    may case_sensitive fun:(set_case_sensitive w);
    cont w
  let set = setter ?cont:Box.set
  external disable_activate : [> combo] obj -> unit
      = "ml_gtk_combo_disable_activate"
end

module MenuShell = struct
  let cast w : menu_shell obj =
    if Object.is_a w "GtkMenuShell" then Obj.magic w
    else invalid_arg "Gtk.MenuShell.cast"
  external coerce : [> menushell] obj -> menu_shell obj = "%identity"
  external append : [> menushell] obj -> [> widget] obj -> unit
      = "ml_gtk_menu_shell_append"
  external prepend : [> menushell] obj -> [> widget] obj -> unit
      = "ml_gtk_menu_shell_prepend"
  external insert : [> menushell] obj -> [> widget] obj -> pos:int -> unit
      = "ml_gtk_menu_shell_insert"
  external deactivate : [> menushell] obj -> unit
      = "ml_gtk_menu_shell_deactivate"
  module Signals = struct
    open Signal
    let deactivate : ([> menushell],_) t =
      { name = "deactivate"; marshaller = marshal_unit }
  end
end

module Menu = struct
  let cast w : menu obj =
    if Object.is_a w "GtkMenu" then Obj.magic w
    else invalid_arg "Gtk.Menu.cast"
  external create : unit -> menu obj = "ml_gtk_menu_new"
  external popup :
      [> menu] obj -> [> menushell] optobj ->
      [> menuitem] optobj -> button:int -> time:int -> unit
      = "ml_gtk_menu_popup"
  let popup w ?:parent_menu ?:parent_item =
    popup w (optboxed parent_menu) (optboxed parent_item)
  external popdown : [> menu] obj -> unit = "ml_gtk_menu_popdown"
  external get_active : [> menu] obj -> widget obj= "ml_gtk_menu_get_active"
  external set_active : [> menu] obj -> int -> unit = "ml_gtk_menu_set_active"
  external set_accel_group : [> menu] obj -> accel_group -> unit
      = "ml_gtk_menu_set_accel_group"
  external get_accel_group : [> menu] obj -> accel_group
      = "ml_gtk_menu_get_accel_group"
  external attach_to_widget : [> menu] obj -> [> widget] obj -> unit
      = "ml_gtk_menu_attach_to_widget"
  external get_attach_widget : [> menu] obj -> widget obj
      = "ml_gtk_menu_get_attach_widget"
  external detach : [> menu] obj -> unit = "ml_gtk_menu_detach"
  let setter w :cont ?:active ?:accel_group =
    may active fun:(set_active w);
    may accel_group fun:(set_accel_group w);
    cont w
  let set = setter ?cont:Container.set
end

module MenuBar = struct
  let cast w : menu_bar obj =
    if Object.is_a w "GtkMenuBar" then Obj.magic w
    else invalid_arg "Gtk.MenuBar.cast"
  external create : unit -> menu_bar obj = "ml_gtk_menu_bar_new"
end

module Notebook = struct
  let cast w : notebook obj =
    if Object.is_a w "GtkNotebook" then Obj.magic w
    else invalid_arg "Gtk.Notebook.cast"
  external create : unit -> notebook obj = "ml_gtk_notebook_new"
  external insert_page :
      [> notebook] obj -> [> widget] obj -> tab:[> widget] obj ->
      ?menu:[> widget] obj -> ?pos:int -> unit
      = "ml_gtk_notebook_insert_page_menu"
      (* default is append to end *)
  external remove_page : [> notebook] obj -> int -> unit
      = "ml_gtk_notebook_remove_page"
  external get_current_page : [> notebook] obj -> int
      = "ml_gtk_notebook_get_current_page"
  external set_page : [> notebook] obj -> int -> unit
      = "ml_gtk_notebook_set_page"
  external set_tab_pos : [> notebook] obj -> position -> unit
      = "ml_gtk_notebook_set_tab_pos"
  external set_show_tabs : [> notebook] obj -> bool -> unit
      = "ml_gtk_notebook_set_show_tabs"
  external set_show_border : [> notebook] obj -> bool -> unit
      = "ml_gtk_notebook_set_show_border"
  external set_scrollable : [> notebook] obj -> bool -> unit
      = "ml_gtk_notebook_set_scrollable"
  external set_tab_border : [> notebook] obj -> int -> unit
      = "ml_gtk_notebook_set_tab_border"
  external popup_enable : [> notebook] obj -> unit
      = "ml_gtk_notebook_popup_enable"
  external popup_disable : [> notebook] obj -> unit
      = "ml_gtk_notebook_popup_disable"
  let setter w :cont ?:page ?:tab_pos ?:show_tabs ?:show_border ?:scrollable
      ?:tab_border ?:popup =
    let may_set f = may fun:(f w) in
    may_set set_page page;
    may_set set_tab_pos tab_pos;
    may_set set_show_tabs show_tabs;
    may_set set_show_border show_border;
    may_set set_scrollable scrollable;
    may_set set_tab_border tab_border;
    may popup fun:(fun b -> (if b then popup_enable else popup_disable) w);
    cont w
  let set = setter ?cont:Container.set
  module Signals = struct
    open Signal
    let switch_page : ([> notebook],_) t =
      let marshal f argv = f (Argv.get_int argv pos:1) in
      { name = "notebook"; marshaller = marshal }
  end
end

module Packer = struct
  let cast w : packer obj =
    if Object.is_a w "GtkPacker" then Obj.magic w
    else invalid_arg "Gtk.Packer.cast"
  external create : unit -> packer obj = "ml_gtk_packer_new"
  external add :
      [> packer] obj -> [> widget] obj ->
      ?side:side_type -> ?anchor:anchor_type ->
      ?options:packer_options list ->
      ?border_width:int -> ?pad_x:int -> ?pad_y:int ->
      ?i_pad_x:int -> ?i_pad_y:int -> unit
      = "ml_gtk_packer_add_bc" "ml_gtk_packer_add"
  external add_defaults :
      [> packer] obj -> [> widget] obj ->
      ?side:side_type -> ?anchor:anchor_type ->
      ?options:packer_options list -> unit
      = "ml_gtk_packer_add_defaults"
  external set_child_packing :
      [> packer] obj -> [> widget] obj ->
      ?side:side_type -> ?anchor:anchor_type ->
      ?options:packer_options list ->
      ?border_width:int -> ?pad_x:int -> ?pad_y:int ->
      ?i_pad_x:int -> ?i_pad_y:int -> unit
      = "ml_gtk_packer_set_child_packing_bc" "ml_gtk_packer_set_child_packing"
  external reorder_child : [> packer] obj -> [> widget] obj -> pos:int -> unit
      = "ml_gtk_packer_reorder_child"
  external set_spacing : [> packer] obj -> int -> unit
      = "ml_gtk_packer_set_spacing"
  external set_defaults :
      [> packer] obj -> 
      ?side:side_type -> ?anchor:anchor_type ->
      ?options:packer_options list ->
      ?border_width:int -> ?pad_x:int -> ?pad_y:int ->
      ?i_pad_x:int -> ?i_pad_y:int -> unit
      = "ml_gtk_packer_set_defaults_bc" "ml_gtk_packer_set_defaults"
end

module Paned = struct
  let cast w : paned obj =
    if Object.is_a w "GtkPaned" then Obj.magic w
    else invalid_arg "Gtk.Paned.cast"
  external add1 : [> paned] obj -> [> widget] obj -> unit
      = "ml_gtk_paned_add1"
  external add2 : [> paned] obj -> [> widget] obj -> unit
      = "ml_gtk_paned_add2"
  let add w ?:fst ?:snd =
    may fun:(add1 w) fst;
    may fun:(add2 w) snd
  external set_handle_size : [> paned] obj -> int -> unit
      = "ml_gtk_paned_set_handle_size"
  external set_gutter_size : [> paned] obj -> int -> unit
      = "ml_gtk_paned_set_gutter_size"
  let setter w :cont ?:handle_size ?:gutter_size =
    may fun:(set_handle_size w) handle_size;
    may fun:(set_gutter_size w) gutter_size;
    cont w
  let set = setter ?cont:Container.set
  external hpaned_new : unit -> paned obj = "ml_gtk_hpaned_new"
  external vpaned_new : unit -> paned obj = "ml_gtk_vpaned_new"
  let create (dir : orientation) =
    if dir = `HORIZONTAL then hpaned_new () else vpaned_new ()
end

module ScrolledWindow = struct
  let cast w : scrolled_window obj =
    if Object.is_a w "GtkScrolledWindow" then Obj.magic w
    else invalid_arg "Gtk.ScrolledWindow.cast"
  external create :
      [> adjustment] optobj -> [> adjustment] optobj -> scrolled_window obj
      = "ml_gtk_scrolled_window_new"
  let create ?:hadjustment ?:vadjustment ?(_ : unit option) =
    create (optboxed hadjustment) (optboxed vadjustment)
  external get_hadjustment : [> scrolled] obj -> adjustment obj
      = "ml_gtk_scrolled_window_get_hadjustment"
  external get_vadjustment : [> scrolled] obj -> adjustment obj
      = "ml_gtk_scrolled_window_get_vadjustment"
  external set_policy :
      [> scrolled] obj -> horizontal:policy_type -> vertical:policy_type -> unit
      = "ml_gtk_scrolled_window_set_policy"
  external add_with_viewport : [> scrolled] obj -> [> widget] obj -> unit
      = "ml_gtk_scrolled_window_add_with_viewport"
  external get_hscrollbar_policy : [> scrolled] obj -> policy_type
      = "ml_gtk_scrolled_window_get_hscrollbar_policy"
  external get_vscrollbar_policy : [> scrolled] obj -> policy_type
      = "ml_gtk_scrolled_window_get_vscrollbar_policy"
  let setter w :cont ?:hscrollbar_policy ?:vscrollbar_policy =
    if hscrollbar_policy <> None || vscrollbar_policy <> None then
      set_policy w
	horizontal:(may_default get_hscrollbar_policy w for:hscrollbar_policy)
	vertical:(may_default get_vscrollbar_policy w for:vscrollbar_policy);
    cont w
  let set = setter ?cont:Container.set
  external add_with_viewport : [> scrolled] obj -> [> widget] obj -> unit
      = "ml_gtk_scrolled_window_add_with_viewport"
end

module Table = struct
  let cast w : table obj =
    if Object.is_a w "GtkTable" then Obj.magic w
    else invalid_arg "Gtk.Table.cast"
  external create : int -> int -> homogeneous:bool -> table obj
      = "ml_gtk_table_new"
  let create rows:r columns:c ?:homogeneous [< false >] =
    create r c :homogeneous
  external attach :
      [> table] obj -> [> widget] obj -> left:int -> right:int ->
      top:int -> bottom:int -> xoptions:attach_options list ->
      yoptions:attach_options list -> xpadding:int -> ypadding:int -> unit
      = "ml_gtk_table_attach_bc" "ml_gtk_table_attach"
  type dirs = [X Y BOTH NONE]
  let has_x : dirs -> bool = function `X|`BOTH -> true | `Y|`NONE -> false
  let has_y : dirs -> bool = function `Y|`BOTH -> true | `X|`NONE -> false
  let attach t w :left :top ?:right [< left+1 >] ?:bottom [< top+1 >]
      ?:expand [< `BOTH >] ?:fill [< `BOTH >]
      ?:shrink [< `NONE >] ?:xpadding [< 0 >] ?:ypadding [< 0 >] =
    let xoptions = if has_x shrink then [`SHRINK] else [] in
    let xoptions = if has_x fill then `FILL::xoptions else xoptions in
    let xoptions = if has_x expand then `EXPAND::xoptions else xoptions in
    let yoptions = if has_y shrink then [`SHRINK] else [] in
    let yoptions = if has_y fill then `FILL::yoptions else yoptions in
    let yoptions = if has_y expand then `EXPAND::yoptions else yoptions in
    attach t w :left :top :right :bottom :xoptions :yoptions
      :xpadding :ypadding
  external set_row_spacing : [> table] obj -> int -> int -> unit
      = "ml_gtk_table_set_row_spacing"
  external set_col_spacing : [> table] obj -> int -> int -> unit
      = "ml_gtk_table_set_col_spacing"
  external set_row_spacings : [> table] obj -> int -> unit
      = "ml_gtk_table_set_row_spacings"
  external set_col_spacings : [> table] obj -> int -> unit
      = "ml_gtk_table_set_col_spacings"
  external set_homogeneous : [> table] obj -> bool -> unit
      = "ml_gtk_table_set_homogeneous"
  let setter w :cont ?:row_spacings ?:col_spacings ?:homogeneous =
    may row_spacings fun:(set_row_spacings w);
    may col_spacings fun:(set_col_spacings w);
    may homogeneous fun:(set_homogeneous w);
    cont w
  let set = setter ?cont:Container.set
end

module Toolbar = struct
  let cast w : toolbar obj =
    if Object.is_a w "GtkToolbar" then Obj.magic w
    else invalid_arg "Gtk.Toolbar.cast"
  external create : orientation -> style:toolbar_style -> toolbar obj
      = "ml_gtk_toolbar_new"
  let create dir ?:style [< `BOTH >] = create dir :style
  external insert_space : [> toolbar] obj -> pos:int -> unit
      = "ml_gtk_toolbar_insert_space"
  let insert_space w ?:pos [< -1 >] = insert_space w :pos
  external insert_button :
      [> toolbar] obj -> type:[BUTTON TOGGLEBUTTON RADIOBUTTON] ->
      text:optstring -> tooltip:optstring -> tooltip_private:optstring ->
      icon:[> widget] optobj -> pos:int -> button obj
      = "ml_gtk_toolbar_insert_element_bc" "ml_gtk_toolbar_insert_element"
  let insert_button w ?type:t [< `BUTTON >] ?:text ?:tooltip ?:tooltip_private
      ?:icon ?:pos [< -1 >] ?:callback =
    let b =insert_button w type:t text:(optpointer text)
	tooltip:(optpointer tooltip)
	tooltip_private:(optpointer tooltip_private) icon:(optboxed icon)
	:pos in
    match callback with
    | None   -> b
    | Some c -> Signal.connect b sig:Button.Signals.clicked
	  callback: c; b
  external insert_widget :
      [> toolbar] obj -> [> widget] obj ->
      tooltip:optstring -> tooltip_private:optstring -> pos:int -> unit
      = "ml_gtk_toolbar_insert_widget"
  let insert_widget w w' ?:tooltip ?:tooltip_private ?:pos [< -1 >] =
    insert_widget w w' tooltip:(optpointer tooltip)
      tooltip_private:(optpointer tooltip_private) :pos
  external set_orientation : [> toolbar] obj -> orientation -> unit =
    "ml_gtk_toolbar_set_orientation"
  external set_style : [> toolbar] obj -> toolbar_style -> unit =
    "ml_gtk_toolbar_set_style"
  external set_space_size : [> toolbar] obj -> int -> unit =
    "ml_gtk_toolbar_set_space_size"
  external set_space_style : [> toolbar] obj -> [ EMPTY LINE ] -> unit =
    "ml_gtk_toolbar_set_space_style"
  external set_tooltips : [> toolbar] obj -> bool -> unit =
    "ml_gtk_toolbar_set_tooltips"
  external set_button_relief : [> toolbar] obj -> relief_type -> unit =
    "ml_gtk_toolbar_set_button_relief"
  external get_button_relief : [> toolbar] obj -> relief_type =
    "ml_gtk_toolbar_get_button_relief"
  let setter w :cont ?:space_size ?:space_style ?:tooltips ?:button_relief =
    may space_size fun:(set_space_size w);
    may space_style fun:(set_space_style w);
    may tooltips fun:(set_tooltips w);
    may button_relief fun:(set_button_relief w);
    cont w
    
  module Signals = struct
    open Signal
    external val_orientation : int -> orientation = "ml_Val_orientation"
    external val_toolbar_style : int -> toolbar_style
	= "ml_Val_toolbar_style"
    let orientation_changed : ([> toolbar],_) t =
      let marshal f argv = f (val_orientation (Argv.get_int argv pos:0)) in
      { name = "orientation_changed"; marshaller = marshal }
    let style_changed : ([> toolbar],_) t =
      let marshal f argv = f (val_toolbar_style (Argv.get_int argv pos:0)) in
      { name = "style_changed"; marshaller = marshal }
  end
end

module Tree = struct
  let cast w : tree obj =
    if Object.is_a w "GtkTree" then Obj.magic w
    else invalid_arg "Gtk.Tree.cast"
  external coerce : [> tree] obj -> tree obj = "%identity"
  external create : unit -> tree obj = "ml_gtk_tree_new"
  external insert : [> tree] obj -> [> treeitem] obj -> ?pos:int -> unit
      = "ml_gtk_tree_insert"
  external clear_items : [> tree] obj -> start:int -> end:int -> unit
      = "ml_gtk_tree_clear_items"
  external select_item : [> tree] obj -> pos:int -> unit
      = "ml_gtk_tree_select_item"
  external unselect_item : [> tree] obj -> pos:int -> unit
      = "ml_gtk_tree_unselect_item"
  external child_position : [> tree] obj -> [> treeitem] obj -> unit
      = "ml_gtk_tree_child_position"
  external set_selection_mode : [> tree] obj -> selection_mode -> unit
      = "ml_gtk_tree_set_selection_mode"
  external set_view_mode : [> tree] obj -> [LINE ITEM] -> unit
      = "ml_gtk_tree_set_view_mode"
  external set_view_lines : [> tree] obj -> bool -> unit
      = "ml_gtk_tree_set_view_lines"
  let setter w :cont ?:selection_mode ?:view_mode ?:view_lines =
    let may_set f = may fun:(f w) in
    may_set set_selection_mode selection_mode;
    may_set set_view_mode view_mode;
    may_set set_view_lines view_lines;
    cont w
  let set = setter ?cont:Container.set
  module Signals = struct
    open Signal
    let selection_changed : ([> tree],_) t =
      { name = "selection_changed"; marshaller = marshal_unit }
    let select_child : ([> tree],_) t =
      { name = "select_child"; marshaller = Widget.Signals.marshal }
    let unselect_child : ([> tree],_) t =
      { name = "unselect_child"; marshaller = Widget.Signals.marshal }
  end
end

module DrawingArea = struct
  let cast w : drawing_area =
    if Object.is_a w "GtkDrawingArea" then Obj.magic w
    else invalid_arg "Gtk.DrawingArea.cast"
  external create : unit -> drawing_area = "ml_gtk_drawing_area_new"
  external size : [> drawing] obj -> width:int -> height:int -> unit
      = "ml_gtk_drawing_area_size"
end

(* Does not seem very useful ...
module Curve = struct
  type t = [widget drawing curve] obj
  let cast w : t =
    if Object.is_a w "GtkCurve" then Obj.magic w
    else invalid_arg "Gtk.Curve.cast"
  external create : unit -> t = "ml_gtk_curve_new"
  external reset : [> curve] obj -> unit = "ml_gtk_curve_reset"
  external set_gamma : [> curve] obj -> float -> unit
      = "ml_gtk_curve_set_gamma"
  external set_range :
      [> curve] obj -> min_x:float -> max_x:float ->
      min_y:float -> max_y:float -> unit
      = "ml_gtk_curve_set_gamma"
end
*)

module Editable = struct
  let cast w : editable obj =
    if Object.is_a w "GtkEditable" then Obj.magic w
    else invalid_arg "Gtk.Editable.cast"
  external coerce : [> editable] obj -> editable obj = "%identity"
  external select_region : [> editable] obj -> start:int -> end:int -> unit
      = "ml_gtk_editable_select_region"
  external insert_text : [> editable] obj -> string -> pos:int -> int
      = "ml_gtk_editable_select_region"
  let insert_text w s ?:pos [< -1 >] = insert_text w s :pos
  external delete_text : [> editable] obj -> start:int -> end:int -> unit
      = "ml_gtk_editable_delete_text"
  external get_chars : [> editable] obj -> start:int -> end:int -> string
      = "ml_gtk_editable_get_chars"
  external cut_clipboard : [> editable] obj -> unit
      = "ml_gtk_editable_cut_clipboard"
  external copy_clipboard : [> editable] obj -> unit
      = "ml_gtk_editable_copy_clipboard"
  external paste_clipboard : [> editable] obj -> unit
      = "ml_gtk_editable_paste_clipboard"
  external claim_selection :
      [> editable] obj -> claim:bool -> time:int -> unit
      = "ml_gtk_editable_claim_selection"
  external delete_selection : [> editable] obj -> unit
      = "ml_gtk_editable_delete_selection"
  external changed : [> editable] obj -> unit = "ml_gtk_editable_changed"
  module Signals = struct
    open Signal
    let activate : ([> editable],_) t =
      { name = "activate"; marshaller = marshal_unit }
    let changed : ([> editable],_) t =
      { name = "changed"; marshaller = marshal_unit }
  end
end

module Entry = struct
  let cast w : entry obj =
    if Object.is_a w "GtkEntry" then Obj.magic w
    else invalid_arg "Gtk.Entry.cast"
  external coerce : [> entry] obj -> entry obj = "%identity"
  external create : unit -> entry obj = "ml_gtk_entry_new"
  external create_with_max_length : int -> entry obj
      = "ml_gtk_entry_new_with_max_length"
  let create ?:max_length ?(_ : unit option) =
    match max_length with None -> create ()
    | Some len -> create_with_max_length len
  external set_text : [> entry] obj -> string -> unit
      = "ml_gtk_entry_set_text"
  external append_text : [> entry] obj -> string -> unit
      = "ml_gtk_entry_append_text"
  external prepend_text : [> entry] obj -> string -> unit
      = "ml_gtk_entry_prepend_text"
  external set_position : [> entry] obj -> int -> unit
      = "ml_gtk_entry_set_position"
  external get_text : [> entry] obj -> string = "ml_gtk_entry_get_text"
  external set_visibility : [> entry] obj -> bool -> unit
      = "ml_gtk_entry_set_visibility"
  external set_editable : [> entry] obj -> bool -> unit
      = "ml_gtk_entry_set_editable"
  external set_max_length : [> entry] obj -> int -> unit
      = "ml_gtk_entry_set_max_length"
  let setter w :cont ?:text ?:position ?:visibility ?:editable ?:max_length =
    let may_set f = may fun:(f w) in
    may_set set_text text;
    may_set set_position position;
    may_set set_visibility visibility;
    may_set set_editable editable;
    may_set set_max_length max_length;
    cont w
  let set = setter ?cont:null_cont
  external text_length : [> entry] obj -> int
      = "ml_GtkEntry_text_length"
end

module SpinButton = struct
  let cast w : spin_button obj =
    if Object.is_a w "GtkSpinButton" then Obj.magic w
    else invalid_arg "Gtk.SpinButton.cast"
  external create :
      [> adjustment] optobj -> rate:float -> digits:int -> spin_button obj
      = "ml_gtk_spin_button_new"
  let create ?:adjustment = create (optboxed adjustment)
  external configure :
    [> spinbutton] obj -> adjustment:[> adjustment] optobj ->
    rate:float -> digits:int -> unit
    = "ml_gtk_spin_button_configure"
  let configure w ?:adjustment = configure w adjustment:(optboxed adjustment)
  external set_adjustment : [> spinbutton] obj -> [> adjustment] obj -> unit
      = "ml_gtk_spin_button_set_adjustment"
  external get_adjustment : [> spinbutton] obj -> adjustment obj
      = "ml_gtk_spin_button_get_adjustment"
  external set_digits : [> spinbutton] obj -> int -> unit
      = "ml_gtk_spin_button_set_digits"
  external get_value : [> spinbutton] obj -> float
      = "ml_gtk_spin_button_get_value_as_float"
  let get_value_as_int w = floor (get_value w +. 0.5)
  external set_value : [> spinbutton] obj -> float -> unit
      = "ml_gtk_spin_button_set_value"
  type update_policy = [ ALWAYS IF_VALID SNAP_TO_TICKS ]
  external set_update_policy : [> spinbutton] obj -> update_policy -> unit
      = "ml_gtk_spin_button_set_update_policy"
  external set_numeric : [> spinbutton] obj -> bool -> unit
      = "ml_gtk_spin_button_set_numeric"
  external spin : [> spinbutton] obj -> [UP DOWN] -> step:float -> unit
      = "ml_gtk_spin_button_spin"
  external set_wrap : [> spinbutton] obj -> bool -> unit
      = "ml_gtk_spin_button_set_wrap"
  external set_shadow_type : [> spinbutton] obj -> shadow_type -> unit
      = "ml_gtk_spin_button_set_shadow_type"
  external set_snap_to_ticks : [> spinbutton] obj -> bool -> unit
      = "ml_gtk_spin_button_set_snap_to_ticks"
  external update : [> spinbutton] obj -> unit
      = "ml_gtk_spin_button_update"
  let setter w :cont ?:adjustment ?:digits ?:value ?:update_policy
      ?:numeric ?:wrap ?:shadow_type ?:snap_to_ticks =
    let may_set f = may fun:(f w) in
    may_set set_adjustment adjustment;
    may_set set_digits digits;
    may_set set_value value;
    may_set set_update_policy update_policy;
    may_set set_numeric numeric;
    may_set set_wrap wrap;
    may_set set_shadow_type shadow_type;
    may_set set_snap_to_ticks snap_to_ticks;
    cont w
  let set = setter ?cont:Entry.set
end

module Text = struct
  let cast w : text obj =
    if Object.is_a w "GtkText" then Obj.magic w
    else invalid_arg "Gtk.Text.cast"
  external create : [> adjustment] optobj -> [> adjustment] optobj -> text obj
      = "ml_gtk_text_new"
  let create ?:hadjustment ?:vadjustment ?(_ : unit option) =
    create (optboxed hadjustment) (optboxed vadjustment)
  external set_editable : [> text] obj -> bool -> unit
      = "ml_gtk_text_set_editable"
  external set_word_wrap : [> text] obj -> bool -> unit
      = "ml_gtk_text_set_word_wrap"
  external set_adjustments :
      [> text] obj -> [> adjustment] optobj -> [> adjustment] optobj -> unit
      = "ml_gtk_text_set_adjustments"
  let set_adjustment w ?:horizontal ?:vertical =
    set_adjustments w (optboxed horizontal) (optboxed vertical)
  external set_point : [> text] obj -> int -> unit
      = "ml_gtk_text_set_point"
  external get_point : [> text] obj -> int = "ml_gtk_text_get_point"
  external get_length : [> text] obj -> int = "ml_gtk_text_get_length"
  external freeze : [> text] obj -> unit = "ml_gtk_text_freeze"
  external thaw : [> text] obj -> unit = "ml_gtk_text_thaw"
  external insert :
      [> text] obj -> ?font:Gdk.font -> ?foreground:Gdk.Color.t ->
      ?background:Gdk.Color.t -> string -> unit
      = "ml_gtk_text_insert"
  let setter w :cont ?:editable ?:word_wrap ?:point =
    may editable fun:(set_editable w);
    may word_wrap fun:(set_word_wrap w);
    may point fun:(set_point w);
    cont w
  let set = setter ?cont:null_cont
end

module Misc = struct
  let cast w : misc obj =
    if Object.is_a w "GtkMisc" then Obj.magic w
    else invalid_arg "Gtk.Misc.cast"
  external coerce : [> misc] obj -> misc obj = "%identity"
  external set_alignment : [> misc] obj -> x:float -> y:float -> unit
      = "ml_gtk_misc_set_alignment"
  external set_padding : [> misc] obj -> x:int -> y:int -> unit
      = "ml_gtk_misc_set_padding"
  external get_xalign : [> misc] obj -> float = "ml_gtk_misc_get_xalign"
  external get_yalign : [> misc] obj -> float = "ml_gtk_misc_get_yalign"
  external get_xpad : [> misc] obj -> int = "ml_gtk_misc_get_xpad"
  external get_ypad : [> misc] obj -> int = "ml_gtk_misc_get_ypad"
  let setter w :cont ?:xalign ?:yalign ?:xpad ?:ypad =
    if xalign <> None || yalign <> None then
      set_alignment w x:(may_default get_xalign w for:xalign)
	y:(may_default get_yalign w for:yalign);
    if xpad <> None || ypad <> None then
      set_padding w x:(may_default get_xpad w for:xpad)
	y:(may_default get_ypad w for:ypad);
    cont w
  let set = setter ?cont:null_cont
end

module Arrow = struct
  let cast w : arrow obj =
    if Object.is_a w "GtkArrow" then Obj.magic w
    else invalid_arg "Gtk.Arrow.cast"
  external create : type:arrow_type -> shadow:shadow_type -> arrow obj
      = "ml_gtk_arrow_new"
  external set : [> arrow] obj -> type:arrow_type -> shadow:shadow_type -> unit
      = "ml_gtk_arrow_set"
end

module Image = struct
  let cast w : image obj =
    if Object.is_a w "GtkImage" then Obj.magic w
    else invalid_arg "Gtk.Image.cast"
  external create : Gdk.image -> ?mask:Gdk.bitmap -> image obj
      = "ml_gtk_image_new"
  external set : [> image] obj -> Gdk.image -> ?mask:Gdk.bitmap -> unit
      = "ml_gtk_image_set"
end

module Label = struct
  let cast w : label obj =
    if Object.is_a w "GtkLabel" then Obj.magic w
    else invalid_arg "Gtk.Label.cast"
  external coerce : [> label] obj -> label obj = "%identity"
  external create : string -> label obj = "ml_gtk_label_new"
  external set_text : [> label] obj -> string -> unit = "ml_gtk_label_set_text"
  external set_justify : [> label] obj -> justification -> unit
      = "ml_gtk_label_set_justify"
  let setter w :cont ?:text ?:justify =
    may fun:(set_text w) text;
    may fun:(set_justify w) justify;
    cont w
  let set = setter ?cont:Misc.set
  external get_text : [> label] obj -> string = "ml_gtk_label_get_label"
end

module TipsQuery = struct
  let cast w : tips_query obj =
    if Object.is_a w "GtkTipsQuery" then Obj.magic w
    else invalid_arg "Gtk.TipsQuery.cast"
  external create : unit -> tips_query obj = "ml_gtk_tips_query_new"
  external start : [> tipsquery] obj -> unit = "ml_gtk_tips_query_start_query"
  external stop : [> tipsquery] obj -> unit = "ml_gtk_tips_query_stop_query"
  external set_caller : [> tipsquery] obj -> [> widget] obj -> unit
      = "ml_gtk_tips_query_set_caller"
  external set_labels :
      [> tipsquery] obj -> inactive:string -> no_tip:string -> unit
      = "ml_gtk_tips_query_set_labels"
  external set_emit_always : [> tipsquery] obj -> bool -> unit
      = "ml_gtk_tips_query_set_emit_always"
  external get_caller : [> tipsquery] obj -> widget obj
      = "ml_gtk_tips_query_get_caller"
  external get_label_inactive : [> tipsquery] obj -> string
      = "ml_gtk_tips_query_get_label_inactive"
  external get_label_no_tip : [> tipsquery] obj -> string
      = "ml_gtk_tips_query_get_label_no_tip"
  external get_emit_always : [> tipsquery] obj -> bool
      = "ml_gtk_tips_query_get_emit_always"
  let setter w :cont ?:caller ?:emit_always ?:label_inactive ?:label_no_tip =
    may caller fun:(set_caller w);
    may emit_always fun:(set_emit_always w);
    if label_inactive <> None || label_no_tip <> None then
      set_labels w
	inactive:(may_default get_label_inactive w for:label_inactive)
	no_tip:(may_default get_label_no_tip w for:label_no_tip);
    cont w
  let set = setter ?cont:Misc.set
  module Signals = struct
    open Signal
    let start_query : ([> tipsquery],_) t =
      { name = "start_query"; marshaller = marshal_unit }
    let stop_query : ([> tipsquery],_) t =
      { name = "stop_query"; marshaller = marshal_unit }
    let widget_entered :
	([> tipsquery],
	 widget obj option-> string option -> string option -> unit) t =
      let marshal f argv =
	f (try Some (Widget.cast (Argv.get_object argv pos:0))
	   with Null_pointer -> None)
	  (try Some(Argv.get_string argv pos:1) with Null_pointer -> None)
	  (try Some(Argv.get_string argv pos:2) with Null_pointer -> None) in
      { name = "widget_entered"; marshaller = marshal }
    let widget_selected :
	([> tipsquery],
	 widget obj option ->
	 string option -> string option -> Gdk.Event.Button.t -> bool) t =
      let marshal f argv =
	let stop = 
	  f (try Some (Widget.cast (Argv.get_object argv pos:0))
	     with Null_pointer -> None)
	    (try Some(Argv.get_string argv pos:1) with Null_pointer -> None)
	    (try Some(Argv.get_string argv pos:2) with Null_pointer -> None)
	    (Gdk.Event.unsafe_copy (Argv.get_pointer argv pos:3)) in
	Argv.set_result_bool argv stop in
      { name = "widget_selected"; marshaller = marshal }
  end
end

module Pixmap = struct
  let cast w : pixmap obj =
    if Object.is_a w "GtkPixmap" then Obj.magic w
    else invalid_arg "Gtk.Pixmap.cast"
  external create : Gdk.pixmap -> ?mask:Gdk.bitmap -> pixmap obj
      = "ml_gtk_pixmap_new"
  external set :
      [> pixmap] obj -> ?pixmap:Gdk.pixmap -> ?mask:Gdk.bitmap -> unit
      = "ml_gtk_pixmap_set"
  let setter w :cont ?:pixmap ?:mask =
    if pixmap <> None || mask <> None then
      set w ?:pixmap ?:mask;
    cont w
  let set = setter ?cont:Misc.set
  external pixmap : [> pixmap] obj -> Gdk.pixmap = "ml_GtkPixmap_pixmap"
  external mask : [> pixmap] obj -> Gdk.bitmap = "ml_GtkPixmap_mask"
end

module Progress = struct
  let cast w : progress obj =
    if Object.is_a w "GtkProgress" then Obj.magic w
    else invalid_arg "Gtk.Progress.cast"
  external set_show_text : [> progress] obj -> bool -> unit
      = "ml_gtk_progress_set_show_text"
  external set_text_alignment :
      [> progress] obj -> ?x:float -> ?y:float -> unit
      = "ml_gtk_progress_set_show_text"
  external set_format_string : [> progress] obj -> string -> unit
      = "ml_gtk_progress_set_format_string"
  external set_adjustment : [> progress] obj -> [> adjustment] obj -> unit
      = "ml_gtk_progress_set_adjustment"
  external configure :
      [> progress] obj -> current:float -> min:float -> max:float -> unit
      = "ml_gtk_progress_configure"
  external set_percentage : [> progress] obj -> float -> unit
      = "ml_gtk_progress_set_percentage"
  external set_value : [> progress] obj -> float -> unit
      = "ml_gtk_progress_set_value"
  external get_value : [> progress] obj -> float
      = "ml_gtk_progress_get_value"
  external get_percentage : [> progress] obj -> float
      = "ml_gtk_progress_get_current_percentage"
  external set_activity_mode : [> progress] obj -> bool -> unit
      = "ml_gtk_progress_set_activity_mode"
  external get_current_text : [> progress] obj -> string
      = "ml_gtk_progress_get_current_text"
  external get_adjustment : [> progress] obj -> adjustment obj
      = "ml_gtk_progress_get_adjustment"
end

module ProgressBar = struct
  let cast w : progress_bar obj =
    if Object.is_a w "GtkProgressBar" then Obj.magic w
    else invalid_arg "Gtk.ProgressBar.cast"
  external create : unit -> progress_bar obj = "ml_gtk_progress_bar_new"
  external update : [> progressbar] obj -> percent:float -> unit
      = "ml_gtk_progress_bar_update"
end

module Range = struct
  let cast w : range obj =
    if Object.is_a w "GtkRange" then Obj.magic w
    else invalid_arg "Gtk.Range.cast"
  external coerce : [> range] obj -> range obj = "%identity"
  external get_adjustment : [> range] obj -> adjustment obj
      = "ml_gtk_range_get_adjustment"
  external set_adjustment : [> range] obj -> [> adjustment] obj -> unit
      = "ml_gtk_range_set_adjustment"
  external set_update_policy : [> range] obj -> update_type -> unit
      = "ml_gtk_range_set_update_policy"
  let setter w :cont ?:adjustment ?:update_policy =
    may adjustment fun:(set_adjustment w);
    may update_policy fun:(set_update_policy w);
    cont w
  let set = setter ?cont:null_cont
end

module Scale = struct
  let cast w : scale obj =
    if Object.is_a w "GtkScale" then Obj.magic w
    else invalid_arg "Gtk.Scale.cast"
  external hscale_new : [> adjustment] optobj -> scale obj
      = "ml_gtk_hscale_new"
  external vscale_new : [> adjustment] optobj -> scale obj
      = "ml_gtk_vscale_new"
  let create (dir : orientation) ?:adjustment =
    let create = if dir = `HORIZONTAL then hscale_new else vscale_new  in
    create (optboxed adjustment)
  external set_digits : [> scale] obj -> int -> unit
      = "ml_gtk_scale_set_digits"
  external set_draw_value : [> scale] obj -> bool -> unit
      = "ml_gtk_scale_set_draw_value"
  external set_value_pos : [> scale] obj -> position -> unit
      = "ml_gtk_scale_set_value_pos"
  external get_value_width : [> scale] obj -> int
      = "ml_gtk_scale_get_value_width"
  external draw_value : [> scale] obj -> unit
      = "ml_gtk_scale_draw_value"
  let setter w :cont ?:digits ?:draw_value ?:value_pos =
    may digits fun:(set_digits w);
    may draw_value fun:(set_draw_value w);
    may value_pos fun:(set_value_pos w);
    cont w
  let set = setter ?cont:Range.set
end

module Scrollbar = struct
  let cast w : scrollbar obj =
    if Object.is_a w "GtkScrollbar" then Obj.magic w
    else invalid_arg "Gtk.Scrollbar.cast"
  external hscrollbar_new : [> adjustment] optobj -> scrollbar obj
      = "ml_gtk_hscrollbar_new"
  external vscrollbar_new : [> adjustment] optobj -> scrollbar obj
      = "ml_gtk_vscrollbar_new"
  let create (dir : orientation) ?:adjustment =
    let create = if dir = `HORIZONTAL then hscrollbar_new else vscrollbar_new
    in create (optboxed adjustment)
end

module Ruler = struct
  let cast w : ruler obj =
    if Object.is_a w "GtkRuler" then Obj.magic w
    else invalid_arg "Gtk.Ruler.cast"
  external hruler_new : unit -> ruler obj = "ml_gtk_hruler_new"
  external vruler_new : unit -> ruler obj = "ml_gtk_vruler_new"
  let create (dir : orientation) =
    if dir = `HORIZONTAL then hruler_new () else vruler_new ()
  external set_metric : [> ruler] obj -> metric_type -> unit
      = "ml_gtk_ruler_set_metric"
  external set_range :
      [> ruler] obj ->
      lower:float -> upper:float -> position:float -> max_size:float -> unit
      = "ml_gtk_ruler_set_range"
  external get_lower : [> ruler] obj -> float = "ml_gtk_ruler_get_lower"
  external get_upper : [> ruler] obj -> float = "ml_gtk_ruler_get_upper"
  external get_position : [> ruler] obj -> float = "ml_gtk_ruler_get_position"
  external get_max_size : [> ruler] obj -> float = "ml_gtk_ruler_get_max_size"
  let setter w :cont ?:metric ?:lower ?:upper ?:position ?:max_size =
    may metric fun:(set_metric w);
    if lower <> None || upper <> None || position <> None || max_size <> None
    then
      set_range w lower:(may_default get_lower w for:lower)
	upper:(may_default get_upper w for:upper)
	position:(may_default get_position w for:position)
	max_size:(may_default get_max_size w for:max_size);
    cont w
  let set = setter ?cont:null_cont
end

module Separator = struct
  let cast w : separator obj =
    if Object.is_a w "GtkSeparator" then Obj.magic w
    else invalid_arg "Gtk.Separator.cast"
  external hseparator_new : unit -> separator obj = "ml_gtk_hseparator_new"
  external vseparator_new : unit -> separator obj = "ml_gtk_vseparator_new"
  let create (dir : orientation) =
    if dir = `HORIZONTAL then hseparator_new () else vseparator_new ()
end

module Main = struct
  external init : string array -> string array = "ml_gtk_init"
  (* external exit : int -> unit = "ml_gtk_exit" *)
  external set_locale : unit -> string = "ml_gtk_set_locale"
  (* external main : unit -> unit = "ml_gtk_main" *)
  let locale = set_locale ()
  let argv = init Sys.argv
  open Glib
  let loops = ref [] 
  let main () =
    let loop = (Main.create true) in
    loops := loop :: !loops;
    while Main.is_running loop do Main.iteration true done;
    loops := List.tl !loops
  and quit () = Main.quit (List.hd !loops)
  external get_version : unit -> int * int * int = "ml_gtk_get_version"
  let version = get_version ()
end

module Grab = struct
  external add : [> widget] obj -> unit = "ml_gtk_grab_add"
  external remove : [> widget] obj -> unit = "ml_gtk_grab_remove"
  external get_current : unit -> widget obj= "ml_gtk_grab_get_current"
end

let _ = Glib.set_warning_handler (fun msg -> raise (Warning msg))
let _ = Glib.set_print_handler (fun msg -> print_string msg)

module New = struct
  type t
type object_type =
  | OBJECT  | WIDGET  | MISC  | LABEL  | ACCELLABEL  | TIPSQUERY  | ARROW
  | IMAGE   | PIXMAP  | CONTAINER  | BIN  | ALIGNMENT  | FRAME  | ASPECTFRAME
  | BUTTON  | TOGGLEBUTTON  | CHECKBUTTON  | RADIOBUTTON  | OPTIONMENU
  | ITEM  | MENUITEM  | CHECKMENUITEM  | RADIOMENUITEM  | TEAROFFMENUITEM
  | LISTITEM  | TREEITEM  | WINDOW  | COLORSELECTIONDIALOG  | DIALOG
  | INPUTDIALOG  | FILESELECTION  | FONTSELECTIONDIALOG  | PLUG
  | EVENTBOX  | HANDLEBOX  | SCROLLEDWINDOW  | VIEWPORT  | BOX
  | BUTTONBOX  | HBUTTONBOX  | VBUTTONBOX  | VBOX  | COLORSELECTION
  | GAMMACURVE  | HBOX  | COMBO  | STATUSBAR  | CLIST  | CTREE  | FIXED
  | NOTEBOOK  | FONTSELECTION  | PANED  | HPANED  | VPANED  | LAYOUT
  | LIST  | MENUSHELL  | MENUBAR  | MENU  | PACKER  | SOCKET  | TABLE
  | TOOLBAR  | TREE  | CALENDAR  | DRAWINGAREA  | CURVE  | EDITABLE
  | ENTRY  | SPINBUTTON  | TEXT  | RULER  | HRULER  | VRULER  | RANGE
  | SCALE  | HSCALE  | VSCALE  | SCROLLBAR  | HSCROLLBAR  | VSCROLLBAR
  | SEPARATOR  | HSEPARATOR  | VSEPARATOR  | PREVIEW  | PROGRESS
  | PROGRESSBAR  | DATA  | ADJUSTMENT  | TOOLTIPS  | ITEMFACTORY

  external set_ml_class_init  : (t -> unit) -> unit = "set_ml_class_init"
  external signal_new : string -> int -> t -> object_type -> int  -> int
      = "ml_gtk_signal_new"
  external object_class_add_signals : t -> int array -> int -> unit
      = "ml_gtk_object_class_add_signals"
  external type_unique : string -> parent:object_type -> nsignals:int -> int
      = "ml_gtk_type_unique"
  external type_new : int -> [> widget] obj
      = "ml_gtk_type_new"

let new_widget_get_type name :parent :nsignals =
  let new_type = lazy (type_unique name :parent :nsignals) in
  fun () -> Lazy.force new_type

open Signal

let make_new_widget name :parent :signal_array =
  let nsignals = Array.length signal_array in
  let class_init_func classe =
    let signal_num_array = Array.create len:nsignals fill:0 in
    for i = 0 to nsignals-1 do
      signal_num_array.(i) <- signal_new signal_array.(i).name 1 classe parent i
    done;
    object_class_add_signals classe signal_num_array nsignals in
  fun () ->
    set_ml_class_init class_init_func;
    type_new (new_widget_get_type name :parent :nsignals ())
end

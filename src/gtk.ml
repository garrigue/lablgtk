(* $Id$ *)

open Misc

exception Error of string
let _ = Callback.register_exception "gtkerror" (Error"")
exception Warning of string
let _ = Glib.set_warning_handler (fun msg -> raise (Warning msg))
let _ = Glib.set_print_handler (fun msg -> print_string msg; flush stdout)

type 'a obj
type clampf = float

type 'a optobj
let optobj : 'a obj option -> 'a optobj =
  function
      None -> Obj.magic (0,null)
    | Some obj -> Obj.magic obj

module Tags = struct
  type state = [ NORMAL ACTIVE PRELIGHT SELECTED INSENSITIVE ] 
  type window_type = [ TOPLEVEL DIALOG POPUP ]
  type direction = [ TAB_FORWARD TAB_BACKWARD UP DOWN LEFT RIGHT ]
  type shadow = [ NONE IN OUT ETCHED_IN ETCHED_OUT ]
  type arrow = [ UP DOWN LEFT RIGHT ]
  type pack_type = [ START END ]
  type policy = [ ALWAYS AUTOMATIC ]
  type update = [ CONTINUOUS DISCONTINUOUS DELAYED ]
  type attach = [ EXPAND SHRINK FILL ]
  type signal_run = [ FIRST LAST BOTH MASK NO_RECURSE ]
  type window_position = [ NONE CENTER MOUSE ]
  type submenu_direction = [ LEFT RIGHT ]
  type submenu_placement = [ TOP_BOTTOM LEFT_RIGHT ]
  type menu_factory = [ MENU MENU_BAR OPTION_MENU ]
  type metric = [ PIXELS INCHES CENTIMETERS ]
  type scroll =
      [ NONE STEP_FORWARD STEP_BACKWARD PAGE_BACKWARD PAGE_FORWARD JUMP ]
  type through = [ NONE START END JUMP ]
  type position = [ LEFT RIGHT TOP BOTTOM ]
  type preview = [ COLOR GRAYSCALE ]
  type justification = [ LEFT RIGHT CENTER FILL ]
  type selection = [ SINGLE BROWSE MULTIPLE EXTENDED ]
  type orientation = [ HORIZONTAL VERTICAL ]
  type toolbar_style = [ ICONS TEXT BOTH ]
  type visibility = [ NONE PARTIAL FULL ]
  type fundamental_type =
    [ INVALID NONE CHAR BOOL INT UINT LONG ULONG FLOAT DOUBLE
      STRING ENUM FLAGS BOXED FOREIGN CALLBACK ARGS POINTER
      SIGNAL C_CALLBACK OBJECT ]
end
open Tags

module Type = struct
  type t
  type klass
  external name : t -> string = "ml_gtk_type_name"
  external from_name : string -> t = "ml_gtk_type_from_name"
  external parent : t -> t = "ml_gtk_type_parent"
  external get_class : t -> klass = "ml_gtk_type_class"
  external parent_class : t -> klass = "ml_gtk_type_parent_class"
  external is_a : t -> t -> bool = "ml_gtk_type_is_a"
  external fundamental : t -> fundamental_type = "ml_gtk_type_fundamental"
end

module Arg = struct
  type t
  external shift : t -> pos:int -> t = "ml_gtk_arg_shift"
  external get_type : t -> Type.t = "ml_gtk_arg_get_type"
  (* Safely get an argument *)
  external get_char : t -> char = "ml_gtk_arg_get_char"
  external get_bool : t -> bool = "ml_gtk_arg_get_bool"
  external get_int : t -> int = "ml_gtk_arg_get_int"
  external get_float : t -> float = "ml_gtk_arg_get_float"
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
  external set_object : t -> unit obj -> unit = "ml_gtk_arg_set_object"
end

module Argv = struct
  open Arg
  type raw_obj
  type t = { referent: raw_obj; nargs: int; args: Arg.t }
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
      'a obj -> name:string -> cb:(Argv.t -> unit) -> after:bool -> id
      = "ml_gtk_signal_connect"
  let connect : 'a obj -> sig:('a, _) t -> _ =
    fun obj sig:signal :cb ?:after [< false >] ->
      connect obj name:signal.name cb:(signal.marshaller cb) :after
  external disconnect : 'a obj -> id -> unit
      = "ml_gtk_signal_disconnect"
  let marshal_unit f _ = f ()
  let break_value = ref false
  let break () = break_value := true
  let marshal_event f argv =
    let p = Argv.get_pointer argv pos:0 in
    let ev = Gdk.Event.unsafe_copy p in
    let old_break = !break_value in
    break_value := false;
    try f ev; Argv.set_result_bool argv !break_value;
      break_value := old_break
    with exn -> break_value := old_break; raise exn
  let destroy : ([> widget],_) t =
    { name = "destroy"; marshaller = marshal_unit }
  let clicked : ([> button],_) t =
    { name = "clicked"; marshaller = marshal_unit }
  let toggled : ([> toggle],_) t =
    { name = "toggled"; marshaller = marshal_unit }
  let activate : ([> editable],_) t =
    { name = "activate"; marshaller = marshal_unit }
  let event : ([> widget], Gdk.Tags.event_type Gdk.event -> unit) t =
    { name = "delete_event"; marshaller = marshal_event }
  let button_press_event : ([> widget], Gdk.Event.Button.t -> unit) t =
    { name = "button_press_event"; marshaller = marshal_event }
  let button_release_event : ([> widget], Gdk.Event.Button.t -> unit) t =
    { name = "button_release_event"; marshaller = marshal_event }
  let motion_notify_event : ([> widget], Gdk.Event.Motion.t -> unit) t =
    { name = "motion_notify_event"; marshaller = marshal_event }
  let delete_event : ([> widget], [DELETE] Gdk.event -> unit) t =
    { name = "delete_event"; marshaller = marshal_event }
  let destroy_event : ([> widget], [DESTROY] Gdk.event -> unit) t =
    { name = "destroy_event"; marshaller = marshal_event }
  let expose_event : ([> widget], Gdk.Event.Expose.t -> unit) t =
    { name = "expose_event"; marshaller = marshal_event }
  let key_press_event : ([> widget], Gdk.Event.Key.t -> unit) t =
    { name = "key_press_event"; marshaller = marshal_event }
  let key_release_event : ([> widget], Gdk.Event.Key.t -> unit) t =
    { name = "key_release_event"; marshaller = marshal_event }
  let enter_notify_event : ([> widget], Gdk.Event.Crossing.t -> unit) t =
    { name = "enter_notify_event"; marshaller = marshal_event }
  let leave_notify_event : ([> widget], Gdk.Event.Crossing.t -> unit) t =
    { name = "leave_notify_event"; marshaller = marshal_event }
  let configure_event : ([> widget], Gdk.Event.Configure.t -> unit) t =
    { name = "configure_event"; marshaller = marshal_event }
  let focus_in_event : ([> widget], Gdk.Event.Focus.t -> unit) t =
    { name = "focus_in_event"; marshaller = marshal_event }
  let focus_out_event : ([> widget], Gdk.Event.Focus.t -> unit) t =
    { name = "focus_out_event"; marshaller = marshal_event }
  let map_event : ([> widget], [MAP] Gdk.event -> unit) t =
    { name = "map_event"; marshaller = marshal_event }
  let unmap_event : ([> widget], [UNMAP] Gdk.event -> unit) t =
    { name = "unmap_event"; marshaller = marshal_event }
  let property_notify_event : ([> widget], Gdk.Event.Property.t -> unit) t =
    { name = "property_notify_event"; marshaller = marshal_event }
  let selection_clear_event : ([> widget], Gdk.Event.Selection.t -> unit) t =
    { name = "selection_clear_event"; marshaller = marshal_event }
  let selection_request_event : ([> widget], Gdk.Event.Selection.t -> unit) t =
    { name = "selection_request_event"; marshaller = marshal_event }
  let selection_notify_event : ([> widget], Gdk.Event.Selection.t -> unit) t =
    { name = "selection_notify_event"; marshaller = marshal_event }
  let proximity_in_event : ([> widget], Gdk.Event.Proximity.t -> unit) t =
    { name = "proximity_in_event"; marshaller = marshal_event }
  let proximity_in_event : ([> widget], Gdk.Event.Proximity.t -> unit) t =
    { name = "proximity_in_event"; marshaller = marshal_event }
end

module Timeout = struct
  type id
  external add : int -> cb:(Argv.t -> unit) -> id = "ml_gtk_timeout_add"
  let add inter :cb =
    add inter cb:(fun arg -> Argv.set_result_bool arg (cb ()))
  external remove : id -> unit = "ml_gtk_timeout_remove"
end

module AcceleratorTable = struct
  type t
  external create : unit -> t = "ml_gtk_accelerator_table_new"
end

module Style = struct
  type t
  external create : unit -> t = "ml_gtk_style_new"
  external copy : t -> t = "ml_gtk_style_copy"
  external attach : t -> Gdk.window -> t = "ml_gtk_style_attach"
  external detach : t -> unit = "ml_gtk_style_detach"
  external set_background : t -> Gdk.window -> state -> unit
      = "ml_gtk_style_set_background"
  external draw_hline :
      t -> Gdk.window -> state -> x:int -> x:int -> y:int -> unit
      = "ml_gtk_draw_hline"
  external draw_vline :
      t -> Gdk.window -> state -> y:int -> y:int -> c:int -> unit
      = "ml_gtk_draw_vline"
  external bg : t -> state:state -> Gdk.Color.t = "ml_GtkStyle_bg"
  let bg st ?:state [< `NORMAL >] = bg st :state
end

module Object = struct
  external get_type : 'a obj -> Type.t = "ml_gtk_object_type"
  let is_a obj name =
    Type.is_a (get_type obj) (Type.from_name name)
end

module Adjustment = struct
  type t = [ajustment] obj
  external create :
      value:float -> lower:float -> upper:float ->
      step_incr:float -> page_incr:float -> page_size:float -> t
      = "ml_gtk_adjustment_new_bc" "ml_gtk_adjustment_new"
  external set_value : [> adjustment] obj -> float -> unit
      = "ml_gtk_adjustment_set_value"
  external clamp_page :
      [> adjustment] obj -> lower:float -> upper:float -> unit
      = "ml_gtk_adjustment_clamp_page"
end

module Tooltips = struct
  type t = [tooltips] obj
  external create : unit -> t = "ml_gtk_tooltips_new"
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
  let set tt ?enable:able ?:delay ?:foreground ?:background =
    may fun:(function true -> enable tt | false -> disable tt) able;
    may fun:(set_delay tt) delay;
    if foreground <> None || background <> None then
      set_colors tt ?:foreground ?:background
end

module Widget = struct
  type t = [widget] obj
  let cast w : t =
    if Object.is_a w "GtkWidget" then Obj.magic w
    else invalid_arg "Gtk.Widget.cast"
  external coerce : [> widget] obj -> t = "%identity"
  external destroy : [> widget] obj -> unit = "ml_gtk_widget_destroy"
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
  external draw_children : [> widget] obj -> unit
      = "ml_gtk_widget_draw_children"
  external event : [> widget] obj -> 'a Gdk.event -> unit
      = "ml_gtk_widget_event"
  external activate : [> widget] obj -> unit
      = "ml_gtk_widget_activate"
  external reparent : [> widget] obj -> [> widget] obj -> unit
      = "ml_gtk_widget_reparent"
  external popup : [> widget] obj -> x:int -> y:int -> unit
      = "ml_gtk_widget_popup"
  external intersect :
      [> widget] obj -> Gdk.Rectangle.t -> Gdk.Rectangle.t option
      = "ml_gtk_widget_intersect"
  external basic : [> widget] obj -> bool
      = "ml_gtk_widget_basic"
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
  external set_state : [> widget] obj -> state -> unit
      = "ml_gtk_widget_set_state"
  external set_sensitive : [> widget] obj -> bool -> unit
      = "ml_gtk_widget_set_sensitive"
  external set_uposition : [> widget] obj -> x:int -> y:int -> unit
      = "ml_gtk_widget_set_uposition"
  external set_usize : [> widget] obj -> width:int -> height:int -> unit
      = "ml_gtk_widget_set_usize"
  external get_toplevel : [> widget] obj -> t
      = "ml_gtk_widget_get_toplevel"
  external get_ancestor : [> widget] obj -> Type.t -> t
      = "ml_gtk_widget_get_ancestor"
  external get_colormap : [> widget] obj -> Gdk.colormap
      = "ml_gtk_widget_get_colormap"
  external get_visual : [> widget] obj -> Gdk.visual
      = "ml_gtk_widget_get_visual"
  external get_pointer : [> widget] obj -> int * int
      = "ml_gtk_widget_get_pointer"
  external is_ancestor : [> widget] obj -> [> widget] obj -> bool
      = "ml_gtk_widget_is_ancestor"
  external is_child : [> widget] obj -> [> widget] obj -> bool
      = "ml_gtk_widget_is_ancestor"
  external set_style : [> widget] obj -> Style.t -> unit
      = "ml_gtk_widget_set_style"
  external set_rc_style : [> widget] obj -> unit
      = "ml_gtk_widget_set_rc_style"
  external ensure_style : [> widget] obj -> unit
      = "ml_gtk_widget_ensure_style"
  external get_style : [> widget] obj -> Style.t
      = "ml_gtk_widget_get_style"
  external restore_default_style : [> widget] obj -> unit
      = "ml_gtk_widget_restore_default_style"
  external window : [> widget] obj -> Gdk.window
      = "ml_GtkWidget_window"
  let set w ?:name ?:state ?:sensitive ?:can_default ?:can_focus
      ?:x [< -2 >] ?:y [< -2 >] ?:width [< -1 >] ?:height [< -1 >] ?:style =
    let may_set f arg = may fun:(f w) arg in
    may_set set_name name;
    may_set set_state state;
    may_set set_sensitive sensitive;
    may_set set_can_default can_default;
    may_set set_can_focus can_focus;
    may_set set_style style;
    if x > -2 || y > -2 then set_uposition w :x :y;
    if width > -1 || height > -1 then set_usize w :width :height
end

module Container = struct
  type t = [widget container] obj
  let cast w : t =
    if Object.is_a w "GtkContainer" then Obj.magic w
    else invalid_arg "Gtk.Container.cast"
  external border_width : [> container] obj -> int -> unit
      = "ml_gtk_container_border_width"
  external add : [> container] obj -> [> widget] obj -> unit
      = "ml_gtk_container_add"
  external remove : [> container] obj -> [> widget] obj -> unit
      = "ml_gtk_container_remove"
  external disable_resize : [> container] obj -> unit
      = "ml_gtk_container_disable_resize"
  external enable_resize : [> container] obj -> unit
      = "ml_gtk_container_enable_resize"
  external block_resize : [> container] obj -> unit
      = "ml_gtk_container_block_resize"
  external unblock_resize : [> container] obj -> unit
      = "ml_gtk_container_unblock_resize"
  external need_resize : [> container] obj -> bool
      = "ml_gtk_container_need_resize"
  external foreach : [> container] obj -> fun:(Widget.t -> unit) -> unit
      = "ml_gtk_container_foreach"
  let children w =
    let l = ref [] in
    foreach w fun:(push on:l);
    List.rev !l
  external focus : [> container] obj -> direction -> bool
      = "ml_gtk_container_focus"
  external set_focus_child : [> container] obj -> [> widget] obj -> unit
      = "ml_gtk_container_set_focus_child"
  external set_focus_vadjustment :
      [> container] obj -> [> adjustment] obj -> unit
      = "ml_gtk_container_set_focus_vadjustment"
  external set_focus_hadjustment :
      [> container] obj -> [> adjustment] obj -> unit
      = "ml_gtk_container_set_focus_hadjustment"
  let set_focus w ?:child ?:vadjustment ?:hadjustment =
    may child fun:(set_focus_child w);
    may vadjustment fun:(set_focus_vadjustment w);
    may hadjustment fun:(set_focus_hadjustment w)
end

module Alignment = struct
  type t = [widget container bin alignment] obj
  let cast w : t =
    if Object.is_a w "GtkAlignment" then Obj.magic w
    else invalid_arg "Gtk.Alignment.cast"
  external create :
      x:clampf -> y:clampf -> xscale:clampf -> yscale:clampf -> t
      = "ml_gtk_alignment_new"
  let create ?:x [< 0.5 >] ?:y [< 0.5 >] ?:xscale [< 1.0 >]
      ?:yscale [< 1.0 >] ?(_ : unit option) =
    create :x :y :xscale :yscale
  external set :
      [> alignment] obj ->
      ?x:clampf -> ?y:clampf -> ?xscale:clampf -> ?yscale:clampf -> unit
      = "ml_gtk_alignment_set"
end

module EventBox = struct
  type t = [widget container bin eventbox] obj
  let cast w : t =
    if Object.is_a w "GtkEventBox" then Obj.magic w
    else invalid_arg "Gtk.EventBox.cast"
  external create : unit -> t = "ml_gtk_event_box_new"
end

module Frame = struct
  type t = [widget container bin frame] obj
  let cast w : t =
    if Object.is_a w "GtkFrame" then Obj.magic w
    else invalid_arg "Gtk.Frame.cast"
  external create : label:string -> t = "ml_gtk_frame_new"
  external set_label : [> frame] obj -> string -> unit
      = "ml_gtk_frame_set_label"
  external set_label_align : [> frame] obj -> x:clampf -> y:clampf -> unit
      = "ml_gtk_frame_set_label"
  external set_shadow_type : [> frame] obj -> shadow -> unit
      = "ml_gtk_frame_set_shadow_type"
end

module AspectFrame = struct
  type t = [widget container bin frame aspect] obj
  let cast w : t =
    if Object.is_a w "GtkAspectFrame" then Obj.magic w
    else invalid_arg "Gtk.AspectFrame.cast"
  external create :
      label:string ->
      xalign:clampf -> yalign:clampf -> ratio:float -> obey:bool -> t
      = "ml_gtk_aspect_frame_new"
  let create :label ?:xalign [< 0.5 >] ?:yalign [< 0.5 >]
      ?:ratio [< 1.0 >] ?:obey [< true >] =
    create :label :xalign :yalign :ratio :obey
  external set :
      [> aspect] obj ->
      xalign:clampf -> yalign:clampf -> ratio:float -> obey:bool -> unit
      = "ml_gtk_aspect_frame_set"
end

module HandleBox = struct
  type t = [widget container bin handle] obj
  let cast w : t =
    if Object.is_a w "GtkHandleBox" then Obj.magic w
    else invalid_arg "Gtk.HandleBox.cast"
  external create : unit -> t = "ml_gtk_handle_box_new"
end

module Item = struct
  type t = [widget container bin item] obj
  let cast w : t =
    if Object.is_a w "GtkItem" then Obj.magic w
    else invalid_arg "Gtk.Item.cast"
  external select : [> item] obj -> unit = "ml_gtk_item_select"
  external deselect : [> item] obj -> unit = "ml_gtk_item_deselect"
  external toggle : [> item] obj -> unit = "ml_gtk_item_toggle"
end

module ListItem = struct
  type t = [widget container bin item list] obj
  let cast w : t =
    if Object.is_a w "GtkListItem" then Obj.magic w
    else invalid_arg "Gtk.ListItem.cast"
  external create : unit -> t = "ml_gtk_list_item_new"
  external create_with_label : string -> t
      = "ml_gtk_list_item_new_with_label"
end

module MenuItem = struct
  type t = [widget container bin item menuitem] obj
  let cast w : t =
    if Object.is_a w "GtkMenuItem" then Obj.magic w
    else invalid_arg "Gtk.MenuItem.cast"
  external create : unit -> t = "ml_gtk_menu_item_new"
  external create_with_label : string -> t
      = "ml_gtk_menu_item_new_with_label"
  external set_submenu : [> menuitem] obj -> [> widget] obj -> unit
      = "ml_gtk_menu_item_set_submenu"
  external remove_submenu : [> menuitem] obj -> unit
      = "ml_gtk_menu_item_remove_submenu"
  external accelerator_size : [> menuitem] obj -> unit
      = "ml_gtk_menu_item_accelerator_size"
  external accelerator_text : [> menuitem] obj -> string -> unit
      = "ml_gtk_menu_item_accelerator_size"
  external configure :
      [> menuitem] obj -> show_toggle:bool -> show_indicator:bool -> unit
      = "ml_gtk_menu_item_configure"
  external activate : [> menuitem] obj -> unit
      = "ml_gtk_menu_item_activate"
  external right_justify : [> menuitem] obj -> unit
      = "ml_gtk_menu_item_right_justify"
end

module CheckMenuItem = struct
  type t = [widget container bin item menuitem checkmenuitem] obj
  let cast w : t =
    if Object.is_a w "GtkCheckMenuItem" then Obj.magic w
    else invalid_arg "Gtk.CheckMenuItem.cast"
  external create : unit -> t = "ml_gtk_check_menu_item_new"
  external create_with_label : string -> t
      = "ml_gtk_check_menu_item_new_with_label"
  external set_state : [> checkmenuitem] obj -> bool -> unit
      = "ml_gtk_check_menu_item_set_state"
  external set_show_toggle : [> checkmenuitem] obj -> bool -> unit
      = "ml_gtk_check_menu_item_set_show_toggle"
  external toggled : [> checkmenuitem] obj -> unit
      = "ml_gtk_check_menu_item_toggled"
end

module RadioMenuItem = struct
  type t = [widget container bin item menuitem checkmenuitem radiomenuitem] obj
  let cast w : t =
    if Object.is_a w "GtkRadioMenuItem" then Obj.magic w
    else invalid_arg "Gtk.RadioMenuItem.cast"
  type group
  let empty : group = Obj.obj null
  external create : group -> t = "ml_gtk_radio_menu_item_new"
  external create_with_label : group -> string -> t
      = "ml_gtk_radio_menu_item_new_with_label"
  external group : [> radiotmenuitem] -> group
      = "ml_gtk_radio_menu_item_group"
  external set_group : [> radiotmenuitem] -> group -> unit
      = "ml_gtk_radio_menu_item_set_group"
end

module TreeItem = struct
  type t = [widget container bin item treeitem] obj
  let cast w : t =
    if Object.is_a w "GtkTreeItem" then Obj.magic w
    else invalid_arg "Gtk.TreeItem.cast"
  external create : unit -> t = "ml_gtk_tree_item_new"
  external create_with_label : string -> t
      = "ml_gtk_tree_item_new_with_label"
  external set_subtree : [> treeitem] obj -> [> widget] obj -> unit
      = "ml_gtk_tree_item_set_subtree"
  external remove_subtree : [> treeitem] obj -> unit
      = "ml_gtk_tree_item_remove_subtree"
  external expand : [> treeitem] obj -> unit
      = "ml_gtk_tree_item_expand"
  external collapse : [> treeitem] obj -> unit
      = "ml_gtk_tree_item_collapse"
end

module Viewport = struct
  type t = [widget container bin viewport] obj
  let cast w : t =
    if Object.is_a w "GtkViewport" then Obj.magic w
    else invalid_arg "Gtk.Viewport.cast"
  external create :
      ?hadj:[> adjustment] obj -> ?vadj:[> adjustment] obj -> ?unit -> t
      = "ml_gtk_viewport_new"
  external get_hadjustment : [> viewport] obj -> Adjustment.t
      = "ml_gtk_viewport_get_hadjustment"
  external get_vadjustment : [> viewport] obj -> Adjustment.t
      = "ml_gtk_viewport_get_vadjustment"
  external set_hadjustment : [> viewport] obj -> Adjustment.t -> unit
      = "ml_gtk_viewport_set_hadjustment"
  external set_vadjustment : [> viewport] obj -> Adjustment.t -> unit
      = "ml_gtk_viewport_set_vadjustment"
  external set_shadow_type : [> viewport] obj -> shadow -> unit
      = "ml_gtk_viewport_set_shadow_type"
end

module Dialog = struct
  type t = [widget container bin dialog] obj
  let cast w : t =
    if Object.is_a w "GtkDialog" then Obj.magic w
    else invalid_arg "Gtk.Dialog.cast"
  external create : unit -> t = "ml_gtk_dialog_new"
  external action_area : [> dialog] obj -> [> box] obj
      = "ml_GtkDialog_action_area"
  external vbox : [> dialog] obj -> [> box] obj
      = "ml_GtkDialog_vbox"
end

module InputDialog = struct
  type t = [widget container bin dialog inputdialog] obj
  let cast w : t =
    if Object.is_a w "GtkInputDialog" then Obj.magic w
    else invalid_arg "Gtk.InputDialog.cast"
  external create : unit -> t = "ml_gtk_input_dialog_new"
end

module FileSelection = struct
  type t = [widget container bin filesel] obj
  let cast w : t =
    if Object.is_a w "GtkFileSelection" then Obj.magic w
    else invalid_arg "Gtk.FileSelection.cast"
  external create : string -> t = "ml_gtk_file_selection_new"
  external set_filename : [> filesel] obj -> string -> unit
      = "ml_gtk_file_selection_set_filename"
  external get_filename : [> filesel] obj -> string
      = "ml_gtk_file_selection_get_filename"
  external show_fileop_buttons : [> filesel] obj -> unit
      = "ml_gtk_file_selection_show_fileop_buttons"
  external hide_fileop_buttons : [> filesel] obj -> unit
      = "ml_gtk_file_selection_hide_fileop_buttons"
end

module Window = struct
  type t = [widget container bin window] obj
  let cast w : t =
    if Object.is_a w "GtkWindow" then Obj.magic w
    else invalid_arg "Gtk.Window.cast"
  external create : window_type -> t = "ml_gtk_window_new"
  external set_title : [> window] obj -> string -> unit
      = "ml_gtk_window_set_title"
  external set_wmclass : [> window] obj -> name:string -> class:string -> unit
      = "ml_gtk_window_set_title"
  external set_focus : [> window] obj -> [> widget] obj -> unit
      = "ml_gtk_window_set_focus"
  external set_default : [> window] obj -> [> widget] obj -> unit
      = "ml_gtk_window_set_default"
  external set_policy :
      [> window] obj ->
      allow_shrink:bool -> allow_grow:bool -> auto_shrink:bool -> unit
      = "ml_gtk_window_set_policy"
  external add_accelerator_table : [> window] obj -> AcceleratorTable.t -> unit
      = "ml_gtk_window_add_accelerator_table"
  external remove_accelerator_table :
      [> window] obj -> AcceleratorTable.t -> unit
      = "ml_gtk_window_remove_accelerator_table"
  external activate_focus : [> window] obj -> unit
      = "ml_gtk_window_activate_focus"
  external activate_default : [> window] obj -> unit
      = "ml_gtk_window_activate_default"
end

module ColorSelection = struct
  type t = [widget container box colorsel] obj
  let cast w : t =
    if Object.is_a w "GtkColorSelection" then Obj.magic w
    else invalid_arg "Gtk.ColorSelection.cast"
  type dialog = [widget container window colorseldialog] obj
  external create : unit -> t = "ml_gtk_color_selection_new"
  external create_dialog : string -> dialog
      = "ml_gtk_color_selection_dialog_new"
  external set_update_policy : [> colorsel] obj -> update -> unit
      = "ml_gtk_color_selection_set_update_policy"
  external set_opacity : [> colorsel] obj -> bool -> unit
      = "ml_gtk_color_selection_set_opacity"
  external set_color :
      [> colorsel] obj ->
      red:float -> green:float -> blue:float -> ?opacity:float -> unit
      = "ml_gtk_color_selection_set_color"
  type color = { red: float; green: float; blue: float; opacity: float }
  external get_color : [> colorsel] obj -> color
      = "ml_gtk_color_selection_get_color"
end

module Box = struct
  type t = [widget container box] obj
  let cast w : t =
    if Object.is_a w "GtkBox" then Obj.magic w
    else invalid_arg "Gtk.Box.cast"
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
  type packing =
      { expand: bool; fill: bool; padding: int; pack_type: pack_type }
  external query_child_packing : [> box] obj -> [> widget] obj -> packing
      = "ml_gtk_box_query_child_packing"
  external set_child_packing :
      [> box] obj -> [> widget] obj ->
      ?expand:bool -> ?fill:bool -> ?padding:int -> ?from:pack_type -> unit
      = "ml_gtk_box_set_child_packing_bc" "ml_gtk_box_set_child_packing"
  external hbox_new : homogeneous:bool -> spacing:int -> t
      = "ml_gtk_hbox_new"
  external vbox_new : homogeneous:bool -> spacing:int -> t
      = "ml_gtk_vbox_new"
  let create (dir : orientation) ?:homogeneous [< false >] ?:spacing [< 0 >] =
    (match dir with `HORIZONTAL -> hbox_new | `VERTICAL -> vbox_new)
      :homogeneous :spacing
end

module BBox = struct
  (* Omitted defaults setting *)
  type t = [widget container bbox] obj
  let cast w : t =
    if Object.is_a w "GtkBBox" then Obj.magic w
    else invalid_arg "Gtk.BBox.cast"
  type bbox_style = [ DEFAULT_STYLE SPREAD EDGE START END ]
  external spacing : [> bbox] -> int = "ml_gtk_button_box_spacing"
  external child_width : [> bbox] -> int
      = "ml_gtk_button_box_child_min_width"
  external child_height : [> bbox] -> int
      = "ml_gtk_button_box_child_min_height"
  external child_ipad_x : [> bbox] -> int = "ml_gtk_button_box_child_ipad_x"
  external child_ipad_y : [> bbox] -> int = "ml_gtk_button_box_child_ipad_y"
  external layout : [> bbox] -> bbox_style
      = "ml_gtk_button_box_layout_style"
  external set_spacing : [> bbox] -> int = "ml_gtk_button_box_set_spacing"
  external set_child_size : [> bbox] -> width:int -> height:int -> unit
      = "ml_gtk_button_box_set_child_size"
  external set_child_ipadding : [> bbox] -> x:int -> y:int -> unit
      = "ml_gtk_button_box_set_child_ipadding"
  external set_layout : [> bbox] -> bbox_style -> unit
      = "ml_gtk_button_box_set_layout"
  external create_hbbox : unit -> t = "ml_gtk_hbutton_box_new"
  external create_vbbox : unit -> t = "ml_gtk_vbutton_box_new"
  let create (dir : orientation) =
    if dir = `HORIZONTAL then create_hbbox () else create_vbbox ()
end

module Button = struct
  type t = [widget container button] obj
  let cast w : t =
    if Object.is_a w "GtkButton" then Obj.magic w
    else invalid_arg "Gtk.Button.cast"
  external create : unit -> t = "ml_gtk_button_new"
  external create_with_label : string -> t = "ml_gtk_button_new_with_label"
  external pressed : [> button] obj -> unit = "ml_gtk_button_pressed"
  external released : [> button] obj -> unit = "ml_gtk_button_released"
  external clicked : [> button] obj -> unit = "ml_gtk_button_clicked"
  external enter : [> button] obj -> unit = "ml_gtk_button_enter"
  external leave : [> button] obj -> unit = "ml_gtk_button_leave"
end

module ToggleButton = struct
  type t = [widget container button toggle] obj
  let cast w : t =
    if Object.is_a w "GtkToggleButton" then Obj.magic w
    else invalid_arg "Gtk.ToggleButton.cast"
  external toggle_button_create : unit -> t = "ml_gtk_toggle_button_new"
  external toggle_button_create_with_label : string -> t
      = "ml_gtk_toggle_button_new_with_label"
  external check_button_create : unit -> t = "ml_gtk_check_button_new"
  external check_button_create_with_label : string -> t
      = "ml_gtk_check_button_new_with_label"
  let create (kind : [toggle check]) ?:label =
    match label with None ->
      if kind = `toggle then toggle_button_create ()
      else check_button_create ()
    | Some label ->
      if kind = `toggle then toggle_button_create_with_label label
      else check_button_create_with_label label
  external set_mode : [> toggle] obj -> bool -> unit
      = "ml_gtk_toggle_button_set_mode"
  external set_state : [> toggle] obj -> bool -> unit
      = "ml_gtk_toggle_button_set_state"
  let set button ?:mode ?:state =
    may fun:(set_mode button) mode;
    may fun:(set_state button) state
  external toggled : [> toggle] obj -> unit = "ml_gtk_toggle_button_toggled"
  external active : [> toggle] obj -> bool = "ml_GtkToggleButton_active"
end

module RadioButton = struct
  type t = [widget container button toggle radio] obj
  let cast w : t =
    if Object.is_a w "GtkRadioButton" then Obj.magic w
    else invalid_arg "Gtk.RadioButton.cast"
  type group
  let empty : group = Obj.obj null
  external create : group -> t = "ml_gtk_radio_button_new"
  external create_with_label : group -> string -> t
      = "ml_gtk_radio_button_new_with_label"
  external group : [> radio] obj -> group = "ml_gtk_radio_button_group"
  external set_group : [> radio] obj -> group -> unit
      = "ml_gtk_radio_button_set_group"
  let create (grp : [none group(_) widget(_)]) ?:label  =
    let group =
      match grp with `none -> empty | `group g -> g | `widget w -> group w
    in
    match label with None -> create group
    | Some label -> create_with_label group label
end

module CList = struct
  type t = [widget container clist] obj
  let cast w : t =
    if Object.is_a w "GtkCList" then Obj.magic w
    else invalid_arg "Gtk.CList.cast"
  external create : cols:int -> t = "ml_gtk_clist_new"
  external create_with_titles : string array -> t
      = "ml_gtk_clist_new_with_titles"
  external set_border : [> clist] obj -> shadow -> unit
      = "ml_gtk_clist_set_border"
  external set_selection_mode : [> clist] obj -> selection -> unit
      = "ml_gtk_clist_set_selection_mode"
  external set_policy : [> clist] obj -> vert:policy -> horiz:policy -> unit
      = "ml_gtk_clist_set_policy"
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
      [> clist] obj -> int -> int -> vert:int -> horiz:int -> unit
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
end

module Fixed = struct
  type t = [widget container fixed] obj
  let cast w : t =
    if Object.is_a w "GtkFixed" then Obj.magic w
    else invalid_arg "Gtk.Fixed.cast"
  external create : unit -> t = "ml_gtk_fixed_new"
  external put : [> fixed] obj -> [> widget] obj -> x:int -> y:int -> unit
      = "ml_gtk_fixed_put"
  external move : [> fixed] obj -> [> widget] obj -> x:int -> y:int -> unit
      = "ml_gtk_fixed_move"
end

module GtkList = struct
  type t = [widget container list] obj
  let cast w : t =
    if Object.is_a w "GtkList" then Obj.magic w
    else invalid_arg "Gtk.GtkList.cast"
  external create : unit -> t = "ml_gtk_list_new"
  external insert_item :
      [> list] obj -> [> widget] obj -> pos:int -> unit
      = "ml_gtk_list_insert_item"
  let insert_items l wl :pos =
    let wl = if pos < 0 then wl else List.rev wl in
    List.iter wl fun:(insert_item l :pos)
  let append_items l = insert_items l pos:(-1)
  let prepend_items l = insert_items l pos:0
  external clear_items : [> list] obj -> start:int -> end:int -> unit =
    "ml_gtk_list_clear_items"
  external select_item : [> list] obj -> int -> unit
      = "ml_gtk_list_select_item"
  external unselect_item : [> list] obj -> int -> unit
      = "ml_gtk_list_unselect_item"
  external select_child : [> list] obj -> [> widget] obj -> unit
      = "ml_gtk_list_select_child"
  external unselect_child : [> list] obj -> [> widget] obj -> unit
      = "ml_gtk_list_unselect_child"
  external child_position : [> list] obj -> [> widget] obj -> int
      = "ml_gtk_list_child_position"
  external set_selection_mode : [> list] obj -> selection -> unit
      = "ml_gtk_list_set_selection_mode"
end

module MenuShell = struct
  type t = [widget container menushell] obj
  let cast w : t =
    if Object.is_a w "GtkMenuShell" then Obj.magic w
    else invalid_arg "Gtk.MenuShell.cast"
  external append : [> menushell] obj -> [> widget] obj -> unit
      = "ml_gtk_menu_shell_append"
  external prepend : [> menushell] obj -> [> widget] obj -> unit
      = "ml_gtk_menu_shell_prepend"
  external insert : [> menushell] obj -> [> widget] obj -> int -> unit
      = "ml_gtk_menu_shell_insert"
  external deactivate : [> menushell] obj -> unit
      = "ml_gtk_menu_shell_deactivate"
end

module Menu = struct
  type t = [widget container menushell menu] obj
  let cast w : t =
    if Object.is_a w "GtkMenu" then Obj.magic w
    else invalid_arg "Gtk.Menu.cast"
  external create : unit -> t = "ml_gtk_menu_new"
  external popup :
      [> menu] obj -> ?parent_menu:[> menushell] obj ->
      ?parent_item:[> menuitem] obj -> button:int -> activate_time:int -> unit
      = "ml_gtk_menu_popup"
  external popdown : [> menu] obj -> unit = "ml_gtk_menu_popdown"
  external get_active : [> menu] obj -> Widget.t = "ml_gtk_menu_get_active"
  external set_active : [> menu] obj -> int -> unit = "ml_gtk_menu_set_active"
  external set_accelerator_table : [> menu] obj -> [> accelerator] obj -> unit
      = "ml_gtk_menu_set_accelerator_table"
  external attach_to_widget : [> menu] obj -> [> widget] obj -> unit
      = "ml_gtk_menu_attach_to_widget"
  external get_attach_widget : [> menu] obj -> Widget.t
      = "ml_gtk_menu_get_attach_widget"
  external detach : [> menu] obj -> unit = "ml_gtk_menu_detach"
end

module OptionMenu = struct
  type t = [widget container button optionmenu] obj
  let cast w : t =
    if Object.is_a w "GtkOptionMenu" then Obj.magic w
    else invalid_arg "Gtk.OptionMenu.cast"
  external create : unit -> t = "ml_gtk_option_menu_new"
  external get_menu : [> optionmenu] obj -> Menu.t
      = "ml_gtk_option_menu_get_menu"
  external set_menu : [> optionmenu] obj -> [> menu] obj -> unit
      = "ml_gtk_option_menu_set_menu"
  external remove_menu : [> optionmenu] obj -> unit
      = "ml_gtk_option_menu_remove_menu"
  external set_history : [> optionmenu] obj -> int -> unit
      = "ml_gtk_option_menu_set_history"
  let set w ?:menu ?:history =
    may menu fun:(set_menu w);
    may history fun:(set_history w)
end

module MenuBar = struct
  type t = [widget container menushell menubar] obj
  let cast w : t =
    if Object.is_a w "GtkMenuBar" then Obj.magic w
    else invalid_arg "Gtk.MenuBar.cast"
  external create : unit -> t = "ml_gtk_menu_bar_new"
end

module Notebook = struct
  type t = [widget container notebook] obj
  let cast w : t =
    if Object.is_a w "GtkNotebook" then Obj.magic w
    else invalid_arg "Gtk.Notebook.cast"
  external create : unit -> t = "ml_gtk_notebook_new"
  external insert_page :
      [> notebook] obj -> [> widget] obj -> tab:[> widget] obj ->
      ?menu:[> widget] obj -> ?pos:int -> unit
      = "ml_gtk_notebook_insert_page_menu"
      (* default is append to end *)
  external remove_page : [> notebook] obj -> int -> unit
      = "ml_gtk_notebook_remove_page"
  external current_page : [> notebook] obj -> int
      = "ml_gtk_notebook_current_page"
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
  let set w ?:page ?:tab_pos ?:show_tabs ?:show_border ?:scrollable
      ?:tab_border ?:popup =
    let may_set f = may fun:(f w) in
    may_set set_page page;
    may_set set_tab_pos tab_pos;
    may_set set_show_tabs show_tabs;
    may_set set_show_border show_border;
    may_set set_scrollable scrollable;
    may_set set_tab_border tab_border;
    may fun:(fun b -> if b then popup_enable w else popup_disable w) popup
end

module Paned = struct
  type t = [widget container paned] obj
  let cast w : t =
    if Object.is_a w "GtkPaned" then Obj.magic w
    else invalid_arg "Gtk.Paned.cast"
  external add1 : [> paned] obj -> [> widget] obj -> unit
      = "ml_gtk_paned_add1"
  external add2 : [> paned] obj -> [> widget] obj -> unit
      = "ml_gtk_paned_add2"
  let add w ?:fst ?:snd =
    may fun:(add1 w) fst;
    may fun:(add2 w) snd
  external handle_size : [> paned] obj -> int -> unit
      = "ml_gtk_paned_handle_size"
  external gutter_size : [> paned] obj -> int -> unit
      = "ml_gtk_paned_gutter_size"
  let set_size w ?:handle ?:gutter =
    may fun:(handle_size w) handle;
    may fun:(gutter_size w) gutter
  external hpaned_new : unit -> t = "ml_gtk_hpaned_new"
  external vpaned_new : unit -> t = "ml_gtk_vpaned_new"
  let create (dir : orientation) =
    if dir = `HORIZONTAL then hpaned_new () else vpaned_new ()
end

module ScrolledWindow = struct
  type t = [widget container scrolled] obj
  let cast w : t =
    if Object.is_a w "GtkScrolledWindow" then Obj.magic w
    else invalid_arg "Gtk.ScrolledWindow.cast"
  external create :
      ?hadj:[> adjustment] obj -> ?vadj:[> adjustment] obj -> ?unit -> t
      = "ml_gtk_scrolled_window_new"
  external get_hadjustment : [> scrolled] obj -> Adjustment.t
      = "ml_gtk_scrolled_window_get_hadjustment"
  external get_vadjustment : [> scrolled] obj -> Adjustment.t
      = "ml_gtk_scrolled_window_get_vadjustment"
  external set_policy : [> scrolled] obj -> horiz:policy -> vert:policy -> unit
      = "ml_gtk_scrolled_window_set_policy"
end

module Table = struct
  type t = [widget container table] obj
  let cast w : t =
    if Object.is_a w "GtkTable" then Obj.magic w
    else invalid_arg "Gtk.Table.cast"
  external create : int -> int -> homogeneous:bool -> t
      = "ml_gtk_table_new"
  let create r c ?:homogeneous [< false >] = create r c :homogeneous
  external attach :
      [> table] obj -> [> widget] obj -> left:int -> right:int ->
      top:int -> bottom:int -> xoptions:attach list ->
      yoptions:attach list -> xpadding:int -> ypadding:int -> unit
      = "ml_gtk_table_attach_bc" "ml_gtk_table_attach"
  type dirs = [x y both none]
  let has_x = function `x|`both -> true | `y|`none -> false
  let has_y = function `y|`both -> true | `x|`none -> false
  let attach t w :left :top ?:right [< left+1 >] ?:bottom [< top+1 >]
      ?:expand [< `both >] ?:fill [< `both >]
      ?:shrink [< `none >] ?:xpadding [< 0 >] ?:ypadding [< 0 >] =
    let xoptions = if has_x shrink then [`SHRINK] else [] in
    let xoptions = if has_x fill then `FILL::xoptions else xoptions in
    let xoptions = if has_x expand then `EXPAND::xoptions else xoptions in
    let yoptions = if has_y shrink then [`SHRINK] else [] in
    let yoptions = if has_y fill then `FILL::yoptions else yoptions in
    let yoptions = if has_y expand then `EXPAND::yoptions else yoptions in
    attach t w :left :top :right :bottom :xoptions :yoptions
      :xpadding :ypadding
end

module Toolbar = struct
  type t = [widget container toolbar]
  let cast w : t =
    if Object.is_a w "GtkToolbar" then Obj.magic w
    else invalid_arg "Gtk.Toolbar.cast"
  external create : orientation -> style:toolbar_style -> t
      = "ml_gtk_toolbar_new"
  external insert_space : [> toolbar] obj -> ?pos:int -> unit
      = "ml_gtk_toolbar_insert_space"
  external insert_button :
      [> toolbar] obj -> ?type:[BUTTON TOGGLEBUTTON RADIOBUTTON] ->
      ?text:string -> ?tooltip:string -> ?tooltip_private:string ->
      ?icon:[> widget] obj -> ?pos:int -> Button.t
      = "ml_gtk_toolbar_insert_space"
  external insert_widget :
      [> toolbar] obj -> [> widget] obj ->
      ?tooltip:string -> ?tooltip_private:string -> ?pos:int -> unit
      = "ml_gtk_toolbar_insert_widget"
end

module Tree = struct
  type t = [widget container tree] obj
  let cast w : t =
    if Object.is_a w "GtkTree" then Obj.magic w
    else invalid_arg "Gtk.Tree.cast"
  external create : unit -> t = "ml_gtk_tree_new"
  external insert : [> tree] obj -> [> widget] obj -> ?pos:int -> unit
      = "ml_gtk_tree_insert"
  external remove : [> tree] obj -> [> widget] obj -> unit
      = "ml_gtk_container_remove"
  external clear_items : [> tree] obj -> start:int -> end:int -> unit
      = "ml_gtk_tree_clear_items"
  external select_item : [> tree] obj -> pos:int -> unit
      = "ml_gtk_tree_select_item"
  external unselect_item : [> tree] obj -> pos:int -> unit
      = "ml_gtk_tree_unselect_item"
  external child_position : [> tree] obj -> [> widget] obj -> unit
      = "ml_gtk_tree_child_position"
  external set_selection_mode : [> tree] obj -> selection -> unit
      = "ml_gtk_tree_set_selection_mode"
  external set_view_mode : [> tree] obj -> [LINE ITEM] -> unit
      = "ml_gtk_tree_set_view_mode"
  external set_view_lines : [> tree] obj -> bool -> unit
      = "ml_gtk_tree_set_view_lines"
  let set w ?:selection_mode ?:view_mode ?:view_lines =
    let may_set f = may fun:(f w) in
    may_set set_selection_mode selection_mode;
    may_set set_view_mode view_mode;
    may_set set_view_lines view_lines
end

(* Does not seem very useful ...
module DrawingArea = struct
  type t = [widget drawing] obj
  let cast w : t =
    if Object.is_a w "GtkDrawingArea" then Obj.magic w
    else invalid_arg "Gtk.DrawingArea.cast"
  external create : unit -> t = "ml_gtk_drawing_area_new"
  external size : [> drawing] obj -> width:int -> height:int -> unit
      = "ml_gtk_drawing_area_size"
end

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
  type t = [widget editable] obj
  let cast w : t =
    if Object.is_a w "GtkEditable" then Obj.magic w
    else invalid_arg "Gtk.Editable.cast"
  external select_region : [> editable] obj -> start:int -> end:int -> unit
      = "ml_gtk_editable_select_region"
  external insert_text : [> editable] obj -> string -> pos:int -> int
      = "ml_gtk_editable_select_region"
  external delete_text : [> editable] obj -> start:int -> end:int -> unit
      = "ml_gtk_editable_delete_text"
  external get_chars : [> editable] obj -> start:int -> end:int -> string
      = "ml_gtk_editable_get_chars"
  external cut_clipboard : [> editable] obj -> time:int -> unit
      = "ml_gtk_editable_cut_clipboard"
  external copy_clipboard : [> editable] obj -> time:int -> unit
      = "ml_gtk_editable_copy_clipboard"
  external paste_clipboard : [> editable] obj -> time:int -> unit
      = "ml_gtk_editable_paste_clipboard"
  external claim_selection :
      [> editable] obj -> claim:bool -> time:int -> unit
      = "ml_gtk_editable_claim_selection"
  external delete_selection : [> editable] obj -> unit
      = "ml_gtk_editable_delete_selection"
  external changed : [> editable] obj -> unit
      = "ml_gtk_editable_changed"
end

module Entry = struct
  type t = [widget editable entry] obj
  let cast w : t =
    if Object.is_a w "GtkEntry" then Obj.magic w
    else invalid_arg "Gtk.Entry.cast"
  external create : unit -> t = "ml_gtk_entry_new"
  external create_with_max_length : int -> t
      = "ml_gtk_entry_new_with_max_length"
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
  let set w ?:text ?:position ?:visibility ?:editable ?:max_length =
    let may_set f = may fun:(f w) in
    may_set set_text text;
    may_set set_position position;
    may_set set_visibility visibility;
    may_set set_editable editable;
    may_set set_max_length max_length
  external text_length : [> entry] obj -> int
      = "ml_GtkEntry_text_length"
end

module SpinButton = struct
  type t = [widget editable entry spinbutton] obj
  let cast w : t =
    if Object.is_a w "GtkSpinButton" then Obj.magic w
    else invalid_arg "Gtk.SpinButton.cast"
  external create : ?adj:[> adjustment] obj -> rate:float -> digits:int -> t
      = "ml_gtk_spin_button_new"
  external set_adjustment : [> spinbutton] obj -> [> adjustment] obj -> unit
      = "ml_gtk_spin_button_set_adjustment"
  external get_adjustment : [> spinbutton] obj -> Adjustment.t
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
  let set w ?:adjustment ?:digits ?:value ?:update_policy ?:numeric ?:wrap =
    let may_set f = may fun:(f w) in
    may_set set_adjustment adjustment;
    may_set set_digits digits;
    may_set set_value value;
    may_set set_update_policy update_policy;
    may_set set_numeric numeric;
    may_set set_wrap wrap
end

module Text = struct
  type t = [widget editable text] obj
  let cast w : t =
    if Object.is_a w "GtkText" then Obj.magic w
    else invalid_arg "Gtk.Text.cast"
  external create :
      ?hadj:[> adjustment] obj -> ?vadj:[> adjustment] obj -> ?unit -> t
      = "ml_gtk_text_new"
  external set_editable : [> text] obj -> bool -> unit
      = "ml_gtk_text_set_editable"
  external set_word_wrap : [> text] obj -> bool -> unit
      = "ml_gtk_text_set_word_wrap"
  external set_adjustments :
      [> text] obj -> [> adjustment] obj -> [> adjustment] obj -> unit
      = "ml_gtk_text_set_adjustments"
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
end

module Combo = struct
  type t = [widget container bbox combo] obj
  let cast w : t =
    if Object.is_a w "GtkCombo" then Obj.magic w
    else invalid_arg "Gtk.Combo.cast"
  external create : unit -> t = "ml_gtk_combo_new"
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
  external entry : [> combo] obj -> Entry.t = "ml_gtk_combo_entry"
  external list : [> combo] obj -> GtkList.t = "ml_gtk_combo_list"
  let set_popdown_strings combo strings =
    GtkList.clear_items (list combo) start:0 end:(-1);
    List.iter strings fun:
      begin fun s ->
	let li = ListItem.create_with_label s in
	Widget.show li;
	Container.add (list combo) li
      end
  external disable_activate : [> combo] obj -> unit
      = "ml_gtk_combo_disable_activate"
end

module Statusbar = struct
  type t = [widget container bbox statusbar]
  let cast w : t =
    if Object.is_a w "GtkStatusbar" then Obj.magic w
    else invalid_arg "Gtk.Statusbar.cast"
  type context
  type message
  external create : unit -> t = "ml_gtk_statusbar_new"
  external get_context : [> statusbar] obj -> string -> context
      = "ml_gtk_statusbar_get_context_id"
  external push : [> statusbar] obj -> context -> text:string -> message
      = "ml_gtk_statusbar_push"
  external pop : [> statusbar] obj -> context ->  unit
      = "ml_gtk_statusbar_pop"
  external remove : [> statusbar] obj -> context -> message -> unit
      = "ml_gtk_statusbar_push"
end

module GammaCurve = struct
  type t = [widget container bbox gamma]
  let cast w : t =
    if Object.is_a w "GtkGammaCurve" then Obj.magic w
    else invalid_arg "Gtk.GammaCurve.cast"
  external create : unit -> t = "ml_gtk_gamma_curve_new"
  external get : [> gamma] obj -> float = "ml_gtk_gamma_curve_get_gamma"
end
    
module Misc = struct
  type t = [widget misc] obj
  external set_alignment : [> misc] obj -> x:float -> y:float -> unit
      = "ml_gtk_misc_set_alignment"
  external set_padding : [> misc] obj -> x:int -> y:int -> unit
      = "ml_gtk_misc_set_padding"
end

module Arrow = struct
  type t = [widget misc arrow] obj
  let cast w : t =
    if Object.is_a w "GtkArrow" then Obj.magic w
    else invalid_arg "Gtk.Arrow.cast"
  external create : type:arrow -> :shadow -> t = "ml_gtk_arrow_new"
  external set : [> arrow] obj -> type:arrow -> :shadow -> unit
      = "ml_gtk_arrow_set"
end

module Image = struct
  type t = [widget misc image] obj
  let cast w : t =
    if Object.is_a w "GtkImage" then Obj.magic w
    else invalid_arg "Gtk.Image.cast"
  external create : Gdk.image -> ?mask:Gdk.bitmap -> t = "ml_gtk_image_new"
  external set : [> image] obj -> Gdk.image -> ?mask:Gdk.bitmap -> unit
      = "ml_gtk_image_set"
end

module Label = struct
  type t = [widget misc label] obj
  let cast w : t =
    if Object.is_a w "GtkLabel" then Obj.magic w
    else invalid_arg "Gtk.Label.cast"
  external create : string -> t = "ml_gtk_label_new"
  external set : [> label] obj -> string -> unit = "ml_gtk_label_set"
  external set_justify : [> label] obj -> justification -> unit
      = "ml_gtk_label_set_justify"
  let set w ?:text ?:justify =
    may fun:(set w) text;
    may fun:(set_justify w) justify
  external text : [> label] obj -> string = "ml_GtkLabel_label"
end

module TipsQuery = struct
  type t = [widget misc label tipsquery] obj
  let cast w : t =
    if Object.is_a w "GtkTipsQuery" then Obj.magic w
    else invalid_arg "Gtk.TipsQuery.cast"
  external create : unit -> t = "ml_gtk_tips_query_new"
  external start : [> tipsquery] obj -> unit = "ml_gtk_tips_query_start_query"
  external stop : [> tipsquery] obj -> unit = "ml_gtk_tips_query_stop_query"
  external set_caller : [> tipsquery] obj -> [> widget] obj -> unit
      = "ml_gtk_tips_query_set_caller"
  external set_labels :
      [> tipsquery] obj -> inactive:string -> no_tip:string -> unit
      = "ml_gtk_tips_query_set_labels"
  external set_emit_always : [> tipsquery] obj -> bool -> unit
      = "ml_gtk_tips_query_set_emit_always"
  external get_caller : [> tipsquery] obj -> Widget.t
      = "ml_gtk_tips_query_get_caller"
  external get_label_inactive : [> tipsquery] obj -> string
      = "ml_gtk_tips_query_get_label_inactive"
  external get_label_no_tip : [> tipsquery] obj -> string
      = "ml_gtk_tips_query_get_label_no_tip"
  external get_emit_always : [> tipsquery] obj -> bool
      = "ml_gtk_tips_query_get_emit_always"
  let set w ?:caller ?:emit_always ?:label_inactive ?:label_no_tip =
    may caller fun:(set_caller w);
    may emit_always fun:(set_emit_always w);
    if label_inactive <> None || label_no_tip <> None then
      set_labels w
	inactive:(may_default get_label_inactive w for:label_inactive)
	no_tip:(may_default get_label_no_tip w for:label_no_tip)
end

module Pixmap = struct
  type t = [widget misc pixmap] obj
  let cast w : t =
    if Object.is_a w "GtkPixmap" then Obj.magic w
    else invalid_arg "Gtk.Pixmap.cast"
  external create : Gdk.pixmap -> mask:Gdk.bitmap -> t
      = "ml_gtk_pixmap_new"
  external set :
      [> pixmap] obj -> ?pixmap:Gdk.pixmap -> ?mask:Gdk.bitmap -> unit
      = "ml_gtk_pixmap_set"
  external pixmap : [> pixmap] obj -> Gdk.pixmap = "ml_GtkPixmap_pixmap"
  external mask : [> pixmap] obj -> Gdk.bitmap = "ml_GtkPixmap_mask"
end

module ProgressBar = struct
  type t = [widget progress] obj
  let cast w : t =
    if Object.is_a w "GtkProgressBar" then Obj.magic w
    else invalid_arg "Gtk.ProgressBar.cast"
  external create : unit -> t = "ml_gtk_progress_bar_new"
  external update : [> progress] obj -> percent:float -> unit
      = "ml_gtk_progress_bar_update"
  external percent : [> progress] obj -> float
      = "ml_GtkProgressBar_percentage"
end

module Range = struct
  type t = [widget range] obj
  let cast w : t =
    if Object.is_a w "GtkRange" then Obj.magic w
    else invalid_arg "Gtk.Range.cast"
  external get_adjustment : [> range] obj -> Adjustment.t
      = "ml_gtk_range_get_adjustment"
  external set_adjustment : [> range] obj -> [> adjustment] obj -> unit
      = "ml_gtk_range_set_adjustment"
  external set_update_policy : [> range] obj -> update -> unit
      = "ml_gtk_range_set_update_policy"
  let set w ?:adjustment ?:update_policy =
    may adjustment fun:(set_adjustment w);
    may update_policy fun:(set_update_policy w)
end

module Scale = struct
  type t = [widget range scale] obj
  let cast w : t =
    if Object.is_a w "GtkScale" then Obj.magic w
    else invalid_arg "Gtk.Scale.cast"
  external hscale_new : [> adjustment] optobj -> t = "ml_gtk_hscale_new"
  external vscale_new : [> adjustment] optobj -> t = "ml_gtk_vscale_new"
  let create (dir : orientation) ?:adjustment =
    let create = if dir = `HORIZONTAL then hscale_new else vscale_new  in
    create (optobj adjustment)
  external set_digits : [> adjustment] obj -> int -> unit
      = "ml_gtk_scale_set_digits"
  external set_draw_value : [> adjustment] obj -> bool -> unit
      = "ml_gtk_scale_set_draw_value"
  external set_value_pos : [> adjustment] obj -> position -> unit
      = "ml_gtk_scale_set_value_pos"
  external value_width : [> adjustment] obj -> int
      = "ml_gtk_scale_value_width"
  external draw_value : [> adjustment] obj -> unit
      = "ml_gtk_scale_draw_value"
  let set w ?:adjustment ?:update_policy ?:digits ?:draw_value ?:value_pos =
    Range.set w ?:adjustment ?:update_policy;
    may digits fun:(set_digits w);
    may draw_value fun:(set_draw_value w);
    may value_pos fun:(set_value_pos w)
end

module Scrollbar = struct
  type t = [widget range scrollbar] obj
  let cast w : t =
    if Object.is_a w "GtkScrollbar" then Obj.magic w
    else invalid_arg "Gtk.Scrollbar.cast"
  external hscrollbar_new : [> adjustment] optobj -> t
      = "ml_gtk_hscrollbar_new"
  external vscrollbar_new : [> adjustment] optobj -> t
      = "ml_gtk_vscrollbar_new"
  let create (dir : orientation) ?:adjustment =
    let create = if dir = `HORIZONTAL then hscrollbar_new else vscrollbar_new
    in create (optobj adjustment)
end

module Ruler = struct
  type t = [widget ruler] obj
  let cast w : t =
    if Object.is_a w "GtkRuler" then Obj.magic w
    else invalid_arg "Gtk.Ruler.cast"
  external hruler_new : unit -> t = "ml_gtk_hruler_new"
  external vruler_new : unit -> t = "ml_gtk_vruler_new"
  let create (dir : orientation) =
    if dir = `HORIZONTAL then hruler_new () else vruler_new ()
  external set_metric : [> ruler] obj -> metric -> unit
      = "ml_gtk_ruler_set_metric"
  external set_range :
      [> ruler] obj ->
      lower:float -> upper:float -> position:float -> max_size:float -> unit
      = "ml_gtk_ruler_set_range"
  external get_lower : [> ruler] obj -> float = "ml_gtk_ruler_get_lower"
  external get_upper : [> ruler] obj -> float = "ml_gtk_ruler_get_upper"
  external get_position : [> ruler] obj -> float = "ml_gtk_ruler_get_position"
  external get_max_size : [> ruler] obj -> float = "ml_gtk_ruler_get_max_size"
  let set w ?:metric ?:lower ?:upper ?:position ?:max_size =
    may metric fun:(set_metric w);
    if lower <> None || upper <> None || position <> None || max_size <> None
    then
      set_range w lower:(may_default get_lower w for:lower)
	upper:(may_default get_upper w for:upper)
	position:(may_default get_position w for:position)
	max_size:(may_default get_max_size w for:max_size)
end

module Separator = struct
  type t = [widget separator] obj
  let cast w : t =
    if Object.is_a w "GtkSeparator" then Obj.magic w
    else invalid_arg "Gtk.Separator.cast"
  external hseparator_new : unit -> t = "ml_gtk_hseparator_new"
  external vseparator_new : unit -> t = "ml_gtk_vseparator_new"
  let create (dir : orientation) =
    if dir = `HORIZONTAL then hseparator_new () else vseparator_new ()
end

module Main = struct
  external init : string array -> string array = "ml_gtk_init"
  (* external exit : int -> unit = "ml_gtk_exit" *)
  external set_locale : unit -> string = "ml_gtk_set_locale"
  (* external main : unit -> unit = "ml_gtk_main" *)
  let argv = init Sys.argv
  let locale = set_locale ()
  external iteration_do : bool -> bool = "ml_gtk_main_iteration_do"
  let main () = while not (iteration_do true) do () done
  external quit : unit -> unit = "ml_gtk_main_quit"
  external get_version : unit -> int * int * int = "ml_gtk_get_version"
  let version = get_version ()
end

module Grab = struct
  external add : [> widget] obj -> unit = "ml_gtk_grab_add"
  external remove : [> widget] obj -> unit = "ml_gtk_grab_remove"
  external get_current : unit -> Widget.t = "ml_gtk_grab_get_current"
end

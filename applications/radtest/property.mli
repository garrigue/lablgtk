class ['a] rval :
  init:'a ->
  ?inits:string ->
  setfun:('a -> unit) ->
  ?value_list:(string * 'a) list ->
  object
    val mutable value : 'a
    val value_list : (string * 'a) list
    val mutable value_string : string
    method set : 'a -> n:string -> unit
    method value : 'a
    method value_list : (string * 'a) list
    method value_string : string
  end
type property =
    Bool of bool rval
  | Int of int rval
  | Float of float rval
  | String of string rval
  | Shadow of Gtk.Tags.shadow_type rval
val get_int_prop : 'a -> in:('a * property) list -> int
val get_float_prop : 'a -> in:('a * property) list -> float
val get_bool_prop : 'a -> in:('a * property) list -> bool
val get_string_prop : 'a -> in:('a * property) list -> string
val get_enum_prop : 'a -> in:('a * property) list -> string
val string_of_int_prop : 'a -> in:('a * property) list -> string
val string_of_float_prop : 'a -> in:('a * property) list -> string
val property_add :
  < base :
      < as_widget : Gtk.widget Gtk.obj;
        destroy : unit -> unit;
        disconnect : GtkSignal.id -> unit;
        get_id : int;
        get_type : Gtk.gtk_type;
        misc :
          < activate : unit -> bool;
            add_accelerator :
              sig:(Gtk.widget, unit -> unit) GtkSignal.t ->
              Gtk.accel_group ->
              key:char ->
              ?mod:Gdk.Tags.modifier list ->
              ?flags:Gtk.Tags.accel_flag list -> unit;
            allocation : Gtk.rectangle;
            colormap : Gdk.colormap;
            draw : Gdk.Rectangle.t -> unit;
            event : 'b. 'b Gdk.event -> bool;
            grab_default : unit -> unit;
            grab_focus : unit -> unit;
            has_focus : bool;
            hide : unit -> unit;
            hide_all : unit -> unit;
            intersect : Gdk.Rectangle.t -> Gdk.Rectangle.t option;
            is_ancestor : 'c. (#GObj.is_widget as 'c) -> bool;
            lock_accelerators : unit -> unit;
            map : unit -> unit;
            name : string;
            parent :
              < as_widget : Gtk.widget Gtk.obj;
                connect :
                  ?after:bool ->
                  < destroy : callback:(unit -> unit) -> GtkSignal.id;
                    event :
                      < any :
                          callback:(Gdk.Tags.event_type Gdk.event -> bool) ->
                          GtkSignal.id;
                        button_press :
                          callback:(GdkEvent.Button.t -> bool) ->
                          GtkSignal.id;
                        button_release :
                          callback:(GdkEvent.Button.t -> bool) ->
                          GtkSignal.id;
                        configure :
                          callback:(GdkEvent.Configure.t -> bool) ->
                          GtkSignal.id;
                        delete :
                          callback:([DELETE] Gdk.event -> bool) ->
                          GtkSignal.id;
                        destroy :
                          callback:([DESTROY] Gdk.event -> bool) ->
                          GtkSignal.id;
                        enter_notify :
                          callback:(GdkEvent.Crossing.t -> bool) ->
                          GtkSignal.id;
                        expose :
                          callback:(GdkEvent.Expose.t -> bool) ->
                          GtkSignal.id;
                        focus_in :
                          callback:(GdkEvent.Focus.t -> bool) -> GtkSignal.id;
                        focus_out :
                          callback:(GdkEvent.Focus.t -> bool) -> GtkSignal.id;
                        key_press :
                          callback:(GdkEvent.Key.t -> bool) -> GtkSignal.id;
                        key_release :
                          callback:(GdkEvent.Key.t -> bool) -> GtkSignal.id;
                        leave_notify :
                          callback:(GdkEvent.Crossing.t -> bool) ->
                          GtkSignal.id;
                        map :
                          callback:([MAP] Gdk.event -> bool) -> GtkSignal.id;
                        motion_notify :
                          callback:(GdkEvent.Motion.t -> bool) ->
                          GtkSignal.id;
                        property_notify :
                          callback:(GdkEvent.Property.t -> bool) ->
                          GtkSignal.id;
                        proximity_in :
                          callback:(GdkEvent.Proximity.t -> bool) ->
                          GtkSignal.id;
                        proximity_out :
                          callback:(GdkEvent.Proximity.t -> bool) ->
                          GtkSignal.id;
                        selection_clear :
                          callback:(GdkEvent.Selection.t -> bool) ->
                          GtkSignal.id;
                        selection_notify :
                          callback:(GdkEvent.Selection.t -> bool) ->
                          GtkSignal.id;
                        selection_request :
                          callback:(GdkEvent.Selection.t -> bool) ->
                          GtkSignal.id;
                        unmap :
                          callback:([UNMAP] Gdk.event -> bool) ->
                          GtkSignal.id;
                        .. >;
                    parent_set :
                      callback:(GObj.widget_wrapper option -> unit) ->
                      GtkSignal.id;
                    show : callback:(unit -> unit) -> GtkSignal.id;
                    .. >;
                destroy : unit -> unit;
                disconnect : GtkSignal.id -> unit;
                get_id : int;
                get_type : Gtk.gtk_type;
                misc : 'a;
                show : unit -> unit;
                stop_emit : string -> unit;
                .. >;
            pointer : int * int;
            popup : x:int -> y:int -> unit;
            realize : unit -> unit;
            remove_accelerator :
              Gtk.accel_group ->
              key:char -> ?mod:Gdk.Tags.modifier list -> unit;
            reparent : 'd. (#GObj.is_widget as 'd) -> unit;
            set :
              ?style:GObj.style ->
              ?name:string ->
              ?state:Gtk.Tags.state_type ->
              ?sensitive:bool ->
              ?extension_events:Gdk.Tags.extension_events ->
              ?can_default:bool ->
              ?can_focus:bool ->
              ?x:int -> ?y:int -> ?width:int -> ?height:int -> unit;
            set_app_paintable : bool -> unit;
            show : unit -> unit;
            show_all : unit -> unit;
            style :
              < as_style : Gtk.style;
                bg : Gtk.Tags.state_type -> Gdk.Color.t;
                colormap : Gdk.colormap;
                copy : 'e;
                font : Gdk.font;
                set :
                  ?bg:(Gtk.Tags.state_type * GdkObj.color) list ->
                  ?background:Gdk.window -> ?font:Gdk.font -> unit;
                .. > as 'e;
            toplevel :
              < as_widget : Gtk.widget Gtk.obj;
                connect :
                  ?after:bool ->
                  < destroy : callback:(unit -> unit) -> GtkSignal.id;
                    event :
                      < any :
                          callback:(Gdk.Tags.event_type Gdk.event -> bool) ->
                          GtkSignal.id;
                        button_press :
                          callback:(GdkEvent.Button.t -> bool) ->
                          GtkSignal.id;
                        button_release :
                          callback:(GdkEvent.Button.t -> bool) ->
                          GtkSignal.id;
                        configure :
                          callback:(GdkEvent.Configure.t -> bool) ->
                          GtkSignal.id;
                        delete :
                          callback:([DELETE] Gdk.event -> bool) ->
                          GtkSignal.id;
                        destroy :
                          callback:([DESTROY] Gdk.event -> bool) ->
                          GtkSignal.id;
                        enter_notify :
                          callback:(GdkEvent.Crossing.t -> bool) ->
                          GtkSignal.id;
                        expose :
                          callback:(GdkEvent.Expose.t -> bool) ->
                          GtkSignal.id;
                        focus_in :
                          callback:(GdkEvent.Focus.t -> bool) -> GtkSignal.id;
                        focus_out :
                          callback:(GdkEvent.Focus.t -> bool) -> GtkSignal.id;
                        key_press :
                          callback:(GdkEvent.Key.t -> bool) -> GtkSignal.id;
                        key_release :
                          callback:(GdkEvent.Key.t -> bool) -> GtkSignal.id;
                        leave_notify :
                          callback:(GdkEvent.Crossing.t -> bool) ->
                          GtkSignal.id;
                        map :
                          callback:([MAP] Gdk.event -> bool) -> GtkSignal.id;
                        motion_notify :
                          callback:(GdkEvent.Motion.t -> bool) ->
                          GtkSignal.id;
                        property_notify :
                          callback:(GdkEvent.Property.t -> bool) ->
                          GtkSignal.id;
                        proximity_in :
                          callback:(GdkEvent.Proximity.t -> bool) ->
                          GtkSignal.id;
                        proximity_out :
                          callback:(GdkEvent.Proximity.t -> bool) ->
                          GtkSignal.id;
                        selection_clear :
                          callback:(GdkEvent.Selection.t -> bool) ->
                          GtkSignal.id;
                        selection_notify :
                          callback:(GdkEvent.Selection.t -> bool) ->
                          GtkSignal.id;
                        selection_request :
                          callback:(GdkEvent.Selection.t -> bool) ->
                          GtkSignal.id;
                        unmap :
                          callback:([UNMAP] Gdk.event -> bool) ->
                          GtkSignal.id;
                        .. >;
                    parent_set :
                      callback:(GObj.widget_wrapper option -> unit) ->
                      GtkSignal.id;
                    show : callback:(unit -> unit) -> GtkSignal.id;
                    .. >;
                destroy : unit -> unit;
                disconnect : GtkSignal.id -> unit;
                get_id : int;
                get_type : Gtk.gtk_type;
                misc : 'a;
                show : unit -> unit;
                stop_emit : string -> unit;
                .. >;
            unmap : unit -> unit;
            unparent : unit -> unit;
            unrealize : unit -> unit;
            visible : bool;
            visual : Gdk.visual;
            visual_depth : int;
            window : Gdk.window;
            .. > as 'a;
        show : unit -> unit;
        stop_emit : string -> unit;
        .. >;
    name : string;
    proplist : (string * property) list;
    .. > ->
  unit
val property_remove :
  < base :
      < as_widget : Gtk.widget Gtk.obj;
        destroy : unit -> unit;
        disconnect : GtkSignal.id -> unit;
        get_id : int;
        get_type : Gtk.gtk_type;
        misc :
          < activate : unit -> bool;
            add_accelerator :
              sig:(Gtk.widget, unit -> unit) GtkSignal.t ->
              Gtk.accel_group ->
              key:char ->
              ?mod:Gdk.Tags.modifier list ->
              ?flags:Gtk.Tags.accel_flag list -> unit;
            allocation : Gtk.rectangle;
            colormap : Gdk.colormap;
            draw : Gdk.Rectangle.t -> unit;
            event : 'b. 'b Gdk.event -> bool;
            grab_default : unit -> unit;
            grab_focus : unit -> unit;
            has_focus : bool;
            hide : unit -> unit;
            hide_all : unit -> unit;
            intersect : Gdk.Rectangle.t -> Gdk.Rectangle.t option;
            is_ancestor : 'c. (#GObj.is_widget as 'c) -> bool;
            lock_accelerators : unit -> unit;
            map : unit -> unit;
            name : string;
            parent :
              < as_widget : Gtk.widget Gtk.obj;
                connect :
                  ?after:bool ->
                  < destroy : callback:(unit -> unit) -> GtkSignal.id;
                    event :
                      < any :
                          callback:(Gdk.Tags.event_type Gdk.event -> bool) ->
                          GtkSignal.id;
                        button_press :
                          callback:(GdkEvent.Button.t -> bool) ->
                          GtkSignal.id;
                        button_release :
                          callback:(GdkEvent.Button.t -> bool) ->
                          GtkSignal.id;
                        configure :
                          callback:(GdkEvent.Configure.t -> bool) ->
                          GtkSignal.id;
                        delete :
                          callback:([DELETE] Gdk.event -> bool) ->
                          GtkSignal.id;
                        destroy :
                          callback:([DESTROY] Gdk.event -> bool) ->
                          GtkSignal.id;
                        enter_notify :
                          callback:(GdkEvent.Crossing.t -> bool) ->
                          GtkSignal.id;
                        expose :
                          callback:(GdkEvent.Expose.t -> bool) ->
                          GtkSignal.id;
                        focus_in :
                          callback:(GdkEvent.Focus.t -> bool) -> GtkSignal.id;
                        focus_out :
                          callback:(GdkEvent.Focus.t -> bool) -> GtkSignal.id;
                        key_press :
                          callback:(GdkEvent.Key.t -> bool) -> GtkSignal.id;
                        key_release :
                          callback:(GdkEvent.Key.t -> bool) -> GtkSignal.id;
                        leave_notify :
                          callback:(GdkEvent.Crossing.t -> bool) ->
                          GtkSignal.id;
                        map :
                          callback:([MAP] Gdk.event -> bool) -> GtkSignal.id;
                        motion_notify :
                          callback:(GdkEvent.Motion.t -> bool) ->
                          GtkSignal.id;
                        property_notify :
                          callback:(GdkEvent.Property.t -> bool) ->
                          GtkSignal.id;
                        proximity_in :
                          callback:(GdkEvent.Proximity.t -> bool) ->
                          GtkSignal.id;
                        proximity_out :
                          callback:(GdkEvent.Proximity.t -> bool) ->
                          GtkSignal.id;
                        selection_clear :
                          callback:(GdkEvent.Selection.t -> bool) ->
                          GtkSignal.id;
                        selection_notify :
                          callback:(GdkEvent.Selection.t -> bool) ->
                          GtkSignal.id;
                        selection_request :
                          callback:(GdkEvent.Selection.t -> bool) ->
                          GtkSignal.id;
                        unmap :
                          callback:([UNMAP] Gdk.event -> bool) ->
                          GtkSignal.id;
                        .. >;
                    parent_set :
                      callback:(GObj.widget_wrapper option -> unit) ->
                      GtkSignal.id;
                    show : callback:(unit -> unit) -> GtkSignal.id;
                    .. >;
                destroy : unit -> unit;
                disconnect : GtkSignal.id -> unit;
                get_id : int;
                get_type : Gtk.gtk_type;
                misc : 'a;
                show : unit -> unit;
                stop_emit : string -> unit;
                .. >;
            pointer : int * int;
            popup : x:int -> y:int -> unit;
            realize : unit -> unit;
            remove_accelerator :
              Gtk.accel_group ->
              key:char -> ?mod:Gdk.Tags.modifier list -> unit;
            reparent : 'd. (#GObj.is_widget as 'd) -> unit;
            set :
              ?style:GObj.style ->
              ?name:string ->
              ?state:Gtk.Tags.state_type ->
              ?sensitive:bool ->
              ?extension_events:Gdk.Tags.extension_events ->
              ?can_default:bool ->
              ?can_focus:bool ->
              ?x:int -> ?y:int -> ?width:int -> ?height:int -> unit;
            set_app_paintable : bool -> unit;
            show : unit -> unit;
            show_all : unit -> unit;
            style :
              < as_style : Gtk.style;
                bg : Gtk.Tags.state_type -> Gdk.Color.t;
                colormap : Gdk.colormap;
                copy : 'e;
                font : Gdk.font;
                set :
                  ?bg:(Gtk.Tags.state_type * GdkObj.color) list ->
                  ?background:Gdk.window -> ?font:Gdk.font -> unit;
                .. > as 'e;
            toplevel :
              < as_widget : Gtk.widget Gtk.obj;
                connect :
                  ?after:bool ->
                  < destroy : callback:(unit -> unit) -> GtkSignal.id;
                    event :
                      < any :
                          callback:(Gdk.Tags.event_type Gdk.event -> bool) ->
                          GtkSignal.id;
                        button_press :
                          callback:(GdkEvent.Button.t -> bool) ->
                          GtkSignal.id;
                        button_release :
                          callback:(GdkEvent.Button.t -> bool) ->
                          GtkSignal.id;
                        configure :
                          callback:(GdkEvent.Configure.t -> bool) ->
                          GtkSignal.id;
                        delete :
                          callback:([DELETE] Gdk.event -> bool) ->
                          GtkSignal.id;
                        destroy :
                          callback:([DESTROY] Gdk.event -> bool) ->
                          GtkSignal.id;
                        enter_notify :
                          callback:(GdkEvent.Crossing.t -> bool) ->
                          GtkSignal.id;
                        expose :
                          callback:(GdkEvent.Expose.t -> bool) ->
                          GtkSignal.id;
                        focus_in :
                          callback:(GdkEvent.Focus.t -> bool) -> GtkSignal.id;
                        focus_out :
                          callback:(GdkEvent.Focus.t -> bool) -> GtkSignal.id;
                        key_press :
                          callback:(GdkEvent.Key.t -> bool) -> GtkSignal.id;
                        key_release :
                          callback:(GdkEvent.Key.t -> bool) -> GtkSignal.id;
                        leave_notify :
                          callback:(GdkEvent.Crossing.t -> bool) ->
                          GtkSignal.id;
                        map :
                          callback:([MAP] Gdk.event -> bool) -> GtkSignal.id;
                        motion_notify :
                          callback:(GdkEvent.Motion.t -> bool) ->
                          GtkSignal.id;
                        property_notify :
                          callback:(GdkEvent.Property.t -> bool) ->
                          GtkSignal.id;
                        proximity_in :
                          callback:(GdkEvent.Proximity.t -> bool) ->
                          GtkSignal.id;
                        proximity_out :
                          callback:(GdkEvent.Proximity.t -> bool) ->
                          GtkSignal.id;
                        selection_clear :
                          callback:(GdkEvent.Selection.t -> bool) ->
                          GtkSignal.id;
                        selection_notify :
                          callback:(GdkEvent.Selection.t -> bool) ->
                          GtkSignal.id;
                        selection_request :
                          callback:(GdkEvent.Selection.t -> bool) ->
                          GtkSignal.id;
                        unmap :
                          callback:([UNMAP] Gdk.event -> bool) ->
                          GtkSignal.id;
                        .. >;
                    parent_set :
                      callback:(GObj.widget_wrapper option -> unit) ->
                      GtkSignal.id;
                    show : callback:(unit -> unit) -> GtkSignal.id;
                    .. >;
                destroy : unit -> unit;
                disconnect : GtkSignal.id -> unit;
                get_id : int;
                get_type : Gtk.gtk_type;
                misc : 'a;
                show : unit -> unit;
                stop_emit : string -> unit;
                .. >;
            unmap : unit -> unit;
            unparent : unit -> unit;
            unrealize : unit -> unit;
            visible : bool;
            visual : Gdk.visual;
            visual_depth : int;
            window : Gdk.window;
            .. > as 'a;
        show : unit -> unit;
        stop_emit : string -> unit;
        .. >;
    name : string;
    proplist : (string * property) list;
    .. > ->
  unit
val property_update : unit -> unit
val test_unique : string -> bool

val list_remove : pred:('a -> bool) -> 'a list -> 'a list
val list_split : pred:('a -> bool) -> 'a list -> 'a list * 'a list
class virtual rwidget :
  classe:string ->
  widget:< as_widget : Gtk.widget Gtk.obj;
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
               drag :
                 < dest_set :
                     Gtk.Tags.dest_defaults list ->
                     Gtk.target_entry array ->
                     int -> Gdk.Tags.drag_action list -> unit;
                   dest_unset : unit -> unit;
                   get_data :
                     Gdk.drag_context -> target:Gdk.atom -> time:int -> unit;
                   highlight : unit -> unit;
                   source_set :
                     ?mod:Gdk.Tags.modifier list ->
                     Gtk.target_entry array ->
                     int -> Gdk.Tags.drag_action list -> unit;
                   source_set_icon :
                     colormap:Gdk.colormap -> GdkObj.pixmap -> unit;
                   source_unset : unit -> unit;
                   unhighlight : unit -> unit;
                   .. >;
               draw : Gdk.Rectangle.t -> unit;
               event : 'c. 'c Gdk.event -> bool;
               grab_default : unit -> unit;
               grab_focus : unit -> unit;
               has_focus : bool;
               hide : unit -> unit;
               hide_all : unit -> unit;
               intersect : Gdk.Rectangle.t -> Gdk.Rectangle.t option;
               is_ancestor : 'd. (#GObj.is_widget as 'd) -> bool;
               lock_accelerators : unit -> unit;
               map : unit -> unit;
               name : string;
               parent :
                 < as_widget : Gtk.widget Gtk.obj;
                   connect :
                     ?after:bool ->
                     < destroy : callback:(unit -> unit) -> GtkSignal.id;
                       drag :
                         < beginning :
                             callback:(GObj.drag_context -> unit) -> GtkSignal.id;
                           data_delete :
                             callback:(GObj.drag_context -> unit) -> GtkSignal.id;
                           data_get :
                             callback:(GObj.drag_context ->
                                       GObj.selection_data ->
                                       int -> int -> unit) ->
                             GtkSignal.id;
                           data_received :
                             callback:(GObj.drag_context ->
                                       int ->
                                       int ->
                                       GObj.selection_data ->
                                       int -> int -> unit) ->
                             GtkSignal.id;
                           drop :
                             callback:(GObj.drag_context ->
                                       int -> int -> int -> bool) ->
                             GtkSignal.id;
                           ending :
                             callback:(GObj.drag_context -> unit) -> GtkSignal.id;
                           leave :
                             callback:(GObj.drag_context -> int -> unit) ->
                             GtkSignal.id;
                           motion :
                             callback:(GObj.drag_context ->
                                       int -> int -> int -> bool) ->
                             GtkSignal.id;
                           .. >;
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
                             callback:(GdkEvent.Focus.t -> bool) ->
                             GtkSignal.id;
                           focus_out :
                             callback:(GdkEvent.Focus.t -> bool) ->
                             GtkSignal.id;
                           key_press :
                             callback:(GdkEvent.Key.t -> bool) ->
                             GtkSignal.id;
                           key_release :
                             callback:(GdkEvent.Key.t -> bool) ->
                             GtkSignal.id;
                           leave_notify :
                             callback:(GdkEvent.Crossing.t -> bool) ->
                             GtkSignal.id;
                           map :
                             callback:([MAP] Gdk.event -> bool) ->
                             GtkSignal.id;
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
                   misc : 'b;
                   show : unit -> unit;
                   stop_emit : string -> unit;
                   .. >;
               pointer : int * int;
               popup : x:int -> y:int -> unit;
               realize : unit -> unit;
               remove_accelerator :
                 Gtk.accel_group ->
                 key:char -> ?mod:Gdk.Tags.modifier list -> unit;
               reparent : 'e. (#GObj.is_widget as 'e) -> unit;
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
                   copy : 'f;
                   font : Gdk.font;
                   set :
                     ?bg:(Gtk.Tags.state_type * GdkObj.color) list ->
                     ?background:Gdk.window -> ?font:Gdk.font -> unit;
                   .. > as 'f;
               toplevel :
                 < as_widget : Gtk.widget Gtk.obj;
                   connect :
                     ?after:bool ->
                     < destroy : callback:(unit -> unit) -> GtkSignal.id;
                       drag :
                         < beginning :
                             callback:(GObj.drag_context -> unit) -> GtkSignal.id;
                           data_delete :
                             callback:(GObj.drag_context -> unit) -> GtkSignal.id;
                           data_get :
                             callback:(GObj.drag_context ->
                                       GObj.selection_data ->
                                       int -> int -> unit) ->
                             GtkSignal.id;
                           data_received :
                             callback:(GObj.drag_context ->
                                       int ->
                                       int ->
                                       GObj.selection_data ->
                                       int -> int -> unit) ->
                             GtkSignal.id;
                           drop :
                             callback:(GObj.drag_context ->
                                       int -> int -> int -> bool) ->
                             GtkSignal.id;
                           ending :
                             callback:(GObj.drag_context -> unit) -> GtkSignal.id;
                           leave :
                             callback:(GObj.drag_context -> int -> unit) ->
                             GtkSignal.id;
                           motion :
                             callback:(GObj.drag_context ->
                                       int -> int -> int -> bool) ->
                             GtkSignal.id;
                           .. >;
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
                             callback:(GdkEvent.Focus.t -> bool) ->
                             GtkSignal.id;
                           focus_out :
                             callback:(GdkEvent.Focus.t -> bool) ->
                             GtkSignal.id;
                           key_press :
                             callback:(GdkEvent.Key.t -> bool) ->
                             GtkSignal.id;
                           key_release :
                             callback:(GdkEvent.Key.t -> bool) ->
                             GtkSignal.id;
                           leave_notify :
                             callback:(GdkEvent.Crossing.t -> bool) ->
                             GtkSignal.id;
                           map :
                             callback:([MAP] Gdk.event -> bool) ->
                             GtkSignal.id;
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
                   misc : 'b;
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
               .. > as 'b;
           show : unit -> unit;
           stop_emit : string -> unit;
           .. > ->
  ?root:bool ->
  name:string ->
  setname:(string -> unit) ->
  object ('a)
    val mutable children : ('a * Gtk.Tags.pack_type * int) list
    val classe : string
    val evbox : GFrame.event_box option
    val mutable name : string
    val mutable parent : 'a option
    val mutable proplist : (string * Property.property) list
    val widget : GObj.widget
    method add : 'a -> unit
    method base : GObj.widget
    method change_name_in_proplist : string -> string -> unit
    method classe : string
    method virtual emit_code : Oformat.c -> unit
    method private emit_end_code : Oformat.c -> unit
    method private emit_start_code : Oformat.c -> unit
    method name : string
    method pack : 'a -> ?from:Gtk.Tags.pack_type -> unit
    method parent : 'a
    method proplist : (string * Property.property) list
    method remove : 'a -> unit
    method set_name : string -> unit
    method set_parent : 'a -> unit
    method widget : GObj.widget
  end
class virtual rcontainer :
  widget:#GContainer.container ->
  name:string ->
  setname:(string -> unit) ->
  ?root:bool ->
  classe:string ->
  object ('a)
    val mutable children : ('a * Gtk.Tags.pack_type * int) list
    val classe : string
    val evbox : GFrame.event_box option
    val mutable name : string
    val mutable parent : 'a option
    val mutable proplist : (string * Property.property) list
    val widget : GObj.widget
    method add : 'a -> unit
    method base : GObj.widget
    method change_name_in_proplist : string -> string -> unit
    method classe : string
    method emit_code : Oformat.c -> unit
    method private emit_end_code : Oformat.c -> unit
    method private emit_start_code : Oformat.c -> unit
    method name : string
    method pack : 'a -> ?from:Gtk.Tags.pack_type -> unit
    method parent : 'a
    method proplist : (string * Property.property) list
    method remove : 'a -> unit
    method set_name : string -> unit
    method set_parent : 'a -> unit
    method widget : GObj.widget
  end
class rwindow :
  widget:GWindow.window ->
  name:string ->
  setname:(string -> unit) ->
  object ('a)
    val mutable children : ('a * Gtk.Tags.pack_type * int) list
    val classe : string
    val evbox : GFrame.event_box option
    val mutable name : string
    val mutable parent : 'a option
    val mutable proplist : (string * Property.property) list
    val widget : GObj.widget
    method add : 'a -> unit
    method base : GObj.widget
    method change_name_in_proplist : string -> string -> unit
    method classe : string
    method emit_code : Oformat.c -> unit
    method private emit_end_code : Oformat.c -> unit
    method private emit_start_code : Oformat.c -> unit
    method name : string
    method pack : 'a -> ?from:Gtk.Tags.pack_type -> unit
    method parent : 'a
    method proplist : (string * Property.property) list
    method remove : 'a -> unit
    method set_name : string -> unit
    method set_parent : 'a -> unit
    method widget : GObj.widget
  end
val new_rwindow : name:string -> setname:(string -> unit) -> rwindow
class rbox :
  dir:Gtk.Tags.orientation ->
  widget:GPack.box ->
  name:string ->
  setname:(string -> unit) ->
  object ('a)
    val mutable children : ('a * Gtk.Tags.pack_type * int) list
    val classe : string
    val evbox : GFrame.event_box option
    val mutable name : string
    val mutable parent : 'a option
    val mutable proplist : (string * Property.property) list
    val widget : GObj.widget
    method add : 'a -> unit
    method base : GObj.widget
    method change_name_in_proplist : string -> string -> unit
    method classe : string
    method emit_code : Oformat.c -> unit
    method private emit_end_code : Oformat.c -> unit
    method private emit_start_code : Oformat.c -> unit
    method name : string
    method pack : 'a -> ?from:Gtk.Tags.pack_type -> unit
    method parent : 'a
    method proplist : (string * Property.property) list
    method remove : 'a -> unit
    method set_name : string -> unit
    method set_parent : 'a -> unit
    method widget : GObj.widget
  end
class rhbox :
  widget:GPack.box -> name:string -> setname:(string -> unit) -> rbox
class rvbox :
  widget:GPack.box -> name:string -> setname:(string -> unit) -> rbox
val new_rhbox : name:string -> setname:(string -> unit) -> rhbox
val new_rvbox : name:string -> setname:(string -> unit) -> rvbox
class rbutton :
  widget:GButton.button ->
  name:string ->
  setname:(string -> unit) ->
  object ('a)
    val mutable children : ('a * Gtk.Tags.pack_type * int) list
    val classe : string
    val evbox : GFrame.event_box option
    val mutable name : string
    val mutable parent : 'a option
    val mutable proplist : (string * Property.property) list
    val widget : GObj.widget
    method add : 'a -> unit
    method base : GObj.widget
    method change_name_in_proplist : string -> string -> unit
    method classe : string
    method emit_code : Oformat.c -> unit
    method private emit_end_code : Oformat.c -> unit
    method private emit_start_code : Oformat.c -> unit
    method name : string
    method pack : 'a -> ?from:Gtk.Tags.pack_type -> unit
    method parent : 'a
    method proplist : (string * Property.property) list
    method remove : 'a -> unit
    method set_name : string -> unit
    method set_parent : 'a -> unit
    method widget : GObj.widget
  end
val new_rbutton : name:string -> setname:(string -> unit) -> rbutton
class rcheck_button :
  widget:GButton.check_button ->
  name:string ->
  setname:(string -> unit) ->
  object ('a)
    val mutable children : ('a * Gtk.Tags.pack_type * int) list
    val classe : string
    val evbox : GFrame.event_box option
    val mutable name : string
    val mutable parent : 'a option
    val mutable proplist : (string * Property.property) list
    val widget : GObj.widget
    method add : 'a -> unit
    method base : GObj.widget
    method change_name_in_proplist : string -> string -> unit
    method classe : string
    method emit_code : Oformat.c -> unit
    method private emit_end_code : Oformat.c -> unit
    method private emit_start_code : Oformat.c -> unit
    method name : string
    method pack : 'a -> ?from:Gtk.Tags.pack_type -> unit
    method parent : 'a
    method proplist : (string * Property.property) list
    method remove : 'a -> unit
    method set_name : string -> unit
    method set_parent : 'a -> unit
    method widget : GObj.widget
  end
val new_rcheck_button :
  name:string -> setname:(string -> unit) -> rcheck_button
class rtoggle_button :
  widget:GButton.toggle_button ->
  name:string ->
  setname:(string -> unit) ->
  object ('a)
    val mutable children : ('a * Gtk.Tags.pack_type * int) list
    val classe : string
    val evbox : GFrame.event_box option
    val mutable name : string
    val mutable parent : 'a option
    val mutable proplist : (string * Property.property) list
    val widget : GObj.widget
    method add : 'a -> unit
    method base : GObj.widget
    method change_name_in_proplist : string -> string -> unit
    method classe : string
    method emit_code : Oformat.c -> unit
    method private emit_end_code : Oformat.c -> unit
    method private emit_start_code : Oformat.c -> unit
    method name : string
    method pack : 'a -> ?from:Gtk.Tags.pack_type -> unit
    method parent : 'a
    method proplist : (string * Property.property) list
    method remove : 'a -> unit
    method set_name : string -> unit
    method set_parent : 'a -> unit
    method widget : GObj.widget
  end
val new_rtoggle_button :
  name:string -> setname:(string -> unit) -> rtoggle_button
class rlabel :
  widget:GMisc.label ->
  name:string ->
  setname:(string -> unit) ->
  object ('a)
    val mutable children : ('a * Gtk.Tags.pack_type * int) list
    val classe : string
    val evbox : GFrame.event_box option
    val mutable name : string
    val mutable parent : 'a option
    val mutable proplist : (string * Property.property) list
    val widget : GObj.widget
    method add : 'a -> unit
    method base : GObj.widget
    method change_name_in_proplist : string -> string -> unit
    method classe : string
    method emit_code : Oformat.c -> unit
    method private emit_end_code : Oformat.c -> unit
    method private emit_start_code : Oformat.c -> unit
    method name : string
    method pack : 'a -> ?from:Gtk.Tags.pack_type -> unit
    method parent : 'a
    method proplist : (string * Property.property) list
    method remove : 'a -> unit
    method set_name : string -> unit
    method set_parent : 'a -> unit
    method widget : GObj.widget
  end
val new_rlabel : name:string -> setname:(string -> unit) -> rlabel
class rframe :
  widget:GFrame.frame ->
  name:string ->
  setname:(string -> unit) ->
  object ('a)
    val mutable children : ('a * Gtk.Tags.pack_type * int) list
    val classe : string
    val evbox : GFrame.event_box option
    val mutable name : string
    val mutable parent : 'a option
    val mutable proplist : (string * Property.property) list
    val widget : GObj.widget
    method add : 'a -> unit
    method base : GObj.widget
    method change_name_in_proplist : string -> string -> unit
    method classe : string
    method emit_code : Oformat.c -> unit
    method private emit_end_code : Oformat.c -> unit
    method private emit_start_code : Oformat.c -> unit
    method name : string
    method pack : 'a -> ?from:Gtk.Tags.pack_type -> unit
    method parent : 'a
    method proplist : (string * Property.property) list
    method remove : 'a -> unit
    method set_name : string -> unit
    method set_parent : 'a -> unit
    method widget : GObj.widget
  end
val new_rframe : name:string -> setname:(string -> unit) -> rframe
class rscrolled_window :
  widget:GFrame.scrolled_window ->
  name:string ->
  setname:(string -> unit) ->
  object ('a)
    val mutable children : ('a * Gtk.Tags.pack_type * int) list
    val classe : string
    val evbox : GFrame.event_box option
    val mutable name : string
    val mutable parent : 'a option
    val mutable proplist : (string * Property.property) list
    val widget : GObj.widget
    method add : 'a -> unit
    method base : GObj.widget
    method change_name_in_proplist : string -> string -> unit
    method classe : string
    method emit_code : Oformat.c -> unit
    method private emit_end_code : Oformat.c -> unit
    method private emit_start_code : Oformat.c -> unit
    method name : string
    method pack : 'a -> ?from:Gtk.Tags.pack_type -> unit
    method parent : 'a
    method proplist : (string * Property.property) list
    method remove : 'a -> unit
    method set_name : string -> unit
    method set_parent : 'a -> unit
    method widget : GObj.widget
  end
val new_rscrolled_window :
  name:string -> setname:(string -> unit) -> rscrolled_window
val new_class_list :
  (string * (name:string -> setname:(string -> unit) -> rwindow)) list
val new_rwidget :
  classe:string -> name:string -> setname:(string -> unit) -> rwindow

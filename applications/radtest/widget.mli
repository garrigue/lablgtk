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
    val mutable parent : rwidget option
    val mutable proplist : Property.property Property.SMap.t
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
    method parent : rwidget
    method proplist : Property.property Property.SMap.t
    method remove : 'a -> unit
    method set_name : string -> unit
    method set_parent : rwidget -> unit
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
    val mutable parent : rwidget option
    val mutable proplist : Property.property Property.SMap.t
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
    method parent : rwidget
    method proplist : Property.property Property.SMap.t
    method remove : 'a -> unit
    method set_name : string -> unit
    method set_parent : rwidget -> unit
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
    val mutable parent : rwidget option
    val mutable proplist : Property.property Property.SMap.t
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
    method parent : rwidget
    method proplist : Property.property Property.SMap.t
    method remove : 'a -> unit
    method set_name : string -> unit
    method set_parent : rwidget -> unit
    method widget : GObj.widget
  end
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
    val mutable parent : rwidget option
    val mutable proplist : Property.property Property.SMap.t
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
    method parent : rwidget
    method proplist : Property.property Property.SMap.t
    method remove : 'a -> unit
    method set_name : string -> unit
    method set_parent : rwidget -> unit
    method widget : GObj.widget
  end
class rhbox :
  widget:GPack.box -> name:string -> setname:(string -> unit) -> rbox
class rvbox :
  widget:GPack.box -> name:string -> setname:(string -> unit) -> rbox
class rbutton :
  widget:GButton.button ->
  name:string ->
  setname:(string -> unit) ->
  object ('a)
    val mutable children : ('a * Gtk.Tags.pack_type * int) list
    val classe : string
    val evbox : GFrame.event_box option
    val mutable name : string
    val mutable parent : rwidget option
    val mutable proplist : Property.property Property.SMap.t
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
    method parent : rwidget
    method proplist : Property.property Property.SMap.t
    method remove : 'a -> unit
    method set_name : string -> unit
    method set_parent : rwidget -> unit
    method widget : GObj.widget
  end
class rlabel :
  widget:GMisc.label ->
  name:string ->
  setname:(string -> unit) ->
  object ('a)
    val mutable children : ('a * Gtk.Tags.pack_type * int) list
    val classe : string
    val evbox : GFrame.event_box option
    val mutable name : string
    val mutable parent : rwidget option
    val mutable proplist : Property.property Property.SMap.t
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
    method parent : rwidget
    method proplist : Property.property Property.SMap.t
    method remove : 'a -> unit
    method set_name : string -> unit
    method set_parent : rwidget -> unit
    method widget : GObj.widget
  end
class rframe :
  widget:GFrame.frame ->
  name:string ->
  setname:(string -> unit) ->
  object ('a)
    val mutable children : ('a * Gtk.Tags.pack_type * int) list
    val classe : string
    val evbox : GFrame.event_box option
    val mutable name : string
    val mutable parent : rwidget option
    val mutable proplist : Property.property Property.SMap.t
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
    method parent : rwidget
    method proplist : Property.property Property.SMap.t
    method remove : 'a -> unit
    method set_name : string -> unit
    method set_parent : rwidget -> unit
    method widget : GObj.widget
  end
val new_rwidget :
  classe:string -> name:string -> setname:(string -> unit) -> rwidget

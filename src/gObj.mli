(* $Id$ *)

open Gtk

(* Object *)

class gtkobj :
  ([> `gtk] as 'a) obj ->
  object
    val obj : 'a obj
    method destroy : unit -> unit
    method get_oid : int
  end

class gtkobj_signals :
  ?after:bool -> ([>`gtk] as 'a) obj ->
  object ('b)
    val obj : 'a obj
    val after : bool
    method after : 'b
    method destroy : callback:(unit -> unit) -> GtkSignal.id
  end

class gtkobj_misc : 'a obj ->
  object
    method get_type : string
    method disconnect : GtkSignal.id -> unit
    method handler_block : GtkSignal.id -> unit
    method handler_unblock : GtkSignal.id -> unit
    method set_property : 'a. string -> 'a Gobject.data_set -> unit
    method get_property : string -> Gobject.data_get
    method freeze_notify : unit -> unit
    method thaw_notify : unit -> unit
  end

(* Widget *)

class event_signals :
  ?after:bool -> [> widget] obj ->
  object ('a)
    method after : 'a
    method any :
	callback:(Gdk.Tags.event_type Gdk.event -> bool) -> GtkSignal.id
    method button_press : callback:(GdkEvent.Button.t -> bool) -> GtkSignal.id
    method button_release :
	callback:(GdkEvent.Button.t -> bool) -> GtkSignal.id
    method configure : callback:(GdkEvent.Configure.t -> bool) -> GtkSignal.id
    method delete : callback:([`DELETE] Gdk.event -> bool) -> GtkSignal.id
    method destroy : callback:([`DESTROY] Gdk.event -> bool) -> GtkSignal.id
    method enter_notify :
	callback:(GdkEvent.Crossing.t -> bool) -> GtkSignal.id
    method expose : callback:(GdkEvent.Expose.t -> bool) -> GtkSignal.id
    method focus_in : callback:(GdkEvent.Focus.t -> bool) -> GtkSignal.id
    method focus_out : callback:(GdkEvent.Focus.t -> bool) -> GtkSignal.id
    method key_press : callback:(GdkEvent.Key.t -> bool) -> GtkSignal.id
    method key_release : callback:(GdkEvent.Key.t -> bool) -> GtkSignal.id
    method leave_notify :
	callback:(GdkEvent.Crossing.t -> bool) -> GtkSignal.id
    method map : callback:([`MAP] Gdk.event -> bool) -> GtkSignal.id
    method motion_notify :
	callback:(GdkEvent.Motion.t -> bool) -> GtkSignal.id
    method property_notify :
	callback:(GdkEvent.Property.t -> bool) -> GtkSignal.id
    method proximity_in :
	callback:(GdkEvent.Proximity.t -> bool) -> GtkSignal.id
    method proximity_out :
	callback:(GdkEvent.Proximity.t -> bool) -> GtkSignal.id
    method selection_clear :
	callback:(GdkEvent.Selection.t -> bool) -> GtkSignal.id
    method selection_notify :
	callback:(GdkEvent.Selection.t -> bool) -> GtkSignal.id
    method selection_request :
	callback:(GdkEvent.Selection.t -> bool) -> GtkSignal.id
    method unmap : callback:([`UNMAP] Gdk.event -> bool) -> GtkSignal.id
  end

class event_ops : [> widget] obj ->
  object
    method add : Gdk.Tags.event_mask list -> unit
    method connect : event_signals
    method send : GdkEvent.any -> bool
    method set_extensions : Gdk.Tags.extension_events -> unit
  end

class style : Gtk.style ->
  object ('a)
    val style : Gtk.style
    method as_style : Gtk.style
    method base : Gtk.Tags.state_type -> Gdk.Color.t
    method bg : Gtk.Tags.state_type -> Gdk.Color.t
    method colormap : Gdk.colormap
    method copy : 'a
    method dark : Gtk.Tags.state_type -> Gdk.Color.t
    method fg : Gtk.Tags.state_type -> Gdk.Color.t
    method font : Gdk.font
    method light : Gtk.Tags.state_type -> Gdk.Color.t
    method mid : Gtk.Tags.state_type -> Gdk.Color.t
    method set_bg : (Gtk.Tags.state_type * GDraw.color) list -> unit
    method set_base : (Gtk.Tags.state_type * GDraw.color) list -> unit
    method set_dark : (Gtk.Tags.state_type * GDraw.color) list -> unit
    method set_fg : (Gtk.Tags.state_type * GDraw.color) list -> unit
    method set_font : Gdk.font -> unit
    method set_light : (Gtk.Tags.state_type * GDraw.color) list -> unit
    method set_mid : (Gtk.Tags.state_type * GDraw.color) list -> unit
    method set_text : (Gtk.Tags.state_type * GDraw.color) list -> unit
    method text : Gtk.Tags.state_type -> Gdk.Color.t
  end

class selection_data :
  Gtk.selection_data ->
  object
    val sel : Gtk.selection_data
    method data : string	(* May raise Gpointer.Null *)
    method format : int
    method selection : Gdk.atom
    method typ : string
    method target : string
  end

class selection_context :
  Gtk.selection_data ->
  object
    val sel : Gtk.selection_data
    method selection : Gdk.atom
    method target : string
    method return : ?typ:string -> ?format:int -> string -> unit
  end

class drag_ops : Gtk.widget obj ->
  object
    method connect : drag_signals
    method dest_set :
      ?flags:Tags.dest_defaults list ->
      ?actions:Gdk.Tags.drag_action list -> target_entry list -> unit
    method dest_unset : unit -> unit
    method get_data : target:string -> ?time:int32 -> drag_context ->unit
    method highlight : unit -> unit
    method source_set :
      ?modi:Gdk.Tags.modifier list ->
      ?actions:Gdk.Tags.drag_action list -> target_entry list -> unit
    method source_set_icon : ?colormap:Gdk.colormap -> GDraw.pixmap -> unit
    method source_unset : unit -> unit
    method unhighlight : unit -> unit
  end

and misc_ops : Gtk.widget obj ->
  object
    inherit gtkobj_misc
    val obj : Gtk.widget obj
    method activate : unit -> bool
    method add_accelerator :
      sgn:(Gtk.widget, unit -> unit) GtkSignal.t ->
      group:accel_group -> ?modi:Gdk.Tags.modifier list ->
      ?flags:Tags.accel_flag list -> Gdk.keysym -> unit
    method add_selection_target :
      target:string -> ?info:int -> Gdk.atom -> unit
    method allocation : rectangle
    method colormap : Gdk.colormap
    method connect : misc_signals
    method convert_selection : target:string -> ?time:int32 -> Gdk.atom -> bool
    method create_pango_context : unit -> GPango.context_rw
    method draw : Gdk.Rectangle.t option -> unit
    method grab_default : unit -> unit
    method grab_focus : unit -> unit
    method grab_selection : ?time:int32 -> Gdk.atom -> bool
    method has_focus : bool
    method hide : unit -> unit
    method hide_all : unit -> unit
    method intersect : Gdk.Rectangle.t -> Gdk.Rectangle.t option
    method is_ancestor : widget -> bool
    method map : unit -> unit
    method modify_bg : (Gtk.Tags.state_type * GDraw.color) list -> unit
    method modify_base : (Gtk.Tags.state_type * GDraw.color) list -> unit
    method modify_fg : (Gtk.Tags.state_type * GDraw.color) list -> unit
    method modify_text : (Gtk.Tags.state_type * GDraw.color) list -> unit
    method modify_font : Pango.font_description -> unit
    method modify_font_by_name : string -> unit
    method name : string
    method parent : widget option
    method pango_context : GPango.context
    method pointer : int * int
    method realize : unit -> unit
    method remove_accelerator :
      group:accel_group -> ?modi:Gdk.Tags.modifier list -> Gdk.keysym -> unit
    method reparent : widget -> unit
    method set_app_paintable : bool -> unit
    method set_can_default : bool -> unit
    method set_can_focus : bool -> unit
    method set_name : string -> unit
    method set_sensitive : bool -> unit
    method set_size_chars :
      ?desc:Pango.font_description ->
      ?lang:string -> ?width:int -> ?height:int -> unit -> unit
    method set_size_request : width:int -> height:int -> unit
    method set_state : Tags.state_type -> unit
    method set_style : style -> unit
    method set_geometry :
      ?x:int -> ?y:int -> ?width:int -> ?height:int -> unit -> unit
    method show : unit -> unit
    method show_all : unit -> unit
    method style : style
    method toplevel : widget
    method unmap : unit -> unit
    method unparent : unit -> unit
    method unrealize : unit -> unit
    method visible : bool
    method visual : Gdk.visual
    method visual_depth : int
    method window : Gdk.window
  end

and widget :
  ([> Gtk.widget] as 'a) obj ->
  object
    inherit gtkobj
    val obj : 'a obj
    method as_widget : Gtk.widget obj
    method coerce : widget
    method drag : drag_ops
    method misc : misc_ops
  end

and misc_signals :
  ?after:bool -> Gtk.widget obj ->
  object ('b)
    inherit gtkobj_signals 
    val obj : Gtk.widget obj
    method after : 'b
    method hide : callback:(unit -> unit) -> GtkSignal.id
    method map : callback:(unit -> unit) -> GtkSignal.id
    method parent_set : callback:(widget option -> unit) -> GtkSignal.id
    method realize : callback:(unit -> unit) -> GtkSignal.id
    method selection_get :
      callback:(selection_context -> info:int -> time:int32 -> unit) ->
      GtkSignal.id
    method selection_received :
      callback:(selection_data -> time:int32 -> unit) -> GtkSignal.id
    method show : callback:(unit -> unit) -> GtkSignal.id
    method size_allocate : callback:(Gtk.rectangle -> unit) -> GtkSignal.id
    method state_changed :
      callback:(Gtk.Tags.state_type -> unit) -> GtkSignal.id
    method style_set : callback:(unit -> unit) -> GtkSignal.id
    method unmap : callback:(unit -> unit) -> GtkSignal.id
  end

and drag_context :
  Gdk.drag_context ->
  object
    val context : Gdk.drag_context
    method context : Gdk.drag_context
    method finish : success:bool -> del:bool -> time:int32 -> unit
    method source_widget : widget 
    method set_icon_pixmap :
      ?colormap:Gdk.colormap -> GDraw.pixmap -> hot_x:int -> hot_y:int -> unit
    method set_icon_widget : widget -> hot_x:int -> hot_y:int -> unit
    method status : ?time:int32 -> Gdk.Tags.drag_action list -> unit
    method suggested_action : Gdk.Tags.drag_action
    method targets : string list
  end

and drag_signals :
  Gtk.widget obj ->
  object ('a)
    method after : 'a
    method beginning :
      callback:(drag_context -> unit) -> GtkSignal.id
    method data_delete :
      callback:(drag_context -> unit) -> GtkSignal.id
    method data_get :
      callback:
      (drag_context -> selection_context -> info:int -> time:int32 -> unit) ->
      GtkSignal.id
    method data_received :
      callback:(drag_context -> x:int -> y:int ->
	        selection_data -> info:int -> time:int32 -> unit) -> GtkSignal.id
    method drop :
      callback:(drag_context -> x:int -> y:int -> time:int32 -> bool) ->
      GtkSignal.id
    method ending :
      callback:(drag_context -> unit) -> GtkSignal.id
    method leave :
      callback:(drag_context -> time:int32 -> unit) -> GtkSignal.id
    method motion :
      callback:(drag_context -> x:int -> y:int -> time:int32 -> bool) ->
      GtkSignal.id
  end

class widget_signals : 'a obj ->
  object
    inherit gtkobj_signals
    constraint 'a = [> Gtk.widget]
    val obj : 'a obj
  end

class widget_full : 'a obj ->
  object
    inherit widget
    constraint 'a = [> Gtk.widget]
    val obj : 'a obj
    method connect : widget_signals
  end

val as_widget : widget -> Gtk.widget obj

val pack_return :
    (#widget as 'a) ->
    packing:(widget -> unit) option -> show:bool option -> 'a
    (* To use in initializers to provide a ?packing: option *)

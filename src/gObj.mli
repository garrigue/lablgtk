(* $Id$ *)

open Gtk

(* Forward declarations *)

class type is_widget = object method as_widget : Gtk.widget obj end

class type ['a] is_item = object
  constraint 'a = [> item]
  method as_item : 'a obj
end

class type is_menu = object method as_menu : menu obj end

class type is_tree = object method as_tree : tree obj end

class type is_window = object method as_window : window obj end

(* Object *)

class gtkobj :
  'a obj ->
  object
    val obj : 'a obj
    method destroy : unit -> unit
    method disconnect : GtkSignal.id -> unit
    method get_type : gtk_type
    method get_id : int
    method stop_emit : string -> unit
  end

class gtkobj_signals :
  'a obj -> ?after:bool ->
  object
    val obj : 'a obj
    val after : bool option
    method destroy : callback:(unit -> unit) -> GtkSignal.id
  end

(* Widget *)

class event_signals :
  ([> widget]) obj -> ?after:bool ->
  object
    val obj : Gtk.widget obj
    val after : bool option
    method any :
	callback:(Gdk.Tags.event_type Gdk.event -> bool) -> GtkSignal.id
    method button_press :
	callback:(Gdk.Event.Button.t -> bool) -> GtkSignal.id
    method button_release :
	callback:(Gdk.Event.Button.t -> bool) -> GtkSignal.id
    method configure : callback:(Gdk.Event.Configure.t -> bool) -> GtkSignal.id
    method delete : callback:([DELETE] Gdk.event -> bool) -> GtkSignal.id
    method destroy : callback:([DESTROY] Gdk.event -> bool) -> GtkSignal.id
    method enter_notify :
	callback:(Gdk.Event.Crossing.t -> bool) -> GtkSignal.id
    method expose : callback:(Gdk.Event.Expose.t -> bool) -> GtkSignal.id
    method focus_in : callback:(Gdk.Event.Focus.t -> bool) -> GtkSignal.id
    method focus_out : callback:(Gdk.Event.Focus.t -> bool) -> GtkSignal.id
    method key_press : callback:(Gdk.Event.Key.t -> bool) -> GtkSignal.id
    method key_release : callback:(Gdk.Event.Key.t -> bool) -> GtkSignal.id
    method leave_notify :
	callback:(Gdk.Event.Crossing.t -> bool) -> GtkSignal.id
    method map : callback:([MAP] Gdk.event -> bool) -> GtkSignal.id
    method motion_notify :
	callback:(Gdk.Event.Motion.t -> bool) -> GtkSignal.id
    method property_notify :
	callback:(Gdk.Event.Property.t -> bool) -> GtkSignal.id
    method proximity_in :
	callback:(Gdk.Event.Proximity.t -> bool) -> GtkSignal.id
    method proximity_out :
      callback:(Gdk.Event.Proximity.t -> bool) -> GtkSignal.id
    method selection_clear :
      callback:(Gdk.Event.Selection.t -> bool) -> GtkSignal.id
    method selection_notify :
      callback:(Gdk.Event.Selection.t -> bool) -> GtkSignal.id
    method selection_request :
      callback:(Gdk.Event.Selection.t -> bool) -> GtkSignal.id
    method unmap : callback:([UNMAP] Gdk.event -> bool) -> GtkSignal.id
  end

class widget_misc :
  ([> widget]) obj ->
  object
    val obj : Gtk.widget obj
    method activate : unit -> bool
    method add_accelerator :
      sig:(Gtk.widget, unit -> unit) GtkSignal.t -> accel_group -> key:char ->
      ?mod:Gdk.Tags.modifier list -> ?flags:Tags.accel_flag list -> unit
    method colormap : Gdk.colormap
    method draw : Gdk.Rectangle.t -> unit
    method event : 'a Gdk.event -> bool
    method grab_default : unit -> unit
    method grab_focus : unit -> unit
    method hide : unit -> unit
    method hide_all : unit -> unit
    method intersect : Gdk.Rectangle.t -> Gdk.Rectangle.t option
    method is_ancestor : #is_widget -> bool
    method lock_accelerators : unit -> unit
    method map : unit -> unit
    method name : string
    method parent : widget_wrapper
    method pointer : int * int
    method popup : x:int -> y:int -> unit
    method realize : unit -> unit
    method remove_accelerator :
      accel_group -> key:char -> ?mod:Gdk.Tags.modifier list -> unit
    method reparent : #is_widget -> unit
    method set :
      ?name:string ->
      ?state:Tags.state_type ->
      ?sensitive:bool ->
      ?can_default:bool ->
      ?can_focus:bool ->
      ?x:int ->
      ?y:int -> ?width:int -> ?height:int -> ?style:style -> unit
    method show : unit -> unit
    method show_all : unit -> unit
    method show_now : unit -> unit
    method style : style
    method toplevel : Gtk.widget obj
    method unmap : unit -> unit
    method unrealize : unit -> unit
    method visible : bool
    method visual : Gdk.visual
    method window : Gdk.window
  end

and widget :
  'a[> widget] obj ->
  object
    inherit gtkobj
    val obj : 'a obj
    method as_widget : Gtk.widget obj
    method misc : widget_misc
    method show : unit -> unit
  end

and widget_signals :
  'a[> widget] obj -> ?after:bool ->
  object
    inherit gtkobj_signals 
    val obj : 'a obj
    method draw : callback:(Gdk.Rectangle.t -> unit) -> GtkSignal.id
    method event : event_signals
    method parent_set :
	callback:(widget_wrapper option -> unit) -> GtkSignal.id
    method show : callback:(unit -> unit) -> GtkSignal.id
  end

and widget_wrapper :
  'a[> widget] obj ->
  object
    inherit widget
    val obj : 'a obj
    method connect : ?after:bool -> widget_signals
  end

val pack_return : 'a -> packing:('a -> unit) option -> unit
    (* To use in initializers to provide a ?packing: option *)

(* $Id$ *)

open Gtk

(* Forward declarations *)

class type is_widget = object method as_widget : Widget.t obj end

class type ['a] is_item = object
  constraint 'a = [> item]
  method as_item : 'a obj
end

class type is_menu = object method as_menu : Menu.t obj end

class type is_tree = object method as_tree : Tree.t obj end

(* Object *)

class gtkobj :
  'a obj ->
  object
    val obj : 'a obj
    method destroy : unit -> unit
    method disconnect : Signal.id -> unit
    method get_type : Type.t
    method stop_emit : string -> unit
  end

class gtkobj_signals :
  'a obj -> ?after:bool ->
  object
    val obj : 'a obj
    val after : bool option
    method destroy : callback:(unit -> unit) -> Signal.id
  end

class gtkobj_wrapper :
  'a obj ->
  object
    inherit gtkobj
    val obj : 'a obj
    method connect : ?after:bool -> gtkobj_signals
  end

(* Widget *)

class event_signals :
  ([> widget]) obj -> ?after:bool ->
  object
    val obj : Widget.t obj
    val after : bool option
    method any : callback:(Gdk.Tags.event_type Gdk.event -> bool) -> Signal.id
    method button_press : callback:(Gdk.Event.Button.t -> bool) -> Signal.id
    method button_release : callback:(Gdk.Event.Button.t -> bool) -> Signal.id
    method configure : callback:(Gdk.Event.Configure.t -> bool) -> Signal.id
    method delete : callback:([DELETE] Gdk.event -> bool) -> Signal.id
    method destroy : callback:([DESTROY] Gdk.event -> bool) -> Signal.id
    method enter_notify : callback:(Gdk.Event.Crossing.t -> bool) -> Signal.id
    method expose : callback:(Gdk.Event.Expose.t -> bool) -> Signal.id
    method focus_in : callback:(Gdk.Event.Focus.t -> bool) -> Signal.id
    method focus_out : callback:(Gdk.Event.Focus.t -> bool) -> Signal.id
    method key_press : callback:(Gdk.Event.Key.t -> bool) -> Signal.id
    method key_release : callback:(Gdk.Event.Key.t -> bool) -> Signal.id
    method leave_notify : callback:(Gdk.Event.Crossing.t -> bool) -> Signal.id
    method map : callback:([MAP] Gdk.event -> bool) -> Signal.id
    method motion_notify : callback:(Gdk.Event.Motion.t -> bool) -> Signal.id
    method property_notify :
	callback:(Gdk.Event.Property.t -> bool) -> Signal.id
    method proximity_in :
	callback:(Gdk.Event.Proximity.t -> bool) -> Signal.id
    method proximity_out :
      callback:(Gdk.Event.Proximity.t -> bool) -> Signal.id
    method selection_clear :
      callback:(Gdk.Event.Selection.t -> bool) -> Signal.id
    method selection_notify :
      callback:(Gdk.Event.Selection.t -> bool) -> Signal.id
    method selection_request :
      callback:(Gdk.Event.Selection.t -> bool) -> Signal.id
    method unmap : callback:([UNMAP] Gdk.event -> bool) -> Signal.id
  end

class widget_misc :
  ([> widget]) obj ->
  object
    val obj : Widget.t obj
    method activate : unit -> bool
    method add_accelerator :
      sig:(Widget.t, unit -> unit) Signal.t -> AccelGroup.t -> key:char ->
      ?mod:Gdk.Tags.modifier list -> ?flags:AccelGroup.accel_flag list -> unit
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
      AccelGroup.t -> key:char -> ?mod:Gdk.Tags.modifier list -> unit
    method reparent : #is_widget -> unit
    method set :
      ?name:string ->
      ?state:Tags.state_type ->
      ?sensitive:bool ->
      ?can_default:bool ->
      ?can_focus:bool ->
      ?x:int ->
      ?y:int -> ?width:int -> ?height:int -> ?style:Style.t -> unit
    method show : unit -> unit
    method show_all : unit -> unit
    method show_now : unit -> unit
    method style : Style.t
    method toplevel : Widget.t obj
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
    method as_widget : Widget.t obj
    method misc : widget_misc
    method show : unit -> unit
  end

and widget_signals :
  'a[> widget] obj -> ?after:bool ->
  object
    inherit gtkobj_signals 
    val obj : 'a obj
    method draw : callback:(Gdk.Rectangle.t -> unit) -> Signal.id
    method event : event_signals
    method parent_set : callback:(widget_wrapper option -> unit) -> Signal.id
    method show : callback:(unit -> unit) -> Signal.id
  end

and widget_wrapper :
  'a[> widget] obj ->
  object
    inherit widget
    val obj : 'a obj
    method connect : ?after:bool -> widget_signals
  end

(* $Id$ *)

open Misc
open Gtk

(* Class declarations *)

class type is_widget = object method as_widget : Widget.t obj end

class type ['a] is_item = object
  constraint 'a = [> item]
  method as_item : 'a obj
end

class type is_menu = object method as_menu : Menu.t obj end

class type is_tree = object method as_tree : Tree.t obj end

class type is_window = object method as_window : Window.t obj end

(* Object *)

class gtkobj obj = object
  val obj = obj
  method destroy () = Object.destroy obj
  method disconnect = Signal.disconnect obj
  method get_type = Object.get_type obj
  method stop_emit name = Signal.emit_stop_by_name obj :name
end

class gtkobj_signals obj ?:after = object
  val obj = obj
  val after : bool option = after
  method destroy = Signal.connect sig:Object.Signals.destroy obj ?:after
end

class gtkobj_wrapper obj = object
  inherit gtkobj obj
  method connect = new gtkobj_signals ?obj
end

(* Widget *)

class event_signals obj ?:after = object
  val obj = Widget.coerce obj
  val after = after
  method any = Signal.connect sig:Event.Signals.any obj ?:after
  method button_press =
    Signal.connect sig:Event.Signals.button_press obj ?:after
  method button_release =
    Signal.connect sig:Event.Signals.button_release obj ?:after
  method configure = Signal.connect sig:Event.Signals.configure obj ?:after
  method delete = Signal.connect sig:Event.Signals.delete obj ?:after
  method destroy = Signal.connect sig:Event.Signals.destroy obj ?:after
  method enter_notify =
    Signal.connect sig:Event.Signals.enter_notify obj ?:after
  method expose = Signal.connect sig:Event.Signals.expose obj ?:after
  method focus_in = Signal.connect sig:Event.Signals.focus_in obj ?:after
  method focus_out = Signal.connect sig:Event.Signals.focus_out obj ?:after
  method key_press = Signal.connect sig:Event.Signals.key_press obj ?:after
  method key_release = Signal.connect sig:Event.Signals.key_release obj ?:after
  method leave_notify =
    Signal.connect sig:Event.Signals.leave_notify obj ?:after
  method map = Signal.connect sig:Event.Signals.map obj ?:after
  method motion_notify =
    Signal.connect sig:Event.Signals.motion_notify obj ?:after
  method property_notify =
    Signal.connect sig:Event.Signals.property_notify obj ?:after
  method proximity_in =
    Signal.connect sig:Event.Signals.proximity_in obj ?:after
  method proximity_out =
    Signal.connect sig:Event.Signals.proximity_out obj ?:after
  method selection_clear =
    Signal.connect sig:Event.Signals.selection_clear obj ?:after
  method selection_notify =
    Signal.connect sig:Event.Signals.selection_notify obj ?:after
  method selection_request =
    Signal.connect sig:Event.Signals.selection_request obj ?:after
  method unmap = Signal.connect sig:Event.Signals.unmap obj ?:after
end

class widget_misc obj = object
  val obj = Widget.coerce obj
  method show () = Widget.show obj
  method show_now () = Widget.show_now obj
  method show_all () = Widget.show_all obj
  method hide () = Widget.hide obj
  method hide_all () = Widget.hide_all obj
  method map () = Widget.map obj
  method unmap () = Widget.unmap obj
  method realize () = Widget.realize obj
  method unrealize () = Widget.realize obj
  method draw = Widget.draw obj
  method event : 'a. 'a Gdk.event -> bool = Widget.event obj
  method activate () = Widget.activate obj
  method reparent : 'a. (#is_widget as 'a) -> unit =
    fun w -> Widget.reparent obj w#as_widget
  method popup = Widget.popup obj
  method intersect = Widget.intersect obj
  method grab_focus () = Widget.grab_focus obj
  method grab_default () = Widget.grab_default obj
  method is_ancestor : 'a. (#is_widget as 'a) -> bool =
    fun w -> Widget.is_ancestor obj w#as_widget
  method add_accelerator = Widget.add_accelerator obj
  method remove_accelerator = Widget.remove_accelerator obj
  method lock_accelerators () = Widget.lock_accelerators obj
  method set = Widget.set ?obj
  (* get functions *)
  method name = Widget.get_name obj
  method toplevel = Widget.get_toplevel obj
  method window = Widget.window obj
  method colormap = Widget.get_colormap obj
  method visual = Widget.get_visual obj
  method pointer = Widget.get_pointer obj
  method style = Widget.get_style obj
  method visible = Widget.visible obj
  method parent = new widget_wrapper (Object.unsafe_cast (Widget.parent obj))
end

and widget obj = object (self)
  inherit gtkobj obj
  method as_widget = Widget.coerce obj
  method misc = new widget_misc obj
  method show () = Widget.show obj
end

and widget_signals obj ?:after = object
  inherit gtkobj_signals obj ?:after
  method show = Signal.connect sig:Widget.Signals.show obj ?:after
  method draw = Signal.connect sig:Widget.Signals.draw obj ?:after
  method event = new event_signals obj ?:after
  method parent_set :callback =
    Signal.connect obj sig:Widget.Signals.parent_set ?:after callback:
      begin function
	  None   -> callback None
	| Some w -> callback (Some (new widget_wrapper (Object.unsafe_cast w)))
      end
end

and widget_wrapper obj = object
  inherit widget obj
  method connect = new widget_signals ?obj
end

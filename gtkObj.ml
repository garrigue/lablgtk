(* $Id$ *)

open Misc
open Gtk

class widget_ops obj = object
  val obj = Widget.coerce obj
  method show = Widget.show obj
  method destroy = Widget.destroy obj
  method show_all = Widget.show_all obj
  method realize = Widget.realize obj
  method window = Widget.window obj
  method set = Widget.set ?obj
  method disconnect = Signal.disconnect obj
end

class type widget_meth = object
  method widget : [widget] obj
end

class ['a] widget_skel obj = object
  val obj : 'a obj = obj
  method raw = obj
  method widget = Widget.coerce obj
  method widget_ops = new widget_ops obj
  method show = Widget.show obj
  method destroy = Widget.destroy obj
end

class event_signal obj = object
  val obj = Widget.coerce obj
  method any = Signal.connect obj sig:Signal.event
  method delete = Signal.connect obj sig:Signal.delete_event
  method expose = Signal.connect obj sig:Signal.expose_event
end

class ['a] widget_signals obj = object
  val obj : 'a = obj
  method destroy = Signal.connect obj sig:Signal.destroy
  method draw = Signal.connect obj sig:Signal.draw
  method show = Signal.connect obj sig:Signal.show
  method event = new event_signal obj
end

class widget obj = object
  inherit [[widget]] widget_skel obj
  method connect = new widget_signals obj
end

class ['a] container obj = object
  inherit ['a] widget_skel obj
  method border_width = Container.border_width obj
  method add : 'b . (#widget_meth as 'b) -> unit =
    fun w -> Container.add obj w#widget
  method remove : 'b. (#widget_meth as 'b) -> unit =
    fun w -> Container.remove obj w#widget
end

class window obj = object
  inherit [[widget container window]] container obj
  method connect = new widget_signals obj
  method show_all = Widget.show_all obj
  method set_title = Window.set_title obj
  method set_wmclass = Window.set_wmclass obj
  method set_focus : 'a. (#widget_meth as 'a) -> unit =
    fun w -> Window.set_focus obj w#widget
  method set_default : 'a. (#widget_meth as 'a) -> unit =
    fun w -> Window.set_default obj w#widget
  method set_policy = Window.set_policy obj
  method activate_focus = Window.activate_focus obj
  method activate_default = Window.activate_default obj
end

let new_window dir = new window (Window.create dir)

class ['a] button_signals obj = object
  inherit ['a] widget_signals obj
  method clicked = Signal.connect obj sig:Signal.clicked
end

class ['a] button_skel obj = object
  inherit ['a] container obj
  method connect = new button_signals obj
  method clicked = Button.clicked obj
end

class button = [[widget container button]] button_skel

let new_button ?:label ?x = new button (Button.create ?:label ?x)

(* $Id$ *)

open Misc
open Gtk
open GObj
open GData

class container obj = object
  inherit widget obj
  method add : 'b . (#is_widget as 'b) -> unit =
    fun w -> Container.add obj w#as_widget
  method remove : 'b. (#is_widget as 'b) -> unit =
    fun w -> Container.remove obj w#as_widget
  method children = List.map fun:(new widget) (Container.children obj)
  method set_size ?:border = Container.set ?obj ?border_width:border
  method set_focus ?:hadjustment ?:vadjustment =
    may hadjustment fun:
      (fun (w : adjustment) ->
	Container.set_focus_hadjustment obj w#as_adjustment);
    may vadjustment fun:
      (fun (w : adjustment) ->
	Container.set_focus_vadjustment obj w#as_adjustment)
end

class container_signals obj ?:after = object
  inherit widget_signals obj ?:after
  method add :callback =
    Signal.connect sig:Container.Signals.add obj ?:after
      callback:(fun w -> callback (new widget_wrapper w))
  method remove :callback =
    Signal.connect sig:Container.Signals.remove obj ?:after
      callback:(fun w -> callback (new widget_wrapper w))
end

class container_wrapper obj = object
  inherit container obj
  method connect = new container_signals ?obj
end

class virtual ['a,'b] item_container obj = object (self)
  inherit widget obj
  method add : 'c. ('a #is_item as 'c) -> _ =
    fun w -> Container.add obj w#as_item
  method remove : 'c. ('a #is_item as 'c) -> _ =
    fun w -> Container.remove obj w#as_item
  method private virtual wrap : Widget.t obj -> 'b
  method children : 'b list =
    List.map fun:self#wrap (Container.children obj)
  method set_size ?:border = Container.set ?obj ?border_width:border
  method set_focus ?:hadjustment ?:vadjustment =
    may hadjustment fun:
      (fun (w : adjustment) ->
	Container.set_focus_hadjustment obj w#as_adjustment);
    may vadjustment fun:
      (fun (w : adjustment) ->
	Container.set_focus_vadjustment obj w#as_adjustment)
  method virtual insert : 'c. ('a #is_item as 'c) -> pos:int -> unit
  method append : 'c. ('a #is_item as 'c) -> unit =
    fun w -> self#insert w pos:(-1)
  method prepend : 'c. ('a #is_item as 'c) -> unit =
    fun w -> self#insert w pos:0
end

class item_signals obj ?:after = object
  inherit container_signals obj ?:after
  method select = Signal.connect sig:Item.Signals.select obj ?:after
  method deselect = Signal.connect sig:Item.Signals.deselect obj ?:after
  method toggle = Signal.connect sig:Item.Signals.toggle obj ?:after
end

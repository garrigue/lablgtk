(* $Id$ *)

open Misc
open Gtk
open GtkBase
open GObj
open GData

class focus obj = object
  val obj = obj
  method circulate = Container.focus obj
  method set (child : widget option) =
    let child = may_map child ~f:(fun x -> x#as_widget) in
    Container.set_focus_child obj (optboxed child)
  method set_hadjustment adj =
    Container.set_focus_hadjustment obj
      (optboxed (may_map adj ~f:as_adjustment))
  method set_vadjustment adj =
    Container.set_focus_vadjustment obj
      (optboxed (may_map adj ~f:as_adjustment))
end

class container obj = object (self)
  inherit widget obj
  method add w =
    (* Hack to avoid creating a bin class *)
    if GtkBase.Object.is_a obj "GtkBin" && Container.children obj <> [] then
      raise (Gtk.Error "GConatiner.container#add: already full");
    Container.add obj (as_widget w)
  method remove w = Container.remove obj (as_widget w)
  method children = List.map ~f:(new widget) (Container.children obj)
  method set_border_width = Container.set_border_width obj
  method focus = new focus obj
end

class container_signals obj = object
  inherit widget_signals obj
  method add ~callback =
    GtkSignal.connect ~sgn:Container.Signals.add obj ~after
      ~callback:(fun w -> callback (new widget w))
  method remove ~callback =
    GtkSignal.connect ~sgn:Container.Signals.remove obj ~after
      ~callback:(fun w -> callback (new widget w))
end

class container_full obj = object
  inherit container obj
  method connect = new container_signals obj
end

let cast_container (w : widget) =
  new container_full (GtkBase.Container.cast w#as_widget)

class virtual ['a] item_container obj = object (self)
  inherit widget obj
  method add (w : 'a) =
    Container.add obj w#as_item
  method remove (w : 'a) =
    Container.remove obj w#as_item
  method private virtual wrap : Gtk.widget obj -> 'a
  method children : 'a list =
    List.map ~f:self#wrap (Container.children obj)
  method set_border_width = Container.set_border_width obj
  method focus = new focus obj
  method virtual insert : 'a -> pos:int -> unit
  method append (w : 'a) = self#insert w ~pos:(-1)
  method prepend (w : 'a) = self#insert w ~pos:0
end

class item_signals obj = object
  inherit container_signals obj
  method select = GtkSignal.connect ~sgn:Item.Signals.select obj ~after
  method deselect = GtkSignal.connect ~sgn:Item.Signals.deselect obj ~after
  method toggle = GtkSignal.connect ~sgn:Item.Signals.toggle obj ~after
end

(* $Id$ *)

open StdLabels
open Gaux
open Gobject
open Gtk
open GtkBase
open GObj
open GData

open Container

class focus obj = object
  val obj = obj
  (* method circulate = focus obj *)
  method set (child : widget option) =
    let child = may_map child ~f:(fun x -> x#as_widget) in
    set_focus_child obj (Gpointer.optboxed child)
  method set_hadjustment adj =
    set_focus_hadjustment obj
      (Gpointer.optboxed (may_map adj ~f:as_adjustment))
  method set_vadjustment adj =
    set_focus_vadjustment obj
      (Gpointer.optboxed (may_map adj ~f:as_adjustment))
end

class ['a] container_impl obj = object (self)
  inherit ['a] widget_impl obj
  method add w = add obj (as_widget w)
  method remove w = remove obj (as_widget w)
  method children = List.map ~f:(new widget) (children obj)
  method set_border_width = set P.border_width obj
  method focus = new focus obj
end

class container = ['a] container_impl

class container_signals obj = object
  inherit widget_signals obj
  method add ~callback =
    GtkSignal.connect ~sgn:Signals.add obj ~after
      ~callback:(fun w -> callback (new widget w))
  method remove ~callback =
    GtkSignal.connect ~sgn:Signals.remove obj ~after
      ~callback:(fun w -> callback (new widget w))
end

class container_full obj = object
  inherit container obj
  method connect = new container_signals obj
end

let cast_container (w : widget) =
  new container_full (cast w#as_widget)

let pack_container ~create =
  Container.make_params ~cont:
    (fun p ?packing ?show () -> pack_return (create p) ~packing ~show)


class virtual ['a] item_container obj = object (self)
  inherit widget obj
  method add (w : 'a) =
    add obj w#as_item
  method remove (w : 'a) =
    remove obj w#as_item
  method private virtual wrap : Gtk.widget obj -> 'a
  method children : 'a list =
    List.map ~f:self#wrap (children obj)
  method set_border_width = set Container.P.border_width obj
  method focus = new focus obj
  method virtual insert : 'a -> pos:int -> unit
  method append (w : 'a) = self#insert w ~pos:(-1)
  method prepend (w : 'a) = self#insert w ~pos:0
end

class item_signals obj = object
  inherit container_signals (obj : [> Gtk.item] obj)
  method select = GtkSignal.connect ~sgn:Item.Signals.select obj ~after
  method deselect = GtkSignal.connect ~sgn:Item.Signals.deselect obj ~after
  method toggle = GtkSignal.connect ~sgn:Item.Signals.toggle obj ~after
end

(* $Id$ *)

open Gaux
open Gtk
open GtkData
open GtkBase
open GtkMenu
open GObj
open GContainer

(* Menu type *)

class menu_shell_signals obj = object
  inherit container_signals obj
  method deactivate =
    GtkSignal.connect ~sgn:MenuShell.Signals.deactivate obj ~after
end

class type virtual ['a] pre_menu = object
  inherit ['a] item_container
  method as_menu : Gtk.menu Gtk.obj
  method deactivate : unit -> unit
  method connect : menu_shell_signals
  method event : event_ops
  method popup : button:int -> time:int -> unit
  method popdown : unit -> unit
  method set_accel_group : accel_group -> unit
end

(* Menu items *)

class menu_item_signals obj = object
  inherit item_signals obj
  method activate = GtkSignal.connect ~sgn:MenuItem.Signals.activate obj
end


class ['a] pre_menu_item_skel obj = object
  inherit container obj
  method as_item = (obj :> Gtk.menu_item obj)
  method set_submenu (w : 'a pre_menu) = MenuItem.set_submenu obj w#as_menu
  method remove_submenu () = MenuItem.remove_submenu obj
  method configure = MenuItem.configure obj
  method activate () = MenuItem.activate obj
  method right_justify () = MenuItem.right_justify obj
  method add_accelerator ~group ?modi:m ?flags key=
    Widget.add_accelerator obj ~sgn:MenuItem.Signals.activate group ?flags
      ?modi:m ~key
end

class menu_item obj = object
  inherit [menu_item] pre_menu_item_skel obj
  method connect = new menu_item_signals obj
  method event = new GObj.event_ops obj
end

class menu_item_skel = [menu_item] pre_menu_item_skel

let pack_item self ~packing ~show =
  may packing ~f:(fun f -> (f (self :> menu_item) : unit));
  if show <> Some false then self#misc#show ();
  self

let menu_item ?label ?border_width ?width ?height ?packing ?show () =
  let w = MenuItem.create ?label () in
  Container.set w ?border_width ?width ?height;
  pack_item (new menu_item w) ?packing ?show

let tearoff_item ?border_width ?width ?height ?packing ?show () =
  let w = MenuItem.tearoff_create () in
  Container.set w ?border_width ?width ?height;
  pack_item (new menu_item w) ?packing ?show

class check_menu_item_signals obj = object
  inherit menu_item_signals obj
  method toggled =
    GtkSignal.connect ~sgn:CheckMenuItem.Signals.toggled obj ~after
end

class check_menu_item obj = object
  inherit menu_item_skel obj
  method set_active = CheckMenuItem.set_active obj
  method set_show_toggle = CheckMenuItem.set_show_toggle obj
  method active = CheckMenuItem.get_active obj
  method toggled () = CheckMenuItem.toggled obj
  method connect = new check_menu_item_signals obj
  method event = new GObj.event_ops obj
end

let check_menu_item ?label ?active ?show_toggle
    ?border_width ?width ?height ?packing ?show () =
  let w = CheckMenuItem.create ?label () in
  CheckMenuItem.set w ?active ?show_toggle;
  Container.set w ?border_width ?width ?height;
  pack_item (new check_menu_item w) ?packing ?show

class radio_menu_item obj = object
  inherit check_menu_item (obj : Gtk.radio_menu_item obj)
  method group = Some obj
  method set_group = RadioMenuItem.set_group obj
end

let radio_menu_item ?group ?label ?active ?show_toggle
    ?border_width ?width ?height ?packing ?show () =
  let w = RadioMenuItem.create ?group ?label () in
  CheckMenuItem.set w ?active ?show_toggle;
  Container.set w ?border_width ?width ?height;
  pack_item (new radio_menu_item w) ?packing ?show

(* Menus *)

class menu_shell obj = object
  inherit [menu_item] item_container obj
  method private wrap w = new menu_item (MenuItem.cast w)
  method insert w = MenuShell.insert obj w#as_item
  method deactivate () = MenuShell.deactivate obj
  method connect = new menu_shell_signals obj
  method event = new GObj.event_ops obj
end

class menu obj = object
  inherit menu_shell obj
  method popup = Menu.popup obj
  method popdown () = Menu.popdown obj
  method as_menu : Gtk.menu obj = obj
  method set_accel_group = Menu.set_accel_group obj
end

let menu ?border_width ?packing ?show () =
  let w = Menu.create () in
  may border_width ~f:(Container.set_border_width w);
  let self = new menu w in
  may packing ~f:(fun f -> (f self : unit));
  if show <> Some false then self#misc#show ();
  self

(* Option Menu (GtkButton?) *)

class option_menu obj = object
  inherit GButton.button_skel obj
  method connect = new GButton.button_signals obj
  method event = new GObj.event_ops obj
  method set_menu (menu : menu) = OptionMenu.set_menu obj menu#as_menu
  method get_menu = new menu (OptionMenu.get_menu obj)
  method remove_menu () = OptionMenu.remove_menu obj
  method set_history = OptionMenu.set_history obj
end

let option_menu ?border_width ?width ?height ?packing ?show () =
  let w = OptionMenu.create () in
  Container.set w ?border_width ?width ?height;
  pack_return (new option_menu w) ~packing ~show

(* Menu Bar *)

let menu_bar ?border_width ?width ?height ?packing ?show () =
  let w = MenuBar.create () in
  Container.set w ?border_width ?width ?height;
  pack_return (new menu_shell w) ~packing ~show

(* Menu Factory *)

class ['a] factory
    ?(accel_group=AccelGroup.create ())
    ?(accel_modi=[`CONTROL])
    ?(accel_flags=[`VISIBLE]) (menu_shell : 'a) =
  object (self)
    val menu_shell : #menu_shell = menu_shell
    val group = accel_group
    val m = accel_modi
    val flags = accel_flags
    method menu = menu_shell
    method accel_group = group
    method private bind ?key ?callback (item : menu_item) =
      menu_shell#append item;
      may key ~f:(item#add_accelerator ~group ~modi:m ~flags);
      may callback ~f:(fun callback -> item#connect#activate ~callback)
    method add_item ?key ?callback ?submenu label =
      let item = menu_item ~label () in
      self#bind item ?key ?callback;
      may (submenu : menu option) ~f:item#set_submenu;
      item
    method add_check_item ?active ?key ?callback label =
      let item = check_menu_item ~label ?active () in
      self#bind (item :> menu_item) ?key
	?callback:(may_map callback ~f:(fun f () -> f item#active));
      item
    method add_radio_item ?group ?active ?key ?callback label =
      let item = radio_menu_item ~label ?group ?active () in
      self#bind (item :> menu_item) ?key
	?callback:(may_map callback ~f:(fun f () -> f item#active));
      item
    method add_separator () = menu_item ~packing:menu_shell#append ()
    method add_submenu ?key label =
      let item = menu_item ~label () in
      self#bind item ?key;
      menu ~packing:item#set_submenu ();
    method add_tearoff () = tearoff_item ~packing:menu_shell#append ()
end

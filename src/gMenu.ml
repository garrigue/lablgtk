(* $Id$ *)

open Misc
open Gtk
open GtkObj
open GtkUtil

(* Menu Shell *)

class menu_shell_signals obj = object
  inherit container_signals obj
  method deactivate = Signal.connect sig:MenuShell.Signals.deactivate obj
end

class menu_shell obj = object
  inherit [MenuItem.t,menu_item] item_container obj
  method private wrap w = new menu_item (MenuItem.cast w)
  method insert : 'a. (MenuItem.t #is_item as 'a) -> _ =
    fun w -> MenuShell.insert obj w#as_item
  method deactivate () = MenuShell.deactivate obj
  method connect = new menu_shell_signals obj
end

(* Menu *)

class menu_wrapper obj = object
  inherit menu_shell obj
  method popup = Menu.popup obj
  method popdown () = Menu.popdown obj
  method as_menu : Menu.t obj = obj
  method set_accel_group = Menu.set_accel_group obj
end

class menu ?:border_width ?:width ?:height ?:packing =
  let w = Menu.create () in
  let () = Container.setter w cont:ignore ?:border_width ?:width ?:height in
  object
    inherit menu_wrapper w
    inherit packing packing
  end

(* Option Menu (GtkButton?) *)

class option_menu_wrapper (obj : OptionMenu.t obj) = object
  inherit button obj
  method set_menu (menu : menu) = OptionMenu.set_menu obj menu#as_menu
  method get_menu = new menu_wrapper (OptionMenu.get_menu obj)
  method remove_menu () = OptionMenu.remove_menu obj
  method set_history = OptionMenu.set_history obj
end

class option_menu ?:border_width ?:width ?:height ?:packing =
  let w = OptionMenu.create () in
  let () = Container.setter w cont:ignore ?:border_width ?:width ?:height in
  object
    inherit option_menu_wrapper w
    inherit packing packing
  end

(* Menu Bar *)

class menu_bar ?:border_width ?:width ?:height ?:packing =
  let w = MenuBar.create () in
  let () = Container.setter w cont:ignore ?:border_width ?:width ?:height in
  object
    inherit menu_shell w
    inherit packing packing
  end

(* Items *)

class type is_menu = object
  method as_menu : Menu.t obj
end

class item_skel obj = object
  inherit container obj
  method as_item = MenuItem.coerce obj
  method set_submenu : 'a. (#is_menu as 'a) -> unit =
    fun w -> MenuItem.set_submenu obj w#as_menu
  method remove_submenu () = MenuItem.remove_submenu obj
  method configure = MenuItem.configure obj
  method activate () = MenuItem.activate obj
  method right_justify () = MenuItem.right_justify obj
  method add_accelerator =
    Widget.add_accelerator obj sig:MenuItem.Signals.activate
end

class item_signals obj = object
  inherit GtkObj.item_signals obj
  method activate = Signal.connect sig:MenuItem.Signals.activate obj
end

class item_wrapper (obj : MenuItem.t obj) = object
  inherit item_skel obj
  method connect = new item_signals obj
end

class item ?:label ?:border_width ?:width ?:height ?:packing =
  let w = MenuItem.create ?None ?:label in
  let () = Container.setter w cont:ignore ?:border_width ?:width ?:height in
  object
    inherit item_wrapper w
    inherit packing packing
  end

class tearoff_item ?:border_width ?:width ?:height ?:packing =
  let w = MenuItem.tearoff_create () in
  let () = Container.setter w cont:ignore ?:border_width ?:width ?:height in
  object (_ : #item)
    inherit item_wrapper w
    inherit packing (packing : (#item -> unit) option)
  end

class check_item_signals obj = object
  inherit item_signals obj
  method toggled = Signal.connect sig:CheckMenuItem.Signals.toggled obj
end

class check_item_skel obj = object
  inherit item_skel obj
  method set_active = CheckMenuItem.set_active obj
  method set_show_toggle = CheckMenuItem.set_show_toggle obj
  method active = CheckMenuItem.get_active obj
  method toggled () = CheckMenuItem.toggled obj
end

class check_item_wrapper (obj : CheckMenuItem.t obj) = object
  inherit check_item_skel obj
  method connect = new check_item_signals obj
end

class check_item ?:label
    ?:active ?:show_toggle ?:border_width ?:width ?:height ?:packing =
  let w = CheckMenuItem.create ?None ?:label in
  let () =
    CheckMenuItem.setter w cont:ignore ?:active ?:show_toggle;
    Container.setter w cont:ignore ?:border_width ?:width ?:height in
  object
    inherit check_item_wrapper w
    inherit packing packing
  end

class radio_item_skel obj = object
  inherit check_item_skel obj
  method group = RadioMenuItem.group obj
  method set_group = RadioMenuItem.set_group obj
end

class radio_item_wrapper (obj : RadioMenuItem.t obj) = object
  inherit radio_item_skel obj
  method connect = new check_item_signals obj
end

class radio_item ?:group ?:label
    ?:active ?:show_toggle ?:border_width ?:width ?:height ?:packing =
  let w = RadioMenuItem.create ?None ?:group ?:label in
  let () =
    CheckMenuItem.setter w cont:ignore ?:active ?:show_toggle;
    Container.setter w cont:ignore ?:border_width ?:width ?:height in
  object
    inherit radio_item_wrapper w
    inherit packing packing
  end

(* Menu Factory *)

class ['a] factory (menu : 'a)
    ?:accel_group [< Gtk.AccelGroup.create () >]
    ?:accel_mod [< [`CONTROL] >]
    ?:accel_flags [< [`VISIBLE] >] =
  object (self)
    val menu : #menu_shell = menu
    val group = accel_group
    val m = accel_mod
    val flags = accel_flags
    method menu = menu
    method accel_group = group
    method private bind (item : item) ?:key ?:callback =
      menu#append item;
      may key fun:
	(fun key -> item#add_accelerator group :key mod:m :flags);
      may callback fun:(fun callback -> item#connect#activate :callback)
    method add_item :label ?:key ?:callback ?:submenu =
      let item = new item :label in
      self#bind item ?:key ?:callback;
      may (submenu : menu option) fun:item#set_submenu;
      item
    method add_check_item :label ?:active ?:key ?:callback =
      let item = new check_item :label ?:active in
      self#bind (item :> menu_item) ?:key
	?callback:(may_map callback fun:(fun f () -> f item#active));
      item
    method add_radio_item :label ?:group ?:active ?:key ?:callback =
      let item = new radio_item :label ?:group ?:active in
      self#bind (item :> menu_item) ?:key
	?callback:(may_map callback fun:(fun f () -> f item#active));
      item
    method add_separator () = new item packing:menu#append
    method add_submenu :label ?:key =
      let item = new item :label in
      self#bind item ?:key;
      new menu packing:item#set_submenu
end

(* $Id$ *)

open Gtk
open GObj
open GContainer

class menu_shell_signals : 'b obj ->
  object ('a)
    inherit container_signals
    constraint 'b = [>`menushell|`container|`widget]
    val obj : 'b obj
    method deactivate : callback:(unit -> unit) -> GtkSignal.id
  end

class menu_item_signals : 'b obj ->
  object ('a)
    inherit item_signals
    constraint 'b = [>`menuitem|`container|`item|`widget]
    val obj : 'b obj
    method activate : callback:(unit -> unit) -> GtkSignal.id
  end

class menu_item_skel :
  'a obj ->
  object
    inherit container
    constraint 'a = [>`widget|`container|`bin|`item|`menuitem]
    val obj : 'a obj
    method activate : unit -> unit
    method add_accelerator :
      group:accel_group ->
      ?modi:Gdk.Tags.modifier list ->
      ?flags:Tags.accel_flag list -> Gdk.keysym -> unit
    method as_item : Gtk.menu_item obj
    method configure : show_toggle:bool -> show_indicator:bool -> unit
    method remove_submenu : unit -> unit
    method right_justify : unit -> unit
    method set_submenu : menu -> unit
  end
and menu_item : 'a obj ->
  object
    inherit menu_item_skel
    constraint 'a = [>`widget|`container|`bin|`item|`menuitem]
    val obj : 'a obj
    method event : event_ops
    method connect : menu_item_signals
  end
and menu : Gtk.menu obj ->
  object
    inherit [menu_item] item_container
    val obj : Gtk.menu obj
    method add : menu_item -> unit
    method event : event_ops
    method append : menu_item -> unit
    method as_menu : Gtk.menu obj
    method children : menu_item list
    method connect : menu_shell_signals
    method deactivate : unit -> unit
    method insert : menu_item -> pos:int -> unit
    method popdown : unit -> unit
    method popup : button:int -> time:int -> unit
    method prepend : menu_item -> unit
    method remove : menu_item -> unit
    method set_accel_group : accel_group -> unit
    method set_border_width : int -> unit
    method private wrap : Gtk.widget obj -> menu_item
  end

val menu :
  ?border_width:int -> ?packing:(menu -> unit) -> ?show:bool -> unit -> menu
val menu_item :
  ?label:string ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(menu_item -> unit) -> ?show:bool -> unit -> menu_item
val tearoff_item :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(menu_item -> unit) -> ?show:bool -> unit -> menu_item

class check_menu_item_signals : 'a obj ->
  object
    inherit menu_item_signals
    constraint 'a = [>`checkmenuitem|`container|`item|`menuitem|`widget]
    val obj : 'a obj
    method toggled : callback:(unit -> unit) -> GtkSignal.id
  end

class check_menu_item : 'a obj ->
  object
    inherit menu_item_skel
    constraint 'a = [>`widget|`container|`bin|`item|`menuitem|`checkmenuitem]
    val obj : 'a obj
    method active : bool
    method event : event_ops
    method connect : check_menu_item_signals
    method set_active : bool -> unit
    method set_show_toggle : bool -> unit
    method toggled : unit -> unit
  end
val check_menu_item :
  ?label:string ->
  ?active:bool ->
  ?show_toggle:bool ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(menu_item -> unit) -> ?show:bool -> unit -> check_menu_item

class radio_menu_item : Gtk.radio_menu_item obj ->
  object
    inherit check_menu_item
    val obj : Gtk.radio_menu_item obj
    method group : Gtk.radio_menu_item group
    method set_group : Gtk.radio_menu_item group -> unit
  end
val radio_menu_item :
  ?group:Gtk.radio_menu_item group ->
  ?label:string ->
  ?active:bool ->
  ?show_toggle:bool ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(menu_item -> unit) -> ?show:bool -> unit -> radio_menu_item

class menu_shell : 'a obj ->
  object
    inherit [menu_item] item_container
    constraint 'a = [>`widget|`container|`menushell]
    val obj : 'a obj
    method event : event_ops
    method deactivate : unit -> unit
    method connect : menu_shell_signals
    method insert : menu_item -> pos:int -> unit
    method private wrap : Gtk.widget obj -> menu_item
  end

val menu_bar :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(GObj.widget -> unit) -> ?show:bool -> unit -> menu_shell

class option_menu : 'a obj ->
  object
    inherit GButton.button_skel
    constraint 'a = [>`optionmenu|`button|`container|`widget]
    val obj : 'a obj
    method event : event_ops
    method connect : GButton.button_signals
    method get_menu : menu
    method remove_menu : unit -> unit
    method set_history : int -> unit
    method set_menu : menu -> unit
  end
val option_menu :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(GObj.widget -> unit) -> ?show:bool -> unit -> option_menu

class ['a] factory :
  ?accel_group:accel_group ->
  ?accel_modi:Gdk.Tags.modifier list ->
  ?accel_flags:Tags.accel_flag list ->
  'a ->
  object
    constraint 'a = #menu_shell
    val flags : Tags.accel_flag list
    val group : accel_group
    val m : Gdk.Tags.modifier list
    val menu_shell : 'a
    method accel_group : accel_group
    method add_check_item :
      ?active:bool ->
      ?key:Gdk.keysym ->
      ?callback:(bool -> unit) -> string -> check_menu_item
    method add_item :
      ?key:Gdk.keysym ->
      ?callback:(unit -> unit) ->
      ?submenu:menu -> string -> menu_item
    method add_radio_item :
      ?group:Gtk.radio_menu_item group ->
      ?active:bool ->
      ?key:Gdk.keysym ->
      ?callback:(bool -> unit) -> string -> radio_menu_item
    method add_separator : unit -> menu_item
    method add_submenu : ?key:Gdk.keysym -> string -> menu
    method add_tearoff : unit -> menu_item
    method private bind :
      ?key:Gdk.keysym -> ?callback:(unit -> unit) -> menu_item -> unit
    method menu : 'a
  end

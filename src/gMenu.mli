(* $Id$ *)

open Gtk
open GtkObj

class menu_shell_signals :
  'a[> container menushell widget] obj ->
  object
    inherit container_signals
    val obj : 'a obj
    method deactivate : callback:(unit -> unit) -> ?after:bool -> Signal.id
  end

class menu_shell :
  'a[> container menushell widget] obj ->
  object
    inherit [MenuItem.t,menu_item] item_container
    val obj : 'a obj
    method connect : menu_shell_signals
    method deactivate : unit -> unit
    method insert : MenuItem.t #GtkObj.is_item -> pos:int -> unit
    method private wrap : Widget.t obj -> GtkObj.menu_item
  end

class menu :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:('a -> unit) ->
  object ('a)
    inherit menu_shell
    val obj : Menu.t obj
    method as_menu : Menu.t obj
    method popdown : unit -> unit
    method popup : button:int -> time:int -> unit
    method set_accel_group : AccelGroup.t -> unit
  end

class menu_wrapper : Menu.t obj -> menu

class option_menu :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:('a -> unit) ->
  object ('a)
    inherit button
    val obj : OptionMenu.t obj
    method get_menu : menu
    method remove_menu : unit -> unit
    method set_history : int -> unit
    method set_menu : menu -> unit
  end

class option_menu_wrapper : OptionMenu.t obj -> option_menu

class menu_bar :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:('a -> unit) ->
  object ('a)
    inherit menu_shell
    val obj : MenuBar.t obj
  end

class type is_menu = object
  method as_menu : Menu.t obj
end

class item_skel :
  'a[> container menuitem widget] obj ->
  object
    inherit container
    val obj : 'a obj
    method activate : unit -> unit
    method add_accelerator :
      AccelGroup.t ->
      key:char ->
      ?mod:Gdk.Tags.modifier list ->
      ?flags:AccelGroup.accel_flag list -> unit
    method as_item : MenuItem.t obj
    method configure : show_toggle:bool -> show_indicator:bool -> unit
    method remove_submenu : unit -> unit
    method right_justify : unit -> unit
    method set_submenu : #is_menu -> unit
  end

class item_signals :
  'a[> container item menuitem widget] obj ->
  object
    inherit GtkObj.item_signals
    val obj : 'a obj
    method activate : callback:(unit -> unit) -> ?after:bool -> Signal.id
  end

class item :
  ?label:string ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:('a -> unit) ->
  object ('a)
    inherit item_skel
    val obj : MenuItem.t obj
    method connect : item_signals
  end

class item_wrapper : MenuItem.t obj -> item

class tearoff_item :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:('a -> unit) -> object ('a) inherit item end

class check_item_signals :
  'a[> checkmenuitem container item menuitem widget] obj ->
  object
    inherit item_signals
    val obj : 'a obj
    method toggled : callback:(unit -> unit) -> ?after:bool -> Signal.id
  end

class check_item_skel :
  'a[> checkmenuitem container menuitem widget] obj ->
  object
    inherit item_skel
    val obj : 'a obj
    method active : bool
    method set_active : bool -> unit
    method set_show_toggle : bool -> unit
    method toggled : unit -> unit
  end
     
class check_item :
  ?label:string ->
  ?active:bool ->
  ?show_toggle:bool ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:('a -> unit) ->
  object ('a)
    inherit check_item_skel
    val obj : CheckMenuItem.t obj
    method connect : check_item_signals
  end

class check_item_wrapper : CheckMenuItem.t obj -> check_item

class radio_item_skel :
  'a[> checkmenuitem container menuitem radiomenuitem widget] obj ->
  object
    inherit check_item_skel
    val obj : 'a Gtk.obj
    method group : RadioMenuItem.group
    method set_group : RadioMenuItem.group -> unit
  end

class radio_item :
  ?group:RadioMenuItem.group ->
  ?label:string ->
  ?active:bool ->
  ?show_toggle:bool ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:('a -> unit) ->
  object ('a)
    inherit radio_item_skel
    val obj : RadioMenuItem.t obj
    method connect : check_item_signals
  end
class radio_item_wrapper : RadioMenuItem.t obj -> radio_item

class ['a] factory :
  'a ->
  ?accel_group:AccelGroup.t ->
  ?accel_mod:Gdk.Tags.modifier list ->
  ?accel_flags:AccelGroup.accel_flag list ->
  object
    constraint 'a = #menu_shell
    method accel_group : AccelGroup.t
    method add_check_item :
      label:string ->
      ?active:bool -> ?key:char -> ?callback:(bool -> unit) -> check_item
    method add_item :
      label:string ->
      ?key:char -> ?callback:(unit -> unit) -> ?submenu:menu -> item
    method add_radio_item :
      label:string ->
      ?group:RadioMenuItem.group ->
      ?active:bool -> ?key:char -> ?callback:(bool -> unit) -> radio_item
    method add_separator : unit -> item
    method add_submenu : label:string -> ?key:char -> menu
    method menu : 'a
  end

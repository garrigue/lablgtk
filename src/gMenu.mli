(* $Id$ *)

open Gtk
open GObj
open GCont

(* Menu items *)

class menu_item_skel :
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

class menu_item_signals :
  'a[> container item menuitem widget] obj -> ?after:bool ->
  object
    inherit GCont.item_signals
    val obj : 'a obj
    method activate : callback:(unit -> unit) -> Signal.id
  end

class menu_item :
  ?label:string ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(menu_item -> unit) ->
  object
    inherit menu_item_skel
    val obj : MenuItem.t obj
    method connect : ?after:bool -> menu_item_signals
  end

class menu_item_wrapper : ([> menuitem] obj) -> menu_item

class tearoff_item :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(menu_item -> unit) -> menu_item

class check_menu_item_signals :
  'a[> checkmenuitem container item menuitem widget] obj -> ?after:bool ->
  object
    inherit menu_item_signals
    val obj : 'a obj
    method toggled : callback:(unit -> unit) -> Signal.id
  end

class check_menu_item_skel :
  'a[> checkmenuitem container menuitem widget] obj ->
  object
    inherit menu_item_skel
    val obj : 'a obj
    method active : bool
    method set_active : bool -> unit
    method set_show_toggle : bool -> unit
    method toggled : unit -> unit
  end
     
class check_menu_item :
  ?label:string ->
  ?active:bool ->
  ?show_toggle:bool ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(check_menu_item -> unit) ->
  object
    inherit check_menu_item_skel
    val obj : CheckMenuItem.t obj
    method connect : ?after:bool -> check_menu_item_signals
  end

class check_menu_item_wrapper : ([> checkmenuitem] obj) -> check_menu_item

class radio_menu_item_skel :
  'a[> checkmenuitem container menuitem radiomenuitem widget] obj ->
  object
    inherit check_menu_item_skel
    val obj : 'a Gtk.obj
    method group : RadioMenuItem.group
    method set_group : RadioMenuItem.group -> unit
  end

class radio_menu_item :
  ?group:RadioMenuItem.group ->
  ?label:string ->
  ?active:bool ->
  ?show_toggle:bool ->
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(radio_menu_item -> unit) ->
  object
    inherit radio_menu_item_skel
    val obj : RadioMenuItem.t obj
    method connect : ?after:bool -> check_menu_item_signals
  end
class radio_menu_item_wrapper : ([> radiomenuitem] obj) -> radio_menu_item

(* Menus and menubars *)

class menu_shell_signals :
  'a[> container menushell widget] obj -> ?after:bool ->
  object
    inherit container_signals
    val obj : 'a obj
    method deactivate : callback:(unit -> unit) -> Signal.id
  end

class menu_shell :
  'a[> container menushell widget] obj ->
  object
    inherit [MenuItem.t,menu_item] item_container
    val obj : 'a obj
    method connect : ?after:bool -> menu_shell_signals
    method deactivate : unit -> unit
    method insert : MenuItem.t #is_item -> pos:int -> unit
    method private wrap : Widget.t obj -> menu_item
  end

class menu :
  ?border_width:int ->
  ?packing:(menu -> unit) ->
  object
    inherit menu_shell
    val obj : Menu.t obj
    method as_menu : Menu.t obj
    method popdown : unit -> unit
    method popup : button:int -> time:int -> unit
    method set_accel_group : AccelGroup.t -> unit
  end

class menu_wrapper : ([> menu] obj) -> menu

class option_menu :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(option_menu -> unit) ->
  object
    inherit GButton.button
    val obj : OptionMenu.t obj
    method get_menu : menu
    method remove_menu : unit -> unit
    method set_history : int -> unit
    method set_menu : menu -> unit
  end

class option_menu_wrapper : ([> optionmenu] obj) -> option_menu

class menu_bar :
  ?border_width:int ->
  ?width:int ->
  ?height:int ->
  ?packing:(menu_bar -> unit) ->
  object
    inherit menu_shell
    val obj : MenuBar.t obj
  end

(* Normaly you need only create a menu and use the factory *)

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
      ?active:bool -> ?key:char -> ?callback:(bool -> unit) -> check_menu_item
    method add_item :
      label:string ->
      ?key:char -> ?callback:(unit -> unit) -> ?submenu:menu -> menu_item
    method add_radio_item :
      label:string ->
      ?group:RadioMenuItem.group ->
      ?active:bool -> ?key:char -> ?callback:(bool -> unit) -> radio_menu_item
    method add_separator : unit -> menu_item
    method add_submenu : label:string -> ?key:char -> menu
    method add_tearoff : unit -> menu_item
    method menu : 'a
  end

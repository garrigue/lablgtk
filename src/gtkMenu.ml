(* $Id$ *)

open Misc
open Gtk
open GtkBase

module MenuItem = struct
  let cast w : menu_item obj =
    if Object.is_a w "GtkMenuItem" then Obj.magic w
    else invalid_arg "Gtk.MenuItem.cast"
  external coerce : [>`menuitem] obj -> menu_item obj = "%identity"
  external create : unit -> menu_item obj = "ml_gtk_menu_item_new"
  external create_with_label : string -> menu_item obj
      = "ml_gtk_menu_item_new_with_label"
  external tearoff_create : unit -> menu_item obj
      = "ml_gtk_tearoff_menu_item_new"
  let create ?:label () =
    match label with None -> create ()
    | Some label -> create_with_label label
  external set_submenu : [>`menuitem] obj -> [>`menu] obj -> unit
      = "ml_gtk_menu_item_set_submenu"
  external remove_submenu : [>`menuitem] obj -> unit
      = "ml_gtk_menu_item_remove_submenu"
  external configure :
      [>`menuitem] obj -> show_toggle:bool -> show_indicator:bool -> unit
      = "ml_gtk_menu_item_configure"
  external activate : [>`menuitem] obj -> unit
      = "ml_gtk_menu_item_activate"
  external right_justify : [>`menuitem] obj -> unit
      = "ml_gtk_menu_item_right_justify"
  module Signals = struct
    open GtkSignal
    let activate : ([>`menuitem],_) t =
      { name = "activate"; marshaller = marshal_unit }
  end
end

module CheckMenuItem = struct
  let cast w : check_menu_item obj =
    if Object.is_a w "GtkCheckMenuItem" then Obj.magic w
    else invalid_arg "Gtk.CheckMenuItem.cast"
  external coerce : [>`checkmenuitem] obj -> check_menu_item obj = "%identity"
  external create : unit -> check_menu_item obj = "ml_gtk_check_menu_item_new"
  external create_with_label : string -> check_menu_item obj
      = "ml_gtk_check_menu_item_new_with_label"
  let create ?:label () =
    match label with None -> create ()
    | Some label -> create_with_label label
  external set_active : [>`checkmenuitem] obj -> bool -> unit
      = "ml_gtk_check_menu_item_set_active"
  external get_active : [>`checkmenuitem] obj -> bool
      = "ml_gtk_check_menu_item_get_active"
  external set_show_toggle : [>`checkmenuitem] obj -> bool -> unit
      = "ml_gtk_check_menu_item_set_show_toggle"
  let set w :cont ?:active ?:show_toggle =
    may active fun:(set_active w);
    may show_toggle fun:(set_show_toggle w);
    cont w
  external toggled : [>`checkmenuitem] obj -> unit
      = "ml_gtk_check_menu_item_toggled"
  module Signals = struct
    open GtkSignal
    let toggled : ([>`checkmenuitem],_) t =
      { name = "toggled"; marshaller = marshal_unit }
  end
end

module RadioMenuItem = struct
  let cast w : radio_menu_item obj =
    if Object.is_a w "GtkRadioMenuItem" then Obj.magic w
    else invalid_arg "Gtk.RadioMenuItem.cast"
  external create : group optaddr -> radio_menu_item obj
      = "ml_gtk_radio_menu_item_new"
  external create_with_label :
      group optaddr -> string -> radio_menu_item obj
      = "ml_gtk_radio_menu_item_new_with_label"
  let create ?:group ?:label () =
    let group = optaddr group in
    match label with None -> create group
    | Some label -> create_with_label group label
  external group : [>`radiomenuitem] obj -> group
      = "ml_gtk_radio_menu_item_group"
  external set_group : [>`radiomenuitem] obj -> group -> unit
      = "ml_gtk_radio_menu_item_set_group"
end

module OptionMenu = struct
  let cast w : option_menu obj =
    if Object.is_a w "GtkOptionMenu" then Obj.magic w
    else invalid_arg "Gtk.OptionMenu.cast"
  external create : unit -> option_menu obj = "ml_gtk_option_menu_new"
  external get_menu : [>`optionmenu] obj -> menu obj
      = "ml_gtk_option_menu_get_menu"
  external set_menu : [>`optionmenu] obj -> [>`menu] obj -> unit
      = "ml_gtk_option_menu_set_menu"
  external remove_menu : [>`optionmenu] obj -> unit
      = "ml_gtk_option_menu_remove_menu"
  external set_history : [>`optionmenu] obj -> int -> unit
      = "ml_gtk_option_menu_set_history"
  let set w :cont ?:menu ?:history =
    may menu fun:(set_menu w);
    may history fun:(set_history w);
    cont w
end

module MenuShell = struct
  let cast w : menu_shell obj =
    if Object.is_a w "GtkMenuShell" then Obj.magic w
    else invalid_arg "Gtk.MenuShell.cast"
  external coerce : [>`menushell] obj -> menu_shell obj = "%identity"
  external append : [>`menushell] obj -> [>`widget] obj -> unit
      = "ml_gtk_menu_shell_append"
  external prepend : [>`menushell] obj -> [>`widget] obj -> unit
      = "ml_gtk_menu_shell_prepend"
  external insert : [>`menushell] obj -> [>`widget] obj -> pos:int -> unit
      = "ml_gtk_menu_shell_insert"
  external deactivate : [>`menushell] obj -> unit
      = "ml_gtk_menu_shell_deactivate"
  module Signals = struct
    open GtkSignal
    let deactivate : ([>`menushell],_) t =
      { name = "deactivate"; marshaller = marshal_unit }
  end
end

module Menu = struct
  let cast w : menu obj =
    if Object.is_a w "GtkMenu" then Obj.magic w
    else invalid_arg "Gtk.Menu.cast"
  external create : unit -> menu obj = "ml_gtk_menu_new"
  external popup :
      [>`menu] obj -> [>`menushell] optobj ->
      [>`menuitem] optobj -> button:int -> time:int -> unit
      = "ml_gtk_menu_popup"
  let popup ?:parent_menu ?:parent_item w =
    popup w (optboxed parent_menu) (optboxed parent_item)
  external popdown : [>`menu] obj -> unit = "ml_gtk_menu_popdown"
  external get_active : [>`menu] obj -> widget obj= "ml_gtk_menu_get_active"
  external set_active : [>`menu] obj -> int -> unit = "ml_gtk_menu_set_active"
  external set_accel_group : [>`menu] obj -> accel_group -> unit
      = "ml_gtk_menu_set_accel_group"
  external get_accel_group : [>`menu] obj -> accel_group
      = "ml_gtk_menu_get_accel_group"
  external attach_to_widget : [>`menu] obj -> [>`widget] obj -> unit
      = "ml_gtk_menu_attach_to_widget"
  external get_attach_widget : [>`menu] obj -> widget obj
      = "ml_gtk_menu_get_attach_widget"
  external detach : [>`menu] obj -> unit = "ml_gtk_menu_detach"
  let set w :cont ?:active ?:accel_group =
    may active fun:(set_active w);
    may accel_group fun:(set_accel_group w);
    cont w
end

module MenuBar = struct
  let cast w : menu_bar obj =
    if Object.is_a w "GtkMenuBar" then Obj.magic w
    else invalid_arg "Gtk.MenuBar.cast"
  external create : unit -> menu_bar obj = "ml_gtk_menu_bar_new"
end

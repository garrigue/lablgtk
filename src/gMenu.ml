(**************************************************************************)
(*                Lablgtk                                                 *)
(*                                                                        *)
(*    This program is free software; you can redistribute it              *)
(*    and/or modify it under the terms of the GNU Library General         *)
(*    Public License as published by the Free Software Foundation         *)
(*    version 2, with the exception described in file COPYING which       *)
(*    comes with the library.                                             *)
(*                                                                        *)
(*    This program is distributed in the hope that it will be useful,     *)
(*    but WITHOUT ANY WARRANTY; without even the implied warranty of      *)
(*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       *)
(*    GNU Library General Public License for more details.                *)
(*                                                                        *)
(*    You should have received a copy of the GNU Library General          *)
(*    Public License along with this program; if not, write to the        *)
(*    Free Software Foundation, Inc., 59 Temple Place, Suite 330,         *)
(*    Boston, MA 02111-1307  USA                                          *)
(*                                                                        *)
(*                                                                        *)
(**************************************************************************)

(* $Id$ *)

open Gaux
open Gobject
open Gtk
open GtkData
open GtkBase
open GtkContainers
open GtkMenu
open OgtkBaseProps
open OgtkMenuProps
open GObj
open GContainer

(* Menu type *)

class menu_shell_signals obj = object (self)
  inherit container_signals_impl obj
  method deactivate = self#connect MenuShell.S.deactivate
end

class type virtual ['a] pre_menu = object
  inherit ['a] item_container
  method as_menu : Gtk.menu Gtk.obj
  method deactivate : unit -> unit
  method connect : menu_shell_signals
  method event : event_ops
  method popup : button:int -> time:int32 -> unit
  method popdown : unit -> unit
  method set_accel_group : accel_group -> unit
  method set_accel_path : string -> unit
end

(* Menu items *)

class menu_item_signals obj = object (self)
  inherit container_signals_impl (obj : [>menu_item] obj)
  method activate = self#connect MenuItem.S.activate
end


class ['a] pre_menu_item_skel obj = object
  inherit container obj
  method as_item = (obj :> Gtk.menu_item obj)
  method set_submenu (w : 'a pre_menu) =
    MenuItem.set_submenu obj (Some w#as_menu)
  method remove_submenu () = MenuItem.set_submenu obj None
  method get_submenu =
    may_map (new GObj.widget) (MenuItem.get_submenu obj)
  method activate () = MenuItem.activate obj
  method select () = MenuItem.select obj
  method deselect () = MenuItem.deselect obj
  method add_accelerator ~group ?modi:m ?flags key=
    Widget.add_accelerator obj ~sgn:MenuItem.S.activate group ?flags
      ?modi:m ~key
end

class menu_item obj = object
  inherit [menu_item] pre_menu_item_skel obj
  method connect = new menu_item_signals obj
  method event = new GObj.event_ops obj
end

class menu_item_skel = [menu_item] pre_menu_item_skel

let pack_item ?packing ?(show=true) self =
  may packing ~f:(fun f -> (f (self :> menu_item) : unit));
  if show then self#misc#show ();
  self

let menu_item ?use_mnemonic ?label ?packing ?show () =
  let w = MenuItem.create ?use_mnemonic ?label () in
  pack_item (new menu_item w) ?packing ?show

let separator_item ?packing ?show () =
  let w = MenuItem.separator_create () in
  pack_item (new menu_item w) ?packing ?show

class check_menu_item_signals obj = object (self)
  inherit menu_item_signals obj
  method toggled = self#connect CheckMenuItem.S.toggled
end

class check_menu_item obj = object
  inherit menu_item_skel obj
  method set_active = set CheckMenuItem.P.active obj
  method set_inconsistent = set CheckMenuItem.P.inconsistent obj
  method inconsistent = get CheckMenuItem.P.inconsistent obj
  method active = get CheckMenuItem.P.active obj
  method toggled () = CheckMenuItem.toggled obj
  method connect = new check_menu_item_signals obj
  method event = new GObj.event_ops obj
end

let check_menu_item ?label ?use_mnemonic ?active ?packing ?show () =
  let w = CheckMenuItem.create ?use_mnemonic ?label () in
  CheckMenuItem.set w ?active;
  pack_item (new check_menu_item w) ?packing ?show

class radio_menu_item obj = object
  inherit check_menu_item (obj : Gtk.radio_menu_item obj)
  method group = Some obj
  method set_group = RadioMenuItem.set_group obj
end

let radio_menu_item ?group ?label ?use_mnemonic ?active ?packing ?show () =
  let w = RadioMenuItem.create ?use_mnemonic ?group ?label () in
  CheckMenuItem.set w ?active;
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
  method set_accel_path = Menu.set_accel_path obj
end

let menu ?accel_path ?border_width ?packing ?show () =
  let w = Menu.create [] in
  may border_width ~f:(set Container.P.border_width w);
  may accel_path ~f:(fun ap -> Menu.set_accel_path w ap);
  let self = new menu w in
  may packing ~f:(fun f -> (f self : unit));
  if show <> Some false then self#misc#show ();
  self

(* Menu Bar *)

let menu_bar =
  pack_container [] ~create:(fun p -> new menu_shell (MenuBar.create p))

(* Menu Factory *)

class ['a] factory
    ?(accel_group=AccelGroup.create ())
    ?(accel_path="<DEFAULT ROOT>/")
    ?(accel_modi=[`CONTROL])
    ?(accel_flags=[`VISIBLE]) (menu_shell : 'a) =
  object (self)
    val menu_shell : #menu_shell = menu_shell
    val group = accel_group
    val m = accel_modi
    val flags = (accel_flags:Gtk.Tags.accel_flag list)
    val accel_path = accel_path
    method menu = menu_shell
    method accel_group = group
    method private bind ?(modi=m) ?key ?callback (item : menu_item) label =
      menu_shell#append item;
      let accel_path = accel_path ^ label ^ "/" in
      (* Default accel path value *)
      GtkData.AccelMap.add_entry accel_path ?key ~modi:m;
      (* Register this accel path *)
      GtkBase.Widget.set_accel_path item#as_widget accel_path accel_group;
      may callback ~f:(fun callback -> item#connect#activate ~callback)
    method add_item ?key ?callback ?submenu label =
      let item = menu_item  ~use_mnemonic:true ~label () in
      self#bind item ?key ?callback label;
      may (submenu : menu option) ~f:item#set_submenu;
      item
    method add_check_item ?active ?key ?callback label =
      let item = check_menu_item ~label ~use_mnemonic:true ?active () in
      self#bind (item : check_menu_item :> menu_item) label ?key
	?callback:(may_map callback ~f:(fun f () -> f item#active));
      item
    method add_radio_item ?group ?active ?key ?callback label =
      let item = radio_menu_item ~label ~use_mnemonic:true ?group ?active () in
      self#bind (item : radio_menu_item :> menu_item) label ?key
	?callback:(may_map callback ~f:(fun f () -> f item#active));
      item
    method add_separator () = separator_item ~packing:menu_shell#append ()
    method add_submenu ?key label =
      let item = menu_item ~use_mnemonic:true ~label () in
      self#bind item ?key label;
      menu ~packing:item#set_submenu ()
end

(* $Id$ *)

open Gaux
open Gtk
open GtkBase
open GtkWindow
open GtkMisc
open GObj
open OgtkBaseProps
open GContainer

let set = Gobject.Property.set
let get = Gobject.Property.get

(** Window **)

module P = Window.P

class window obj = object (self)
  inherit ['b] bin_impl obj
  inherit window_props
  method event = new GObj.event_ops obj
  method as_window = (obj :> Gtk.window obj)
  method activate_focus () = Window.activate_focus obj
  method activate_default () = Window.activate_default obj
  method add_accel_group = Window.add_accel_group obj
  method set_modal = set obj P.modal
  method set_default_size ~width ~height =
    set obj P.default_width width;
    set obj P.default_height height
  method move = Window.move obj
  method parse_geometry = Window.parse_geometry obj
  method resize = Window.resize obj
  method set_geometry_hints ?min_size ?max_size ?base_size ?aspect
      ?resize_inc ?win_gravity ?pos ?user_pos ?user_size w =
    Window.set_geometry_hints obj ?min_size ?max_size ?base_size ?aspect
      ?resize_inc ?win_gravity ?pos ?user_pos ?user_size (as_widget w)
  method set_gravity = Window.set_gravity obj
  method set_transient_for (w : window) =
    Window.set_transient_for obj w#as_window
  method set_wm_name name = Window.set_wmclass obj ~name
  method set_wm_class cls = Window.set_wmclass obj ~clas:cls
  method show () = Widget.show obj
  method present () = Window.present obj
  method iconify () = Window.iconify obj
  method deiconify () = Window.deiconify obj
end

class window_full obj = object
  inherit window (obj : [> Gtk.window] obj)
  method connect = new container_signals_impl obj
  method maximize () = Window.maximize obj
  method unmaximize () = Window.unmaximize obj
  method fullscreen () = Window.fullscreen obj
  method unfullscreen () = Window.unfullscreen obj
  method stick () = Window.stick obj
  method unstick () = Window.unstick obj
end

let make_window ~create =
  Window.make_params ~cont:(fun pl ?wm_name ?wm_class ->
    Container.make_params pl ~cont:(fun pl ?(show=false) () ->
      let (w : #window) = create pl in
      may w#set_wm_name wm_name;
      may w#set_wm_class wm_class;
      if show then w#show ();
      w))

let window ?kind =
  make_window [] ~create:(fun pl -> new window_full (Window.create ?kind pl))

let cast_window (w : #widget) =
  new window_full (Window.cast w#as_widget)

let toplevel (w : #widget) =
  try Some (cast_window w#misc#toplevel) with Gobject.Cannot_cast _ -> None


(** Dialog **)

class ['a] dialog_signals (obj : [>Gtk.dialog] obj) tbl = object (self)
  inherit container_signals_impl obj
  method response ~(callback : 'a -> unit) = 
    self#connect Dialog.S.response
      ~callback:(fun i -> callback (List.assoc i !tbl))
  method close = self#connect Dialog.S.close
end

let rec list_rassoc k = function
  | (a, b) :: _ when b = k -> a
  | _ :: l -> list_rassoc k l
  | [] -> raise Not_found

let rnone = Dialog.std_response `NONE
let rdelete = Dialog.std_response `DELETE_EVENT

class ['a] dialog_skel obj = object (self)
  inherit window obj
  inherit dialog_props
  val tbl : (int * 'a) list ref = 
    ref [rdelete, `DELETE_EVENT]
  val mutable id = 0
  method action_area = new GPack.box (Dialog.action_area obj)
  method vbox = new GPack.box (Dialog.vbox obj)
  method connect : 'a dialog_signals = new dialog_signals obj tbl
  method response v = Dialog.response obj (list_rassoc v !tbl)
  method set_response_sensitive v s =
    Dialog.set_response_sensitive obj (list_rassoc v !tbl) s
  method set_default_response v = 
    Dialog.set_default_response obj (list_rassoc v !tbl)
  method run () = 
    let resp = Dialog.run obj in
    if resp = rnone
    then failwith "dialog destroyed"
    else List.assoc resp !tbl
end

class ['a] dialog obj = object (self)
  inherit ['a] dialog_skel obj
  method add_button text (v : 'a) =
    tbl := (id, v) :: !tbl ;
    Dialog.add_button obj text id ;
    id <- succ id
  method add_button_stock s_id (v : 'a) =
    self#add_button (GtkStock.convert_id s_id) v
end

let make_dialog pl ?parent ?destroy_with_parent ~create =
  make_window ~create:(fun pl ->
    let d = create pl in
    may (fun p -> d#set_transient_for (p : #window :> window)) parent ;
    may d#set_destroy_with_parent destroy_with_parent ;
    d) pl

let dialog ?(no_separator=false) =
  make_dialog [] ~create:(fun pl ->
    new dialog (Dialog.create pl))

(** MessageDialog **)

type 'a buttons = Gtk.Tags.buttons * (int * 'a) list
module Buttons = struct
let rok = Dialog.std_response `OK
and rclose = Dialog.std_response `CLOSE
and ryes = Dialog.std_response `YES
and rno = Dialog.std_response `NO
and rcancel = Dialog.std_response `CANCEL
let ok = `OK, [ rok, `OK ]
let close = `CLOSE, [ rclose, `CLOSE ]
let yes_no = `YES_NO, [ ryes, `YES ; rno, `NO ]
let ok_cancel = `OK_CANCEL, [ rok, `OK; rcancel, `CANCEL ]
type color_selection = [`OK | `CANCEL | `HELP | `DELETE_EVENT]
type file_selection = [`OK | `CANCEL | `HELP | `DELETE_EVENT]
type font_selection = [`OK | `CANCEL | `APPLY | `DELETE_EVENT]
end

class ['a] message_dialog obj ~(buttons : 'a buttons) = object
  inherit ['a] dialog_skel obj
  inherit message_dialog_props
  initializer
    tbl := snd buttons @ !tbl
end

let message_dialog ?(message="") ~message_type ~buttons =
  make_dialog [] ~create:(fun pl ->
    let w = MessageDialog.create 
	~message_type ~buttons:(fst buttons) ~message () in
    Gobject.set_params w pl;
    new message_dialog ~buttons w)


(** ColorSelectionDialog **)

class color_selection_dialog obj = object
  inherit [Buttons.color_selection] dialog_skel (obj : Gtk.color_selection_dialog obj)
  method ok_button =
    new GButton.button (ColorSelectionDialog.ok_button obj)
  method cancel_button =
    new GButton.button (ColorSelectionDialog.cancel_button obj)
  method help_button =
    new GButton.button (ColorSelectionDialog.help_button obj)
  method colorsel =
    new GMisc.color_selection (ColorSelectionDialog.colorsel obj)
  initializer
    tbl := [ Buttons.rok, `OK ; 
	     Buttons.rcancel, `CANCEL ;
	     Dialog.std_response `HELP, `HELP ] @ !tbl
end

let color_selection_dialog ?(title="Pick a color") =
  make_dialog [] ~title ~resizable:false ~create:(fun pl ->
    new color_selection_dialog (ColorSelectionDialog.create pl))


(** FileSelection **)
class file_selection obj = object
  inherit [Buttons.file_selection] dialog_skel (obj : Gtk.file_selection obj)
  inherit file_selection_props
  method complete = FileSelection.complete obj
  method get_selections = FileSelection.get_selections obj
  method ok_button = new GButton.button (FileSelection.get_ok_button obj)
  method cancel_button =
    new GButton.button (FileSelection.get_cancel_button obj)
  method help_button = new GButton.button (FileSelection.get_help_button obj)
  method file_list : string GList.clist =
    new GList.clist (FileSelection.get_file_list obj)
  method dir_list : string GList.clist =
    new GList.clist (FileSelection.get_dir_list obj)
  initializer
    tbl := [ Buttons.rok, `OK ; 
	     Buttons.rcancel, `CANCEL ;
	     Dialog.std_response `HELP, `HELP ] @ !tbl
end

let file_selection ?(title="Choose a file") ?(show_fileops=false) =
  FileSelection.make_params [] ~show_fileops ~cont:(
  make_dialog ?title:None ~create:(fun pl ->
    let w = FileSelection.create title in
    Gobject.set_params w pl;
    new file_selection w))


(** FontSelectionDialog **)

class font_selection_dialog obj = object
  inherit [Buttons.font_selection] dialog_skel (obj : Gtk.font_selection_dialog obj)
  method selection =
    new GMisc.font_selection (FontSelectionDialog.font_selection obj)
  method ok_button =  new GButton.button (FontSelectionDialog.ok_button obj)
  method apply_button =
    new GButton.button (FontSelectionDialog.apply_button obj)
  method cancel_button =
    new GButton.button (FontSelectionDialog.cancel_button obj)
  initializer
    tbl := [ Buttons.rok, `OK ; 
	     Buttons.rcancel, `CANCEL ;
	     Dialog.std_response `APPLY, `APPLY ] @ !tbl
end

let font_selection_dialog ?title =
  make_dialog [] ?title ~create:(fun pl ->
    new font_selection_dialog (FontSelectionDialog.create pl))


(** Plug **)

class plug_signals obj = object
  inherit container_signals_impl (obj : [> plug] obj)
  inherit plug_sigs
end

class plug (obj : Gtk.plug obj) = object
  inherit window obj
  method connect = new plug_signals obj
end

let plug ~window:xid =
  Container.make_params [] ~cont:(fun pl ?(show=false) () ->
    let w = Plug.create xid in
    Gobject.set_params w pl;
    if show then Widget.show w;
    new plug w)

(** Socket **)

class socket_signals obj = object
  inherit container_signals_impl (obj : [> socket] obj)
  inherit socket_sigs
end

class socket obj = object (self)
  inherit container (obj : Gtk.socket obj)
  method connect = new socket_signals obj
  method steal = Socket.steal obj
  method xwindow =
    self#misc#realize ();
    Gdk.Window.get_xwindow self#misc#window
end

let socket =
  pack_container [] ~create:(fun pl -> new socket (Socket.create pl))

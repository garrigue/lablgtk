(* $Id$ *)

open Gaux
open Gtk
open GtkBase
open GtkWindow
open GtkMisc
open GObj
open OGtkProps
open GContainer

let set = Gobject.Property.set
let get = Gobject.Property.get

(** Window **)

module P = Window.P

class ['a] window_skel obj = object (self)
  constraint 'a = _ #window_skel
  inherit ['b] container_impl obj
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
  method resize = Window.resize obj
  method set_transient_for (w : 'a) =
    Window.set_transient_for obj w#as_window
  method set_wm_name name = Window.set_wmclass obj ~name
  method set_wm_class cls = Window.set_wmclass obj ~clas:cls
  method show () = Widget.show obj
  method present () = Window.present obj
end

class window obj = object
  inherit [window] window_skel (obj : Gtk.window obj)
  method connect = new container_signals obj
end

let make_window ~create =
  Window.make_params ~cont:(fun pl ?wm_name ?wm_class ?x ?y ->
    Container.make_params pl ~cont:(fun pl ?(show=false) () ->
      let (w : _ #window_skel) = create pl in
      may w#set_wm_name wm_name;
      may w#set_wm_class wm_class;
      w#misc#set_geometry ?x ?y ();
      if show then w#show ();
      w))

let window ?kind =
  make_window [] ~create:(fun pl -> new window (Window.create ?kind pl))

let cast_window (w : #widget) =
  new window (Window.cast w#as_widget)

let toplevel (w : #widget) =
  try Some (cast_window w#misc#toplevel) with Gobject.Cannot_cast _ -> None


(** Dialog **)

class ['a] dialog_signals (obj : [>Gtk.dialog] obj) tbl = object (self)
  inherit widget_signals_impl obj
  inherit container_sigs
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

class ['a] dialog obj = object
  inherit [window] window_skel obj
  inherit dialog_props
  val tbl = ref [rnone, `NONE; rdelete, `DELETE_EVENT]
  val mutable id = 0
  method action_area = new GPack.box (Dialog.action_area obj)
  method vbox = new GPack.box (Dialog.vbox obj)
  method connect : 'a dialog_signals = new dialog_signals obj tbl
  method add_button text (v : 'a) =
    tbl := (id, v) :: !tbl ;
    Dialog.add_button obj text id ;
    id <- succ id
  method add_button_stock s_id (v : 'a) =
    tbl := (id, v) :: !tbl ;
    Dialog.add_button obj (GtkStock.convert_id s_id) id ;
    id <- succ id
  method response v = Dialog.response obj (list_rassoc v !tbl)
  method set_response_sensitive v s =
    Dialog.set_response_sensitive obj (list_rassoc v !tbl) s
  method set_default_response v = 
    Dialog.set_default_response obj (list_rassoc v !tbl)
  method run () = 
    let resp = Dialog.run obj in
    List.assoc resp !tbl
end

let dialog ?parent ?destroy_with_parent ?(no_separator=false) =
  make_window [] ~create:(fun pl ->
    let w = new dialog (Dialog.create pl) in
    may (fun p -> w#set_transient_for (p :> window)) parent ;
    may w#set_destroy_with_parent destroy_with_parent ;
    if no_separator then w#set_has_separator false;
    w)


(** MessageDialog **)

type 'a buttons = Gtk.Tags.buttons * (int * 'a) list
module Buttons = struct
let rok = Dialog.std_response `OK
and rclose = Dialog.std_response `CLOSE
and ryes = Dialog.std_response `YES
and rno = Dialog.std_response `NO
and rcancel = Dialog.std_response `CANCEL
let none = `NONE, [ ]
let ok = `OK, [ rok, `OK ]
let close = `CLOSE, [ rclose, `CLOSE ]
let yes_no = `YES_NO, [ ryes, `YES ; rno, `NO ]
let ok_cancel = `OK_CANCEL, [ rok, `OK; rcancel, `CANCEL ]
end

class ['a] message_dialog obj ~(buttons : 'a buttons) = object
  inherit ['a] dialog obj
  inherit message_dialog_props
  initializer
    tbl := snd buttons @ !tbl
end

let message_dialog ?(message="") ~message_type ~buttons
    ?parent ?destroy_with_parent=
  make_window [] ~create:(fun pl ->
    let parent = match parent with None -> None | Some x -> Some x#as_window in
    let w = MessageDialog.create ?parent
        ~message_type ~buttons:(fst buttons) ~message () in
    Gobject.set_params w pl;
    may (Gobject.set Window.P.destroy_with_parent w) destroy_with_parent ;
    new message_dialog ~buttons w)


(** ColorSelectionDialog **)

class color_selection_dialog obj = object
  inherit [window] window_skel (obj : Gtk.color_selection_dialog obj)
  method connect = new container_signals obj
  method ok_button =
    new GButton.button (ColorSelectionDialog.ok_button obj)
  method cancel_button =
    new GButton.button (ColorSelectionDialog.cancel_button obj)
  method help_button =
    new GButton.button (ColorSelectionDialog.help_button obj)
  method colorsel =
    new GMisc.color_selection (ColorSelectionDialog.colorsel obj)
end

let color_selection_dialog ?(title="Pick a color") =
  make_window [] ~title ~resizable:false ~create:(fun pl ->
    new color_selection_dialog (ColorSelectionDialog.create pl))


(** FileSelection **)

class file_selection obj = object
  inherit [window] window_skel (obj : Gtk.file_selection obj)
  inherit file_selection_props
  method connect = new container_signals obj
  method complete = FileSelection.complete obj
  method get_selections = FileSelection.get_selections obj
  method ok_button = new GButton.button (FileSelection.get_ok_button obj)
  method cancel_button =
    new GButton.button (FileSelection.get_cancel_button obj)
  method help_button = new GButton.button (FileSelection.get_help_button obj)
  method file_list =
    ((new GList.clist (FileSelection.get_file_list obj)) : string GList.clist)
end

let file_selection ?(title="Choose a file") ?(show_fileops=false) =
  FileSelection.make_params [] ~show_fileops ~cont:(
  make_window ?title:None ~create:(fun pl ->
    let w = FileSelection.create title in
    Gobject.set_params w pl;
    new file_selection w))


(** FontSelectionDialog **)

class font_selection_dialog obj = object
  inherit [window] window_skel (obj : Gtk.font_selection_dialog obj)
  method connect = new container_signals obj
  method selection =
    new GMisc.font_selection (FontSelectionDialog.font_selection obj)
  method ok_button =  new GButton.button (FontSelectionDialog.ok_button obj)
  method apply_button =
    new GButton.button (FontSelectionDialog.apply_button obj)
  method cancel_button =
    new GButton.button (FontSelectionDialog.cancel_button obj)
end

let font_selection_dialog =
  make_window [] ~create:(fun pl ->
    new font_selection_dialog (FontSelectionDialog.create pl))


(** Plug **)

class plug (obj : Gtk.plug obj) = window (obj :> Gtk.window obj)

let plug ~window:xid =
  Container.make_params [] ~cont:(fun pl ?(show=false) () ->
    let w = Plug.create xid in
    Gobject.set_params w pl;
    if show then Widget.show w;
    new plug w)

(* $Id$ *)

open Gaux
open Gtk
open GtkBase
open GtkWindow
open GtkMisc
open GObj
open GContainer

let set = Gobject.Property.set
let get = Gobject.Property.get

(** Window **)

module P = Window.Prop

class ['a] window_skel obj = object
  constraint 'a = _ #window_skel
  inherit container obj
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
  method set_allow_shrink = set obj P.allow_shrink
  method set_allow_grow = set obj P.allow_grow
  method set_position = set obj P.window_position
  method set_resize_mode = Container.set_resize_mode obj
  method set_transient_for (w : 'a) =
    Window.set_transient_for obj w#as_window
  method set_title = Window.set_title obj
  method set_wm_name name = Window.set_wmclass obj ~name
  method set_wm_class cls = Window.set_wmclass obj ~clas:cls
  method set_resizable = set obj P.resizable
  method show () = Widget.show obj
  method present () = Window.present obj
end

class window obj = object
  inherit [window] window_skel (obj : Gtk.window obj)
  method connect = new container_signals obj
end

let setter ~create ~wrap =
  Window.setter ~cont:(fun f1 ->
    Container.setter ~cont:
      (fun f2 ?(show=false) () -> 
        let w = create () in f1 w; f2 w;
        if show then Widget.show w;
        wrap w))

let window ?kind:(t=`TOPLEVEL) =
  setter ~wrap:(new window) ~create:(fun () -> Window.create t)

let cast_window (w : #widget) =
  new window (GtkWindow.Window.cast w#as_widget)

let toplevel (w : #widget) =
  try Some (cast_window w#misc#toplevel) with Gobject.Cannot_cast _ -> None


(** Dialog **)

class ['a] dialog_signals obj tbl = object
  inherit container_signals (obj : Gtk.dialog obj)
  method response ~(callback : 'a -> unit) = 
    GtkSignal.connect ~sgn:Dialog.Signals.response obj ~after 
      ~callback:(fun i -> callback (List.assoc i !tbl))
  method close =
    GtkSignal.connect ~sgn:Dialog.Signals.close obj ~after
end

let rec list_rassoc k = function
  | (a, b) :: _ when b = k -> a
  | _ :: l -> list_rassoc k l
  | [] -> raise Not_found

let rnone = Dialog.std_response `NONE
let rdelete = Dialog.std_response `DELETE_EVENT

class ['a] dialog obj = object
  inherit [window] window_skel (obj : Gtk.dialog obj)
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
  method set_has_separator = set obj Dialog.Prop.has_separator
  method get_has_separator = get obj Dialog.Prop.has_separator
  method run () = 
    let resp = Dialog.run obj in
    List.assoc resp !tbl
end

let dialog_setter ~create ~wrap
    ?parent ?destroy_with_parent ?(no_separator=false) =
  setter ~wrap ~create:
    (fun () ->
      let w = create () in
      Gaux.may (fun p -> Window.set_transient_for w p#as_window) parent ;
      Gaux.may ~f:(set w P.destroy_with_parent) destroy_with_parent ;
      if no_separator then set w Dialog.Prop.has_separator false;
      w)

let dialog ?parent =
  dialog_setter ~create:Dialog.create ~wrap:(new dialog) ?parent


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
  initializer
    tbl := snd buttons @ !tbl
end

let message_dialog ?(message="") ~message_type ~buttons ?parent =
  dialog_setter ?parent:None ~wrap:(new message_dialog ~buttons) ~create:
    (fun () ->
      let parent =
        match parent with None -> None | Some x -> Some x#as_window in
      Dialog.create_message ?parent
        ~message_type ~buttons:(fst buttons) ~message ())


(** ColorSelectionDialog **)

class color_selection_dialog obj = object
  inherit [window] window_skel (obj : Gtk.color_selection_dialog obj)
  method connect = new container_signals obj
  method ok_button =
    new GButton.button (ColorSelection.ok_button obj)
  method cancel_button =
    new GButton.button (ColorSelection.cancel_button obj)
  method help_button =
    new GButton.button (ColorSelection.help_button obj)
  method colorsel =
    new GMisc.color_selection (ColorSelection.colorsel obj)
end

let color_selection_dialog ?(title="Pick a color") =
  setter ?title:None ~wrap:(new color_selection_dialog)
    ~create:(fun () -> ColorSelection.create_dialog title)


(** FileSelectionDialog **)

class file_selection obj = object
  inherit [window] window_skel (obj : Gtk.file_selection obj)
  method connect = new container_signals obj
  method set_filename = FileSelection.set_filename obj
  method get_filename = FileSelection.get_filename obj
  method complete = FileSelection.complete obj
  method set_fileop_buttons = FileSelection.set_fileop_buttons obj
  method set_select_multiple = FileSelection.set_select_multiple obj
  method select_multiple = FileSelection.get_select_multiple obj
  method get_selections = FileSelection.get_selections obj
  method ok_button = new GButton.button (FileSelection.get_ok_button obj)
  method cancel_button =
    new GButton.button (FileSelection.get_cancel_button obj)
  method help_button = new GButton.button (FileSelection.get_help_button obj)
  method file_list =
    ((new GList.clist (FileSelection.get_file_list obj)) : string GList.clist)
end

let file_selection ?(title="Choose a file") ?filename
    ?(fileop_buttons=false) ?select_multiple =
  setter ?title:None ~wrap:(new file_selection) ~create:
    (fun () ->
      let w = FileSelection.create title in
      FileSelection.set w ?filename ~fileop_buttons ?select_multiple;
      w)


(** FontSelectionDialog **)

class font_selection_dialog obj = object
  inherit [window] window_skel (obj : Gtk.font_selection_dialog obj)
  method connect = new container_signals obj
(*
  method font = FontSelectionDialog.get_font obj

  method font_name = FontSelectionDialog.get_font_name obj
  method set_font_name = FontSelectionDialog.set_font_name obj
  method preview_text = FontSelectionDialog.get_preview_text obj
  method set_preview_text = FontSelectionDialog.set_preview_text obj
  method set_filter = FontSelectionDialog.set_filter obj
*)
  method selection =
    new GMisc.font_selection (FontSelectionDialog.font_selection obj)
  method ok_button =  new GButton.button (FontSelectionDialog.ok_button obj)
  method apply_button =
    new GButton.button (FontSelectionDialog.apply_button obj)
  method cancel_button =
    new GButton.button (FontSelectionDialog.cancel_button obj)
end

let font_selection_dialog ?title =
  setter ?title:None ~wrap:(new font_selection_dialog)
    ~create:(FontSelectionDialog.create ?title)


(** Plug **)

class plug (obj : Gtk.plug obj) = window (obj :> Gtk.window obj)

let plug ~window:xid ?border_width ?width ?height ?(show=false) () =
  let w = Plug.create xid in
  Container.set w ?border_width ?width ?height;
  if show then Widget.show w;
  new plug w

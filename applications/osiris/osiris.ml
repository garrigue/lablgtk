(*****************************************************************************)
(*                                                                           *)
(* Osiris : OCaml Visual Components - Copyright (c)2002 Nicolas Cannasse     *)
(* LablGTK port by Jacques Garrigue (2003)                                   *)
(*                                                                           *)
(*****************************************************************************)

type handle = Gtk.widget Gobject.obj
type menuhandle = Gtk.menu Gobject.obj
type richcolor = Gdk.Color.t
type hres
type hresources

type richeffect =
    FE_AUTOCOLOR
  | FE_BOLD
  | FE_ITALIC
  | FE_STRIKEOUT
  | FE_UNDERLINE
  | FE_PROTECTED

type stringtype =
    ST_ALPHANUM
  | ST_SPACES
  | ST_OTHER

type show_window_state = Maximize | Minimize | Normal
type align = AlNone | AlLeft | AlRight | AlTop | AlBottom | AlClient | AlCenter
type border = BdNone | BdSingle | BdNormal

type question_result = QR_YES | QR_NO | QR_CANCEL

type sel = {
    mutable smin : int;
    mutable smax : int
}

type keys = {
    k_del : int;
    k_enter : int;
    k_esc : int;
    k_fun : int
}

type richformat = {
    rf_effects : richeffect list;
    rf_height : int option;
    rf_color : richcolor option;
    rf_fontface : string option;
}

type 'a tree = Empty | Tree of ('a * 'a tree list)

type event = (unit -> unit) -> unit
type event_bool = (unit -> bool) -> unit
type event_key = (int -> unit) -> unit

class type font =
  object
    method face : string -> unit
    method size : int -> unit
    method bold : bool -> unit
    method italic : bool -> unit
    method underline : bool -> unit
    (* color : GDI low-level *)
  end

class type mouse_events =
  object
    method on_click : event
    method on_dblclick : event
    method on_rdblclick : event
    method on_mdblclick : event
    method on_ldown : event
    method on_rdown : event
    method on_mdown : event
    method on_lup : event
    method on_rup : event
    method on_mup : event
    method on_mousemove : (int -> int -> unit) -> unit
  end

class type key_events =
  object    
    method on_key_down : event_key
    method on_key_up : event_key
  end

class type virtual component =
  object
    method handle : handle
    method parent : container option
    method visible : bool -> unit
    method is_visible : bool
    method enable : bool -> unit
    method is_enabled : bool
    method caption : string -> unit
    method get_caption : string
    method x : int -> unit
    method get_x : int
    method y : int -> unit
    method get_y : int
    method width : int -> unit
    method get_width : int
    method height : int -> unit
    method get_height : int
    method align : align -> unit
    method get_align : align
    method pos : int -> int -> int -> int -> unit
    method virtual update : unit
    method component : component
    method destroy : unit
    method is_destroyed : bool
    method font : font
    method focus : unit

    method set_custom : (unit -> unit) -> unit
    method call_custom : unit
  end
and
 virtual container =
  object
    inherit component

    method span : int -> unit
    method space : int -> unit
    method container : container
  end

class menu menu =
  object
    method handle : menuhandle = menu
    method destroy = GtkBase.Object.destroy menu
  end

(*
class type menuitem =
  object
    method caption : string -> unit
    method get_caption : string
    method parent : menu
    method enable : bool -> unit
    method is_enabled : bool
    method check : bool -> unit
    method is_checked : bool
    method break : bool -> unit
    method is_break : bool
    method submenu : menu option -> unit
    method get_submenu : menu option    
    method on_click : event
  end
*)

class type window =
  object
    inherit container
    inherit mouse_events
    inherit key_events

    method process : bool -> bool
    method update : unit
    method close : unit

    method state : show_window_state -> unit
    method get_state : show_window_state
    method on_top : bool -> unit

    method menu : menu  
    method on_closequery : event_bool
    method on_destroy : event
    method on_resize : event
    method on_move : event
  end

class type popupmenu =
  object
    inherit menu
    method popup : window -> int -> int -> unit
    method menu : menu
  end

class type panel =
  object
    inherit container
    inherit mouse_events
    inherit key_events

    method update : unit
    method clear : unit
    method border : border -> unit
    method get_border : border
  end

class type button =
  object
    inherit component
    inherit mouse_events

    method update : unit    
  end

class type genlist =
  object
    inherit component
    inherit mouse_events
    inherit key_events

    method listprint : (unit -> string list) -> unit

    method redraw : unit
    method update : unit

    method selected : int option
    method is_selected : int -> bool
    method set_selected : int option -> unit

    method on_selchange : event
    method genlist : genlist
  end

class type listbox =
  object
    inherit genlist
    method multiselect : bool -> unit
    method is_multiselect : bool
    method top_index : int
    method set_top_index : int -> unit
  end

class type combobox =
  object
    inherit genlist
  end

class type ['a] litems =
  object
    method redraw : unit
    method list : (unit -> 'a list) -> unit
    method print : ('a -> string) -> unit
    method equal : ('a -> 'a -> bool) -> unit
    method sort : ('a -> 'a -> int) option -> unit
    method curlist : 'a list
    method selection : 'a list
    method selected : 'a option
    method is_selected : 'a -> bool
    method set_selected : 'a option -> unit
    method set_selection : 'a list -> unit  
  end

class type virtual toggle =
  object
    inherit component
    inherit mouse_events

    method state : bool -> unit
    method get_state : bool
    method on_statechange : event
    method update : unit
    method toggle : toggle
  end

class type radiobutton =
  object
    inherit toggle
  end

class type checkbox =
  object
    inherit toggle
  end

class type label =
  object
    inherit component
    inherit mouse_events
    inherit key_events

    method update : unit
  end

class type edit =
  object
    inherit component
    inherit mouse_events
    inherit key_events

    method on_change : event
    method undo : unit  
    method update : unit
  end

class type richedit =
  object
    inherit component

    method update : unit
    
    method tabsize : int -> unit
    method wordwrap : bool -> unit
    method selection : sel -> unit
    method get_selection : sel
    method get_tabsize : int
    method get_wordwrap : bool

    method line_from_char : int -> int
    method char_from_line : int -> int
    method set_format : bool -> richformat -> unit
    method get_format : bool -> richformat
    method get_text : sel -> string

    method colorize : (stringtype -> string -> int -> richcolor option) -> sel option -> unit

    method on_change : event

    method undo : unit
    method redo : unit
  end


class type resources =
  object
    method add_source : string -> unit

    method add_icon : string -> hres
    method add_bitmap : string -> hres

    method handle : hresources
  end

class type treeview =
  object
    inherit component
    inherit mouse_events
    inherit key_events

    method update : unit
    method redraw : unit

    method treeprint : (unit -> (string*hres option) tree) -> unit

    method icons : resources option
    method set_icons : resources option -> unit
    method on_selchange : event

    method selected : int option
    method set_selected : int option -> unit
    method hittest : int -> int -> int option

  end

let bts x =
  let x = if x < 0 then 0 else if x > 255 then 255 else x in
  x * 257

let make_richcolor ~red ~green ~blue =
  let colormap = Gdk.Color.get_system_colormap () in
  Gdk.Color.alloc ~colormap (`RGB(bts red, bts green, bts blue))

open GdkKeysyms
let keys = {
    k_del = _Delete;
    k_enter = _Return;
    k_esc = _Escape;
    k_fun = _F1;
}

let no_event _ = ()
let no_event_2 _ _ = ()
let event_true _ = true
let event_false _ = false

open StdLabels
open GtkBase
open GtkButton
open GtkMain
open GtkMenu
open GtkMisc
open GtkWindow

type button_id = [`APPLY|`CANCEL|`CLOSE|`HELP|`NO|`OK|`YES]

let make_dialog ~title ~message ~buttons ?(no_delete=false) () = 
  let dia = Dialog.create () in
  Window.set_title dia title;
  let label = Label.create message in
  Label.set_line_wrap label true;
  Misc.set_padding label ~x:10 ~y:10 ();
  Container.add (Dialog.vbox dia) label;
  Widget.show label;
  List.iter buttons ~f:
    (fun (#button_id as id) ->
      Dialog.add_button dia
        (GtkStock.convert_id id) (Dialog.std_response id));
  begin match buttons with
    (#button_id as id) :: _ ->
      Dialog.set_default_response dia (Dialog.std_response id)
  | _ -> ()
  end;
  let rec check resp =
    if no_delete && resp = Dialog.std_response `DELETE_EVENT
    then check (Dialog.run dia)
    else resp
  in
  let r = check (Dialog.run dia) in
  Object.destroy dia;
  r

let message_box message =
  ignore (make_dialog ~title:"Message:" ~message ~buttons:[`OK] ())

let question_box message =
  let r =
    make_dialog ~title:"Message:" ~message ~buttons:[`YES;`NO]
      ~no_delete:true () in
  r = Dialog.std_response `YES

let question_cancel_box message =
  let r =
    make_dialog ~title:"Message:" ~message ~buttons:[`YES;`NO;`CANCEL] () in
  if r = GtkWindow.Dialog.std_response `YES then QR_YES else
  if r = GtkWindow.Dialog.std_response `NO then QR_NO else
  QR_CANCEL

let file_dialog ~title ?default () =
  let sel = FileSelection.create title in
  FileSelection.hide_fileop_buttons sel;
  Gaux.may default ~f:(FileSelection.set_filename sel);
  Window.set_modal sel true;
  let name = ref None in
  GtkSignal.connect sel ~sgn:Object.Signals.destroy ~callback:Main.quit;
  GtkSignal.connect (FileSelection.get_cancel_button sel)
    ~sgn:Button.Signals.clicked
    ~callback:(fun () -> Object.destroy sel);
  GtkSignal.connect (FileSelection.get_ok_button sel)
    ~sgn:Button.Signals.clicked
    ~callback:
    (fun () ->
      name := Some (FileSelection.get_filename sel); Object.destroy sel);
  Widget.show sel;
  Main.main ();
  !name

let open_file _ =
  file_dialog ~title:"Osiris Open Dialog" ()

let create_file ~default ~exts =
  file_dialog ~title:"Osiris Create Dialog" ~default ()

let select_directory ~title =
  file_dialog ~title ()

let mouse_pos () =
  Gdk.Window.get_pointer_location (Gdk.Window.root_parent ())

let exit_application = Main.quit

class menuitem parent item =
  object
    val item = item
    val mutable label = None
    val mutable enabled = true
    val mutable break = true
    val mutable submenu = None
    method caption s =
      break <- false;
      match label with
        Some l ->
          Label.set_text l s
      | None ->
          let l = Label.create s in
          label <- Some l;
          Widget.show l;
          Container.add item l
    method get_caption =
      match label with
        Some l -> Label.get_text l
      | None   -> ""
    method parent : menu = parent
    method enable b =
      Widget.set_sensitive item b;
      enabled <- b
    method is_enabled =
      enabled
    method check b =
      break <- false;
      CheckMenuItem.set_show_toggle item true;
      CheckMenuItem.set_active item b
    method is_checked =
      CheckMenuItem.get_active item
    method break b =
      break <- b;
      if b then begin
        CheckMenuItem.set_show_toggle item false;
        match label with None -> ()
        | Some l ->
            Container.remove item l;
            Object.destroy l;
            label <- None
      end
    method is_break = break
    method submenu opt =
      if submenu <> None then MenuItem.remove_submenu item;
      match opt with
        None -> ()
      | Some (sub : menu) ->
          break <- false;
          MenuItem.set_submenu item sub#handle;
          submenu <- Some sub
    method get_submenu = submenu
    method on_click : event = fun callback ->
      ignore (GtkSignal.connect item ~sgn:MenuItem.Signals.activate ~callback)
  end

let new_menuitem (menu : menu) =
  let item = CheckMenuItem.create () in
  CheckMenuItem.set_show_toggle item false;
  MenuShell.append menu#handle item;
  Widget.show item;
  new menuitem menu item

let new_menu () =
  let m = Menu.create () in
  Widget.show m;
  new menu m

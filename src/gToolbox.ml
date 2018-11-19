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

open StdLabels

(** Menus *)

type menu_entry =
  [ `I of string * (unit -> unit)
  | `C of string * bool * (bool -> unit)
  | `R of (string * bool * (bool -> unit)) list
  | `M of string * menu_entry list
  | `S ]

let rec build_menu menu ~(entries : menu_entry list) =
  let f = new GMenu.factory menu in
  List.iter entries ~f:
    begin function
    | `I (label, callback) ->
        ignore (f#add_item label ~callback)
    | `C (label, active, callback) ->
        ignore (f#add_check_item label ~callback ~active)
    | `R ((label, active, callback) :: l) ->
        let r = f#add_radio_item label ~active ~callback in
        let group = r#group in
        List.iter l ~f:
          (fun (label, active, callback) ->
            ignore (f#add_radio_item label ~active ~callback ~group))
    | `R [] ->
        ()
    | `M (label, entries) ->
        let m = f#add_submenu label in
        build_menu m ~entries
    | `S ->
        ignore (f#add_separator ())
    end

let popup_menu ~entries =
  let menu = GMenu.menu () in
  build_menu menu ~entries;
  fun ~button ~time -> 
    if entries = [] then 
      () 
    else 
      menu#popup ~button ~time

(** Dialogs *)

let mOk = "Ok"
let mCancel = "Cancel"

let question_box ?parent ~title  ~buttons ?(default=1) ?icon message =
  let button_nb = ref 0 in
  let destroy_with_parent = Gaux.may_map ~f:(fun _ -> true) parent in
  let window = GWindow.dialog ?parent ?destroy_with_parent ~modal:true ~title () in
  let hbox = GPack.hbox ~border_width:10 ~packing:window#vbox#add () in
  let bbox = window#action_area in
  begin match icon with
    None -> ()
  | Some i -> hbox#pack i#coerce ~padding:4
  end;
  ignore (GMisc.label ~text: message ~packing: hbox#add ());
  (* the function called to create each button by iterating *)
  let rec iter_buttons n = function
      [] ->
        ()
    | button_label :: q ->    
        let b = GButton.button ~label: button_label 
            ~packing:(bbox#pack ~expand:true ~padding:4) ()
        in
        b#connect#clicked ~callback:
          (fun () -> button_nb := n; window#destroy ());
        (* If it's the first button then give it the focus *)
        if n = default then b#grab_default () else ();

        iter_buttons (n+1) q
  in
  iter_buttons 1 buttons;
  window#connect#destroy ~callback: GMain.Main.quit;
  window#set_position `CENTER;
  window#show ();
  GMain.Main.main ();
  !button_nb


let message_box ?parent ~title ?icon ?(ok=mOk) message =
  ignore (question_box ?parent ?icon ~title message ~buttons:[ ok ])


let input_widget ?parent ~widget ~event ~get_text ~bind_ok ~expand
    ~title ?(ok=mOk) ?(cancel=mCancel) message =
  let retour = ref None in
  let destroy_with_parent = Gaux.may_map ~f:(fun _ -> true) parent in
  let window = GWindow.dialog ?parent ?destroy_with_parent ~title ~modal:true () in
  window#connect#destroy ~callback: GMain.Main.quit;
  let main_box = window#vbox in
  let hbox_boutons = window#action_area in

  let vbox_saisie = GPack.vbox ~packing: (main_box#pack ~expand: true) () in
  
  ignore (GMisc.label ~text:message ~packing:(vbox_saisie#pack ~padding:3) ());

  vbox_saisie#pack widget ~expand ~padding: 3;

  let wb_ok = GButton.button ~label: ok
      ~packing: (hbox_boutons#pack ~expand: true ~padding: 3) () in
  wb_ok#grab_default ();
  let wb_cancel = GButton.button ~label: cancel
      ~packing: (hbox_boutons#pack ~expand: true ~padding: 3) () in
  let f_ok () =
    retour := Some (get_text ()) ;
    window#destroy ()
  in
  let f_cancel () = 
    retour := None;
    window#destroy () 
  in
  wb_ok#connect#clicked f_ok;
  wb_cancel#connect#clicked f_cancel;

  (* the enter key is linked to the ok action *)
  (* the escape key is linked to the cancel action *)
  event#connect#key_press ~callback:
    begin fun ev -> 
      if GdkEvent.Key.keyval ev = GdkKeysyms._Return && bind_ok then f_ok ();
      if GdkEvent.Key.keyval ev = GdkKeysyms._Escape then f_cancel ();
      false
    end;

  widget#misc#grab_focus ();
  window#show ();
  GMain.Main.main ();

  !retour

let input_string ?parent ~title ?ok ?cancel ?(text="") message =
  let we_chaine = GEdit.entry ~text () in
  if text <> "" then
    we_chaine#select_region 0 (we_chaine#text_length);
  input_widget ?parent ~widget:we_chaine#coerce ~event:we_chaine#event
    ~get_text:(fun () -> we_chaine#text) ~bind_ok:true
    ~expand: false
    ~title ?ok ?cancel message


let input_text ?parent ~title ?ok ?cancel ?(text="") message =
  let wscroll = GBin.scrolled_window
      ~vpolicy: `AUTOMATIC
      ~hpolicy: `AUTOMATIC
      () 
  in
  let wview_chaine = GText.view ~editable: true ~packing: wscroll#add () in
  if text <> "" then begin
    wview_chaine#buffer#insert text;
    wview_chaine#buffer#move_mark 
      `SEL_BOUND
      ~where:wview_chaine#buffer#start_iter;
  end;
  input_widget ?parent ~widget:wscroll#coerce ~event:wview_chaine#event
    ~get_text: wview_chaine#buffer#get_text
    ~bind_ok:false ~expand: true ~title ?ok ?cancel message


(**This variable contains the last directory where the user selected a file.*)
let last_dir = ref ""

let select_file ~title ?(dir = last_dir) ?(filename="") () =
  let fs =
    if Filename.is_relative filename then begin
      if !dir <> "" then
        let filename = Filename.concat !dir filename in 
        GWindow.file_selection ~modal:true ~title ~filename ()
      else
        GWindow.file_selection ~modal:true ~title ()
    end else begin
      dir := Filename.dirname filename;
      GWindow.file_selection ~modal:true ~title ~filename ()
    end
  in
  fs#connect#destroy ~callback: GMain.Main.quit;
  let file = ref None in 
  fs#ok_button#connect#clicked ~callback:
    begin fun () ->
      file := Some fs#filename; 
      dir := Filename.dirname fs#filename;
      fs#destroy ()
    end;
  fs # cancel_button # connect#clicked ~callback:fs#destroy;
  fs # show ();
  GMain.Main.main ();
  !file


type 'a tree = [`L of 'a | `N of 'a * 'a tree list]


class ['a] tree_selection ~tree ~label ~info ?packing ?show () =
  let main_box = GPack.vbox ?packing ?show () in
  (* The scroll window used for the tree of the versions *)
  let wscroll_tree = GBin.scrolled_window ~packing: main_box#add () in
  (* The tree containing the versions *)
  let wtree = GBroken.tree
      ~packing:wscroll_tree#add_with_viewport () in
  (* the text widget used to display information on the selected node. *)
  let wview = GText.view ~editable: false ~packing: main_box#pack () in
  (* build the tree *)
  object
    inherit GObj.widget main_box#as_widget
    val mutable selection = None
    method selection = selection
    method clear_selection () = selection <- None
    method wtree = wtree
    method wview = wview

    initializer
      let rec insert_node wt (t : 'a tree) =
        let data, children =
          match t with `L d -> d, [] | `N(d,c) -> d, c in
        let item = GBroken.tree_item ~label: (label data) () in
        wt#insert item ~pos: 0;
        item#connect#select ~callback:
          begin fun () -> 
	    selection <- Some data;
	    wview#buffer#delete ~start: wview#buffer#start_iter ~stop:wview#buffer#end_iter ;
            wview#buffer#insert ~iter: wview#buffer#start_iter (info data);
	    ()
          end;
        item#connect#deselect ~callback:
          begin fun () ->
	    selection <- None;
	    wview#buffer#set_text "";
          end;
        match children with
          [] ->
            (* nothing more to do *)
            ()
        | l ->
            (* create a subtree and expand it *)
            let newtree = GBroken.tree () in
            item#set_subtree newtree;
            item#expand ();
            (* insert the children *)
            List.iter (insert_node newtree) (List.rev children)
      in
      insert_node wtree tree
  end

let tree_selection_dialog ?parent ~tree ~label ~info ~title
    ?(ok=mOk) ?(cancel=mCancel) ?(width=300) ?(height=400)
    ?show () =
  let destroy_with_parent = Gaux.may_map ~f:(fun _ -> true) parent in
  let window = GWindow.dialog ?parent ?destroy_with_parent ~modal:true ~title ~width ~height ?show () in
  (* the tree selection box *)
  let ts = new tree_selection ~tree ~label ~info
      ~packing:window#vbox#add () 
  in

  (* the box containing the ok and cancel buttons *)
  let hbox = window#action_area in

  let bOk = GButton.button ~label: ok
      ~packing:(hbox#pack ~padding:4 ~expand: true) ()
  in
  let bCancel = GButton.button ~label: cancel
      ~packing:(hbox#pack ~padding:4 ~expand: true) ()
  in
  bOk#connect#clicked ~callback:window#destroy;
  bCancel#connect#clicked
    ~callback:(fun _ -> ts#clear_selection () ; window#destroy ());
  window#connect#destroy ~callback: GMain.Main.quit;
  window#show ();
  GMain.Main.main () ;
  ts#selection


(** Misc *)

let autosize_clist wlist =
  (* get the number of columns *)
  let nb_columns = wlist#columns in
  (* get the columns titles *)
  let rec iter lacc i =
    if i >= nb_columns then
      lacc
    else
      let title = wlist#column_title i in
      iter (lacc@[("  "^title^"  ")]) (i+1)
  in
  let titles = iter [] 0 in
  (* insert a row with the titles *)
  wlist#insert ~row:0 titles;
  (* use to clist columns_autosize method *)
  wlist#columns_autosize ();
  (* remove the inserted row *)
  ignore (wlist#remove ~row: 0)


(** Shortcuts *)

type key_combination = [ `A | `C | `S ] list * char

type 'a shortcut_specification = {
  name : string;
  keys : key_combination list;
  message : 'a;
}

(* mk_keys turns keys from a key_combination into a format which can be used in
* a GTK+ RC file. *)
let mk_keys (mods, c) =
  let mods = List.map (function `A -> "<Alt>" | `C -> "<Control>" | `S ->
    "<Shift>") mods in
  (String.concat "" mods) ^ (String.make 1 (Char.uppercase_ascii c))

(* Signal creation for shortcuts unfortunately requires us to create an
 * in-memory gtkrc file which this function do. *)
let make_gtkrc_string g_type shortcuts =
  let sp = Printf.sprintf in
  let b = Buffer.create 4000 in
  Buffer.add_string b "binding \"Shortcuts\" {";
  StdLabels.List.iter shortcuts ~f:(fun t ->
    ListLabels.iter t.keys ~f:(fun keys ->
      let keys = mk_keys keys in
      Buffer.add_string b (sp "bind \"%s\" { \"%s\" () }" keys
      t.name)
    )
  );
  Buffer.add_string b "}";
  let classname = Gobject.Type.name g_type in
  Buffer.add_string b (sp "class \"%s\" binding \"Shortcuts\"" classname);
  Buffer.contents b

let create_shortcuts ~window:(win : #GWindow.window_skel) ~shortcuts ~callback =
  let win = win#as_window in
  let g_type = Gobject.get_type win in
  GtkMain.Rc.parse_string (make_gtkrc_string g_type shortcuts);
  ListLabels.iter shortcuts ~f:(fun t ->
    let sgn = { GtkSignal.name = t.name; classe = `window; marshaller =
      GtkSignal.marshal_unit } in
    GtkSignal.signal_new t.name g_type [ `ACTION; `RUN_FIRST ];
    ignore (GtkSignal.connect ~sgn ~callback:(fun () -> callback t.message) win)
  )


(* $Id$ *)

open Util
open Os
open Common
open Uicommon
open Printf
open Trace

(**********************************************************************)
(*                           GRAPHICAL INTERFACE                      *)
(**********************************************************************)

module Private : Uicommon.UI = struct

open GMain
open GdkKeysyms

let debugprogress = Trace.debug "progress"

(**********************************************************************)
(* UI preferences                                                     *)
(**********************************************************************)

let fontMonospaceMedium =
  if Sys.os_type = "Win32" then
    lazy (Gdk.Font.load "-*-Courier New-Medium-R-Normal--*-110-*-*-*-*-*-*")
  else
    lazy (Gdk.Font.load "-*-Clean-Medium-R-Normal--*-130-*-*-*-*-*-*")
let fontMonospaceBold =
  if Sys.os_type = "Win32" then
    lazy (Gdk.Font.load "-*-Courier New-Bold-R-Normal--*-110-*-*-*-*-*-*")
  else
    lazy (Gdk.Font.load "-*-Courier-Bold-R-Normal--*-120-*-*-*-*-*-*")

(**********************************************************************)
(* UI state variables                                                 *)
(**********************************************************************)

type stateItem = { ri : reconItem;
                   mutable bytesTransferred : int;
                   mutable whatHappened : unit confirmation option }
let theState = ref [||]

let current = ref None

let currentWindow = ref None
let grabFocus t =
  match !currentWindow with
    Some w -> t#set_transient_for w;
              w#misc#set_sensitive false
  | None   -> ()
let releaseFocus () =
  begin match !currentWindow with
    Some w -> w#misc#set_sensitive true
  | None   -> ()
  end

(**********************************************************************)
(*                         Lock management                            *)
(**********************************************************************)

let busy = ref false

let getLock f =
  if !busy then
    Trace.message "Synchronizer is busy, please wait..\n"
  else begin
    busy := true; f (); busy := false
  end

(**********************************************************************)
(* Some widgets							      *)
(**********************************************************************)

class scrolled_text ?editable ?word_wrap ?width ?height ?packing ?show
    () =
  let sw =
    GFrame.scrolled_window ?width ?height ?packing ~show:false
      ~hpolicy:`NEVER ~vpolicy:`AUTOMATIC ()
  in
  let text = GEdit.text ?editable ?word_wrap ~packing:sw#add () in
  object
    inherit GObj.widget_full sw#as_widget
    method text = text
    method insert ?(font=fontMonospaceMedium) s =
      text#freeze ();
      text#delete_text ~start:0 ~stop:text#length;
      text#insert ~font:(Lazy.force font) s;
      text#thaw ()
    method show () = sw#misc#show ()
    initializer
      if show <> Some false then sw#misc#show ()
  end

let gtk_sync () = while Glib.Main.iteration false do () done

(**********************************************************************)
(*                           YES OR NO FUNCTION                       *)
(**********************************************************************)
(* val yesOrNo : string -> string -> (unit -> unit) -> (unit -> unit) *)
(*                      -> unit                                       *)
(* Displays a window with two buttons : YES and NO                    *)
(* yesOrNo title message yesFunction noFunction open the title        *)
(* window in which is displayed message. yesFunction and noFunctions  *)
(* are the functions associated two the two buttons                   *)
(**********************************************************************)
let yesOrNo ~title ~message ~yes:yesFunction ~no:noFunction =
  let t = GWindow.dialog ~title ~wm_name:title ~modal:true ~position:`CENTER () in
  grabFocus t;
  let theLabel = GMisc.label ~text:message
      ~packing:(t#vbox#pack ~padding:4) () in
  let yes = GButton.button ~label:"Yes" ~packing:t#action_area#add ()
  and no = GButton.button ~label:"No" ~packing:t#action_area#add () in
  no#grab_default ();
  ignore
    (yes#connect#clicked ~callback:(fun () -> t#destroy (); yesFunction ()));
  ignore
    (no#connect#clicked  ~callback:(fun () -> t#destroy (); noFunction ()));
  t#show ();
  ignore (t#connect#destroy ~callback:Main.quit);
  Main.main ();
  releaseFocus ()

(**********************************************************************)
(*                         SAFE EXIT FUNCTION                         *)
(**********************************************************************)

(* Avoid recursive invocations of the function below
   (a window receives delete events even when it is not sensitive) *)
let inExit = ref false

let safeExit () =
  if not !inExit then begin
    inExit := true;
    if not !busy then exit 0 else
    yesOrNo ~title:"Premature exit"
      ~message:"Unison is working, exit anyway ?"
      ~yes:(fun () -> exit 0) ~no:(fun () -> ());
    inExit := false
  end

(**********************************************************************)
(* okBox: Display a message in a window and wait for the user         *)
(* to hit the "OK" button.                                            *)
(**********************************************************************)
let okBox ~title ~message =
  let t = GWindow.dialog ~title ~wm_name:title ~modal:true ~position:`CENTER () in
  grabFocus t;
  let theLabel = GMisc.label ~text:message
      ~packing:(t#vbox#pack ~padding:4) () in
  let ok = GButton.button ~label:"OK" ~packing:t#action_area#add () in
  ok#grab_default ();
  ignore (ok#connect#clicked ~callback:(fun () -> t#destroy()));
  t#show ();
  (* Do nothing until user destroys window *)
  ignore (t#connect#destroy ~callback:Main.quit);
  Main.main ();
  releaseFocus ()

(**********************************************************************)
(* warnBox: Display a warning message in a window and wait for the    *)
(* user to hit "OK" or "Exit".                                        *)
(**********************************************************************)
let warnBox ~title ~message =
  inExit := true;
  let t = GWindow.dialog ~title ~wm_name:title ~modal:true ~position:`CENTER () in
  grabFocus t;
  let theLabel =
    GMisc.label ~text:message
      ~packing:(t#vbox#pack ~padding:4) () in
  let ok = GButton.button ~label:"OK" ~packing:t#action_area#add () in
  ok#grab_default ();
  ignore (ok#connect#clicked ~callback:(fun () -> t#destroy()));
  let exi = GButton.button ~label:"Exit" ~packing:t#action_area#add () in
  ignore (exi#connect#clicked ~callback:(fun () -> exit 0));
  t#show ();
  (* Do nothing until user destroys window *)
  ignore (t#connect#destroy ~callback:Main.quit);
  Main.main ();
  releaseFocus ();
  inExit := false

(**********************************************************************)
(* Standard file dialog                                               *)
(**********************************************************************)
let file_dialog ~title ~callback ?filename () =
  let sel = GWindow.file_selection ~title ~modal:true ?filename () in
  grabFocus sel;
  ignore (sel#cancel_button#connect#clicked ~callback:sel#destroy);
  ignore (sel#ok_button#connect#clicked ~callback:
            (fun () ->
               let name = sel#get_filename in
               sel#destroy ();
               callback name));
  sel#show ();
  Main.main ();
  releaseFocus ()

(**********************************************************************)
(* The root selection dialog                                          *)
(**********************************************************************)
let rootSelect cont =
  let t = GWindow.dialog ~title:"Root selection" ~wm_name:"Root selection"
      ~modal:true ~allow_grow:true () in
  t#misc#grab_focus ();
  
  let makeGetRoot title =
    let fr =
      GBin.frame ~label:title ~border_width:2 ~packing:(t#vbox#add) () in

    let vb = GPack.vbox ~border_width:4 ~packing:fr#add () in
  
    let f = GPack.vbox ~packing:(vb#add) () in
    let f0 = GPack.hbox ~spacing:4 ~packing:f#add () in
    ignore (GMisc.label ~text:"Host:" ~packing:f0#pack ());
    let localB = GButton.radio_button ~packing:f0#pack
        ~label:"Local" () in
    let remoteB = GButton.radio_button ~group:localB#group
        ~packing:f0#pack ~label:"Remote" () in
    let hostE = GEdit.entry ~packing:f0#add () in
    let f1 = GPack.hbox ~spacing:4 ~packing:f#add () in
    ignore (GMisc.label ~text:"File:" ~packing:f1#pack ());
    let fileE = GEdit.entry ~packing:f1#add () in
    let browseCommand() =
      file_dialog ~title:"Select a local file"
        ~callback:(fun file -> fileE#set_text file) ~filename:fileE#text ()
    in
    let b = GButton.button ~label:"Browse"
        ~packing:f1#pack () in
    ignore (b#connect#clicked ~callback:browseCommand);
    let varLocalRemote = ref (`Local : [`Local|`Remote]) in
    let localState() =
      varLocalRemote := `Local;
      hostE#misc#set_sensitive false;
      b#misc#set_sensitive true
    in
    let remoteState() =
      varLocalRemote := `Remote;
      hostE#misc#set_sensitive true;
      b#misc#set_sensitive false
    in
    ignore (localB#connect#clicked ~callback:localState);
    ignore (remoteB#connect#clicked ~callback:remoteState);
    localState();
    let getRoot() =
      let filePart = fileE#text in
      let remoteHost = hostE#text in
      (* FIX: should do sanity checking here *)
      match !varLocalRemote with
        `Local -> filePart
      | `Remote -> "//"^remoteHost^"/"^filePart in
    getRoot
  in
  
  let getRoot1 = makeGetRoot "Root 1" in
  let getRoot2 = makeGetRoot "Root 2" in
  
  let f3 = t#action_area in
  let okCommand() =
    let root1 = getRoot1() in
    let root2 = getRoot2() in
    Prefs.setPref Uicommon.roots Prefs.TempSetting [root1;root2];
    t#destroy ();
    cont ()
  in
  let okButton = GButton.button ~label:"OK" ~packing:f3#add () in
  ignore (okButton#connect#clicked ~callback:okCommand);
  okButton#grab_default ();
  let cancelButton = GButton.button ~label:"Cancel" ~packing:f3#add () in
  ignore (cancelButton#connect#clicked ~callback:safeExit);
  
  (* The profile editing dialog has been installed into the Gtk
     main interaction loop; wait until it completes. *)
  t#show ();
  ignore (t#connect#destroy ~callback:Main.quit);
  Main.main ()

(**********************************************************************)
(* The root selection dialog                                          *)
(**********************************************************************)
let editProfile prof =
  (* FIX:
     Scan the profile (if it is defined)
     Extract the roots
     Modifications
     Save with new roots *)
  let t = GWindow.dialog ~title:"Edit profile" ~wm_name:"Edit profile"
      ~modal:true ~allow_grow:true () in
  t#misc#grab_focus ();
  
  let vb = GPack.vbox ~border_width:4 ~packing:t#vbox#add () in
  
  let makeGetRoot() =
    let f = GPack.vbox ~packing:(vb#pack ~expand:true ~padding:4) () in
    let f0 = GPack.hbox ~spacing:4 ~packing:f#add () in
    ignore (GMisc.label ~text:"Host:" ~packing:f0#pack ());
    let localB = GButton.radio_button ~packing:f0#pack ~label:"Local" () in
    let remoteB = GButton.radio_button ~group:localB#group
        ~packing:f0#pack ~label:"Remote" () in
    let hostE = GEdit.entry ~packing:f0#add () in
    let f1 = GPack.hbox ~spacing:4 ~packing:f#add () in
    ignore (GMisc.label ~text:"File:" ~packing:f1#pack ());
    let fileE = GEdit.entry ~packing:f1#add () in
    let browseCommand() =
      file_dialog ~title:"Select a local file"
        ~callback:(fun file -> fileE#set_text file) ()
    in
    let b = GButton.button ~label:"Browse" ~packing:f1#pack () in
    ignore (b#connect#clicked ~callback:browseCommand);
    let varLocalRemote = ref (`Local : [`Local|`Remote]) in
    let localState() =
      varLocalRemote := `Local;
      hostE#set_editable false;
      b#misc#set_state `NORMAL
    in
    let remoteState() =
      varLocalRemote := `Remote;
      hostE#set_editable true;
      b#misc#set_state `INSENSITIVE
    in
    ignore (localB#connect#clicked ~callback:localState);
    ignore (remoteB#connect#clicked ~callback:remoteState);
    localState();
    let getRoot() =
      let filePart = fileE#text in
      let remoteHost = hostE#text in
      (* FIX: should do sanity checking here *)
      match !varLocalRemote with
        `Local -> filePart
      | `Remote -> "//"^remoteHost^"/"^filePart in
    getRoot
  in
  
  
  ignore (GMisc.label ~text:"Root 1:" ~xalign:0.
            ~packing:(vb#pack ~expand:true ~padding:4) ());
  let getRoot1 = makeGetRoot() in
  
  ignore (GMisc.label ~text:"Root 2:" ~xalign:0.
            ~packing:(vb#pack ~expand:true ~padding:4) ());
  let getRoot2 = makeGetRoot() in
  
  let f3 = t#action_area in
  let okCommand() =
    let root1 = getRoot1() in
    let root2 = getRoot2() in
    Prefs.setPref Uicommon.roots Prefs.PermanentSetting [root1;root2];
    Globals.savePrefs();
    t#destroy () in
  let okButton = GButton.button ~label:"OK" ~packing:f3#add () in
  ignore (okButton#connect#clicked ~callback:okCommand);
  let cancelCommand() =
    t#destroy ()
  in
  let cancelButton = GButton.button ~label:"Cancel" ~packing:f3#add () in
  ignore (cancelButton#connect#clicked ~callback:cancelCommand);
  
  (* The profile editing dialog has been installed into the Gtk
     main interaction loop; wait until it completes. *)
  t#show ();
  ignore (t#connect#destroy ~callback:Main.quit);
  Main.main ()

(**********************************************************************)
(*                        Documentation window                        *)
(**********************************************************************)
let documentation sect =
  let title = "Documentation" in
  let t = GWindow.dialog ~title ~wm_name:title () in
  let t_dismiss =
    GButton.button ~label:"dismiss" ~packing:t#action_area#add () in
  t_dismiss#grab_default ();
  let dismiss () = t#destroy () in
  ignore (t_dismiss#connect#clicked ~callback:dismiss);
  ignore (t#connect#event#delete ~callback:(fun _ -> dismiss (); true));

  let (name, docstr) = List.assoc sect Strings.docs in
  let hb = GPack.hbox ~packing:(t#vbox#pack ~expand:false ~padding:2) () in
  let optionmenu =
    GMenu.option_menu ~packing:(hb#pack ~fill:false) () in

  let charW = Gdk.Font.char_width (Lazy.force fontMonospaceMedium) 'M' in
  let charH = 16 in
  let t_text =
    new scrolled_text ~editable:false
      ~width:(charW * 80) ~height:(charH * 20) ~packing:t#vbox#add ()
  in
  t_text#insert docstr;

  let sect_idx = ref 0 in
  let idx = ref 0 in
  let menu = GMenu.menu () in
  let addDocSection (shortname, (name, docstr)) =
    if shortname <> "" && name <> "" then begin
      if shortname = sect then sect_idx := !idx;
      incr idx;
      let item = GMenu.menu_item ~label:name ~packing:menu#append () in
      ignore
        (item#connect#activate ~callback:(fun () -> t_text#insert docstr))
    end
  in
  Safelist.iter addDocSection Strings.docs;
  optionmenu#set_menu menu;
  optionmenu#set_history !sect_idx;

  t#show ()

(**********************************************************************)
(* The profile selection dialog                                       *)
(**********************************************************************)
let profileSelect cont =
(* FIX:
  - Choix du profil par defaut
*)
  let profilesAndRoots =
    ref
      (Safelist.map
         (fun f ->
            let filename = fspath2string (Os.fileInUnisonDir f) in
            let roots =
              Safelist.map snd
                (Safelist.filter (fun (n, v) -> n = "root")
                   (Prefs.scanPreferencesFile filename))
            in
            (Filename.chop_suffix f ".prf", roots))
         (Files.ls (fspath2string Os.synchronizerFspath) "*.prf")) in

  (* The selected profile *)
  let selection = ref None in
  
  (* Build the dialog *)
  let t = GWindow.dialog ~title:"Profiles" ~wm_name:"Profiles" () in
  
  let okCommand() =
    match !selection with
      Some profile ->
        Globals.prefsFileName := profile ^ ".prf";
        currentWindow := None;
        t#destroy ();
        cont ()
    | _ ->
        ()
  in
  let okButton = GButton.button ~label:"OK" ~packing:t#action_area#add () in
  ignore (okButton#connect#clicked ~callback:okCommand);
  okButton#misc#set_sensitive false;
  okButton#grab_default ();
  let cancelCommand() = t#destroy (); Main.quit () in
  let cancelButton = GButton.button ~label:"Cancel"
      ~packing:t#action_area#add () in
  ignore (cancelButton#connect#clicked ~callback:cancelCommand);
  cancelButton#misc#set_can_default true;
  
  let vb = t#vbox in
  
  ignore (GMisc.label
            ~text:"Select an existing profile or create a new one"
            ~xpad:2 ~ypad:2 ~packing:vb#pack ());
  
  let sw =
    GBin.scrolled_window ~packing:vb#add ~height:100
      ~hpolicy:`AUTOMATIC ~vpolicy:`AUTOMATIC ()
  in
  let lst = GList.clist ~selection_mode:`BROWSE ~packing:(sw#add) () in
  let fillLst default =
    lst#freeze ();
    lst#clear ();
    let selRow = ref 0 in
    let i = ref 0 in (* FIX: Work around a lablgtk bug *)
    Safelist.iter
      (fun (profile, roots) ->
         ignore (lst#append [profile]);
         if profile = default then selRow := !i;
         lst#set_row_data !i (profile, roots);
         incr i)
      (List.sort (fun (p, _) (p', _) -> compare p p') !profilesAndRoots);
    let r = lst#rows in
    let p = if r < 2 then 0. else float !selRow /. float (r - 1) in
    lst#scroll_vertical `JUMP p;
    lst#thaw ()
  in
  let tbl =
    GPack.table ~rows:2 ~columns:2 ~packing:vb#pack ()
  in
  tbl#misc#set_sensitive false;
  ignore (GMisc.label ~text:"Root 1:" ~xpad:2
            ~packing:(tbl#attach ~left:0 ~top:0 ~expand:`NONE) ());
  ignore (GMisc.label ~text:"Root 2:" ~xpad:2
            ~packing:(tbl#attach ~left:0 ~top:1 ~expand:`NONE) ());
  let root1 =
    GEdit.entry ~packing:(tbl#attach ~left:1 ~top:0) ~editable:false () in
  let root2 =
    GEdit.entry ~packing:(tbl#attach ~left:1 ~top:1) ~editable:false () in
  root1#misc#set_can_focus false;
  root2#misc#set_can_focus false;
  let hb =
    GPack.hbox ~border_width:2 ~spacing:2 ~packing:(vb#pack ~expand:false) ()
  in
  let nw =
    GButton.button ~label:"Create new profile"
      ~packing:hb#pack () in
  ignore (nw#connect#clicked ~callback:(fun () ->
    let t =
      GWindow.dialog ~title:"New profile" ~wm_name:"New profile" ~modal:true ()
    in
    let vb = GPack.vbox ~border_width:4 ~packing:t#vbox#add () in
    let f = GPack.vbox ~packing:(vb#pack ~expand:true ~padding:4) () in
    let f0 = GPack.hbox ~spacing:4 ~packing:f#add () in
    ignore (GMisc.label ~text:"Profile name:"
              ~packing:f0#pack ());
    let prof = GEdit.entry ~packing:f0#add () in
    prof#misc#grab_focus ();

    let exit () = t#destroy (); Main.quit () in
    ignore (t#event#connect#delete ~callback:(fun _ -> exit (); true));

    let f3 = t#action_area in
    let okCommand () =
      let profile = prof#text in
      if profile <> "" then
        let file = profile ^ ".prf" in
        let fspath = Os.fileInUnisonDir file in
        let filename = fspath2string fspath in
        if Sys.file_exists filename then
          okBox (myName ^ " error")
            ("Profile \""
             ^ profile
             ^ "\" already exists!\nPlease select another name.")
        else
          (* Make an empty file *)
          let ch =
            open_out_gen
              [Open_wronly; Open_creat; Open_trunc] 0o600 filename in
          close_out ch;
          profilesAndRoots := (profile, [])::!profilesAndRoots;
          fillLst profile;
          exit ()
    in
    let okButton = GButton.button ~label:"OK" ~packing:f3#add () in
    ignore (okButton#connect#clicked ~callback:okCommand);
    okButton#grab_default ();
    let cancelButton = GButton.button ~label:"Cancel" ~packing:f3#add () in
    ignore (cancelButton#connect#clicked ~callback:exit);

    t#show ();
    grabFocus t;
    Main.main ();
    releaseFocus ()));
  let ed =
    GButton.button ~label:"Edit" (*~packing:(hb#pack ~expand:false)*) () in
  let sd =
    GButton.button ~label:"Set default" (*~packing:(hb#pack ~expand:false)*) ()
  in
  let hlp =
    GButton.button ~label:"Help"
      ~packing:(hb#pack ~expand:false ~from:`END) () in
  ignore (hlp#connect#clicked ~callback:(fun () -> documentation "tutorial"));

  ignore (lst#connect#unselect_row ~callback:(fun _ _ _ ->
    root1#set_text ""; root2#set_text "";
    selection := None;
    tbl#misc#set_sensitive false;
    okButton#misc#set_sensitive false;
    ed#misc#set_sensitive false;
    sd#misc#set_sensitive false));
  ignore (lst#connect#select_row ~callback:(fun i _ _ ->
    (* Inserting the first row trigger the signal, even before the row
       data is set. So, we need to catch the corresponding exception *)
    try
      let (profile, roots) = lst#get_row_data i in
      selection := Some profile;
      begin match roots with
        [r1; r2] -> root1#set_text r1; root2#set_text r2;
                    tbl#misc#set_sensitive true
      | _        -> root1#set_text ""; root2#set_text "";
                    tbl#misc#set_sensitive false
      end;
      okButton#misc#set_sensitive true;
      ed#misc#set_sensitive true;
      sd#misc#set_sensitive true
    with Gpointer.Null -> ()));
  ignore (lst#event#connect#button_press ~callback:(fun ev ->
    match GdkEvent.get_type ev with
      `TWO_BUTTON_PRESS ->
        okCommand ();
        true
    | _ ->
        false));
  fillLst "default";
  lst#misc#grab_focus ();
  currentWindow := Some (t :> GWindow.window);
  ignore (t#event#connect#delete ~callback:(fun _ -> Main.quit (); true));
  t#show ()

(**********************************************************************)
(* Function to display a message in a new window                      *)
(**********************************************************************)
let messageBox ~title ?(label = "Dismiss") ?(action = fun t -> t#destroy)
    ?(modal = false) message =
  let t = GWindow.dialog ~title ~wm_name:title ~modal ~position:`CENTER () in
  let t_dismiss = GButton.button ~label ~packing:t#action_area#add () in
  t_dismiss#grab_default ();
  ignore (t_dismiss#connect#clicked ~callback:(action t));
  let charW = Gdk.Font.char_width (Lazy.force fontMonospaceMedium) 'M' in
  let charH = 16 in
  let t_text =
    new scrolled_text ~editable:false
      ~width:(charW * 80) ~height:(charH * 20) ~packing:t#vbox#add ()
  in
  t_text#insert message;
  ignore (t#event#connect#delete ~callback:(fun _ -> action t (); true));
  t#show ();
  if modal then begin
    grabFocus t;
    Main.main ();
    releaseFocus ()
  end

(**********************************************************************)
(* Fatal error handling                                               *)
(**********************************************************************)
let fatalError =
  messageBox ~title:"Fatal Error" ~label:"Exit" ~modal:true
    ~action:(fun t () -> exit 1)


(**********************************************************************)
(*                      Toplevel window                               *)
(**********************************************************************)
let createToplevelWindow () =
  let toplevelWindow = GWindow.window ~wm_name:myName () in
  let toplevelVBox = GPack.vbox ~packing:toplevelWindow#add () in

  (**********************************************************************)
  (* Groups of same sensitivity                                         *)
  (**********************************************************************)
  let grAction = ref [] in
  let grDiff = ref [] in
  let grProceed = ref [] in
  let grRestart = ref [] in
  let grAdd gr w = gr := w#misc::!gr in
  let grSet gr st = List.iter (fun x -> x#set_sensitive st) !gr in

  (**********************************************************************)
  (* Create the menu bar                                                *)
  (**********************************************************************)
  let menuBar =
    GMenu.menu_bar ~border_width:2 ~packing:toplevelVBox#pack ()
  in
  let menus = new GMenu.factory ~accel_modi:[] menuBar in
  let accel_group = menus#accel_group in
  toplevelWindow#add_accel_group accel_group;
  let add_submenu ?(modi=[]) ~label () =
    new GMenu.factory ~accel_group ~accel_modi:modi (menus#add_submenu label)
  in
  
  (**********************************************************************)
  (* Create the menus                                                   *)
  (**********************************************************************)
  let fileMenu = add_submenu ~label:"Synchronization" ()
  and actionsMenu = add_submenu ~label:"Actions" ()
  and ignoreMenu = add_submenu ~modi:[`SHIFT] ~label:"Ignore" ()
  and helpMenu = add_submenu ~label:"Help" () in

  (**********************************************************************)
  (* Create the main window                                             *)
  (**********************************************************************)
  let mainWindow =
    let sw =
      GBin.scrolled_window ~packing:(toplevelVBox#add)
        ~height:(Prefs.readPref mainWindowHeight * 12)
        ~hpolicy:`AUTOMATIC ~vpolicy:`AUTOMATIC ()
    in
    GList.clist
      ~columns:5 ~titles_show:true ~selection_mode:`BROWSE ~packing:sw#add ()
  in
  mainWindow#misc#grab_focus ();
  (* FIX: roots2string should return a pair *)
  let s = roots2string () in
  Array.iteri
    (fun i data ->
       mainWindow#set_column
         ~title_active:false ~auto_resize:true ~title:data i)
    [| " " ^ String.sub s ~pos:0 ~len:12 ^ " "; "  Action  ";
       " " ^ String.sub s ~pos:15 ~len:12 ^ " "; "  Status  "; " Path" |];
  let status_width =
    let font = mainWindow#misc#style#font in
    4 + max (Gdk.Font.string_width font "working")
            (Gdk.Font.string_width font "skipped")
  in
  mainWindow#set_column ~justification:`CENTER 1;
  mainWindow#set_column
    ~justification:`CENTER ~auto_resize:false ~width:status_width 3;

  (**********************************************************************)
  (* Create the details window                                          *)
  (**********************************************************************)

  let charW = Gdk.Font.char_width (Lazy.force fontMonospaceMedium) 'M' in
  let charH = if Sys.os_type = "Win32" then 20 else 16 in

  let detailsWindow =
    let sw =
      GFrame.scrolled_window ~packing:(toplevelVBox#pack ~expand:false)
        ~hpolicy:`AUTOMATIC ~vpolicy:`AUTOMATIC ()
    in
    GEdit.text ~editable:false ~height:(3 * charH) ~width: (96 * charW)
      ~line_wrap:false ~packing:sw#add () in
  detailsWindow#misc#set_can_focus false;
  let style = detailsWindow#misc#style#copy in
  style#set_font (Lazy.force fontMonospaceMedium);
  detailsWindow#misc#set_style style;
  let updateButtons () =
    match !current with
      None ->
        grSet grAction false;
        grSet grDiff false
    | Some row ->
        let (activate1, activate2) =
          match !theState.(row).whatHappened, !theState.(row).ri.replicas with
            Some _, _                                    -> (false, false)
          | None,   Different((FILE,_, _),(FILE,_, _),_) -> (true, true)
          | None,   _                                    -> (true, false)
        in
        grSet grAction activate1;
        grSet grDiff activate2
  in

  let makeRowVisible row =
    if mainWindow#row_is_visible row <> `FULL then begin
      let adj = mainWindow#vadjustment in
      let current = adj#value
      and upper = adj#upper and lower = adj#lower in
      let v =
        float row /. float (mainWindow#rows + 1) *. (upper-.lower) +. lower
      in
      adj#set_value (min v (upper -. adj#page_size))
    end
  in

  let updateDetails () =
    detailsWindow#freeze ();
    detailsWindow#delete_text ~start:0 ~stop:detailsWindow#length;
    begin match !current with
      None ->
        ()
    | Some row ->
        makeRowVisible row;
        let details =
          match !theState.(row).whatHappened with
            None -> details2string !theState.(row).ri "  "
          | Some(Succeeded(_)) -> details2string !theState.(row).ri "  "
          | Some(Failed(s)) -> s in
        detailsWindow#insert (path2string !theState.(row).ri.path);
        detailsWindow#insert "\n";
        detailsWindow#insert details
    end;
    (* Display text *)
    detailsWindow#thaw ();
    updateButtons ()
  in

  (**********************************************************************)
  (*                       CREATE THE STATUS WINDOW                     *)
  (**********************************************************************)

  let statusWindow =
    GMisc.statusbar ~packing:toplevelVBox#pack () in
  let statusContext = statusWindow#new_context ~name:"status" in
  ignore (statusContext#push "");

  let displayStatus s1 s2 =
    Threads.do_on_main_thread (fun () ->
      (* Concatenate the new message *)
      let m =
        s1 ^ (String.make (max 2 (30 - String.length s1)) ' ') ^ s2 in
      statusContext#pop ();
      ignore (statusContext#push m);
      (* Force message to be displayed immediately *)
      gtk_sync ())
  in

  (* Tell the Trace module about the status printer *)
  Trace.statusPrinter := Some displayStatus;

  (**********************************************************************)
  (*            FUNCTIONS USED TO PRINT IN THE MAIN WINDOW              *)
  (**********************************************************************)

  let select i =
    let r = mainWindow#rows in
    let p = if r < 2 then 0. else (float i +. 0.5) /. float (r - 1) in
    mainWindow#scroll_vertical `JUMP (min p 1.)
  in

  ignore (mainWindow#connect#unselect_row ~callback:
      (fun ~row ~column ~event -> current := None; updateDetails ()));
  ignore (mainWindow#connect#select_row ~callback:
      (fun ~row ~column ~event -> current := Some row; updateDetails ()));

  let nextInteresting () =
    let l = Array.length !theState in
    let start = match !current with Some i -> i + 1 | None -> 0 in
    let rec loop i =
      if i < l then
        match !theState.(i).ri.replicas with
          Different (_, _, dir)
              when not (Prefs.readPref auto) || !dir = Conflict ->
            select i
        | _ ->
            loop (i + 1)
    in
    loop start
  in
  let selectSomethingIfPossible () =
    if !current=None then nextInteresting ()
  in

  let columnsOf i =
    let oldPath = if i = 0 then emptypath else !theState.(i-1).ri.path in
    let status =
      match !theState.(i).whatHappened with
        None -> "      "
      | Some conf ->
          match !theState.(i).ri.replicas with
            Different(_,_,{contents=Conflict}) | Problem _ ->
              "      "
          | _ ->
              match conf with
                Succeeded _ -> "done  "
              | Failed _    -> "failed"
    in
    let s = reconItem2string oldPath !theState.(i).ri status in
    (* FIX: This is ugly *)
    (String.sub s ~pos:0 ~len:8,
     String.sub s ~pos:9 ~len:5,
     String.sub s ~pos:15 ~len:8,
     String.sub s ~pos:25 ~len:6,
     String.sub s ~pos:32 ~len:(String.length s - 32))
  in

  let rightArrow =
    GDraw.pixmap_from_xpm_d ~window:toplevelWindow ~data:Pixmaps.copyAB () in
  let leftArrow =
    GDraw.pixmap_from_xpm_d ~window:toplevelWindow ~data:Pixmaps.copyBA () in
  let rightArrowBlack =
    GDraw.pixmap_from_xpm_d
      ~window:toplevelWindow ~data:Pixmaps.copyABblack () in
  let leftArrowBlack =
    GDraw.pixmap_from_xpm_d
      ~window:toplevelWindow ~data:Pixmaps.copyBAblack () in
  let ignoreAct =
    GDraw.pixmap_from_xpm_d ~window:toplevelWindow ~data:Pixmaps.ignore () in
  let doneIcon = 
    GDraw.pixmap_from_xpm_d ~window:toplevelWindow ~data:Pixmaps.success () in
  let failedIcon = 
    GDraw.pixmap_from_xpm_d ~window:toplevelWindow ~data:Pixmaps.failure () in

  let displayArrow i action =
    match action with
      "<-?->" -> mainWindow#set_cell ~pixmap:ignoreAct i 1
    | "---->" -> mainWindow#set_cell ~pixmap:rightArrow i 1
    | "<----" -> mainWindow#set_cell ~pixmap:leftArrow i 1
    | "error" -> mainWindow#set_cell ~pixmap:failedIcon i 1
    |    _    -> assert false
  in

  let displayStatusIcon i status =
    match status with
    | "failed" -> mainWindow#set_cell ~pixmap:failedIcon i 3
    | "done  " -> mainWindow#set_cell ~pixmap:doneIcon i 3
    | _        -> mainWindow#set_cell ~text:status i 3
  in

  let displayMain() =
    mainWindow#freeze ();
    mainWindow#clear ();
    for i = 0 to Array.length !theState - 1 do
      let (r1, action, r2, status, path) = columnsOf i in
      ignore (mainWindow#append [ r1; ""; r2; status; path ]);
      displayArrow i action
    done;
    selectSomethingIfPossible ();
    begin match !current with Some idx -> select idx | None -> () end;
    mainWindow#thaw ();
    updateDetails ()
  in

  let redisplay i =
    let (r1, action, r2, status, path) = columnsOf i in
    mainWindow#freeze ();
    mainWindow#set_cell ~text:r1     i 0;
    displayArrow i action;
    mainWindow#set_cell ~text:r2     i 2;
    displayStatusIcon i status;
    mainWindow#set_cell ~text:path   i 4;
    if status = " failed " then mainWindow#set_row ~foreground:(`NAME"red") i;
    mainWindow#thaw ();
    if !current = Some i then updateDetails ();
    updateButtons ()
  in

  let showProgress i bytes =
    !theState.(i).bytesTransferred <- !theState.(i).bytesTransferred + bytes;
    let b = !theState.(i).bytesTransferred in
    let len = Common.riLength !theState.(i).ri in
    let newstatus =
      if b=0 || len = 0 then "working "
      else if len = 0 then sprintf "%8d" b 
      else
        let percentage = (int_of_float ((float b) *. 100.0 /. (float len))) in
        if percentage > 100 then
          debugprogress (fun() -> errmsg "Progress amount miscalculated for %s\n"
                                    (path2string (!theState.(i).ri.path)));
        sprintf "  %3d%%  " (max 100 percentage) in
    Threads.do_on_main_thread (fun () ->
      mainWindow#set_cell ~text:newstatus i 3;
      gtk_sync ())
  in

  (* Install showProgress so that we get called back by low-level
     file transfer stuff *)
  Util.progressPrinter := Some(showProgress);

  (* Apply new ignore patterns to the current state, expecting that the
     number of reconitems will grow smaller. Adjust the display, being
     careful to keep the cursor as near as possible to its position
     before the new ignore patterns take effect. *)
  let ignoreAndRedisplay () =
    let lst = Array.to_list !theState in
    (* FIX: we should actually test whether any prefix is now ignored *)
    let keep sI = not (Pred.test Globals.ignore (path2string sI.ri.path)) in
    begin match !current with
      None ->
        theState := Array.of_list (Safelist.filter keep lst)
    | Some index ->
        let i = ref index in
        let l = ref [] in
        Array.iteri
          (fun j sI -> if keep sI then l := sI::!l
                       else if j < !i then decr i)
          !theState;
        current := if !l = [] then None else Some !i;
        theState := Array.of_list (Safelist.rev !l)
    end;
    displayMain();
  in
  
  (**********************************************************************)
  (*                         FUNCTION DETECT UPDATES                    *)
  (**********************************************************************)

  let detectUpdatesAndReconcile () =
    grSet grAction false;
    grSet grDiff false;
    grSet grProceed false;
    grSet grRestart false;

    let (r1,r2) = Globals.getReplicaRoots () in
    let t = Trace.startTimer "Checking for updates" in
    let findUpdates () =
      let updates = Update.findUpdates () in
      Trace.showTimer t;
      updates
    in
    let reconcile updates =
      let t = Trace.startTimer "Reconciling" in
      Recon.reconcileAll updates
    in
    let reconItemList = reconcile (findUpdates ()) in
    Trace.showTimer t;
    if reconItemList = [] then
      Trace.status "Everything is up to date"
    else
      Trace.status ("Check and/or adjust selected actions; "
                    ^ "then press Proceed");
    theState :=
      Array.of_list
         (Safelist.map
            (fun ri -> { ri = ri; bytesTransferred = 0; whatHappened = None })
            reconItemList);
    current := None;
    displayMain();
    grSet grProceed (Array.length !theState > 0);
    grSet grRestart true
  in

  (**********************************************************************)
  (* The ignore dialog                                                  *)
  (**********************************************************************)

  let ignoreDialog () =
    let t = GWindow.dialog ~title: "Ignore" ~wm_name: "Ignore" () in
    let hbox = GPack.hbox ~packing:t#vbox#add () in
    let sb = GRange.scrollbar `VERTICAL
        ~packing:(hbox#pack ~from:`END) () in
    let regExpWindow =
      GList.clist ~columns:1 ~titles_show:false ~packing:hbox#add
        ~vadjustment:sb#adjustment ~width:400 ~height:150 () in
    
    (* Local copy of the regular expressions; the global copy will
       not be changed until the Apply button is pressed *)
    let theRegexps = Pred.extern Globals.ignore in
    Safelist.iter (fun r -> ignore (regExpWindow#append [r])) theRegexps;
    let maybeGettingBigger = ref false in
    let maybeGettingSmaller = ref false in
    let selectedRow = ref None in
    ignore
      (regExpWindow#connect#select_row ~callback:
         (fun ~row ~column ~event -> selectedRow := Some row));
    ignore
      (regExpWindow#connect#unselect_row ~callback:
         (fun ~row ~column ~event -> selectedRow := None));
    
    (* Configure the add frame *)
    let hbox = GPack.hbox ~spacing:4 ~packing:t#vbox#pack () in
    ignore (GMisc.label ~text: "Regular expression:"
              ~packing:(hbox#pack ~padding:2) ());
    let entry = GEdit.entry ~packing:hbox#add () in
    let add () =
      let theRegExp = entry#text in
      if theRegExp<>"" then begin
        entry#set_text "";
        regExpWindow#unselect_all ();
        ignore (regExpWindow#append [theRegExp]);
        maybeGettingSmaller := true
      end
    in
    let addButton = GButton.button ~label:"Add"
        ~packing:hbox#pack () in
    ignore (addButton#connect#clicked ~callback:add);
    ignore (entry#connect#activate ~callback:add);
    entry#misc#grab_focus ();
    
    (* Configure the delete button *)
    let delete () =
      match !selectedRow with
        Some x ->
          (* After a deletion, updates must be detected again *)
          maybeGettingBigger := true;
          (* Delete xth regexp *)
          regExpWindow#unselect_all ();
          regExpWindow#remove ~row:x
      | None ->
          ()
    in
    let deleteButton = GButton.button ~label:"Delete"
        ~packing:hbox#pack () in
    ignore (deleteButton#connect#clicked ~callback:delete);
    
    ignore
      (regExpWindow#event#connect#after#key_press ~callback:
         begin fun ev ->
           let key = GdkEvent.Key.keyval ev in
           if key = _Up || key = _Down || key = _Prior || key = _Next ||
           key = _Page_Up || key = _Page_Down then begin
             regExpWindow#select (regExpWindow#focus_row) 0;
             true
           end else if key = _Delete then begin
             delete (); true
           end else
             false
         end);
    
    (* A function to refresh the state and ignore list *)
    let refresh () =
      let theRegexps = ref [] in
      for i = regExpWindow#rows - 1 downto 0 do
        theRegexps := regExpWindow#cell_text i 0 :: !theRegexps
      done;
      Pred.intern Globals.ignore (!theRegexps);
      if !maybeGettingBigger || !maybeGettingSmaller then begin
        Globals.savePrefs();
        Globals.propagatePrefs()
      end;
      if !maybeGettingBigger then detectUpdatesAndReconcile ()
      else if !maybeGettingSmaller then ignoreAndRedisplay();
      maybeGettingBigger := false;
      maybeGettingSmaller := false;
    in
    
    (* Install the main buttons *)
    let applyButton =
      GButton.button ~label:"Apply" ~packing:t#action_area#add () in
    ignore (applyButton#connect#clicked ~callback:refresh);
    let cancelButton =
      GButton.button ~label:"Cancel" ~packing:t#action_area#add () in
    ignore (cancelButton#connect#clicked ~callback:(t#destroy));
    let okButton =
      GButton.button ~label:"OK" ~packing:t#action_area#add () in
    ignore
      (okButton#connect#clicked
         ~callback:(fun () -> refresh (); t#destroy ()));
    ignore (t#connect#destroy ~callback:Main.quit);
    grabFocus t;
    t#show ();
    Main.main ();
    releaseFocus ()
  in

  (**********************************************************************)
  (* Add entries to the Help menu                                       *)
  (**********************************************************************)
  let addDocSection (shortname, (name, docstr)) =
    if shortname <> "" && name <> "" then
      ignore (helpMenu#add_item
		~callback:(fun () -> documentation shortname)
                name)
  in
  Safelist.iter addDocSection Strings.docs;

  (**********************************************************************)
  (* Add entries to the Ignore menu                                     *)
  (**********************************************************************)
  let addRegExpByPath pathfunc =
    match !current with
      Some i ->
        addIgnorePattern (pathfunc !theState.(i).ri.path);
        ignoreAndRedisplay ()
    | None ->
        ()
  in
  grAdd grAction
    (ignoreMenu#add_item ~key:_i
       ~callback:(fun () -> getLock (fun () -> addRegExpByPath ignorePath))
       "Ignore this file permanently");
  grAdd grAction
    (ignoreMenu#add_item ~key:_E
       ~callback:(fun () -> getLock (fun () -> addRegExpByPath ignoreExt))
       "Ignore files with this extension");
  grAdd grAction
    (ignoreMenu#add_item ~key:_N
       ~callback:(fun () -> getLock (fun () -> addRegExpByPath ignoreName))
       "Ignore files with this name");

(*
  grAdd grRestart
    (ignoreMenu#add_item ~callback:
       (fun () -> getLock ignoreDialog) "Edit ignore patterns");
*)

  (**********************************************************************)
  (*                       MAIN FUNCTION : SYNCHRONIZE                  *)
  (**********************************************************************)
  let synchronize () =
    if Array.length !theState = 0 then
      Trace.status "Nothing to synchronize"
    else begin
      grSet grAction false;
      grSet grDiff false;
      grSet grProceed false;
      grSet grRestart false;

      Trace.status "Propagating changes";
      let t = Trace.startTimer "Propagating changes" in
      let (start, wait) = Threads.thread_maker () in
      let background = let i = 55000 in `RGB (i, i, i) in
      let finish i =
        redisplay i;
        mainWindow#set_row ~background:`WHITE i;
        gtk_sync ()
      in
      for i = 0 to Array.length !theState - 1 do
        let theSI = !theState.(i) in
        assert (theSI.whatHappened = None);
        start
          (fun () ->
             Threads.do_on_main_thread (fun () ->
               mainWindow#set_row ~background i;
               makeRowVisible i);
             theSI.whatHappened <- Some (Transport.transportItem theSI.ri i);
             i)
          finish
      done;
      wait finish;
      
      Trace.showTimer t;
      Trace.status "Updating synchronizer state";
      let t = Trace.startTimer "Updating synchronizer state" in
      Update.commitUpdates();
      Trace.showTimer t;
      Trace.status "Synchronization complete";

      grSet grRestart true
    end
  in

  (**********************************************************************)
  (*                  CREATE THE ACTION BAR                             *)
  (**********************************************************************)
  let actionBar =
    GButton.toolbar
      ~orientation:`HORIZONTAL ~tooltips:true ~space_size:10
      ~packing:toplevelVBox#pack () in

  (**********************************************************************)
  (*         CREATE AND CONFIGURE THE QUIT BUTTON                       *)
  (**********************************************************************)
  actionBar#insert_space ();
  ignore (actionBar#insert_button ~text:"Quit" ~callback:safeExit ());

  (**********************************************************************)
  (*         CREATE AND CONFIGURE THE PROCEED BUTTON                    *)
  (**********************************************************************)
  actionBar#insert_space ();
  grAdd grProceed
    (actionBar#insert_button ~text:"Proceed"
       (* tooltip:"Proceed with displayed actions" *)
       ~callback:(fun () ->
                    getLock synchronize) ());

  (**********************************************************************)
  (*           CREATE AND CONFIGURE THE RESCAN BUTTON                   *)
  (**********************************************************************)
  let detectCmdName = "Restart" in
  let detectCmd () =
    getLock detectUpdatesAndReconcile;
    if Prefs.readPref batch then begin
      Prefs.setPref batch Prefs.TempSetting false; synchronize()
    end
  in
  actionBar#insert_space ();
  grAdd grRestart
    (actionBar#insert_button ~text:detectCmdName ~callback:detectCmd ());

  (**********************************************************************)
  (* Buttons for <--, -->, Skip                                         *)
  (**********************************************************************)
  let doAction f =
    match !current with
      Some i ->
        let theSI = !theState.(i) in
        begin match theSI.whatHappened, theSI.ri.replicas with
          None, Different(_, _, dir) ->
            f dir;
            redisplay i;
            nextInteresting ()
        | _ ->
            ()
        end
    | None ->
        ()
  in
  let leftAction     _ = doAction (fun dir -> dir := Replica2ToReplica1) in
  let rightAction    _ = doAction (fun dir -> dir := Replica1ToReplica2) in
  let questionAction _ = doAction (fun dir -> dir := Conflict) in

  (**********************************************************************)
  (*             CREATE AND CONFIGURE THE DIFF BUTTON and KEY           *)
  (**********************************************************************)
  let diffCmd () =
    match !current with
      Some i ->
        getLock (fun () ->
          showDiffs !theState.(i).ri
            (fun title text -> messageBox ~title text)
            Trace.status i)
    | None ->
        ()
  in

  actionBar#insert_space ();
  grAdd grAction
    (actionBar#insert_button
       ~icon:((GMisc.pixmap leftArrowBlack ())#coerce)
       ~callback:leftAction ());
  actionBar#insert_space ();
  grAdd grAction
    (actionBar#insert_button
       ~icon:((GMisc.pixmap rightArrowBlack ())#coerce)
       ~callback:rightAction ());
  actionBar#insert_space ();
  grAdd grAction
    (actionBar#insert_button ~text:"Skip" ~callback:questionAction ());
  actionBar#insert_space ();
  grAdd grDiff (actionBar#insert_button ~text:"Diff" ~callback:diffCmd ());

  (**********************************************************************)
  (* Configure keyboard commands                                        *)
  (**********************************************************************)
  ignore
    (mainWindow#event#connect#key_press ~callback:
       begin fun ev ->
         let key = GdkEvent.Key.keyval ev in
         if key = _Left then begin
           leftAction (); GtkSignal.stop_emit (); true
         end else if key = _Right then begin
           rightAction (); GtkSignal.stop_emit (); true
         end else
           false
       end);

  (**********************************************************************)
  (* Add entries to the Action menu                                     *)
  (**********************************************************************)
  let (root1,root2) = Globals.getReplicaRoots () in
  let loc1 = root2hostname root1 in
  let loc2 = root2hostname root2 in
  let descr =
    if loc1 = loc2 then "left to right" else
    Printf.sprintf "from %s to %s" loc1 loc2
  in
  let left =
    actionsMenu#add_item ~key:_greater ~callback:rightAction
      ("Propagate " ^ descr) in
  grAdd grAction left;
  left#add_accelerator ~group:accel_group ~modi:[`SHIFT] _greater;
  
  let descl =
    if loc1 = loc2 then "right to left" else
    Printf.sprintf "from %s to %s" loc2 loc1
  in
  let right =
    actionsMenu#add_item ~key:_less ~callback:leftAction
      ("Propagate " ^ descl) in
  grAdd grAction right;
  right#add_accelerator ~group:accel_group ~modi:[`SHIFT] _less;
 
  grAdd grAction
    (actionsMenu#add_item ~key:_slash ~callback:questionAction
       "Do not propagate changes");

  ignore (actionsMenu#add_separator ());
  grAdd grDiff (actionsMenu#add_item ~key:_d ~callback:diffCmd "Show diffs");

  (**********************************************************************)
  (* Add commands to the Synchronization menu                           *)
  (**********************************************************************)
  grAdd grProceed
    (fileMenu#add_item ~key:_g
       ~callback:(fun () ->
                    getLock synchronize)
       "Proceed");
  grAdd grRestart (fileMenu#add_item ~key:_r ~callback:detectCmd detectCmdName);
  grAdd grRestart
    (fileMenu#add_item ~key:_a
       ~callback:(fun () ->
                    getLock detectUpdatesAndReconcile; 
                    getLock synchronize)
       "Atomically detect updates and proceed");
  ignore (fileMenu#add_separator ());
  let cm =
    fileMenu#add_check_item ~active:(Prefs.readPref Transport.backups)
      ~callback:(fun b -> Prefs.setPref Transport.backups Prefs.TempSetting b)
      "Make backups"
  in
  cm#set_show_toggle true;
  grAdd grRestart cm;
  ignore (fileMenu#add_separator ());
  ignore (fileMenu#add_item ~key:_q ~callback:safeExit "Quit");

  grSet grAction false;
  grSet grDiff false;
  grSet grProceed false;
  grSet grRestart false;

  ignore (toplevelWindow#event#connect#delete ~callback:
            (fun _ -> safeExit (); true));
  toplevelWindow#show ();
  currentWindow := Some toplevelWindow;
  detectCmd ()

(**********************************************************************)
(* Starting up...                                                     *)
(**********************************************************************)
let start _ =
  begin try
    (* Initialize the library *)
    ignore (Main.init ());

    Util.warnPrinter := Some (warnBox "Warning");
    (* Ask the Remote module to call us back at regular intervals during
       long network operations. *)
    Threads.tickProc := Some gtk_sync;

    (**********************************************************************)
    (* Set things up to initialize the client/server connection and       *)
    (* detect updates after the ui is displayed.                          *)
    (* This makes a difference when the replicas are large and it takes   *)
    (* a lot of time to detect updates.                                   *)
    (**********************************************************************)
    let msg = ref None in
    Uicommon.uiInit
      profileSelect
      rootSelect
      (fun () ->
         let w =
           GWindow.window ~kind:`TOPLEVEL ~position:`CENTER
             ~wm_name:"Unison" ~border_width:16 () in
         ignore (GMisc.label ~text: "Contacting server..."
                   ~packing:(w#add) ());
         w#show ();
         ignore (w#event#connect#delete ~callback:(fun _ -> exit 0));
         msg := Some w)
      (fun () ->
         begin match !msg with
           None   -> ()
         | Some w -> w#destroy ()
         end;
         createToplevelWindow ());

    (**********************************************************************)
    (* Display the ui                                                     *)
    (**********************************************************************)
    ignore (Timeout.add 500 (fun _ -> true));
              (* Hack: this allows signals such as SIGINT to be
                 handled even when Gtk is waiting for events *)
    Main.main ()
  with exn ->
    fatalError (exn2string exn)
  end

end (* module Private *)

(**********************************************************************)
(*                               MODULE MAIN                          *)
(**********************************************************************)

module Body : Uicommon.UI = struct

let start = function
    Text -> Uitext.Body.start Text
  | Graphic -> Private.start Graphic

end (* module Body *)

(*
FIX:
- Édition (minimale) et création des profiles
- Profile par défaut
- Sanity checks pour "Root selection"
- Edition du filtrage
*)

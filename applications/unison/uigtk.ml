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
    lazy (Gdk.Font.load "-*-Courier-Medium-R-Normal--*-120-*-*-*-*-*-*")
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

let size_message s =
  let x = ref 0 in
  let max_x = ref 0 in
  let y = ref 0 in
  for i = 0 to String.length s do
    if String.get s i = '\n' then (y := !y + 1; x := 0)
    else (x := !x + 1; if !x > !max_x then max_x := !x)
  done;
  (!max_x,!y)

(**********************************************************************)
(* oneBox: Display a message in a window and wait for the user        *)
(* to hit the button.                                                 *)
(**********************************************************************)
let oneBox ~title ~message ~label =
  let t = GWindow.dialog ~title ~wm_name:title
      ~modal:true ~position:`CENTER () in
  grabFocus t;
  let h = GPack.hbox ~packing:(t#vbox#pack ~expand:false ~padding:20) () in
  ignore(GMisc.label ~justify:`LEFT ~text:message
           ~packing:(h#pack ~expand:false ~padding:20) ());
  let b = GButton.button ~label ~packing:t#action_area#add () in
  b#grab_default ();
  ignore (b#connect#clicked ~callback:(fun () -> t#destroy()));
  t#show ();
  (* Do nothing until user destroys window *)
  ignore (t#connect#destroy ~callback:Main.quit);
  Main.main ();
  releaseFocus ()

(**********************************************************************)
(* twoBox: Display a message in a window and wait for the user        *)
(* to hit one of two buttons.  Return true if the first button is     *)
(* chosen, false if the second button is chosen.                      *)
(**********************************************************************)
let twoBox ~title ~message ~alabel ~blabel =
  let result = ref false in
  let t = GWindow.dialog ~title ~wm_name:title ~modal:true
      ~position:`CENTER () in
  grabFocus t;
  let h = GPack.hbox ~packing:(t#vbox#pack ~expand:false ~padding:20) () in
  ignore(GMisc.label ~justify:`LEFT ~text:message
           ~packing:(h#pack ~expand:false ~padding:20) ());
(*
  ignore(GMisc.label ~text:message
           ~packing:(t#vbox#pack ~expand:false ~padding:4) ());
*)
  let yes = GButton.button ~label:alabel ~packing:t#action_area#add ()
  and no = GButton.button ~label:blabel ~packing:t#action_area#add () in
  yes#grab_default ();
  ignore (yes#connect#clicked
            ~callback:(fun () -> t#destroy (); result := true));
  ignore (no#connect#clicked
            ~callback:(fun () -> t#destroy (); result := false));
  t#show ();
  (* Do nothing until user destroys window *)
  ignore (t#connect#destroy ~callback:Main.quit);
  Main.main ();
  releaseFocus ();
  !result

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
    if twoBox ~title:"Premature exit"
        ~message:"Unison is working, exit anyway ?"
        ~alabel:"Yes" ~blabel:"No"
    then exit 0;
    inExit := false
  end

let okBox ~title ~message = oneBox ~title ~message ~label:"OK"

(**********************************************************************)
(* warnBox: Display a warning message in a window and wait for the    *)
(* user to hit "OK" or "Exit".                                        *)
(**********************************************************************)
let warnBox ~title ~message =
  inExit := true;
  let ok = twoBox ~title ~message ~alabel:"OK" ~blabel:"Exit" in
  if not(ok) then exit 0;
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
  ignore (sel#connect#destroy ~callback:Main.quit);
  Main.main ();
  releaseFocus ()
;;

(* Working on new startup sequence... *)
let fatalError ~message =
  oneBox ~title:(Printf.sprintf "%s: Fatal error" (String.capitalize myName))
    ~message ~label:"Quit";;
let waitWindow = ref None
let displayWaitMessage () =
  let w =
    GWindow.window ~kind:`TOPLEVEL ~position:`CENTER
      ~wm_name:"Unison" ~border_width:16 () in
  ignore (GMisc.label ~text: "Contacting server..."
            ~packing:(w#add) ());
  w#show ();
  waitWindow := Some w;
  ignore (w#connect#event#delete ~callback:(fun _ -> exit 0));
  ()
let tryAgainOrQuit ~message =
  twoBox ~title:"Error" ~message ~alabel:"Try again" ~blabel:"Quit";;
let getFirstRoot() =
  let t = GWindow.dialog ~title:"Root selection" ~wm_name:"Root selection"
      ~modal:true ~allow_grow:true () in
  t#misc#grab_focus ();
  
  let message =
    Printf.sprintf
      "Welcome to %s!

You can use %s to synchronize a local file with another local file,
or with a remote file.

Please enter the first (local) file that you want to synchronize."
      myName myName in

  let hb = GPack.hbox
      ~packing:(t#vbox#pack ~expand:false ~padding:15) () in
  ignore(GMisc.label ~text:message
           ~justify:`LEFT
           ~packing:(hb#pack ~expand:false ~padding:15) ());

  let f1 = GPack.hbox ~spacing:4
      ~packing:(t#vbox#pack ~padding:4) () in
  ignore (GMisc.label ~text:"File:" ~packing:(f1#pack ~expand:false) ());
  let fileE = GEdit.entry ~packing:f1#add () in
  fileE#misc#grab_focus ();
  let browseCommand() =
    file_dialog ~title:"Select a local file"
      ~callback:fileE#set_text ~filename:fileE#text () in
  let b = GButton.button ~label:"Browse"
      ~packing:(f1#pack ~expand:false) () in
  ignore (b#connect#clicked ~callback:browseCommand);
  
  let f3 = t#action_area in
  let result = ref None in
  let contCommand() =
    result := Some(fileE#text);
    t#destroy () in
  let contButton = GButton.button ~label:"Continue" ~packing:f3#add () in
  ignore (contButton#connect#clicked ~callback:contCommand);
  ignore (fileE#connect#activate ~callback:contCommand);
  contButton#grab_default ();
  let quitButton = GButton.button ~label:"Quit" ~packing:f3#add () in
  ignore (quitButton#connect#clicked
            ~callback:(fun () -> result := None; t#destroy()));
  t#show ();
  ignore (t#connect#destroy ~callback:Main.quit);
  Main.main ();
  match !result with None -> None
  | Some file -> 
      Some(Uri.clroot2string(Uri.ConnectLocal(Some file)))

let getSecondRoot () =
  let t = GWindow.dialog ~title:"Root selection" ~wm_name:"Root selection"
      ~modal:true ~allow_grow:true () in
  t#misc#grab_focus ();
  
  let message =
    "Please enter the second file or directory you want to synchronize." in

  let helpmessage =
    Printf.sprintf
"%s can synchronize a local file with another local file, or with
a file on a remote machine.

To synchronize with a local file, just enter the file name.

To synchronize with a remote file, you must first choose a protocol
that %s will use to connect to the remote machine.  Each protocol has
different requirements:

1) To synchronize using SSH, there must be an SSH client installed on
this machine and an SSH server installed on the remote machine.  You
must enter the host to connect to, a user name (if different from
your user name on this machine), and the file on the remote machine
(relative to your home directory on that machine).

2) To synchronize using RSH, there must be an RSH client installed on
this machine and an RSH server installed on the remote machine.  You
must enter the host to connect to, a user name (if different from
your user name on this machine), and the file on the remote machine
(relative to your home directory on that machine).

3) To synchronize using %s's socket protocol, there must be a %s
server running on the remote machine, listening to the port that you
specify here.  (Use \"%s -socket xxx\" on the remote machine to
start the %s server.)  You must enter the host, port, and the file
on the remote machine (relative to the working directory of the
%s server running on that machine)."
    myName myName myName myName myName myName myName in

  let vb = t#vbox in
  let hb = GPack.hbox ~packing:(vb#pack ~expand:false ~padding:15) () in
  ignore(GMisc.label ~text:message
           ~justify:`LEFT
           ~packing:(hb#pack ~expand:false ~padding:15) ());
  let helpB = GButton.button ~label:"Help" ~packing:hb#add () in
  ignore (helpB#connect#clicked
            ~callback:(fun () -> okBox ~title:"Picking roots"
                ~message:helpmessage));

  let result = ref None in

  let f = GPack.vbox ~packing:(vb#pack ~expand:false) () in

  let f1 = GPack.hbox ~spacing:4 ~packing:f#add () in
  ignore (GMisc.label ~text:"File:" ~packing:(f1#pack ~expand:false) ());
  let fileE = GEdit.entry ~packing:f1#add () in
  fileE#misc#grab_focus ();
  let browseCommand() =
    file_dialog ~title:"Select a local file"
      ~callback:fileE#set_text ~filename:fileE#text () in
  let b = GButton.button ~label:"Browse"
      ~packing:(f1#pack ~expand:false) () in
  ignore (b#connect#clicked ~callback:browseCommand);

  let f0 = GPack.hbox ~spacing:4 ~packing:f#add () in
  let localB = GButton.radio_button ~packing:(f0#pack ~expand:false)
      ~label:"Local" () in
  let sshB = GButton.radio_button ~group:localB#group
      ~packing:(f0#pack ~expand:false)
      ~label:"SSH" () in
  let rshB = GButton.radio_button ~group:localB#group
      ~packing:(f0#pack ~expand:false) ~label:"RSH" () in
  let socketB = GButton.radio_button ~group:sshB#group
      ~packing:(f0#pack ~expand:false) ~label:"Socket" () in

  let f2 = GPack.hbox ~spacing:4 ~packing:f#add () in
  ignore (GMisc.label ~text:"Host:" ~packing:(f2#pack ~expand:false) ());
  let hostE = GEdit.entry ~packing:f2#add () in

  ignore (GMisc.label ~text:"(Optional) User:"
            ~packing:(f2#pack ~expand:false) ());
  let userE = GEdit.entry ~packing:f2#add () in

  ignore (GMisc.label ~text:"Port:"
            ~packing:(f2#pack ~expand:false) ());
  let portE = GEdit.entry ~packing:f2#add () in

  let varLocalRemote = ref (`Local : [`Local|`SSH|`RSH|`SOCKET]) in
  let localState() =
    varLocalRemote := `Local;
    hostE#misc#set_sensitive false;
    userE#misc#set_sensitive false;
    portE#misc#set_sensitive false;
    b#misc#set_sensitive true in
  let remoteState() =
    hostE#misc#set_sensitive true;
    b#misc#set_sensitive false;
    match !varLocalRemote with
      `SOCKET ->
        (portE#misc#set_sensitive true; userE#misc#set_sensitive false)
    | _ ->
        (portE#misc#set_sensitive false; userE#misc#set_sensitive true) in
  let protoState x =
    varLocalRemote := x;
    remoteState() in
  ignore (localB#connect#clicked ~callback:localState);
  ignore (sshB#connect#clicked ~callback:(fun () -> protoState(`SSH)));
  ignore (rshB#connect#clicked ~callback:(fun () -> protoState(`RSH)));
  ignore (socketB#connect#clicked ~callback:(fun () -> protoState(`SOCKET)));
  localState();
  let getRoot() =
    let file = fileE#text in
    let user = userE#text in
    let host = hostE#text in
    match !varLocalRemote with
      `Local -> 
        Uri.clroot2string(Uri.ConnectLocal(Some file))
    | `SSH | `RSH ->
        let portOpt =
          (* FIX: report an error if the port entry is not well formed *)
          try Some(int_of_string(portE#text))
          with _ -> None in
        Uri.clroot2string(
        Uri.ConnectByShell((if !varLocalRemote=`SSH then "ssh" else "rsh"),
                           host,
                           (if user="" then None else Some user),
                           portOpt,
                           Some file))
    | `SOCKET ->
        Uri.clroot2string(
        (* FIX: report an error if the port entry is not well formed *)
        Uri.ConnectBySocket(host,
                            int_of_string(portE#text),
                            Some file)) in
  let contCommand() =
    try
      let root = getRoot() in
      result := Some root;
      t#destroy ()
    with Failure "int_of_string" ->
      if portE#text="" then
        okBox ~title:"Error" ~message:"Please enter a port"
      else okBox ~title:"Error"
          ~message:"The port you specify must be an integer"
    | _ ->
        okBox ~title:"Error"
          ~message:"Something's wrong with the values you entered, try again" in
  let f3 = t#action_area in
  let contButton = GButton.button ~label:"Continue" ~packing:f3#add () in
  ignore (contButton#connect#clicked ~callback:contCommand);
  contButton#grab_default ();
  ignore (fileE#connect#activate ~callback:contCommand);
  let quitButton = GButton.button ~label:"Quit" ~packing:f3#add () in
  ignore (quitButton#connect#clicked ~callback:safeExit);

  t#show ();
  ignore (t#connect#destroy ~callback:Main.quit);
  Main.main ();
  !result
;;
let getProfile () =
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
  let result = ref None in
  
  (* Build the dialog *)
  let t = GWindow.dialog ~title:"Profiles" ~wm_name:"Profiles" () in
  
  let okCommand() =
    currentWindow := None;
    t#destroy () in
  let okButton = GButton.button ~label:"OK" ~packing:t#action_area#add () in
  ignore (okButton#connect#clicked ~callback:okCommand);
  okButton#misc#set_sensitive false;
  okButton#grab_default ();
  let cancelCommand() = t#destroy (); exit 0 in
  let cancelButton = GButton.button ~label:"Cancel"
      ~packing:t#action_area#add () in
  ignore (cancelButton#connect#clicked ~callback:cancelCommand);
  cancelButton#misc#set_can_default true;
  
  let vb = t#vbox in
  
  ignore (GMisc.label
            ~text:"Select an existing profile or create a new one"
            ~xpad:2 ~ypad:2 ~packing:(vb#pack ~expand:false) ());
  
  let sw =
    GFrame.scrolled_window ~packing:(vb#add) ~height:100
      ~hpolicy:`AUTOMATIC ~vpolicy:`AUTOMATIC () in
  let lst = GList.clist ~selection_mode:`BROWSE ~packing:(sw#add) () in
  let selRow = ref 0 in
  let fillLst default =
    lst#freeze ();
    lst#clear ();
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
    lst#thaw () in
  let tbl =
    GPack.table ~rows:2 ~columns:2 ~packing:(vb#pack ~expand:false) () in
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
      ~packing:(hb#pack ~expand:false) () in
  ignore (nw#connect#clicked ~callback:(fun () ->
    let t =
      GWindow.dialog ~title:"New profile" ~wm_name:"New profile" ~modal:true ()
    in
    let vb = GPack.vbox ~border_width:4 ~packing:t#vbox#add () in
    let f = GPack.vbox ~packing:(vb#pack ~padding:4) () in
    let f0 = GPack.hbox ~spacing:4 ~packing:f#add () in
    ignore (GMisc.label ~text:"Profile name:"
              ~packing:(f0#pack ~expand:false) ());
    let prof = GEdit.entry ~packing:f0#add () in
    prof#misc#grab_focus ();

    let exit () = t#destroy (); Main.quit () in
    ignore (t#connect#event#delete ~callback:(fun _ -> exit (); true));

    let f3 = t#action_area in
    let okCommand () =
      let profile = prof#text in
      if profile <> "" then
        let file = profile ^ ".prf" in
        let fspath = Os.fileInUnisonDir file in
        let filename = fspath2string fspath in
        if Sys.file_exists filename then
          okBox
            ~title:(myName ^ " error")
            ~message:("Profile \""
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
          exit () in
    let okButton = GButton.button ~label:"OK" ~packing:f3#add () in
    ignore (okButton#connect#clicked ~callback:okCommand);
    okButton#grab_default ();
    let cancelButton = GButton.button ~label:"Cancel" ~packing:f3#add () in
    ignore (cancelButton#connect#clicked ~callback:exit);

    t#show ();
    grabFocus t;
    Main.main ();
    releaseFocus ()));

  ignore (lst#connect#unselect_row ~callback:(fun _ _ _ ->
    root1#set_text ""; root2#set_text "";
    result := None;
    tbl#misc#set_sensitive false;
    okButton#misc#set_sensitive false));

  let select_row i =
    (* Inserting the first row triggers the signal, even before the row
       data is set. So, we need to catch the corresponding exception *)
    (try
      let (profile, roots) = lst#get_row_data i in
      result := Some profile;
      begin match roots with
        [r1; r2] -> root1#set_text r1; root2#set_text r2;
                    tbl#misc#set_sensitive true
      | _        -> root1#set_text ""; root2#set_text "";
                    tbl#misc#set_sensitive false
      end;
      okButton#misc#set_sensitive true
    with Misc.Null_pointer -> ()) in

  ignore (lst#connect#select_row ~callback:(fun i _ _ -> select_row i));

  ignore (lst#connect#event#button_press ~callback:(fun ev ->
    match GdkEvent.get_type ev with
      `TWO_BUTTON_PRESS ->
        okCommand ();
        true
    | _ ->
        false));
  fillLst "default";
  select_row !selRow;
  lst#misc#grab_focus ();
  currentWindow := Some (t :> GWindow.window);
  ignore (t#connect#destroy ~callback:Main.quit);
  t#show ();
  Main.main ();
  !result

(**********************************************************************)
(* The root selection dialog                                          *)
(**********************************************************************)
let rootSelect cont =
  let t = GWindow.dialog ~title:"Root selection" ~wm_name:"Root selection"
      ~modal:true ~allow_grow:true () in
  t#misc#grab_focus ();
  
  let makeGetRoot title =
    let fr =
      GFrame.frame ~label:title ~border_width:2 ~packing:(t#vbox#add) () in

    let vb = GPack.vbox ~border_width:4 ~packing:fr#add () in
  
    let f = GPack.vbox ~packing:(vb#add) () in
    let f0 = GPack.hbox ~spacing:4 ~packing:f#add () in
    let localB = GButton.radio_button ~packing:(f0#pack ~expand:false)
        ~label:"Local" () in
    let remoteB = GButton.radio_button ~group:localB#group
        ~packing:(f0#pack ~expand:false) ~label:"Remote" () in
    ignore (GMisc.label ~text:"Host:" ~packing:(f0#pack ~expand:false) ());
    let hostE = GEdit.entry ~packing:f0#add () in
    let f1 = GPack.hbox ~spacing:4 ~packing:f#add () in
    ignore (GMisc.label ~text:"File:" ~packing:(f1#pack ~expand:false) ());
    let fileE = GEdit.entry ~packing:f1#add () in
    let browseCommand() =
      file_dialog ~title:"Select a local file"
        ~callback:fileE#set_text ~filename:fileE#text ()
    in
    let b = GButton.button ~label:"Browse"
        ~packing:(f1#pack ~expand:false) () in
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
(* The profile editing dialog                                         *)
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
    let f = GPack.vbox ~packing:(vb#pack ~padding:4) () in
    let f0 = GPack.hbox ~spacing:4 ~packing:f#add () in
    ignore (GMisc.label ~text:"Host:" ~packing:(f0#pack ~expand:false) ());
    let localB = GButton.radio_button ~packing:(f0#pack ~expand:false)
        ~label:"Local" () in
    let remoteB = GButton.radio_button ~group:localB#group
        ~packing:(f0#pack ~expand:false) ~label:"Remote" () in
    let hostE = GEdit.entry ~packing:f0#add () in
    let f1 = GPack.hbox ~spacing:4 ~packing:f#add () in
    ignore (GMisc.label ~text:"File:" ~packing:(f1#pack ~expand:false) ());
    let fileE = GEdit.entry ~packing:f1#add () in
    let browseCommand() =
      file_dialog ~title:"Select a local file"
        ~callback:(fun file -> fileE#set_text file) ()
    in
    let b = GButton.button ~label:"Browse"
        ~packing:(f1#pack ~expand:false) () in
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
            ~packing:(vb#pack ~padding:4) ());
  let getRoot1 = makeGetRoot() in
  
  ignore (GMisc.label ~text:"Root 2:" ~xalign:0.
            ~packing:(vb#pack ~padding:4) ());
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
    | _ -> () in
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
            ~xpad:2 ~ypad:2 ~packing:(vb#pack ~expand:false) ());
  
  let sw =
    GFrame.scrolled_window ~packing:(vb#add) ~height:100
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
    lst#thaw () in
  let tbl =
    GPack.table ~rows:2 ~columns:2 ~packing:(vb#pack ~expand:false) () in
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
      ~packing:(hb#pack ~expand:false) () in
  ignore (nw#connect#clicked ~callback:(fun () ->
    let t =
      GWindow.dialog ~title:"New profile" ~wm_name:"New profile" ~modal:true ()
    in
    let vb = GPack.vbox ~border_width:4 ~packing:t#vbox#add () in
    let f = GPack.vbox ~packing:(vb#pack ~padding:4) () in
    let f0 = GPack.hbox ~spacing:4 ~packing:f#add () in
    ignore (GMisc.label ~text:"Profile name:"
              ~packing:(f0#pack ~expand:false) ());
    let prof = GEdit.entry ~packing:f0#add () in
    prof#misc#grab_focus ();

    let exit () = t#destroy (); Main.quit () in
    ignore (t#connect#event#delete ~callback:(fun _ -> exit (); true));

    let f3 = t#action_area in
    let okCommand () =
      let profile = prof#text in
      if profile <> "" then
        let file = profile ^ ".prf" in
        let fspath = Os.fileInUnisonDir file in
        let filename = fspath2string fspath in
        if Sys.file_exists filename then
          okBox
            ~title:(myName ^ " error")
            ~message:("Profile \""
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
    with Misc.Null_pointer -> ()));
  ignore (lst#connect#event#button_press ~callback:(fun ev ->
    match GdkEvent.get_type ev with
      `TWO_BUTTON_PRESS ->
        okCommand ();
        true
    | _ ->
        false));
  fillLst "default";
  lst#misc#grab_focus ();
  currentWindow := Some (t :> GWindow.window);
  ignore (t#connect#event#delete ~callback:(fun _ -> Main.quit (); true));
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
  ignore (t#connect#event#delete ~callback:(fun _ -> action t (); true));
  t#show ();
  if modal then begin
    grabFocus t;
    Main.main ();
    releaseFocus ()
  end

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
    GMenu.menu_bar ~border_width:2
      ~packing:(toplevelVBox#pack ~expand:false) () in
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
  and sortMenu = add_submenu ~label:"Sort" ()
  and helpMenu = add_submenu ~label:"Help" () in

  (**********************************************************************)
  (* Create the main window                                             *)
  (**********************************************************************)
  let mainWindow =
    let sw =
      GFrame.scrolled_window ~packing:(toplevelVBox#add)
        ~height:(Prefs.readPref mainWindowHeight * 12)
        ~hpolicy:`AUTOMATIC ~vpolicy:`AUTOMATIC () in
    GList.clist ~columns:5 ~titles_show:true
      ~selection_mode:`BROWSE ~packing:sw#add () in
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
            (Gdk.Font.string_width font "skipped") in
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
        ~hpolicy:`AUTOMATIC ~vpolicy:`AUTOMATIC () in
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
            Some _, _                                      -> (false, false)
          | None,   Different((FILE,_, _),(FILE,_, _),_,_) -> (true, true)
          | None,   _                                      -> (true, false) in
        grSet grAction activate1;
        grSet grDiff activate2 in

  let makeRowVisible row =
    if mainWindow#row_is_visible row <> `FULL then begin
      let adj = mainWindow#vadjustment in
      let current = adj#value
      and upper = adj#upper and lower = adj#lower in
      let v =
        float row /. float (mainWindow#rows + 1) *. (upper-.lower) +. lower
      in
      adj#set_value (min v (upper -. adj#page_size))
    end in

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
    updateButtons () in

  (**********************************************************************)
  (*                       CREATE THE STATUS WINDOW                     *)
  (**********************************************************************)

  let statusHBox = GPack.hbox ~packing:(toplevelVBox#pack ~expand:false) () in
  let statusWindow =
    GMisc.statusbar ~packing:(statusHBox#pack ~expand:true) () in
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
      gtk_sync ()) in

  (* Tell the Trace module about the status printer *)
  Trace.statusPrinter := Some displayStatus;

  (**********************************************************************)
  (*            FUNCTIONS USED TO PRINT IN THE MAIN WINDOW              *)
  (**********************************************************************)

  let select i =
    let r = mainWindow#rows in
    let p = if r < 2 then 0. else (float i +. 0.5) /. float (r - 1) in
    mainWindow#scroll_vertical `JUMP (min p 1.) in

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
          Different (_, _, dir, _)
              when not (Prefs.readPref auto) || !dir = Conflict ->
            select i
        | _ ->
            loop (i + 1) in
    loop start in
  let selectSomethingIfPossible () =
    if !current=None then nextInteresting () in

  let columnsOf i =
    let oldPath = if i = 0 then emptypath else !theState.(i-1).ri.path in
    let status =
      match !theState.(i).whatHappened with
        None -> "      "
      | Some conf ->
          match !theState.(i).ri.replicas with
            Different(_,_,{contents=Conflict},_) | Problem _ ->
              "      "
          | _ ->
              match conf with
                Succeeded _ -> "done  "
              | Failed _    -> "failed" in
    let s = reconItem2string oldPath !theState.(i).ri status in
    (* FIX: This is ugly *)
    (String.sub s ~pos:0 ~len:8,
     String.sub s ~pos:9 ~len:5,
     String.sub s ~pos:15 ~len:8,
     String.sub s ~pos:25 ~len:6,
     String.sub s ~pos:32 ~len:(String.length s - 32)) in

  let greenPixel  = "00dd00" in
  let redPixel    = "ff2040" in
  let yellowPixel = "999900" in
  let lightbluePixel = "8888FF" in
  let blackPixel  = "000000" in
  let buildPixmap p = 
    GDraw.pixmap_from_xpm_d ~window:toplevelWindow ~data:p () in
  let buildPixmaps f c1 =
    (buildPixmap (f c1), buildPixmap (f lightbluePixel)) in

  let rightArrow = buildPixmaps Pixmaps.copyAB greenPixel in
  let leftArrow = buildPixmaps Pixmaps.copyBA greenPixel in
  let ignoreAct = buildPixmaps Pixmaps.ignore redPixel in
  let doneIcon = buildPixmap Pixmaps.success in
  let failedIcon = buildPixmap Pixmaps.failure in
  let rightArrowBlack = buildPixmap (Pixmaps.copyAB blackPixel) in
  let leftArrowBlack = buildPixmap (Pixmaps.copyBA blackPixel) in

  let displayArrow i action =
    let changedFromDefault = match !theState.(i).ri.replicas with
        Different(_,_,{contents=curr},default) -> curr<>default
      | _ -> false in
    let sel pixmaps =
      if changedFromDefault then snd pixmaps else fst pixmaps in
    match action with
      "<-?->" -> mainWindow#set_cell ~pixmap:(sel ignoreAct) i 1
    | "---->" -> mainWindow#set_cell ~pixmap:(sel rightArrow) i 1
    | "<----" -> mainWindow#set_cell ~pixmap:(sel leftArrow) i 1
    | "error" -> mainWindow#set_cell ~pixmap:failedIcon i 1
    |    _    -> assert false in

  let displayStatusIcon i status =
    match status with
    | "failed" -> mainWindow#set_cell ~pixmap:failedIcon i 3
    | "done  " -> mainWindow#set_cell ~pixmap:doneIcon i 3
    | _        -> mainWindow#set_cell ~text:status i 3 in

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
    updateDetails () in

  let red =
    Gdk.Color.alloc (Gdk.Color.get_system_colormap ())
      (`RGB (65535, 0, 0)) in

  let redisplay i =
    let (r1, action, r2, status, path) = columnsOf i in
    mainWindow#freeze ();
    mainWindow#set_cell ~text:r1     i 0;
    displayArrow i action;
    mainWindow#set_cell ~text:r2     i 2;
    displayStatusIcon i status;
    mainWindow#set_cell ~text:path   i 4;
    if status = "failed" then begin
      mainWindow#set_cell
        ~text:(path ^ "       [failed: click here for details]") i 4
    end; 
    mainWindow#thaw ();
    if !current = Some i then updateDetails ();
    updateButtons () in

  let globalProgressBar =
    GMisc.statusbar ~packing:(statusHBox#pack ~expand:false) () in
  let globalProgressContext = globalProgressBar#new_context ~name:"prog" in
  ignore (globalProgressContext#push "");

  let totalBytesToTransfer = ref(0) in
  let totalBytesTransferred = ref(0) in

  let displayGlobalProgress s =
    ignore (globalProgressContext#push s);
    (* Force message to be displayed immediately *)
    gtk_sync () in

  let showGlobalProgress b =
    Threads.do_on_main_thread (fun () ->
      (* Concatenate the new message *)
      globalProgressContext#pop ();
      totalBytesTransferred := !totalBytesTransferred + b;
      let s = percent2string (percentageOfTotal !totalBytesTransferred
                                                !totalBytesToTransfer) in
      displayGlobalProgress (s^" ")) in

  let initGlobalProgress b =
    totalBytesToTransfer := b;
    totalBytesTransferred := 0;
    showGlobalProgress 0
  in

  let showProgress i bytes dbg =
    !theState.(i).bytesTransferred <- !theState.(i).bytesTransferred + bytes;
    let b = !theState.(i).bytesTransferred in
    let len = Common.riLength !theState.(i).ri in
    let newstatus =
      if b=0 || len = 0 then "start "
      else if len = 0 then sprintf "%5d " b 
      else percent2string (percentageOfTotal b len) in
    let dbg = if Trace.enabled "progress" then dbg ^ "/" else "" in 
    let newstatus = dbg ^ newstatus in
    debugprogress
      (fun() -> errmsg4
         "Progress update: %d bytes (%d done out of %d: %s)\n"
         bytes b len newstatus);
    Threads.do_on_main_thread (fun () ->
      mainWindow#set_cell ~text:newstatus i 3;
      gtk_sync ());
    showGlobalProgress bytes;
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
    displayMain() in
  
  let sortAndRedisplay () =
    current := None;
    let compareRIs = Sortri.compareReconItems() in
    Array.stable_sort (fun si1 si2 -> compareRIs si1.ri si2.ri) !theState;
    displayMain() in
  
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
      updates in
    let reconcile updates =
      let t = Trace.startTimer "Reconciling" in
      Recon.reconcileAll updates in
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
    grSet grRestart true in

  (**********************************************************************)
  (* The ignore dialog                                                  *)
  (**********************************************************************)

  let ignoreDialog () =
    let t = GWindow.dialog ~title: "Ignore" ~wm_name: "Ignore" () in
    let hbox = GPack.hbox ~packing:t#vbox#add () in
    let sb = GRange.scrollbar `VERTICAL
        ~packing:(hbox#pack ~from:`END ~expand:false) () in
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
    let hbox = GPack.hbox ~spacing:4 ~packing:(t#vbox#pack ~expand:false) () in
    ignore (GMisc.label ~text: "Regular expression:"
              ~packing:(hbox#pack ~expand:false ~padding:2) ());
    let entry = GEdit.entry ~packing:hbox#add () in
    let add () =
      let theRegExp = entry#text in
      if theRegExp<>"" then begin
        entry#set_text "";
        regExpWindow#unselect_all ();
        ignore (regExpWindow#append [theRegExp]);
        maybeGettingSmaller := true
      end in
    let addButton = GButton.button ~label:"Add"
        ~packing:(hbox#pack ~expand:false) () in
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
          () in
    let deleteButton = GButton.button ~label:"Delete"
        ~packing:(hbox#pack ~expand:false) () in
    ignore (deleteButton#connect#clicked ~callback:delete);
    
    ignore
      (regExpWindow#connect#after#event#key_press ~callback:
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
      maybeGettingSmaller := false; in
    
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
    releaseFocus () in

  (**********************************************************************)
  (* Add entries to the Help menu                                       *)
  (**********************************************************************)
  let addDocSection (shortname, (name, docstr)) =
    if shortname <> "" && name <> "" then
      ignore (helpMenu#add_item
		~callback:(fun () -> documentation shortname)
                name) in
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
        () in
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
  (* Add entries to the Sort menu                                       *)
  (**********************************************************************)
  grAdd grAction
    (sortMenu#add_item 
       ~callback:(fun () -> getLock (fun () ->
          Sortri.sortByName();
          sortAndRedisplay()))
       "Sort entries by name");
  grAdd grAction
    (sortMenu#add_item 
       ~callback:(fun () -> getLock (fun () ->
          Sortri.sortBySize();
          sortAndRedisplay()))
       "Sort entries by size");
  grAdd grAction
    (sortMenu#add_item 
       ~callback:(fun () -> getLock (fun () ->
          Sortri.sortNewFirst();
          sortAndRedisplay()))
       "Sort new entries first");
  grAdd grAction
    (sortMenu#add_item 
       ~callback:(fun () -> getLock (fun () ->
          Sortri.restoreDefaultSettings();
          sortAndRedisplay()))
       "Go back to default ordering");

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
      let totalLength =
        Array.fold_left
          (fun l si -> l + (Common.riLength si.ri))
          0 !theState in
      displayGlobalProgress "     ";
      initGlobalProgress totalLength;
      let t = Trace.startTimer "Propagating changes" in
      let (start, wait) = Threads.thread_maker () in
      let background =
        let i = 55000 in
        Gdk.Color.alloc (Gdk.Color.get_system_colormap ()) (`RGB (i, i, i)) in
      let white =
        let i = 65535 in
        Gdk.Color.alloc (Gdk.Color.get_system_colormap ()) (`RGB (i, i, i)) in
      let finish i =
        redisplay i;
        mainWindow#set_row ~background:white i;
        gtk_sync () in
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

      let failures =
        let count =
          Array.fold_left
            (fun l si ->
               l + (match si.whatHappened with Some(Failed(_)) -> 1 | _ -> 0))
            0 !theState in
        if count = 0 then "" else
          sprintf "%d failure%s" count (if count=1 then "" else "s") in
      let skipped =
        let count =
          Array.fold_left
            (fun l si ->
               l + (if problematic si.ri then 1 else 0))
            0 !theState in
        if count = 0 then "" else
          sprintf "%d skipped" count in
      Trace.status
        (sprintf "Synchronization complete         %s%s%s"
           failures (if failures=""||skipped="" then "" else ", ") skipped);
      displayGlobalProgress "";

      grSet grRestart true
    end in

  (**********************************************************************)
  (*                  CREATE THE ACTION BAR                             *)
  (**********************************************************************)
  let actionBar =
    GButton.toolbar
      ~orientation:`HORIZONTAL ~tooltips:true ~space_size:10
      ~packing:(toplevelVBox#pack ~expand:false) () in

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
    end in
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
          None, Different(_, _, dir, _) ->
            f dir;
            redisplay i;
            nextInteresting ()
        | _ ->
            ()
        end
    | None ->
        () in
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
        () in

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
    (mainWindow#connect#event#key_press ~callback:
       begin fun ev ->
         let key = GdkEvent.Key.keyval ev in
         if key = _Left then begin
           leftAction (); mainWindow#connect#stop_emit "key_press_event"; true
         end else if key = _Right then begin
           rightAction (); mainWindow#connect#stop_emit "key_press_event"; true
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
    Printf.sprintf "from %s to %s" loc1 loc2 in
  let left =
    actionsMenu#add_item ~key:_greater ~callback:rightAction
      ("Propagate this path " ^ descr) in
  grAdd grAction left;
  left#add_accelerator ~group:accel_group ~modi:[`SHIFT] _greater;
  
  let descl =
    if loc1 = loc2 then "right to left" else
    Printf.sprintf "from %s to %s" loc2 loc1 in
  let right =
    actionsMenu#add_item ~key:_less ~callback:leftAction
      ("Propagate this path " ^ descl) in
  grAdd grAction right;
  right#add_accelerator ~group:accel_group ~modi:[`SHIFT] _less;
 
  grAdd grAction
    (actionsMenu#add_item ~key:_slash ~callback:questionAction
       "Do not propagate changes to this path");

  (* Override actions *)
  ignore (actionsMenu#add_separator ());
  grAdd grAction
    (actionsMenu#add_item 
       ~callback:(fun () -> getLock (fun () ->
          Array.iter
            (fun si -> Recon.preferDirection si.ri Replica1ToReplica2 false)
            !theState;
          displayMain()))
       "Resolve all conflicts in favor of first root");
  grAdd grAction
    (actionsMenu#add_item 
       ~callback:(fun () -> getLock (fun () ->
          Array.iter
            (fun si -> Recon.preferDirection si.ri Replica2ToReplica1 false)
            !theState;
          displayMain()))
       "Resolve all conflicts in favor of second root");
  grAdd grAction
    (actionsMenu#add_item 
       ~callback:(fun () -> getLock (fun () ->
          Array.iter
            (fun si -> Recon.preferDirection si.ri Replica1ToReplica2 true)
            !theState;
          displayMain()))
       "Force all changes from first root to second");
  grAdd grAction
    (actionsMenu#add_item 
       ~callback:(fun () -> getLock (fun () ->
          Array.iter
            (fun si -> Recon.preferDirection si.ri Replica2ToReplica1 true)
            !theState;
          displayMain()))
       "Force all changes from second root to first");
  grAdd grAction
    (actionsMenu#add_item 
       ~callback:(fun () -> getLock (fun () ->
          Array.iter
            (fun si -> Recon.revertToDefaultDirection si.ri)
            !theState;
          displayMain()))
       "Revert to Unison's recommendations");

  (* Diff *)
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
  grAdd grRestart
    (fileMenu#add_item ~key:_r ~callback:detectCmd detectCmdName);
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
      "Make backups" in
  cm#set_show_toggle true;
  grAdd grRestart cm;
  ignore (fileMenu#add_separator ());
  ignore (fileMenu#add_item ~key:_q ~callback:safeExit "Quit");

  grSet grAction false;
  grSet grDiff false;
  grSet grProceed false;
  grSet grRestart false;

  ignore (toplevelWindow#connect#event#delete ~callback:
            (fun _ -> safeExit (); true));
  toplevelWindow#show ();
  currentWindow := Some toplevelWindow;
  detectCmd ()

(**********************************************************************)
(* Starting up...                                                     *)
(**********************************************************************)
let start _ =
  begin try
    (* Initialize the GTK library *)
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

    Uicommon.uiInit2
      fatalError
      tryAgainOrQuit
      displayWaitMessage
      getProfile 
      getFirstRoot 
      getSecondRoot;

    (match !waitWindow with None -> () | Some w -> w#destroy());
    createToplevelWindow ();

(* WORKING ON NEW SEQUENCE
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
         ignore (w#connect#event#delete ~callback:(fun _ -> exit 0));
         msg := Some w)
      (fun () ->
         begin match !msg with
           None   -> ()
         | Some w -> w#destroy ()
         end;
         createToplevelWindow ());
*)

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

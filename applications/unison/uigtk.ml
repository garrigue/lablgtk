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

(**********************************************************************)
(* UI preferences                                                     *)
(**********************************************************************)

let fontMonospaceMedium =
  if Sys.os_type = "Win32" then
    lazy (Gdk.Font.load "-*-Courier New-Medium-R-Normal--*-90-*-*-*-*-*-*")
  else
    lazy (Gdk.Font.load "-*-Clean-Medium-R-Normal--*-130-*-*-*-60-*-*")
let fontMonospaceBold =
  if Sys.os_type = "Win32" then
    lazy (Gdk.Font.load "-*-Courier New-Bold-R-Normal--*-90-*-*-*-*-*-*")
  else
    lazy (Gdk.Font.load "-*-Courier-Bold-R-Normal--*-120-*-*-*-*-*-*")

(**********************************************************************)
(* UI state variables                                                 *)
(**********************************************************************)

exception DerefSome
let derefSome theOption =
  match !theOption with
    None -> raise DerefSome
  | Some item -> item

let isNone = function
    None -> ()
  | Some _ -> raise DerefSome

type stateItem = { ri : reconItem;
                   mutable whatHappened : unit confirmation option }
let theState = ref None

let current = ref None
let busy = ref false

(**********************************************************************)
(* Some widgets							      *)
(**********************************************************************)

class scrolled_text ?editable ?word_wrap ?width ?height ?packing ?show
    () =
  let hbox = GPack.hbox ?width ?height ?packing ~show:false () in
  let scrollbar = GRange.scrollbar `VERTICAL
      ~packing:(hbox#pack ~from:`END ~expand:false) () in
  let text = GEdit.text ~vadjustment:scrollbar#adjustment
      ?editable ?word_wrap ~packing:hbox#add () in
  object
    inherit GObj.widget_full hbox#as_widget
    method scrollbar = scrollbar
    method text = text
    method insert ?(font=fontMonospaceMedium) s =
      text#insert ~font:(Lazy.force font) s
    method show () = hbox#misc#show ()
    initializer
      if show <> Some false then hbox#misc#show ()
  end

let gtk_sync () = while Glib.Main.iteration false do () done

(**********************************************************************)
(* okBox: Display a message in a window and wait for the user   *)
(* to hit the "OK" button.                                            *)
(**********************************************************************)
let okBox ~title ~message =
    (* Create a new toplevel window *)
    let t = GWindow.dialog ~title ~wm_name:title ~modal:true () in
    let theLabel = GMisc.label ~text:message
	~packing:(t#vbox#pack ~expand:false ~padding:4) () in
    let ok = GButton.button ~label:"OK" ~packing:t#action_area#add () in
    ok#grab_default ();
    ok#connect#clicked ~callback:(fun () -> t#destroy());
    t#show ();
    (* Do nothing until user destroys window *)
    t#connect#destroy ~callback:Main.quit;
    Main.main ()

(**********************************************************************)
(* warnBox: Display a warning message in a window and wait for the    *)
(* user to hit "OK" or "Exit".                                        *)
(**********************************************************************)
let warnBox ~title ~message =
    (* Create a new toplevel window *)
    let t = GWindow.dialog ~title ~wm_name:title ~modal:true () in
    let theLabel = GMisc.label ~text:message
	~packing:(t#vbox#pack ~expand:false ~padding:4) () in
    let ok = GButton.button ~label:"OK" ~packing:t#action_area#add () in
    ok#grab_default ();
    ok#connect#clicked ~callback:(fun () -> t#destroy());
    let exitB = GButton.button ~label:"Exit" ~packing:t#action_area#add () in
    ok#connect#clicked ~callback:(fun () -> t#destroy(); GMain.Main.quit ());
    t#show ();
    (* Do nothing until user destroys window *)
    t#connect#destroy ~callback:Main.quit;
    Main.main ()

(**********************************************************************)
(* The profile selection dialog                                       *)
(**********************************************************************)
let profileSelect toplevelWindow =
  let dirString = fspath2string Os.synchronizerFspath in
  if not(Sys.file_exists dirString)
  then true (* First use, just return and build a default profile *)
  else (* > first use, look for existing profiles *)
    let profiles =
      Safelist.map (Files.ls dirString "*.prf")
        ~f:(fun f -> Filename.chop_suffix f ".prf")
    in
    match profiles with
      [] -> true (* No profiles; return and build a default profile *)
    | hd::_ -> begin
        (* Profiles exist. If "default" is one of them, that becomes
           the default of the dialog; otherwise the first profile
           becomes the default. *)
        let profiles =
          if Safelist.mem "default" profiles
          then "default":: Safelist.filter ~f:(fun f -> f<>"default") profiles
          else profiles in
        let var1 = ref (Safelist.hd profiles) in

        let roots_of_profile f =
          try
            let filename = fspath2string (Os.fileInUnisonDir (f^".prf")) in
            Safelist.map ~f:(fun (n,v) -> v)
              (Safelist.filter ~f:(fun (n,v) -> n="root")
                 (Prefs.scanPreferencesFile filename))
          with _ -> []
        in

        (* This ref will be set to true if the user picks a profile.
           If the user cancels by hitting the cancel button or closing
           the dialog, it will remain false and the whole program will
           be closed. *)
        let successful = ref false in

        (* Build the dialog *)
        let t = GWindow.dialog ~title:"Profiles"
            ~wm_name:"Profiles" ~modal:true ~allow_grow:false () in
        t#misc#grab_focus ();

        let vb = t#vbox in

        GMisc.label ~text:"Select an existing profile or start a new one."
          ~packing:(vb#pack ~expand:false) ();

        let buttons =
          Safelist.map profiles ~f:
            begin fun profile ->
              let b = GButton.radio_button ~label:profile ~packing:vb#add () in
              Safelist.iter (roots_of_profile profile) ~f:
                begin fun s ->
                  ignore (GMisc.label ~text:("          Root: "^s)
                            ~packing:vb#add ())
                end;
              b
            end
        in

        let f1 = GPack.hbox ~packing:vb#add () in
        let newValue = "//NEWPROFILE//" in
        let newButton = GButton.radio_button ~label:"New:"
            ~packing:(f1#pack ~expand:false) () in

        let entry = GEdit.entry ~packing:f1#add () in
        let newCommand() =
          let profile = entry#text in
          if profile<>"" then
            let file = profile^".prf" in
            let fspath = Os.fileInUnisonDir file in
            let filename = fspath2string fspath in
            if Sys.file_exists filename then
              okBox ~title:(myName^" error")
                ~message:("Profile \""
                         ^ profile
                         ^ "\" already exists!\nPlease select another name.")
            else begin
              (* Make an empty file *)
              let ch =
                open_out_gen filename
                  ~mode:[Open_wronly; Open_creat; Open_trunc] ~perm:0o600 in
              close_out ch;
              Globals.prefsFileName := file;
              successful := true;
              t#destroy ()
            end in
        let okCommand() =
          let profile = !var1 in
          if profile = newValue
          then newCommand()
          else begin
            Globals.prefsFileName := profile^".prf";
            successful := true;
            t#destroy ()
          end in

        entry#connect#activate ~callback:newCommand;

        let oldState() =
          entry#set_editable false
        in
        let newState() =
          entry#set_editable true
        in
        oldState();

        let button0 = Safelist.hd buttons in
        List.iter2 (newValue::profiles) (newButton::buttons) ~f:
          begin fun profile (button : GButton.radio_button) ->
            if button <> button0 then button#set_group button0#group;
            button#connect#clicked ~callback:
              begin fun () ->
                if profile = newValue then newState () else oldState ();
                var1 := profile
              end;
            ()
          end;
        button0#set_active true;

        let okButton = GButton.button ~label:"OK"
            ~packing:t#action_area#add () in
        okButton#connect#clicked ~callback:okCommand;
        okButton#grab_default ();
        let cancelCommand() = t#destroy (); toplevelWindow#destroy () in
        let cancelButton = GButton.button ~label:"Cancel"
            ~packing:t#action_area#add () in
        cancelButton#connect#clicked ~callback:cancelCommand;
        cancelButton#misc#set_can_default true;

        (* The profile selection dialog has been installed into the Gtk
           main interaction loop; wait until it completes. *)
        t#show ();
        t#connect#destroy ~callback:Main.quit;
        Main.main ();

        (* Return whether the selection was successful *)
        !successful
    end

(**********************************************************************)
(* Standard file dialog                                               *)
(**********************************************************************)
let file_dialog ~title ~callback ?filename () =
  let sel =
    GWindow.file_selection ~title ~modal:true ?filename () in
  sel#cancel_button#connect#clicked ~callback:sel#destroy;
  sel#ok_button#connect#clicked ~callback:
    begin fun () ->
      let name = sel#get_filename in
      sel#destroy ();
      callback name
    end;
  sel#show ()

(**********************************************************************)
(* The root selection dialog                                          *)
(**********************************************************************)
let rootSelect toplevelWindow =
  begin
    (* This ref will be set to true if the user picks roots.
       If the user cancels by hitting the cancel button or closing
       the dialog, it will remain false and the whole program will
       be closed. *)
    let successful = ref false in

    let t = GWindow.dialog ~title:"Enter roots" ~wm_name:"Enter roots"
        ~modal:true ~allow_grow:false () in
    t#misc#grab_focus ();

    let vb = GPack.vbox ~border_width:4 ~packing:t#vbox#add () in

    GMisc.label ~text:"Enter the roots you want to synchronize."
      ~packing:vb#add ();

    let makeGetRoot() =
      let f = GPack.vbox ~packing:(vb#pack ~padding:4) () in
      let f0 = GPack.hbox ~spacing:4 ~packing:f#add () in
      GMisc.label ~text:"Host:" ~packing:(f0#pack ~expand:false) ();
      let localB = GButton.radio_button ~packing:(f0#pack ~expand:false)
          ~label:"Local" () in
      let remoteB = GButton.radio_button ~group:localB#group
          ~packing:(f0#pack ~expand:false) ~label:"Remote" () in
      let hostE = GEdit.entry ~packing:f0#add () in
      let f1 = GPack.hbox ~spacing:4 ~packing:f#add () in
      GMisc.label ~text:"File:" ~packing:(f1#pack ~expand:false) ();
      let fileE = GEdit.entry ~packing:f1#add () in
      let browseCommand() =
        file_dialog ~title:"Select a local file"
          ~callback:(fun file -> fileE#set_text file) ()
      in
      let b = GButton.button ~label:"Browse"
          ~packing:(f1#pack ~expand:false) () in
      b#connect#clicked ~callback:browseCommand;
      let varLocalRemote = ref (`Local : [`Local|`Remote]) in
      let localState() =
        varLocalRemote := `Local;
        hostE#set_editable false;
        b#misc#set_sensitive true
      in
      let remoteState() =
        varLocalRemote := `Remote;
        hostE#set_editable true;
        b#misc#set_sensitive false
      in
      localB#connect#clicked ~callback:localState;
      remoteB#connect#clicked ~callback:remoteState;
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

    
    GMisc.label ~text:"ROOT 1:" ~xalign:0. ~packing:(vb#pack ~padding:4) ();
    let getRoot1 = makeGetRoot() in

    GMisc.label ~text:"ROOT 2:" ~xalign:0. ~packing:(vb#pack ~padding:4) ();
    let getRoot2 = makeGetRoot() in

    let f3 = t#action_area in
    let okCommand() =
      let root1 = getRoot1() in
      let root2 = getRoot2() in
      Prefs.setPref Uicommon.roots Prefs.PermanentSetting [root1;root2];
      Globals.savePrefs();
      successful := true;
      t#destroy () in
    let okButton = GButton.button ~label:"OK" ~packing:f3#add () in
    okButton#connect#clicked ~callback:okCommand;
    let cancelCommand() =
      t#destroy ();
      toplevelWindow#destroy ()
    in
    let cancelButton = GButton.button ~label:"Cancel" ~packing:f3#add () in
    cancelButton#connect#clicked ~callback:cancelCommand;

    (* The root selection dialog has been installed into the Gtk
       main interaction loop; wait until it completes. *)
    t#show ();
    t#connect#destroy ~callback:Main.quit;
    Main.main ();

    (* Return whether the selection was successful *)
    !successful
  end



(**********************************************************************)
(* Create the toplevel window                                         *)
(**********************************************************************)
let start _ =
  (* Initialize the library *)
  Main.init ();

  let toplevelWindow = GWindow.window ~wm_name:myName () in
  let toplevelVBox = GPack.vbox ~packing:toplevelWindow#add () in

  (* displayHooks is a list of functions that should be called to
     actually display the ui elements on screen. It allows us to
     set up all the elements in an initial stage, but defer their
     actual display until later. *)
  let displayHooks = ref [] in
  let addDisplayHook f = displayHooks := f::!displayHooks in
  let invokeDisplayHooks () =
    Safelist.iter ~f:(fun f -> f()) (Safelist.rev !displayHooks) in

  (**********************************************************************)
  (* Function to display a message in a new window                      *)
  (**********************************************************************)
  let charW = Gdk.Font.char_width (Lazy.force fontMonospaceMedium) 'M'
  and charH = 15
    (* Gdk.Font.char_height (Lazy.force fontMonospaceMedium) 'l' *) in
  let messageBox ~title ?(label = "Dismiss")
      ?(action = fun t -> t#destroy) ?(modal = false) message =
    begin
      (* Create a new toplevel window *)
      let t = GWindow.dialog ~title ~wm_name:title ~modal () in
      (* Create the dismiss button *)
      let t_dismiss =
	GButton.button ~label ~packing:t#action_area#add () in
      t_dismiss#connect#clicked ~callback:(action t);
      (* Create the display area *)
      let t_text = new scrolled_text ~editable:false
	  ~width:(charW*80) ~height:(charH*20) ~packing:t#vbox#add () in
      (* Insert text *)
      t_text#insert message;
      t#show ()
    end in
  let fatalError =
    messageBox ~title:"Fatal Error" ~label:"Exit" ~modal:true
      ~action:(fun t () -> t#destroy (); toplevelWindow#destroy ())
  in

  (**********************************************************************)
  (* Create the menu bar                                                *)
  (**********************************************************************)
  let menuBar =
    GMenu.menu_bar ~border_width:2 ~packing:(toplevelVBox#pack ~expand:false) ()
  in
  let menus = new GMenu.factory menuBar ~accel_modi:[] in
  let accel_group = menus#accel_group in
  toplevelWindow#add_accel_group accel_group;
  let add_submenu ~label =
    new GMenu.factory (menus#add_submenu label) ~accel_group ~accel_modi:[]
  in
  
  (**********************************************************************)
  (* Create the menus                                                   *)
  (**********************************************************************)
  let fileMenu = add_submenu ~label:"File"
  and actionsMenu = add_submenu ~label:"Actions"
  and ignoreMenu = add_submenu ~label:"Ignore"
  and helpMenu = add_submenu ~label:"Help" in

  (**********************************************************************)
  (* Create the main window                                             *)
  (**********************************************************************)

  let mainWindow =
    let box = GPack.hbox ~height:(Prefs.readPref mainWindowHeight * 12)
        ~packing:toplevelVBox#add () in
    let sb = GRange.scrollbar `VERTICAL
	~packing:(box#pack ~from:`END ~expand:false) () in
    GList.clist ~columns:5 ~vadjustment:sb#adjustment
      ~titles_show:true ~packing:box#add ()
  in
  mainWindow#misc#grab_focus ();
  Array.iteri [|100; 40; 100; 40; 200|]
    ~f:(fun i data -> mainWindow#set_column i ~width:data);
  let displayTitle() =
    let s = roots2string () in
    Array.iteri ~f:(fun i data -> mainWindow#set_column i ~title:data)
      [| String.sub ~pos:0 ~len:12 s; "Action";
	 String.sub ~pos:15 ~len:12 s; "Status"; "Path" |]
  in

  (**********************************************************************)
  (* Create the details window                                          *)
  (**********************************************************************)

  let detailsWindow =
    GEdit.text ~editable:false ~height:(3*charH) ~width:(charW*96)
      ~packing:(toplevelVBox#pack ~expand:false) () in
  let displayDetails thePathString newtext =
    detailsWindow#freeze ();
    (* Delete the current text *)
    detailsWindow#delete_text ~start:0 ~stop:detailsWindow#length;
    (* Insert the new text *)
    detailsWindow#insert thePathString ~font:(Lazy.force fontMonospaceBold);
    detailsWindow#insert "\n";
    detailsWindow#insert newtext ~font:(Lazy.force fontMonospaceMedium);
    (* Display text *)
    detailsWindow#thaw ()
  in

  (**********************************************************************)
  (*          CREATE THE WINDOW FOR TRACING INFORMATION                 *)
  (**********************************************************************)

  let traceWindow =
    new scrolled_text ~editable:false ~packing:toplevelVBox#add ~show:false () in

  if Prefs.readPref Trace.printTrace then traceWindow#show ();

  let displayMessage0 printNewline m =
    (* Concatenate the new message *)
    traceWindow#insert m;
    if printNewline then traceWindow#insert "\n";
    (* Text.see traceWindowText (TextIndex(End,[])); *)
    (* Force message to be displayed immediately *)
    gtk_sync ()
  in
  let displayMessage m = displayMessage0 true m in
  let displayMessageContinue m = displayMessage0 false m in

  (* Cause any tracing messages to be printed to the messages window *)
  Trace.printer := Some displayMessageContinue;

  let trace m = (Trace.message m; Trace.message "\n") in
  let traceContinue m = Trace.message m in

  let deleteTraceWindow() =
    traceWindow#text#delete_text ~start:0 ~stop:traceWindow#text#length
  in

  (**********************************************************************)
  (*                       CREATE THE STATUS WINDOW                     *)
  (**********************************************************************)

  let statusWindow =
    GMisc.statusbar ~packing:(toplevelVBox#pack ~expand:false) () in
  let statusContext = statusWindow#new_context ~name:"status" in
  ignore (statusContext#push "");

  let displayStatus s1 s2 =
    (* Concatenate the new message *)
    let m =
      s1 ^ (String.make (max 2 (30 - String.length s1)) ' ') ^ s2 in
    statusContext#pop ();
    ignore (statusContext#push m);
    (* Force message to be displayed immediately *)
    gtk_sync () in

  (* Tell the Trace module about the status printer *)
  Trace.statusPrinter := Some displayStatus;

  (**********************************************************************)
  (*            FUNCTIONS USED TO PRINT IN THE MAIN WINDOW              *)
  (**********************************************************************)

  let deselect () =
    mainWindow#unselect_all ();
    current := None;
    displayDetails "" ""
  in

  let select i = mainWindow#select i 0 in

  mainWindow#connect#select_row ~callback:
    begin fun ~row ~column ~event ->
      try
	let a = derefSome theState in
	current := Some row;
	if mainWindow#row_is_visible row <> `FULL then begin
	  let adj = mainWindow#vadjustment in
	  let current = adj#value
	  and upper = adj#upper and lower = adj#lower in
	  let v =
	    (float row /. float (Array.length a +1) *. (upper-.lower) +. lower)
	  in
	  adj#set_value (min v (upper -. adj#page_size))
	end;
        let details =
          match a.(row).whatHappened with
            None -> details2string a.(row).ri "  "
          | Some(Succeeded(_)) -> details2string a.(row).ri "  "
          | Some(Failed(s)) -> s in
        displayDetails (path2string a.(row).ri.path) details
      with DerefSome -> ()
    end;

  let next() =
    match !current with
    | Some i ->
        begin try
          if i+1<Array.length(derefSome theState) then select(i+1)
        with DerefSome -> () end
    | None ->
        begin try
          ignore (derefSome theState);
          select 0
        with DerefSome -> () end in

  let nextInteresting() =
    begin try
      let a = derefSome theState in
      let l = Array.length a in
      let start = match !current with Some i -> i+1 | None -> 0 in
      let rec loop i =
        if i>=l then ()
        else match a.(i).ri.replicas with
            Different (_,_,dir) ->
              if Prefs.readPref auto && !dir<>Conflict then loop (i+1)
              else select(i)
          | _ ->
              loop (i+1) in
      loop start
    with DerefSome -> () end in

  let selectSomethingIfPossible() =
    if !current=None then
      nextInteresting()
  in

  let prev() =
    match !current with
    | Some i ->
        if i-1>=0 then select(i-1)
    | None ->
        begin try
          let len = Array.length(derefSome theState) in
          if len-1>=0 then select(len-1)
        with DerefSome -> () end in

  let confirmation2string = function
      Succeeded _ -> "ok      "
    | Failed _    -> "failed  " in

  let insert i =
    let theSIArray = derefSome theState in
    if i >= Array.length theSIArray then raise DerefSome;
    let resultof i =
      match theSIArray.(i).whatHappened with
        None -> "        "
      | Some conf ->
          match theSIArray.(i).ri.replicas with
            Different(_,_,{contents=Conflict}) ->
              "skipped "
          | _ ->
              confirmation2string conf in
    (* Insert the new contents *)
    let oldPath =
      if i = 0 then emptypath else theSIArray.(i-1).ri.path in
    let s = reconItem2string oldPath theSIArray.(i).ri (resultof i) in
    mainWindow#insert ~row:i
      [ String.sub ~pos:0 ~len:8 s;
	String.sub ~pos:9 ~len:5 s;
	String.sub ~pos:15 ~len:8 s;
	String.sub ~pos:24 ~len:8 s;
	String.sub ~pos:33 ~len:(String.length s - 33) s ];
    ()
  in

  let displayMain() =
    (* Delete the current contents *)
    mainWindow#clear ();
    begin try
      let theSIArray = derefSome theState in
      let theLength = Array.length theSIArray in
      (* Insert the new contents *)
      for i = 0 to theLength - 1 do insert i done;
      select 0
    with DerefSome -> ()
    end;
    (* Force immediate redisplay *)
    gtk_sync () in

  (* Experimental
  let successlabel =
    Label.create mainWindowText
      [BorderWidth(Pixels 0);
       ImagePhoto (Imagephoto.create [Data Strings.successicon])] in
     end experimental *)

  let redisplay i =
    mainWindow#remove ~row:i;
    (* Insert the new text *)
    try insert i with DerefSome -> ()
  in

  (* Apply new ignore patterns to the current state, expecting that the
     number of reconitems will grow smaller. Adjust the display, being
     careful to keep the cursor as near as possible to its position
     before the new ignore patterns take effect. *)
  let ignoreAndRedisplay() =
    begin
      begin try
        let theSIArray = derefSome theState in
        let theSIList = Array.to_list theSIArray in
        let keep sI =
          not (Pred.test Globals.ignore (path2string sI.ri.path)) in
        begin match !current with
          None ->
            let theSIList = Safelist.filter ~f:keep theSIList in
            let theSIArray = Array.of_list theSIList in
            theState := Some theSIArray
        | Some index ->
            deselect ();
            let (theSIList,newCurrent) =
              if index < 0 then
                (Safelist.filter ~f:keep theSIList,None)
              else
                try
                  let beforeIndex,atIndex,afterIndex =
                    let rec loop i (before,rest) =
                      match rest with
                        [] -> raise(Transient "ignoreAndRedisplay")
                      | hd::tl ->
                          if i=index then (Safelist.rev before,hd,tl)
                          else loop (i+1) (hd::before,tl) in
                    loop 0 ([],theSIList) in
                  let before = Safelist.filter ~f:keep beforeIndex in
                  let after = Safelist.filter ~f:keep afterIndex in
                  if keep atIndex then
                    (Safelist.append before (atIndex::after),
                     Some(Safelist.length before))
                  else if Safelist.length after > 0 then
                    (Safelist.append before after,Some(Safelist.length before))
                  else if Safelist.length before > 0 then
                    (before,Some(Safelist.length before - 1))
                  else ([],None)
                with Transient "ignoreAndRedisplay" ->
                  (Safelist.filter ~f:keep theSIList,None) in
            let theSIArray = Array.of_list theSIList in
            current := newCurrent;
            theState := Some theSIArray
        end;
        displayMain()
        (* redisplay (derefSome current) *)
      with DerefSome -> ()
      end;
      (try select (derefSome current) with DerefSome -> ())
    end in
  
  (**********************************************************************)
  (*                         FUNCTION DETECT UPDATES                    *)
  (**********************************************************************)

  let detectUpdatesAndReconcile clearMessages =
    try
      begin
        current := None;
        displayDetails "" "";
        if clearMessages then deleteTraceWindow();
        (* displayRoots(); *)
        displayTitle();
        let (r1,r2) = Globals.getReplicaRoots() in
        let t = Trace.startTimer "Checking for updates" in
        let updates = Update.findUpdates() in
        Trace.showTimer t;
        let t = Trace.startTimer "Reconciling" in
        let reconItemList = Recon.reconcileAll updates in
        Trace.showTimer t;
        if reconItemList = [] then begin
          Trace.status "Everything is up to date";
          theState := None
        end else begin
          Trace.status ("Check and/or adjust selected actions; "
                        ^ "then press Proceed");
          theState :=
            Some(Array.of_list
                   (Safelist.map reconItemList
                      ~f:(fun ri -> { ri = ri; whatHappened = None })))
	end;
        displayMain()
      end
    with
      someError -> let errorMessage = exn2string someError in
      fatalError errorMessage
  in


  (**********************************************************************)
  (*                     LOCK MANAGEMENT FUNCTIONS                      *)
  (**********************************************************************)

  let getLock theFunction =
    if !busy then
     (displayMessage "Synchronizer is busy, please wait..")
    else
     (busy := true;
      theFunction();
      busy := false) in

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
    (* Create a new toplevel window *)
    let t = GWindow.dialog ~title ~wm_name:title ~modal:true () in
    let theLabel = GMisc.label ~text:message
	~packing:(t#vbox#pack ~expand:false ~padding:4) () in
    let yes = GButton.button ~label:"Yes" ~packing:t#action_area#add ()
    and no = GButton.button ~label:"No" ~packing:t#action_area#add () in
    yes#connect#clicked ~callback:(fun () -> t#destroy(); yesFunction());
    no#connect#clicked ~callback:(fun () -> t#destroy(); noFunction());
    t#show ()
  in

  (**********************************************************************)
  (* The ignore dialog                                                  *)
  (**********************************************************************)

  let ignoreDialog() =
    begin
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
      Safelist.iter theRegexps ~f:(fun r -> ignore (regExpWindow#append [r]));
      let maybeGettingBigger = ref false in
      let maybeGettingSmaller = ref false in
      let selectedRow = ref None in
      regExpWindow#connect#select_row ~callback:
	begin fun ~row ~column ~event ->
	  selectedRow := Some row
	end;
      regExpWindow#connect#unselect_row ~callback:
	begin fun ~row ~column ~event ->
	  selectedRow := None
	end;

      (* Configure the add frame *)
      let hbox = GPack.hbox ~spacing:4 ~packing:(t#vbox#pack ~expand:false) () in
      GMisc.label ~text: "Regular expression:"
	~packing:(hbox#pack ~expand:false ~padding:2) ();
      let entry = GEdit.entry ~packing:hbox#add () in
      let add () =
        let theRegExp = entry#text in
        if theRegExp<>"" then begin
	  entry#set_text "";
	  regExpWindow#unselect_all ();
	  regExpWindow#append [theRegExp];
          maybeGettingSmaller := true
	end
      in
      let addButton = GButton.button ~label:"Add"
	  ~packing:(hbox#pack ~expand:false) () in
      addButton#connect#clicked ~callback:add;
      entry#connect#activate ~callback:add;
      entry#misc#grab_focus ();

      (* Configure the delete button *)
      let delete () =
        try
          let x = derefSome selectedRow in
          (* After a deletion, updates must be detected again *)
          maybeGettingBigger := true;
          (* Delete xth regexp *)
	  regExpWindow#unselect_all ();
	  regExpWindow#remove ~row:x
        with DerefSome -> ()
      in
      let deleteButton = GButton.button ~label:"Delete"
	  ~packing:(hbox#pack ~expand:false) () in
      deleteButton#connect#clicked ~callback:delete;

      regExpWindow#connect#after#event#key_press ~callback:
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
	end;

      (* A function to refresh the state and ignore list *)
      let refresh() =
	let theRegexps = ref [] in
	for i = regExpWindow#rows - 1 downto 0 do
	  theRegexps := regExpWindow#cell_text i 0 :: !theRegexps
	done;
        Pred.intern Globals.ignore (!theRegexps);
        if !maybeGettingBigger || !maybeGettingSmaller then begin
          Globals.savePrefs();
	  Globals.propagatePrefs()
	end;
        if !maybeGettingBigger then detectUpdatesAndReconcile false
        else if !maybeGettingSmaller then ignoreAndRedisplay();
        maybeGettingBigger := false;
        maybeGettingSmaller := false;
      in

      (* Install the main buttons *)
      let applyButton =
	GButton.button ~label:"Apply" ~packing:t#action_area#add () in
      applyButton#connect#clicked ~callback:refresh;
      let cancelButton =
	GButton.button ~label:"Cancel" ~packing:t#action_area#add () in
      cancelButton#connect#clicked ~callback:t#destroy;
      let okButton =
	GButton.button ~label:"OK" ~packing:t#action_area#add () in
      okButton#connect#clicked ~callback:(fun () -> refresh(); t#destroy ());
      t#show ()
    end in

  (**********************************************************************)
  (*                         SAFE EXIT FUNCTION                         *)
  (**********************************************************************)

  let safeExit() =
    if not !busy then begin
     Remote.shutDown(); Main.quit ()
    end else
      yesOrNo ~title:"Premature exit"
        ~message:"Unison is working, exit anyway ?"
        ~yes:(fun () -> Remote.shutDown(); Main.quit ())
        ~no:(fun () -> ())
  in

  (**********************************************************************)
  (* Add entries to the Help menu                                       *)
  (**********************************************************************)
  let addDocSection (shortname, (name, docstr)) =
    if shortname<>"" && name<>"" then
      ignore (helpMenu#add_item name
		~callback:(fun () -> messageBox ~title:name docstr))
  in

  Safelist.iter ~f:addDocSection Strings.docs;

  (**********************************************************************)
  (* Add entries to the Ignore menu                                     *)
  (**********************************************************************)
  let addRegExp theRegExp =
    begin
      addIgnorePattern theRegExp;
      ignoreAndRedisplay()
    end in
  
  let addRegExpByPath pathfunc =
    try
      let i = derefSome current in
      let a = derefSome theState in
      let theRI = a.(i).ri in
      let thePath = theRI.path in
      addRegExp (pathfunc thePath);
    with
      DerefSome
    | Failure "nameRegExp"
    | Failure "extRegExp" -> () in

  ignoreMenu#add_item "Ignore this file permanently" ~key:_i
    ~callback:(fun () -> getLock (fun () -> addRegExpByPath ignorePath));

  ignoreMenu#add_item "Ignore files with this extension" ~key:_E
    ~callback:(fun () -> getLock (fun () -> addRegExpByPath ignoreExt));

  ignoreMenu#add_item "Ignore files with this name" ~key:_N
    ~callback:(fun () -> getLock (fun () -> addRegExpByPath ignoreName));

(* This is currently broken
  ignoreMenu#add_item "Edit ignore patterns" callback:
    begin fun () ->
      getLock (fun () -> try ignoreDialog() with DerefSome -> ())
    end;
 *)

  (**********************************************************************)
  (*                       MAIN FUNCTION : SYNCHRONIZE                  *)
  (**********************************************************************)

  let synchronize() =
    try
      let theSIArray = derefSome theState in
      let theLength = Array.length theSIArray in

      Trace.status "Propagating changes";
      let t = Trace.startTimer "Propagating changes" in

      for i = 0 to theLength - 1 do
        let theSI = theSIArray.(i) in
        if theSI.whatHappened = None then begin
          select(i);
          gtk_sync ();
          let conf = Transport.transportItem theSI.ri in
          theSI.whatHappened <- (Some conf);
          redisplay i;
	  gtk_sync ();
          match conf with
          | Succeeded() -> ()
          | Failed s -> displayMessage ("Failure: " ^ s)
        end
      done;

      Trace.showTimer t;
      Trace.status "Updating synchronizer state";
      let t = Trace.startTimer "Updating synchronizer state" in
      Update.commitUpdates ();
      Trace.showTimer t;
      Trace.status "Synchronization complete";
    with DerefSome ->
      (* BCPFIX: This is ugly *)
      Trace.status "Nothing to synchronize";
    | someError ->
      let errorMessage = exn2string someError in
      fatalError errorMessage in

  (**********************************************************************)
  (*                  CREATE THE ACTION BAR                             *)
  (**********************************************************************)

  let actionBar = GButton.toolbar
      ~orientation:`HORIZONTAL ~tooltips:true ~space_size:10
      ~packing:(toplevelVBox#pack ~expand:false) () in

  (**********************************************************************)
  (*         CREATE AND CONFIGURE THE QUIT BUTTON                       *)
  (**********************************************************************)

  actionBar#insert_space ();
  let _ = actionBar#insert_button ~text:"Quit" ~callback:safeExit in

  (**********************************************************************)
  (*         CREATE AND CONFIGURE THE PROCEED BUTTON                    *)
  (**********************************************************************)

  if not (Prefs.readPref batch) then begin
    actionBar#insert_space ();
    actionBar#insert_button ~text:"Proceed"
      ~tooltip:"Proceed with displayed actions"
      ~callback:(fun () -> getLock synchronize) ();
    ()
  end; 

  (**********************************************************************)
  (*           CREATE AND CONFIGURE THE RESCAN BUTTON                   *)
  (**********************************************************************)

  let detectCmdName =
    if Prefs.readPref batch then "Synchronize again" else "Restart" in
  let detectCmd () =
    getLock (fun () -> detectUpdatesAndReconcile false);
    if Prefs.readPref batch then
      (Prefs.setPref batch Prefs.TempSetting false; synchronize())
  in
  actionBar#insert_space ();
  actionBar#insert_button ~text:detectCmdName ~callback:detectCmd ();

  (**********************************************************************)
  (* Buttons for <--, -->, Skip                                         *)
  (**********************************************************************)

  let leftAction _ =
    try
      selectSomethingIfPossible();
      let i = derefSome current in
      let a = derefSome theState in
      let theSI = a.(i) in
      (match theSI.whatHappened,theSI.ri.replicas with
        None,Different(_,_,dir) ->
          dir := Replica2ToReplica1;
          redisplay i
      | _ -> ());
      nextInteresting();
    with DerefSome -> () in

  let rightAction _ =
    try
      selectSomethingIfPossible();
      let i = derefSome current in
      let a = derefSome theState in
      let theSI = a.(i) in
      (match theSI.whatHappened,theSI.ri.replicas with
        None,Different(_,_,dir) ->
          dir := Replica1ToReplica2;
          redisplay i
      | _ -> ());
      nextInteresting();
    with DerefSome -> () in

  let questionAction _ =
    try
      selectSomethingIfPossible();
      let i = derefSome current in
      let a = derefSome theState in
      let theSI = a.(i) in
      (match theSI.whatHappened,theSI.ri.replicas with
        None,Different(_,_,dir) ->
          dir := Conflict;
          redisplay i
      | _ -> ());
      nextInteresting();
    with DerefSome -> () in

  (**********************************************************************)
  (*             CREATE AND CONFIGURE THE DIFF BUTTON and KEY           *)
  (**********************************************************************)

  let diffCmd () = 
    getLock
      begin fun () ->
	try
          selectSomethingIfPossible();
          let i = derefSome current in
          let a = derefSome theState in
          let theSI = a.(i) in
          showDiffs a.(i).ri
            (fun title text -> messageBox ~title text)
            Trace.status
	with DerefSome -> ()
      end
  in

  if not(Prefs.readPref batch) && Sys.os_type <> "Win32" then begin
    actionBar#insert_space ();
    actionBar#insert_button ~text:"<--" ~callback:leftAction ();
    actionBar#insert_space ();
    actionBar#insert_button ~text:"-->" ~callback:rightAction ();
    actionBar#insert_space ();
    actionBar#insert_button ~text:"Skip" ~callback:questionAction ();
    actionBar#insert_space ();
    actionBar#insert_button ~text:"Diff" ~callback:diffCmd ();
    ()
  end;

  if Sys.os_type <> "Win32" then
    ignore (fileMenu#add_item "Show diffs" ~key:_d ~callback:diffCmd);

  (**********************************************************************)
  (* Configure keyboard commands                                        *)
  (**********************************************************************)

  mainWindow#connect#after#event#key_press ~callback:
    begin fun ev ->
      let key = GdkEvent.Key.keyval ev in
      if key = _Up || key = _Down || key = _Prior || key = _Next ||
      key = _Page_Up || key = _Page_Down then begin
	select (mainWindow#focus_row);
	true
      end else
	false
    end;

  (**********************************************************************)
  (* Add entries to the Navigate menu                                   *)
  (**********************************************************************)
  addDisplayHook (fun () ->
    (* All this is delayed because we need to wait until after
       Globals.replicaRoots is initialized *)
    let root1,root2 = Globals.getReplicaRoots() in
    let descr =
      if root1=root2 then "left to right"
      else (Printf.sprintf "from %s to %s"
              (root2hostname root1) (root2hostname root2)) in
    let left =
      actionsMenu#add_item ("Propagate " ^ descr) ~key:_greater
        ~callback:rightAction in
    left#add_accelerator _greater ~modi:[`SHIFT] ~group:accel_group;

    let descl =
      if root1=root2 then "right to left"
      else (Printf.sprintf "from %s to %s"
              (root2hostname root2) (root2hostname root1)) in
    let right =
      actionsMenu#add_item ("Propagate " ^ descl) ~key:_less
        ~callback:leftAction in
    right#add_accelerator _less ~modi:[`SHIFT] ~group:accel_group;

    actionsMenu#add_item "Do not propagate changes" ~key:_slash
      ~callback:questionAction;
    ()
    );

  (**********************************************************************)
  (* Add commands to the File menu                                      *)
  (**********************************************************************)
  fileMenu#add_item "Proceed" ~key:_g
    ~callback:(fun () -> getLock synchronize);

  fileMenu#add_item detectCmdName ~key:_r ~callback:detectCmd;

  fileMenu#add_check_item "Make backups"
    ~active:(Prefs.readPref Transport.backups)
    ~callback:(fun b -> Prefs.setPref Transport.backups Prefs.TempSetting b);

  fileMenu#add_check_item "Trace" ~active:(Prefs.readPref Trace.printTrace)
    ~callback:
    begin fun b ->
      Prefs.setPref Trace.printTrace Prefs.TempSetting b;
      if b then traceWindow#misc#show ()
      else traceWindow#misc#hide ()
    end;

(*
  fileMenu#add_check_item "Ignore files" active:(not !Ignore.noignore)
    callback: begin fun b ->
      Ignore.noignore := not b;
      Globals.propagatePrefs();
      if !Ignore.noignore then
        (* We are no longer ignoring files; we must re-detect *)
        detectUpdatesAndReconcile false
      else
          (* We are now ignoring files; we don't need to re-detect,
             we just need to filter out files which should now be
             ignored. *)
        ignoreAndRedisplay()
    end;
*)

  fileMenu#add_item "Exit" ~key:_q ~callback:safeExit;

  (**********************************************************************)
  (* Ask the Remote module to call us back at regular intervals during  *)
  (* long network operations.                                           *)
  (**********************************************************************)
  Remote.tickProc := Some gtk_sync;

  (**********************************************************************)
  (* Set things up to initialize the client/server connection and       *)
  (* detect updates after the ui is displayed.                          *)
  (* This makes a difference when the replicas are large and it takes   *)
  (* a lot of time to detect updates.                                   *)
  (**********************************************************************)
  ignore(Timeout.add 1   (* = 1 millisecond *)
           ~callback:(fun () ->
             begin  try
               let successful =
                 Uicommon.uiInit
                   (fun () -> profileSelect toplevelWindow)
                   (fun () -> rootSelect toplevelWindow)
                   (fun () -> status "Contacting server...") in
               if not successful then exit 1;
               invokeDisplayHooks();
               detectCmd()
             with Fatal err ->
               fatalError err
             | exn ->
                 fatalError
                   (Printf.sprintf
                      "There was an unexpected fatal error: %s"
                      (Printexc.to_string exn))
             end;
             false));
 
  (**********************************************************************)
  (* Display the ui                                                     *)
  (**********************************************************************)
  toplevelWindow#connect#destroy ~callback:safeExit;
  toplevelWindow#show ();
  Util.warnPrinter := Some (fun message -> warnBox ~title:"Warning" ~message);
  displayMessage "Starting up...";
  Main.main ()

end (* module Private *)

(**********************************************************************)
(*                               MODULE MAIN                          *)
(**********************************************************************)

module Body : Uicommon.UI = struct

let start = function
    Text -> Uitext.Body.start Text
  | Graphic -> Private.start Graphic

end (* module Body *)

(* $I1: Unison file synchronizer: src/uitk.ml $ *)
(* $I2: Last modified by bcpierce on Tue, 31 Aug 1999 11:42:29 -0400 $ *)
(* $I3: Copyright 1999 $ *)

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
  lazy (Gdk.Font.load "-*-Clean-Medium-R-Normal--*-130-*-*-*-60-*-*")
let fontMonospaceBold =
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
                   mutable whatHappened : confirmation option }
let theState = ref None

let filterIgnoreStateItems sIList =
 List.filter sIList pred:(fun sI -> not (Ignore.test sI.ri.path))

let detector1 = ref None
let detector2 = ref None
let current = ref None
let busy = ref false

(**********************************************************************)
(* Useful regular expressions                                         *)
(**********************************************************************)

let pathRegExp path = Str.quote (path2indepString path)

let nameRegExp path =
  try
    let name = List.hd (List.rev path) in
    let theString = name2string name in
    "\\(.*/\\|\\)" ^ (Str.quote theString)
  with Failure "hd" -> raise(Failure "nameRegExp")

let extRegExp path =
  try
    let name = List.hd (List.rev path) in
    let theString = name2string name in
    let pos = String.index theString char:'.' in
    let ext = String.sub theString pos:(pos + 1)
        len:(String.length theString - pos -1) in
    ".*\\." ^ (Str.quote ext)
  with Failure "hd"
  | Not_found -> raise(Failure "extRegExp")

(**********************************************************************)
(* Some widgets							      *)
(**********************************************************************)

class scrolled_text ?:editable ?:word_wrap ?:width ?:height ?:packing ?:show =
  let hbox = new GPack.hbox ?:width ?:height ?:packing show:false in
  let scrollbar = new GRange.scrollbar `VERTICAL
      packing:(hbox#pack from:`END expand:false) in
  let text = new GEdit.text vadjustment:scrollbar#adjustment
      ?:editable ?:word_wrap packing:hbox#add in
  object
    inherit GObj.widget_wrapper hbox#as_widget
    method scrollbar = scrollbar
    method text = text
    method insert s ?:font [< fontMonospaceMedium >] =
      text#insert ?s ?font:(Some (Lazy.force font))
    method show () = hbox#misc#show ()
    initializer
      if show <> Some false then hbox#misc#show ()
  end

let gtk_sync () = while Glib.Main.iteration false do () done

(**********************************************************************)
(* Create the toplevel window                                         *)
(**********************************************************************)
let start () =
  (* Initialize the library *)
  Main.init ();

  let toplevelWindow = new GWindow.window wm_name:myName in
  let toplevelVBox = new GPack.vbox packing:toplevelWindow#add in

  (**********************************************************************)
  (* Function to display a message in a new window                      *)
  (**********************************************************************)
  let messageBox title message =
    begin
      (* Create a new toplevel window *)
      let t = new GWindow.dialog :title wm_name:title in
      (* Create the dismiss button *)
      let t_dismiss =
	new GButton.button label:"Dismiss" packing:t#action_area#add in
      t_dismiss#connect#clicked callback:t#destroy;
      (* Create the display area *)
      let t_text = new scrolled_text editable:false
	  width:500 height:200 packing:t#vbox#add in
      (* Insert text *)
      t_text#insert message;
      t#show ()
    end in

  (**********************************************************************)
  (* Create the menu bar                                                *)
  (**********************************************************************)
  let menuBar =
    new GMenu.menu_bar border_width:2 packing:(toplevelVBox#pack expand:false)
  in
  let menus = new GMenu.factory menuBar accel_mod:[] in
  let accel_group = menus#accel_group in
  toplevelWindow#add_accel_group accel_group;
  let add_submenu :label =
    new GMenu.factory (menus#add_submenu :label) :accel_group accel_mod:[]
  in
  
  (**********************************************************************)
  (* Create the menus                                                   *)
  (**********************************************************************)
  let fileMenu = add_submenu label:"File"
  and navigateMenu = add_submenu label:"Navigate"
  and ignoreMenu = add_submenu label:"Ignore"
  and helpMenu = add_submenu label:"Help" in

  (**********************************************************************)
  (* Create the main window                                             *)
  (**********************************************************************)

  let mainWindow =
    let box = new GPack.hbox height:150 packing:toplevelVBox#add in
    let sb = new GRange.scrollbar `VERTICAL
	packing:(box#pack from:`END expand:false) in
    new GList.clist columns:5 vadjustment:sb#adjustment
      titles_show:true packing:box#add
  in
  mainWindow#misc#grab_focus ();
  Array.iteri [|100; 40; 100; 40; 280|]
    fun:(fun :i :data -> mainWindow#set_column i width:data);
  let displayTitle() =
    let s = roots2string () in
    Array.iteri fun:(fun :i :data -> mainWindow#set_column i title:data)
      [| String.sub pos:0 len:12 s; "Action";
	 String.sub pos:15 len:12 s; "Status"; "Path" |]
  in
  displayTitle ();

  (**********************************************************************)
  (* Create the details window                                          *)
  (**********************************************************************)

  let detailsWindow =
    new GEdit.text editable:false height:45
      packing:(toplevelVBox#pack expand:false) in
  let displayDetails thePathString newtext =
    detailsWindow#freeze ();
    (* Delete the current text *)
    detailsWindow#delete_text start:0 end:detailsWindow#length;
    (* Insert the new text *)
    detailsWindow#insert thePathString font:(Lazy.force fontMonospaceBold);
    detailsWindow#insert "\n";
    detailsWindow#insert newtext font:(Lazy.force fontMonospaceMedium);
    (* Display text *)
    detailsWindow#thaw ()
  in

  (**********************************************************************)
  (*                       CREATE THE MESSAGE WINDOW                    *)
  (**********************************************************************)

  let messagesWindow =
    new scrolled_text editable:false packing:toplevelVBox#add show:false in

  if !Trace.printTrace then messagesWindow#show ();

  let displayMessage0 printNewline m =
    (* Concatenate the new message *)
    messagesWindow#insert m;
    if printNewline then messagesWindow#insert "\n";
    (* Text.see messagesWindowText (TextIndex(End,[])); *)
    (* Force message to be displayed immediately *)
    gtk_sync ()
  in
  let displayMessage m = displayMessage0 true m in
  let displayMessageContinue m = displayMessage0 false m in

  (* Cause any tracing messages to be printed to the messages window *)
  Trace.printer := Some displayMessageContinue;

  let trace m = (Trace.message m; Trace.message "\n") in
  let traceContinue m = Trace.message m in

  let deleteMessagesWindow() =
    messagesWindow#text#delete_text start:0 end:messagesWindow#text#length
  in

  (**********************************************************************)
  (*                       CREATE THE STATUS WINDOW                     *)
  (**********************************************************************)

  let statusWindow =
    new GMisc.statusbar packing:(toplevelVBox#pack expand:false) in
  let statusContext = statusWindow#new_context name:"status" in
  ignore (statusContext#push "");

  let displayStatus s1 s2 =
    (* Concatenate the new message *)
    let m =
      s1 ^ (String.make len:(max 2 (30 - String.length s1)) fill:' ') ^ s2 in
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

  mainWindow#connect#select_row callback:
    begin fun :row :column :event ->
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
	displayDetails (path2string a.(row).ri.path)
	  (details2string a.(row).ri)
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
              if !auto && !dir<>Conflict then loop (i+1)
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
      Succeeded -> "done    "
    | Failed _ ->  "failed  " in

  let insert i =
    let theSIArray = derefSome theState in
    if i >= Array.length theSIArray then raise DerefSome;
    let resultof i =
      match theSIArray.(i).whatHappened with
        None -> "        "
      | Some conf -> confirmation2string conf in
    (* Insert the new contents *)
    let oldPath =
      if i = 0 then emptypath else theSIArray.(i-1).ri.path in
    let s = reconItem2string oldPath theSIArray.(i).ri (resultof i) in
    mainWindow#insert row:i
      [ String.sub pos:0 len:8 s;
	String.sub pos:9 len:5 s;
	String.sub pos:15 len:8 s;
	String.sub pos:24 len:8 s;
	String.sub pos:33 len:(String.length s - 33) s ];
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
    mainWindow#remove i;
    (* Insert the new text *)
    try insert i with DerefSome -> ()
  in

  (**********************************************************************)
  (*                         FUNCTION DISPLAY ERROR MESSAGE             *)
  (**********************************************************************)

  let displayErrorMessage errorMessage =
    (* Create a new toplevel window *)
    let dialog = new GWindow.dialog title:"Error" wm_name:"Error" modal:true in
    let _ =
      new GMisc.label packing:(dialog#vbox#pack expand:false padding:4)
       text:(sprintf "The following error occured :\n%s\n%s should be closed"
               errorMessage myName)
    in
    let ok = new GButton.button label:"OK" packing:dialog#action_area#add in
    ok#grab_default ();
    ok#connect#clicked
      callback:(fun () -> dialog#destroy (); toplevelWindow#destroy ());
    dialog#show ()
  in

  (**********************************************************************)
  (*                         FUNCTION DETECT UPDATES                    *)
  (**********************************************************************)

  let detectUpdatesAndReconcile clearMessages =
    try
      begin
        current := None;
        displayDetails "" "";
        if clearMessages then deleteMessagesWindow();
        (* displayRoots(); *)
        displayTitle();
        if not (Archive.createUnisonDir()) then
          raise (OsError "Impossible to create unison directories...");
        let r1 = List.nth !Globals.replicaRoots pos:0 in
        let r2 = List.nth !Globals.replicaRoots pos:1 in
        let t = Trace.startTimer "Looking for changes" in
        (* This can be slow, so be sure to display as much as possible first *)
        let updates = Update.findUpdates() in
        Trace.showTimer t;
        let t = Trace.startTimer "Reconciling" in
        let reconItemList = Recon.reconcileAll updates in
        Trace.showTimer t;
        let reconItemList = filterIgnore reconItemList in
        let theLength = List.length reconItemList in
        if theLength = 0 then begin
          Trace.status "Everything is up to date";
          theState := None end
        else begin
          Trace.status ("Check and/or adjust selected actions; "
                        ^ "then press Proceed");
          theState :=
	    Some(Array.of_list
                   (List.map reconItemList
                      fun:(fun ri -> { ri = ri; whatHappened = None })))
	end;
        displayMain()
      end
    with
      someError -> let errorMessage = exn2string someError in
      displayErrorMessage errorMessage
  in

  (**********************************************************************)
  (*                       FUNCTION TO ASK FOR NEW ROOTS                *)
  (**********************************************************************)

  let getRoots() =
    let t =
      new GWindow.dialog title:"Enter roots" wm_name:"Enter roots" modal:true
    in
    (* Create the display area *)
    let hbox = new GPack.hbox packing:(t#vbox#pack expand:false padding:10) in
    let label1 = new GMisc.label text:"Local root:"
	packing:(hbox#pack padding:2 expand:false) in
    let entry1 = new GEdit.entry packing:hbox#add in
    entry1#misc#grab_focus ();
    let hbox = new GPack.hbox packing:(t#vbox#pack expand:false padding:10) in
    new GMisc.label text: "Second root:"
      packing:(hbox#pack padding:2 expand:false);
    let entry2 = new GEdit.entry width:100 packing:hbox#add in
    new GMisc.label text:"with optional host:"
      packing:(hbox#pack padding:2 expand:false);
    let entry3 = new GEdit.entry width:100 packing:hbox#add in
    let go () =
      if entry1#text = "" || entry2#text = "" then () else
      let root1 = (Local, string2fspath entry1#text) in
      let fspath2 = string2fspath entry2#text in
      let host2 = entry3#text in
      let root2 =
        if (compare host2 "" = 0) then
          (Local, fspath2)
        else (Remote host2, fspath2)
      in
      Globals.replicaRoots := [root1; root2];
      detectUpdatesAndReconcile true;
      t#destroy ()
    in
    let goButton = new GButton.button label: "Go!" packing:t#action_area#add in
    goButton#connect#clicked callback:go;
    goButton#grab_default ();
    List.iter [entry1;entry2;entry2]
      fun:(fun (e : GEdit.entry) -> ignore (e#connect#activate callback:go));
    let dismiss =
      new GButton.button label: "Dismiss" packing:t#action_area#add in
    dismiss#connect#clicked callback:t#destroy;
    dismiss#misc#set_can_default true;
    t#show ()
  in

  (**********************************************************************)
  (* Function to ask for editing preferences                            *)
  (**********************************************************************)

  let editPreferences() =
    displayErrorMessage "Not implemented"
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

  let yesOrNo :title :message yes:yesFunction no:noFunction =
    (* Create a new toplevel window *)
    let t = new GWindow.dialog :title wm_name:title modal:true in
    let theLabel = new GMisc.label text:message
	packing:(t#vbox#pack expand:false padding:4) in
    let yes = new GButton.button label:"Yes" packing:t#action_area#add
    and no = new GButton.button label:"No" packing:t#action_area#add in
    yes#connect#clicked callback:(fun () -> t#destroy(); yesFunction());
    no#connect#clicked callback:(fun () -> t#destroy(); noFunction());
    t#show ()
  in

  (**********************************************************************)
  (* The ignore dialog                                                  *)
  (**********************************************************************)
(*
  let ignoreDialog() =
    begin
      let t = Toplevel.create toplevelWindow [] in
      Wm.title_set t "Ignore";
      Wm.iconname_set t "Ignore";
      let f1 = Frame.create t [] in
      let f2 = Frame.create t [] in
      let f3 = Frame.create t [] in
      pack [f1] [Side Side_Top; Fill Fill_Both; Expand true];
      pack [f2] [Side Side_Top; Fill Fill_X];
      pack [f3] [Side Side_Top; Fill Fill_X];
      let regExpWindow = Frame.create f1 [] in
      pack [regExpWindow] [Side Side_Left; Fill Fill_Both; Expand true];
      let regExpWindowText = Text.create regExpWindow
          [ TextHeight 6;
            Font fontMonospaceMedium;
            Wrap(WrapNone);     (* Don't wrap text *)
            SetGrid true;       (* Resizing will be in units of characters *)
            Cursor(XCursor ""); (* Use the default (arrow) cursor *)
            Foreground colorUsual;
            Background colorBackground;
          ] in
      pack [regExpWindowText]
        [Side Side_Left;Expand true;Fill Fill_Both];
      let regExpWindowScrollbar = Scrollbar.create regExpWindow
          [ScrollCommand (Text.yview regExpWindowText)] in
      Text.configure regExpWindowText
        [YScrollCommand(Scrollbar.set regExpWindowScrollbar)];
      pack [regExpWindowScrollbar]
        [Side Side_Right; Fill Fill_Y];
      (* Local copy of the regular expressions; the global copy will
         not be changed until the Apply button is pressed *)
      let theRegexps = ref(Ignore.extern()) in
      let numRegexps = ref(List.length !theRegexps) in
      let currentRegexp = (* A number from 0 to numRegexps-1 *)
        ref(if !numRegexps>0 then Some 0 else None) in
      let maybeGettingBigger = ref false in
      let maybeGettingSmaller = ref false in
      let deselect i =
        Text.tag_configure regExpWindowText (tag i)
          [ Foreground colorUsual;
            Background colorBackground;
          ] in
      let select i =
        begin
          (try deselect(derefSome currentRegexp) with DerefSome -> ());
          Text.tag_configure regExpWindowText (tag i)
            [ Foreground colorForegroundHighlight;
              Background colorBackgroundHighlight;
            ];
          currentRegexp := Some i;
          Text.see regExpWindowText (TextIndex(TagFirst(tag i),[]));
        end in
      let next() =
        begin
          try
            let x = derefSome currentRegexp + 1 in
            if !numRegexps>x then select x
          with DerefSome ->
            if !numRegexps>0 then begin
              currentRegexp := Some 0;
              select 0
            end
        end in
      let prev() =
        begin
          try
            let x = derefSome currentRegexp - 1 in
            if x>=0 & !numRegexps>x then select x
          with DerefSome ->
            if !numRegexps>0 then begin
              currentRegexp := Some(!numRegexps-1);
              select(!numRegexps-1)
            end
        end in
      Tk.bind t [([],KeyPressDetail "Up")]
        (BindSet([],(fun _ -> prev())));
      Tk.bind t [([],KeyPressDetail "Down")]
        (BindSet([],(fun _ -> next())));

      (* Display the regexps *)
      let displayRegexps() =
        begin
          Text.configure regExpWindowText [State Normal];
          Text.tag_delete regExpWindowText
            (Text.tag_allnames regExpWindowText);
          Text.delete regExpWindowText
            (TextIndex(LineChar(1,0),[]))
            (TextIndex(End,[]));
          let theList = !theRegexps in
          let theArray = Array.of_list theList in
          for i = 0 to !numRegexps - 1 do
            Text.insert regExpWindowText (TextIndex(End,[]))
              (theArray.(i)^ "\n") [tag i];
            Text.tag_bind regExpWindowText (tag i) [([],ButtonPressDetail 1)]
              (BindSet([], (fun _ -> select i)));
          done;
          Text.configure regExpWindowText [State Disabled];
          try
            select(derefSome currentRegexp)
          with DerefSome -> ();
        end in
      displayRegexps();

      (* Configure the add frame *)
      let label1 = Label.create f2 [Text "Regular expression:"] in
      let var1 = Textvariable.create() in
      let entry1 = Entry.create f2 [TextVariable var1] in
      let addButton = Button.create f2
          [ Relief Raised;
            Text "Add";
            Command(fun () ->
              let theRegExp = Textvariable.get var1 in
              if theRegExp<>"" then begin
                Textvariable.set var1 "";
                theRegexps := theRegExp::(!theRegexps);
                numRegexps := !numRegexps + 1;
                currentRegexp := None;
                maybeGettingSmaller := true;
                displayRegexps();
              end)] in
      pack [label1;entry1;addButton]
        [Side Side_Left;PadX(Pixels 4);PadY(Pixels 4)];
      Focus.set entry1;
      (* Configure the delete button *)
      let deleteButton = Button.create f3
          [ Relief Raised;
            Text "Delete";
            Command(fun () ->
              try
                let x = derefSome currentRegexp in
                (* After a deletion, updates must be detected again *)
                maybeGettingBigger := true;
                (* Delete xth regexp *)
                let rec loop l i =
                  match l with
                    [] -> []
                  | hd::tl ->
                      if i<=0 then tl
                      else hd::(loop tl (i-1)) in
                theRegexps := loop (!theRegexps) x;
                numRegexps := !numRegexps - 1;
                if !numRegexps<=0 then
                  (numRegexps := 0; currentRegexp := None)
                else if x >= !numRegexps
                    then currentRegexp := Some(!numRegexps-1);
                (* Make the text editable *)
                Text.configure regExpWindowText [State Normal];
                (* Delete line x *)
                Text.delete regExpWindowText
                  (TextIndex(TagFirst(tag x),[]))
                  (TextIndex(TagLast(tag x),[]));
                (* Adjust tags *)
                for y = x to !numRegexps-1 do
                  Text.tag_add regExpWindowText (tag y)
                    (TextIndex(TagFirst(tag(y+1)),[]))
                    (TextIndex(TagLast(tag(y+1)),[]));
                  Text.tag_delete regExpWindowText [tag(y+1)];
                done;
                (* Disable editing *)
                Text.configure regExpWindowText [State Disabled];
                (* Adjust highlight *)
                select (derefSome currentRegexp);
              with DerefSome
              | Failure "nth" -> ())
          ] in
      pack [deleteButton] [Side Side_Left;PadX(Pixels 8);PadY(Pixels 4)];

      (* A function to refresh the state and ignore list *)
      let refresh() =
        begin
          Ignore.intern(!theRegexps);
          if !maybeGettingBigger || !maybeGettingSmaller then
            (Ignore.save(); Globals.propagatePrefs());
          if !maybeGettingBigger then detectUpdatesAndReconcile false
          else if !maybeGettingSmaller then begin
            try
              let theSIArray = derefSome theState in
              let theSIList = Array.to_list theSIArray in
              let theSIList = filterIgnoreStateItems theSIList in
              let theSIArray = Array.of_list theSIList in
              theState := Some theSIArray;
              displayMain()
            with DerefSome -> ()
          end;
          maybeGettingBigger := false;
          maybeGettingSmaller := false;
        end in

      (* Install the main buttons *)
      let applyButton = Button.create f3
          [ Relief Raised;
            Text "Apply";
            Command refresh ] in
      let cancelButton = Button.create f3
          [ Relief Raised;
            Text "Cancel";
            Command(fun () -> Tk.destroy t) ] in
      let okButton = Button.create f3
          [ Relief Raised;
            Text "OK";
            Command(fun () -> refresh(); Tk.destroy t) ] in
      pack [applyButton;cancelButton;okButton]
        [Side Side_Left;PadX(Pixels 4)];
  end in
*)
  (**********************************************************************)
  (*                         SAFE EXIT FUNCTION                         *)
  (**********************************************************************)

  let safeExit() =
    if not !busy then begin
     Remote.shutDown(); Main.quit ()
    end else
      yesOrNo title:"prematured exit"
        message:"Some application is running, exit anyway ?"
        yes:(fun () -> Remote.shutDown(); Main.quit ())
        no:(fun () -> ())
  in

  (**********************************************************************)
  (* Add a command to obtain new roots to the File menu                 *)
  (**********************************************************************)

  fileMenu#add_item label: "New roots"
    callback:(fun () -> getLock getRoots);

  (**********************************************************************)
  (* Add entries to the Help menu                                       *)
  (**********************************************************************)
  let addDocSection (shortname, (name, docstr)) =
    if shortname<>"" && name<>"" then
      ignore (helpMenu#add_item label:name
		callback:(fun () -> messageBox name docstr))
  in

  List.iter fun:addDocSection Strings.docs;

  (**********************************************************************)
  (* Add entries to the Ignore menu                                     *)
  (**********************************************************************)
  let addRegExp theRegExp =
    begin
      let theRegExps = theRegExp::(Ignore.extern()) in
      Ignore.intern theRegExps;
      Ignore.save();
      (* Make sure the server has the same ignored paths (in case, for
         example, we do a "rescan") *)
      Globals.propagatePrefs(); 
      try
        let theSIArray = derefSome theState in
        let theSIList = Array.to_list theSIArray in
        let theSIList = filterIgnoreStateItems theSIList in
        let theSIArray = Array.of_list theSIList in
        theState := Some theSIArray;
        displayMain()
      with DerefSome -> ()
    end in
  
  let addRegExpByPath pathfunc =
    try
      let i = derefSome current in
      let a = derefSome theState in
      let theRI = a.(i).ri in
      let thePath = theRI.path in
      addRegExp (pathfunc thePath);
      current := None;
      displayDetails "" ""
    with
      DerefSome
    | Failure "nameRegExp"
    | Failure "extRegExp" -> () in

  ignoreMenu#add_item label:"Ignore this file" key:_i
    callback:(fun () -> getLock (fun () -> addRegExpByPath pathRegExp));

  ignoreMenu#add_item label:"Ignore files with this extension" key:_E
    callback:(fun () -> getLock (fun () -> addRegExpByPath extRegExp));

  ignoreMenu#add_item label:"Ignore files with this name" key:_N
    callback:(fun () -> getLock (fun () -> addRegExpByPath extRegExp));

(*
  ignoreMenu#add_item label:"Edit ignore patterns" callback:
    begin fun () ->
      getLock (fun () -> try ignoreDialog() with DerefSome -> ())
    end;
*)
 
  (**********************************************************************)
  (* Add an Edit command to the Preferences menu                        *)
  (**********************************************************************)
  (*
  Menu.add_command prefMenu
    [ Label "Edit";
      Font fontBold;
      Command (fun () -> getLock(fun () -> editPreferences()))];
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
          | Succeeded -> ()
          | Failed s -> displayMessage ("Failure: " ^ s)
        end
      done;

      Trace.showTimer t;
      Trace.status "Updating synchronizer state";
      let t = Trace.startTimer "Updating synchronizer state" in

      let stateItemList = Array.to_list theSIArray in
      let rIConfList =
        List.map stateItemList fun:
          begin fun sI ->
            match sI.whatHappened with
              None -> raise(Can'tHappen("uitk","synchronize"))
            | Some conf -> (sI.ri, conf)
	  end
      in
      let pathList = Recon.selectPath rIConfList in
      let lastResult = Update.markUpdated pathList in
      List.iter lastResult fun:
        begin function
            Succeeded -> ()
          | Failed errorString -> displayMessage errorString
	end;
      Trace.showTimer t;
      Trace.status "Synchronization complete";
    with DerefSome ->
      (* BCPFIX: This looks like a rather dirty way to tell that there's
         nothing to synchronize! *)
      (* TJIMCOMMENT: I am shocked!! Shocked, I say!! *)
      Trace.status "Nothing to synchronize";
    | someError ->
      let errorMessage = exn2string someError in
      displayErrorMessage errorMessage in

  (**********************************************************************)
  (*                  CREATE THE ACTION BAR                             *)
  (**********************************************************************)

  let actionBar = new GButton.toolbar
      orientation:`HORIZONTAL tooltips:true space_size:10
      packing:(toplevelVBox#pack expand:false) in

  (**********************************************************************)
  (*         CREATE AND CONFIGURE THE QUIT BUTTON                       *)
  (**********************************************************************)

  actionBar#insert_space;
  let _ = actionBar#insert_button text:"Quit" callback:safeExit in

  (**********************************************************************)
  (*         CREATE AND CONFIGURE THE PROCEED BUTTON                    *)
  (**********************************************************************)

  if not !batch then begin
    actionBar#insert_space;
    ignore (actionBar#insert_button text:"Proceed"
	      tooltip:"Proceed with displayed actions"
	      callback:(fun () -> getLock synchronize))
  end; 

  (**********************************************************************)
  (*           CREATE AND CONFIGURE THE RESCAN BUTTON                   *)
  (**********************************************************************)

  let detectCmdName = if !batch then "Synchronize again" else "Restart" in
  let detectCmd () = 
    getLock (fun () -> detectUpdatesAndReconcile false);
    if !batch then (batch := false; synchronize())
  in
  actionBar#insert_space;
  let detectButton =
    actionBar#insert_button text:detectCmdName callback:detectCmd in

  (**********************************************************************)
  (* Buttons for <--, -->, ????                                         *)
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

  if not !batch then begin
    actionBar#insert_space;
    actionBar#insert_button text:"<--" callback:leftAction;
    actionBar#insert_space;
    actionBar#insert_button text:"-->" callback:rightAction;
    actionBar#insert_space;
    actionBar#insert_button text:"????" callback:questionAction;
    ()
  end;

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
            (fun title text -> messageBox title text)
            Trace.status
	with DerefSome -> ()
      end
  in
  actionBar#insert_space;
  let diffButton = actionBar#insert_button text:"Diff" callback:diffCmd in

  fileMenu#add_item label:"Show diffs" key:_d callback:diffCmd;

  (**********************************************************************)
  (* Configure keyboard commands                                        *)
  (**********************************************************************)

  mainWindow#connect#event#key_press after:true callback:
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
  let root1 = try root2hostname(List.nth !Globals.replicaRoots pos:0)
              with Failure(_) -> "??" in
  let root2 = try root2hostname(List.nth !Globals.replicaRoots pos:1)
              with Failure(_) -> "??" in

  let descr = if root1=root2 then "left to right"
              else ("from "^root1^" to "^root2) in
  let left =
    navigateMenu#add_item label:("Propagate " ^ descr) key:_greater
      callback:rightAction in
  left#add_accelerator accel_group key:_greater mod:[`SHIFT];

  let descl = if root1=root2 then "right to left"
              else ("from "^root2^" to "^root1) in
  let right =
    navigateMenu#add_item label:("Propagate " ^ descl) key:_less
      callback:leftAction in
  right#add_accelerator accel_group key:_less mod:[`SHIFT];

  navigateMenu#add_item label:"Do not propagate changes" key:_slash
    callback:questionAction;

  (**********************************************************************)
  (* Add commands to the File menu                                      *)
  (**********************************************************************)
  fileMenu#add_item label:"Proceed" key:_g
    callback:(fun () -> getLock synchronize);

  fileMenu#add_item label:detectCmdName key:_r callback:detectCmd;

  fileMenu#add_check_item label:"Make backups" active:!Transport.backups
    callback:(fun b -> Transport.backups := b);

  fileMenu#add_check_item label:"Trace" active:!Trace.printTrace callback:
    begin fun b ->
      Trace.printTrace := b;
      if !Trace.printTrace then messagesWindow#misc#show ()
      else messagesWindow#misc#hide ()
    end;

  fileMenu#add_check_item label:"Ignore files" active:(not !Ignore.noignore)
    callback: begin fun b ->
      Ignore.noignore := not b;
      Globals.propagatePrefs();
      if !Ignore.noignore then
        (* We are no longer ignoring files; we must re-detect *)
        detectUpdatesAndReconcile false
      else try
          (* We are now ignoring files; we don't need to re-detect,
             we just need to filter out files which should now be
             ignored. *)
        let theSIArray = derefSome theState in
        let theSIList = Array.to_list theSIArray in
        let theSIList = filterIgnoreStateItems theSIList in
        let theSIArray = Array.of_list theSIList in
        theState := Some theSIArray;
        displayMain()
      with DerefSome -> ()
    end;

  fileMenu#add_item label:"Exit" key:_q callback:safeExit;

  (**********************************************************************)
  (* Ask the Remote module to call us back at regular intervals during  *)
  (* long network operations.                                           *)
  (**********************************************************************)
  Remote.tickProc := Some gtk_sync;

  (**********************************************************************)
  (* Set things up to detect updates after the ui is displayed.         *)
  (* This makes a difference when the replicas are large and it takes   *)
  (* a lot of time to detect updates.                                   *)
  (**********************************************************************)
  ignore(Timeout.add 1   (* = 1 millisecond *)
           callback:(fun () -> detectCmd (); false));
 
  (**********************************************************************)
  (* Display the ui                                                     *)
  (**********************************************************************)
  toplevelWindow#connect#destroy callback:safeExit;
  toplevelWindow#show ();
  Main.main ()

end (* module Graphical *)

(**********************************************************************)
(*                               MODULE MAIN                          *)
(**********************************************************************)

module Body : Uicommon.UI = struct

  let start() =
  match !interface with
    Text -> Uitext.Body.start()
  | Graphic -> Private.start()

end (* module Body *)

(* $Id$ *)

open GMain
open Printf

let file_dialog :title :callback ?:filename =
  let sel =
    new GWindow.file_selection :title modal:true ?:filename in
  sel#cancel_button#connect#clicked callback:sel#destroy;
  sel#ok_button#connect#clicked callback:
    begin fun () ->
      let name = sel#get_filename in
      sel#destroy ();
      callback name
    end;
  sel#show ()

let w = new GWindow.window title:"Okaimono"
let vb = new GPack.vbox packing:w#add

let menubar = new GMenu.menu_bar packing:(vb#pack expand:false)
let factory = new GMenu.factory menubar
let file_menu = factory#add_submenu label:"File"
let edit_menu = factory#add_submenu label:"Edit"

let sw = new GFrame.scrolled_window height:200 packing:vb#add
    hpolicy:`AUTOMATIC vpolicy:`AUTOMATIC
let vp = new GFrame.viewport width:340
    shadow_type:`NONE packing:sw#add
let vb = new GPack.vbox packing:vp#add
let _ =
  vb#focus#set_vadjustment vp#vadjustment
let titles = new GPack.hbox packing:(vb#pack expand:false)

let entry_list = ref []

let add_entry () =
  let hb = new GPack.hbox packing:(vb#pack expand:false) in
  let entry =
    List.map [40;200;40;60]
      fun:(fun width -> new GEdit.entry packing:hb#add :width)
  in entry_list := entry :: !entry_list

let _ =
  List.iter2 ["Number";"Name";"Count";"Price"] [40;200;40;60] fun:
    begin fun text width ->
      let frame =
	new GFrame.frame shadow_type:`OUT packing:titles#add :width in
      ignore (new GMisc.label :text packing:frame#add)
    end;
  for i = 1 to 9 do add_entry () done

let split :sep s =
  let len = String.length s in
  let rec loop pos =
    let next =
      try String.index_from :pos char:sep s with Not_found -> len
    in
    let sub = String.sub s :pos len:(next-pos) in
    if next = len then [sub] else sub::loop (next+1)
  in loop 0

let load name =
  try
    let ic = open_in file:name in
    List.iter !entry_list
      fun:(fun l -> List.iter l fun:(fun e -> e#set_text ""));
    let entries = Stack.create () in
    List.iter !entry_list fun:(Stack.push on:entries);
    try while true do
      let line = input_line ic in
      let fields = split sep:'\t' line in
      let entry =
	try Stack.pop entries
	with Stack.Empty ->
	  add_entry (); List.hd !entry_list
      in
      List.fold_left fields acc:entry fun:
	begin fun field :acc ->
	  (List.hd acc)#set_text field;
	  List.tl acc
	end
    done
    with End_of_file -> close_in ic
  with Sys_error _ -> ()
    

let save name =
  try
    let oc = open_out file:name in
    List.iter (List.rev !entry_list) fun:
      begin fun entry ->
	let l = List.map entry fun:(fun e -> e#text) in
	if List.exists l pred:((<>) "") then
	  let rec loop = function
	      [] -> ()
	    | [x] -> fprintf to:oc "%s\n" x
	    | x::l -> fprintf to:oc "%s\t" x; loop l
	  in loop l
      end;
    close_out oc
  with Sys_error _ -> ()

open GdkKeysyms

let _ =
  w#connect#destroy callback:Main.quit;
  w#connect#event#key_press callback:
    begin fun ev ->
      let key = GdkEvent.Key.keyval ev in
      if key = _Page_Up then
	vp#vadjustment#set_value (vp#vadjustment#value -. 20.)
      else if key = _Page_Down then
	vp#vadjustment#set_value (vp#vadjustment#value +. 20.);
      false
    end;
  w#add_accel_group factory#accel_group;
  let ff = new GMenu.factory file_menu accel_group:factory#accel_group in
  ff#add_item key:_O label:"Open..."
    callback:(fun () -> file_dialog title:"Open data file" callback:load);
  ff#add_item key:_S label:"Save..."
    callback:(fun () -> file_dialog title:"Save data" callback:save);
  ff#add_separator ();
  ff#add_item key:_Q label:"Quit" callback:w#destroy;
  let ef = new GMenu.factory edit_menu accel_group:factory#accel_group in
  ef#add_item key:_A label:"Add line" callback:add_entry;
  w#show ();
  Main.main ()

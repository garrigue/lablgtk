(* $Id$ *)

open GdkKeysyms
open GMain
open GObj

let create_bbox direction title spacing child_w child_h layout =
  let frame = GFrame.frame label: title () in
  let bbox = GPack.button_box direction border_width: 5 packing: frame#add 
      layout: layout child_height: child_h child_width: child_w
      spacing: spacing () in
  GButton.button label: "OK"     packing: bbox#add ();
  GButton.button label: "Cancel" packing: bbox#add ();
  GButton.button label: "Help"   packing: bbox#add ();
  frame#coerce

let create_button_box =
  let rw = ref None in
  let aux () =
    match !rw with
    | None ->
	let window = GWindow.window title: "Button Boxes" border_width: 0 () in
	rw := Some window;
	window #connect#destroy callback:(fun _ -> rw := None);

	let main_vbox = GPack.vbox packing: (window#add) () in

	let frame_horz = GFrame.frame label: "Horizontal Button Boxes"
	    packing: (main_vbox#pack padding: 10) () in
	
	let vbox = GPack.vbox border_width: 10 packing: frame_horz#add () in
	
	vbox#pack (create_bbox `HORIZONTAL "Spread" 40 85 20 `SPREAD);
	vbox#pack (create_bbox `HORIZONTAL "Edge"   40 85 20 `EDGE)  padding: 5;
	vbox#pack (create_bbox `HORIZONTAL "Start"  40 85 20 `START) padding: 5;
	vbox#pack (create_bbox `HORIZONTAL "End"    40 85 20 `END)   padding: 5;

	let frame_vert = GFrame.frame label: "Vertical Button Boxes"
	    packing: (main_vbox#pack padding: 10) () in
	
	let hbox = GPack.hbox border_width: 10 packing: frame_vert#add () in
	hbox#pack (create_bbox `VERTICAL "Spread" 30 85 20 `SPREAD);
	hbox#pack (create_bbox `VERTICAL "Edge"   30 85 20 `EDGE)  padding: 5;
	hbox#pack (create_bbox `VERTICAL "Start"  30 85 20 `START) padding: 5;
	hbox#pack (create_bbox `VERTICAL "End"    30 85 20 `END)   padding: 5;
	window #show ()	

    | Some window -> window #destroy ()
in aux


let button_window button _ =
  if button #misc#visible then
    button #misc#hide ()
  else
    button #misc#show ()

let create_buttons =
  let rw = ref None in
  let aux () =
    match !rw with
    | None ->
	let window = GWindow.window title: "GtkButton" border_width: 0 () in
	rw := Some window;
	window #connect#destroy callback:(fun _ -> rw := None);

	let box1 = GPack.vbox packing:window#add () in
	
	let table = GPack.table rows:3 columns:3 homogeneous:false 
	    row_spacings:3 col_spacings:3 border_width:10
	    packing:box1#pack () in

	let button = Array.create len:9 (GButton.button label:"button1" ()) in
	for i = 2 to 9 do
	  button.(i-1) <- GButton.button label:("button" ^ string_of_int i) ();
	done;

	let f i l r t b =
	  button.(i) #connect#clicked callback:(button_window button.(i+1));
	  table #attach button.(i)#coerce left:l right:r top:t bottom:b
	    xpadding:0 ypadding:0
	in
	f 0 0 1 0 1;
	f 1 1 2 1 2;
	f 2 2 3 2 3;
	f 3 0 1 2 3;
	f 4 2 3 0 1;
	f 5 1 2 2 3;
	f 6 1 2 0 1;
	f 7 2 3 1 2;
	button.(8) #connect#clicked callback:(button_window button.(0)); 
	table #attach button.(8)#coerce left:0 right:1 top:1 bottom:2
	  xpadding:0 ypadding:0;

	GMisc.separator `HORIZONTAL packing:(box1 #pack expand: false) ();
	
	let box2 = GPack.vbox spacing: 10 border_width: 10
	    packing:(box1 #pack expand: false) () in

	let button = GButton.button label: "close" packing:box2#pack () in
	button #connect#clicked callback: window#destroy;
	button #grab_default ();
	window #show ()

    | Some window -> window #destroy ()
in aux



let create_check_buttons =
  let rw = ref None in
  let aux () =
    match !rw with
    | None ->
	let window = GWindow.window title: "GtkCheckButton"
	    border_width: 0 () in
	rw := Some window;
	window #connect#destroy callback:(fun _ -> rw := None);

	let box1 = GPack.vbox packing:window#add () in
	let box2 = GPack.vbox spacing: 10 border_width: 10
	    packing:(box1#pack expand:false) () in
	
	for i = 1 to 3 do
	  GButton.check_button label:("button" ^ (string_of_int i))
	    packing:box2#pack ();
	done;

	GMisc.separator `HORIZONTAL packing:(box1#pack expand:false) ();
	
	let box2 = GPack.vbox spacing:10 border_width:10
	    packing:(box1#pack expand:false) () in

	let button = GButton.button label: "close" packing:box2#pack () in
	button #connect#clicked callback: window#destroy;
	button #grab_default ();
	window #show ()
	
    | Some window ->  window #destroy ()
in aux


let create_radio_buttons =
  let rw = ref None in
  let aux () =
    match !rw with
    | None ->
	let window = GWindow.window title: "radio buttons"
	    border_width: 0 () in
	rw := Some window;
	window #connect#destroy callback:(fun _ -> rw := None);

	let box1 = GPack.vbox packing:window#add () in
	
	let box2 = GPack.vbox spacing:10 border_width:10 
	    packing: (box1#pack expand:false) () in
	
	let button = GButton.radio_button label:"button1"
	    packing:box2#pack () in

	let button = GButton.radio_button label:"button2" group:button#group
	    packing: box2 #pack active:true () in
	
	let button = GButton.radio_button label:"button3" group:button#group
	    packing: box2#pack () in

	GMisc.separator `HORIZONTAL packing:(box1#pack expand:false) ();
	
	let box2 = GPack.vbox spacing:10 border_width:10
	    packing: (box1#pack expand:false) () in

	let button = GButton.button label:"close" packing:box2#pack () in
	button #connect#clicked callback: window #destroy;
	button #grab_default ();
	window #show ()
	
    | Some window -> window #destroy ()
in aux


let create_toggle_buttons =
  let rw = ref None in
  let aux () =
    match !rw with
    | None ->
	let window = GWindow.window title: "GtkToggleButton"
	    border_width: 0 () in
	rw := Some window;
	window #connect#destroy callback:(fun _ -> rw := None);

	let box1 = GPack.vbox packing:window#add () in
	
	let box2 = GPack.vbox spacing:10 border_width:10
	packing:(box1#pack expand:false) () in
	
	for i = 1 to 3 do
	  GButton.toggle_button label:("button" ^ (string_of_int i))
	    packing:box2#pack ()
	done;

	GMisc.separator `HORIZONTAL packing:(box1 #pack expand: false) ();
	
	let box2 = GPack.vbox spacing: 10 border_width: 10
	    packing:(box1 #pack expand: false) () in

	let button = GButton.button label: "close" packing:box2#add () in
	button #connect#clicked callback: window#destroy;
	button #grab_default ();
	window #show ()
	
    | Some window -> window #destroy ()
in aux


(* Menus *)

let create_menu depth tearoff =
  let rec aux depth tearoff =
    let menu = GMenu.menu () and group = ref None in
    if tearoff then ignore (GMenu.tearoff_item packing: menu#append ());
    for i = 0 to 4 do
      let menuitem = GMenu.radio_menu_item ?group:!group
	  label:("item " ^ string_of_int depth ^ " - " ^ string_of_int (i+1))
	  packing:menu#append show_toggle:(depth mod 2 <> 0)
	  () in
      group := Some (menuitem #group);
      if i = 3 then menuitem #misc#set_sensitive false;
      if depth > 1 then
	menuitem #set_submenu (aux (depth-1) true)
    done;

    menu
  in aux depth tearoff


let create_menus =
let rw = ref None in
  let aux () =
    match !rw with
    | None ->
	let window = GWindow.window title: "menus"
	    border_width: 0 () in
	rw := Some window;
	window #connect#destroy callback:(fun _ -> rw := None);
	window #connect#event#delete callback:(fun _ -> true);

	let accel_group = GtkData.AccelGroup.create () in
	window #add_accel_group accel_group  ;

	let box1 = GPack.vbox packing:window#add () in

	let menubar = GMenu.menu_bar packing:(box1#pack expand:false) () in

	let menuitem = GMenu.menu_item label:"test\nline2"
	    packing: menubar#append () in
	menuitem #set_submenu (create_menu 2 true);

	let menuitem = GMenu.menu_item label:"foo"
	    packing: menubar#append () in
	menuitem #set_submenu (create_menu 3 true);

	let menuitem = GMenu.menu_item label:"bar"
	    packing: menubar#append () in
	menuitem #set_submenu (create_menu 4 true);
	menuitem #right_justify ();

	let box2 = GPack.vbox spacing:10 packing:box1#pack
	    border_width:10 () in

	let menu = create_menu 1 false in
	menu #set_accel_group accel_group;

	let menuitem = GMenu.check_menu_item label:"Accelerate Me"
	    packing:menu#append () in
	menuitem #add_accelerator group:accel_group _M
	  flags:[`VISIBLE; `SIGNAL_VISIBLE];

	let menuitem = GMenu.check_menu_item label:"Accelerator Locked"
	    packing:menu#append () in
	menuitem #add_accelerator group:accel_group _L
	  flags:[`VISIBLE; `LOCKED];

	let menuitem = GMenu.check_menu_item label:"Accelerators Frozen"
	    packing:menu#append () in
	menuitem #add_accelerator group:accel_group _F
	  flags:[`VISIBLE];
	menuitem #misc#lock_accelerators ();

	let optionmenu = GMenu.option_menu packing:box2#pack () in
	optionmenu #set_menu menu;
	optionmenu #set_history 3;

	GMisc.separator `HORIZONTAL packing:(box1#pack expand:false) ();

	let box2 = GPack.vbox spacing:10 border_width:10
	    packing:(box1#pack expand:false) () in

	let button = GButton.button label: "close" packing:box2#pack () in
	button #connect#clicked callback: window#destroy;
	button #grab_default ();
	window #show ()

    | Some window -> window #destroy ()
  in aux



(* Modal windows *)

let cmw_destroy_cb _ =
  Main.quit ()

let cmw_color parent _ =
  let csd = GWindow.color_selection_dialog modal:true
      title:"This is a modal color selection dialog" () in
  csd # set_transient_for parent;
  csd # connect#destroy callback:cmw_destroy_cb;
  csd # ok_button # connect#clicked callback:csd#destroy;
  csd # cancel_button # connect#clicked callback:csd#destroy;
  csd # show ();
  Main.main ()

let cmw_file parent _ =
  let fs = GWindow.file_selection modal:true
      title:"This is a modal file selection dialog" () in
  fs # set_transient_for parent;
  fs # connect#destroy callback:cmw_destroy_cb;
  fs # ok_button # connect#clicked callback:fs#destroy;
  fs # cancel_button # connect#clicked callback:fs#destroy;
  fs # show ();
  Main.main ()

let create_modal_window () =
  let window = GWindow.window modal:true title:"This window is modal" () in
  let box1 = GPack.vbox spacing:5 border_width:3 packing:window#add () in
  let frame1 = GFrame.frame label:"Standard dialogs in modal form"
      packing:(box1#pack padding:4) () in
  let box2 = GPack.vbox homogeneous:true spacing:5 packing:frame1#add () in
  let btnColor = GButton.button label:"Color" 
      packing:(box2#pack expand:false fill:false padding:4) ()
  and btnFile = GButton.button label:"File selection" 
      packing:(box2#pack expand:false fill:false padding:4) ()
  and btnClose = GButton.button label:"Close" 
      packing:(box2#pack expand:false fill:false padding:4) () in
  GMisc.separator `HORIZONTAL
    packing:(box1#pack expand:false fill:false padding:4) ();
  
  btnClose #connect#clicked callback:(fun _ -> window #destroy ());
  window #connect#destroy callback:cmw_destroy_cb;
  btnColor #connect#clicked callback: (cmw_color window);
  btnFile #connect#clicked callback: (cmw_file window);
  window # show ();
  Main.main ()


(* corrected bug in testgtk.c *)
let scrolled_windows_remove, scrolled_windows_clean =
  let parent = ref None and float_parent = ref None in
  let remove (scrollwin : GFrame.scrolled_window) () =
    match !parent with
    | None ->
	parent :=
	  begin try Some scrollwin#misc#parent
	  with Not_found -> None end;
	let f = GWindow.window title:"new parent" () in
	float_parent := Some f;
	f #set_default_size width:200 height:200;
	scrollwin #misc#reparent f#coerce;
	f #show ()
    | Some p ->
	scrollwin #misc#reparent p#coerce;
	match !float_parent with
	| None -> ()
	| Some f ->
	  f #destroy ();
	float_parent := None;
	parent := None
  and clean () =
    match !float_parent with
    | None -> ()
    | Some p -> p #destroy (); parent := None; float_parent := None
  in remove, clean


(* scrolled windows *)

let create_scrolled_windows =
  let rw = ref None in
  let aux () =
    match !rw with
    | None ->
	let window = GWindow.dialog title:"dialog" border_width:0 () in
	rw := Some window;
	window #connect#destroy callback:(fun  _ -> rw := None);
	window #connect#destroy callback:scrolled_windows_clean;

	let scrolled_window = GFrame.scrolled_window border_width:10
	    hpolicy: `AUTOMATIC vpolicy:`AUTOMATIC
	    packing: window#vbox#pack () in

	let table = GPack.table rows:20 columns:20 row_spacings:10
	    col_spacings:10 packing:scrolled_window#add_with_viewport () in
	table #focus#set_hadjustment (Some scrolled_window # hadjustment);
	table #focus#set_vadjustment (Some scrolled_window # vadjustment);

	for i = 0 to 19 do
	  for j=0 to 19 do
	    GButton.toggle_button
	      label:("button ("^ string_of_int i ^","^ string_of_int j ^")\n")
	      packing:(table #attach left:i top:j) ()
	  done
	done;

	let button = GButton.button label:"close"
	    packing:window#action_area#add () in
	button #connect#clicked callback:(window #destroy);
	button #grab_default ();

	let button = GButton.button label:"remove"
	    packing:window#action_area#add () in
	button #connect#clicked
	  callback:(scrolled_windows_remove scrolled_window);
	button #grab_default ();
	
	window #set_default_size width:300 height:300;
	window #show ()

    | Some window -> window #destroy ()
  in aux


(* Toolbar *)

let make_toolbar (toolbar : GButton.toolbar) window =
  let icon =
    let info =
      GdkObj.pixmap_from_xpm file:"test.xpm" window:window#misc#window () in
    fun () -> (GPix.pixmap info ())#coerce
  in

  toolbar #insert_button text:"Horizontal"
    tooltip:"Horizontal toolbar layout"
    tooltip_private:"Toolbar/Horizontal"
    icon:(icon ())
    callback:(fun _ -> toolbar #set_orientation `HORIZONTAL) ();
  
  toolbar #insert_button text:"Vertical"
    tooltip:"Vertical toolbar layout"
    tooltip_private:"Toolbar/Vertical"
    icon:(icon ())
    callback:(fun _ -> toolbar #set_orientation `VERTICAL) ();
  
  toolbar #insert_space ();
  
  toolbar #insert_button text:"Icons"
    tooltip: "Only show toolbar icons"
    tooltip_private:"Toolbar/IconsOnly"
    icon:(icon ())
    callback:(fun _ -> toolbar #set_style `ICONS) ();
  
  toolbar #insert_button text:"Text"
    tooltip: "Only show toolbar text"
    tooltip_private:"Toolbar/TextOnly"
    icon:(icon ())
    callback:(fun _ -> toolbar #set_style `TEXT) ();
  
  toolbar #insert_button text:"Both"
    tooltip: "Show toolbar icons and text"
    tooltip_private:"Toolbar/Both"
    icon:(icon ())
    callback:(fun _ -> toolbar #set_style `BOTH) ();
  
  toolbar #insert_space ();
  
  GEdit.entry packing:(toolbar #insert_widget
			 tooltip:"This is an unusable GtkEntry"
			 tooltip_private: "Hey don't click me!!!") ();
  
  toolbar #insert_button text:"Small"
    tooltip:"Use small spaces"
    tooltip_private:"Toolbar/Small"
    icon:(icon ())
    callback:(fun _ -> toolbar #set_space_size 5) ();
  
  toolbar #insert_button text:"Big"
    tooltip:"Use big spaces"
    tooltip_private:"Toolbar/Big"
    icon:(icon ())
    callback:(fun _ -> toolbar #set_space_size 10) ();
  
  toolbar #insert_space ();
  
  toolbar #insert_button text:"Enable"
    tooltip:"Enable tooltips"
    icon:(icon ())
    callback:(fun _ -> toolbar #set_tooltips true) ();
  
  toolbar #insert_button text:"Disable"
    tooltip:"Disable tooltips"
    icon:(icon ())
    callback:(fun _ -> toolbar #set_tooltips false) ();
  
  toolbar #insert_space ();
  
  toolbar #insert_button text:"Borders"
    tooltip:"Show borders"
    icon:(icon ())
    callback:(fun _ -> toolbar #set_button_relief `NORMAL) ();
  
  toolbar #insert_button text:"Borderless"
    tooltip:"Hide borders"
    icon:(icon ())
    callback:(fun _ -> toolbar #set_button_relief `NONE) ();
  
  toolbar #insert_space ();
  
  toolbar #insert_button text:"Empty"
    tooltip:"Empty spaces"
    icon:(icon ())
    callback:(fun _ -> toolbar #set_space_style `EMPTY) ();
  
  toolbar #insert_button text:"Lines"
    tooltip:"Lines in spaces"
    icon:(icon ())
    callback:(fun _ -> toolbar #set_space_style `LINE) ();
  ()
 
let create_toolbar =
  let rw = ref None in
  let aux () =
    match !rw with
    | None ->
	let window = GWindow.window title: "Toolbar test"
	    border_width: 0 allow_shrink: false allow_grow: true
	    auto_shrink: true () in
	rw := Some window;
	window #connect#destroy callback:(fun _ -> rw := None);
	window #misc #realize ();
	
	let toolbar = GButton.toolbar packing: window#add () in
	make_toolbar toolbar window;
	
	window #show ()
	  
    | Some window -> window #destroy ()
  in aux


(* Handlebox *)

let handle_box_child_signal action (hb : GFrame.handle_box) child =
  Printf.printf "%s: child <%s> %s\n" hb#get_type child#get_type action

let create_handle_box =
  let rw = ref None in
  let aux () =
    match !rw with
    | None ->
	let window = GWindow.window title: "Handle box test"
	    border_width: 20 allow_shrink: false allow_grow: true
	    auto_shrink: true () in
	rw := Some window;
	window #connect#destroy callback:(fun _ -> rw := None);
	window #misc #realize ();

	let vbox = GPack.vbox packing:window#add () in

	GMisc.label text:"Above" packing:vbox#pack ();
	GMisc.separator `HORIZONTAL packing:vbox#pack ();

	let hbox = GPack.hbox spacing:10 packing:vbox#pack () in
	GMisc.separator `HORIZONTAL packing:vbox#pack ();

	GMisc.label text:"Below" packing:vbox#pack ();
	let handle_box = GFrame.handle_box
	    packing:(hbox#pack expand:false fill:false) () in
	handle_box #connect#child_attached
	  callback:(handle_box_child_signal "attached" handle_box);
	handle_box #connect#child_detached
	  callback:(handle_box_child_signal "detached" handle_box);

	let toolbar = GButton.toolbar packing:handle_box#add () in
	make_toolbar toolbar window;
	toolbar #set_button_relief `NORMAL;

	let handle_box = GFrame.handle_box
	    packing:(hbox#pack expand:false fill:false) () in
	handle_box #connect#child_attached
	  callback:(handle_box_child_signal "attached" handle_box);
	handle_box #connect#child_detached
	  callback:(handle_box_child_signal "detached" handle_box);

	let handle_box2 = GFrame.handle_box packing:handle_box#add () in
	handle_box2 #connect#child_attached
	  callback:(handle_box_child_signal "attached" handle_box);
	handle_box2 #connect#child_detached
	  callback:(handle_box_child_signal "detached" handle_box);

	GMisc.label text:"Fooo!" packing:handle_box2#add ();
	window #show ()
	  
    | Some window -> window #destroy ()
  in aux



(* Tree *)

class tree_and_buttons () =
object
  val tree = GTree.tree ()
  val add_button = GButton.button label: "Add Item" ()
  val remove_button = GButton.button label:"Remove Item(s)" ()
  val subtree_button = GButton.button label:"Remove Subtree" ()
  val mutable nb_item_add = 0

  method tree = tree
  method add_button = add_button
  method remove_button = remove_button
  method subtree_button = subtree_button
  method nb_item_add = nb_item_add
  method incr_nb_item_add = nb_item_add <- nb_item_add + 1
end

let cb_tree_destroy_event w = ()

let cb_add_new_item (treeb : tree_and_buttons) _ =
  let subtree = match treeb#tree#selection with
  | []  -> treeb#tree
  | selected_item :: _ ->
      try selected_item#subtree
      with Not_found ->
	let t = GTree.tree () in
	selected_item#set_subtree t;
	t
  in
  let item_new = GTree.tree_item packing:(subtree#insert pos:0)
      label:("item add " ^ string_of_int treeb # nb_item_add) () in
  treeb #incr_nb_item_add


let cb_remove_item (treeb : tree_and_buttons) _  = 
  let tree = treeb#tree in
  match tree #selection with
  | [] -> ()
  |  selected -> tree #remove_items selected


let cb_remove_subtree (treeb : tree_and_buttons) _ =
  match treeb#tree #selection with
  | [] -> ()
  | selected_item :: _ ->
    try selected_item#subtree; selected_item#remove_subtree ()
    with Not_found -> ()

let cb_tree_changed (treeb : tree_and_buttons) _ =
  let tree = treeb#tree in
  let nb_selected = List.length (tree#selection) in
  if nb_selected = 0 then begin
    treeb # remove_button #misc#set_sensitive false;
    treeb # subtree_button #misc#set_sensitive false;
  end else begin
    treeb # remove_button #misc#set_sensitive true;
    treeb # subtree_button #misc#set_sensitive (nb_selected = 1);
    treeb # add_button #misc#set_sensitive (nb_selected = 1);
  end
  
  
let rec create_subtree (item : GTree.tree_item) level nb_item_max
    recursion_level_max =
  if level = recursion_level_max then ()
  else begin
    let item_subtree = GTree.tree () in
    for nb_item = 1 to nb_item_max do
      let item_new = GTree.tree_item packing:(item_subtree#insert pos:0)
	  label:("item" ^ string_of_int level ^ "-" ^ string_of_int nb_item) ()
      in
      create_subtree item_new (level + 1) nb_item_max recursion_level_max;
    done;
    item # set_subtree item_subtree
  end


let create_tree_sample selection_mode draw_line view_line no_root_item
    nb_item_max recursion_level_max =
  let window = GWindow.window title:"Tree Sample" () in
  let box1 = GPack.vbox packing:window#add () in
  let box2 = GPack.vbox packing:box1#pack border_width:5 () in
  let scrolled_win = GFrame.scrolled_window packing:box2#pack
      hpolicy: `AUTOMATIC vpolicy:`AUTOMATIC
      width:200 height:200 () in

  let root_treeb = new tree_and_buttons () in
  let root_tree = root_treeb#tree in
  root_tree #connect#selection_changed callback:(cb_tree_changed root_treeb);
  scrolled_win #add_with_viewport root_tree#coerce;
  root_tree #set_selection_mode selection_mode;
  root_tree #set_view_lines draw_line;
  root_tree #set_view_mode
    (match view_line with `LINE -> `ITEM | `ITEM -> `LINE);

  if no_root_item then
    for nb_item = 1 to nb_item_max do
      let item_new = GTree.tree_item label:("item0-" ^ string_of_int nb_item)
	  packing:(root_tree#insert pos:0) () in
      create_subtree item_new 1 nb_item_max recursion_level_max;
    done
  else begin
    let root_item = GTree.tree_item label:"root item"
	packing:(root_tree #insert pos:0) () in
    create_subtree root_item 0 nb_item_max recursion_level_max
  end;

  let box2 = GPack.vbox border_width:5
      packing:(box1#pack expand:false fill:false) () in

  let button = root_treeb #add_button in
  button #misc#set_sensitive false;
  button #connect#clicked callback:(cb_add_new_item root_treeb);
  box2 #pack button#coerce;

  let button = root_treeb #remove_button in
  button #misc#set_sensitive false;
  button #connect#clicked callback:(cb_remove_item root_treeb);
  box2 #pack button#coerce;

  let button = root_treeb #subtree_button in
  button #misc#set_sensitive false;
  button #connect#clicked callback:(cb_remove_subtree root_treeb);
  box2 #pack button#coerce;

  GMisc.separator `HORIZONTAL packing:(box1#pack expand:false fill:false) ();

  let button = GButton.button label:"Close" packing:box2#pack () in
  button #connect#clicked callback:window#destroy;

  window #show ()


let create_tree_mode_window =
  let rw = ref None in
  let aux () =
    let default_number_of_item = 3.0 in
    let default_recursion_level = 3.0 in
    let single_button = GButton.radio_button label:"SINGLE" () in
    let browse_button = GButton.radio_button
	group:single_button#group label:"BROWSE" () in
    let multiple_button = GButton.radio_button
	group:browse_button#group label:"MULTIPLE" () in
    let draw_line_button = GButton.check_button label:"Draw line" () in
    let view_line_button = GButton.check_button label:"View line mode" () in
    let no_root_item_button = GButton.check_button
	label:"Without Root item" () in
    let nb_item_spinner = GEdit.spin_button
	adjustment:(GData.adjustment value:default_number_of_item
	   lower:1.0 upper:255.0 step_incr:1.0 page_incr:5.0
	   page_size:0.0 ()) rate:0. digits:0 () in
    let recursion_spinner = GEdit.spin_button
	adjustment:(GData.adjustment value:default_recursion_level
	   lower:0.0 upper:255.0 step_incr:1.0 page_incr:5.0
	   page_size:0.0 ()) rate:0. digits:0 () in
    let cb_create_tree _ =
      let selection_mode =
	if single_button #active then `SINGLE
	else if browse_button #active then `BROWSE
	else `MULTIPLE in
      let nb_item = nb_item_spinner#value_as_int  in
      let recursion_level = recursion_spinner#value_as_int in
      create_tree_sample selection_mode (draw_line_button #active)
	(if (view_line_button #active) then `ITEM else `LINE)
	(no_root_item_button #active)
	nb_item recursion_level
    in
    match !rw with
    | None ->
	let window = GWindow.window title:"Set Tree Parameters" () in
	rw := Some window;
	window #connect#destroy callback:(fun _ -> rw := None);

	let box1 = GPack.vbox packing:(window#add) () in

	let box2 = GPack.vbox spacing:5 packing:(box1#pack)
	    border_width:5 () in

	let box3 = GPack.hbox spacing:5 packing:(box2#pack) () in

	let frame = GFrame.frame label:"Selection Mode" packing:(box3#pack) ()
	in
	
	let box4 = GPack.vbox packing:(frame#add) border_width:5 () in

	box4 #pack single_button#coerce;
	box4 #pack browse_button#coerce;
	box4 #pack multiple_button#coerce;

	let frame = GFrame.frame label:"Options" packing:(box3#pack) () in
	
	let box4 = GPack.vbox packing:(frame#add) border_width:5 () in
	box4 #pack draw_line_button#coerce;
	draw_line_button #set_active true;
	
	box4 #pack view_line_button#coerce;
	view_line_button #set_active true;
	
	box4 #pack no_root_item_button#coerce;

	let frame = GFrame.frame label:"Size Parameters" packing:box2#pack ()
	in

	let box4 = GPack.hbox spacing:5 packing:frame#add border_width:5 () in

	let box5 = GPack.hbox spacing:5 packing:(box4#pack) () in
	let label = GMisc.label text:"Number of items : " xalign:0. yalign:0.5
	  packing:(box5#pack expand:false) () in
	box5 #pack nb_item_spinner#coerce expand:false;
	
	let label = GMisc.label text:"Depth : " xalign:0. yalign:0.5
	  packing:(box5#pack expand:false) () in
	box5 #pack recursion_spinner#coerce expand:false;
	
	GMisc.separator `HORIZONTAL
	  packing:(box1#pack expand:false fill:false) ();

	let box2 = GPack.hbox homogeneous:true spacing:10
	    packing:(box1#pack expand:false fill:false)
	    border_width:5 () in

	let button = GButton.button label:"Create Tree" packing:box2#pack () in
	button #connect#clicked callback:cb_create_tree;

	let button = GButton.button label: "close" packing:(box2#pack) () in
	button #connect#clicked callback: window#destroy;
	button #grab_default ();
	window #show ()
	
    | Some window -> window #destroy ()
  in aux



(* Tooltips *)

let tips_query_widget_entered (toggle : GButton.toggle_button)
    (tq : GMisc.tips_query) _ :text private:_  =
if toggle #active then begin
  tq #set_text
    (match text with
    | None -> "There is no tip!" | Some _ -> "There is a tip!");
  tq #connect#stop_emit name:"widget_entered"
end

let tips_query_widget_selected (w : #widget option) :text private:tp _ =
  (match w with
  | None -> ()
  | Some w -> 
    Printf.printf "Help \"%s\" requested for <%s>\n"
	(match tp with None -> "None" | Some t -> t)
	(w #get_type));
   true


let create_tooltips =
  let rw = ref None in
  let aux () =
     match !rw with
    | None ->

	let window = GWindow.window title:"Tooltips"
	    border_width:0 allow_shrink:false allow_grow:false
	    auto_shrink:true () in
	rw := Some window;
	let tooltips = GData.tooltips () in
	window #connect#destroy 
	  callback:(fun _ -> tooltips #destroy ();  rw := None);

	let box1 = GPack.vbox packing:window#add () in

	let box2 = GPack.vbox spacing:10 border_width:10
	    packing:box1#pack () in

	let button = GButton.toggle_button label:"button1" packing:box2#pack ()
	in
	tooltips #set_tip button#coerce text:"This is button1"
	  private:"ContextHelp/buttons/1";
	
	let button = GButton.toggle_button label:"button2" packing:box2#pack ()
	in
	tooltips #set_tip button#coerce
	  text:"This is button 2. This is also a really long tooltip which probably won't fit on a single line and will therefore need to be wrapped. Hopefully the wrapping will work correctly."
	  private:"ContextHelp/buttons/2_long";

	let toggle = GButton.toggle_button label:"Override TipsQuery Label" 
	    packing:box2#pack () in
	tooltips #set_tip toggle#coerce text:"Toggle TipsQuery view."
	  private:"Hi msw! ;)";

	let box3 = GPack.vbox spacing:5 border_width:5 () in

	let button = GButton.button label:"[?]" 
	    packing:(box3 #pack expand:false fill:false) () in

	let tips_query = GMisc.tips_query packing:box3#add () in
	button #connect#clicked callback:(tips_query #start);

	tooltips #set_tip button#coerce text:"Start the Tooltips Inspector"
	  private:"ContextHelp/buttons/?";

	tips_query #set_caller button#coerce;
	tips_query #connect#widget_entered
	  callback:(tips_query_widget_entered toggle tips_query);
	tips_query #connect#widget_selected callback:tips_query_widget_selected;

	let frame = GFrame.frame label:"Tooltips Inspector"
	    border_width:0 packing:(box2#pack padding:10) 
	    label_xalign:0.5 label_yalign:0.0 () in
	frame #add box3#coerce;

	GMisc.separator `HORIZONTAL packing:(box1#pack expand:false) ();

	let box2 = GPack.vbox spacing: 10 border_width: 10
	    packing:(box1#pack expand:false) () in

	let button = GButton.button label: "close" packing:box2#pack () in
	button #connect#clicked callback: window#destroy;
	button #grab_default ();
	tooltips #set_tip button#coerce text:"Push this button to close window"
	  private:"ContextHelp/buttons/Close";

	window #show ();

    | Some window -> window #destroy ()
  in aux


(* Labels *)
let create_labels =
  let rw = ref None in
  let aux () =
     match !rw with
    | None ->

	let window = GWindow.window title:"Labels" border_width:5 () in
	rw := Some window;
	window #connect#destroy 
	  callback:(fun _ -> rw := None);

	let hbox = GPack.hbox spacing:5 packing:window#add () in
	let vbox = GPack.vbox spacing:5 packing:hbox#pack () in

	let frame = GFrame.frame label:"Normal Label"
	    packing:(vbox#pack expand:false fill:false) () in
	GMisc.label text:"This is a normal label" packing:frame#add ();

	let frame = GFrame.frame label:"Multi_line Label"
	    packing:(vbox#pack expand:false fill:false) () in
	GMisc.label packing:frame#add
	  text:"This is a multi-line label.\nSecond line\nThird line" ();

	let frame = GFrame.frame label:"Left Justified Label"
	    packing:(vbox#pack expand:false fill:false) () in
	GMisc.label packing:frame#add justify:`LEFT
	  text:"This is a left justified\nmulti_line label\nThird line" ();

	let frame = GFrame.frame label:"Right Justified Label"
	    packing:(vbox#pack expand:false fill:false) () in
	GMisc.label packing:frame#add justify:`RIGHT
	  text:"This is a right justified\nmulti_line label\nThird line" ();

	let vbox = GPack.vbox spacing:5 packing:hbox#pack () in

	let frame = GFrame.frame label:"Line wrapped Label"
	    packing:(vbox#pack expand:false fill:false) () in
	GMisc.label packing:frame#add line_wrap:true
	  text:"This is an example of a line-wrapped label.  It should not be taking up the entire             width allocated to it, but automatically wraps the words to fit.  The time has come, for all good men, to come to the aid of their party.  The sixth sheik's six sheep's sick.\n     It supports multiple paragraphs correctly, and  correctly   adds many          extra  spaces. " ();

	let frame = GFrame.frame label:"Underlined Label"
	    packing:(vbox#pack expand:false fill:false) () in
	GMisc.label text:"This label is underlined!\nThis one is underlined in a quite a funky fashion" packing:frame#add
	  justify:`LEFT pattern:"_________________________ _ _________ _ _____ _ __ __  ___ ____ _____" ();

	window #show ();

    | Some window -> window #destroy ()
  in aux


(* reparent *)


let set_parent child old_parent =
  let name_opt = function
    | None -> "(NULL)"
    | Some w -> w#get_type in
  Printf.printf
    "set parent for \"%s\": new parent: \"%s\", old parent: \"%s\"\n" 
    child#get_type
    (try child#misc#parent#get_type with Not_found -> "(NULL)")
    (name_opt old_parent)

let reparent_label (label : GMisc.label) new_parent _ =
  label #misc#reparent new_parent



let create_reparent =
  let rw = ref None in
  let aux () =
     match !rw with
    | None ->

	let window = GWindow.window title:"Reparent" border_width:5 () in
	rw := Some window;
	window #connect#destroy callback:(fun _ -> rw := None);

	let vbox = GPack.vbox packing:window#add () in
	let hbox = GPack.hbox spacing:5 packing:vbox#pack border_width:10 () in

	let frame = GFrame.frame label:"Frame1"  packing:hbox#pack () in
	let vbox2 = GPack.vbox spacing:5 packing:frame#add border_width:5 () in
	let label = GMisc.label text:"Hello world"
	    packing:(vbox2#pack expand:false) () in
	label #connect#parent_set callback:(set_parent label);
	let button = GButton.button label:"switch"
	    packing:(vbox2#pack expand:false) () in
	button #connect#clicked callback:(reparent_label label vbox2#coerce);

	let frame = GFrame.frame label:"Frame2"  packing:hbox#pack () in
	let vbox2 = GPack.vbox spacing:5 packing:frame#add border_width:5 () in
	let button = GButton.button label:"switch"
	    packing:(vbox2#pack expand:false) () in
	button #connect#clicked callback:(reparent_label label vbox2#coerce);

	GMisc.separator `HORIZONTAL packing:(vbox#pack expand:false) ();

	let vbox = GPack.vbox spacing:10 border_width:10
	    packing:(vbox#pack expand:false) () in

	let button = GButton.button label: "close" packing:vbox#pack () in
	button #connect#clicked callback: window#destroy;
	button #grab_default ();

	window #show ();

    | Some window -> window #destroy ()
  in aux




let create_main_window () =
  let buttons = [
    "button box", Some create_button_box;
    "buttons", Some create_buttons;
    "check buttons", Some create_check_buttons;
    "clist", None;
    "color selection", None;
    "ctree", None;
    "cursors", None;
    "dialog", None;
    "entry", None;
    "event watcher", None;
    "file selection", None;
    "font selection", None;
    "gamma curve", None;
    "handle box", Some create_handle_box;
    "item factory", None;
    "labels", Some create_labels;
    "layout", None;
    "list", None;
    "menus", Some create_menus;
    "modal windows", Some create_modal_window;
    "notebooks", None;
    "panes", None;
    "pixmap", None;
    "preview color", None;
    "preview gray", None;
    "progress bar", None;
    "radio buttons", Some create_radio_buttons;
    "range controls", None;
    "rc file", None;
    "reparent", Some create_reparent;
    "rulers", None;
    "saved position", None;
    "scrolled windows", Some create_scrolled_windows;
    "shapes", None;
    "spinbutton", None;
    "statusbar", None;
    "test idle", None;
    "test mainloop", None;
    "test scrolling", None;
    "test selection", None;
    "test timeout", None;
    "text", None;
    "toggle buttons", Some create_toggle_buttons;
    "toolbar", Some create_toolbar;
    "tooltips", Some create_tooltips;
    "tree", Some create_tree_mode_window;
    "WM hints", None
  ] in

  let window = GWindow.window title:"main window" allow_shrink:false
      allow_grow:false auto_shrink:false width:200 height:400 x:20 y:20 () in

  window #connect#destroy callback: Main.quit;

  let box1 = GPack.vbox packing: window#add () in

  GMisc.label text: "Gtk+ v1.2" packing:(box1#pack expand:false fill:false) ();

  let scrolled_window = GFrame.scrolled_window border_width: 10
      hpolicy: `AUTOMATIC vpolicy: `AUTOMATIC
      packing:box1#pack () in

  let box2 = GPack.vbox border_width: 10
      packing:scrolled_window#add_with_viewport () in
  box2 #focus#set_vadjustment (Some scrolled_window#vadjustment);

  let rec aux = function
    | [] -> ()
    | (_,     None) :: tl -> aux tl
    | (label, Some func) :: tl ->
	let button = GButton.button label: label
	    packing:(box2 #pack expand: true fill: true padding: 0) () in
	button #connect#clicked callback: func;
	aux tl
  in aux buttons;

  GMisc.separator `HORIZONTAL packing:(box1#pack expand:false) ();

  let box2 = GPack.vbox spacing: 10 border_width: 10
      packing:(box1 #pack expand: false) () in

  let button = GButton.button label: "close"  packing:box2#pack () in
  button #connect#clicked callback: window#destroy;
  button #grab_default ();

  window #show ();

  Main.main ()

let _ = create_main_window ()


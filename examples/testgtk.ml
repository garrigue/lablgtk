open GtkObj

let create_bbox direction title spacing child_w child_h layout =
  let frame = new_frame label: title in
  let bbox = new_bbox direction border_width: 5 packing: frame#add 
      layout: layout child_height: child_h child_width: child_w
      spacing: spacing in
  new_button label: "OK"     packing: bbox#add;
  new_button label: "Cancel" packing: bbox#add;
  new_button label: "Help"   packing: bbox#add;
  frame

let create_button_box =
  let rw = ref None in
  let aux () =
    match !rw with
    | None ->
	let window = new_window `TOPLEVEL title: "Button Boxes"
	    border_width: 0 in
	rw := Some window;
	window #connect#destroy callback:(fun _ -> rw := None);

	let main_vbox = new_box `VERTICAL packing: (window#add) in

	let frame_horz = new_frame label: "Horizontal Button Boxes"
	    packing: (main_vbox#pack padding: 10) in
	
	let vbox = new_box `VERTICAL border_width: 10 packing: frame_horz#add in
	
	vbox#pack (create_bbox `HORIZONTAL "Spread" 40 85 20 `SPREAD);
	vbox#pack (create_bbox `HORIZONTAL "Edge"   40 85 20 `EDGE)  padding: 5;
	vbox#pack (create_bbox `HORIZONTAL "Start"  40 85 20 `START) padding: 5;
	vbox#pack (create_bbox `HORIZONTAL "End"    40 85 20 `END)   padding: 5;

	let frame_vert = new_frame label: "Vertical Button Boxes"
	    packing: (main_vbox#pack padding: 10) in
	
	let hbox = new_box `HORIZONTAL border_width: 10
	    packing: frame_vert#add in
	hbox#pack (create_bbox `VERTICAL "Spread" 30 85 20 `SPREAD);
	hbox#pack (create_bbox `VERTICAL "Edge"   30 85 20 `EDGE)  padding: 5;
	hbox#pack (create_bbox `VERTICAL "Start"  30 85 20 `START) padding: 5;
	hbox#pack (create_bbox `VERTICAL "End"    30 85 20 `END)   padding: 5;
	window #show_all ()	

    | Some window -> window #destroy ()
in aux


let button_window (button : button) _ =
  if button #misc#visible then
    button #misc#hide ()
  else
    button # show ()

let create_buttons =
  let rw = ref None in
  let aux () =
    match !rw with
    | None ->
	let window = new_window `TOPLEVEL title: "GtkButton"
	    border_width: 0 in
	rw := Some window;
	window #connect#destroy callback:(fun _ -> rw := None);

	let box1 = new_box `VERTICAL packing:window#add in
	box1 #show ();
	
	let table = new_table rows:3 columns:3 homogeneous:false 
	    row_spacings:3 col_spacings:3 border_width:10
	    packing:box1#pack in
	table #show ();

	let button = Array.create len:9 fill:(new_button label:"button1") in
	for i = 2 to 9 do
	  button.(i-1) <- new_button label:("button" ^ (string_of_int i));
	  button.(i-1) #show ()
	done;
	button.(0) #show ();
	let f i l r t b =
	  button.(i) #connect#clicked callback:(button_window button.(i+1));
	  table #attach button.(i) left:l right:r top:t bottom:b
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
	table #attach button.(8) left:0 right:1 top:1 bottom:2
	  xpadding:0 ypadding:0;

	let separator = new_separator `HORIZONTAL in
	box1 #pack separator expand: false;
	separator #show ();
	
	let box2 = new_box `VERTICAL spacing: 10 border_width: 10 in
	box1 #pack box2 expand: false;
	box2 #show ();

	let button = new_button label: "close" packing:box2#pack in
	button #connect#clicked callback: window#destroy;
	button #grab_default ();
	button #show ();
	window #show ()

    | Some window -> window #destroy ()
in aux



let create_check_buttons =
  let rw = ref None in
  let aux () =
    match !rw with
    | None ->
	let window = new_window `TOPLEVEL title: "GtkCheckButton"
	    border_width: 0 in
	rw := Some window;
	window #connect#destroy callback:(fun _ -> rw := None);

	let box1 = new_box `VERTICAL packing:window#add in
	let box2 = new_box `VERTICAL spacing: 10 border_width: 10
	    packing:(box1#pack expand:false) in
	
	for i = 1 to 3 do
	  new_check_button label:("button" ^ (string_of_int i))
	    packing:box2#pack;
	done;

	new_separator `HORIZONTAL packing:(box1#pack expand:false);
	
	let box2 = new_box `VERTICAL spacing:10 border_width:10
	    packing:(box1#pack expand:false) in

	let button = new_button label: "close" packing:box2#pack in
	button #connect#clicked callback: window#destroy;
	button #grab_default ();
	window #show_all ()
	
    | Some window ->  window #destroy ()
in aux


let create_radio_buttons =
  let rw = ref None in
  let aux () =
    match !rw with
    | None ->
	let window = new_window `TOPLEVEL title: "radio buttons"
	    border_width: 0 in
	rw := Some window;
	window #connect#destroy callback:(fun _ -> rw := None);

	let box1 = new_box `VERTICAL packing:window#add in
	
	let box2 = new_box `VERTICAL spacing:10 border_width:10 
	    packing: (box1#pack expand:false) in
	
	let button = new_radio_button label:"button1" packing:box2#pack in

	let button = new_radio_button label:"button2" group:button#group
	    packing: box2 #pack active:true in
	
	let button = new_radio_button label:"button3" group:button#group
	    packing: box2#pack in

	new_separator `HORIZONTAL packing:(box1#pack expand:false);
	
	let box2 = new_box `VERTICAL spacing:10 border_width:10
	    packing: (box1#pack expand:false) in

	let button = new_button label:"close" packing:box2#pack in
	button #connect#clicked callback: window #destroy;
	button #grab_default ();
	window #show_all ()
	
    | Some window -> window #destroy ()
in aux


let create_toggle_buttons =
  let rw = ref None in
  let aux () =
    match !rw with
    | None ->
	let window = new_window `TOPLEVEL title: "GtkToggleButton"
	    border_width: 0 in
	rw := Some window;
	window #connect#destroy callback:(fun _ -> rw := None);

	let box1 = new_box `VERTICAL packing:window#add in
	
	let box2 = new_box `VERTICAL spacing:10 border_width:10
	packing:(box1#pack expand:false) in
	
	for i = 1 to 3 do
	  new_toggle_button label:("button" ^ (string_of_int i))
	    packing:box2#pack
	done;

	let separator = new_separator `HORIZONTAL in
	box1 #pack separator expand: false;
	
	let box2 = new_box `VERTICAL spacing: 10 border_width: 10 in
	box1 #pack box2 expand: false;

	let button = new_button label: "close" in
	button #connect#clicked callback: window#destroy;
	box2 #pack button;
	button #grab_default ();
	  window #show_all ()
	
    | Some window -> window #destroy ()
in aux


let create_menu depth tearoff =
  let rec aux depth tearoff =
    let menu = new_menu () and group = ref None in
    if tearoff then begin
      let menuitem = new_tearoff_menu_item () in
      menu #append menuitem;
      menuitem #show ()
    end;
    for i = 0 to 4 do
      let menuitem = new_radio_menu_item ?group:!group
	  label:("item " ^ (string_of_int depth) ^ " - " ^
		 (string_of_int (i+1))) in
      group := Some (menuitem #group);
      if ((depth mod 2) <> 0) then
	menuitem #set_show_toggle true;
      menu #append menuitem;
      menuitem #show ();
      if i = 3 then menuitem #misc#set sensitive:false;
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
	let window = new_window `TOPLEVEL title: "menus"
	    border_width: 0 in
	rw := Some window;
	window #connect#destroy callback:(fun _ -> rw := None);
	window #connect#event#delete callback:(fun _ -> true);

	let accel_group = Gtk.AccelGroup.create () in
	window #add_accel_group accel_group  ;

	let box1 = new_box `VERTICAL packing:window#add in
	box1 #show ();

	let menubar = new_menu_bar () packing:(box1#pack expand:false) in
	menubar #show ();

	let menuitem = new_menu_item label:"test\nline2" in
	menuitem #set_submenu (create_menu 2 true);
	menubar #append menuitem;
	menuitem #show ();

	let menuitem = new_menu_item label:"foo" in
	menuitem #set_submenu (create_menu 3 true);
	menubar #append menuitem;
	menuitem #show ();

	let menuitem = new_menu_item label:"bar" in
	menuitem #set_submenu (create_menu 4 true);
	menuitem #right_justify ();
	menubar #append menuitem;
	menuitem #show ();

	let box2 = new_box `VERTICAL spacing:10 packing:box1#pack
	    border_width:10 in
	box2 #show ();

	let menu = create_menu 1 false in
	menu #set_accel_group accel_group;

	let menuitem = new_check_menu_item label:"Accelerate Me" in
	menu #append menuitem;
	menuitem #show ();
	menuitem #add_accelerator accel_group key:'M'
	  flags:[`VISIBLE; `SIGNAL_VISIBLE];

	let menuitem = new_check_menu_item label:"Accelerator Locked" in
	menu #append menuitem;
	menuitem #show ();
	menuitem #add_accelerator accel_group key:'L'
	  flags:[`VISIBLE; `LOCKED];

	let menuitem = new_check_menu_item label:"Accelerators Frozen" in
	menu #append menuitem;
	menuitem #show ();
	menuitem #add_accelerator accel_group key:'F'
	  flags:[`VISIBLE];
	menuitem #misc#lock_accelerators ();

	let optionmenu = new_option_menu () packing:box2#pack in
	optionmenu #set_menu menu;
	optionmenu #set_history 3;
	optionmenu #show ();

	(new_separator `HORIZONTAL packing:(box1#pack expand:false))#show ();

	let box2 = new_box `VERTICAL spacing:10 border_width:10
	    packing:(box1#pack expand:false) in

	let button = new_button label: "close" packing:box2#pack in
	button #connect#clicked callback: window#destroy;
	button #grab_default ();
	button #show ();
	window #show ()

    | Some window -> window #destroy ()
  in aux

let cmw_destroy_cb _ =
  Main.quit ()

let cmw_color parent _ =
  let csd = new_color_selection_dialog
      title:"This is a modal color selection dialog" in
  csd #set_modal true;
  csd # set_transient_for parent;
  csd # connect#destroy callback:cmw_destroy_cb;
  csd # ok_button # connect#clicked callback:csd#destroy;
  csd # cancel_button # connect#clicked callback:csd#destroy;
  csd # show ();
  Main.main ()

let cmw_file parent _ =
  let fs = new_file_selection title:"This is a modal file selection dialog" in
  fs #set_modal true;
  fs # set_transient_for parent;
  fs # connect#destroy callback:cmw_destroy_cb;
  fs # ok_button # connect#clicked callback:fs#destroy;
  fs # cancel_button # connect#clicked callback:fs#destroy;
  fs # show ();
  Main.main ()

let create_modal_window () =
  let window = new_window `TOPLEVEL modal:true title:"This window is modal" in
  let box1 = new_box `VERTICAL spacing:5 border_width:3 packing:window#add in
  let frame1 = new_frame () label:"Standard dialogs in modal form"
      packing:(box1#pack padding:4) in
  let box2 = new_box `VERTICAL homogeneous:true spacing:5 packing:frame1#add in
  let btnColor = new_button () label:"Color" 
      packing:(box2#pack expand:false fill:false padding:4)
  and btnFile = new_button () label:"File selection" 
      packing:(box2#pack expand:false fill:false padding:4)
  and btnClose = new_button () label:"Close" 
      packing:(box2#pack expand:false fill:false padding:4) in
  new_separator `HORIZONTAL packing:(box1#pack expand:false fill:false padding:4);
  
  btnClose #connect#clicked callback:(fun _ -> window #destroy ());
  window #connect#destroy callback:cmw_destroy_cb;
  btnColor #connect#clicked callback: (cmw_color window);
  btnFile #connect#clicked callback: (cmw_file window);
  window # show_all ();
  Main.main ()


(* corrected bug in testgtk.c *)
let scrolled_windows_remove, scrolled_windows_clean =
  let parent = ref None and float_parent = ref None in
  let remove (scrollwin : scrolled_window) _ =
    match !parent with
    | None -> parent := Some (new widget (scrollwin #misc#parent));
	let f = new_window `TOPLEVEL title:"new parent" in
	float_parent := Some f;
	f #set_default_size 200 200;
	scrollwin #misc#reparent f;
	f #show ()
    | Some p ->
	scrollwin #misc#reparent p;
	match !float_parent with Some f ->
	  f #destroy ();
	float_parent := None;
	parent := None
  and clean _ =
    match !float_parent with
    | None -> ()
    | Some p -> p #destroy (); parent := None; float_parent := None
  in remove, clean

let create_scrolled_windows =
  let rw = ref None in
  let aux () =
    match !rw with
    | None ->
	let window = new_dialog () title:"dialog" border_width:0 in
	rw := Some window;
	window #connect#destroy callback:(fun  _ -> rw := None);
	window #connect#destroy callback:scrolled_windows_clean;

	let scrolled_window = new_scrolled_window () border_width:10
	    hscrollbar_policy: `AUTOMATIC
	    vscrollbar_policy:`AUTOMATIC
	    packing: window#vbox#pack in
	scrolled_window #show ();

	let table = new_table rows:20 columns:20 row_spacings:10
	    col_spacings:10 in
	scrolled_window #add_with_viewport table;
	table #set_focus_hadjustment (scrolled_window # hadjustment);
	table #set_focus_vadjustment (scrolled_window # vadjustment);
	table #show ();

	for i = 0 to 19 do
	  for j=0 to 19 do
	    let button = new_toggle_button label:("button (" ^
	       (string_of_int i) ^ "," ^ (string_of_int j) ^ ")\n") in
	    table #attach button left:i top:j;
	    button #show ()
	  done
	done;

	let button = new_button label:"close" in
	button #connect#clicked callback:(window #destroy);
	window #action_area #pack button;
	button #grab_default ();
	button #show ();

	let button = new_button label:"remove" in
	button #connect#clicked
	  callback:(scrolled_windows_remove scrolled_window);
	window #action_area # pack button;
	button #grab_default ();
	button #show ();
	
	window #set_default_size 300 300;
	window #show ()

    | Some window -> window #destroy ()
  in aux



let pixmap_new filename window background =
  let pixmap,mask = Gdk.Pixmap.create_from_xpm window file:filename in
  new_pixmap pixmap :mask

let make_toolbar (toolbar : toolbar) (window : window) =
  let icon () = (pixmap_new "test.xpm" (window #misc#window)
		(Gtk.Style.get_bg (window #misc#style))) in
  toolbar #insert_button text:"Horizontal"
    tooltip:"Horizontal toolbar layout"
    tooltip_private:"Toolbar/Horizontal"
    icon:(icon ())
    callback:(fun _ -> toolbar #set_orientation `HORIZONTAL);
  
  toolbar #insert_button text:"Vertical"
    tooltip:"Vertical toolbar layout"
    tooltip_private:"Toolbar/Vertical"
    icon:(icon ())
    callback:(fun _ -> toolbar #set_orientation `VERTICAL);
  
  toolbar #insert_space;
  
  toolbar #insert_button text:"Icons"
    tooltip: "Only show toolbar icons"
    tooltip_private:"Toolbar/IconsOnly"
    icon:(icon ())
    callback:(fun _ -> toolbar #set_style `ICONS);
  
  toolbar #insert_button text:"Text"
    tooltip: "Only show toolbar text"
    tooltip_private:"Toolbar/TextOnly"
    icon:(icon ())
    callback:(fun _ -> toolbar #set_style `TEXT);
  
  toolbar #insert_button text:"Both"
    tooltip: "Show toolbar icons and text"
    tooltip_private:"Toolbar/Both"
    icon:(icon ())
    callback:(fun _ -> toolbar #set_style `BOTH);
  
  toolbar #insert_space;
  
  toolbar #insert_widget (new_entry ())
    tooltip:"This is an unusable GtkEntry"
    tooltip_private: "Hey don't click me!!!";
  
  toolbar #insert_button text:"Small"
    tooltip:"Use small spaces"
    tooltip_private:"Toolbar/Small"
    icon:(icon ())
    callback:(fun _ -> toolbar #set_space_size 5);
  
  toolbar #insert_button text:"Big"
    tooltip:"Use big spaces"
    tooltip_private:"Toolbar/Big"
    icon:(icon ())
    callback:(fun _ -> toolbar #set_space_size 10);
  
  toolbar #insert_space;
  
  toolbar #insert_button text:"Enable"
    tooltip:"Enable tooltips"
    icon:(icon ())
    callback:(fun _ -> toolbar #set_tooltips true);
  
  toolbar #insert_button text:"Disable"
    tooltip:"Disable tooltips"
    icon:(icon ())
    callback:(fun _ -> toolbar #set_tooltips false);
  
  toolbar #insert_space;
  
  toolbar #insert_button text:"Borders"
    tooltip:"Show borders"
    icon:(icon ())
    callback:(fun _ -> toolbar #set_button_relief `NORMAL);
  
  toolbar #insert_button text:"Borderless"
    tooltip:"Hide borders"
    icon:(icon ())
    callback:(fun _ -> toolbar #set_button_relief `NONE);
  
  toolbar #insert_space;
  
  toolbar #insert_button text:"Empty"
    tooltip:"Empty spaces"
    icon:(icon ())
    callback:(fun _ -> toolbar #set_space_style `EMPTY);
  
  toolbar #insert_button text:"Lines"
    tooltip:"Lines in spaces"
    icon:(icon ())
    callback:(fun _ -> toolbar #set_space_style `LINE)
 
let create_toolbar =
  let rw = ref None in
  let aux () =
    match !rw with
    | None ->
	let window = new_window `TOPLEVEL title: "Toolbar test"
	    border_width: 0 allow_shrink: false allow_grow: true
	    auto_shrink: true in
	rw := Some window;
	window #connect#destroy callback:(fun _ -> rw := None);
	window #misc #realize ();
	
	let toolbar = new_toolbar `HORIZONTAL packing: window#add in
	make_toolbar toolbar window;
	
	window #show_all ()
	  
    | Some window -> window #destroy ()
  in aux


let handle_box_child_signal action (hb : handle_box) child =
  Printf.printf "%s: child <%s> %s\n" (Gtk.Type.name hb#get_type)
    (Gtk.Type.name (Gtk.Object.get_type child)) action

let create_handle_box =
  let rw = ref None in
  let aux () =
    match !rw with
    | None ->
	let window = new_window `TOPLEVEL title: "Handle box test"
	    border_width: 20 allow_shrink: false allow_grow: true
	    auto_shrink: true in
	rw := Some window;
	window #connect#destroy callback:(fun _ -> rw := None);
	window #misc #realize ();

	let vbox = new_box `VERTICAL packing:window#add in

	let label = new_label text:"Above" packing:vbox#pack in
	new_separator `HORIZONTAL packing:vbox#pack;

	let hbox = new_box `HORIZONTAL spacing:10 packing:vbox#pack in
	new_separator `HORIZONTAL packing:vbox#pack;

	let label = new_label text:"Below" packing:vbox#pack in
	let handle_box = new_handle_box ()
	    packing:(hbox#pack expand:false fill:false) in
	handle_box #connect#child_attached
	  callback:(handle_box_child_signal "attached" handle_box);
	handle_box #connect#child_detached
	  callback:(handle_box_child_signal "detached" handle_box);

	let toolbar = new_toolbar `HORIZONTAL in
	make_toolbar toolbar window;
	toolbar #set_button_relief `NORMAL;
	handle_box #add toolbar;

	let handle_box = new_handle_box ()
	    packing:(hbox#pack expand:false fill:false) in
	handle_box #connect#child_attached
	  callback:(handle_box_child_signal "attached" handle_box);
	handle_box #connect#child_detached
	  callback:(handle_box_child_signal "detached" handle_box);

	let handle_box2 = new_handle_box () packing:handle_box#add in
	handle_box2 #connect#child_attached
	  callback:(handle_box_child_signal "attached" handle_box);
	handle_box2 #connect#child_detached
	  callback:(handle_box_child_signal "detached" handle_box);

	new_label text:"Fooo!" packing:handle_box2#add;
	window #show_all ()
	  
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
    "labels", None;
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
    "reparent", None;
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
    "tooltips", None;
    "tree", None;
    "WM hints", None
  ] in

  let window = new_window `TOPLEVEL title:"main window" allow_shrink:false
      allow_grow:false auto_shrink:false width:200 height:400 x:20 y:20 in

  window #connect#destroy callback: Main.quit;

  let box1 = new_box `VERTICAL packing: window#add in

  new_label text: "Gtk+ v1.2"
    packing:(box1#pack expand:false fill:false);

  let scrolled_window = new_scrolled_window () border_width: 10
      hscrollbar_policy: `AUTOMATIC vscrollbar_policy: `AUTOMATIC
      packing:box1#pack in
  scrolled_window #show ();

  let box2 = new_box `VERTICAL border_width: 10 in
  scrolled_window #add_with_viewport box2;
  box2 #set_focus_vadjustment (scrolled_window #vadjustment);

  let rec aux = function
    | [] -> ()
    | (_,     None) :: tl -> aux tl
    | (label, Some func) :: tl ->
	let button = new_button label: label in
	button #connect#clicked callback: func;
	box2 #pack expand: true fill: true padding: 0 button;
	aux tl
  in aux buttons;

  let separator = new_separator `HORIZONTAL in
  box1 #pack separator expand: false;

  let box2 = new_box `VERTICAL spacing: 10 border_width: 10 in
  box1 #pack box2 expand: false;

  let button = new_button label: "close"  packing:box2#pack in
  button #connect#clicked callback: window#destroy;
  button #grab_default ();

  window #show_all ();

  Main.main ()
;;

create_main_window ()


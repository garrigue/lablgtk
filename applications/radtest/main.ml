(* $Id$ *)

open GdkKeysyms
open Gtk
open GObj

open Utils
open TiBase

let main_project_modify = ref false

let main_window  = GWindow.window ~title:"ZOOM" ()
let main_vbox    = GPack.vbox ~packing:main_window#add ()
let main_menu    = GMenu.menu_bar ~packing:(main_vbox#pack ~expand:false) ()

let can_copy = ref (fun _ -> assert false)
let can_paste = ref (fun _ -> assert false)

class project () =
  let project_box = GPack.vbox ~packing:main_vbox#pack () in
  let project_tree = GTree2.tree ~packing:project_box#pack () in
  object(self)
    val mutable window_list = []

(* the selected window *)
    val mutable selected = (None : window_and_tree option)

    method change_selected sel =
      match selected with
      |	None ->
	  selected <- Some sel;
	  sel#project_tree_item#misc#set_state `SELECTED;
	  !can_copy true
      |	Some old_sel ->
	  if sel = old_sel then begin
	    selected <- None;
	    sel#project_tree_item#misc#set_state `NORMAL;
	    !can_copy false
	  end else begin
	    old_sel#project_tree_item#misc#set_state `NORMAL;
	    selected <- Some sel;
	    sel#project_tree_item#misc#set_state `SELECTED;
	    !can_copy true
	  end

    val mutable filename = ""
    val mutable dirname = ""

    method set_filename f =
      let dir, file = split_filename f ~ext:".rad" in
      filename <- file;
      dirname <- dir

    method get_filename () =
      get_filename ~callback:self#set_filename ~dir:dirname ()

    method dirname = dirname

(*    method set_dirname f = dirname <- f *)

    method add_window ~name ?tree:wt () =
      let wt = match wt with
      |	None -> new window_and_tree ~name
      |	Some wt -> wt in
      let tiwin = wt#tiwin and tw=wt#tree_window in
      let project_tree_item = wt#project_tree_item in
      project_tree#append project_tree_item;
      let show = ref true in
      project_tree_item#event#connect#button_press ~callback:
	(fun ev ->
	match GdkEvent.get_type ev with
	| `BUTTON_PRESS ->
	    if GdkEvent.Button.button ev = 1 then begin
	      self#change_selected wt
	    end else
	    if GdkEvent.Button.button ev = 3 then begin
	      let menu = GMenu.menu () in
	      let name = wt#tiwin#name in
	      let mi_remove = GMenu.menu_item ~label:("delete " ^ name)
		  ~packing:menu#append ()
	      and mi_copy = GMenu.menu_item ~label:("copy " ^ name)
		  ~packing:menu#append ()      
	      and mi_cut = GMenu.menu_item ~label:("cut " ^ name)
		  ~packing:menu#append () in
	      mi_remove#connect#activate
		~callback:(fun () -> self#delete_window wt);
	      mi_copy#connect#activate
		~callback:(fun () -> self#copy_wt wt);
	      mi_cut#connect#activate
		~callback:(fun () -> self#cut_wt wt);
	      menu#popup ~button:3 ~time:(GdkEvent.Button.time ev)
	    end;
            GtkSignal.stop_emit ();
            true
	| `TWO_BUTTON_PRESS ->
	    if GdkEvent.Button.button ev = 1 then begin
	      if !show then begin
		show := false;
		tiwin#widget#misc#hide ();
		tw#misc#hide ()
	      end
	      else begin
		show := true;
		tiwin#widget#misc#show ();
		tw#misc#show ()
	      end
	    end;
	    true
	| _ -> false);
      tiwin#connect_event#delete ~callback:
	(fun _ -> show := false; tiwin#widget#misc#hide (); true);
      tw#event#connect#delete ~callback:
	(fun _ -> show := false; tw#misc#hide (); true);
      window_list <- wt :: window_list;
      add_undo (Remove_window name);
      main_window#misc#set_can_focus false;
      main_window#misc#grab_focus ()

      
    method add_window_by_node
	(Node ((classe, name, proplist), children)) =
      if classe <> "window"
      then failwith "add_window_by_node: class <> \"window\"";
      let name = change_name name in  (* for paste *)
      let wt = new window_and_tree ~name in
      let tiwin = wt#tiwin in
      List.iter proplist ~f:(fun (n,v) -> tiwin#set_property n v);
      begin match children with
      | [] -> ()
      | [ ch ] -> tiwin#add_children_wo_undo ch; ()
      | _ -> failwith "add_window_by_node: more than one child"
      end;
      self#add_window ~name ~tree:wt ()

    method delete_window (wt : window_and_tree) =
      let tiwin = wt#tiwin in
      project_tree#remove wt#project_tree_item;
      tiwin#remove_me ();
      wt#tree_window#destroy ();
      window_list <- list_remove ~f:(fun w -> w = wt) window_list

    method delete_window_by_name ~name =
      let wt = List.find window_list ~f:(fun wt -> wt#tiwin#name = name) in
      self#delete_window wt
      
    method delete () =
      List.iter window_list
	~f:(fun wt -> self#delete_window wt);
      main_vbox#remove project_box#coerce;
(* remove after test *)
      if !name_list <> [] then failwith "name_list not empty"

    method save_as () = if self#get_filename () then self#save ()

    method save () =
      if filename = "" then self#save_as ()
      else begin
	let outch = open_out (dirname ^ filename ^ ".rad") in
	let f = Format.formatter_of_out_channel outch in
	List.iter window_list ~f:(fun wt -> wt#tiwin#save f);
	close_out outch;
	main_project_modify := false
      end

    method copy_wt (wt : window_and_tree) =
      wt#tiwin#copy ();
      !can_paste true

    method cut_wt (wt : window_and_tree) =
      self#copy_wt wt;
      self#delete_window wt

    method copy () =
      match selected with
      |	None -> failwith "main_project copy"
      |	Some sel -> self#copy_wt sel

    method cut () =
      match selected with
      |	None -> failwith "main_project cut"
      |	Some sel -> self#cut_wt sel

    method paste () =
      let lexbuf = Lexing.from_string !window_selection in
      let node = Load_parser.window Load_lexer.token lexbuf in
      self#add_window_by_node node

    method emit () =
      let outc = open_out (dirname ^ filename ^ ".ml") in
      let f = Format.formatter_of_out_channel outc in
      List.iter window_list ~f:(fun wt -> wt#emit f);
      Format.fprintf f "let main () =@\n";
(* this is just for demo *)
      List.iter window_list ~f:
	begin fun wt ->
	  let name = wt#tiwin#name in
	  Format.fprintf f "  let %s = new %s () in %s#show ();@\n"
	    name name name
	end;
      Format.fprintf f
	"  GMain.Main.main ()@\n@\nlet _ = main ()@\n";
      close_out outc

  end


let main_project = ref (new project ())

let load () =
  let filename = ref "" in
  get_filename ~callback:(fun f -> filename := f) ~dir:!main_project#dirname ();
  if !filename <> "" then begin
    !main_project#delete ();
    main_project := new project ();
    let inch = open_in !filename in
    let lexbuf = Lexing.from_channel inch in
    let project_list = Load_parser.project Load_lexer.token lexbuf in
    close_in inch;
    List.iter project_list
      ~f:(fun node -> !main_project#add_window_by_node node);
    !main_project#set_filename !filename
  end


let interpret_undo = function
  | Add (parent_name, node, pos) ->
      let parent = Hashtbl.find widget_map parent_name in
      parent#add_children node ~pos
  | Remove child_name ->
      let child  = Hashtbl.find widget_map child_name in
      child#remove_me ()
  | Property (property, value_string) ->
      property#set value_string
  | Add_window node -> !main_project#add_window_by_node node
  | Remove_window name -> !main_project#delete_window_by_name ~name

let undo () =
  if !last_action_was_undo then begin
    match !next_undo_info with
    | hd :: tl -> interpret_undo hd; next_undo_info := tl
    | [] -> message "no more undo info"
  end
  else begin
    match !undo_info with
    | hd :: tl -> interpret_undo hd; next_undo_info := tl
    | [] -> message "no undo info"
  end;
  last_action_was_undo := true


let targets = [  { target = "STRING"; flags = []; info = 0}  ]

let xpm_window () =
  let source_drag_data_get classe _ (data : selection_data) ~info ~time =
    data#set ~typ:data#target ~format:0 ~data:classe in
  let window = GWindow.window ~title:"icons" () in
  window#misc#realize ();
  window#misc#set_uposition ~x:250 ~y:10;
  let vbox = GPack.vbox ~packing:window#add () in
  let table = GPack.table ~rows:1 ~columns:5 ~border_width:20
      ~packing:vbox#pack () in
  let tooltips = GData.tooltips () in
  let add_xpm ~file ~left ~top ~tip =
    let gdk_pix = GDraw.pixmap_from_xpm ~file ~window () in
    let ev = GBin.event_box ~packing:(table#attach ~left ~top) () in
    let pix = GMisc.pixmap gdk_pix ~packing:ev#add () in
    ev#event#connect#button_press ~callback:
      (fun ev -> match GdkEvent.get_type ev with
	| `BUTTON_PRESS ->
	    if GdkEvent.Button.button ev = 1 then begin
	      !main_project#add_window ~name:(make_new_name "window") ()
	    end;
	    true
	| _ -> false);
    tooltips#set_tip ev#coerce ~text:tip
  in
  add_xpm ~file:"window.xpm" ~left:0 ~top:0 ~tip:"window";
  GMisc.separator `HORIZONTAL ~packing:vbox#pack ();
  let table = GPack.table ~rows:6 ~columns:6 ~packing:vbox#pack
      ~row_spacings:20 ~col_spacings:20 ~border_width:20 () in
  let add_xpm file ~left ~top ~classe =
    let gdk_pix = GDraw.pixmap_from_xpm ~file ~window () in
    let ev = GBin.event_box ~packing:(table#attach ~left ~top) () in
    let pix = GMisc.pixmap gdk_pix ~packing:ev#add () in
    ev#drag#source_set ~modi:[`BUTTON1] targets ~actions:[`COPY];
    ev#drag#source_set_icon ~colormap:window#misc#style#colormap 
      gdk_pix; 
    ev#drag#connect#data_get ~callback:(source_drag_data_get classe);
    tooltips#set_tip ev#coerce ~text:classe
  in
  
  add_xpm "button.xpm"         ~left:0 ~top:0 ~classe:"button";
  add_xpm "togglebutton.xpm"   ~left:1 ~top:0 ~classe:"toggle_button";
  add_xpm "checkbutton.xpm"    ~left:2 ~top:0 ~classe:"check_button";
  add_xpm "radiobutton.xpm"    ~left:3 ~top:0 ~classe:"radio_button";
  add_xpm "toolbar.xpm"        ~left:4 ~top:0 ~classe:"toolbar";
  add_xpm "hbox.xpm"           ~left:0 ~top:1 ~classe:"hbox";
  add_xpm "vbox.xpm"           ~left:1 ~top:1 ~classe:"vbox";
  add_xpm "hbuttonbox.xpm"     ~left:2 ~top:1 ~classe:"hbutton_box";
  add_xpm "vbuttonbox.xpm"     ~left:3 ~top:1 ~classe:"vbutton_box";
  add_xpm "fixed.xpm"          ~left:4 ~top:1 ~classe:"fixed";
  add_xpm "frame.xpm"          ~left:0 ~top:2 ~classe:"frame";
  add_xpm "aspectframe.xpm"    ~left:1 ~top:2 ~classe:"aspect_frame";
  add_xpm "scrolledwindow.xpm" ~left:2 ~top:2 ~classe:"scrolled_window";
  add_xpm "eventbox.xpm"       ~left:3 ~top:2 ~classe:"event_box";
  add_xpm "handlebox.xpm"      ~left:4 ~top:2 ~classe:"handle_box";
  add_xpm "viewport.xpm"       ~left:5 ~top:2 ~classe:"viewport";
  add_xpm "hseparator.xpm"     ~left:0 ~top:3 ~classe:"hseparator";
  add_xpm "vseparator.xpm"     ~left:1 ~top:3 ~classe:"vseparator";
  add_xpm "clist.xpm"          ~left:2 ~top:3 ~classe:"clist";
  add_xpm "label.xpm"          ~left:0 ~top:4 ~classe:"label";
  add_xpm "statusbar.xpm"      ~left:1 ~top:4 ~classe:"statusbar";
  add_xpm "notebook.xpm"       ~left:2 ~top:4 ~classe:"notebook";
  add_xpm "colorselection.xpm" ~left:3 ~top:4 ~classe:"color_selection";
  add_xpm "pixmap.xpm"         ~left:4 ~top:4 ~classe:"pixmap";
  add_xpm "entry.xpm"          ~left:0 ~top:5 ~classe:"entry";
  add_xpm "spinbutton.xpm"     ~left:1 ~top:5 ~classe:"spin_button";
  add_xpm "combo.xpm"          ~left:2 ~top:5 ~classe:"combo";

  window#show ();
  window


let main () =
  let _ = GMain.Main.init () in
  let prop_win = Propwin.init () in
  let palette = xpm_window () in
  main_window#misc#set_uposition ~x:10 ~y:10;
  main_window#show ();
  main_window#connect#destroy ~callback:GMain.Main.quit;

  let mp = main_project in
  let f = new GMenu.factory main_menu in
  let accel_group  = f#accel_group in
  main_window#add_accel_group accel_group;
  prop_win#add_accel_group accel_group;
  palette#add_accel_group accel_group;

  let file_menu    = new GMenu.factory (f#add_submenu "File") ~accel_group
  and edit_menu    = new GMenu.factory (f#add_submenu "Edit") ~accel_group
  and view_menu    = new GMenu.factory (f#add_submenu "View") ~accel_group
  and project_menu = new GMenu.factory (f#add_submenu "Project") ~accel_group
  in

  file_menu#add_item "Quit" ~key:_Q ~callback:GMain.Main.quit;

  project_menu#add_item "New" ~key:_N
    ~callback:(fun () -> !mp#delete (); mp := new project ());
  project_menu#add_item "Open..." ~key:_O ~callback:load;
  project_menu#add_item "Save" ~key:_S ~callback:(fun () -> !mp#save ());
  project_menu#add_item "Save as..." ~callback:(fun () -> !mp#save_as ());
  project_menu#add_separator ();
  project_menu#add_item "Emit code" ~callback:(fun () -> !mp#emit ());

  let copy_item =
    edit_menu#add_item "Copy" ~key:_C ~callback:(fun () -> !mp#copy ())
  and cut_item =
    edit_menu#add_item "Cut" ~key:_X ~callback:(fun () -> !mp#cut ())
  and paste_item =
    edit_menu#add_item "Paste" ~key:_V ~callback:(fun () -> !mp#paste ())
  in
  can_copy :=
    (fun b -> copy_item#misc#set_sensitive b; cut_item#misc#set_sensitive b);
  can_paste := paste_item#misc#set_sensitive;
  !can_copy false; !can_paste false;
  edit_menu#add_item "Undo" ~key:_Z ~callback:undo;

  let palette_visible = ref true in
  palette#event#connect#delete ~callback:
    (fun _ -> palette_visible := false; palette#misc#hide (); true);
  view_menu#add_item "Palette"
    ~callback:(fun () ->
      if !palette_visible then begin
	palette#misc#hide ();
	palette_visible := false
      end else begin
	palette#misc#show ();
	palette_visible := true
      end);
  let prop_win_visible = ref true in
  prop_win#event#connect#delete ~callback:
    (fun _ -> prop_win_visible := false; prop_win#misc#hide (); true);
  view_menu#add_item "Properties window"
    ~callback:(fun () ->
      if !prop_win_visible then begin
	prop_win#misc#hide ();
	prop_win_visible := false
      end else begin
	prop_win#misc#show ();
	prop_win_visible := true
      end);

  GMain.Main.main ()

let _ = main ()

open Gtk
open GdkObj
open GObj
open GWindow
open GPack
open GMenu
open GMisc
open GFrame
open GPix

open GTree2
open Property
open Utils
open Treew


let main_project_modify = ref false

let main_window  = new window width:200 height:200
let main_vbox    = new vbox packing:main_window#add
let main_menu    = new menu_bar packing:(main_vbox#pack expand:false)
let file_item    = new menu_item label:"File" packing:main_menu#append
let project_item = new menu_item label:"Project" packing:main_menu#append
let edit_item    = new menu_item label:"Edit" packing:main_menu#append
let file_menu    = new menu packing:file_item#set_submenu
let project_menu = new menu packing:project_item#set_submenu
let edit_menu    = new menu packing:edit_item#set_submenu
let emit_item    = new menu_item label:"Emit code" packing:file_menu#append
let exit_item    = new menu_item label:"Exit" packing:file_menu#append
let new_item     = new menu_item label:"New" packing:project_menu#append
let open_item    = new menu_item label:"Open" packing:project_menu#append
let save_item    = new menu_item label:"Save" packing:project_menu#append
let save_as_item = new menu_item label:"Save as" packing:project_menu#append
let test_item    = new menu_item label:"Test" packing:project_menu#append
let copy_item    = new menu_item label:"Copy" packing:edit_menu#append
let cut_item     = new menu_item label:"Cut" packing:edit_menu#append
let paste_item   = new menu_item label:"Paste" packing:edit_menu#append
let accel = GtkData.AccelGroup.create ()

let _ =
  GtkData.AccelGroup.attach accel (main_window #as_widget);
  project_menu#set_accel_group accel;
  test_item#add_accelerator accel key:GdkKeysyms._Z mod:[`CONTROL]
    flags:[`VISIBLE]

class project () =
  let project_box = new vbox packing:main_vbox#pack in
  let project_tree = new tree2 packing:project_box#pack in
  object(self)
    val mutable window_list = []

(* the selected window *)
    val mutable selected = (None : window_and_tree option)

    method change_selected sel =
      match selected with
      |	None ->
	  selected <- Some sel;
	  sel#project_tree_item#misc#set_state `SELECTED;
	  copy_item#misc#set_sensitive true;
	  cut_item#misc#set_sensitive true
      |	Some old_sel ->
	  if sel = old_sel then begin
	    selected <- None;
	    sel#project_tree_item#misc#set_state `NORMAL;
	    copy_item#misc#set_sensitive false;
	    cut_item#misc#set_sensitive false
	  end else begin
	    old_sel#project_tree_item#misc#set_state `NORMAL;
	    selected <- Some sel;
	    sel#project_tree_item#misc#set_state `SELECTED;
	    copy_item#misc#set_sensitive true;
	    cut_item#misc#set_sensitive true
	  end

    val mutable filename = ""
    val mutable dirname = ""

    method set_filename f =
      let dir, file = split_filename f ext:".rad" in
      filename <- file;
      dirname <- dir

    method dirname = dirname

(*    method set_dirname f = dirname <- f *)

    method add_window :name ?wt =
      let wt = match wt with
      |	None -> new window_and_tree :name
      |	Some wt -> wt in
      let tiwin = wt#tiwin and tw=wt#tree_window in
      let project_tree_item = wt#project_tree_item in
      project_tree#append project_tree_item;
      project_tree_item#connect#event#button_press callback:
	(fun ev -> match GdkEvent.get_type ev with
	| `BUTTON_PRESS ->
	    if GdkEvent.Button.button ev = 1 then begin
	      self#change_selected wt
	    end else
	    if GdkEvent.Button.button ev = 3 then begin
	      let menu = new menu in
	      let name = wt#tiwin#name in
	      let mi_remove = new menu_item label:("delete " ^ name)
		  packing:menu#append
	      and mi_copy = new menu_item label:("copy " ^ name)
		  packing:menu#append	      
	      and mi_cut = new menu_item label:("cut " ^ name)
		  packing:menu#append in
	      mi_remove#connect#activate
		callback:(fun () -> self#delete_window wt);
	      mi_copy#connect#activate
		callback:(fun () -> self#copy_wt wt);
	      mi_cut#connect#activate
		callback:(fun () -> self#cut_wt wt);
	      menu#popup button:3 time:(GdkEvent.Button.time ev)
	    end;
	    project_tree_item#connect#stop_emit name:"button_press_event";
	    true
	| _ -> false);
      window_list <- wt :: window_list;
      add_undo (Remove_window name);
      main_window#misc#set_can_focus false; 
      main_window#misc#grab_focus ()

      
    method add_window_by_node
	(Node ((classe, name, proplist), children)) =
      if classe <> "window"
      then failwith "add_window_by_node: class <> \"window\"";
      let name = change_name name in  (* for paste *)
      let wt = new window_and_tree :name in
      let tiwin = wt#tiwin in
      List.iter proplist fun:(fun (n,v) -> tiwin#set_property n v);
      begin match children with
      | [] -> ()
      | [ ch ] -> tiwin#add_children_wo_undo ch; ()
      | _ -> failwith "add_window_by_node: more than one child"
      end;
      self#add_window :name wt

    method delete_window (wt : window_and_tree) =
      let tiwin = wt#tiwin in
      project_tree#remove wt#project_tree_item;
      tiwin#remove_me ();
      wt#tree_window#destroy ();
      window_list <- list_remove pred:(fun w -> w = wt) window_list

    method delete_window_by_name :name =
      let wt = List.find window_list
	  pred:(fun wt -> wt#tiwin#name = name) in
      self#delete_window wt
      
    method delete () =
      List.iter window_list
	fun:(fun wt -> self#delete_window wt);
      main_vbox#remove project_box;
(* remove after test *)
      if !name_list <> [] then failwith "name_list not empty"

    method get_filename () =
      get_filename set_fun:self#set_filename dir:dirname

    method save_as () = if self#get_filename () then self#save ()

    method save () =
      if filename = "" then self#save_as ()
      else begin
	let outch = open_out file:(dirname ^ filename ^ ".rad") in
	let c = Oformat.of_channel outch in
	List.iter window_list fun:(fun wt -> wt#tiwin#save c);
	close_out outch;
	main_project_modify := false
      end

    method copy_wt (wt : window_and_tree) =
      wt#tiwin#copy ();
      paste_item#misc#set_sensitive true

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
      let node = Wpaste_parser.window Wpaste_lexer.token lexbuf in
      self#add_window_by_node node

    method emit () =
      let outc = open_out file:(dirname ^ filename ^ ".ml") in
      let c = Oformat.of_channel outc in
      List.iter window_list fun:(fun wt -> wt#emit c);
      Format.fprintf c#formatter "let main () =@\n";
(* this is just for demo *)
      List.iter window_list
	fun:(fun wt -> let name = wt#tiwin#name in
	Format.fprintf c#formatter "  let %s = new %s in %s#show ();@\n"
	  name name name);
      Format.fprintf c#formatter
	"  GMain.Main.main ()@\n@\nlet _ = main ()@\n";
      close_out outc

  end


let main_project = ref (new project ())

let load () =
  let filename = ref "" in
  get_filename set_fun:(fun f -> filename := f) dir:!main_project#dirname;
  if !filename <> "" then begin
    !main_project#delete ();
    main_project := new project ();
    let inch = open_in file:!filename in
    let lexbuf = Lexing.from_channel inch in
    let project_list = Load_parser.project Load_lexer.token lexbuf in
    close_in inch;
    List.iter project_list
      fun:(fun node -> !main_project#add_window_by_node node);
    !main_project#set_filename !filename
  end


let interpret_undo = function
  | Add (parent_name, node, pos) ->
      let parent = widget_map#find key:parent_name in
      parent#add_children node :pos
  | Remove child_name ->
      let child  = widget_map#find key:child_name in
      child#remove_me ()
  | Property (tiwidget_name, property, value_string) ->
      let tiwidget  = widget_map#find key:tiwidget_name in
      tiwidget#set_property property value_string
  | Add_window node -> !main_project#add_window_by_node node
  | Remove_window name -> !main_project#delete_window_by_name :name

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
  let source_drag_data_get classe _ (data : selection_data) :info :time =
    data#set type:data#target format:0 data:classe in
  let window = new window show:true title:"icons" in
  let vbox = new vbox packing:window#add in
  let table = new table rows:1 columns:5 packing:vbox#pack in
  let add_xpm :file :left :top =
    let gdk_pix = new pixmap_from_xpm :file window:window#misc#window in
    let ev = new event_box in
    let pix = new pixmap gdk_pix packing:ev#add in
    table#attach ev :left :top;
    ev#connect#event#button_press callback:
      (fun ev -> match GdkEvent.get_type ev with
	| `BUTTON_PRESS ->
	    if GdkEvent.Button.button ev = 1 then begin
	      !main_project#add_window name:(make_new_name "window")
	    end;
	    true
	| _ -> false) in
  add_xpm file:"window.xpm"       left:0 top:0;
  new separator `HORIZONTAL packing:vbox#pack;
  let table = new table rows:5 columns:5 packing:vbox#pack in
  let add_xpm :file :left :top :classe =
    let gdk_pix = new pixmap_from_xpm :file window:window#misc#window in
    let ev = new event_box in
    let pix = new pixmap gdk_pix packing:ev#add in
    table#attach ev :left :top;
    ev#drag#source_set mod:[`BUTTON1] :targets actions:[`COPY];
    ev#drag#source_set_icon colormap:window#misc#style#colormap 
      gdk_pix; 
    ev#connect#drag#data_get callback:(source_drag_data_get classe) in
  
  add_xpm file:"button.xpm"         left:0 top:0 classe:"button";
  add_xpm file:"togglebutton.xpm"   left:1 top:0 classe:"toggle_button";
  add_xpm file:"checkbutton.xpm"    left:2 top:0 classe:"check_button";
  add_xpm file:"hbox.xpm"           left:0 top:1 classe:"hbox";
  add_xpm file:"vbox.xpm"           left:1 top:1 classe:"vbox";
  add_xpm file:"frame.xpm"          left:2 top:1 classe:"frame";
  add_xpm file:"scrolledwindow.xpm" left:3 top:1 classe:"scrolled_window";
  add_xpm file:"hseparator.xpm"     left:0 top:2 classe:"hseparator";
  add_xpm file:"vseparator.xpm"     left:1 top:2 classe:"vseparator";
  add_xpm file:"label.xpm"          left:2 top:2 classe:"label";
  add_xpm file:"entry.xpm"          left:3 top:2 classe:"entry"


let main () =
  xpm_window ();
  main_window#show ();

  emit_item#connect#activate callback:(fun () -> !main_project#emit ());
  exit_item#connect#activate callback:GMain.Main.quit;
  new_item#connect#activate callback:
    begin fun () ->
      !main_project#delete ();
      main_project := new project ()
    end;
  cut_item#connect#activate callback:(fun () -> !main_project#cut ());
  copy_item#connect#activate callback:(fun () -> !main_project#copy ());
  paste_item#connect#activate callback:(fun () -> !main_project#paste ());
  open_item#connect#activate callback:load;
  save_item#connect#activate callback:(fun () -> !main_project#save ());
  save_as_item#connect#activate callback:(fun () -> !main_project#save_as ());
  copy_item#misc#set_sensitive false;
  cut_item#misc#set_sensitive false;
  paste_item#misc#set_sensitive false;

  test_item#connect#activate callback:undo;
  GMain.Main.main ()

let _ = main ()

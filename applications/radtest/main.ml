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
open Treew

let main_window = new window width:200 height:200
let main_vbox = new vbox packing:main_window#add
let main_menu = new menu_bar packing:(main_vbox#pack expand:false)
let file_item = new menu_item label:"File" packing:main_menu#append
let project_item = new menu_item label:"Project" packing:main_menu#append
let file_menu = new menu packing:file_item#set_submenu
let project_menu = new menu packing:project_item#set_submenu
let exit_item = new menu_item label:"Exit" packing:file_menu#append
let new_item = new menu_item label:"New" packing:project_menu#append
let open_item = new menu_item label:"Open" packing:project_menu#append
let save_item = new menu_item label:"Save" packing:project_menu#append
let save_as_item = new menu_item label:"Save as" packing:project_menu#append
;;

exit_item#connect#activate callback:GMain.Main.quit

class project () =
  let project_box = new vbox packing:main_vbox#pack in
  let project_tree = new tree2 packing:project_box#pack in
  object(self)
    val mutable window_list = []
    val mutable filename = ""

    method add_window_by_name :name =
      self#add_window (new_window :name)

    method add_window (tw, tiw) =
      let name = tiw#tiw#name in
      let label = new label text:name xalign:0. yalign:0.5 in
      let tree_item = new tree_item2 in
      tree_item#add label;
      project_tree#append tree_item;
      tree_item#connect#event#button_press callback:
	(fun ev -> match GdkEvent.get_type ev with
	| `BUTTON_PRESS ->
	    if GdkEvent.Button.button ev = 3 then begin
	      tree_item#stop_emit "button_press_event";
	      let menu = new menu in
	      let mi_remove = new menu_item label:"delete"
		  packing:menu#append in
	      mi_remove#connect#activate callback:(fun () -> self#delete_window :name);
	      menu#popup button:3 time:(GdkEvent.Button.time ev)
	    end;
	    true
	| _ -> false);
      let id = tiw#tiw#connect#name_changed callback:
	  (fun n -> label#set_text n; tw#set_wm title:(n ^ "-Tree")) in
      window_list <- window_list @ [name, (tw, tiw, tree_item, id)]
      
    method delete_window :name =
      let (tw, tiw, ti, id) = List.assoc name in:window_list in
      tiw#tiw#disconnect id;
      tw#destroy ();
      tiw#tiw#widget#destroy ();
      project_tree#remove ti;
(* l'enlever aussi de la fenetre property *)
      let rec rem (t : #tiwidget) =
	t#forall callback:rem; property_remove t in
      rem tiw#tiw;
      window_list <- List.remove_assoc name in:window_list
      
    method delete () =
      List.iter (List.map window_list fun:fst)
	fun:(fun name -> self#delete_window :name);
      main_vbox#remove project_box

    method get_filename () =
      let res = ref false in
      let file_selection = new file_selection show:true modal:true in
      file_selection#ok_button#connect#clicked
	callback:(fun () -> filename <- file_selection#get_filename;
	  res := true;
	  file_selection#destroy ());
      file_selection#connect#destroy callback:GMain.Main.quit;
      GMain.Main.main ();
      !res

    method save_as () = if self#get_filename () then self#save ()
    method save () =
      if filename = "" then self#save_as ()
      else begin
	let outch = open_out file:filename in
	let c = Oformat.of_channel outch in
	List.iter window_list fun:(fun (_, (_, t, _, _)) -> t#tiw#save c);
	close_out outch
      end
  end
;;

let main_project_modify = ref false
;;

let main_project = ref (new project ())
;;

new_item#connect#activate callback:
    (fun () ->
      !main_project#delete ();
      main_project := new project ())
;;

let window_index = ref 99;;
let new_window_name () =
  incr window_index;
  "window" ^ (string_of_int !window_index)
;;

let load () =
  let file_selection = new file_selection show:true modal:true in
  let filename = ref "" in
  file_selection#ok_button#connect#clicked
    callback:(fun () -> filename := file_selection#get_filename;
      file_selection#destroy ());
  file_selection#connect#destroy callback:GMain.Main.quit;
  GMain.Main.main ();
  if !filename <> "" then begin
    let inch = open_in_bin file:!filename in
    let lexbuf = Lexing.from_channel inch in
    let project = Load_parser.project Load_lexer.token lexbuf in
    close_in inch;
    !main_project#delete ();
    main_project := new project ();
(*    Printf.printf "length: %d\n" (List.length project);
    flush stdout;
*)
    List.iter project fun:!main_project#add_window
  end
;;

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
	      !main_project#add_window_by_name name:(new_window_name ())
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
  add_xpm file:"entry.xpm"          left:2 top:2 classe:"entry"
;;

xpm_window ()
;;


main_window#show ()
;;

open_item#connect#activate callback:load;
save_item#connect#activate callback:!main_project#save;
save_as_item#connect#activate callback:!main_project#save_as;
;;

GMain.Main.main ()

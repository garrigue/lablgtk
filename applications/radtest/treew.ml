open GObj
open GTree
open GWindow
open GMenu
open GMisc
open GMain

open Property
open Widget


class tiw ?:border_width [< 0 >] parent_tree:(parent_tree : tree) :name =
  object(self : 'stype)
    val tree_item = new tree_item :border_width show:true
    val mutable stree = new tree
    val label = new label text:name show:true xalign:0. yalign:0.5
    val mutable parent_ti : 'stype option = None
    val parent_tree = parent_tree
    method parent_tree = parent_tree
    method parent_ti = parent_ti
    method set_parent_ti p = parent_ti <- Some p
    method set_label name = label#set_text name
    method tree = stree
    method tree_item = tree_item
    method new_tree () =
      stree <- new tree;
      tree_item#set_subtree stree;
      tree_item#expand ()
    val mutable widget : rwidget option = None
    method widget = match widget with
    | None -> raise Not_found
    | Some w -> w
    method set_widget w = widget <- Some w

    initializer
      parent_tree#insert tree_item pos:0;
      tree_item#set_subtree stree;
      tree_item#add label;
      tree_item#expand ();
  end


class ['a, 'd] memo () = object
  constraint 'a = #gtkobj
  val tbl = Hashtbl.create size:7
  method add (obj : 'a) data:(data : 'd) =
    Hashtbl.add tbl key:obj#get_id :data
  method find : 'b. (#gtkobj as 'b) -> 'd =
    fun obj -> Hashtbl.find tbl key:obj#get_id
  method remove : 'c. (#gtkobj as 'c) -> unit =
    fun obj -> Hashtbl.remove tbl key:obj#get_id
end

let memo = new memo ()

(* GtkThread.start ();; *)


let index = ref 0


let new_window :name =
  let tree_window = new window type:`TOPLEVEL show:true
      title:(name ^ "-Tree") in
  let root_tree = new tree packing:tree_window#add in
  let tiw1 = new tiw parent_tree:root_tree :name in
  memo#add tiw1#tree_item data:tiw1;
  let gtk_window = new_rwidget classe:"window" :name setname:tiw1#set_label in
  tiw1#set_widget gtk_window;

  let sel () = match root_tree#selection with
  | [] -> None
  | sel :: _ -> Some (memo#find sel) in

  let add_widget classe meth:(meth : [ START END ADD ]) _ =
    match sel () with   (* test a supprimer ensuite*)
    | None -> ()
    | Some (sel : tiw) ->
	incr index;
	let name = classe ^ (string_of_int !index) in
	let t = new tiw parent_tree:sel#tree :name in
	t#set_parent_ti sel;
	let w = new_rwidget :classe :name  setname:t#set_label in
	t#set_widget w;
	begin match meth with
	| `START -> sel#widget#pack w
	| `ADD -> sel#widget#add w
	| `END -> sel#widget#pack from:`END w
	end;
	w#set_parent sel#widget;
	property_add w;
	memo#add t#tree_item data:t in
  
  let remove_widget _ =
    let remove_one_tiw (tiw : tiw) =
   flush stdout;  
      match tiw#parent_ti with
      |	None -> ()
      |	Some tip ->
	  memo#remove tiw#tree_item;
	  tiw#parent_tree#remove_items [ tiw#tree_item ];
	  tiw#widget#parent#remove tiw#widget;
	  property_remove tiw#widget in
    let rec remove_tiws (tiw : tiw) =
      List.iter fun:remove_tiws
	(List.map fun:(fun ti -> memo#find ti) tiw#tree#children);
      remove_one_tiw tiw in
    match sel () with
    | None -> ()
    | Some (sel : tiw) -> 
	let one = List.length sel#parent_tree#children = 1 in
	remove_tiws sel;
	if one then begin
	  match sel#parent_ti with 
	  | None -> failwith "bug remove_widget"
	  | Some tip -> tip#new_tree ()
	end in

  let emit () =
    let outc = open_out file:(gtk_window#name ^ ".ml") in
    let c = Oformat.of_channel outc in
    gtk_window#emit_code c;
    close_out outc in

  let menu_bin = 
    let menu = new menu in
    let mi_vbox = new menu_item packing:menu#append label:"add vbox"
    and mi_hbox = new menu_item packing:menu#append label:"add hbox"
    and mi_frame = new menu_item packing:menu#append label:"add frame"
    and mi_label = new menu_item packing:menu#append label:"add label"
    and mi_button = new menu_item packing:menu#append label:"add button"
    and mi_remove = new menu_item packing:menu#append label:"remove" in
    mi_vbox#connect#activate callback:(add_widget "vbox" meth:`ADD);
    mi_hbox#connect#activate callback:(add_widget "hbox" meth:`ADD);
    mi_frame#connect#activate callback:(add_widget "frame" meth:`ADD);
    mi_label#connect#activate callback:(add_widget "label" meth:`ADD);
    mi_button#connect#activate callback:(add_widget "button" meth:`ADD);
    mi_remove#connect#activate callback:remove_widget;
    menu in
  
  let menu_window = 
    let menu = new menu in
    let mi_vbox = new menu_item packing:menu#append label:"add vbox"
    and mi_hbox = new menu_item packing:menu#append label:"add hbox"
    and mi_frame = new menu_item packing:menu#append label:"add frame"
    and mi_label = new menu_item packing:menu#append label:"add label"
    and mi_button = new menu_item packing:menu#append label:"add button"
    and mi_emit = new menu_item packing:menu#append label:"emit code" in
    mi_vbox#connect#activate callback:(add_widget "vbox" meth:`ADD);
    mi_hbox#connect#activate callback:(add_widget "hbox" meth:`ADD);
    mi_frame#connect#activate callback:(add_widget "frame" meth:`ADD);
    mi_label#connect#activate callback:(add_widget "label" meth:`ADD);
    mi_button#connect#activate callback:(add_widget "button" meth:`ADD);
    mi_emit#connect#activate callback:emit;
    menu in

  let menu_window2 =
    let menu = new menu in
    let mi_emit = new menu_item packing:menu#append label:"emit code" in
    mi_emit#connect#activate callback:emit;
    menu in

  let menu_remove =
    let menu = new menu in
    let mi_remove = new menu_item packing:menu#append label:"remove" in
    mi_remove#connect#activate callback:remove_widget;
    menu in

  let menu_box = 
    let menu = new menu in
    let menu_end = new menu in
    let menu_start = new menu in
    let mi_start = new menu_item packing:menu#append label:"add at start"
    and mi_end = new menu_item packing:menu#append label:"add at end"
    and mi_vboxs = new menu_item packing:menu_start#append label:"vbox"
    and mi_hboxs = new menu_item packing:menu_start#append label:"hbox"
    and mi_frames = new menu_item packing:menu_start#append label:"frame"
    and mi_labels = new menu_item packing:menu_start#append label:"label"
    and mi_buttons = new menu_item packing:menu_start#append label:"button"
    and mi_vboxe = new menu_item packing:menu_end#append label:"vbox"
    and mi_hboxe = new menu_item packing:menu_end#append label:"hbox"
    and mi_framee = new menu_item packing:menu_end#append label:"frame"
    and mi_labele = new menu_item packing:menu_end#append label:"label"
    and mi_buttone = new menu_item packing:menu_end#append label:"button"
    and mi_remove = new menu_item packing:menu#append label:"remove" in
    mi_start#set_submenu menu_start;
    mi_end#set_submenu menu_end;
    mi_vboxs#connect#activate callback:(add_widget "vbox" meth:`START);
    mi_hboxs#connect#activate callback:(add_widget "hbox" meth:`START);
    mi_frames#connect#activate callback:(add_widget "frame" meth:`START);
    mi_labels#connect#activate callback:(add_widget "label" meth:`START);
    mi_buttons#connect#activate callback:(add_widget "button" meth:`START);
    mi_vboxe#connect#activate callback:(add_widget "vbox" meth:`END);
    mi_hboxe#connect#activate callback:(add_widget "hbox" meth:`END);
    mi_framee#connect#activate callback:(add_widget "frame" meth:`END);
    mi_labele#connect#activate callback:(add_widget "label" meth:`END);
    mi_buttone#connect#activate callback:(add_widget "button" meth:`END);
    mi_remove#connect#activate callback:remove_widget;
    menu in

  let last_sel = ref (None : rwidget option) in

  root_tree#connect#selection_changed callback:(fun _ ->
    begin match !last_sel with
      | None -> ()
      |	Some sl -> sl#base#misc#set state:`NORMAL end;
    match root_tree#selection with
    | [] ->  last_sel := None
    | sel :: _  -> let ti = memo#find sel in
      ti#widget#base#misc#set state:`SELECTED;
      begin match ti#widget#classe with
      | "hbox" | "vbox" -> menu_box#popup button:0 time:0
      |	"frame" when ti#tree#children = [] -> menu_bin#popup button:0 time:0
      | "window" when ti#tree#children = [] ->
	  menu_window#popup button:0 time:0
      |	"window" -> menu_window2#popup button:0 time:0
      | _ -> menu_remove#popup button:0 time:0 end;
      last_sel := Some ti#widget
					       );    
  
  tree_window#connect#event#focus_out callback:
    (fun _ -> begin match !last_sel with
      |	None -> ()
      |	Some sl -> sl#base#misc#set state:`NORMAL end;
      true);
  tree_window#connect#event#focus_in callback:
    (fun _ -> begin match !last_sel with
      |	None -> ()
      |	Some sl -> sl#base#misc#set state:`SELECTED end;
      true);
  property_add gtk_window;
  tree_window, gtk_window
;;

let t, g = new_window name:"window"
;;

Main.main ()



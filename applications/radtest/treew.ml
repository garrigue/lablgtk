open Gtk
open GObj
open GWindow
open GMenu
open GMisc
open GMain
open GFrame
open Misc
open GPack
open GTree2

open Property
open Widget


let get_opt = function
| Some x -> x
| None -> failwith "get_opt"

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

(* this is necessary to avoid the "self type cannot escape its class"
   error *)
class virtual tiw0 = object
  method virtual parent_tree : tree2
  method virtual parent_ti : tiw0 option
  method virtual set_parent_ti : tiw0 -> unit
  method virtual set_new_name : string -> unit
  method virtual tree : tree2
  method virtual tree_item : tree_item2
  method virtual widget : rwidget
  method virtual set_widget : rwidget -> unit
  method virtual add_child : string -> meth:[ADD END START] -> unit -> unit
  method virtual remove : unit -> unit
  method virtual set_add_menu : string -> string -> unit
end

(* possible children *)
let widget_add_list = [ "vbox"; "hbox"; "frame"; "label"; "button";
			"toggle_button"; "check_button" ; "scrolled_window"]

(* widgets which can have one or more children  *)
let bin_list = [ "hbox"; "vbox"; "frame"; "scrolled_window"; "window"]

(* widgets which can accept only one child *)
let bin1_list = [ "frame"; "window" ; "scrolled_window"]

(* widgets which can accept only one child except window *)
let bin2_list = [ "frame"; "scrolled_window"]

(* widgets which can accept only one child window included *)
let bin1_list = bin2_list @ [ "window" ]

let menu_bin name add remove = 
  let menu = new menu and menu_add = new menu in
  List.iter
    fun:(fun n ->
      let mi = new menu_item packing:menu_add#append label:n
      in mi#connect#activate callback:(add n meth:`ADD); ())
    widget_add_list;      
  let mi_add = new menu_item packing:menu#append label:("add to " ^ name)
  and mi_remove = new menu_item packing:menu#append
      label:("remove " ^ name) in
  mi_remove#connect#activate callback:remove;
  mi_add#set_submenu menu_add;
  menu
  
let menu_window name add _ =
  let menu = new menu and menu_add = new menu in
  List.iter
    fun:(fun n ->
      let mi = new menu_item packing:menu_add#append label:n
      in mi#connect#activate callback:(add n meth:`ADD); ())
    widget_add_list;      
  let mi_add = new menu_item packing:menu#append label:("add to " ^ name)
  in
  mi_add#set_submenu menu_add;
  menu

let menu_remove remove =
  let menu = new menu in
  let mi_remove = new menu_item packing:menu#append label:"remove" in
  mi_remove#connect#activate callback:remove;
  menu

class tiw parent_tree:(parent_tree : tree2) :name = object(self : 'stype)
  inherit tiw0
  val tree_item = new tree_item2
  val  mutable stree = new tree2
  val label = new label text:name xalign:0. yalign:0.5
  val mutable parent_ti : tiw option = None
  val parent_tree = parent_tree
  method parent_tree = parent_tree
  method parent_ti = parent_ti
  method set_parent_ti p = parent_ti <- Some p
  method tree = stree
  method tree_item = tree_item

  val mutable widget : rwidget option = None
  method widget = match widget with
  | None -> raise Not_found
  | Some w -> w

(* signal id of button_press handler *)
  val mutable button_press_id = None

(* true if the current menu is the add_menu; for changing the name *)
  val mutable menu_add_set = false

(* sets the add menu of the tree_item; the stop_emit
 stops the default action of button 3 (hiding the tree) *)
  method set_add_menu classe name =
    menu_add_set <- true;
    may button_press_id fun:tree_item#disconnect;
    button_press_id <- Some
	(let menu =
	  if classe = "window" then menu_window name else menu_bin name in
	(tree_item#connect#event#button_press callback:
	   (fun ev -> match GdkEvent.get_type ev with
	   | `BUTTON_PRESS ->
	       if GdkEvent.Button.button ev = 3 then begin
		 tree_item#stop_emit "button_press_event";
		 (menu self#add_child
		    self#remove)#popup  button:3 time:(GdkEvent.Button.time ev) end;
	       true
	   | _ -> false)))


(* changes all that depends on the name *)
  method set_new_name name =
    label#set_text name;
    if menu_add_set then begin
      self#set_add_menu self#widget#classe self#widget#name
    end
      
(* sets the menu with only remove item *)
  method private set_remove_menu () =
    menu_add_set <- false;
    button_press_id <- Some
	(tree_item#connect#event#button_press callback:
	   (fun ev -> match GdkEvent.get_type ev with
	   | `BUTTON_PRESS ->
	       if GdkEvent.Button.button ev = 3 then begin
		 tree_item#stop_emit "button_press_event";
		 (menu_remove self#remove)#popup  button:3 time:(GdkEvent.Button.time ev);
		 true end else false
	   | _ -> false))

(* only stops the third button default action *)
  method private stop_third_button () =
    menu_add_set <- false;
    button_press_id <- Some
	(tree_item#connect#event#button_press callback:
	   (fun ev -> match GdkEvent.get_type ev with
	   | `BUTTON_PRESS ->
	       if GdkEvent.Button.button ev = 3 then begin
		 tree_item#stop_emit "button_press_event";
		 true end else false
	   | _ -> false))

  method set_widget w =
    widget <- Some w;
    let classe = w#classe in
    if List.mem classe in:bin_list then begin
      tree_item#drag#dest_set
	targets:[{ target = "STRING"; flags = []; info = 0}]
	actions:[`COPY];
      tree_item#connect#drag#data_received callback:
	begin fun (context : drag_context) :x :y
	    (data : selection_data) :info :time ->
	  self#add_child data#data meth:`ADD ();
	  context#finish success:true del:false :time
	end;
      self#set_add_menu classe w#name
    end
    else begin
      self#set_remove_menu ()
    end

  method add_child classe meth:(meth : [ START END ADD ]) () =
    incr index;
    let name = classe ^ (string_of_int !index) in
    let (t : tiw0) = new tiw parent_tree:stree :name in
    t#set_parent_ti (self : #tiw0 :> tiw0); 
    let w = new_rwidget :classe :name  setname:t#set_new_name in
    t#set_widget w;
    begin match meth with
    | `START -> self#widget#pack w
    | `ADD -> self#widget#add w
    | `END -> self#widget#pack from:`END w
    end;
    w#set_parent self#widget;
    property_add w;
    memo#add t#tree_item data:t;
    let classe = self#widget#classe in
    if List.mem classe in:bin1_list then begin
      may fun:tree_item#disconnect button_press_id;
      tree_item#drag#dest_unset ();
      if classe <> "window"
      then self#set_remove_menu ()
      else self#stop_third_button ()
    end

(* removes the present tiw from his parent and from the memo
   and does this recursively on the children *)
  method remove () =
    let remove_one_tiw (tiw : tiw0) =
      match tiw#parent_ti with
      | None -> ()
      | Some tip ->
	  memo#remove tiw#tree_item;
	  tiw#parent_tree#remove tiw#tree_item ;
	  tiw#widget#parent#remove tiw#widget;
	  property_remove tiw#widget in
    let rec remove_tiws (tiw : tiw0) =
      List.iter fun:remove_tiws
	(List.map fun:(fun ti -> memo#find ti) tiw#tree#children2);
      remove_one_tiw tiw in
    remove_tiws (self : #tiw0 :> tiw0);
      match parent_ti with 
      | None -> failwith "bug remove_widget"
      | Some tip ->
	  let classe = tip#widget#classe in
	  if List.mem classe in:bin1_list then begin
	    tip#tree_item#drag#dest_set
	      targets:[{ target = "STRING"; flags = []; info = 0}]
	      actions:[`COPY];
	    tip#set_add_menu classe tip#widget#name
	  end
      
  initializer
    parent_tree#append tree_item; 
    tree_item#set_subtree stree;
    tree_item#add label;
    tree_item#expand ();
end

let new_window :name =
  let tree_window = new window type:`TOPLEVEL show:true
      title:(name ^ "-Tree") in
  let vbox = new vbox spacing:2 packing:tree_window#add in
  let menu_bar = new menu_bar packing:(vbox#pack expand:false) in
  let mi = new menu_item label:"File" packing:menu_bar#append in
  let menu = new menu packing:mi#set_submenu in
  let mi_emit = new menu_item label:"emit code" packing:menu#append in
  let root_tree = new tree2 packing:vbox#pack in
  let tiw1 = new tiw parent_tree:root_tree :name in
  memo#add tiw1#tree_item data:tiw1;
  let gtk_window = new_rwidget classe:"window" :name setname:tiw1#set_new_name in

  tiw1#set_widget gtk_window;

  let sel () = match root_tree#selection with
  | [] -> None
  | sel :: _ -> Some (memo#find sel) in

  let emit () =
    let outc = open_out file:(gtk_window#name ^ ".ml") in
    let c = Oformat.of_channel outc in
    gtk_window#emit_code c;
    close_out outc in

  mi_emit#connect#activate callback:emit;

  let last_sel = ref (None : rwidget option) in

  root_tree#connect#selection_changed callback:(fun _ ->
    begin match !last_sel with
      | None -> ()
      |	Some sl -> sl#base#misc#set state:`NORMAL end;
    match root_tree#selection with
    | [] ->  last_sel := None
    | sel :: _  -> let ti = memo#find sel in
      ti#widget#base#misc#set state:`SELECTED;
      let x, y = Gdk.Window.get_position ti#tree_item#misc#window in
      let w, h = Gdk.Window.get_size ti#tree_item#misc#window in
      let x, y = Gdk.Window.get_position ti#tree#misc#window in
      let w, h = Gdk.Window.get_size ti#tree#misc#window in
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



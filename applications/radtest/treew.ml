open Misc
open Gtk
open GObj
open GContainer
open GWindow
open GMenu
open GMisc
open GMain
open GFrame
open GPack
open GButton
open GEdit

open GTree2

open Utils
open Property


(* possible children; used to make the menus *)
let widget_add_list =
  [ "vbox"; "hbox"; "frame"; "label"; "button";
    "toggle_button"; "check_button" ; "scrolled_window";
    "hseparator"; "vseparator" ; "entry" ]


(*********** selection ***********)

let selection = ref ""
let window_selection = ref ""


(**************** signals class ***************)

class tiwidget_signals :signals =
  let name_changed : string signal = signals in
  object
    method name_changed = name_changed#connect
  end


(************* class type ***************)
(* the ti<gtkwidget> classes encapsulate the corresponding gtk
   widget which will be in the gtk-window and a tree item
   labelled with the name of the widget which will be in the
   tree-window.
   all these classes have the same following interface *)

class virtual tiwidget0 = object
  method virtual widget : GObj.widget
  method virtual parent : tiwidget0 option
  method virtual set_parent : tiwidget0 -> unit
  method virtual base : GObj.widget
  method virtual tree_item : GTree2.tree_item2
  method virtual tree : GTree2.tree2
  method virtual children : (tiwidget0 * Gtk.Tags.pack_type) list
  method virtual name : string
  method virtual proplist : (string * Property.property) list
  method virtual add_to_proplist : (string * Property.property) list -> unit
  method virtual change_name_in_proplist : string -> string -> unit
  method virtual set_property : string -> string -> unit
  method virtual forall :  callback:(tiwidget0 -> unit) -> unit
  method virtual remove : tiwidget0 -> unit
  method virtual add_child_with_name : string -> string -> pos:int -> tiwidget0
  method virtual add_children : yywidget_tree -> ?pos:int -> unit
  method virtual add_children_wo_undo : yywidget_tree -> ?pos:int -> string
  method virtual remove_me  : unit -> unit
  method virtual remove_me_without_undo  : unit -> unit
  method virtual emit_code : Oformat.c -> unit
  method virtual emit_init_code : Oformat.c -> packing:string -> unit
  method virtual emit_method_code : Oformat.c -> unit
  method virtual save : Oformat.c -> unit
  method virtual copy : unit -> unit
  method virtual connect : tiwidget_signals
  method virtual disconnect : GtkSignal.id -> bool
  method virtual child_up : tiwidget0 -> unit
  method virtual up : unit -> unit
  method virtual child_down : tiwidget0 -> unit
  method virtual down : unit -> unit
  method virtual next : tiwidget0
  method virtual next_child : tiwidget0 -> tiwidget0
  method virtual last : tiwidget0
  method virtual prev : tiwidget0
  method virtual set_full_menu : bool -> unit
end

class virtual window_and_tree0 = object
(*  method virtual tiwin : tiwidget0
  method virtual tree_window : window *)
  method virtual change_selected : tiwidget0 -> unit
  method virtual remove_sel : tiwidget0 -> unit
(*  method virtual emit : unit -> unit *)
end

(* forward declaration of function new_widget *)
let new_tiwidget :
    (classe:string -> name:string -> parent_tree:tree2 -> ?pos:int ->
      parent_window:window_and_tree0 -> tiwidget0) ref =
  ref (fun classe:_ name:_ parent_tree:_ ?pos:_ [<-1>] parent_window:_ -> failwith "new_tiwidget")


let widget_map = new Omap.c []

(************* window creation class *************)
(* an instance of this class is created for each window opened
   in radtest. It contains the tree window and the gtk window (tiwin) *)

class window_and_tree :name =
  let tree_window = new window show:true title:(name ^ "-Tree") in
  let vbox = new vbox spacing:2 packing:tree_window#add in
(*  let menu_bar = new menu_bar packing:(vbox#pack expand:false) in
  let mi = new menu_item label:"File" packing:menu_bar#append in
  let menu = new menu packing:mi#set_submenu in
  let mi_emit = new menu_item label:"emit code" packing:menu#append in *)
  let root_tree = new tree2 packing:vbox#pack selection_mode:`EXTENDED in
  let project_tree_item = new tree_item2 in
  let label = new label text:name xalign:0. yalign:0.5 in

  object(self)

    inherit window_and_tree0

(* I use magic here because the real initialization is done
   below in the initializer part. It can't be done here because
   of the call to self *)
    val mutable tiwin = (Obj.magic 0 : tiwidget0)

    method tiwin = tiwin
    method tree_window = tree_window

    method project_tree_item = project_tree_item

(* the selected item in this window *)
    val mutable selected = (None : tiwidget0 option)

(* what to do when a new item is selected.
   this method is passed to all the tiwidgets (by the select_fun
   parameter) and they will call it when they are clicked on;
   she is also called when changing the selection the arrow keys
   (see in the initializer part) *)
    method change_selected sel =
      match selected with
      |	None ->
	  selected <- Some sel;
	  sel#tree_item#misc#set_state `SELECTED;
	  sel#base#misc#set_state `SELECTED;
	  prop_affich sel
      |	Some old_sel ->
	  if sel = old_sel then begin
	    selected <- None;
	    sel#base#misc#set_state `NORMAL;
	    sel#tree_item#misc#set_state `NORMAL
	  end else begin
	    old_sel#tree_item#misc#set_state `NORMAL;
	    old_sel#base#misc#set_state `NORMAL;
	    selected <- Some sel;
	    sel#tree_item#misc#set_state `SELECTED;
	    sel#base#misc#set_state `SELECTED;
	    prop_affich sel
	  end

(* the tiwidget tiw is being removed; if it was selected,
   put the selection to None *)
    method remove_sel tiw =
      match selected with
      |	Some sel when sel = tiw -> selected <- None
      |	_ -> ()

(* emits the code corresponding to this window *)
    method emit c = tiwin#emit_code c;

    method delete () =
      tiwin#remove_me_without_undo ();
      tree_window#destroy ();

    initializer
      project_tree_item#add label;
      tiwin <- !new_tiwidget classe:"window" :name parent_tree:root_tree
	  parent_window:(self : #window_and_tree0 :> window_and_tree0);

      tiwin#connect#name_changed callback:
	  (fun n -> label#set_text n; tree_window#set_title (n ^ "-Tree"));

      prop_affich tiwin;

      tree_window#connect#event#key_press callback:
	begin fun ev ->
	  let state = GdkEvent.Key.state ev in
	  let keyval = GdkEvent.Key.keyval ev in
	  if keyval = GdkKeysyms._Up then begin
	    match selected with
	    | None -> ()
	    | Some t -> 
		if test_modifier `CONTROL state then t#up ()
		else try
		  self#change_selected t#prev
		with Not_found -> ()
	  end
	  else if keyval = GdkKeysyms._Down then begin
	    match selected with
	    | None -> ()
	    | Some t -> 
		if test_modifier `CONTROL state then t#down ()
		else try
		  self#change_selected t#next
		with Not_found -> ()
	  end;
	  tree_window#stop_emit "key_press_event";
	  true
	end;
      ()
  end



(***************** class implementation *****************)
(* this is the base class of the ti<gtkwidget> hierarchy.
   all these classes will inherit from tiwidget, but without
   adding new methods. In this way all the classes have the
   same interface and we can use them in lists, pass them to
   functions without caring on the type.
   All methods needed by any of the classes are defined in
   tiwidget but if a method is not pertinent in tiwidget
   it has for implementation:
      failwith "<name of the method>"
   the real implementation of the method is done in the
   class (or classes) in which it is needed (or sometimes
   in tiwidget anyway).
   Additionally, to workaround some problem with recursive types
   the type of the (public) methods of tiwidget is defined in
   tiwidget0 of which tiwidget inherits.
   The parent_tree parameter is the tree in which the
   tiwidget#tree_item will be inserted at position :pos.
*)

class virtual tiwidget  :name parent_tree:(parent_tree : tree2) :pos
    :classe widget:w ?:root [<false>]
    parent_window:(parent_window : window_and_tree0) =
object(self)

  inherit tiwidget0
  inherit has_ml_signals

  val widget = (w : #widget :> widget)
  method widget = widget

  val mutable parent = None
  method set_parent p = parent <- Some p
  method parent =  parent
  method private sure_parent =
    match parent with
    | None -> failwith "sure_parent"
    | Some p -> p

  val evbox =
    if root then None
    else let ev = new event_box in ev#add w; Some ev
  method base = match evbox with
  | None -> w
  | Some ev -> (ev :> widget)


  val classe : string = classe

  val tree_item = new tree_item2
  method tree_item = tree_item

  val  mutable stree = new tree2
  method tree = stree

  val label = new label text:name xalign:0. yalign:0.5

  val mutable name : string = name
  method name = name

  method private class_name = ""  (* used in the init code *)

  val mutable proplist : (string * property) list = []
  method proplist = proplist
  method private get_mandatory_props = []

  method add_to_proplist plist = proplist <- proplist @ plist
(* for children of a box *)
  method change_name_in_proplist : string -> string -> unit =
    fun _ _ -> ()
  method set_property name value_string =
    set_property_in_list name value_string proplist
(* the proplist with some items removed e.g. the expand... in a box
   used for saving and emitting code *)
  method private emit_clean_proplist plist =
    List.fold_left acc:plist fun:
      (fun acc:pl propname -> List.remove_assoc propname in:pl)
	[ "name"; "expand"; "fill"; "padding" ]

  method private save_clean_proplist =
    List.remove_assoc "name" in:proplist

  val mutable children : (tiwidget0 * Gtk.Tags.pack_type) list = []
  method children = children
  method forall =
    fun :callback -> List.iter (List.map children fun:fst) fun:callback

(* encapsulate container#add and container#remove 
   they are here because they depend on the type of the widget:
   e.g.: gtkbin->add scrolled_window->add_with_viewport box->pack *)
  method private add = failwith (name ^ "::add")
  method remove = failwith (name ^ "::remove")


(* removes self from his parent;
   will be different for a window *)
  method remove_me () =
    let sref = ref "" in
    self#save_to_string sref;
    let pos = list_pos (self : #tiwidget0 :> tiwidget0)
	in:(List.map self#sure_parent#children fun:fst) in
    let lexbuf = Lexing.from_string !sref in
    let node = Paste_parser.widget Paste_lexer.token lexbuf in
    add_undo (Add (self#sure_parent#name, node, pos));
    self#remove_me_without_undo ()

  method remove_me_without_undo () =
(* it should be enough to only recursively remove the children from the
   name_list and do the tip#remove and tip#tree#remove
   only for self *)
    self#forall callback:(fun tiw -> tiw#remove_me_without_undo ());
    parent_window#remove_sel (self : #tiwidget0 :> tiwidget0);
    match parent with
    | None -> failwith "remove without parent"
    | Some (tip : #tiwidget0) ->
	tip#tree#remove tree_item;
	tip#remove (self : #tiwidget0 :> tiwidget0);
	name_list := list_remove !name_list pred:(fun n -> n=name);
	widget_map#remove key:name;
	prop_remove name

(* used for undo in add_child_tiw *)
  method private remove_child_by_name name () =
    let child = fst (List.find children
	pred:(fun (ch, _) -> ch#name = name)) in
    child#remove_me ()

(* adds a child and shows his properties;
   used when adding a child by the menu or DnD *)
  method private add_child classe () =
    let name = make_new_name classe in
    let child = !new_tiwidget :classe :name
	parent_tree:stree :parent_window in
    self#add_child_tiw child affich:true;
    add_undo (Remove name)

  method private add_child_tiw child :affich ?:pos [< -1 >] =
    child#set_parent (self : #tiwidget0 :> tiwidget0);
    self#add child :pos;
    if affich then prop_affich child (* else prop_add child *)

(* adds a child without showing immediatly his properties;
   used by load,  paste and undo via add_children.
   the pos param indicates the position of the child (meaningful
   if the parent is a box) pos=0 means first, pos=-1 means last *)
  method add_child_with_name classe name :pos = 
    let child =
      !new_tiwidget :classe :name parent_tree:stree :parent_window :pos in
    self#add_child_tiw child affich:false :pos;
    child


(* adds the subtree saved in the Node *)
  method add_children node ?:pos [< -1 >] =
    let child_name = self#add_children_wo_undo node :pos in
    add_undo (Remove child_name)

  method private add_children_wo_undo
      (Node (child, children)) ?:pos [< -1 >] =
    let classe, name, property_list = child in
    let rname = change_name name in
    let tc = self#add_child_with_name classe rname :pos in
    List.iter (List.rev children)
      fun:(fun c -> tc#add_children_wo_undo c; ());
    List.iter property_list fun:(fun (n,v) -> tc#set_property n v);
    rname

(* only a tiwindow can emit code *)
  method emit_code = failwith "emit_code"

(* some methods for emitting code *)
(* this one calculates the expand, fill and padding parameters
   of a window child *)
  method private get_packing packing =
    let aux name =
      match prop_modified (List.assoc name in:proplist) with
      | None -> ""
      | Some (_, vs) -> " " ^ name ^ ":" ^ vs in
    let efp = try
      (aux "expand") ^ (aux "fill") ^ (aux "padding")
    with Not_found -> "" in
    if efp = "" then ("packing:" ^ packing)
    else ("packing:(" ^ packing ^ efp ^ ")")

(* this one emits the declaration code of the widget *)
  method emit_init_code c :packing =
    Format.fprintf c#formatter "@ @[<hv 2>let %s =@ @[<hov 2>new %s"
      name self#class_name;
    List.iter self#get_mandatory_props fun:(fun name ->
      Format.fprintf c#formatter "@ %s:\"%s\"" name
	(get_value_string (List.assoc name in:proplist)));
    let packing = self#get_packing packing in
    if packing <> "" then Format.fprintf c#formatter "@ %s" packing;
    self#emit_prop_code c;
    Format.fprintf c#formatter "@]@]"

(* this one emits the properties which do not have their
   default value; used by emit_init_code *)
  method private emit_prop_code c =
    List.iter (self#emit_clean_proplist proplist)
    fun:(fun (name, prop) ->
      match prop_modified prop with
      |	None -> ()
      |	Some (codename, vs) ->
	  Format.fprintf c#formatter "@ %s:%s" codename vs);
    Format.fprintf c#formatter " in"

(* this one emits the method returning this widget *)
  method emit_method_code c =
    Format.fprintf c#formatter "@ method %s = %s" name name;

(* for saving the project to a file. Used also by copy and cut *)
  method private save_start : Oformat.c -> unit = fun c ->
    Format.fprintf c#formatter "@\n@[<2><%s name=%s>" classe name

  method private save_end : Oformat.c -> unit = fun c ->
    Format.fprintf c#formatter "@]@\n</%s>" classe

  method save c =
    self#save_start c;
    List.iter self#save_clean_proplist fun:
      (fun (name, prop) ->
	match prop_modified prop with
	| None -> ()
	| Some (_, s) -> Format.fprintf c#formatter "@\n\"%s\"=%s" name s);
    self#forall callback:(fun w -> w#save c);
    self#save_end c


  method private save_to_string string_ref =
    let to_sel = to_string string_ref in
    self#save to_sel;
    to_sel#flush

  method private copy_to_sel selection = self#save_to_string selection

  method copy () = self#copy_to_sel selection

  method private cut () =
    self#copy ();
    self#remove_me ()

  method private paste () =
    let lexbuf = Lexing.from_string !selection in
    let node = Paste_parser.widget Paste_lexer.token lexbuf in
    self#add_children node
    

(* ML signal used when the name of the widget is changed *)
  val name_changed : string signal = new signal
  method connect = new tiwidget_signals signals:name_changed
  method private call_name_changed = name_changed#call


(* this is necessary because gtk_tree#remove deletes the tree
   when removing the last item  *)
(* suppressed this in gtktree2 
  method new_tree () =
    stree <- new tree2;
    tree_item#set_subtree stree;
    tree_item#expand ()
*)

(* when full_menu is true we use the menu else the restricted menu *)
  val mutable full_menu  = true
  method set_full_menu b = full_menu <- b

(* the menu for this widget 
   This menu is recalculated when one clicks on the 3rd button.
   There is nothing to do e.g. when the name of the widget changes,
   it will change in the menu the next time. *)
  method private menu :time = self#restricted_menu :time

(* the restricted menu for this widget 
   used for containers when they are full *)
  method private restricted_menu :time =
    let menu = new menu in
    let mi_remove = new menu_item packing:menu#append
	label:"remove"
    and mi_cut  = new menu_item packing:menu#append
	label:"Cut"
    and mi_copy = new menu_item packing:menu#append
	label:"Copy" in
    mi_remove#connect#activate callback:self#remove_me;
    mi_copy#connect#activate callback:self#copy;
    mi_cut#connect#activate callback:self#cut;
    menu#popup button:3 :time

(* changes all that depends on the name *)
  method private set_new_name new_name =
    if test_unique new_name then begin
      widget_map#remove key:name;
      widget_map#add key:new_name data:(self : #tiwidget0 :> tiwidget0);
      label#set_text new_name;
      let old_name = name in
      name <- new_name;
      prop_change_name old_name new_name;
      name_list :=
	new_name :: (list_remove !name_list pred:(fun n -> n=old_name));
      begin match self#parent with
      | None -> ()
      | Some p -> p#change_name_in_proplist old_name new_name
      end;
      self#call_name_changed new_name
    end
    else message_name ()
	

(* moves the present tiw up in his parents' children list *)
(* does something only when the parent is a box *)
  method child_up = fun _ -> ()

  method up () = match parent with
  | None -> ()
  | Some t -> t#child_up (self : #tiwidget0 :> tiwidget0)

  method child_down = fun _ -> ()

  method down () = match parent with
  | None -> ()
  | Some t -> t#child_down (self : #tiwidget0 :> tiwidget0)


(* get the next tiwidget in the tree (used with Down arrow) *)
  method next =
    if children <> [] then fst (List.hd children)
    else begin
      match parent with
      |	None -> raise Not_found
      |	Some p -> p#next_child (self : #tiwidget0 :> tiwidget0)
    end

  method next_child child =
    let _, tl = cut_list elt:child (List.map fun:fst children) in
    match tl with
    | ch :: next :: _ -> next
    | ch :: [] -> begin
	match parent with
	| None -> raise Not_found
	| Some p -> p#next_child (self : #tiwidget0 :> tiwidget0)
    end
    | _ -> failwith "next_child"

(* get the last child of the last child ... of our last child.
   Used by prev. *)
  method last =
    if children = [] then (self : #tiwidget0 :> tiwidget0)
    else (fst (List.hd (List.rev children)))#last

(* get the previous tiwidget in the tree (used with Up arrow) *)
  method prev =
    match parent with
    | None -> raise Not_found
    | Some p ->
	let hd, _ = cut_list elt:(self : #tiwidget0 :> tiwidget0)
	    (List.map fun:fst p#children) in
	match hd with
	| [] -> p
	| h :: _ -> h#last

  initializer
    widget_map#add key:name data:(self : #tiwidget0 :> tiwidget0);
    name_list := name :: !name_list;
    parent_tree#insert tree_item :pos;
    tree_item#set_subtree stree;
    tree_item#add label;
    tree_item#expand ();

    proplist <-  proplist @
      [  "name",  String (new rval init:name inits:name codename:"name"
	       undo_fun:(fun vs -> add_undo (Property (name, "name", vs)))
			   setfun:self#set_new_name); 
        "width",  Int (new rval init:(-2) inits:"-2" codename:"width"
           undo_fun:(fun vs -> add_undo (Property (name, "width", vs)))
			       setfun:(fun v -> widget#misc#set_size width:v));
        "height", Int (new rval init:(-2) inits:"-2" codename:"height"
           undo_fun:(fun vs -> add_undo (Property (name, "height", vs)))
	     setfun:(fun v -> widget#misc#set_size height:v))  ];

    self#add_signal name_changed;

    tree_item#connect#event#button_press callback:
      (fun ev -> match GdkEvent.get_type ev with
      | `BUTTON_PRESS ->
	  if GdkEvent.Button.button ev = 1 then begin
	    parent_window#change_selected
	      (self : #tiwidget0 :> tiwidget0);
	  end
	  else if GdkEvent.Button.button ev = 3 then begin
	    if full_menu
	    then self#menu time:(GdkEvent.Button.time ev)
	    else self#restricted_menu time:(GdkEvent.Button.time ev);
	  end;
	  tree_item#stop_emit "button_press_event";
	  true
      | _ -> false);
    ()
end


(* for containers being able to have at least one child;
   not for buttons (can't have children) *)

class virtual ticontainer widget:(container : #container) :name
    ?:root [<false>] :classe :parent_tree :pos :parent_window =
object(self)

  inherit tiwidget :name :classe widget:(container :> widget) :root :parent_tree :pos :parent_window as widget

(* name of the add method: add for most bin widgets,
   pack for boxes, add_with_viewport for scrolled windows... *)
  method private name_of_add_method = "#add"

  method private add child :pos =
    container#add child#base;
    children <- [child, `START];
    self#set_full_menu false;
    tree_item#drag#dest_unset ()

  method remove child =
    container#remove child#base;
    children <- [];
    self#set_full_menu true;
    tree_item#drag#dest_set actions:[`COPY]
      targets:[ { target = "STRING"; flags = []; info = 0} ]

  method private menu :time =
    let menu = new menu and menu_add = new menu in
    List.iter
      fun:(fun n ->
	let mi = new menu_item packing:menu_add#append label:n
	in mi#connect#activate callback:(self#add_child n); ())
      widget_add_list;      
    let mi_add = new menu_item packing:menu#append
	label:("add to " ^ name)
    and mi_remove = new menu_item packing:menu#append
	label:("remove " ^ name)
    and mi_cut  = new menu_item packing:menu#append
	label:"Cut"
    and mi_copy = new menu_item packing:menu#append
	label:"Copy"
    and mi_paste = new menu_item packing:menu#append
	label:"Paste" in
    mi_remove#connect#activate callback:self#remove_me;
    mi_add#set_submenu menu_add;
    mi_copy#connect#activate callback:self#copy;
    mi_cut#connect#activate callback:self#cut;
    if !selection <> ""
    then begin mi_paste#connect#activate callback:self#paste; () end
    else mi_paste#misc#set_sensitive false;
    menu#popup button:3 :time

  method emit_init_code c :packing =
    widget#emit_init_code c :packing;
    self#forall callback:(fun child -> child#emit_init_code c
	packing:(name ^ self#name_of_add_method))

  method emit_method_code c =
    widget#emit_method_code c;
    self#forall callback:(fun child -> child#emit_method_code c)


  initializer
    proplist <-  proplist @
      [ "border width",   Int (new rval init:0 inits:"0" codename:"border_width"
           undo_fun:(fun vs -> add_undo (Property (name, "border width" , vs)))
	       setfun:(fun v -> container#set_border_width v)) ];

    tree_item#drag#dest_set actions:[`COPY]
      targets:[ { target = "STRING"; flags = []; info = 0} ];
    tree_item#connect#drag#data_received callback:
      begin fun (context : drag_context) :x :y
	  (data : selection_data) :info :time ->
	    self#add_child data#data ();
	    context#finish success:true del:false :time
      end;()
end

class tiwindow widget:(window : #window) :name :parent_tree :pos :parent_window =
object(self)

  inherit ticontainer :name classe:"window" widget:window root:true :parent_tree :pos :parent_window as container

  method private class_name = "GWindow.window"

  method private get_mandatory_props = [ "title" ]

  method private save_clean_proplist =
    List.remove_assoc "title" in:container#save_clean_proplist

  method private emit_clean_proplist plist =
    List.remove_assoc "title" in:(container#emit_clean_proplist plist)

  method remove_me () =
    let sref = ref "" in
    self#save_to_string sref;
    let lexbuf = Lexing.from_string !sref in
    let node = Wpaste_parser.window Wpaste_lexer.token lexbuf in
    add_undo (Add_window node);
    self#remove_me_without_undo ()

  method copy () = self#copy_to_sel window_selection

  method remove_me_without_undo () =
    self#forall callback:(fun tiw -> tiw#remove_me_without_undo ());
    parent_window#remove_sel (self : #tiwidget0 :> tiwidget0);
    name_list := list_remove !name_list pred:(fun n -> n=name);
    widget_map#remove key:name;
    prop_remove name;
    widget#destroy ()

  method private get_packing packing = ""

  method emit_code c =
    Format.fprintf c#formatter "(* Code for %s *)@\n@\n@[<hv 2>class %s ="
      name name;
    self#emit_init_code c packing:"";
(*    Format.fprintf c#formatter "  let %s = new %s title:%s"
      name self#class_name (get_string_prop "title" in:proplist);
    self#emit_prop_code c;
*)
    Format.fprintf c#formatter "@]@\n@[<hv 2>object (self)";
    self#emit_method_code c;
    Format.fprintf c#formatter "@ method show () = %s#show ()" name;
    Format.fprintf c#formatter
      "@ @[<v 2>initializer@ (* signal handlers here *)@ ()@]@]@ end@\n@\n"

  method private save_start : Oformat.c -> unit = fun c ->
    Format.fprintf c#formatter "@[<0>@\n@[<2><window name=%s>" name;
    Format.fprintf c#formatter "@\n\"title\"=%s"
      (get_string_prop "title" in:proplist)

  method private save_end : Oformat.c -> unit = fun c ->
    Format.fprintf c#formatter "@]@\n</window>@\n@]"

  method private menu :time =
    let menu = new menu and menu_add = new menu in
    List.iter
      fun:(fun n ->
	let mi = new menu_item packing:menu_add#append label:n
	in mi#connect#activate callback:(self#add_child n); ())
      widget_add_list;      
    let mi_add = new menu_item packing:menu#append label:("add to " ^ name)
    and mi_paste = new menu_item packing:menu#append label:"Paste"
    in
    mi_add#set_submenu menu_add;
    if !selection <> ""
    then begin mi_paste#connect#activate callback:self#paste; () end
    else mi_paste#misc#set_sensitive false;
    menu#popup button:3 :time


  initializer
    window#set_title name;
    proplist <-	proplist @
      ["title", String
	 (new rval init:name inits:name codename:"title"
	    undo_fun:(fun vs -> add_undo (Property (name, "title", vs)))
	    setfun:window#set_title);
       "allow_shrink", Bool
	 (new rval init:true inits:"true" codename:"allow_shrink"
            undo_fun:(fun vs -> add_undo (Property (name, "allow_shrink", vs)))
	    setfun:window#set_allow_shrink);
       "allow_grow", Bool
	 (new rval init:true inits:"true" codename:"allow_grow"
            undo_fun:(fun vs -> add_undo (Property (name, "allow_grow", vs)))
	    setfun:window#set_allow_grow);
       "auto_shrink", Bool
	 (new rval init:false inits:"false" codename:"auto_shrink"
            undo_fun:(fun vs -> add_undo (Property (name, "auto_shrink", vs)))
	    setfun:window#set_auto_shrink);
       "x position", Int
	 (new rval init:(-2)  inits:"-2" codename:"x"
            undo_fun:(fun vs -> add_undo (Property (name, "x position", vs)))
	    setfun:(fun x -> window#misc#set_position :x));
      "y position", Int
	 (new rval init:(-2) inits:"-2" codename:"y"
            undo_fun:(fun vs -> add_undo (Property (name, "y position", vs)))
	    setfun:(fun y -> window#misc#set_position :y))  ]
end

let new_tiwindow :name =
  let w = new window show:true in 
  w#misc#set_can_focus false;
  w#misc#set_can_default false;
  new tiwindow widget:w :name




class tibox dir:(dir : Gtk.Tags.orientation) widget:(box : #box)
    :name :parent_tree :pos :parent_window =
object(self)

  inherit ticontainer :name widget:box :parent_tree :pos :parent_window
      classe:(match dir with `VERTICAL -> "vbox" | _ -> "hbox") as container

  method private class_name =
    match dir with `VERTICAL -> "GPack.vbox" | _ -> "GPack.hbox"

  method private name_of_add_method = "#pack"

(* removes the ::expand ::fill ::padding in the proplist of a box
   assumes that these are the only properties with a :: in the name *)
  method private save_clean_proplist =
    snd (list_split container#save_clean_proplist
	   pred:(fun (n,p) ->
	     try
	       let i = String.index n char:':' in
	       i < (String.length n) && n.[i+1]=':'
	     with Not_found -> false))

  method private emit_clean_proplist pl =
    snd (list_split (container#emit_clean_proplist pl)
	   pred:(fun (n,p) ->
	     try
	       let i = String.index n char:':' in
	       i < (String.length n) && n.[i+1]=':'
	     with Not_found -> false))

  method change_name_in_proplist oldn newn =
    proplist <- List.fold_left acc:proplist fun:
	(fun acc:pl propname ->
	  change_property_name (oldn ^ propname) (newn ^ propname) pl)
	[ "::expand"; "::fill"; "::padding" ];
    prop_update (self : #tiwidget0 :> tiwidget0)

  method child_up child =
    let pos = list_pos child in:(List.map fun:fst children) in
    if pos > 0 then begin
      box#reorder_child child#base pos:(pos-1);
      children <- list_reorder_up children :pos;
      stree#item_up :pos
    end
	    
  method child_down child =
    let pos = list_pos child in:(List.map fun:fst children) in
    if pos < (List.length children - 1) then begin
      box#reorder_child child#base pos:(pos+1);
      children <- list_reorder_down children :pos;
      stree#item_up pos:(pos+1)
    end
	    
  method private add child :pos =
    box#pack  child#base;
    if pos < 0 then begin
      children <-  children @ [(child, `START)]
    end
    else begin
      children <- list_insert (child, `START) in:children :pos;
      box#reorder_child child#base :pos
    end;
    let n = child#name in
    let expand = Bool (new rval init:true inits:"true" codename:"expand"
	  setfun:(fun v -> box#set_child_packing (child#base) expand:v;
		 prop_update child;
		 prop_update (self : #tiwidget0 :> tiwidget0))
	  undo_fun:(fun vs -> add_undo (Property (n, "expand", vs))))
    and fill = Bool (new rval init:true inits:"true" codename:"fill"
	   setfun:(fun v -> box#set_child_packing (child#base) fill:v;
		 prop_update child;
		 prop_update (self : #tiwidget0 :> tiwidget0))
	  undo_fun:(fun vs -> add_undo (Property (n, "fill", vs))))
    and padding = Int (new rval init:0 inits:"0" codename:"padding"
	  setfun:(fun v -> box#set_child_packing (child#base) padding:v;
		 prop_update child;
		 prop_update (self : #tiwidget0 :> tiwidget0))
	  undo_fun:(fun vs -> add_undo (Property (n, "padding", vs))))
    in
    proplist <-  proplist @ 
      [ (n ^ "::expand"),  expand;
	(n ^ "::fill"),    fill;
        (n ^ "::padding"), padding ];
    child#add_to_proplist
      [ "expand", expand; "fill", fill; "padding", padding ];
    prop_update (self : #tiwidget0 :> tiwidget0)
         

  method remove child =
    box#remove (child#base);
    children <- list_remove pred:(fun (ch, _) -> ch = child) children;
    let n = child#name in
    proplist <-  List.fold_left
	fun:(fun :acc n -> List.remove_assoc n in:acc)
	acc:proplist
	[ (n ^ "::expand"); (n ^ "::fill"); (n ^ "::padding") ];
    prop_update (self : #tiwidget0 :> tiwidget0)
(*
  method emit_init_code c :packing =
    Format.fprintf c#formatter "  let %s = new %s %s"
      name self#class_name (self#get_packing packing);
    self#emit_prop_code c;
    self#forall callback:(fun child ->
      child#emit_init_code c packing:(name ^ "#pack"))
*)
(*  method emit_code c =
    let startl, endl =
      list_split pred:(fun (_, dir) -> dir=`START) children in
    List.iter (List.rev startl)
      fun:(fun (rw, _) -> rw#emit_code c;
	Format.fprintf c#formatter
	  "%s#pack %s expand:%s fill:%s padding:%d;@\n"
    List.iter (List.rev endl)
      fun:(fun (rw, _) -> rw#emit_code c;
	Format.fprintf c#formatter
	  "%s#pack from: `END %s expand:%s fill:%s padding:%d;@\n"
*)    
  initializer
    proplist <-  proplist @
      ["homogeneous", Bool
	 (new rval init:false inits:"false" codename:"homogeneous"
            undo_fun:(fun vs -> add_undo (Property (name, "homogeneous", vs)))
	    setfun:box#set_homogeneous);
       "spacing", Int
	 (new rval init:0 inits:"0" codename:"spacing"
            undo_fun:(fun vs -> add_undo (Property (name, "spacing", vs)))
	    setfun:box#set_spacing) ]
end

class tihbox = tibox dir:`HORIZONTAL
class tivbox = tibox dir:`VERTICAL

let new_tihbox :name = new tihbox widget:(new hbox) :name
let new_tivbox :name = new tivbox widget:(new vbox) :name

(*
class ti_prebutton = object

  method private clean_proplist = proplist

  method private save_start : Oformat.c -> unit = fun c ->
    Format.fprintf c#formatter "@\n@[<2><%s name=%s>" classe name;
    Format.fprintf c#formatter "@\n\"label\"=%s"
      (get_string_prop "label" in:proplist)

  method emit_init_code (c : Oformat.c) :packing =
    Format.fprintf c#formatter
      "  let %s = new %s label:\"%s\" %s in@\n" name self#class_name
      (get_string_prop "label" in:proplist) packing

  initializer
    proplist <-  proplist @ [
      "border width",
	Int (new rval init:0 inits:"0" codename:"border_width"
           undo_fun:(fun vs -> add_undo (Property (name, "border width", vs)))
	       setfun:(fun v -> button#set_border_width v));
      "label",   String (new rval init:name inits:name codename:"label"
           undo_fun:(fun vs -> add_undo (Property (name, "label", vs)))
             setfun:(fun v -> button#remove (List.hd button#children);
	       button#add (new label text:v xalign:0.5 yalign:0.5)))
    ]
end
*)

(* the button inherits from widget because it can't accept
   a child; 
   needs to add the border_width property *)
class tibutton widget:(button : #button) :name :parent_tree :pos :parent_window = object(self)

  inherit tiwidget :name classe:"button" widget:(button :> widget) :parent_tree :pos :parent_window as widget

  method private class_name = "GButton.button"

  method private get_mandatory_props = [ "label" ]

  method private save_clean_proplist =
    List.remove_assoc "label" in:widget#save_clean_proplist

  method private emit_clean_proplist plist =
    List.remove_assoc "label" in:(widget#emit_clean_proplist plist)


  method private save_start : Oformat.c -> unit = fun c ->
    Format.fprintf c#formatter "@\n@[<2><%s name=%s>" classe name;
    Format.fprintf c#formatter "@\n\"label\"=%s"
      (get_string_prop "label" in:proplist)

(*  method emit_init_code c :packing =
    Format.fprintf c#formatter
      "  let %s = new %s label:\"%s\" %s" name self#class_name
      (get_string_prop "label" in:proplist) (self#get_packing packing);
    self#emit_prop_code c
*)
  initializer
    proplist <-  proplist @ [
      "border width",
	Int (new rval init:0 inits:"0" codename:"border_width"
           undo_fun:(fun vs -> add_undo (Property (name, "border width", vs)))
	       setfun:(fun v -> button#set_border_width v));
      "label",   String (new rval init:name inits:name codename:"label"
           undo_fun:(fun vs -> add_undo (Property (name, "label", vs)))
             setfun:(fun v -> button#remove (List.hd button#children);
	       button#add (new label text:v xalign:0.5 yalign:0.5)))
    ]
end

let new_tibutton :name = new tibutton
    widget:(let b = new button label:name in
    b#connect#event#enter_notify
      callback:(fun _ -> b#stop_emit "enter_notify_event"; true);
    b#connect#event#leave_notify
      callback:(fun _ -> b#stop_emit "leave_notify_event"; true); b)
    :name


class ticheck_button widget:(button : check_button) :name :parent_tree :pos :parent_window = object(self)

  inherit tiwidget :name classe:"check_button" widget:(button :> widget) :parent_tree :pos :parent_window as widget


  method private class_name = "GButton.check_button"

  method private get_mandatory_props = [ "label" ]

  method private save_clean_proplist =
    List.remove_assoc "label" in:widget#save_clean_proplist

  method private emit_clean_proplist plist =
    List.remove_assoc "label" in:(widget#emit_clean_proplist plist)

  method private save_start : Oformat.c -> unit = fun c ->
    Format.fprintf c#formatter "@\n@[<2><%s name=%s>" classe name;
    Format.fprintf c#formatter "@\n\"label\"=%s"
      (get_string_prop "label" in:proplist)

(*  method emit_init_code c :packing =
    Format.fprintf c#formatter
      "  let %s = new %s label:\"%s\" %s" name self#class_name
      (get_string_prop "label" in:proplist) (self#get_packing packing);
    self#emit_prop_code c
*)

  initializer
    proplist <-  proplist @ [
      "border width",
	Int (new rval init:0 inits:"0" codename:"border_width"
           undo_fun:(fun vs -> add_undo (Property (name, "border width", vs)))
	       setfun:(fun v -> button#set_border_width v));
      "label",   String (new rval init:name inits:name codename:"label"
           undo_fun:(fun vs -> add_undo (Property (name, "label", vs)))
             setfun:(fun v -> button#remove (List.hd button#children);
	       button#add (new label text:v xalign:0.5 yalign:0.5)))
    ]
end

let new_ticheck_button :name = new ticheck_button
    widget:(let b = new check_button label:name in b) :name



class titoggle_button widget:(button : toggle_button) :name :parent_tree :pos :parent_window = object(self)

  inherit tiwidget :name classe:"toggle_button" widget:(button :> widget) :parent_tree :pos :parent_window as widget

  method private class_name = "GButton.toggle_button"

  method private get_mandatory_props = [ "label" ]

  method private save_clean_proplist =
    List.remove_assoc "label" in:widget#save_clean_proplist

  method private emit_clean_proplist plist =
    List.remove_assoc "label" in:(widget#emit_clean_proplist plist)

  method private save_start : Oformat.c -> unit = fun c ->
    Format.fprintf c#formatter "@\n@[<2><%s name=%s>" classe name;
    Format.fprintf c#formatter "@\n\"label\"=%s"
      (get_string_prop "label" in:proplist)

(*  method emit_init_code c :packing =
    Format.fprintf c#formatter
      "  let %s = new %s label:\"%s\" %s" name self#class_name
      (get_string_prop "label" in:proplist) (self#get_packing packing);
    self#emit_prop_code c
*)

  initializer
    proplist <-  proplist @ [
      "border width",
	Int (new rval init:0 inits:"0" codename:"border_width"
           undo_fun:(fun vs -> add_undo (Property (name, "border width", vs)))
	       setfun:(fun v -> button#set_border_width v));
      "label",   String (new rval init:name inits:name codename:"label"
           undo_fun:(fun vs -> add_undo (Property (name, "label", vs)))
             setfun:(fun v -> button#remove (List.hd button#children);
	       button#add (new label text:v xalign:0.5 yalign:0.5)))
    ]
end

let new_titoggle_button :name = new titoggle_button :name
    widget:(let b = new toggle_button label:name in
    b#connect#event#enter_notify
      callback:(fun _ -> b#stop_emit "enter_notify_event"; true);
    b#connect#event#leave_notify
      callback:(fun _ -> b#stop_emit "leave_notify_event"; true); b)



class tilabel widget:(labelw : label) :name :parent_tree :pos :parent_window =
object(self)

  inherit tiwidget :name classe:"label" widget:(labelw :> widget) :parent_tree :pos :parent_window as widget

  method private class_name = "GMisc.label"

  method private get_mandatory_props = [ "text" ]

  method private save_clean_proplist =
    List.remove_assoc "label" in:widget#save_clean_proplist

  method private emit_clean_proplist plist =
    List.remove_assoc "label" in:(widget#emit_clean_proplist plist)

  method private save_start : Oformat.c -> unit = fun c ->
    Format.fprintf c#formatter "@\n@[<2><%s name=%s>" classe name;
    Format.fprintf c#formatter "@\n\"text\"=%s"
      (get_string_prop "text" in:proplist)

(*  method emit_init_code (c : Oformat.c) :packing =
    Format.fprintf c#formatter
      "  let %s = new %s text\"%s\" %s" name self#class_name
      (get_string_prop "text" in:proplist) (self#get_packing packing);
    self#emit_prop_code c
*)

  initializer
    proplist <-  proplist @
      ["text", String
	 (new rval init:name inits:name codename:"text"
            undo_fun:(fun vs -> add_undo (Property (name, "text", vs)))
            setfun:labelw#set_text);
       "line_wrap", Bool
	 (new rval init:true inits:"true" codename:"line_wrap"
            undo_fun:(fun vs -> add_undo (Property (name, "line_wrap", vs)))
	    setfun:labelw#set_line_wrap);    ]
end

let new_tilabel :name = new tilabel widget:(new label text:name) :name


class tiframe widget:(frame : frame) :name :parent_tree :pos :parent_window =
  object
  inherit ticontainer
      classe:"frame" :name widget:frame :parent_tree :pos :parent_window

  method private class_name = "GFrame.frame"

  initializer
    frame#set_label name;
    proplist <- proplist @
      ["label", String
	 (new rval init:name inits:name codename:"label"
            undo_fun:(fun vs -> add_undo (Property (name, "label", vs)))
	    setfun:frame#set_label);
       "label xalign", Float
	 (new rval init:0.0 inits:"0.0" codename:"label_xalign"
            undo_fun:(fun vs -> add_undo (Property (name, "label xalign", vs)))
	    value_list:["min", 0. ; "max", 1.]
            setfun:(fun x -> frame#set_label_align :x));
       "shadow", Shadow
	 (new rval init:`ETCHED_IN inits:"ETCHED_IN" codename:"shadow"
            undo_fun:(fun vs -> add_undo (Property (name, "shadow", vs)))
	    setfun:frame#set_shadow_type) ]
end

let new_tiframe :name = new tiframe widget:(new frame) :name


class tiscrolled_window widget:(scrolled_window : scrolled_window)
    :name :parent_tree :pos :parent_window =
  object(self)
    inherit ticontainer classe:"scrolled_window" :name
	:parent_tree :pos widget:scrolled_window :parent_window

    method private class_name = "GFrame.scrolled_window"
    method private name_of_add_method = "#add_with_viewport"


    method private add rw :pos =
      scrolled_window#add_with_viewport (rw#base);
      children <- [ rw, `START];
      self#set_full_menu false;
      tree_item#drag#dest_unset ()
(*
  method emit_init_code c :packing =
    Format.fprintf c#formatter "  let %s = new %s %s"
      name self#class_name (self#get_packing packing);
    self#emit_prop_code c;
    self#forall callback:(fun child -> child#emit_init_code c
	packing:(name ^ "#add_with_viewport"))
*)

(* we must remove the child from the viewport,
   not from the scrolled_window;
   it is not mandatory to remove the viewport
   from the scrolled_window *)
    method remove child =
      let viewport = (new GContainer.container (GtkBase.Container.cast (List.hd scrolled_window#children)#as_widget)) in
      viewport#remove child#base;
(*      scrolled_window#remove (List.hd scrolled_window#children); *)
      children <- [ ];
      self#set_full_menu true;
      tree_item#drag#dest_set actions:[`COPY]
	targets:[ { target = "STRING"; flags = []; info = 0} ]


    initializer
      proplist <- proplist @
	["hscrollbar policy", Policy
	   (new rval init:`ALWAYS inits:"ALWAYS" codename:"hscrollbar_policy"
              undo_fun:(fun vs ->
		add_undo (Property (name, "hscrollbar policy", vs)))
	      setfun:scrolled_window#set_hpolicy);
	 "vscrollbar policy", Policy
	   (new rval init:`ALWAYS inits:"ALWAYS" codename:"vscrollbar_policy"
              undo_fun:(fun vs ->
		add_undo (Property (name, "vscrollbar policy", vs)))
	      setfun:scrolled_window#set_vpolicy); ]
end

let new_tiscrolled_window :name =
  new tiscrolled_window widget:(new scrolled_window) :name


class tiseparator dir:(dir : Gtk.Tags.orientation)
    widget:(separator : separator) :name :parent_tree :pos :parent_window =
object

  inherit tiwidget :name
      widget:(separator :> widget) :parent_tree :pos :parent_window
      classe:(match dir with `VERTICAL -> "vseparator"
                           | `HORIZONTAL -> "hseparator")

  method private class_name = match dir with `VERTICAL -> "GMisc.vseparator"
      | `HORIZONTAL -> "GMisc.hseparator"

end

let new_tihseparator :name = new tiseparator dir: `HORIZONTAL :name
    widget:(new separator `HORIZONTAL)
let new_tivseparator :name = new tiseparator dir: `VERTICAL :name
    widget:(new separator `VERTICAL)



class tientry widget:(entry : entry) :name :parent_tree :pos :parent_window =
object

  inherit tiwidget :name widget:(entry :> widget) :parent_tree :pos
      classe:"entry" :parent_window

  method private class_name = "GEdit.entry"

end

let new_tientry :name = new tientry :name widget:(new entry)



let new_class_list = [
  "window",          new_tiwindow ;
  "hbox",            new_tihbox;
  "vbox",            new_tivbox;
  "button",          new_tibutton;
  "check_button",    new_ticheck_button;
  "toggle_button",   new_titoggle_button;
  "label",           new_tilabel;
  "frame",           new_tiframe;
  "scrolled_window", new_tiscrolled_window;
  "hseparator",      new_tihseparator;
  "vseparator",      new_tivseparator;
  "entry",           new_tientry
]
;;

new_tiwidget := fun :classe ?:pos [<-1>] -> (List.assoc classe in:new_class_list) :pos
;;


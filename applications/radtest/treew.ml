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
  method virtual change_name_in_proplist : string -> string -> unit
  method virtual set_property : string -> string -> unit
  method virtual forall : 'a . callback:(tiwidget0 -> 'a) -> 'a list
  method virtual remove : tiwidget0 -> unit
  method virtual add_child_with_name : string -> string -> tiwidget0
  method virtual remove_me  : unit -> unit
  method virtual emit_code : Oformat.c -> unit
  method virtual save : Oformat.c -> unit
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


(* forward declaration of function new_widget *)
let new_tiwidget :
    (classe:string -> name:string -> parent_tree:tree2 ->
      select_fun:(tiwidget0 -> unit) -> tiwidget0) ref =
  ref (fun classe:_ name:_ parent_tree:_ select_fun:_ -> failwith "new_tiwidget")



(************* window creation class *************)
(* an instance of this class is created for each window opened
   in radtest. It contains the tree window and the gtk window (tiwin) *)
class window_and_tree :name =
  let tree_window = new window show:true title:(name ^ "-Tree") in
  let vbox = new vbox spacing:2 packing:tree_window#add in
  let menu_bar = new menu_bar packing:(vbox#pack expand:false) in
  let mi = new menu_item label:"File" packing:menu_bar#append in
  let menu = new menu packing:mi#set_submenu in
  let mi_emit = new menu_item label:"emit code" packing:menu#append in
  let root_tree = new tree2 packing:vbox#pack selection_mode:`EXTENDED in

  object(self)

(* I use magic here because the real initialization is done
   below in the initializer part. It can't be done here because
   of the call to self#change_selected *)
    val mutable tiwin = (Obj.magic 0 : tiwidget0)

    method tiwin = tiwin
    method tree_window = tree_window

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
	  sel#tree_item#misc#set state:`SELECTED;
	  sel#base#misc#set state:`SELECTED;
	  prop_affich sel
      |	Some old_sel ->
	  if sel = old_sel then begin
	    selected <- None;
	    sel#base#misc#set state:`NORMAL;
	    sel#tree_item#misc#set state:`NORMAL
	  end else begin
	    old_sel#tree_item#misc#set state:`NORMAL;
	    old_sel#base#misc#set state:`NORMAL;
	    selected <- Some sel;
	    sel#tree_item#misc#set state:`SELECTED;
	    sel#base#misc#set state:`SELECTED;
	    prop_affich sel
	  end

(* emits the code corresponding to this window *)
    method emit () =
      let outc = open_out file:(tiwin#name ^ ".ml") in
      let c = Oformat.of_channel outc in
      tiwin#emit_code c;
      close_out outc


    initializer
      tiwin <- !new_tiwidget classe:"window" :name parent_tree:root_tree
	  select_fun:self#change_selected;

      mi_emit#connect#activate callback:self#emit;

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
   All methods needed by any of the class are defined in
   tiwidget but if a method is not pertinent in tiwidget
   it has for implementation:
      failwith "<name of the method>"
   the real implementation of the method is done in the
   class (or classes) in which it is needed (or sometimes
   in tiwidget anyway).
   Additionally, to workaround some problem with recursive types
   the type of the (public) methods of tiwidget is defined in
   tiwidget0 of which tiwidget inherits *)

class virtual tiwidget  :name parent_tree:(parent_tree : tree2)
    :classe widget:w ?:root [<false>] :select_fun =   
object(self)

  inherit tiwidget0
  inherit has_ml_signals

  val widget = (w : #widget :> widget)
  method widget = widget

  val mutable parent = None
  method set_parent p = parent <- Some p
  method parent =  parent

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

  val mutable proplist : (string * property) list = []
  method proplist = proplist
(* for children of a box *)
  method change_name_in_proplist : string -> string -> unit =
    fun _ _ -> ()
  method set_property name value_string =
    set_property_in_list name value_string proplist


  val mutable children : (tiwidget0 * Gtk.Tags.pack_type) list = []
  method children = children
  method forall : 'a . callback:(_ -> 'a) -> 'a list =
    fun :callback -> List.map (List.map children fun:fst) fun:callback

(* encapsulate container#add and container#remove 
   they are here because they depend on the type of the widget:
   e.g.: gtkbin->add scrolled_window->add_with_viewport box->pack *)
  method private add = failwith (name ^ "::add")
  method remove = failwith (name ^ "::remove")


(* removes self from his parent *)
(* it should be enough to only recursively remove the children from the
   name_list and do the tip#remove and tip#tree#remove
   only for self *)
  method remove_me () =
    self#forall callback:(fun tiw -> tiw#remove_me ());
    match parent with
    | None -> failwith "remove without parent"
    | Some (tip : #tiwidget0) ->
	tip#tree#remove tree_item;
	tip#remove (self : #tiwidget0 :> tiwidget0);
	name_list := list_remove !name_list pred:(fun n -> n=name);
	prop_remove name

(* adds a child and shows his properties;
   used when adding a child by the menu or DnD *)
  method private add_child classe () = 
    let index = ref 1 in
    let name = ref (classe ^ "1") in
    while not (test_unique !name) do
      incr index;
      name := classe ^ (string_of_int !index)
    done;
    let child =
      !new_tiwidget :classe name:!name parent_tree:stree :select_fun in
    self#add_child_tiw child affich:true;

  method private add_child_tiw child :affich =
    child#set_parent (self : #tiwidget0 :> tiwidget0);
    self#add child;
    if affich then prop_affich child else prop_add child

(* adds a child without showing immediatly his properties;
   used by load and paste *)
  method add_child_with_name classe name = 
    let child =
      !new_tiwidget :classe :name parent_tree:stree :select_fun in
    self#add_child_tiw child affich:false;
    child



  method private emit_start_code : Oformat.c -> unit = fun _ -> ()
  method private emit_end_code : Oformat.c -> unit = fun _ -> ()
  method virtual emit_code : Oformat.c -> unit


(* for saving the project to a file. Used also by copy and cut *)
  method private save_start : Oformat.c -> unit = fun c ->
    Format.fprintf c#formatter
      "@\n@[<2><%s name=%s>" classe name
  method private save_end : Oformat.c -> unit = fun c ->
    Format.fprintf c#formatter
      "@]@\n</%s>" classe
  method save : Oformat.c -> unit = fun c ->
    self#save_start c;
    List.iter proplist fun:
      (fun (name, prop) ->
	match prop_modified prop with
	| None -> ()
	| Some s -> Format.fprintf c#formatter "@\n\"%s\"=%s" name s);
    self#forall callback:(fun w -> w#save c);
    self#save_end c

  method private copy () =
    let to_sel = to_string selection in
    self#save to_sel;
    to_sel#flush

  method private cut () =
    self#copy ();
    self#remove_me ()

  method private paste () =
    let lexbuf = Lexing.from_string !selection in
    let node = Paste_parser.widget Paste_lexer.token lexbuf in
    let rec add_children (t : tiwidget0) (Node (child, children)) =
      let classe, name, property_list = child in
      let rname = ref name in
      while not (test_unique !rname) do
	rname := change_name !rname
      done;
      let tc = t#add_child_with_name classe !rname in
      List.iter (List.rev children) fun:(fun c -> add_children tc c);
      List.iter property_list fun:(fun (n,v) -> tc#set_property n v) in
    add_children (self : #tiwidget0 :> tiwidget0) node
    

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
   the default menu has just a remove item.
   This menu is recalculated when one clicks on the 3rd button.
   There is nothing to do e.g. when the name of the widget changes,
   it will change in the menu the next time. *)
  method private menu :time =
    let menu = new menu in
    let mi_remove = new menu_item packing:menu#append
	label:"remove" in
    mi_remove#connect#activate callback:self#remove_me;
    menu#popup button:3 :time

(* the restricted menu for this widget 
   used for containers when they are full *)
  method private restricted_menu :time = self#menu :time

(* changes all that depends on the name *)
  method private set_new_name new_name =
    if test_unique new_name then begin
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
    name_list := name :: !name_list;
    parent_tree#append tree_item;
    tree_item#set_subtree stree;
    tree_item#add label;
    tree_item#expand ();

    proplist <-  proplist @
      [  "name", String (new rval init:name inits:name
			   setfun:self#set_new_name); 
        "width",        Int (new rval init:(-2) inits:"-2"
			       setfun:(fun v -> widget#misc#set width:v));
        "height",       Int (new rval init:(-2) inits:"-2"
	     setfun:(fun v -> widget#misc#set height:v))  ];

    self#add_signal name_changed;

    tree_item#connect#event#button_press callback:
      (fun ev -> match GdkEvent.get_type ev with
      | `BUTTON_PRESS ->
	  if GdkEvent.Button.button ev = 1 then begin
	    select_fun (self : #tiwidget0 :> tiwidget0);
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
    ?:root [<false>] :classe :parent_tree :select_fun =
object(self)

  inherit tiwidget :name :classe widget:(container :> widget) :root :parent_tree :select_fun as super

  method private add w =
    container#add w#base;
    children <- [w, `START];
    self#set_full_menu false;
    tree_item#drag#dest_unset ()

  method remove w =
    container#remove w#base;
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
	label:"Paste"
    in
    mi_remove#connect#activate callback:self#remove_me;
    mi_add#set_submenu menu_add;
    mi_paste#connect#activate callback:self#paste;
    mi_copy#connect#activate callback:self#copy;
    mi_cut#connect#activate callback:self#cut;
    menu#popup button:3 :time


  method emit_code c =
    self#emit_start_code c;
    Format.fprintf c#formatter
      "%s#set_border_width %d;@\n"
      name (get_int_prop "border width" in:proplist);
    begin match children with
    | [] -> Format.fprintf c#formatter "();@\n"
    | [ child, _ ] ->
	child#emit_code c;
	Format.fprintf c#formatter "%s#add %s;@\n" name child#name
    | _ -> failwith "bug: rwindow#emit_code"
    end;
    self#emit_end_code c;

  initializer
    proplist <-  proplist @
      [ "border width",
	Int (new rval init:0 inits:"0"
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

class tiwindow widget:(window : #window) :name :parent_tree :select_fun =
object(self)

  inherit ticontainer :name classe:"window" widget:window root:true :parent_tree :select_fun

  method private emit_start_code c =
    Format.fprintf c#formatter
      "@[<v 0>open GObj@\nopen GData@\nopen GWindow@\nopen GPack@\nopen GFrame@\nopen GMisc@\nopen GEdit@\nopen GButton@\nopen GMain@\n@\nlet %s () =@\n@]"
      name;
    Format.fprintf c#formatter
      "@[<v 2>let %s  = new window show:true title:\"%s\" allow_shrink:%s allow_grow:%s auto_shrink:%s %s %s %s %s in@\n"
      name (get_string_prop "title" in:proplist)
      (get_enum_prop "allow_shrink" in:proplist)
      (get_enum_prop "allow_grow" in:proplist)
      (get_enum_prop "auto_shrink" in:proplist)
      (let x =  get_int_prop "x position" in:proplist in
        if x>0 then (" x:" ^ (string_of_int x)) else "")
      (let y = get_int_prop "y position" in:proplist in
        if y>0 then (" y:" ^ (string_of_int y)) else "")
      (let w = get_int_prop "width" in:proplist in
        if w>0 then (" width:" ^ (string_of_int w)) else "")
      (let h = get_int_prop "height" in:proplist in
        if h>0 then (" height:" ^ (string_of_int h)) else "");

  method private emit_end_code c =
    Format.fprintf c#formatter
      "%s@\n@]@." name

  method private save_start : Oformat.c -> unit = fun c ->
    Format.fprintf c#formatter "@[<0>@\n@[<2><window name=%s>" name
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
    mi_paste#connect#activate callback:self#paste;
    menu#popup button:3 :time

  method private restricted_menu :time = ()

  initializer
    window#set_wm title:name;
    proplist <-	proplist @  [
          "title",
          String (new rval init:name inits:name
	    setfun:(fun v -> window#set_wm title:v));
	"allow_shrink", Bool (new rval init:true inits:"true"
	   setfun:(fun v -> window#set_policy allow_shrink:v));
	"allow_grow",   Bool (new rval init:true inits:"true"
	setfun:(fun v -> window#set_policy allow_grow:v));
      "auto_shrink",  Bool (new rval init:false inits:"false"
	setfun:(fun v -> window#set_policy auto_shrink:v));
      "x position",   Int (new rval init:(-2)  inits:"-2"
	     setfun:(fun v -> window#misc#set x:v));
      "y position",   Int (new rval init:(-2) inits:"-2"
	     setfun:(fun v -> window#misc#set y:v))  ]
end

let new_tiwindow :name = new tiwindow widget:(new window show:true) :name




class tibox dir:(dir : Gtk.Tags.orientation) widget:(box : #box) :name :parent_tree :select_fun =
object(self)

  inherit ticontainer :name widget:box :parent_tree :select_fun
      classe:(match dir with `VERTICAL -> "vbox" | _ -> "hbox")

  method change_name_in_proplist oldn newn =
    proplist <- List.fold_left acc:proplist fun:
	(fun acc:pl propname ->
	  change_property_name (oldn ^ propname) (newn ^ propname) pl)
	[ "::expand"; "::fill"; "::padding" ]
(*    property_update newn *)

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
	    
  method private add child =
    box#pack  (child#base);
    children <-  children @ [(child, `START)];
    let n = child#name in
    proplist <-  proplist @ 
      [ (n ^ "::expand"),  Bool (new rval init:true inits:"true"
	  setfun:(fun v -> box#set_child_packing (child#base) expand:v));
	(n ^ "::fill"),    Bool (new rval init:true inits:"true"
	   setfun:(fun v -> box#set_child_packing (child#base) fill:v));
        (n ^ "::padding"), Int (new rval init:0 inits:"0"
	  setfun:(fun v -> box#set_child_packing (child#base) padding:v))
      ];
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

  method emit_code c =
    Format.fprintf c#formatter
      "let %s = new box %s homogeneous:%s spacing:%d in@\n"
      name
      (match dir with `VERTICAL -> "`VERTICAL" | _ -> "`HORIZONTAL")
      (get_enum_prop "homogeneous" in:proplist)
      (get_int_prop "spacing" in:proplist);
    
    let startl, endl =
      list_split pred:(fun (_, dir) -> dir=`START) children in
    List.iter (List.rev startl)
      fun:(fun (rw, _) -> rw#emit_code c;
	Format.fprintf c#formatter
	  "%s#pack %s expand:%s fill:%s padding:%d;@\n"
	  name rw#name
	  (get_enum_prop (rw#name ^ "::expand") in:proplist)
	  (get_enum_prop (rw#name ^ "::fill") in:proplist)
	  (get_int_prop (rw#name ^ "::padding") in:proplist));
    List.iter (List.rev endl)
      fun:(fun (rw, _) -> rw#emit_code c;
	Format.fprintf c#formatter
	  "%s#pack from: `END %s expand:%s fill:%s padding:%d;@\n"
	  name rw#name
	  (get_enum_prop (rw#name ^ "::expand") in:proplist)
	  (get_enum_prop (rw#name ^ "::fill") in:proplist)
	  (get_int_prop (rw#name ^ "::padding") in:proplist))
    
  initializer
    proplist <-  proplist @ [
       "homogeneous",  Bool (new rval init:false inits:"false"
	  setfun:(fun v -> box#set_packing homogeneous:v));
      "spacing",      Int (new rval init:0 inits:"0"
	  setfun:(fun v -> box#set_packing spacing:v)) ]
end

class tihbox = tibox dir:`HORIZONTAL
class tivbox = tibox dir:`VERTICAL

let new_tihbox :name = new tihbox widget:(new hbox) :name
let new_tivbox :name = new tivbox widget:(new vbox) :name



(* the button inherits from widget because it can't accept
   a child; 
   needs to add the border_width property *)
class tibutton widget:(button : #button) :name :parent_tree :select_fun =
object

  inherit tiwidget :name classe:"button" widget:(button :> widget) :parent_tree :select_fun as widget


  method emit_code c =
    Format.fprintf c#formatter
      "let %s = new button label:\"%s\" in@\n" name name

  initializer
    proplist <-  proplist @ [
      "border width",
	Int (new rval init:0 inits:"0"
	       setfun:(fun v -> button#set_border_width v));
      "label",   String (new rval init:name inits:name
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


class ticheck_button widget:(button : check_button) :name :parent_tree :select_fun =
object

  inherit tiwidget :name classe:"check_button" widget:(button :> widget) :parent_tree :select_fun


  method emit_code c =
    Format.fprintf c#formatter
      "let %s = new check_button label:\"%s\" in@\n" name name

  initializer
    proplist <-  proplist @ [
      "border width",
	Int (new rval init:0 inits:"0"
	       setfun:(fun v -> button#set_border_width v));
      "label",   String (new rval init:name inits:name
             setfun:(fun v -> button#remove (List.hd button#children);
	       button#add (new label text:v xalign:0.5 yalign:0.5)))
    ]
end

let new_ticheck_button :name = new ticheck_button
    widget:(let b = new check_button label:name in b) :name



class titoggle_button widget:(button : toggle_button) :name :parent_tree :select_fun =
object

  inherit tiwidget :name classe:"toggle_button" widget:(button :> widget) :parent_tree :select_fun


  method emit_code c =
    Format.fprintf c#formatter
      "let %s = new toggle_button label:\"%s\" in@\n" name name

  initializer
    proplist <-  proplist @ [
      "border width",
	Int (new rval init:0 inits:"0"
	       setfun:(fun v -> button#set_border_width v));
      "label",   String (new rval init:name inits:name
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



class tilabel widget:(labelw : label) :name :parent_tree :select_fun =
object

  inherit tiwidget :name classe:"label" widget:(labelw :> widget) :parent_tree :select_fun


  method emit_code c =
    Format.fprintf c#formatter
      "let %s = new label text:\"%s\" in@\n" name
      (get_string_prop "text" in:proplist)

  initializer
(*    labelw#set_text name; *)
    proplist <-  proplist @ [
      "text",   String (new rval init:name inits:name
             setfun:(fun v -> labelw#set_text v));
       "line_wrap",  Bool (new rval init:true inits:"true"
	  setfun:(fun v -> labelw#set_label line_wrap:v));    ]
end

let new_tilabel :name = new tilabel widget:(new label text:name) :name


class tiframe widget:(frame : frame) :name :parent_tree :select_fun =
  object
  inherit ticontainer classe:"frame" :name widget:frame :parent_tree :select_fun

  method private emit_start_code c =
    Format.fprintf c#formatter
      "let %s = new frame label:\"%s\" label_xalign:%1.1f shadow_type:`%s in@\n"
      name (get_string_prop "label" in:proplist) 
      (get_float_prop "label xalign" in:proplist)
      (get_enum_prop "shadow" in:proplist)
         
  initializer
    frame#set_label name;
    proplist <-  proplist @ [
          "label", String (new rval init:name inits:name
	     setfun:(fun v -> frame#set_label v));
          "label xalign", Float (new rval init:0.0 inits:"0.0"
				   value_list:["min", 0. ; "max", 1.]
             setfun:(fun v -> frame#set_label xalign:v));
          "shadow", Shadow (new rval init:`ETCHED_IN inits:"ETCHED_IN"
	     setfun:(fun v -> frame#set_shadow_type v))
    ]
end

let new_tiframe :name = new tiframe widget:(new frame) :name


class tiscrolled_window widget:(scrolled_window : scrolled_window)
    :name :parent_tree :select_fun =
  object(self)
    inherit ticontainer classe:"scrolled_window" :name :parent_tree widget:scrolled_window :select_fun

    method private add rw =
      scrolled_window#add_with_viewport (rw#base);
      children <- [ rw, `START];
      self#set_full_menu false;
      tree_item#drag#dest_unset ()


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


    method private emit_start_code c =
      Format.fprintf c#formatter
	"let %s = new scrolled_window hpolicy:`%s vpolicy:`%s in@\n"
	name
	(get_enum_prop "hscrollbar policy" in:proplist)
	(get_enum_prop "vscrollbar policy" in:proplist)
         
    initializer
      proplist <- proplist @ [
       "hscrollbar policy", Policy (new rval init:`ALWAYS inits:"ALWAYS"
	 setfun:(fun v -> scrolled_window#set_scrolled hpolicy:v));
	"vscrollbar policy", Policy (new rval init:`ALWAYS inits:"ALWAYS"
	  setfun:(fun v -> scrolled_window#set_scrolled vpolicy:v));
      ]
end

let new_tiscrolled_window :name = new tiscrolled_window widget:(new scrolled_window) :name


class tiseparator dir:(dir : Gtk.Tags.orientation) widget:(separator : separator) :name :parent_tree :select_fun =
object

  inherit tiwidget :name widget:(separator :> widget) :parent_tree :select_fun
      classe:(match dir with `VERTICAL -> "vseparator"
      | `HORIZONTAL -> "hseparator")


  method emit_code c =
    Format.fprintf c#formatter
      "let %s = new separator %s in@\n" name
      (match dir with `VERTICAL -> "`VERTICAL" | _ -> "`HORIZONTAL")

end

let new_tihseparator :name = new tiseparator dir: `HORIZONTAL :name
    widget:(new separator `HORIZONTAL)
let new_tivseparator :name = new tiseparator dir: `VERTICAL :name
    widget:(new separator `VERTICAL)



class tientry widget:(entry : entry) :name :parent_tree :select_fun =
object

  inherit tiwidget :name widget:(entry :> widget) :parent_tree
      classe:"entry" :select_fun


  method emit_code c =
    Format.fprintf c#formatter
      "let %s = new entry in@\n" name

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

new_tiwidget := fun :classe -> List.assoc classe in:new_class_list
;;


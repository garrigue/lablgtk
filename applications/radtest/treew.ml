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

open Property


external test_modifier : Gdk.Tags.modifier -> int -> bool
    = "ml_test_GdkModifier_val"



(*********** some utility functions **************)
let rec list_remove pred:f = function
  | [] -> []
  | hd :: tl -> if f hd then tl else hd :: (list_remove pred:f tl)

let rec list_split pred:f = function
  | [] -> [], []
  | hd :: tl -> let g, d = list_split pred:f tl in
    if f hd then (hd :: g, d) else (g, hd :: d)

let list_pos ch in:l =
  let rec aux pos = function
    | [] -> raise Not_found
    | hd :: tl -> if hd = ch then pos else aux (pos+1) tl
  in aux 0 l

(* moves the pos element up; pos is >= 1;
   the first element is numbered 0 *)
let rec list_reorder_up :pos = function
    | hd1 :: hd2 :: tl when pos = 1 -> hd2 :: hd1 :: tl
    | hd :: tl when pos > 1 -> hd :: (list_reorder_up pos:(pos-1) tl)
    | _ -> failwith "list_reorder"

(* moves the pos element down; pos is < length of l - 1;
   the first element is numbered 0 *)
let rec list_reorder_down :pos = 
  list_reorder_up pos:(pos+1)

let rec change_property_name oldname newname = function
  | (n, p) :: tl when oldname = n -> (newname, p) :: tl
  | (n, p) :: tl -> (n, p) :: change_property_name oldname newname tl
  | [] -> failwith "change_property_name: name not found"

(********************* memo ***************************)

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



let signal_id = ref 0

let next_callback_id () : GtkSignal.id =
  decr signal_id; Obj.magic (!signal_id : int)

class ['a] signal = object
  val mutable callbacks : (GtkSignal.id * ('a -> unit)) list = []
  method connect :callback ?:after [< false >] =
    let id = next_callback_id () in
    callbacks <-
      if after then callbacks @ [id,callback] else (id,callback)::callbacks;
    id
  method call arg =
    List.iter callbacks fun:(fun (_,f) -> f arg)
  method disconnect id =
    List.mem_assoc id in:callbacks &&
    (callbacks <- List.remove_assoc id in:callbacks; true)
  method reset () = callbacks <- []
end

class type disconnector =
  object
    method disconnect : GtkSignal.id -> bool
    method reset : unit -> unit
  end

class has_ml_signals = object
  val mutable disconnectors = []
  method private add_signal : 'a. 'a signal -> unit =
    fun sgn -> disconnectors <- (sgn :> disconnector) :: disconnectors

  method disconnect id =
    List.exists disconnectors pred:(fun d -> d#disconnect id)
end

class tiwidget_signals :signals =
  let name_changed : string signal = signals in
  object
    method name_changed = name_changed#connect
  end

(***************  used for the name of the widgets *************)
let index = ref 0


(* possible children; used to make the menus *)
let widget_add_list =
  [ "vbox"; "hbox"; "frame"; "label"; "button";
    "toggle_button"; "check_button" ; "scrolled_window";
    "hseparator"; "vseparator" ; "entry" ]


class type ['wrap] pre_tiwidget = object
  method child_up : 'wrap -> unit
  method child_down : 'wrap -> unit
  method emit_code : Oformat.c -> unit
  method name : string
  method change_name_in_proplist : string -> string -> unit
  method save : Oformat.c -> unit
end

class virtual ['tiwidget] pre_tiwrapper0 = object
  constraint 'tiwidget = 'tiwidget pre_tiwrapper0 #pre_tiwidget
  method virtual tiw : 'tiwidget
  method virtual add_child : string -> unit -> unit
  method virtual add_child_with_name :
      string -> string -> 'tiwidget pre_tiwrapper0
  method virtual remove_me : unit -> unit
  method virtual set_parent : 'tiwidget pre_tiwrapper0 -> unit
  method virtual parent : 'tiwidget pre_tiwrapper0 option
end

class virtual tiwrapper0 = [tiwidget] pre_tiwrapper0

and virtual tiwidget  :name parent_tree:(parent_tree : tree2)
    :classe widget:w ?:root [<false>] =   
object(self : 'stype)

  inherit has_ml_signals

  val widget = (w : #widget :> widget)
  method widget = widget

  val mutable glob : tiwrapper0 option = None
  method set_glob g =  glob <- Some g
  method glob = match glob with
  | None -> raise Not_found
  | Some g -> g

  val evbox =
    if root then None
    else let ev = new event_box in ev#add w; Some ev
  method base = match evbox with
  | None -> w
  | Some ev -> (ev :> widget)


  val classe : string = classe
(*  method classe = classe *)

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
  method set_property name values =
    set_property_in_list name values proplist

(*
  val mutable parent_ti : tiwidget option = None
  method parent_ti = parent_ti
  method set_parent_ti p = parent_ti <- Some p
*)
      
  val mutable children : (tiwidget * Gtk.Tags.pack_type) list = []
  method children = children

  method forall : callback:_ -> unit =
    fun :callback -> List.iter (List.map children fun:fst) fun:callback

(* correspond to container#add and container#remove *)
  method add        : tiwidget -> unit = failwith (name ^ "::add")
  method remove     : tiwidget -> unit = failwith (name ^ "::remove")

  method private emit_start_code : Oformat.c -> unit = fun _ -> ()
  method private emit_end_code : Oformat.c -> unit = fun _ -> ()
  method virtual emit_code : Oformat.c -> unit


  method private save_start : Oformat.c -> unit = fun c ->
    Format.fprintf c#formatter
      "<CLASS> %s %s@\n" classe name
  method private save_end : Oformat.c -> unit = fun c -> ()
  method save : Oformat.c -> unit = fun c ->
    self#save_start c;
    Format.fprintf c#formatter "<CHILD>@\n";
    self#forall callback:(fun w -> w#save c);
    Format.fprintf c#formatter "</CHILD>@\n";
    self#save_end c

  val name_changed : string signal = new signal
  method connect = new tiwidget_signals signals:name_changed
  method call_name_changed = name_changed#call

(* this is necessary because gtk_tree#remove deletes the tree
   when removing the last item  *)
(* suppressed this in gtktree2 
  method new_tree () =
    stree <- new tree2;
    tree_item#set_subtree stree;
    tree_item#expand ()
*)
(* signal id of button_press handler *)
  val mutable button_press_id = None

(* true if the current menu is the add_menu; for changing the name *)
(*  val mutable menu_set = false *)

(* the menu for this widget 
   the default menu has just a remove item *)
  method menu : 
      add:(string -> unit -> unit) -> remove:(unit -> unit) -> menu =
	fun add:_ :remove ->
	  let menu = new menu in
	  let mi_remove = new menu_item packing:menu#append
	      label:"remove" in
	  mi_remove#connect#activate callback:remove;
	  menu


(* the restricted menu for this widget 
   used for containers when they are full *)
  method restricted_menu : remove:(unit -> unit) -> menu =
    failwith (name ^ "restricted_menu")

(* sets the add menu of the tree_item; the stop_emit
   stops the default action of button 3 (hiding the tree) 
   the drag_data_received is set in the initializer because
   it needs to be done only once *)
  method set_menu () =
(*    menu_set <- true; *)
    may button_press_id fun:tree_item#disconnect;
    button_press_id <- Some
	(tree_item#connect#event#button_press callback:
	   (fun ev -> match GdkEvent.get_type ev with
	   | `BUTTON_PRESS ->
	       if GdkEvent.Button.button ev = 3 then begin
		 tree_item#stop_emit "button_press_event";
		 (self#menu
		    add:self#glob#add_child
		    remove:self#glob#remove_me)#popup
                   button:3 time:(GdkEvent.Button.time ev)
	       end;
	       true
	   | _ -> false));

  method set_restricted_menu () =
(*    menu_set <- true; *)
    may button_press_id fun:tree_item#disconnect;
    button_press_id <- Some
	(tree_item#connect#event#button_press callback:
	   (fun ev -> match GdkEvent.get_type ev with
	   | `BUTTON_PRESS ->
	       if GdkEvent.Button.button ev = 3 then begin
		 tree_item#stop_emit "button_press_event";
		 (self#restricted_menu remove:self#glob#remove_me)#popup
                   button:3 time:(GdkEvent.Button.time ev)
	       end;
	       true
	   | _ -> false))



(* changes all that depends on the name *)
  method set_new_name new_name =
    label#set_text new_name;
    let old_name = name in
    name <- new_name;
    property_update new_name;
    begin match self#glob#parent with
    | None -> ()
    | Some p -> p#tiw#change_name_in_proplist old_name new_name
    end;
    self#call_name_changed new_name
	

(* moves the present tiw up in his parents' children list *)
(* does something only when the parent is a box *)
  method child_up : tiwrapper0 -> unit = fun _ -> ()

  method up () = match self#glob#parent with
  | None -> ()
  | Some (t : tiwrapper0) -> t#tiw#child_up self#glob

  method child_down : tiwrapper0 -> unit = fun _ -> ()

  method down () = match self#glob#parent with
  | None -> ()
  | Some (t : tiwrapper0) -> t#tiw#child_down self#glob

  initializer
    parent_tree#append tree_item;
    tree_item#set_subtree stree;
    tree_item#add label;
    tree_item#expand ();
    self#set_menu ();

    proplist <-  proplist @
      [  "name", String (new rval init:name setfun:self#set_new_name); 
        "width",        Int (new rval init:(-2)
			       setfun:(fun v -> widget#misc#set width:v));
        "height",       Int (new rval init:(-2)
	     setfun:(fun v -> widget#misc#set height:v))  ];

    self#add_signal name_changed

end


(* for containers being able to have at least one child;
   not for buttons (can't have children) *)

class virtual ticontainer widget:(container : #container) :name
    ?:root [<false>] :classe :parent_tree =
object(self)

  inherit tiwidget :name :classe widget:(container :> widget) :root :parent_tree as super

  method add w =
    container#add w#base;
    children <- [w, `START];
    self#set_restricted_menu ()

  method remove w =
    container#remove w#base;
    children <- [];
    self#set_menu ()
    

  method menu :add :remove =
    let menu = new menu and menu_add = new menu in
    List.iter
      fun:(fun n ->
	let mi = new menu_item packing:menu_add#append label:n
	in mi#connect#activate callback:(add n); ())
      widget_add_list;      
    let mi_add = new menu_item packing:menu#append label:("add to " ^ name)
    and mi_remove = new menu_item packing:menu#append
	label:("remove " ^ name) in
    mi_remove#connect#activate callback:remove;
    mi_add#set_submenu menu_add;
    menu

  method restricted_menu :remove =
    let menu = new menu in
    let mi_remove = new menu_item packing:menu#append label:"remove" in
    mi_remove#connect#activate callback:remove;
    menu

  method set_menu () =
    super#set_menu ();
    tree_item#drag#dest_set actions:[`COPY]
      targets:[ { target = "STRING"; flags = []; info = 0} ]
    
  method set_restricted_menu () =
    super#set_restricted_menu ();
    tree_item#drag#dest_unset ()
    

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
	Int (new rval init:0
	       setfun:(fun v -> container#set_border_width v)) ];

    tree_item#connect#drag#data_received callback:
      begin fun (context : drag_context) :x :y
	  (data : selection_data) :info :time ->
	    self#glob#add_child data#data ();
	    context#finish success:true del:false :time
      end;()
end

class tiwindow widget:(window : #window) :name :parent_tree =
object

  inherit ticontainer :name classe:"window" widget:window root:true :parent_tree

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
    Format.fprintf c#formatter "<WINDOW> %s@\n" name
  method private save_end : Oformat.c -> unit = fun c ->
    Format.fprintf c#formatter "</WINDOW>@\n"

  method menu :add remove:_ =
    let menu = new menu and menu_add = new menu in
    List.iter
      fun:(fun n ->
	let mi = new menu_item packing:menu_add#append label:n
	in mi#connect#activate callback:(add n); ())
      widget_add_list;      
    let mi_add = new menu_item packing:menu#append label:("add to " ^ name)
    in
    mi_add#set_submenu menu_add;
    menu

  method set_restricted_menu () =
(*    menu_set <- false; *)
    may button_press_id fun:tree_item#disconnect;
    button_press_id <- Some
	(tree_item#connect#event#button_press callback:
	   (fun ev -> match GdkEvent.get_type ev with
	   | `BUTTON_PRESS ->
	       if GdkEvent.Button.button ev = 3 then begin
		 tree_item#stop_emit "button_press_event";
		 true end else false
	   | _ -> false));
    tree_item#drag#dest_unset ()

  initializer
    window#set_wm title:name;
    proplist <-	proplist @  [
          "title",
          String (new rval init:name
	    setfun:(fun v -> window#set_wm title:v));
	"allow_shrink", Bool (new rval init:true inits:"true"
	   setfun:(fun v -> window#set_policy allow_shrink:v));
	"allow_grow",   Bool (new rval init:true inits:"true"
	setfun:(fun v -> window#set_policy allow_grow:v));
      "auto_shrink",  Bool (new rval init:false inits:"false"
	setfun:(fun v -> window#set_policy auto_shrink:v));
      "x position",   Int (new rval init:(-2)
	     setfun:(fun v -> window#misc#set x:v));
      "y position",   Int (new rval init:(-2)
	     setfun:(fun v -> window#misc#set y:v))  ]
end

let new_tiwindow :name = new tiwindow widget:(new window show:true) :name




class tibox dir:(dir : Gtk.Tags.orientation) widget:(box : #box) :name :parent_tree =
object

  inherit ticontainer :name widget:box :parent_tree
      classe:(match dir with `VERTICAL -> "vbox" | _ -> "hbox")

  method change_name_in_proplist oldn newn =
    proplist <- List.fold_left acc:proplist fun:
	(fun acc:pl propname ->
	  change_property_name (oldn ^ propname) (newn ^ propname) pl)
	[ "::expand"; "::fill"; "::padding" ];
    property_update newn

  method child_up child =
    let pos = list_pos child#tiw in:(List.map fun:fst children) in
    if pos > 0 then begin
      box#reorder_child child#tiw#base pos:(pos-1);
      children <- list_reorder_up children :pos;
      stree#item_up :pos
    end
	    
  method child_down child =
    let pos = list_pos child#tiw in:(List.map fun:fst children) in
    if pos < (List.length children - 1) then begin
      box#reorder_child child#tiw#base pos:(pos+1);
      children <- list_reorder_down children :pos;
      stree#item_up pos:(pos+1)
    end
	    
  method add child =
    box#pack  (child#base);
    children <-  children @ [(child, `START)];
    let n = child#name in
    proplist <-  proplist @ 
      [ (n ^ "::expand"),  Bool (new rval init:true inits:"true"
	  setfun:(fun v -> box#set_child_packing (child#base) expand:v));
	(n ^ "::fill"),    Bool (new rval init:true inits:"true"
	   setfun:(fun v -> box#set_child_packing (child#base) fill:v));
        (n ^ "::padding"), Int (new rval init:0
	  setfun:(fun v -> box#set_child_packing (child#base) padding:v))
      ]
         

  method remove child =
    box#remove (child#base);
    children <- list_remove pred:(fun (ch, _) -> ch = child) children;
    let n = child#name in
    proplist <-  List.fold_left
	fun:(fun :acc n -> List.remove_assoc n in:acc)
	acc:proplist
	[ (n ^ "::expand"); (n ^ "::fill"); (n ^ "::padding") ]

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
      "spacing",      Int (new rval init:0
	  setfun:(fun v -> box#set_packing spacing:v)) ]
end

class tihbox = tibox dir:`HORIZONTAL
class tivbox = tibox dir:`VERTICAL

let new_tihbox :name = new tihbox widget:(new hbox) :name
let new_tivbox :name = new tivbox widget:(new vbox) :name



(* the button inherits from widget because it can't accept
   a child; 
   needs to add the border_width property *)
class tibutton widget:(button : #button) :name :parent_tree =
object

  inherit tiwidget :name classe:"button" widget:(button :> widget) :parent_tree


  method emit_code c =
    Format.fprintf c#formatter
      "let %s = new button label:\"%s\" in@\n" name name

  initializer
    proplist <-  proplist @ [
      "border_width",
	Int (new rval init:0
	       setfun:(fun v -> button#set_border_width v));
      "label",   String (new rval init:name
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


class ticheck_button widget:(button : check_button) :name :parent_tree =
object

  inherit tiwidget :name classe:"check_button" widget:(button :> widget) :parent_tree


  method emit_code c =
    Format.fprintf c#formatter
      "let %s = new check_button label:\"%s\" in@\n" name name

  initializer
    proplist <-  proplist @ [
      "border width",
	Int (new rval init:0
	       setfun:(fun v -> button#set_border_width v));
      "label",   String (new rval init:name
             setfun:(fun v -> button#remove (List.hd button#children);
	       button#add (new label text:v xalign:0.5 yalign:0.5)))
    ]
end

let new_ticheck_button :name = new ticheck_button
    widget:(let b = new check_button label:name in b) :name



class titoggle_button widget:(button : toggle_button) :name :parent_tree =
object

  inherit tiwidget :name classe:"toggle_button" widget:(button :> widget) :parent_tree


  method emit_code c =
    Format.fprintf c#formatter
      "let %s = new toggle_button label:\"%s\" in@\n" name name

  initializer
    proplist <-  proplist @ [
      "border width",
	Int (new rval init:0
	       setfun:(fun v -> button#set_border_width v));
      "label",   String (new rval init:name
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



class tilabel widget:(label : label) :name :parent_tree =
object

  inherit tiwidget :name classe:"label" widget:(label :> widget) :parent_tree


  method emit_code c =
    Format.fprintf c#formatter
      "let %s = new label text:\"%s\" in@\n" name
      (get_string_prop "text" in:proplist)

  initializer
    label#set_text name;
    proplist <-  proplist @ [
      "text",   String (new rval init:name
             setfun:(fun v -> label#set_text v))
    ]
end

let new_tilabel :name = new tilabel widget:(new label) :name


class tiframe widget:(frame : frame) :name :parent_tree = object
  inherit ticontainer classe:"frame" :name widget:frame :parent_tree

  method private emit_start_code c =
    Format.fprintf c#formatter
      "let %s = new frame label:\"%s\" label_xalign:%1.1f shadow_type:`%s in@\n"
      name (get_string_prop "label" in:proplist) 
      (get_float_prop "label xalign" in:proplist)
      (get_enum_prop "shadow" in:proplist)
         
  initializer
    frame#set_label name;
    proplist <-  proplist @ [
          "label", String (new rval init:name
	     setfun:(fun v -> frame#set_label v));
          "label xalign", Float (new rval init:0.0 value_list:["min", 0. ; "max", 1.]
             setfun:(fun v -> frame#set_label xalign:v));
          "shadow", Shadow (new rval init:`ETCHED_IN inits:"ETCHED_IN"
	     setfun:(fun v -> frame#set_shadow_type v))
    ]
end

let new_tiframe :name = new tiframe widget:(new frame) :name


class tiscrolled_window widget:(scrolled_window : scrolled_window)
    :name :parent_tree =
  object(self)
    inherit ticontainer classe:"scrolled_window" :name :parent_tree widget:scrolled_window

    method add rw =
      scrolled_window#add_with_viewport (rw#base);
      children <- [ rw, `START];
      self#set_restricted_menu ()

(* we must remove the child from the viewport,
   not from the scrolled_window;
   it is not mandatory to remove the viewport
   from the scrolled_window *)
    method remove child =
      let viewport = (new GContainer.container (GtkBase.Container.cast (List.hd scrolled_window#children)#as_widget)) in
      viewport#remove child#base;
(*      scrolled_window#remove (List.hd scrolled_window#children); *)
      children <- [ ];
      self#set_menu ()


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


class tiseparator dir:(dir : Gtk.Tags.orientation) widget:(separator : separator) :name :parent_tree =
object

  inherit tiwidget :name widget:(separator :> widget) :parent_tree
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



class tientry widget:(entry : entry) :name :parent_tree =
object

  inherit tiwidget :name widget:(entry :> widget) :parent_tree
      classe:"entry"


  method emit_code c =
    Format.fprintf c#formatter
      "let %s = new entry in@\n" name

end

let new_tientry :name = new tientry :name widget:(new entry)






let new_class_list = [
  "window", new_tiwindow ;
  "hbox",   new_tihbox;
  "vbox",   new_tivbox;
  "button", new_tibutton;
  "check_button", new_ticheck_button;
  "toggle_button", new_titoggle_button;
  "label",  new_tilabel;
  "frame",  new_tiframe;
  "scrolled_window", new_tiscrolled_window;
  "hseparator", new_tihseparator;
  "vseparator", new_tivseparator;
  "entry", new_tientry
]

let new_tiwidget :classe = List.assoc classe in:new_class_list



class tiwrapper :classe :name parent_tree:(parent_tree : tree2) =
object(self : 'stype)
  inherit tiwrapper0

  val tiw = new_tiwidget :classe :name :parent_tree
  method tiw = tiw


  val mutable parent = None
  method set_parent p = parent <- Some p
  method parent =  parent


(* removes self from his parent *)
  method remove_me () =
    let remove_one_tiwr (tiwr : tiwrapper0) =
      match tiwr#parent with
      | None -> failwith "remove without parent"
      | Some (tip : tiwrapper0) ->
	  memo#remove tiwr#tiw#tree_item;
	  tip#tiw#tree#remove tiwr#tiw#tree_item;
	  tip#tiw#remove tiwr#tiw;
	  property_remove tiwr#tiw in
    let rec remove_tiws (tw : tiwidget) =
      List.iter fun:remove_tiws (List.map fun:fst tw#children);
      remove_one_tiwr tw#glob in
    remove_tiws tiw


  method add_child_with_name classe name = 
    let (child : tiwrapper0) = new tiwrapper :classe :name parent_tree:tiw#tree in
    child#set_parent (self : #tiwrapper0 :> tiwrapper0);
    tiw#add child#tiw;
    property_add child#tiw;
    child

  method add_child classe () = 
    incr index;
    let name = classe ^ (string_of_int !index) in
    self#add_child_with_name classe name; ()

  initializer
    memo#add tiw#tree_item  data:(self : #tiwrapper0 :> tiwrapper0);
    tiw#set_glob (self : #tiwrapper0 :> tiwrapper0)
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
  let tiw1 = new tiwrapper classe:"window" :name parent_tree:root_tree in
  



  let sel () = match root_tree#selection with
  | [] -> None
  | sel :: _ -> Some (memo#find sel) in

  let emit () =
    let outc = open_out file:(tiw1#tiw#name ^ ".ml") in
    let c = Oformat.of_channel outc in
    tiw1#tiw#emit_code c;
    close_out outc in

  mi_emit#connect#activate callback:emit;

  let last_sel = ref (None : tiwrapper0 option) in

  root_tree#connect#selection_changed callback:(fun _ ->
    begin match !last_sel with
      | None -> ()
      |	Some sl -> sl#tiw#base#misc#set state:`NORMAL end;
    match root_tree#selection with
    | [] ->  last_sel := None
    | sel :: _  -> let ti = memo#find sel in
      ti#tiw#base#misc#set state:`SELECTED;
      cb#entry#set_text ti#tiw#name;
      last_sel := Some ti
					       );    
  tree_window#connect#event#focus_out callback:
    (fun _ -> begin match !last_sel with
      |	None -> ()
      |	Some sl -> sl#tiw#base#misc#set state:`NORMAL end;
      true);
  tree_window#connect#event#focus_in callback:
    (fun _ -> begin match !last_sel with
      |	None -> ()
      |	Some sl -> sl#tiw#base#misc#set state:`SELECTED end;
      true);
  property_add tiw1#tiw;
  tree_window#connect#event#key_press callback:
    begin fun ev ->
      let state = GdkEvent.Key.state ev in
      let keyval = GdkEvent.Key.keyval ev in
      if keyval = GdkKeysyms._Up then begin
	match sel () with
	| None -> ()
	| Some (t : tiwrapper0) -> 
	    if test_modifier `CONTROL state then t#tiw#up () else
	    match t#parent with
	    | None -> ()
	    | Some (p : tiwrapper0) ->
		p#tiw#tree#unselect_child t#tiw#tree_item;
		p#tiw#tree#select_prev_child t#tiw#tree_item
      end
      else if keyval = GdkKeysyms._Down then begin
	match sel () with
	| None -> ()
	| Some (t : tiwrapper0) -> 
	    if test_modifier `CONTROL state then t#tiw#down () else
	    match t#parent with
	    | None -> root_tree#select_next_child t#tiw#tree_item true
	    | Some (p : tiwrapper0) ->
		p#tiw#tree#select_next_child t#tiw#tree_item true
      end;
      tree_window#stop_emit "key_press_event";
      true
    end;


  tree_window, tiw1
;;
(*
new_window name:"window"
;;
*)
(*
Main.main ()
*)

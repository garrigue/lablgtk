(* $Id$ *)

open StdLabels
open Gaux
open Gtk
open GObj
open GContainer

open Utils
open Common
open Property

(* possible children; used to make the menus *)
let widget_add_list =
  [ "vbox"; "hbox"; "vbutton_box"; "hbutton_box"; "fixed";
    "frame"; "aspect_frame"; "handle_box"; "event_box";
    "hseparator"; "vseparator"; "statusbar"; "label"; "notebook";
    "color_selection";
    "button";
    "toggle_button"; "check_button"; "radio_button"; "scrolled_window";

    "entry"; "spin_button"; "combo"; "clist"; "toolbar"]


(*********** selection ***********)

let selection = ref ""
let window_selection = ref ""


(**************** signals class ***************)

class tiwidget_signals ~signals =
  let name_changed : string signal = signals in
  object
    val after = false
    method after = {< after = true >}
    method name_changed = name_changed#connect ~after
  end


(************* class type ***************)
(* the ti<gtkwidget> classes encapsulate the corresponding gtk
   widget which will be in the gtk-window and a tree item
   labelled with the name of the widget which will be in the
   tree-window.
   all these classes have the same following interface *)

class virtual tiwidget0 = object
  method virtual widget : GObj.widget
  method virtual connect_event : GObj.event_signals
  method virtual parent : tiwidget0 option
  method virtual set_parent : tiwidget0 -> unit
  method virtual base : GObj.widget
  method virtual tree_item : GTree2.tree_item
  method virtual tree : GTree2.tree
  method virtual children : (tiwidget0 * Gtk.Tags.pack_type) list
  method virtual name : string
  method virtual proplist : (string * prop) list
  method virtual add_to_proplist : (string * prop) list -> unit
  method virtual change_name_in_proplist : string -> string -> unit
  method virtual set_property : string -> string -> unit
  method virtual forall :  callback:(tiwidget0 -> unit) -> unit
  method virtual remove : tiwidget0 -> unit
(*  method virtual add_child_with_name : string -> string -> pos:int -> tiwidget0 *)
  method virtual add_children : ?pos:int -> yywidget_tree -> unit
  method virtual add_children_wo_undo : ?pos:int -> yywidget_tree -> string
  method virtual remove_me  : unit -> unit
  method virtual remove_me_without_undo  : unit -> unit
  method virtual emit_code : Format.formatter -> char list -> unit
  method virtual emit_init_code : Format.formatter -> packing:string -> unit
  method virtual emit_method_code : Format.formatter -> unit
  method virtual emit_initializer_code : Format.formatter -> unit
  method virtual save : Format.formatter -> unit
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
  method virtual tiwin : tiwidget0
(*  method virtual tree_window : window *)
  method virtual change_selected : tiwidget0 -> unit
  method virtual remove_sel : tiwidget0 -> unit
  method virtual add_param : char
  method virtual remove_param : char -> unit
(*  method virtual emit : unit -> unit *)
end

(* forward declaration of function new_widget *)
let new_tiwidget :
    (classe:string -> ?pos:int -> name:string ->parent_tree:GTree2.tree ->
      ?insert_evbox:bool -> ?listprop:(string * string) list -> window_and_tree0 -> tiwidget0) ref =
  ref (fun ~classe ?pos ~name ~parent_tree ?insert_evbox ?listprop w -> failwith "new_tiwidget")


let widget_map = Hashtbl.create 17

(* list of names of radio_buttons (for groups) *)
let radio_button_pool = ref []


(************* window creation class *************)
(* an instance of this class is created for each window opened
   in radtest. It contains the tree window and the gtk window (tiwin) *)

class window_and_tree ~name =
  let tree_window = GWindow.window ~show:true ~title:(name ^ "-Tree") () in
  let vbox = GPack.vbox ~spacing:2 ~packing:tree_window#add () in
  let root_tree = GTree2.tree ~packing:vbox#pack ~selection_mode:`EXTENDED () in
  let project_tree_item = GTree2.tree_item () in
  let label = GMisc.label ~text:name ~xalign:0. ~yalign:0.5
      ~packing:project_tree_item#add () in

  object(self)

    inherit window_and_tree0

(* the params of the window class; because the class clist needs a param
   I suppose there will be no more than 26 clists in a single window    *)
    val param_list = Array.create 26 false

    method add_param =
      let i = ref 0 in
      while param_list.(!i) do incr i done;
      param_list.(!i) <- true;
      char_of_int (97 + !i)

    method remove_param c =
      param_list.(int_of_char c - 97) <- false

    method private param_list =
      let r = ref [] in
      for i = 25 downto 0 do
	if Array.unsafe_get param_list i then r := (char_of_int (i+97)) :: !r
      done;
      !r

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
	  Propwin.show sel
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
	    Propwin.show sel
	  end

(* the tiwidget tiw is being removed; if it was selected,
   put the selection to None *)
    method remove_sel tiw =
      match selected with
      |	Some sel when sel = tiw -> selected <- None
      |	_ -> ()

(* emits the code corresponding to this window *)
    method emit c = tiwin#emit_code c self#param_list;

    method delete () =
      tiwin#remove_me_without_undo ();
      tree_window#destroy ();

    initializer
      tiwin <- !new_tiwidget ~classe:"window" ~name ~parent_tree:root_tree
	  (self : #window_and_tree0 :> window_and_tree0);

      tiwin#connect#name_changed ~callback:
	  (fun n -> label#set_text n; tree_window#set_title (n ^ "-Tree"));

      Propwin.show tiwin;

      tree_window#event#connect#key_press ~callback:
	begin fun ev ->
	  let state = GdkEvent.Key.state ev in
	  let keyval = GdkEvent.Key.keyval ev in
	  if keyval = GdkKeysyms._Up then begin
	    match selected with
	    | None -> ()
	    | Some t -> 
		if List.mem `CONTROL state then t#up ()
		else try
		  self#change_selected t#prev
		with Not_found -> ()
	  end
	  else if keyval = GdkKeysyms._Down then begin
	    match selected with
	    | None -> ()
	    | Some t -> 
		if List.mem `CONTROL state then t#down ()
		else try
		  self#change_selected t#next
		with Not_found -> ()
	  end;
	  GtkSignal.stop_emit ();
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

class virtual tiwidget ~name ~parent_tree:(parent_tree : GTree2.tree) ~pos
    ~widget ?(insert_evbox=true) (parent_window : window_and_tree0) =
object(self)

  inherit tiwidget0
  inherit has_ml_signals

  val evbox =
    if insert_evbox then
      let ev = GBin.event_box () in ev#add widget#coerce; Some ev
    else None

(* used only for windows delete_event *)
  method connect_event = failwith "tiwidget::connect_event"

  val widget = widget#coerce
  method widget = widget

  val mutable parent = None
  method set_parent p = parent <- Some p
  method parent =  parent
  method private sure_parent =
    match parent with
    | None -> failwith "sure_parent"
    | Some p -> p

  method base =
    match evbox with
    | None -> widget#coerce
    | Some ev -> ev#coerce

(* this is the name used in new_tiwidget for the creation
   of an object of this class *)
  val mutable classe = ""

  val tree_item = GTree2.tree_item ()
  method tree_item = tree_item

  val mutable stree = GTree2.tree ()
  method tree = stree

  val label = GMisc.label ~text:name ~xalign:0. ~yalign:0.5 ()

  val mutable name : string = name
  method name = name

(* this is the complete name for the creation of the widget
   in lablgtk e.g. GPack.vbox; used in emit_init_code *)
  method private class_name = ""

  val mutable proplist : (string * prop) list = []
  method proplist = proplist
  method private get_mandatory_props = []

  method add_to_proplist plist = proplist <- proplist @ plist

(* for children of a box *)
  method change_name_in_proplist : string -> string -> unit =
    fun _ _ -> ()
  method set_property name value_string = try
    (List.assoc name proplist)#set value_string
  with Not_found -> Printf.printf "Property not_found %s, %s\n" name value_string;
    flush stdout

  method private get_property name =
    (List.assoc name proplist)#get


(* the proplist with some items removed e.g. the expand... in a box
   used for saving and emitting code *)
  method private emit_clean_proplist =
    List.fold_left ~f:(fun l p -> List.remove_assoc p l)
      ~init:proplist
      ([ "name"; "expand"; "fill"; "padding" ] @ self#get_mandatory_props)
(*  method private emit_clean_proplist plist =
    List.fold_left ~init:plist ~f:
      (fun pl propname -> List.remove_assoc propname pl)
	[ "name"; "expand"; "fill"; "padding" ]
*)

  method private save_clean_proplist =
    List.fold_left ~f:(fun l p -> List.remove_assoc p l)
      ~init:proplist ("name" :: self#get_mandatory_props)
(*  method private save_clean_proplist =
    List.remove_assoc "name" proplist *)

  val mutable children : (tiwidget0 * Gtk.Tags.pack_type) list = []
  method children = children
  method forall =
    fun ~callback -> List.iter (List.map children ~f:fst) ~f:callback

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
    let pos = list_pos ~item:(self : #tiwidget0 :> tiwidget0)
	(List.map self#sure_parent#children ~f:fst) in
    let lexbuf = Lexing.from_string !sref in
    let node = Load_parser.widget Load_lexer.token lexbuf in
    add_undo (Add (self#sure_parent#name, node, pos));
    self#remove_me_without_undo ()

  method remove_me_without_undo () =
(* it should be enough to only recursively remove the children from the
   name_list and do the tip#remove and tip#tree#remove
   only for self *)
    self#forall ~callback:(fun tiw -> tiw#remove_me_without_undo ());
    parent_window#remove_sel (self : #tiwidget0 :> tiwidget0);
    match parent with
    | None -> failwith "remove without parent"
    | Some (tip : #tiwidget0) ->
	tip#tree#remove tree_item;
	tip#remove (self : #tiwidget0 :> tiwidget0);
	name_list := list_remove !name_list ~f:(fun n -> n=name);
	Hashtbl.remove widget_map name;
	Propwin.remove name

(* used for undo *)
  method private remove_child_by_name name () =
    let child = fst (List.find children
	~f:(fun (ch, _) -> ch#name = name)) in
    child#remove_me ()

(* for most widgets we make a child with new_tiwidget and then add it
   to self; for toolbars we use toolbar#insert_button...     *)
      method private make_child = !new_tiwidget

(* adds a child and shows his properties;
   used when adding a child by the menu or DnD *)
  method private add_child classe ?name ?(undo = true) ?(affich = true) ?(pos = -1) ?(listprop = []) () =
    let name = match name with
    | None -> make_new_name classe
    | Some n -> n in
    let child = self#make_child ~classe ~name ~parent_tree:stree parent_window ~pos ~listprop in
    child#set_parent (self : #tiwidget0 :> tiwidget0);
    self#add child ~pos;
    if affich then Propwin.show child;
    if undo then add_undo (Remove name);
    child


(* adds the subtree saved in the Node *)
  method add_children ?(pos = -1) node =
    let child_name = self#add_children_wo_undo node ~pos in
    add_undo (Remove child_name)

  method add_children_wo_undo ?(pos = -1) (Node (child, children)) =
    let classe, name, property_list = child in
    let rname = change_name name in
    let tc = self#add_child classe ~name:rname ~undo:false ~affich:false ~pos ~listprop:property_list () in
    List.iter (List.rev children)
      ~f:(fun c -> tc#add_children_wo_undo c; ());
    List.iter property_list ~f:(fun (n,v) -> tc#set_property n v);
    rname

(* only a tiwindow can emit code *)
  method emit_code = failwith "emit_code"

(* some methods for emitting code *)
(* this one calculates the expand, fill and padding parameters
   of a box child *)
  method private get_packing packing =
    let aux name =
      let prop  = List.assoc name proplist in
      if prop#modified then " ~" ^ name ^ ":" ^ prop#code else ""
    in
    let efp = try
      (aux "expand") ^ (aux "fill") ^ (aux "padding")
    with Not_found -> "" in
    if efp = "" then ("~packing:" ^ packing)
    else ("~packing:(" ^ packing ^ efp ^ ")")

(* this one emits the declaration code of the widget *)
  method emit_init_code formatter ~packing =
    Format.fprintf formatter "@ @[<hv 2>let %s =@ @[<hov 2>%s"
      name self#class_name;
    List.iter self#get_mandatory_props
      ~f:begin fun name ->
	Format.fprintf formatter "@ ~%s:%s" name
	  (List.assoc name proplist)#code
      end;
    let packing = self#get_packing packing in
    if packing <> "" then Format.fprintf formatter "@ %s" packing;
    self#emit_prop_code formatter;
    Format.fprintf formatter "@ ()@ in@]@]"

(* this one emits the properties which do not have their
   default value; used by emit_init_code *)
  method private emit_prop_code formatter =
    let mandatory = self#get_mandatory_props in
    List.iter self#emit_clean_proplist ~f:
      begin  fun (name, prop) ->
	if List.mem name mandatory then () else
	if prop#modified then
	  Format.fprintf formatter "@ ~%s:%s" prop#name prop#code
      end

(* this one emits the method returning this widget *)
  method emit_method_code formatter =
    Format.fprintf formatter "@ method %s = %s" name name;

(* emits the code in the initializer part for this widget *)
  method emit_initializer_code _ = ()

(* for saving the project to a file. Used also by copy and cut *)
  method private save_start formatter =
    Format.fprintf formatter "@\n@[<2><%s name=%s>" classe name;
    List.iter
      ~f:(fun p -> Format.fprintf formatter 
	  "@\n%s=\"%s\"" p (List.assoc p proplist)#get)
      self#get_mandatory_props
      

  method private save_end formatter =
    Format.fprintf formatter "@]@\n</%s>" classe

  method save formatter =
    self#save_start formatter;
    List.iter self#save_clean_proplist ~f:
      (fun (name, prop) ->
	if prop#modified then
	  Format.fprintf formatter "@\n%s=%s" name prop#save_code);
    self#forall ~callback:(fun w -> w#save formatter);
    self#save_end formatter


  method private save_to_string string_ref =
    let b = Buffer.create 80 in
    let f = Format.formatter_of_buffer b in
    self#save f;
    Format.pp_print_flush f ();
    string_ref := Buffer.contents b

  method private copy_to_sel selection = self#save_to_string selection

  method copy () = self#copy_to_sel selection

  method private cut () =
    self#copy ();
    self#remove_me ()

  method private paste () =
    let lexbuf = Lexing.from_string !selection in
    let node = Load_parser.widget Load_lexer.token lexbuf in
    self#add_children node
    

(* ML signal used when the name of the widget is changed *)
  val name_changed : string signal = new signal
  method connect = new tiwidget_signals ~signals:name_changed
  method private call_name_changed = name_changed#call


(* this is necessary because gtk_tree#remove deletes the tree
   when removing the last item  *)
(* suppressed this in gtktree2 
  method new_tree () =
    stree <- GTree2.tree;
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
  method private menu ~time = self#restricted_menu ~time

(* the restricted menu for this widget 
   used for containers when they are full *)
  method private restricted_menu ~time =
    let menu = GMenu.menu () in
    let mi_remove = GMenu.menu_item ~packing:menu#append	~label:"remove" ()
    and mi_cut  = GMenu.menu_item ~packing:menu#append ~label:"Cut" ()
    and mi_copy = GMenu.menu_item ~packing:menu#append ~label:"Copy" () in
    mi_remove#connect#activate ~callback:self#remove_me;
    mi_copy#connect#activate ~callback:self#copy;
    mi_cut#connect#activate ~callback:self#cut;
    menu#popup ~button:3 ~time

(* changes all that depends on the name *)
  method private set_new_name new_name =
    if test_unique new_name then begin
      Hashtbl.remove widget_map name;
      Hashtbl.add' widget_map ~key:new_name
	~data:(self : #tiwidget0 :> tiwidget0);
      if (classe = "radio_button") then begin
	radio_button_pool := new_name ::
	  (list_remove !radio_button_pool ~f:(fun x -> x = name));
	List.iter
	  ~f:(fun x -> Propwin.update (Hashtbl.find widget_map x) false)
	  !radio_button_pool
      end;
      label#set_text new_name;
      let old_name = name in
      name <- new_name;
(*      Propwin.change_name old_name new_name; *)
      name_list :=
	new_name :: (list_remove !name_list ~f:(fun n -> n=old_name));
      begin match self#parent with
      | None -> ()
      | Some p -> p#change_name_in_proplist old_name new_name
      end;
      self#call_name_changed new_name;
      true
    end
    else begin
      message_name ();
      Propwin.update self true;
      false
    end


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
    let _, tl = cut_list ~item:child (List.map ~f:fst children) in
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
	let hd, _ = cut_list ~item:(self : #tiwidget0 :> tiwidget0)
	    (List.map ~f:fst p#children) in
	match hd with
	| [] -> p
	| h :: _ -> h#last

  initializer
    Hashtbl.add' widget_map ~key:name ~data:(self : #tiwidget0 :> tiwidget0);
    name_list := name :: !name_list;
    parent_tree#insert tree_item ~pos;
    tree_item#set_subtree stree;
    tree_item#add label#coerce;
    tree_item#expand ();

    proplist <-  proplist @
      [ "name",
        new prop_string ~name:"name" ~init:name ~set:self#set_new_name; 
        "width", new prop_int ~name:"width" ~init:"-2"
	  ~set:(fun v -> widget#misc#set_geometry ~width:v (); true);
        "height", new prop_int ~name:"height" ~init:"-2"
	  ~set:(fun v -> widget#misc#set_geometry ~height:v (); true) ];

    self#add_signal name_changed;

    tree_item#event#connect#button_press ~callback:
      (fun ev -> match GdkEvent.get_type ev with
      | `BUTTON_PRESS ->
	  if GdkEvent.Button.button ev = 1 then begin
	    parent_window#change_selected
	      (self : #tiwidget0 :> tiwidget0);
	  end
	  else if GdkEvent.Button.button ev = 3 then begin
	    if full_menu
	    then self#menu ~time:(GdkEvent.Button.time ev)
	    else self#restricted_menu ~time:(GdkEvent.Button.time ev);
	  end;
	  GtkSignal.stop_emit ();
          true
      | _ -> false);
    ()
end


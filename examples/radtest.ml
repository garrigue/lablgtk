open Gtk
open GObj
open GData
open GTree
open GWindow
open GPack
open GFrame
open GMisc
open GMenu
open GEdit
open GButton
open GUtil
open GMain

class ['a] rval (init : 'a) :name :setfun ?:value_list [< [] >] = object
  val mutable name : string = name
  val mutable value = init
  val value_list : (string * 'a) list = value_list
  method name = name
  method value = value
  method value_list = value_list
  method set : 'a -> unit = fun v -> 
    if value <> v then begin value <- v; setfun v end
end

type property =
  | Bool of bool rval
  | Int of int rval
  | Float of float rval
  | String of string rval

class type is_widgetname = object
  inherit is_widget
  method name : string
end


class virtual rwidget name:n :setname = object
  val mutable proplist : property list = []
  val mutable name : string = n
  method proplist = proplist
  method name = name
  method set_name n : unit = name <- n; setname n
  method virtual as_widget : Gtk.widget Gtk.obj
  method ajoute : 'a . (#is_widgetname as 'a) -> unit = fun _ -> failwith "ajoute" 
end

class rwindow ?type:t [< `TOPLEVEL >] :name :setname ?:title = object(self)
  inherit window type:t show:true ?:title
  inherit rwidget :name :setname
  method ajoute = self#add
  initializer
    proplist <- [
      String (new rval name:"name" name
	setfun:self#set_name);
      String (new rval name:"title" name
	setfun:(fun v -> self#set_wm title:v));
      Bool (new rval name:"allow_shrink" true
	setfun:(fun v -> self#set_policy allow_shrink:v));
      Bool (new rval name:"allow_grow" true
	setfun:(fun v -> self#set_policy allow_grow:v));
      Bool (new rval name:"auto_shrink" true
	setfun:(fun v -> self#set_policy auto_shrink:v));
      Int (new rval name:"x position" (-2)
	     setfun:(fun v -> self#misc#set x:v));
      Int (new rval name:"y position" (-2)
	     setfun:(fun v -> self#misc#set y:v));
      Int (new rval name:"width" (-2)
	     setfun:(fun v -> self#misc#set width:v));
      Int (new rval name:"heigth" (-2)
	     setfun:(fun v -> self#misc#set height:v))
    ] 
end

class rbox dir  :name :setname = object(self)
  inherit box dir show:true as box
  inherit rwidget :name :setname
  method ajoute =
    fun w ->
      let n = w#name in
      proplist <- proplist @ [
        Bool (new rval name:(n ^ "::expand") true
	  setfun:(fun v -> self#set_child_packing w expand:v));
        Bool (new rval name:(n ^ "::fill") true
	  setfun:(fun v -> self#set_child_packing w fill:v));
        Int (new rval name:(n ^ "::padding") 0
	  setfun:(fun v -> self#set_child_packing w padding:v))
      ];
      box#pack w
  initializer
    proplist <- [
      String (new rval name:"name" name
	setfun:self#set_name);
      Bool (new rval name:"homogeneous" false
	setfun:(fun v -> self#set_packing homogeneous:v));
      Int (new rval name:"spacing" 0
	setfun:(fun v -> self#set_packing spacing:v))
    ]
end

class rvbox = rbox `VERTICAL
class rhbox = rbox `HORIZONTAL

class rlabel ?:text [< "" >] :name :setname = object(self)
  inherit label :text show:true
  inherit rwidget :name :setname
  initializer
    proplist <- [
      String (new rval name:"name" name
	setfun:self#set_name);
      String (new rval name:"text" name
		setfun:(fun v -> self#set_text v))
    ]
end

class rbutton ?:label [< "" >] :name :setname = object(self)
  inherit button :label show:true
  inherit rwidget :name :setname
  initializer
    proplist <- [
      String (new rval name:"name" name
	setfun:self#set_name);
      Int (new rval name:"width" (-2)
	     setfun:(fun v -> self#misc#set width:v));
      Int (new rval name:"heigth" (-2)
	     setfun:(fun v -> self#misc#set height:v))
    ]
end

type rwidget_switch =
  | Rien
  | Rwindow of rwindow
  | Rvbox of rvbox
  | Rhbox of rhbox
  | Rlabel of rlabel
  | Rbutton of rbutton

let select_ajoute = function
  | Rien -> failwith "ajoute::rien"
  | Rwindow window -> window#ajoute
  | Rvbox vbox  -> vbox#ajoute
  | Rhbox hbox -> hbox#ajoute
  | Rlabel _ -> failwith "ajoute::label"
  | Rbutton _ -> failwith "ajoute::button"

class tiw ?:border_width [< 0 >] parent_tree:(parent_tree : tree) :name =
  object(self : 'stype)
    inherit  tree_item :border_width show:true
    val tree = new tree
    val label = new label text:name show:true xalign:0. yalign:0.5
    val parent : 'stype option = None
    method set_label name = label#set_text name
    method tree = tree
    method insert :
	'a . (Gtk.tree_item #GObj.is_item as 'a) -> pos:int -> unit
	    = tree#insert
    val mutable widget = Rien
    method widget = widget
    method set_widget w = widget <- w
    method ajoute : 'c . (#is_widgetname as 'c) -> unit =
      select_ajoute widget
    initializer parent_tree#insert self pos:0;
      self#set_subtree tree;
      self#add label;
      self#expand ()
  end

let new_label_name =
  let rl = ref 0 in
  let aux () =
    incr rl;
    "label" ^ (string_of_int !rl)
  in aux

let new_vbox_name =
  let rl = ref 0 in
  let aux () =
    incr rl;
    "vbox" ^ (string_of_int !rl)
  in aux

let new_hbox_name =
  let rl = ref 0 in
  let aux () =
    incr rl;
    "hbox" ^ (string_of_int !rl)
  in aux

let new_button_name =
  let rl = ref 0 in
  let aux () =
    incr rl;
    "button" ^ (string_of_int !rl)
  in aux

let new_hseparator_name =
  let rl = ref 0 in
  let aux () =
    incr rl;
    "hseparator" ^ (string_of_int !rl)
  in aux

let new_vseparator_name =
  let rl = ref 0 in
  let aux () =
    incr rl;
    "vseparator" ^ (string_of_int !rl)
  in aux



(* l est une liste de couples (nom, valeur) *)
class prop_enumtype l :callback ?:packing :value = object(self)
  inherit combo popdown_strings:(List.map fun:fst l) show:true ?:packing
      use_arrows_always:true
  initializer
    self#entry#connect#changed callback:
      (fun _ -> callback (List.assoc self#entry#text in:l));
    self#entry#set_editable false;
    self#entry#set_text value
end

class prop_bool = prop_enumtype ["true", true; "false", false]

class prop_string :callback ?:packing :value = object(self)
  inherit entry text:value ?:packing show:true
  initializer
    self#connect#activate callback:(fun _ -> callback self#text);
    ()
end



class spin_int ?:value [< 0 >] :lower :upper ?:step_incr [< 1. >]
    ?:page_incr [< 1. >] ?:packing :callback =
object(self)
  inherit spin_button rate:0.5 digits:0
      adjustment:(new adjustment value:(float_of_int value) :lower
		    :upper :step_incr :page_incr page_size:0.)
      show:true ?:packing
  initializer
    self#connect#activate callback:
      (fun _ -> callback self#value_as_int);
    ()
end


let memo = new memo ();;

(* GtkThread.start ();; *)
let applic_window = new window type:`TOPLEVEL show:true title:"Tree"
let applic = new tree;;
applic_window#add applic;;
applic#show();;



let w1 = new tiw parent_tree:applic name:"window";;

memo#add w1;;


let ww1 = new rwindow   name:"window" setname:w1#set_label title:"window";;
w1#set_widget (Rwindow ww1);;

let menu = new menu show:true
let mi_vbox = new menu_item show:true packing:menu#append label:"add vbox"
let mi_hbox = new menu_item show:true packing:menu#append label:"add hbox"
let mi_label = new menu_item show:true packing:menu#append label:"add label"
let mi_button = new menu_item show:true packing:menu#append label:"add button"


let sel () = match applic#selection with
| [] -> None
| sel :: _ -> Some (memo#find sel)
;;

applic#connect#selection_changed callback:(fun _ ->
  match applic#selection with
  | [] -> ()
  | sel :: _  -> let ti = memo#find sel in
    match ti#widget with
    | Rvbox _ | Rhbox _ -> menu#popup button:0 time:0
    | Rwindow _ when ti#tree#children = [] -> menu#popup button:0 time:0
    | _ -> ())

    


let plist_affich list =
  let une_prop_affich prop = 
    let hbox = new box `HORIZONTAL show:true homogeneous:true in
    begin match prop with
    | Bool prop -> new label text:prop#name show:true
	  packing:(hbox#pack fill:true);
	new prop_bool callback:prop#set packing:(hbox#pack fill:true)
	  value:(string_of_bool prop#value);
	()
    | Int prop -> new label text:prop#name show:true
	  packing:(hbox#pack fill:true);
	new spin_int lower:(-2.) upper:5000. callback:prop#set
	  packing:(hbox#pack fill:true) value:prop#value;
	()
    | String prop -> new label text:prop#name show:true
	  packing:(hbox#pack fill:true);
	new prop_string  callback:prop#set
	  packing:(hbox#pack fill:true) value:prop#value;
	()
    end;
    hbox
  in let vbox = new box `VERTICAL show:true in
  List.map fun:(fun p -> vbox#pack (une_prop_affich p);
	new separator `HORIZONTAL show:true packing:vbox#pack) list;
  vbox



let property_window_add  =
  let propwin = new window show:true title:"properties" in
  let vbox = new box `VERTICAL show:true packing:propwin#add in
  let hbox = new box `HORIZONTAL show:true
      packing:(vbox#pack padding:5) in
  new separator `HORIZONTAL packing:vbox#pack show:true;
  new separator `HORIZONTAL packing:vbox#pack show:true;
  let cb = new combo popdown_strings:[]
      show:true use_arrows_always:true
      packing:(hbox#pack expand:true fill:false) in
  let vbox2 = plist_affich [] in
  vbox#pack vbox2;
  let vboxref = ref vbox2 in
  let rwidget_list = ref ([] : rwidget list) in
  let rname_prop_list = ref ([] : (string * property list) list) in
  cb#entry#connect#changed callback:
    (fun _ ->
      let vb = plist_affich (List.assoc cb#entry#text in:!rname_prop_list) in
      vbox#remove !vboxref;
      vbox#pack vb;
      vboxref := vb
	  );
  let add (rw : rwidget) =
    rwidget_list := rw :: !rwidget_list;
    let nplist = List.map fun:(fun w -> (w#name, w#proplist)) !rwidget_list in
    rname_prop_list := nplist;
    cb#set_combo popdown_strings:(List.map fun:fst nplist);
    cb#entry#set_text rw#name
  in add

      
  


let add_label _ = match sel () with
| None -> ()
| Some (sel : tiw) ->
    let name = new_label_name () in
    let t = new tiw parent_tree:sel#tree :name in
    let w = new rlabel text:name :name setname:t#set_label in
    t#set_widget (Rlabel w);
    sel#ajoute w;
    property_window_add (w :> rwidget);
    memo#add t



let add_hbox _ = match sel () with
| None -> ()
| Some (sel : tiw) ->
    let name = new_hbox_name () in
    let t = new tiw parent_tree:sel#tree :name in
    let w = new rhbox :name setname:t#set_label in
    sel#ajoute w;
    property_window_add (w :> rwidget);
    t#set_widget (Rhbox w);
    memo#add t

let add_vbox _ = match sel () with
| None -> ()
| Some (sel : tiw) ->
    let name = new_vbox_name () in
    let t = new tiw parent_tree:sel#tree :name in
    let w = new rvbox :name setname:t#set_label in
    sel#ajoute w;
    property_window_add (w :> rwidget);
    t#set_widget (Rvbox w);
    memo#add t

let add_button _ = match sel () with
| None -> ()
| Some (sel : tiw) ->
    let name = new_button_name () in
    let t = new tiw parent_tree:sel#tree :name in
    let w = new rbutton :name label:name setname:t#set_label in
    sel#ajoute w;
    property_window_add (w :> rwidget);
    t#set_widget (Rbutton w);
    memo#add t
;;

mi_vbox#connect#activate callback:(add_vbox);;
mi_hbox#connect#activate callback:add_hbox;;
mi_label#connect#activate callback:add_label;;
mi_button#connect#activate callback:add_button;;


property_window_add (ww1 :> rwidget);;

Main.main ()



(* $Id$ *)

open StdLabels

open Utils
open Property

open TiContainer

class tibox ~(dir : Gtk.Tags.orientation) ~(widget : GPack.box)
    ~name ~parent_tree ~pos ?(insert_evbox=true) parent_window =
  let class_name =
    match dir with `VERTICAL -> "GPack.vbox" | _ -> "GPack.hbox" in
object(self)
  val box = widget
  inherit ticontainer ~name ~widget ~parent_tree ~pos ~insert_evbox
      parent_window as container

  method private class_name = class_name

  method private name_of_add_method = "#pack"

(* removes the ::expand ::fill ::padding in the proplist of a box
   assumes that these are the only properties with a :: in the name *)
  method private save_clean_proplist =
    List.filter container#save_clean_proplist
      ~f:(fun (n,p) ->
	try
	  let i = String.index n ':' in
	  i = String.length n || n.[i+1] <> ':'
	with Not_found -> true)

  method private emit_clean_proplist =
    List.filter container#emit_clean_proplist
      ~f:(fun (n,p) ->
	try
	  let i = String.index n ':' in
	  i = String.length n || n.[i+1] <> ':'
	with Not_found -> true)

  method change_name_in_proplist oldn newn =
    proplist <- List.fold_left ~init:proplist ~f:
	(fun pl propname ->
	  change_property_name (oldn ^ propname) (newn ^ propname) pl)
	[ "::expand"; "::fill"; "::padding" ];
    Propwin.update self false

  method child_up child =
    let pos = list_pos ~item:child (List.map ~f:fst children) in
    if pos > 0 then begin
      box#reorder_child child#base ~pos:(pos-1);
      children <- list_reorder_up children ~pos;
      stree#item_up ~pos
    end
	    
  method child_down child =
    let pos = list_pos ~item:child (List.map ~f:fst children) in
    if pos < (List.length children - 1) then begin
      box#reorder_child child#base ~pos:(pos+1);
      children <- list_reorder_down children ~pos;
      stree#item_up ~pos:(pos+1)
    end
	    
  method private add child ~pos =
    box#pack  child#base;
    if pos < 0 then begin
      children <-  children @ [(child, `START)]
    end
    else begin
      children <- list_insert ~item:(child, `START) children ~pos;
      box#reorder_child child#base ~pos
    end;
    let n = child#name in
    let expand =
      new prop_bool ~name:"expand" ~init:"false" ~set:
	begin fun v ->
	  box#set_child_packing (child#base) ~expand:v;
	  Propwin.update child false;
	  Propwin.update self false; true
	end
    and fill =
      new prop_bool ~name:"fill" ~init:"true" ~set:
	begin fun v ->
	  box#set_child_packing (child#base) ~fill:v;
	  Propwin.update child false;
	  Propwin.update self false; true
	end
    and padding =
      new prop_int ~name:"padding" ~init:"0" ~set:
	begin fun v ->
	  box#set_child_packing (child#base) ~padding:v;
	  Propwin.update child false;
	  Propwin.update self false; true
	end
    in
    proplist <-  proplist @ 
      [ (n ^ "::expand"),  expand;
	(n ^ "::fill"),    fill;
        (n ^ "::padding"), padding ];
    child#add_to_proplist
      [ "expand", expand; "fill", fill; "padding", padding ];
    Propwin.update self true
         

  method remove child =
    box#remove (child#base);
    children <- list_remove ~f:(fun (ch, _) -> ch = child) children;
    let n = child#name in
    proplist <-  List.fold_left ~init:proplist
	~f:(fun acc n -> List.remove_assoc n acc)
	[ (n ^ "::expand"); (n ^ "::fill"); (n ^ "::padding") ];
    Propwin.update self true

  initializer
    classe <- (match dir with `VERTICAL -> "vbox" | _ -> "hbox");
    proplist <-  proplist @
      [ "homogeneous",
	new prop_bool ~name:"homogeneous" ~init:"false"
	  ~set:(ftrue box#set_homogeneous);
	"spacing",
	new prop_int ~name:"spacing" ~init:"0"
	  ~set:(ftrue box#set_spacing)
      ]
end

class tihbox = tibox ~dir:`HORIZONTAL
class tivbox = tibox ~dir:`VERTICAL

let new_tihbox ~name ?(listprop = []) = new tihbox ~widget:(GPack.hbox ()) ~name
let new_tivbox ~name ?(listprop = []) = new tivbox ~widget:(GPack.vbox ()) ~name




class tibbox ~(dir : Gtk.Tags.orientation) ~(widget : GPack.button_box)
    ~name ~parent_tree ~pos ?(insert_evbox=true) parent_window =
  let class_name =
    match dir with `VERTICAL -> "GPack.button_box `VERTICAL"
    | _ -> "GPack.button_box `HORIZONTAL" in
object(self)
  val bbox = widget
  inherit tibox ~dir ~widget:(widget :> GPack.box)
    ~name ~parent_tree ~pos ~insert_evbox parent_window

  method private class_name = class_name

initializer
    classe <- (match dir with `VERTICAL -> "vbutton_box" | _ -> "hbutton_box");
    proplist <-  proplist @
      [ "layout",
	new prop_button_box_style ~name:"layout" ~init:"DEFAULT_STYLE"
	  ~set:(ftrue bbox#set_layout);
	"spacing",
	new prop_int ~name:"spacing"
	  ~init:(match dir with `VERTICAL -> "10" | _ -> "30")
(*  donne -1 (defaut)  
(GtkPack.BBox.get_spacing bbox#as_button_box) *)
	  ~set:(fun v -> bbox#set_spacing v;
	    GtkBase.Widget.queue_resize bbox#as_widget; true);
	"child_width",
	new prop_int ~name:"child_width" ~init:"85"
	  ~set:(fun v ->
	    bbox#set_child_size ~width:v
	      ~height:(int_of_string (self#get_property "child_height")) ();
	    GtkBase.Widget.queue_resize bbox#as_widget; true);
	"child_height",
	new prop_int ~name:"child_height" ~init:"27"
	  ~set:(fun v ->
	    bbox#set_child_size ~height:v
	      ~width:(int_of_string (self#get_property "child_width")) (); 
	    GtkBase.Widget.queue_resize bbox#as_widget; true);
	"child_ipad_x",
	new prop_int ~name:"child_ipad_x" ~init:"7"
	  ~set:(fun v ->
	    bbox#set_child_ipadding ~x:v
	      ~y:(int_of_string (self#get_property "child_ipad_y")) ();
	    GtkBase.Widget.queue_resize bbox#as_widget; true);
	"child_ipad_y",
	new prop_int ~name:"child_ipad_y" ~init:"0"
	  ~set:(fun v ->
	    bbox#set_child_ipadding ~y:v
	      ~x:(int_of_string (self#get_property "child_ipad_x")) (); 
	    GtkBase.Widget.queue_resize bbox#as_widget; true);
      ]
end


(* TODO:  pour proplist/spacing il faudrait implementer
          les fonctions get_spacing ... (voir dans gtkPack) *)

class tihbutton_box = tibbox ~dir:`HORIZONTAL
class tivbutton_box = tibbox ~dir:`VERTICAL

let new_tihbutton_box ~name ?(listprop = []) =
  new tihbutton_box ~widget:(GPack.button_box `HORIZONTAL ()) ~name

let new_tivbutton_box ~name ?(listprop = []) =
  new tivbutton_box ~widget:(GPack.button_box `VERTICAL ()) ~name




let get_fixed_pos () =
  let rx = ref 0 and ry = ref 0 in
  let w  = GWindow.window ~modal:true () in
  let v  = GPack.vbox  ~packing:w#add () in
  let l  = GMisc.label ~text:"Enter position for child" ~packing:v#pack () in
  let h1 = GPack.hbox ~packing:v#pack () in
  let l1 = GMisc.label ~text:"x:" ~packing:h1#pack () in
  let e1 = GEdit.entry ~text:"0" ~packing:h1#pack () in
  let h2 = GPack.hbox ~packing:v#pack () in
  let l2 = GMisc.label ~text:"y" ~packing:h2#pack () in
  let e2 = GEdit.entry ~text:"0" ~packing:h2#pack () in
  let h7 = GPack.hbox ~packing:v#pack () in
  let b1 = GButton.button ~label:"OK" ~packing:h7#pack () in
  let b2 = GButton.button ~label:"Cancel" ~packing:h7#pack () in
  w#show ();
  b1#connect#clicked
    ~callback:(fun () ->
      begin
	try rx  := int_of_string e1#text with _ -> () end;
      begin
	try ry  := int_of_string e2#text with _ -> () end;
      w#destroy ());
  b2#connect#clicked ~callback:w#destroy;
  w#connect#destroy ~callback:GMain.Main.quit;
  GMain.Main.main ();
  !rx, !ry


class tifixed ~(widget : GPack.fixed)
    ~name ~parent_tree ~pos ?(insert_evbox=true) parent_window =
object(self)
  val fixed = widget
  inherit ticontainer ~widget
    ~name ~parent_tree ~pos ~insert_evbox parent_window

  method private class_name = "GPack.fixed"

  method private add child ~pos =
    let x, y = get_fixed_pos () in
    fixed#put child#base ~x ~y;
    children <-  children @ [(child, `START)]
  initializer
    classe <- "fixed"
end

let new_tifixed ~name ?(listprop = []) =
  new tifixed ~widget:(GPack.fixed ()) ~name





class tinotebook ~(widget : GPack.notebook) ~name ~parent_tree ~pos
    ?(insert_evbox=true) parent_window =
object(self)
  val notebook = widget
  inherit ticontainer ~name ~widget ~insert_evbox
      ~parent_tree ~pos parent_window as widget

  method private class_name = "GPack.notebook"

  method private add child ~pos =
    children <- children @ [child, `START];
    notebook#insert_page child#base ~pos;
    child#add_to_proplist
      [ "tab_label",
	new prop_string ~name:"tab_label" ~init:""
	  ~set:(fun v -> notebook#set_page
	      ~tab_label:((GMisc.label ~text:v())#coerce) child#base; true)
      ]


  initializer
    classe <- "notebook";
    proplist <-  proplist @
      [ "tab_pos",
	new prop_position ~name:"tab_ pos" ~init:"TOP"
	  ~set:(ftrue notebook#set_tab_pos);
	"show_tabs",
	new prop_bool ~name:"show_tabs" ~init:"true"
	  ~set:(ftrue notebook#set_show_tabs);
	"homogeneous_tabs",
	new prop_bool ~name:"homogeneous_tabs" ~init:"true"
	  ~set:(ftrue notebook#set_homogeneous_tabs);
	"show_border",
	new prop_bool ~name:"show_border" ~init:"true"
	  ~set:(ftrue notebook#set_show_border);
	"scrollable",
	new prop_bool ~name:"scrollable" ~init:"false"
	  ~set:(ftrue notebook#set_scrollable);
	"tab_border",
	new prop_int ~name:"tab_border" ~init:"2"
	  ~set:(ftrue notebook#set_tab_border);
	"popup_enable",
	new prop_bool ~name:"popup_enable" ~init:"false"
	  ~set:(ftrue notebook#set_popup)
      ]
end

let new_tinotebook ~name ?(listprop = []) =
  new tinotebook ~widget:(GPack.notebook ()) ~name

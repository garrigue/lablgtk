
open Utils
open Property

open TiContainer

class tibox ~(dir : Gtk.Tags.orientation) ~(widget : GPack.box)
    ~name ~parent_tree ~pos ?(insert_evbox=true) parent_window =
object(self)
  val box = widget
  inherit ticontainer ~name ~widget ~parent_tree ~pos parent_window ~insert_evbox
       as container

  method private class_name =
    match dir with `VERTICAL -> "GPack.vbox" | _ -> "GPack.hbox"

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

  method private emit_clean_proplist pl =
    List.filter (container#emit_clean_proplist pl)
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
      new prop_bool ~name:"expand" ~init:"true" ~set:
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
      [ "homogeneous", new prop_bool ~name:"homogeneous" ~init:"false"
	                 ~set:(ftrue box#set_homogeneous);
	"spacing", new prop_int ~name:"spacing" ~init:"0"
	                 ~set:(ftrue box#set_spacing) ]
end

class tihbox = tibox ~dir:`HORIZONTAL
class tivbox = tibox ~dir:`VERTICAL

let new_tihbox ~name = new tihbox ~widget:(GPack.hbox ()) ~name
let new_tivbox ~name = new tivbox ~widget:(GPack.vbox ()) ~name



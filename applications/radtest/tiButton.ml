open Utils
open Property

open TiBase
open TiContainer

(* the button inherits from widget because it can't accept
   a child; 
   needs to add the border_width property *)
class tibutton ~(widget : #GButton.button) ~name ~parent_tree ~pos
    ?(insert_evbox=true) parent_window =
object(self)
  val button = widget
  inherit tiwidget ~name ~widget ~parent_tree ~pos ~insert_evbox
      parent_window as widget

  method private class_name = "GButton.button"

  method private get_mandatory_props = [ "label" ]

  method private save_clean_proplist =
    List.remove_assoc "label" widget#save_clean_proplist

  method private emit_clean_proplist plist =
    List.remove_assoc "label" (widget#emit_clean_proplist plist)


  method private save_start formatter =
    Format.fprintf formatter "@\n@[<2><%s name=%s>" classe name;
    Format.fprintf formatter "@\nlabel=\"%s\""
      (List.assoc "label" proplist)#get

  initializer
    classe <- "button";
    proplist <-  proplist @
      [ "border width",	new prop_int ~name:"border_width" ~init:"0"
	                  ~set:(ftrue button#set_border_width);
	"label",
	new prop_string ~name:"label" ~init:name ~set:
	  begin fun v ->
	    button#remove (List.hd button#children)#coerce;
	    GMisc.label ~text:v ~xalign:0.5 ~yalign:0.5 ~packing:button#add ();
	    true
	  end ]
end

let new_tibutton ~name =
  let b = GButton.button ~label:name () in
  b#connect#event#enter_notify
    ~callback:(fun _ -> b#connect#stop_emit ~name:"enter_notify_event"; true);
  b#connect#event#leave_notify
    ~callback:(fun _ -> b#connect#stop_emit ~name:"leave_notify_event"; true);
  new tibutton ~widget:b ~name


class ticheck_button ~(widget : #GButton.toggle_button) ~name
    ~parent_tree ~pos ?(insert_evbox=true) parent_window =
object(self)
  val button = widget
  inherit tiwidget ~name ~widget ~insert_evbox
      ~parent_tree ~pos parent_window as widget


  method private class_name = "GButton.check_button"

  method private get_mandatory_props = [ "label" ]

  method private save_clean_proplist =
    List.remove_assoc "label" widget#save_clean_proplist

  method private emit_clean_proplist plist =
    List.remove_assoc "label" (widget#emit_clean_proplist plist)

  method private save_start formatter =
    Format.fprintf formatter "@\n@[<2><%s name=%s>" classe name;
    Format.fprintf formatter "@\nlabel=\"%s\""
      (List.assoc "label" proplist)#get

  initializer
    classe <- "check_button";
    proplist <-  proplist @
      [ "border width",	new prop_int ~name:"border_width" ~init:"0"
	                 ~set:(ftrue button#set_border_width);
	"label",
	new prop_string ~name:"label" ~init:name ~set:
	  begin fun v ->
	    button#remove (List.hd button#children)#coerce;
	    GMisc.label ~text:v ~xalign:0.5 ~yalign:0.5 ~packing:button#add ();
	    true
	  end ]
end

let new_ticheck_button ~name =
  new ticheck_button ~widget:(GButton.check_button ~label:name ()) ~name



class titoggle_button ~(widget : #GButton.toggle_button) ~name
    ~parent_tree ~pos ?(insert_evbox=true) parent_window =
object(self)
  val button = widget
  inherit tiwidget ~name ~widget ~insert_evbox
      ~parent_tree ~pos parent_window as widget

  method private class_name = "GButton.toggle_button"

  method private get_mandatory_props = [ "label" ]

  method private save_clean_proplist =
    List.remove_assoc "label" widget#save_clean_proplist

  method private emit_clean_proplist plist =
    List.remove_assoc "label" (widget#emit_clean_proplist plist)

  method private save_start formatter =
    Format.fprintf formatter "@\n@[<2><%s name=%s>" classe name;
    Format.fprintf formatter "@\nlabel=\"%s\""
      (List.assoc "label" proplist)#get

  initializer
    classe <- "toggle_button";
    proplist <-  proplist @
      [ "border width",	new prop_int ~name:"border_width" ~init:"0"
	                  ~set:(ftrue button#set_border_width);
	"label",
	new prop_string ~name:"label" ~init:name ~set:
	  begin fun v ->
	    button#remove (List.hd button#children)#coerce;
	    GMisc.label ~text:v ~xalign:0.5 ~yalign:0.5 ~packing:button#add ();
	    true
	  end ]
end

let new_titoggle_button ~name =
  let b = GButton.toggle_button ~label:name () in
  b#connect#event#enter_notify
    ~callback:(fun _ -> b#connect#stop_emit ~name:"enter_notify_event"; true);
    b#connect#event#leave_notify
      ~callback:(fun _ -> b#connect#stop_emit ~name:"leave_notify_event"; true);
  new titoggle_button ~name ~widget:b


class tiradio_button ~(widget : #GButton.radio_button) ~name:nname
    ~parent_tree ~pos ?(insert_evbox=true) parent_window =
object(self)
  val button = widget
  inherit tiwidget ~name:nname ~widget ~insert_evbox
      ~parent_tree ~pos parent_window as widget

  val group_prop =
    new prop_enum_dyn ~values:(fun () -> !radio_button_pool) ~name:"group"
      ~set:(fun () -> true) ~init:nname


  method private class_name = "GButton.radio_button"

  method remove_me_without_undo () =
    radio_button_pool := list_remove !radio_button_pool
	~f:(fun x -> x = name);
    widget#remove_me_without_undo ()

  method private get_mandatory_props = [ "label" ]

  method private save_clean_proplist =
    List.remove_assoc "label" widget#save_clean_proplist

  method private emit_clean_proplist plist =
    List.fold_left ~init:plist
      ~f:(fun pl propname -> List.remove_assoc propname pl)
      [ "label"; "group" ]
(*    List.remove_assoc "label" (widget#emit_clean_proplist plist) *)

  method private save_start formatter =
    Format.fprintf formatter "@\n@[<2><%s name=%s>" classe name;
    Format.fprintf formatter "@\nlabel=\"%s\""
      (List.assoc "label" proplist)#get

  method emit_initializer_code formatter =
    let groupname = group_prop#get in
    if name <> groupname then
      Format.fprintf formatter "@ %s#set_group %s#group;" name groupname

  initializer
    classe <- "radio_button";
    radio_button_pool := name :: !radio_button_pool;
    List.iter
      ~f:(fun x -> Propwin.update (Hashtbl.find widget_map x) true)
      (List.tl !radio_button_pool);

    proplist <-  proplist @
      [ "border width",	new prop_int ~name:"border_width" ~init:"0"
	                  ~set:(ftrue button#set_border_width);
	"label",
	new prop_string ~name:"label" ~init:name ~set:
	  begin fun v ->
	    button#remove (List.hd button#children)#coerce;
	    GMisc.label ~text:v ~xalign:0.5 ~yalign:0.5 ~packing:button#add ();
	    true
	  end ;
	"group", group_prop
      ]
end

let new_tiradio_button ~name =
  let b = GButton.radio_button ~label:name () in
  b#connect#event#enter_notify
    ~callback:(fun _ -> b#connect#stop_emit ~name:"enter_notify_event"; true);
    b#connect#event#leave_notify
      ~callback:(fun _ -> b#connect#stop_emit ~name:"leave_notify_event"; true);
  new tiradio_button ~name ~widget:b





class titoolbar ~(widget : GToolbar2.toolbar2) ~name ~parent_tree ~pos
    ?(insert_evbox=true) parent_window =
object(self)
  val toolbar = widget
  inherit ticontainer ~name ~widget ~parent_tree ~pos
    ~insert_evbox parent_window

  method private class_name = "GButton.toolbar"

  method private add child ~pos =
    children <- children @ [child, `START]

  method private get_pos child =
    let rec aux n = function
      |	[] -> failwith "toolbar::get_pos"
      |	(hd, _)::tl -> if hd = child then n else aux (n+1) tl in
    aux 0 children

  method private make_child ~classe ?(pos = -1) ~name ~parent_tree
      ?(insert_evbox = true) ?(listprop = []) parent_window =
    match classe with
    | "button" ->
	let ok, t, tt, ptt = match listprop with
	| [] -> toolbar_child_prop "button" 
	| ["true"; t'; tt'; ptt'] -> true, t', tt', ptt'
	| _ -> failwith "toolbar1"
	in
	if ok then begin
	  let b = toolbar#insert_button ~text:t ~tooltip:tt
	      ~tooltip_private:ptt () in
	  let child = new tibutton ~name ~widget:b ~pos:(-1)
	      ~insert_evbox:false ~parent_tree:stree parent_window in
	  let tp = new prop_string ~name:"text" ~init:t
	      ~set:(fun v -> toolbar#set_text v (self#get_pos child); true)
	  and ttp = new prop_string ~name:"tooltip_text" ~init:tt
	      ~set:(fun _ -> true)
	  and pttp = new prop_string ~name:"tooltip_private_text" ~init:ptt
	      ~set:(fun _ -> true) in
	  child#add_to_proplist
	    [ "text", tp; "tooltip_text", ttp; "tooltip_private_text", pttp ];
	  child
	end else failwith "toolbar"
    | "toggle_button" ->
	let ok, t, tt, ptt = toolbar_child_prop "button" in
	if ok then begin
	  let b = toolbar#insert_toggle_button ~text:t ~tooltip:tt
	      ~tooltip_private:ptt () in
	  let child = new titoggle_button ~name ~widget:b ~pos:(-1)
	      ~insert_evbox:false ~parent_tree:stree parent_window in
	  child
	end else failwith "toolbar"
    | "radio_button" ->
	let ok, t, tt, ptt = toolbar_child_prop "button" in
	if ok then begin
	  let b = toolbar#insert_radio_button ~text:t
	      ~tooltip:tt ~tooltip_private:ptt () in
	  let child = new tiradio_button ~name ~widget:b ~pos:(-1)
	      ~insert_evbox:false ~parent_tree:stree parent_window in
	  child
	end else failwith "toolbar"
    | _ -> failwith "toolbar"



  method remove child =
    toolbar#remove (child#base);
    children <- list_remove ~f:(fun (ch, _) -> ch = child) children;

  initializer
    classe <- "toolbar";
    proplist <- proplist @
      [ "orientation",
	new prop_orientation ~name:"orientation" ~init:"HORIZONTAL"
	  ~set:(ftrue toolbar#set_orientation);
	"style",
	new prop_toolbar_style ~name:"style" ~init:"BOTH"
	  ~set:(ftrue toolbar#set_style);
	"space_size",
	new prop_int ~name:"space size" ~init:"5"
	  ~set:(ftrue toolbar#set_space_size);
	"space_style",
	new prop_toolbar_space_style ~name:"space style" ~init:"EMPTY"
	  ~set:(ftrue toolbar#set_space_style);
	"tooltips",
	new prop_bool ~name:"tooltips" ~init:"TRUE"
	  ~set:(ftrue toolbar#set_tooltips);
	"button_relief",
	new prop_relief_style ~name:"button relief" ~init:"NORMAL"
	  ~set:(ftrue toolbar#set_button_relief)
      ]	
end

let new_toolbar ~name = new titoolbar ~name ~widget:(GToolbar2.toolbar2 ())


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

  initializer
    classe <- "button";
    proplist <-  proplist @
      [ "border_width",	new prop_int ~name:"border_width" ~init:"0"
	                  ~set:(ftrue button#set_border_width);
	"label",
	new prop_string ~name:"label" ~init:name ~set:
	  begin fun v ->
	    button#remove (List.hd button#children)#coerce;
	    GMisc.label ~text:v ~xalign:0.5 ~yalign:0.5 ~packing:button#add ();
	    true
	  end ]
end

let new_tibutton ~name ?(listprop = []) =
  let b = GButton.button ~label:name () in
  b#event#connect#enter_notify
    ~callback:(fun _ -> GtkSignal.stop_emit (); true);
  b#event#connect#leave_notify
    ~callback:(fun _ -> GtkSignal.stop_emit (); true);
  new tibutton ~widget:b ~name


class ticheck_button ~(widget : #GButton.toggle_button) ~name
    ~parent_tree ~pos ?(insert_evbox=true) parent_window =
object(self)
  val button = widget
  inherit tiwidget ~name ~widget ~insert_evbox
      ~parent_tree ~pos parent_window as widget


  method private class_name = "GButton.check_button"

  method private get_mandatory_props = [ "label" ]

  initializer
    classe <- "check_button";
    proplist <-  proplist @
      [ "border_width",	new prop_int ~name:"border_width" ~init:"0"
	                 ~set:(ftrue button#set_border_width);
	"label",
	new prop_string ~name:"label" ~init:name ~set:
	  begin fun v ->
	    button#remove (List.hd button#children)#coerce;
	    GMisc.label ~text:v ~xalign:0.5 ~yalign:0.5 ~packing:button#add ();
	    true
	  end
      ]
end

let new_ticheck_button ~name ?(listprop = []) =
  new ticheck_button ~widget:(GButton.check_button ~label:name ()) ~name



class titoggle_button ~(widget : #GButton.toggle_button) ~name
    ~parent_tree ~pos ?(insert_evbox=true) parent_window =
object(self)
  val button = widget
  inherit tiwidget ~name ~widget ~insert_evbox
      ~parent_tree ~pos parent_window as widget

  method private class_name = "GButton.toggle_button"

  method private get_mandatory_props = [ "label" ]

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

let new_titoggle_button ~name ?(listprop = []) =
  let b = GButton.toggle_button ~label:name () in
(*
  b#event#connect#enter_notify
    ~callback:(fun _ -> b#misc#stop_emit ~name:"enter_notify_event"; true);
  b#event#connect#leave_notify
    ~callback:(fun _ -> b#misc#stop_emit ~name:"leave_notify_event"; true);
*)
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

  method private emit_clean_proplist =
    List.remove_assoc "group" widget#emit_clean_proplist

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
      [ "border_width",	new prop_int ~name:"border_width" ~init:"0"
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

let new_tiradio_button ~name ?(listprop = []) =
  let b = GButton.radio_button ~label:name () in
  (*
  b#event#connect#enter_notify
    ~callback:(fun _ -> b#misc#stop_emit ~name:"enter_notify_event"; true);
  b#event#connect#leave_notify
    ~callback:(fun _ -> b#misc#stop_emit ~name:"leave_notify_event"; true);
  *)
  new tiradio_button ~name ~widget:b




class tibutton_toolbar ~(widget : #GButton.button) ~name ~parent_tree ~pos
    ?(insert_evbox=true) parent_window ~toolbar =
object(self)
  val button = widget
  inherit tibutton ~name ~widget ~parent_tree ~pos ~insert_evbox
       parent_window as button

  method private get_mandatory_props =
    [ "text"; "tooltip"; "tooltip_private" ]

  method emit_init_code formatter ~packing =
    Format.fprintf formatter "@ @[<hv 2>let %s =@ @[<hov 2>%s#insert_button"
      name toolbar#name;
    List.iter self#get_mandatory_props ~f:
      begin fun name ->
	Format.fprintf formatter "@ ~%s:%s" name
	  (List.assoc name proplist)#code
      end;
    Format.fprintf formatter "@ ()@ in@]@]"

  initializer
    proplist <- List.remove_assoc "label" proplist
end


class titoggle_button_toolbar ~(widget : #GButton.toggle_button) ~name
    ~parent_tree ~pos ?(insert_evbox=true) parent_window ~toolbar =
object(self)
  val button = widget
  inherit titoggle_button ~name ~widget ~parent_tree ~pos ~insert_evbox
       parent_window as button

  method private get_mandatory_props =
    [ "text"; "tooltip"; "tooltip_private" ]

  method emit_init_code formatter ~packing =
    Format.fprintf formatter
      "@ @[<hv 2>let %s =@ @[<hov 2>%s#insert_toggle_button"
      name toolbar#name;
    List.iter self#get_mandatory_props ~f:
      begin fun name ->
	Format.fprintf formatter "@ ~%s:%s" name
	  (List.assoc name proplist)#code
      end;
    Format.fprintf formatter "@ ()@ in@]@]"

  initializer
    proplist <- List.remove_assoc "label" proplist
end


class tiradio_button_toolbar ~(widget : #GButton.radio_button) ~name
    ~parent_tree ~pos ?(insert_evbox=true) parent_window ~toolbar =
object(self)
  val button = widget
  inherit tiradio_button ~name ~widget ~parent_tree ~pos ~insert_evbox
       parent_window as button

  method private get_mandatory_props =
    [ "text"; "tooltip"; "tooltip_private" ]

  method emit_init_code formatter ~packing =
    Format.fprintf formatter
      "@ @[<hv 2>let %s =@ @[<hov 2>%s#insert_radio_button"
      name toolbar#name;
    List.iter self#get_mandatory_props ~f:
      begin fun name ->
	Format.fprintf formatter "@ ~%s:%s" name
	  (List.assoc name proplist)#code
      end;
    Format.fprintf formatter "@ ()@ in@]@]"

  initializer
    proplist <- List.remove_assoc "label" proplist
end




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
	let t = try List.assoc "text" listprop with Not_found -> "" in
	let tt = try List.assoc "tooltip" listprop with Not_found -> "" in
	let ptt = try List.assoc "tooltip_private" listprop
	with Not_found -> "" in
	let listp = List.fold_left ~f:(fun l p -> List.remove_assoc p l)
	    ~init:listprop
	    [ "text"; "tooltip"; "tooltip_private" ] in
	let b = toolbar#insert_button ~text:t ~tooltip:tt
	    ~tooltip_private:ptt () in
	let child = new tibutton_toolbar ~name ~widget:b ~pos:(-1)
	      ~insert_evbox:false ~parent_tree:stree parent_window ~toolbar:self in
	let tp = new prop_string ~name:"text" ~init:t
	    ~set:(fun v -> toolbar#set_text v (self#get_pos child); true)
	and ttp = new prop_string ~name:"tooltip" ~init:tt
	    ~set:(fun _ -> true)
	and pttp = new prop_string ~name:"tooltip_private" ~init:ptt
	    ~set:(fun _ -> true) in
	child#add_to_proplist
	  [ "text", tp; "tooltip", ttp; "tooltip_private", pttp ];
	child
    | "toggle_button" ->
	let t = try List.assoc "text" listprop with Not_found -> "" in
	let tt = try List.assoc "tooltip" listprop with Not_found -> "" in
	let ptt = try List.assoc "tooltip_private" listprop
	with Not_found -> "" in
	let listp = List.fold_left ~f:(fun l p -> List.remove_assoc p l)
	    ~init:listprop
	    [ "text"; "tooltip"; "tooltip_private" ] in
	let b = toolbar#insert_toggle_button ~text:t ~tooltip:tt
	    ~tooltip_private:ptt () in
	let child = new titoggle_button_toolbar ~name ~widget:b ~pos:(-1)
	      ~insert_evbox:false ~parent_tree:stree parent_window ~toolbar:self in
	let tp = new prop_string ~name:"text" ~init:t
	    ~set:(fun v -> toolbar#set_text v (self#get_pos child); true)
	and ttp = new prop_string ~name:"tooltip" ~init:tt
	    ~set:(fun _ -> true)
	and pttp = new prop_string ~name:"tooltip_private" ~init:ptt
	    ~set:(fun _ -> true) in
	child#add_to_proplist
	  [ "text", tp; "tooltip", ttp; "tooltip_private", pttp ];
	child
    | "radio_button" ->
	let t = try List.assoc "text" listprop with Not_found -> "" in
	let tt = try List.assoc "tooltip" listprop with Not_found -> "" in
	let ptt = try List.assoc "tooltip_private" listprop
	with Not_found -> "" in
	let listp = List.fold_left ~f:(fun l p -> List.remove_assoc p l)
	    ~init:listprop
	    [ "text"; "tooltip"; "tooltip_private" ] in
	let b = toolbar#insert_radio_button ~text:t ~tooltip:tt
	    ~tooltip_private:ptt () in
	let child = new tiradio_button_toolbar ~name ~widget:b ~pos:(-1)
	      ~insert_evbox:false ~parent_tree:stree parent_window ~toolbar:self in
	let tp = new prop_string ~name:"text" ~init:t
	    ~set:(fun v -> toolbar#set_text v (self#get_pos child); true)
	and ttp = new prop_string ~name:"tooltip" ~init:tt
	    ~set:(fun _ -> true)
	and pttp = new prop_string ~name:"tooltip_private" ~init:ptt
	    ~set:(fun _ -> true) in
	child#add_to_proplist
	  [ "text", tp; "tooltip", ttp; "tooltip_private", pttp ];
	child
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
	new prop_int ~name:"space_size" ~init:"5"
	  ~set:(ftrue toolbar#set_space_size);
	"space_style",
	new prop_toolbar_space_style ~name:"space_style" ~init:"EMPTY"
	  ~set:(ftrue toolbar#set_space_style);
	"tooltips",
	new prop_bool ~name:"tooltips" ~init:"true"
	  ~set:(ftrue toolbar#set_tooltips);
	"button_relief",
	new prop_relief_style ~name:"button_relief" ~init:"NORMAL"
	  ~set:(ftrue toolbar#set_button_relief)
      ]
end

let new_toolbar ~name ?(listprop = []) =
  new titoolbar ~name ~widget:(GToolbar2.toolbar2 ())


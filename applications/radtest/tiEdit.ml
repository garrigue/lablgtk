open Utils
open Property

open TiBase



class tientry ~(widget : GEdit.entry) ~name ~parent_tree ~pos
    ?(insert_evbox=true) parent_window =
object
  val entry = widget
  inherit tiwidget ~name ~widget ~parent_tree ~pos
      ~insert_evbox parent_window

  method private class_name = "GEdit.entry"
  initializer
    classe <- "entry";
      proplist <- proplist @
      [ "visibility",
	new prop_bool ~name:"visibility" ~init:"true"
	             ~set:(ftrue entry#set_visibility);
	"editable",
	new prop_bool ~name:"editable" ~init:"true"
	             ~set:(ftrue entry#set_editable)
      ]
end

let new_tientry ~name ?(listprop = []) =
  new tientry ~name ~widget:(GEdit.entry ())


class tispin_button ~(widget : GEdit.spin_button) ~name ~parent_tree ~pos
    ?(insert_evbox=true) parent_window =
object
    val spin_button = widget
  inherit tientry ~widget:(widget :> GEdit.entry) ~name ~parent_tree ~pos
      ~insert_evbox parent_window

  method private class_name = "GEdit.spin_button"
  initializer
    classe <- "spin_button";
      proplist <- proplist @
      [ "digits",
	new prop_int ~name:"digits" ~init:"0"
	             ~set:(ftrue spin_button#set_digits);
	"update_policy",
	new prop_spin_button_update_policy ~name:"update_policy"
	  ~init:"ALWAYS"
	  ~set:(ftrue spin_button#set_update_policy);
	"numeric",
	new prop_bool ~name:"numeric" ~init:"false"
	  ~set:(ftrue spin_button#set_numeric);
	"wrap",
	new prop_bool ~name:"wrap" ~init:"false"
	  ~set:(ftrue spin_button#set_wrap);
	"shadow_type",
	new prop_shadow ~name:"shadow_type" ~init:"NONE"
	  ~set:(ftrue spin_button#set_shadow_type);
	"snap_to_ticks",
	new prop_bool ~name:"snap_to_ticks" ~init:"false"
	  ~set:(ftrue spin_button#set_snap_to_ticks)
      ]
    
end


let get_adjustment () =
  let rv = ref 0. and rl = ref 0. and ru = ref 100. and rsi = ref 1.
      and rpi = ref 10. and rps = ref 10. in
  let w  = GWindow.window ~modal:true () in
  let v  = GPack.vbox  ~packing:w#add () in
  let l  = GMisc.label ~text:"adjustment properties" ~packing:v#pack () in
  let h1 = GPack.hbox ~packing:v#pack () in
  let l1 = GMisc.label ~text:"value" ~packing:h1#pack () in
  let e1 = GEdit.entry ~text:"0." ~packing:h1#pack () in
  let h2 = GPack.hbox ~packing:v#pack () in
  let l2 = GMisc.label ~text:"lower" ~packing:h2#pack () in
  let e2 = GEdit.entry ~text:"0." ~packing:h2#pack () in
  let h3 = GPack.hbox ~packing:v#pack () in
  let l3 = GMisc.label ~text:"upper" ~packing:h3#pack () in
  let e3 = GEdit.entry ~text:"100." ~packing:h3#pack () in
  let h4 = GPack.hbox ~packing:v#pack () in
  let l4 = GMisc.label ~text:"step_incr" ~packing:h4#pack () in
  let e4 = GEdit.entry ~text:"1." ~packing:h4#pack () in
  let h5 = GPack.hbox ~packing:v#pack () in
  let l5 = GMisc.label ~text:"page_incr" ~packing:h5#pack () in
  let e5 = GEdit.entry ~text:"10." ~packing:h5#pack () in
  let h6 = GPack.hbox ~packing:v#pack () in
  let l6 = GMisc.label ~text:"page_size" ~packing:h6#pack () in
  let e6 = GEdit.entry ~text:"10." ~packing:h6#pack () in
  let h7 = GPack.hbox ~packing:v#pack () in
  let b1 = GButton.button ~label:"OK" ~packing:h7#pack () in
  let b2 = GButton.button ~label:"Cancel" ~packing:h7#pack () in
  w#show ();
  b1#connect#clicked
    ~callback:(fun () ->
      begin
	try rv  := float_of_string e1#text with _ ->
	try rv  := float_of_int (int_of_string e1#text) with _ -> () end;
      begin
	try rl  := float_of_string e2#text with _ ->
	try rl  := float_of_int (int_of_string e2#text) with _ -> () end;
      begin
	try ru  := float_of_string e3#text with _ ->
	try ru  := float_of_int (int_of_string e3#text) with _ -> () end;
      begin
	try rsi := float_of_string e4#text with _ ->
	try rsi := float_of_int (int_of_string e4#text) with _ -> () end;
      begin
	try rpi := float_of_string e5#text with _ ->
	try rpi := float_of_int (int_of_string e5#text) with _ -> () end;
      begin
	try rps := float_of_string e6#text with _ ->
	try rps := float_of_int (int_of_string e6#text) with _ -> () end;
      w#destroy ());
  b2#connect#clicked ~callback:w#destroy;
  w#connect#destroy ~callback:GMain.Main.quit;
  GMain.Main.main ();
  !rv, !rl, !ru, !rsi, !rpi, !rps

let new_tispin_button ~name ?(listprop = []) =
  let v, l, u, si, pi, ps = get_adjustment () in
  new tispin_button ~name
    ~widget:(GEdit.spin_button ~adjustment:
	       (GData.adjustment ~value:v ~lower:l ~upper:u
		  ~step_incr:si ~page_incr:pi ~page_size:ps ()) ())
 


class ticombo ~(widget : GEdit.combo) ~name ~parent_tree ~pos
    ?(insert_evbox=true) parent_window =
object
  val combo = widget
  inherit tiwidget ~name ~widget ~parent_tree ~pos
      ~insert_evbox parent_window

  method private class_name = "GEdit.combo"
  initializer
    classe <- "combo";
      proplist <- proplist @
      [ "use_arrows",
	new prop_combo_use_arrows ~name:"use_arrows" ~init:"true"
	             ~set:(ftrue combo#set_use_arrows);
	"case_sensitive",
	new prop_bool ~name:"case_sensitive" ~init:"false"
	             ~set:(ftrue combo#set_case_sensitive)
      ]
end

let new_ticombo ~name ?(listprop = []) =
  new ticombo ~name ~widget:(GEdit.combo ())



(* $Id$ *)

open StdLabels
open GObj

open Common
open Utils

class type tiwidget_base = object
  method name : string
  method proplist : (string * prop) list
end

let prop_widget (prop : prop) =
  match prop#range with
    Enum l ->
      let w = GEdit.combo ~popdown_strings:l ~use_arrows:`ALWAYS () in
      w#entry#connect#changed ~callback:(fun () -> prop#set w#entry#text);
      w#entry#set_editable false;
      w#entry#set_text prop#get;
      w#coerce
  | String ->
      let w = GEdit.entry ~text:prop#get () in
      w#connect#activate ~callback:(fun () -> prop#set w#text);
      w#coerce
  | File ->
      let w = GPack.hbox () in
      let e = GEdit.entry ~text:prop#get ~editable:false ~packing:w#pack () in
      let b = GButton.button ~label:"..." ~packing:w#pack () in
      b#connect#clicked
	~callback:(fun () -> get_filename
	    ~callback:(fun name -> e#set_text name; prop#set name) (); ());
      w#coerce
  | Int ->
      let adjustment =
	GData.adjustment ~value:(float_of_string prop#get)
	  ~lower:(-2.) ~upper:5000. ~step_incr:1. ~page_incr:10. ~page_size:0. ()
      in
      let w = GEdit.spin_button ~rate:0.5 ~digits:0 ~adjustment () in
      w#connect#activate
	~callback:(fun () -> prop#set (string_of_int w#value_as_int));
      w#coerce
  | Float (lower, upper) ->
(*      let adjustment =
	GData.adjustment ~value:(float_of_string prop#get)
	  ~lower ~upper ~step_incr:((upper-.lower)/.100.)
	  ~page_incr:((upper-.lower)/.10.) ~page_size:0. ()
      in
      let w = GEdit.spin_button ~rate:0.5 ~digits:2 ~adjustment () in
      w#connect#activate
	~callback:(fun () -> prop#set (string_of_float w#value));
      w#coerce
*)
      let w = entry_float ~init:(float_of_string prop#get) () in
      w#connect#activate
	~callback:(fun () -> prop#set (string_of_float w#value));
      w#coerce
(*  | Adjust ->
      let wpop = GWindow.window ~title:"Adjustment values" () in
      let vb = GPack.vbox ~packing:wpop#add()  in
      let hb1 = GPack.hbox ~packing:vb#pack () in
      let l1 = GMisc.label ~text:"lower" ~packing:hb1#pack () in
      let e1 = entry_float ~packing:hb1#pack
	  ~init:(float_of_string prop#get) ~set:prop#set in
*)    
  | CList_titles ->
      let wpop = GWindow.window ~title:"titles of the columns" () in
      let vb = GPack.vbox ~packing:wpop#add () in
      let titles = split_string prop#get ~sep:' ' in
      let n = List.length titles in
      let rtitles = ref titles in
      let rget = ref [] and rset = ref [] in
      for i = 1 to n do
	match !rtitles with
	| hd::tl ->
	    let hb = GPack.hbox ~packing:vb#pack () in
	    let _ = GMisc.label ~text:("column" ^ (string_of_int i))
		~packing:hb#pack () in
	    let e = GEdit.entry ~text:hd ~packing:hb#pack () in
	    rtitles := tl;
	    rget := (fun () -> e#text) :: !rget;
	    rset := e#set_text :: !rset;
	| _ -> failwith "CList_titles: this cannot happen!!"
      done;
      rtitles := titles;
      rget := List.rev !rget;
      rset := List.rev !rset;
      let hb = GPack.hbox ~packing:vb#pack () in
      let ok = GButton.button ~label:"OK" ~packing:hb#pack () in
      let cancel = GButton.button ~label:"Cancel" ~packing:hb#pack () in
      ok#connect#pressed
	~callback:(fun () ->
	  let tit = List.map ~f:(fun f -> f ()) !rget in
	  prop#set (String.concat ~sep:" " tit);
	  rtitles := tit;
	  wpop#misc#hide ());
      cancel#connect#pressed
	~callback:(fun () ->
	  wpop#misc#hide ();
	  List.iter2 ~f:(fun f v -> f v) !rset !rtitles);
      let e = GEdit.entry ~text:"double click here" ~editable:false () in
      e#event#connect#button_press ~callback:
	(fun ev -> 
          GdkEvent.get_type ev = `TWO_BUTTON_PRESS &&
	  GdkEvent.Button.button ev = 1 &&
          begin
	    wpop#misc#show ();
            GtkSignal.stop_emit ();
            true
	  end);
      e#coerce

let prop_box list =
  let vbox = GPack.vbox () in
  List.iter list ~f:
    begin fun (name, prop) ->
      let hbox =
	GPack.hbox ~homogeneous:true ~packing:(vbox#pack ~expand:false) () in
      GMisc.label ~text:name ~packing:hbox#pack ();
      hbox#pack ~fill:true (prop_widget prop);
      GMisc.separator `HORIZONTAL ~packing:(vbox#pack ~expand:false) ();
      ()
    end;
  vbox

class ['a] frozen lz = object
  method get : 'a = Lazy.force lz
end

let vbox =
  new frozen (lazy (GWindow.window ~show:true ~title:"Properties" ()))

let init () = vbox#get

let widget_pool = Hashtbl.create 7

let boxref = ref None
let shown_widget = ref ""

let show_prop_box vb =
  Gaux.may !boxref ~f:vbox#get#remove;
  vbox#get#add vb#coerce;
  boxref := Some vb#coerce

let show (w : #tiwidget_base) =
  let name = w#name in
  let vb =
    try
      Hashtbl.find widget_pool name
    with Not_found ->
      let vb = prop_box w#proplist in
      Hashtbl.add' widget_pool ~key:name ~data:vb;
      vb
  in
  show_prop_box vb;
  shown_widget := name

let add (w : #tiwidget_base) =
  let vb = prop_box w#proplist in
  Hashtbl.add' widget_pool ~key:w#name ~data:vb


let remove name =
  Hashtbl.remove widget_pool name;
  if !shown_widget = name then begin
    shown_widget := "";
    show_prop_box (GMisc.label ~text:"No widget selected" ())
  end

(*
let change_name oldname newname =
  let vb = Hashtbl.find widget_pool oldname in
  Hashtbl.remove widget_pool oldname;
  Hashtbl.add widget_pool ~key:newname ~data:vb
*)

let update (w : #tiwidget_base) show_modif =
  let vb = prop_box w#proplist in
  Hashtbl.remove widget_pool w#name;
  Hashtbl.add' widget_pool ~key:w#name ~data:vb;
  if show_modif && !shown_widget = w#name then show_prop_box vb

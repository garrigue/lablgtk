(* $Id$ *)

open GObj

open Common

class type tiwidget_base = object
  method name : string
  method proplist : (string * prop) list
end

let prop_widget (prop : prop) =
  match prop#range with
    Enum l ->
      let w = GEdit.combo popdown_strings:l use_arrows:`ALWAYS () in
      w#entry#connect#changed callback:(fun () -> prop#set w#entry#text);
      w#entry#set_editable false;
      w#entry#set_text prop#get;
      w#coerce
  | String ->
      let w = GEdit.entry text:prop#get () in
      w#connect#activate callback:(fun () -> prop#set w#text);
      w#coerce
  | Int ->
      let adjustment =
	GData.adjustment value:(float_of_string prop#get)
	  lower:(-2.) upper:5000. step_incr:1. page_incr:10. page_size:0. ()
      in
      let w = GEdit.spin_button rate:0.5 digits:0 :adjustment () in
      w#connect#activate
	callback:(fun () -> prop#set (string_of_int w#value_as_int));
      w#coerce
  | Float (lower, upper) ->
      let adjustment =
	GData.adjustment value:(float_of_string prop#get)
	  :lower :upper step_incr:((upper-.lower)/.100.)
	  page_incr:((upper-.lower)/.10.) page_size:0. ()
      in
      let w = GEdit.spin_button rate:0.5 digits:2 :adjustment () in
      w#connect#activate
	callback:(fun () -> prop#set (string_of_float w#value));
      w#coerce

let prop_box list =
  let vbox = GPack.vbox () in
  List.iter list fun:
    begin fun (name, prop) ->
      let hbox =
	GPack.hbox homogeneous:true packing:(vbox#pack expand:false) () in
      GMisc.label text:name packing:hbox#pack ();
      hbox#pack fill:true (prop_widget prop);
      GMisc.separator `HORIZONTAL packing:(vbox#pack expand:false) ();
      ()
    end;
  vbox

class ['a] frozen lz = object
  method get : 'a = Lazy.force lz
end

let vbox =
  new frozen (lazy (GWindow.window show:true title:"Properties" ()))

let init () = vbox#get

let widget_pool = Hashtbl.create size:7

let boxref = ref None
let shown_widget = ref ""

let show_prop_box vb =
  Misc.may !boxref fun:vbox#get#remove;
  vbox#get#add vb#coerce;
  boxref := Some vb#coerce

let show (w : #tiwidget_base) =
  let name = w#name in
  let vb =
    try
      Hashtbl.find widget_pool key:name
    with Not_found ->
      let vb = prop_box w#proplist in
      Hashtbl.add widget_pool key:name data:vb;
      vb
  in
  show_prop_box vb;
  shown_widget := name

let add (w : #tiwidget_base) =
  let vb = prop_box w#proplist in
  Hashtbl.add widget_pool key:w#name data:vb


let remove name =
  Hashtbl.remove widget_pool key:name;
  if !shown_widget = name then begin
    shown_widget := "";
    show_prop_box (GMisc.label text:"No widget selected" ())
  end

let change_name oldname newname =
  let vb = Hashtbl.find widget_pool key:oldname in
  Hashtbl.remove widget_pool key:oldname;
  Hashtbl.add widget_pool key:newname data:vb

let update (w : #tiwidget_base) =
  let vb = prop_box w#proplist in
  Hashtbl.remove widget_pool key:w#name;
  Hashtbl.add widget_pool key:w#name data:vb;
  if !shown_widget = w#name then show_prop_box vb

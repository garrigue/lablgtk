(* $Id$ *)

open GObj
open GPack

open Common

class type tiwidget_base = object
  method name : string
  method proplist : (string * prop) list
end

let prop_widget (prop : prop) =
  match prop#range with
    Enum l ->
      let w =
	new GEdit.combo popdown_strings:l use_arrows:`ALWAYS
      in
      w#entry#connect#changed callback:(fun () -> prop#set w#entry#text);
      w#entry#set_editable false;
      w#entry#set_text prop#get;
      (w :> widget)
  | String ->
      let w = new GEdit.entry text:prop#get in
      w#connect#activate callback:(fun () -> prop#set w#text);
      (w :> widget)
  | Int ->
      let adjustment =
	new GData.adjustment value:(float_of_string prop#get)
	  lower:(-2.) upper:5000. step_incr:1. page_incr:10. page_size:0.
      in
      let w =
	new GEdit.spin_button rate:0.5 digits:0 :adjustment in
      w#connect#activate
	callback:(fun () -> prop#set (string_of_int w#value_as_int));
      (w :> widget)
  | Float (lower, upper) ->
      let adjustment =
	new GData.adjustment value:(float_of_string prop#get)
	  :lower :upper step_incr:((upper-.lower)/.100.)
	  page_incr:((upper-.lower)/.10.) page_size:0.
      in
      let w = new GEdit.spin_button rate:0.5 digits:2 :adjustment in
      w#connect#activate
	callback:(fun () -> prop#set (string_of_float w#value));
      (w :> widget)

let prop_box list ?:packing ?:show =
  let vbox = new box `VERTICAL ?:packing ?:show in
  List.iter list fun:
    begin fun (name, prop) ->
      let hbox = new hbox homogeneous:true packing:(vbox#pack expand:false) in
      hbox#pack fill:true (new GMisc.label text:name);
      hbox#pack fill:true (prop_widget prop);
      vbox#pack expand:false (new GMisc.separator `HORIZONTAL)
    end;
  vbox

class ['a] frozen lz = object
  method get : 'a = Lazy.force lz
end

let vbox =
  new frozen (lazy (new GWindow.window show:true title:"Properties"))

let init () = vbox#get

let widget_pool = new Omap.c []

let boxref = ref None
let shown_widget = ref ""

let show_prop_box vb =
  Misc.may !boxref fun:vbox#get#remove;
  vbox#get#add vb;
  boxref := Some vb

let show (w : #tiwidget_base) =
  let name = w#name in
  let vb =
    try
      widget_pool#find key:name
    with Not_found ->
      let vb = prop_box w#proplist in
      widget_pool#add key:name data:vb;
      vb
  in
  show_prop_box vb;
  shown_widget := name

let add (w : #tiwidget_base) =
  let vb = prop_box w#proplist in
  widget_pool#add key:w#name data:vb


let remove name =
  widget_pool#remove key:name;
  if !shown_widget = name then begin
    shown_widget := "";
    show_prop_box (widget_pool#find key:"")
  end

let change_name oldname newname =
  let vb = widget_pool#find key:oldname in
  widget_pool#remove key:oldname;
  widget_pool#add key:newname data:vb

let update (w : #tiwidget_base) =
  let vb = prop_box w#proplist in
  widget_pool#remove key:w#name;
  widget_pool#add key:w#name data:vb;
  if !shown_widget = w#name then show_prop_box vb

(* $Id$ *)

module Array = StdLabels.Array

(* To create a new widget:
   create an array sig_array containing the signals defined by
   the new widget;
   call:
      make_new_widget name parent:parent signal_array:sig_array
   where name is the name of the new widget (a string)
   parent is the type of the parent: of type Gtk.New.object_type
   This call returns a triple:
     (get_type_func, new_func, sig_array_num)
   where get_type_func is the new widget get_type function,
   new_func is the function returning a new widget of the new type
   sig_array_num is an array containing the Gtk id of the signals
   of the new widget.
*)

module Tictactoe = struct
  type t = [`base|`widget|`container|`box|`tictactoe]
  module Signals = struct
    module S = GtkSignal
    let tictactoe : ([>`tictactoe],_) S.t =
      { S.classe = `tictactoe; S.name = "tictactoe";
        S.marshaller = S.marshal_unit }
    let emit_tictactoe = S.emit_unit ~sgn:tictactoe
  end
  let create : unit -> t Gtk.obj =
    let _,tictactoe_new = GtkNew.make_new_widget
	~name:"Tictactoe" ~parent:GtkNew.VBOX ~signals:[Signals.tictactoe]
    in fun () -> GtkBase.Object.try_cast (tictactoe_new ()) "Tictactoe"
end

class tictactoe_signals obj = object
  inherit GContainer.container_signals obj
  method tictactoe =
    GtkSignal.connect ~sgn:Tictactoe.Signals.tictactoe obj ~after
end

exception Trouve

class tictactoe ?packing ?show () =
  let obj : Tictactoe.t Gtk.obj = Tictactoe.create () in
  let box = new GPack.box_skel obj in
object (self)
  inherit GObj.widget obj
  val mutable buttons = [||]
  val mutable buttons_handlers = [||]
  val label = GMisc.label ~text:"Go on!" ~packing:box#add ()
  method clear () =
    for i = 0 to 2 do
      for j = 0 to 2 do
	let button = buttons.(i).(j)
	and handler = buttons_handlers.(i).(j) in
	button#misc#handler_block handler;
	button#set_active false;
	button#misc#handler_unblock handler
      done
    done
  method connect = new tictactoe_signals obj
  method emit_tictactoe () =
    GtkSignal.emit_unit obj ~sgn:Tictactoe.Signals.tictactoe
  method toggle () =
    let rwins = [| [| 0; 0; 0 |]; [| 1; 1; 1 |]; [| 2; 2; 2 |];
                   [| 0; 1; 2 |]; [| 0; 1; 2 |]; [| 0; 1; 2 |];
                   [| 0; 1; 2 |]; [| 0; 1; 2 |] |]
    and cwins = [| [| 0; 1; 2 |]; [| 0; 1; 2 |]; [| 0; 1; 2 |];
                   [| 0; 0; 0 |]; [| 1; 1; 1 |]; [| 2; 2; 2 |];
                   [| 0; 1; 2 |]; [| 2; 1; 0 |] |] in
    label#set_text"Go on!";
    try
      for k = 0 to 7 do
	let rec aux i =
	  (i = 3) ||
	  (buttons.(rwins.(k).(i)).(cwins.(k).(i))#active) && (aux (i+1)) in
	if aux 0 then raise Trouve
      done
    with Trouve -> label#set_text "Win!!"; self#emit_tictactoe ()
	
  initializer
    let table =
      GPack.table ~rows:3 ~columns:3 ~homogeneous:true ~packing:box#add () in
    buttons <-
      Array.init 3 ~f:
	(fun i -> Array.init 3 ~f:
	    (fun j ->
	      GButton.toggle_button ~width:20 ~height:20
		~packing:(table#attach ~left:i ~top:j ~expand:`BOTH) ()));
    buttons_handlers <-
      Array.mapi buttons ~f:
	(fun i -> Array.mapi ~f:
	  (fun j button -> button #connect#toggled ~callback:self#toggle));
    GObj.pack_return self ~packing ~show;
    ()
end

let win (ttt : tictactoe)  _ =
  Printf.printf "Gagne!!\n" ;
  flush stdout;
  ttt #clear ()

let essai () =
  let window = GWindow.window ~title:"Tictactoe" ~border_width:10 () in
  window #connect#destroy ~callback:GMain.Main.quit;
  let ttt = new tictactoe ~packing:window#add () in
  ttt #connect#tictactoe ~callback:(win ttt);
  window #show ();
  GMain.Main.main ()

let _ = essai ()
  

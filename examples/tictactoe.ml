(* $Id$ *)

open GtkNew

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
  open GtkSignal
  let tictactoe : (_,_) t =
    { name = "tictactoe"; marshaller = marshal_unit }
  let tictactoe_sig : ([`widget] Gtk.obj, _) t array
      = [| tictactoe |]
end


let _,tictactoe_new,_ = make_new_widget "Tictactoe" ~parent:VBOX
    ~signal_array:Tictactoe.tictactoe_sig


open GMain

class tictactoe_signals obj = object
  inherit GContainer.container_signals obj
  method tictactoe = GtkSignal.connect ~sgn:Tictactoe.tictactoe obj ~after
end

exception Trouve

class tictactoe ?packing ?show () =
  let obj : Gtk.box Gtk.obj = GtkBase.Object.unsafe_cast (tictactoe_new ()) in
  let box = new GPack.box_skel obj in
object (self)
  inherit GObj.widget obj
  val buttons = Array.create_matrix ~dimx:3 ~dimy:3 (GButton.toggle_button ())
  val buttons_handlers = Array.create_matrix ~dimx:3 ~dimy:3 (Obj.magic 0)
  val label = GMisc.label ~text:"Go on!" ~packing:box#add ()
  method clear () =
    for i = 0 to 2 do
      for j = 0 to 2 do
	GtkSignal.handler_block (buttons.(i).(j) #as_widget)
	  buttons_handlers.(i).(j);
	buttons.(i).(j)#set_active false;
	GtkSignal.handler_unblock (buttons.(i).(j) #as_widget)
	  buttons_handlers.(i).(j)
      done
    done
  method connect = new tictactoe_signals obj
  method emit_tictactoe () = GtkSignal.emit obj ~sgn:Tictactoe.tictactoe
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
    for i = 0 to 2 do
      for j = 0 to 2 do
	let button = GButton.toggle_button ~width:20 ~height:20
	    ~packing:(table#attach ~left:i ~top:j ~expand:`BOTH) () in
	buttons.(i).(j) <- button;
	buttons_handlers.(i).(j) <-
	  button #connect#toggled ~callback:self#toggle;
      done
    done;
    GObj.pack_return self ~packing ~show;
    ()
end

let win (ttt : tictactoe)  _ =
  Printf.printf "Gagne!!\n" ;
  ttt #clear ()

let essai () =
  let window = GWindow.window ~title:"Tictactoe" ~border_width:10 () in
  window #connect#destroy ~callback:Main.quit;
  let ttt = new tictactoe ~packing:window#add () in
  ttt #connect#tictactoe ~callback:(win ttt);
  window #show ();
  Main.main ()

let _ = essai ()
  

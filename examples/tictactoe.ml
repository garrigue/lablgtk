(* $Id$ *)

open GtkNew

(* pour definir un nouveau widget, il faut faire
   un tableau contenant les signaux qu'emettra le
   widget; puis on appelle make_new_widget avec
   comme parametres le nom de la classe, la classe parent
   (type object_type), et le tableau;
   cette fonction renvoie la fonction qui cree un nouveau
   widget du nouveau type;

   limitations: les signaux ne sont pour l'instant que du type
   standard
*)

module Tictactoe = struct
  open GtkSignal
  let tictactoe : (_,_) t =
    { name = "tictactoe"; marshaller = marshal_unit }
  let tictactoe_sig : ([widget] Gtk.obj, _) t array
      = [| tictactoe |]
end


let _,tictactoe_new,_ = make_new_widget "Tictactoe" parent:VBOX
    signal_array:Tictactoe.tictactoe_sig


open GMain

class tictactoe_signals obj = object
  inherit GContainer.container_signals obj
  method tictactoe = GtkSignal.connect sig:Tictactoe.tictactoe obj
end

exception Trouve

class tictactoe =
  let obj = tictactoe_new () in
object(self)
  inherit GPack.box_skel obj
  val buttons = Array.create_matrix cols:3 rows:3
      fill:(new GButton.toggle_button)
  val buttons_handlers = Array.create_matrix cols:3 rows:3 fill:(Obj.magic 0)
  val label = new GMisc.label text:"Go on!"
  method clear () =
    for i = 0 to 2 do
      for j = 0 to 2 do
	GtkSignal.handler_block (buttons.(i).(j) #as_widget)
	  buttons_handlers.(i).(j);
	buttons.(i).(j)#set_toggle active: false;
	GtkSignal.handler_unblock (buttons.(i).(j) #as_widget)
	  buttons_handlers.(i).(j)
      done
    done
  method connect = new tictactoe_signals obj
  method emit_tictactoe () = GtkSignal.emit obj sig:Tictactoe.tictactoe
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
    let table = new GPack.table rows:3 columns:3 homogeneous:true in
    self#pack label;
    self#pack table;
    for i = 0 to 2 do
      for j = 0 to 2 do
	buttons.(i).(j) <- new GButton.toggle_button;
	table #attach buttons.(i).(j) left:i top:j;
	buttons_handlers.(i).(j) <-
	  buttons.(i).(j) #connect#toggled callback:self#toggle;
	buttons.(i).(j) #misc#set width:20 height:20;
      done
    done
end

let win (ttt : tictactoe)  _ =
  Printf.printf "Gagne!!\n" ;
  ttt #clear ()

let essai () =
  let window =
    new GWindow.window title:"Tictactoe" border_width:10 in
  window #connect#destroy callback:Main.quit;
  let ttt = new tictactoe in
  window#add ttt;
  ttt #show ();
  ttt #connect#tictactoe callback:(win ttt);
  window #show ();
  Main.main ()
;;

essai ()
  

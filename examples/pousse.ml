(* $Id$ *)

open Gtk
open GtkObj
open GdkObj

let window = new_window `TOPLEVEL

let pixdraw = new pixdraw parent:window width:40 height:40
let pixdraw1 = new pixdraw parent:window width:40 height:40
let pixdraw2 = new pixdraw parent:window width:40 height:40

let _ =
  pixdraw1#set foreground:`Black;
  pixdraw1#arc x:3 y:3 width:34 height:34 filled:true;
  pixdraw2#set foreground:`White;
  pixdraw2#arc x:3 y:3 width:34 height:34 filled:true;
  pixdraw2#set foreground:`Black;
  pixdraw2#arc x:3 y:3 width:34 height:34

class cell () = object (self)
  inherit button (Button.create ())
  val pm = new_pixdraw pixdraw
  val mutable color : [none white black] = `none
  method color = color
  method set_color col =
    color <- col;
    set_pixdraw pm
      (match col with `none -> pixdraw
      |	`black -> pixdraw1
      |	`white -> pixdraw2)
  initializer
    self#add pm;
    ()
end

let cells =
  Array.init len:8
    fun:(fun _ -> Array.init len:8 fun:(fun _ -> new cell ()))

let on_board x y =
  x >= 0 && x < 8 && y >= 0 && y < 8

let rec string :x :y :dx :dy :color l =
  let x = x+dx and y = y+dy in
  if on_board x y then
    let col = cells.(x).(y)#color in 
    if col = color then l else
    if col = `none then [] else
    string :x :y :dx :dy :color ((x,y)::l)
  else []

let action x y :color =
  let color = (color : [white black] :> [white black none]) in
  if cells.(x).(y)#color <> `none then false else
  let swaps =
    List.fold_left [-1,-1; -1,0; -1,1; 0,-1; 0,1; 1,-1; 1,0; 1,1]
      acc:[]
      fun:(fun :acc (dx,dy) -> string :x :y :dx :dy :color [] @ acc)
  in
  if swaps = [] then false else begin
    List.iter ((x,y)::swaps) fun:(fun (x,y) -> cells.(x).(y)#set_color color);
    true
  end

let count_cells () =
  Array.fold_left
    (Array.fold_left
       begin fun (w,b) (cell : cell) ->
	 match cell#color with
	   `white -> (w+1,b) | `black -> (w,b+1) | `none -> (w,b)
       end)
    (0,0) cells

let table = new_table columns:8 rows:8
let vbox = new_box `VERTICAL
let hbox = new_box `HORIZONTAL
let frame = new_frame ()
let label = new_label label:""

let update_label () =
  let w, b = count_cells () in
  label#set label:(Printf.sprintf "White: %d Black: %d" w b)

let bar = new_statusbar ()
let turn = bar#new_context name:"turn"
let messages = bar#new_context name:"messages"

let current_color = ref `white

let _ =
  window#connect#destroy callback:Main.quit;
  window#set title:"pousse";
  window#add vbox;
  vbox#add table;
  vbox#add hbox;
  hbox#add bar;
  hbox#pack frame expand:false;
  frame#set shadow_type:`IN;
  frame#add label;
  label#set justify:`LEFT xpad:5 xalign:0.0;
  for i = 0 to 7 do for j = 0 to 7 do
    let cell = cells.(i).(j) in
    cell#connect#event#enter_notify
      callback:(fun _ -> cell#misc#grab_focus (); false);
    cell#connect#clicked callback:
      begin fun () ->
	if action i j color:!current_color then begin
	  update_label ();
	  current_color :=
	    match !current_color with
	      `white -> turn#pop (); turn#push "Player is black"; `black
	    | `black -> turn#pop (); turn#push "Player is white"; `white
	end else
	  messages#flash "You cannot play there"
      end;
    table#attach left:i top:j cell
  done done;
  cells.(3).(3)#set_color `white;
  cells.(4).(4)#set_color `white;
  cells.(3).(4)#set_color `black;
  cells.(4).(3)#set_color `black;
  update_label ();
  turn#push "Player is white";
  window#show_all ();
  Main.main ()

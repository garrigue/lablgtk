(* $Id$ *)

open Gtk
open GtkObj
open GdkObj

(* The game logic *)

type color = [none white black]

module type BoardSpec = sig
  type t
  val size : int
  val get : t -> x:int -> y:int -> color
  val set : t -> x:int -> y:int -> color:color -> unit
end

module Board (Spec : BoardSpec) = struct
  open Spec
  let size = size

  let on_board x y =
    x >= 0 && x < size && y >= 0 && y < size

  let rec string board :x :y :dx :dy :color l =
    let x = x+dx and y = y+dy in
    if on_board x y then
      let col = get board :x :y in 
      if col = (color : [white black] :> color) then l else
      if col = `none then [] else
      string board :x :y :dx :dy :color ((x,y)::l)
    else []

  let find_swaps board :x :y :color =
    if get board :x :y <> `none then [] else
    List.fold_left [-1,-1; -1,0; -1,1; 0,-1; 0,1; 1,-1; 1,0; 1,1]
      acc:[]
      fun:(fun :acc (dx,dy) -> string board :x :y :dx :dy :color [] @ acc)

  let action board :x :y :color =
    let swaps = find_swaps board :x :y :color in
    if swaps = [] then false else begin
      List.iter ((x,y)::swaps)
	fun:(fun (x,y) -> set board :x :y color:(color :> color));
      true
    end

  let check_impossible board :color =
    try
      for x = 0 to size - 1 do for y = 0 to size - 1 do
	if find_swaps board :x :y :color <> [] then raise Exit
      done done;
      true
    with Exit -> false

  let count_cells board =
    let w = ref 0 and b = ref 0 in
    for x = 0 to size - 1 do for y = 0 to size - 1 do
      match get board :x :y with
	`white -> incr w
      | `black -> incr b
      | `none -> ()
    done done;
    (!w,!b)
end

(* GUI *)

(* Toplevel window *)

let window = new_window `TOPLEVEL title:"pousse"

(* Create pixmaps *)

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

(* The cell class: a button with a pixmap on it *)

class cell () = object (self)
  inherit button_create ()
  val mutable color : color = `none
  val pm = new_pixdraw pixdraw
  method color = color
  method set_color col =
    if col <> color then begin
      color <- col;
      set_pixdraw pm
	(match col with `none -> pixdraw
	| `black -> pixdraw1
	| `white -> pixdraw2)
    end
  initializer
    self#add pm;
    ()
end

module RealBoard = Board (
  struct
    type t = cell array array
    let size = 8
    let get (board : t) :x :y = board.(x).(y)#color
    let set (board : t) :x :y :color = board.(x).(y)#set_color color
  end
)

(* Conducting a game *)

open RealBoard

class game frame:(frame : _ #container_skel) :label
    statusbar:(bar : #statusbar) =
object (self)
  val cells =
    Array.init len:size
      fun:(fun _ -> Array.init len:size fun:(fun _ -> new cell ()))
  val table = new_table columns:size rows:size packing:frame#add
  val label : #label = label
  val turn = bar#new_context name:"turn"
  val messages = bar#new_context name:"messages"
  val mutable current_color = `black
  method board = cells
  method table = table
  method player = current_color

  method swap_players () =
    current_color <-
      match current_color with
	`white -> turn#pop (); turn#push "Player is black"; `black
      | `black -> turn#pop (); turn#push "Player is white"; `white

  method finish () =
    turn#pop ();
    let w, b = count_cells cells in
    turn#push
      (if w > b then "White wins" else
       if w < b then "Black wins" else
       "Game is a draw");
    ()

  method update_label () =
    let w, b = count_cells cells in
    label#set label:(Printf.sprintf "White: %d Black: %d" w b)

  method play x y =
    if action cells :x :y color:current_color then begin
      self#update_label ();
      self#swap_players ();
      if check_impossible cells color:current_color then begin
	self#swap_players ();
	if check_impossible cells color:current_color then self#finish ()
      end
    end else
      messages#flash "You cannot play there"

  initializer
    for i = 0 to size-1 do for j = 0 to size-1 do
      let cell = cells.(i).(j) in
      cell#connect#event#enter_notify
	callback:(fun _ -> cell#misc#grab_focus (); false);
      cell#connect#clicked callback:(fun () -> self#play i j);
      table#attach left:i top:j cell
    done done;
    List.iter fun:(fun (x,y,col) -> cells.(x).(y)#set_color col)
      [ 3,3,`black; 4,4,`black; 3,4,`white; 4,3,`white ];
    self#update_label ();
    turn#push "Player is black";
    ()
end

(* Graphical elements *)

let vbox = new_box `VERTICAL packing:window#add
let frame = new_frame shadow_type:`IN packing:vbox#add
let hbox = new_box `HORIZONTAL packing:vbox#add

let bar = new_statusbar packing:hbox#add

let frame2 = new_frame shadow_type:`IN packing:(hbox#pack expand:false)
let label = new_label justify:`LEFT xpad:5 xalign:0.0 packing:frame2#add

let game = new game :frame :label statusbar:bar

(* Start *)

let _ =
  window#connect#destroy callback:Main.quit;
  window#show_all ();
  Main.main ()


open Gtk
open GObj
open GContainer

open Utils
open Property

open TiBase

(* for containers being able to have at least one child;
   not for buttons (can't have children) *)

class virtual ticontainer ~widget ~name
    ?(insert_evbox=true) ~parent_tree ~pos parent_window =
object(self)

  val container = (widget : #container :> container)

  inherit tiwidget ~name ~widget ~insert_evbox
      ~parent_tree ~pos parent_window as widget

(* name of the add method: add for most bin widgets,
   pack for boxes, add_with_viewport for scrolled windows... *)
  method private name_of_add_method = "#add"

  method private add child ~pos =
    container#add child#base;
    children <- [child, `START];
    self#set_full_menu false;
    tree_item#drag#dest_unset ()

  method remove child =
    container#remove child#base;
    children <- [];
    self#set_full_menu true;
    tree_item#drag#dest_set ~actions:[`COPY]
      [ { target = "STRING"; flags = []; info = 0} ]

  method private menu ~time =
    let menu = GMenu.menu () and menu_add = GMenu.menu () in
    List.iter
      ~f:(fun n ->
	let mi = GMenu.menu_item ~packing:menu_add#append ~label:n ()
	in mi#connect#activate
	  ~callback:(fun () -> self#add_child n ();()); ())
      widget_add_list;      
    let mi_add = GMenu.menu_item ~packing:menu#append
	~label:("add to " ^ name) ()
    and mi_remove = GMenu.menu_item ~packing:menu#append
	~label:("remove " ^ name) ()
    and mi_cut  = GMenu.menu_item ~packing:menu#append ~label:"Cut" ()
    and mi_copy = GMenu.menu_item ~packing:menu#append ~label:"Copy" ()
    and mi_paste = GMenu.menu_item ~packing:menu#append ~label:"Paste" () in
    mi_remove#connect#activate ~callback:self#remove_me;
    mi_add#set_submenu menu_add;
    mi_copy#connect#activate ~callback:self#copy;
    mi_cut#connect#activate ~callback:self#cut;
    if !selection <> ""
    then begin mi_paste#connect#activate ~callback:self#paste; () end
    else mi_paste#misc#set_sensitive false;
    menu#popup ~button:3 ~time

  method emit_init_code c ~packing =
    widget#emit_init_code c ~packing;
    self#forall ~callback:(fun child -> child#emit_init_code c
	~packing:(name ^ self#name_of_add_method))

  method emit_method_code c =
    widget#emit_method_code c;
    self#forall ~callback:(fun child -> child#emit_method_code c)

  method emit_initializer_code c =
    widget#emit_initializer_code c;
    self#forall ~callback:(fun child -> child#emit_initializer_code c)


  initializer
    proplist <-  proplist @
      [ "border width",	new prop_int ~name:"border_width" ~init:"0"
	                  ~set:(ftrue container#set_border_width) ];

    tree_item#drag#dest_set ~actions:[`COPY]
      [ { target = "STRING"; flags = []; info = 0} ];
    tree_item#connect#drag#data_received ~callback:
      begin fun (context : drag_context) ~x ~y
	  (data : selection_data) ~info ~time ->
	    self#add_child data#data ();
	    context#finish ~success:true ~del:false ~time
      end;()
end


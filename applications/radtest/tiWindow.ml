(* $Id$ *)

open StdLabels

open Utils
open Property

open TiBase
open TiContainer


class tiwindow ~widget ~name ~parent_tree ~pos ?(insert_evbox=true)
    parent_window =
object(self)
  val window = widget
  inherit ticontainer ~name ~widget
      ~insert_evbox:false ~parent_tree ~pos parent_window as container

  method connect_event = window#event#connect

  method private class_name = "GWindow.window"

  method private get_mandatory_props = [ "title" ]

(*  method private save_clean_proplist =
    List.remove_assoc "title" container#save_clean_proplist

  method private emit_clean_proplist plist =
    List.remove_assoc "title" (container#emit_clean_proplist plist)
*)
  method remove_me () =
    let sref = ref "" in
    self#save_to_string sref;
    let lexbuf = Lexing.from_string !sref in
    let node = Load_parser.window Load_lexer.token lexbuf in
    add_undo (Add_window node);
    self#remove_me_without_undo ()

  method copy () = self#copy_to_sel window_selection

  method remove_me_without_undo () =
    self#forall ~callback:(fun tiw -> tiw#remove_me_without_undo ());
    parent_window#remove_sel (self : #tiwidget0 :> tiwidget0);
    name_list := list_remove !name_list ~f:(fun n -> n=name);
    Hashtbl.remove widget_map name;
    Propwin.remove name;
    widget#destroy ()

  method private get_packing packing = ""

  method emit_code f param_list =
    let param_string =
      match param_list with
      |	 [] -> ""
      |	_ -> "['" ^
	  (String.concat ~sep:", '"
	     (List.map ~f:(fun c -> (String.make 1 c)) param_list)) ^
	  "] " in
    Format.fprintf f "(* Code for %s *)@\n@\n@[<hv 2>class %s%s () ="
      name param_string name;
    self#emit_init_code f ~packing:"";
    Format.fprintf f "@]@\n@[<hv 2>object (self)";
    self#emit_method_code f;
    Format.fprintf f "@ method show () = %s#show ()" name;
    Format.fprintf f "@ @[<v 2>initializer";
    self#emit_initializer_code f;
    Format.fprintf f "@ ()@]@]@ end@\n@\n"

(*  method private save_start formatter =
    Format.fprintf formatter "@[<0>@\n@[<2><window name=%s>" name;
    Format.fprintf formatter "@\ntitle=\"%s\""
      (List.assoc "title" proplist)#get
*)
  method private save_end formatter =
    Format.fprintf formatter "@]@\n</window>@\n@]"

  method private menu ~time =
    let menu = GMenu.menu () and menu_add = GMenu.menu () in
    List.iter
      ~f:(fun n ->
	let mi = GMenu.menu_item ~packing:menu_add#append ~label:n ()
	in mi#connect#activate
	  ~callback:(fun () -> self#add_child n (); ()); ())
      widget_add_list;      
    let mi_add = GMenu.menu_item ~packing:menu#append ~label:("add to "^ name) ()
    and mi_paste = GMenu.menu_item ~packing:menu#append ~label:"Paste" ()
    in
    mi_add#set_submenu menu_add;
    if !selection <> ""
    then begin mi_paste#connect#activate ~callback:self#paste; () end
    else mi_paste#misc#set_sensitive false;
    menu#popup ~button:3 ~time


  initializer
    classe <- "window";
    window#set_title name;
    proplist <-	proplist @
      [ "title",
	new prop_string ~name:"title" ~init:name ~set:(ftrue window#set_title);
	"allow_shrink",	new prop_bool ~name:"allow_shrink" ~init:"false"
	                  ~set:(ftrue window#set_allow_shrink);
	"allow_grow", new prop_bool ~name:"allow_grow" ~init:"true"
	                ~set:(ftrue window#set_allow_grow);
	"auto_shrink", new prop_bool ~name:"auto_shrink" ~init:"false"
	                 ~set:(ftrue window#set_auto_shrink);
	"x position", new prop_int ~name:"x" ~init:"-2"
	  ~set:(fun x -> window#misc#set_geometry ~x (); true);
	"y position", new prop_int ~name:"y" ~init:"-2"
	  ~set:(fun y -> window#misc#set_geometry ~y (); true) ]
end

let new_tiwindow ~name ?(listprop = []) =
  let w = GWindow.window ~show:true () in
  w#misc#set_can_focus false;
  w#misc#set_can_default false;
  new tiwindow ~widget:w ~name




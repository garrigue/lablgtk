
(* Various experiments with GtkTreeModelSort and GtkTreeModelFilter *)

let data = [
  `HOME,    "home",   true ;
  `JUMP_TO, "go",     true ;
  `QUIT,    "quit",   false ;
  `STOP,    "stop",   true ;
  `DELETE,  "delete", false ;
]

(* Sort function: sort according to string length ! *)
let sort_function column (model : GTree.tree_sortable) it_a it_b =
  let a = model#get ~row:it_a ~column in
  let b = model#get ~row:it_b ~column in
  compare (String.length a) (String.length b)


let print_flags name (m : #GTree.model) =
  Format.printf "%sflags: %s@." name
    (String.concat "; "
       (List.map
	  (function 
	    | `ITERS_PERSIST -> "persistent iterators"
	    | `LIST_ONLY     -> "list only")
	  m#flags))


let make_model data =
  let cols = new GTree.column_list in
  let stock_id_col = cols#add GtkStock.conv in
  let str_col      = cols#add Gobject.Data.string in
  let vis_col      = cols#add Gobject.Data.boolean in
  let l = GTree.list_store cols in
  print_flags "ListStore" l ;
  List.iter
    (fun (stock_id, str, vis) ->
      let row = l#append () in
      l#set ~row ~column:stock_id_col stock_id ;
      l#set ~row ~column:str_col str ;
      l#set ~row ~column:vis_col vis)
    data ;
  let s = GTree.model_sort l in
  print_flags "TreeModelSort" s ;
  let f = GTree.model_filter l in
  print_flags "TreeModelFilter" f ;
  f#set_visible_column vis_col ;
  let s' = GTree.model_sort f in
  List.iter
    (fun (s : #GTree.tree_sortable) ->
      s#connect#sort_column_changed
	(fun () ->
	  match s#get_sort_column_id with
	  | None -> Format.printf "no sort_column@."
	  | Some (id, `ASCENDING)  -> Format.printf "sort_column = %d, ascending@." id
	  | Some (id, `DESCENDING) -> Format.printf "sort_column = %d, descending@." id) ;
      s#set_sort_func 0 (sort_function str_col) )
    [ s ; s' ] ;
  (s, s', (stock_id_col, str_col))


let make_view (model, model_filtered, (stock_id_col, str_col)) packing =
  let view_col = GTree.view_column ~title:"Stock Icons" () in

  let str_renderer = GTree.cell_renderer_text [ `FAMILY "monospace" ; `XALIGN 1. ] in
  view_col#pack str_renderer ;
  view_col#add_attribute str_renderer "text" str_col ;

  let pb_renderer = GTree.cell_renderer_pixbuf [ `STOCK_SIZE `BUTTON ] in
  view_col#pack pb_renderer ;
  view_col#add_attribute pb_renderer "stock_id" stock_id_col ;

  view_col#set_sort_column_id 0 ;

  let b = GButton.check_button ~label:"_Filter data" ~use_mnemonic:true ~packing () in
  let v = GTree.view ~model ~width:200 ~packing () in
  v#append_column view_col ;
  b#connect#toggled
    (fun () -> 
      let current, new_model =
	if b#active
	then (model, model_filtered)
	else (model_filtered, model) in
      let (id, dir) =
	Gaux.default (-1, `ASCENDING) ~opt:current#get_sort_column_id in
      new_model#set_sort_column_id id dir ;

      v#set_model (Some new_model#coerce) ) ;
  v

let inspect_data_1 column (model : GTree.model) =
  Format.printf "@[<v 2>Traverse with iters:" ;
  begin match model#get_iter_first with
  | None -> Format.printf "@ empty model"
  | Some row ->
      let cont = ref true in
      while !cont do
	let data = model#get ~row ~column in
	Format.printf "@ %s" data ;
	cont := model#iter_next row
      done 
  end ;
  Format.printf "@]@."

let inspect_data_2 column (model : GTree.model) =
  Format.printf "@[<v 2>Traverse with #foreach:" ;
  model#foreach
    (fun _ row ->
      let data = model#get ~row ~column in
      Format.printf "@ %s" data ;
      false) ;
  Format.printf "@]@."

	
let main =
  let w = GWindow.window ~title:"GtkListStore test" () in
  w#connect#destroy GMain.quit ;

  let box = GPack.vbox ~packing:w#add () in

  let m = make_model data in
  let v = make_view m box#pack in
  
  begin
    let b = GButton.button ~label:"Dump data" ~packing:box#pack () in
    b#connect#clicked
      (fun () ->
	let (_, _, (_, col)) = m in
	let model = v#model in
	inspect_data_1 col model ;
	inspect_data_2 col model)
  end ;

  w#show () ;
  GMain.main ()

let changed_and_get_active (combo : #GEdit.combo_box) column cb =
  combo#connect#changed
    (fun () ->
      match combo#active_iter with
      | None -> ()
      | Some row -> 
	  let data = combo#model#get ~row ~column in
	  cb data)

let setup_combobox_demo_grid packing =
  let tmp = GBin.frame ~label:"GtkComboBox (grid mode)" ~packing () in
  let box = GPack.vbox ~border_width:5 ~packing:tmp#add () in

  let cols = new GTree.column_list in
  let column = cols#add Gobject.Data.string in
  let model = GTree.list_store cols in
  List.iter
    (fun c -> 
      let row = model#append () in 
      model#set ~row ~column c)
    [ "red"; "green" ; "blue" ; 
      "yellow" ; "black" ; "white" ;
      "gray" ; "snow" ; "magenta" ] ;
  
  let combo = GEdit.combo_box ~model ~wrap_width:3 ~packing:box#pack () in
  let cell = GTree.cell_renderer_pixbuf [ `WIDTH 16 ; `HEIGHT 16 ] in
  combo#pack ~expand:true cell ;
  combo#add_attribute cell "cell-background" column ;
  combo#set_active 1 ;
  changed_and_get_active combo column prerr_endline ;
  ()

let create_model () =
  let column_list = new GTree.column_list in
  let column      = column_list#add GtkStock.conv in
  let store = GTree.list_store column_list in
  List.iter
    (fun id ->
      let row = store#append () in
      store#set ~row ~column id)
    [ `DIALOG_WARNING ;
      `STOP ;
      `NEW ;
      `CLEAR ] ;
  (store, column)

let setup_combobox_demo packing =
  let tmp = GBin.frame ~label:"GtkComboBox" ~packing () in
  let box = GPack.vbox ~border_width:5 ~packing:tmp#add () in

  let model, column = create_model () in
  let combobox = GEdit.combo_box ~model ~packing:box#pack () in
    
  begin
    let renderer = GTree.cell_renderer_pixbuf [ `STOCK_SIZE `BUTTON ] in
    combobox#pack renderer ;
    combobox#add_attribute renderer "stock_id" column
  end ;
  begin
    let renderer = GTree.cell_renderer_text [ `XPAD 5 ] in
    combobox#pack renderer ;
    combobox#add_attribute renderer "text" column
  end ;
  combobox#set_active 1 ;
  changed_and_get_active combobox column 
    (fun id -> prerr_endline (GtkStock.convert_id id))

let setup_combobox_text packing =
  let tmp = GBin.frame ~label:"GtkComboBox (text-only)" ~packing () in
  let box = GPack.vbox ~border_width:5 ~packing:tmp#add () in
  let combo = GEdit.combo_box_text ~packing:box#pack () in
  List.iter combo#append_text
    [ "Jan" ; "Feb" ; "Mar" ; "Apr" ; "May" ; "Jun" ; 
      "Jul" ; "Aug" ; "Sep" ; "Oct" ; "Nov" ; "Dec" ] ;
  combo#set_active 0 ;
  changed_and_get_active combo combo#column prerr_endline ;
  ()

let setup_combobox_entry packing =
  let tmp = GBin.frame ~label:"GtkComboBoxEntry" ~packing () in
  let box = GPack.vbox ~border_width:5 ~packing:tmp#add () in
  let model, text_column = begin
    let cols = new GTree.column_list in
    let column = cols#add Gobject.Data.string in
    let store = GTree.list_store cols in
    List.iter (fun s -> store#set ~row:(store#append ()) ~column s)
      [ "Paris" ; "Grenoble" ; "Toulouse" ] ;
    store, column
  end in
  let combo = GEdit.combo_box_entry ~text_column ~model ~packing:box#pack () in
  combo#entry#connect#changed 
    (fun () -> match combo#entry#text with "" -> () | s -> prerr_endline s) ;
  ()
  

let main () =
  let window = GWindow.window ~border_width:5 () in
  window#connect#destroy GMain.quit ;
  
  let mainbox = GPack.vbox ~spacing:2 ~packing:window#add () in
  setup_combobox_demo mainbox#pack ;
  setup_combobox_demo_grid mainbox#pack ;
  setup_combobox_text mainbox#pack ;
  setup_combobox_entry mainbox#pack ;
  
  window#show () ;
  GMain.main ()

let _ = main ()

(* Local Variables: *)
(* compile-command: "ocamlc -I ../src -w s lablgtk.cma gtkInit.cmo combobox.ml" *)
(* End: *)

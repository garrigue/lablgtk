
let create_color_pixbuf color =
  let width = 16 in
  let height = 16 in
  let pb = GdkPixbuf.create ~width ~height () in
  let rowstride = GdkPixbuf.get_rowstride pb in
  let pixels = GdkPixbuf.get_pixels pb in
  let col = Gdk.Color.alloc (Gdk.Color.get_system_colormap ()) (`NAME color) in
  let red_c   = (Gdk.Color.red   col) lsr 8 in
  let green_c = (Gdk.Color.green col) lsr 8 in
  let blue_c  = (Gdk.Color.blue  col) lsr 8 in
  for l = 0 to height - 1 do
    for c = 0 to width - 1 do
      let i = l * rowstride + c * 3 in
      Gpointer.set_byte pixels i       red_c ;
      Gpointer.set_byte pixels (i + 1) green_c ;
      Gpointer.set_byte pixels (i + 2) blue_c ;
    done
  done ;
  pb

let create_combo_box_grid_demo packing =
  let cell = GTree.cell_renderer_pixbuf [] in
  let cols = new GTree.column_list in
  let pb_col = cols#add Gobject.Data.gobject in
  let model = GTree.list_store cols in
  
  let combo = GEdit.combo_box ~model ~wrap_width:3 ~packing () in
  combo#pack cell ~expand:true ;
  combo#add_attribute cell "pixbuf" pb_col ;
  List.iter
    (fun c -> 
      let row = model#append () in 
      model#set ~row ~column:pb_col 
	(create_color_pixbuf c))
    [ "red"; "green" ; "blue" ; 
      "yellow" ; "black" ; "white" ;
      "gray" ; "snow" ; "magenta" ] ;
  combo#set_active 0 ;
  combo

let setup_combobox_demo_grid packing =
  let tmp = GBin.frame ~label:"GtkComboBox (grid mode)" ~packing () in
  let boom = GPack.vbox ~border_width:5 ~packing:tmp#add () in
  let combo = create_combo_box_grid_demo boom#pack in
  ()

let create_model (w : #GObj.widget) =
  let column_list = new GTree.column_list in
  let pb_col  = column_list#add Gobject.Data.gobject in
  let txt_col = column_list#add Gobject.Data.string in

  let store = GTree.list_store column_list in
  List.iter
    (fun id ->
      let pb = w#misc#render_icon ~size:`BUTTON id in
      let row = store#append () in
      store#set ~row ~column:pb_col pb ;
      store#set ~row ~column:txt_col (GtkStock.convert_id id))
    [ `DIALOG_WARNING ;
      `STOP ;
      `NEW ;
      `CLEAR ] ;

  (store, pb_col, txt_col)

let changed_and_get_active (combo : #GEdit.combo_box) column cb =
  combo#connect#changed
    (fun () ->
      let row = combo#active_iter in
      let data = combo#model#get ~row ~column in
      cb data)

let setup_combobox_demo packing =
  let tmp = GBin.frame ~label:"GtkComboBox" ~packing () in
  let boom = GPack.vbox ~border_width:5 ~packing:tmp#add () in

  let model, pb_col, txt_col = create_model tmp in
  let combobox = GEdit.combo_box ~model ~packing:boom#pack () in
    
  begin
    let renderer = GTree.cell_renderer_pixbuf [] in
    combobox#pack renderer ;
    combobox#add_attribute renderer "pixbuf" pb_col 
  end ;
  begin
    let renderer = GTree.cell_renderer_text [] in
    combobox#pack renderer ;
    combobox#add_attribute renderer "text" txt_col 
  end ;
  combobox#set_active 1 ;
  changed_and_get_active combobox txt_col prerr_endline

let setup_combobox_text packing =
  let tmp = GBin.frame ~label:"GtkComboBox (text-only)" ~packing () in
  let boom = GPack.vbox ~border_width:5 ~packing:tmp#add () in
  let combo = GEdit.combo_box_text ~packing:boom#pack () in
  List.iter combo#append_text
    [ "Jan" ; "Feb" ; "Mar" ; "Apr" ; "May" ; "Jun" ; 
      "Jul" ; "Aug" ; "Sep" ; "Oct" ; "Nov" ; "Dec" ] ;
  combo#set_active 0 ;
  changed_and_get_active combo combo#column prerr_endline ;
  ()

let setup_combobox_entry packing =
  let tmp = GBin.frame ~label:"GtkComboBoxEntry" ~packing () in
  let boom = GPack.vbox ~border_width:5 ~packing:tmp#add () in
  let model, text_column = begin
    let cols = new GTree.column_list in
    let txt_col = cols#add Gobject.Data.string in
    GTree.list_store cols, txt_col 
  end in
  let combo = GEdit.combo_box_entry ~text_column ~model ~packing:boom#pack () in
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

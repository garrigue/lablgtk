
let all_files () =
  let f = GFile.filter ~name:"All" () in
  f#add_pattern "*" ;
  f

let image_filter () =
  let f = GFile.filter ~name:"Images" () in
  List.iter f#add_pattern
    [ "*.png" ; "*.jpg" ; "*.jpeg" ; "*.gif" ; "*.xpm" ] ;
  f

let text_filter () = 
  let f = GFile.filter ~name:"Text" () in
  f#add_pattern "*.txt" ;
  f

let ask_for_file parent =
  let dialog = GWindow.file_chooser_dialog 
      ~action:`OPEN 
      ~title:"Open File"
      ~parent () in
  dialog#add_button_stock `CANCEL `CANCEL ;
  dialog#add_button_stock `OPEN `OPEN ;
  dialog#add_filter (all_files ()) ;
  dialog#add_filter (image_filter ()) ;
  dialog#add_filter (text_filter ()) ;
  begin match dialog#run () with
  | `OPEN ->
      Printf.printf "filename: %s\n" dialog#filename ;
      flush stdout
  | `DELETE_EVENT | `CANCEL -> ()
  end ;
  dialog#destroy ()

let main () =
  let w = GWindow.window ~title:"FileChooser demo" () in
  w#connect#destroy GMain.quit ;

  let b = GButton.button ~stock:`OPEN ~packing:w#add () in
  b#connect#clicked
    (fun () -> ask_for_file w) ;

  w#show () ;
  GMain.main ()

let _ = main ()

(* Local Variables: *)
(* compile-command: "ocamlc -I ../src -w s lablgtk.cma gtkInit.cmo filechooser.ml" *)
(* End: *)

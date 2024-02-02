
let () =
  ignore @@ GMain.init ();
  let window = GWindow.window () in
  ignore @@ window#connect#destroy ~callback:GMain.quit;
  let obj = GlGtk.area ~packing:window#add () in
  obj#set_required_version 3 2;
  obj#set_has_auto_render true;
  ignore @@ obj#connect#realize ~callback:(fun () -> print_endline "creating opengl context");
  ignore @@ obj#connect#render ~callback:(fun () -> print_endline "rendering opengl context"; true);
  window#show ();
  GtkMain.Main.main ()

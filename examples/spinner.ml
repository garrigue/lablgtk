(**************************************************************************)
(*    Lablgtk - Examples                                                  *)
(*                                                                        *)
(*    This code is in the public domain.                                  *)
(*    You may freely copy parts of it in your application.                *)
(*                                                                        *)
(**************************************************************************)

let main () =
  GMain.init ();
  let window = GWindow.window ~show:false () in
  let vbox = GPack.vbox ~border_width:10 ~spacing:10 ~packing:window#add () in
  let spinner = GMisc.spinner ~width:100 ~height:100 ~active:true ~packing:vbox#add () in
  let button_start = GButton.button ~label:"Start" ~packing:vbox#add () in
  let button_stop = GButton.button ~label:"Stop" ~packing:vbox#add () in
  button_start#connect#clicked ~callback:spinner#start;
  button_stop#connect#clicked ~callback:spinner#stop;
  window#connect#destroy ~callback:GMain.quit;
  window#present ();
  GMain.main ()

let () = main ()

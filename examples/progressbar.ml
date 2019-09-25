(**************************************************************************)
(*    Lablgtk - Examples                                                  *)
(*                                                                        *)
(*    This code is in the public domain.                                  *)
(*    You may freely copy parts of it in your application.                *)
(*                                                                        *)
(**************************************************************************)

(* $Id$ *)

let main () =

  GMain.init ();
  let window = GWindow.window ~border_width: 10 () in
  window#connect#destroy ~callback:GMain.quit;

  let table = GPack.table ~rows:3 ~columns:2 ~packing: window#add () in
  
  GMisc.label ~text:"Progress Bar Example" ()
    ~packing:(table#attach ~left:0 ~right:2 ~top:0 ~expand:`X ~shrink:`BOTH);
  
  let pbar =
    GRange.progress_bar ~pulse_step:0.01 ()
      ~packing:(table#attach ~left:0 ~right:2 ~top:1
                  ~expand:`BOTH ~fill:`X ~shrink:`BOTH) in

  let ptimer = GMain.Timeout.add ~ms:50 ~callback:(fun () -> pbar#pulse(); true) in

  let button = GButton.button ~label:"Reset" ()
      ~packing:(table#attach ~left:0 ~top:2
                  ~expand:`NONE ~fill:`X ~shrink:`BOTH) in
  button#connect#clicked ~callback:(fun () -> pbar#set_fraction 0.);

  let button = GButton.button ~label:"Cancel" ()
      ~packing:(table#attach ~left:1 ~top:2
                  ~expand:`NONE ~fill:`X ~shrink:`BOTH) in
  button#connect#clicked ~callback:GMain.quit;

  window#show ();
  GMain.main ()

let _ = main ()

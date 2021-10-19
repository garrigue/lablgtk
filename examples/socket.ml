(**************************************************************************)
(*    Lablgtk - Examples                                                  *)
(*                                                                        *)
(*    This code is in the public domain.                                  *)
(*    You may freely copy parts of it in your application.                *)
(*                                                                        *)
(**************************************************************************)

(* $Id$ *)

let main () =
  let _locale = GMain.init () in
  let w = GWindow.window ~title:"Socket example" () in
  let _sid = w#connect#destroy ~callback:GMain.quit in
  let vbox = GPack.vbox ~packing:w#add () in
  let label = GMisc.label ~packing:vbox#pack () in
  w#show ();
  let socket = GWindow.socket ~packing:vbox#add ~height:40 () in
  label#set_text ("XID to plug into this socket: 0x" ^
                  Printf.sprintf "%lX" socket#xwindow);
  GMain.main ()

let _ = main ()

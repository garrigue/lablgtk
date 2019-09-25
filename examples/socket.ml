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
  let w = GWindow.window ~title:"Socket example" () in
  w#connect#destroy ~callback:GMain.quit;
  let vbox = GPack.vbox ~packing:w#add () in
  let label = GMisc.label ~packing:vbox#pack () in
  w#show ();
  let socket = GWindow.socket ~packing:vbox#add ~height:40 () in
  label#set_text ("XID to plug into this socket: 0x" ^ 
                  Int32.format "%x" socket#xwindow);
  GMain.main ()

let _ = main ()

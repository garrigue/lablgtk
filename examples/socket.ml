(* $Id$ *)

open GMain

let main () =
  let w = GWindow.window ~title:"Socket example" () in
  w#connect#destroy ~callback:Main.quit;
  let vbox = GPack.vbox ~packing:w#add () in
  let label = GMisc.label ~packing:(vbox#pack ~expand:false) () in
  let socket = GBin.socket ~packing:vbox#add ~height:40 () in
  label#set_text ("XID to plug into this socket: 0x" ^ 
                  Int32.format "%x" socket#xwindow);
  w#show ();
  Main.main ()

let _ = main ()

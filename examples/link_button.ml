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

  let window = GWindow.window ~title: "Link button" ~border_width: 0 () in

  let box = GPack.vbox ~packing: window#add () in

  let button = GButton.link_button 
    "http://HELLO.ORG" 
    ~label:"BYE" ~packing:box#add () 
  in
  button#set_uri "GHHHHH";
  Format.printf "Got:%a@." GUtil.print_widget button;
  button#connect#activate_link
    (fun () -> Format.printf "Got url '%s'@." button#uri;   button#set_uri "AGAIN");
  window#connect#destroy GMain.quit;
  window#show ();
  GMain.main ()

let _ = main ()

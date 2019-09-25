(**************************************************************************)
(*    Lablgtk - Examples                                                  *)
(*                                                                        *)
(*    This code is in the public domain.                                  *)
(*    You may freely copy parts of it in your application.                *)
(*                                                                        *)
(**************************************************************************)

(* $Id: $ *)
let main () =
  GMain.init ();

  let assistant = GAssistant.assistant () in

  let box = GPack.vbox () in
  ignore (assistant#append_page box#as_widget);
  assistant#set_page_complete box#as_widget true;
  prerr_endline "Complete";
  assistant#set_page_type box#as_widget `SUMMARY;
  let button = GButton.link_button 
    "http://HELLO.ORG" 
    ~label:"BYE" ~packing:box#add () 
  in
  button#set_uri "GHHHHH";
  Format.printf "Got:%a@." GUtil.print_widget button;
  button#connect#activate_link
    (fun () -> Format.printf "Got url '%s'@." button#uri;   button#set_uri "AGAIN");
  assistant#connect#close GMain.quit;
  assistant#show ();
  GMain.main ()

let _ = main ()


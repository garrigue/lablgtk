(* $Id$ *)

open GMain

let main () =
  let window = GWindow.window ~title:"Notebook" ~border_width:10 () in
  window#connect#destroy ~callback:Main.quit;
  let notebook = GPack.notebook ~packing:window#add () in
  let button = GButton.button ~label:"Page 1" ~packing:notebook#append_page () in
  button#connect#clicked ~callback:
    (fun () -> prerr_endline "Hello again - cool button 1 was pressed");

  let button = GButton.button ~label:"Page 2" ~packing:notebook#append_page () in
  button#connect#clicked ~callback:
    (fun () -> prerr_endline "Hello again - cool button 2 was pressed");
  notebook#connect#switch_page 
    ~callback:(fun i -> prerr_endline ("Page switch to " ^ string_of_int i));
  button#connect#clicked ~callback:
    (fun () -> prerr_endline "Coucou");
  window#show ();
  Main.main ()

let _ = main ()

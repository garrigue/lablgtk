(**************************************************************************)
(*    Lablgtk - Examples                                                  *)
(*                                                                        *)
(*    This code is in the public domain.                                  *)
(*    You may freely copy parts of it in your application.                *)
(*                                                                        *)
(**************************************************************************)

let setup_expander packing =
  let e = GBin.expander ~packing () in
  let pixbuf = e#misc#render_icon ~size:`DIALOG `DIALOG_INFO in
  let icon = GMisc.image ~pixbuf ~packing:e#add () in
  e#set_label "Show image" ;
  e#connect#after#activate (fun () ->
    e#set_label 
      (if e#expanded then "Hide image" else "Show image"))

let main () = 
  GMain.init ();
  let w = GWindow.window ~title:"GtkExpander demo" () in
  w#connect#destroy GMain.quit ;

  setup_expander w#add ;

  w#show () ;
  GMain.main ()

let _ = main ()

(* Local Variables: *)
(* compile-command: "ocamlc -I ../src -w s lablgtk.cma expander.ml" *)
(* End: *)


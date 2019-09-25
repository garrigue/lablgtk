(**************************************************************************)
(*    Lablgtk - Examples                                                  *)
(*                                                                        *)
(*    This code is in the public domain.                                  *)
(*    You may freely copy parts of it in your application.                *)
(*                                                                        *)
(**************************************************************************)

(* $Id$ *)

let xpm_label_box ~(window : #GContainer.container)
    ~file ~text ?packing ?(show=true) () =
  if not (Sys.file_exists file) then failwith (file ^ " does not exist");
  let box = GPack.hbox ~border_width: 2 ?packing ~show:false () in
  let image = GMisc.image ~file ~packing:(box#pack ~padding:3) () in
  GMisc.label ~text ~packing:(box#pack ~padding:3) ();
  if show then box#misc#show ();
  new GObj.widget_full box#as_widget

let main () =
  GMain.init ();
  let window = GWindow.window ~title:"Pixmap'd Buttons!" ~border_width:10 () in
  window#connect#destroy ~callback:GMain.quit;
  let hbox = GPack.hbox ~packing:window#add () in
  let button = GButton.button ~packing:(hbox#pack ~padding:5) () in
  button#connect#clicked ~callback:
    (fun () -> prerr_endline "Hello again - cool button was pressed");
  xpm_label_box ~window ~file:"test.xpm" ~text:"cool button"
    ~packing:button#add ();
  let button = GButton.button ~use_mnemonic:true ~label:"_Coucou" ~packing:(hbox#pack ~padding:5) () in
  button#connect#clicked ~callback:
    (fun () -> prerr_endline "Coucou");
  let button = GButton.button ~stock:`HOME ~packing:(hbox#pack ~padding:5) () in
  button#connect#clicked ~callback:
    (fun () -> prerr_endline "Stock buttons look nice");
  window#show ();
  GMain.main ()

let _ = main ()

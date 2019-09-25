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
  let window = GWindow.dialog ~title: "dialog"
      ~border_width: 10 ~width: 300 ~height: 300 () in
  window#connect#destroy ~callback:GMain.quit;

  let scrolled_window = GBin.scrolled_window
      ~border_width: 10 ~hpolicy: `AUTOMATIC ~packing: window#vbox#add ()
  in

  let table = GPack.table ~rows:10 ~columns:10
      ~row_spacings: 10 ~col_spacings: 10
      ~packing: scrolled_window#add_with_viewport ()
  in

  for i = 0 to 9 do
    for j = 0 to 9 do
      let label = Printf.sprintf "button (%d,%d)\n" i j in
      GButton.toggle_button ~label
        ~packing:(table#attach ~left: i ~top: j ~expand: `BOTH) ()
    done
  done;

  let button =
    GButton.button ~label: "close" ~packing: window#action_area#add () in
  button#connect#clicked ~callback: GMain.quit;
  button#grab_default ();
  window#show ();
  GMain.main ()

let _ = main ()

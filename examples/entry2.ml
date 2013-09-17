(**************************************************************************)
(*    Lablgtk - Examples                                                  *)
(*                                                                        *)
(*    There is no specific licensing policy, but you may freely           *)
(*    take inspiration from the code, and copy parts of it in your        *)
(*    application.                                                        *)
(*                                                                        *)
(**************************************************************************)

let w = GWindow.window ~show:true ()
let e = GEdit.entry ~packing:w#add ()

let () =
  e#connect#after#insert_text
    (fun _ ~pos ->
      if e#text_length > 5 then e#set_secondary_icon_stock `DIALOG_WARNING
      else e#set_secondary_icon_name "");
  w#event#connect#delete (fun _ -> GMain.quit (); true);
  GMain.main ()

open Gtk
open Tags

let main () =
  let window = Dialog.create () in
  Signal.connect window sig:Signal.destroy cb:Main.quit;
  Window.set_title window "dialog";
  Container.border_width window 10;
  Widget.set_usize window width: 300 height: 300;

  let scrolled_window = ScrolledWindow.create () in
  Container.border_width scrolled_window 10;
  ScrolledWindow.set_policy scrolled_window horiz: `AUTOMATIC vert: `ALWAYS;
  Box.pack_start (Dialog.vbox window) scrolled_window expand: true
    fill: true padding: 0;
  Widget.show scrolled_window;

  let table = Table.create 10 10 in
  (* Table.set_row_spacing table 10; *)
  (* Table.set_col_spacing table 10; *)

  Container.add scrolled_window table;
  Widget.show table;

  for i = 0 to 9 do
    for j = 0 to 9 do
      let s = Printf.sprintf "button (%d,%d)\n" i j in
      let button = ToggleButton.create `toggle label: s in
      Table.attach table button left: i top: j;
      Widget.show button
    done
  done;

  let button = Button.create_with_label "close" in
  Signal.connect button sig:Signal.clicked cb:Main.quit;
  (* GTK_WIDGET_SET_FLAGS(button, GTK_CAN_DEFAULT) is as follows *)
  Widget.set_can_default button true;
  Box.pack_start (Dialog.action_area window) button expand: true
    fill: true padding: 0;
  Widget.grab_default button;
  Widget.show button;
  Widget.show window;
  Main.main ()

let _ = main ()
    

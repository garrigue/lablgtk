(* $Id$ *)

open GtkObj

let main () =
  let window = new_dialog ()
      title: "dialog" border_width: 10 width: 300 height: 300 in
  window#connect#destroy callback:Main.quit;

  let scrolled_window = new_scrolled_window ()
      border_width: 10 hscrollbar_policy: `AUTOMATIC packing: window#vbox#pack
  in

  let table = new_table rows:10 columns:10
      row_spacings: 10 col_spacings: 10
      packing: scrolled_window#add_with_viewport
  in

  for i = 0 to 9 do
    for j = 0 to 9 do
      let label = Printf.sprintf "button (%d,%d)\n" i j in
      new_toggle_button :label packing:(table#attach left: i top: j)
    done
  done;

  let button = new_button label: "close" packing: window#action_area#pack in
  button#connect#clicked callback: Main.quit;
  button#grab_default ();
  window#show_all ();
  Main.main ()

let _ = main ()
    

(* $Id$ *)

open GtkObj

let main () =

  let window = new_window `TOPLEVEL
      title: "radio buttons" border_width: 0 in
  window#connect#destroy callback:Main.quit;

  let box1 = new_box `VERTICAL packing: window#add in

  let box2 = new_box `VERTICAL
      spacing:10 border_width: 10 packing: box1#pack in

  let button1 = new_radio_button
      label:"button1" packing: box2#pack in
  button1#connect#clicked callback:(fun () -> prerr_endline "button1");

  let button2 = new_radio_button
      group:button1#group label:"button2" state:true packing: box2#pack in
  button2#connect#clicked callback:(fun () -> prerr_endline "button2");

  let button3 = new_radio_button
      group:button1#group label:"button3" packing: box2#pack in
  button3#connect#clicked callback:(fun () -> prerr_endline "button3");

  let separator = new_separator `HORIZONTAL
      packing:(box1#pack expand:false) in
  
  let box3 = new_box `VERTICAL
      spacing: 10 border_width: 10 packing:(box1#pack expand:false) in

  let button = new_button label: "close" packing: box3#pack in
  button#connect#clicked callback:Main.quit;
  button#grab_default ();

  window#show_all ();

  Main.main ()

let _ = main ()

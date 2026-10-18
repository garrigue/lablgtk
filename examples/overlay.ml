(**************************************************************************)
(*    Lablgtk - Examples                                                  *)
(*                                                                        *)
(*    This code is in the public domain.                                  *)
(*    You may freely copy parts of it in your application.                *)
(*                                                                        *)
(**************************************************************************)

let lorem = {|Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin sagittis auctor urna in vehicula. Morbi a aliquam sem, sed dictum diam. Morbi viverra vehicula risus quis vestibulum. Aliquam rutrum nisl quis pharetra iaculis. Cras sapien erat, congue a porta at, fringilla dignissim enim. Fusce enim quam, rutrum ac velit eu, pretium fringilla augue. Quisque sapien felis, aliquet facilisis justo vitae, hendrerit dictum elit. Praesent nulla quam, molestie semper dolor vel, auctor tincidunt arcu. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Morbi in nibh id nibh tempus egestas eget eu lorem. Suspendisse potenti. Cras elementum dui.|}

let main () =
  GMain.init ();
  let window = GWindow.window ~show:true () in
  let vbox = GPack.vbox ~border_width:20 ~spacing:20 ~packing:window#add () in
  let overlay = GBin.overlay ~packing:vbox#add () in
  let buffer = GText.buffer ~text:lorem () in
  let sw = GBin.scrolled_window ~width:500 ~height:300 ~hpolicy:`AUTOMATIC ~vpolicy:`AUTOMATIC ~packing:overlay#add () in
  let view = GText.view ~buffer ~packing:sw#add () in
  view#set_wrap_mode `WORD;
  view#misc#grab_focus ();

  let child_1 = GButton.button ~label:"This is an overlay" () in
  let child_2 = GButton.button ~label:"This another overlay" () in
  child_1#misc#set_size_request ~width:200 ~height:100 ();
  child_1#set_halign `START;
  child_1#set_valign `START;
  child_1#set_margin_left 20;
  child_1#set_margin_top 20;
  child_1#misc#modify_bg [`NORMAL, `NAME "yellow"];
  child_1#misc#modify_fg [`NORMAL, `NAME "black"];
  child_2#misc#set_size_request ~width:200 ~height:100 ();
  child_2#set_halign `START;
  child_2#set_valign `START;
  child_2#set_margin_left 80;
  child_2#set_margin_top 80;
  child_2#misc#modify_bg [`NORMAL, `NAME "lightblue"];
  child_2#misc#modify_fg [`NORMAL, `NAME "black"];

  overlay#add_overlay child_1#coerce;
  overlay#add_overlay child_2#coerce;
  (* overlay#set_overlay_pass_through child_1#coerce true;
  overlay#set_overlay_pass_through child_2#coerce true; *)

  child_1#connect#clicked ~callback:(fun () ->
    overlay#reorder_overlay child_2#coerce 0;
    child_2#set_margin_left (child_2#margin_left + 20));
  child_2#connect#clicked ~callback:(fun () ->
    overlay#reorder_overlay child_1#coerce 0;
    child_2#set_margin_left (child_2#margin_left - 20));

  window#connect#destroy ~callback:GMain.quit;
  window#present ();
  GMain.main ()

let () = main ()

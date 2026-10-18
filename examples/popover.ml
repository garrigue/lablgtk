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
  let buffer = GText.buffer ~text:lorem () in
  let sw = GBin.scrolled_window ~width:500 ~height:300 ~hpolicy:`AUTOMATIC ~vpolicy:`AUTOMATIC ~packing:vbox#add () in
  let view = GText.view ~buffer ~packing:sw#add () in
  view#set_wrap_mode `WORD;
  buffer#place_cursor ~where:(buffer#get_iter (`OFFSET 200));
  let hbox = GPack.hbox ~border_width:10 ~spacing:10 ~packing:vbox#add () in
  let check_transitions = GButton.check_button ~label:"Enable transitions" ~packing:hbox#add () in
  let check_modal = GButton.check_button ~label:"Modal popover" ~packing:hbox#add () in
  let button_popup = GButton.button ~label:"Show popover pointing to cursor" ~packing:vbox#add () in
  let button_popdown = GButton.button ~label:"Pop down popover" ~packing:vbox#add () in
  let popover = GBin.popover ~relative_to:view#coerce ~position:`BOTTOM () in
  popover#set_modal true;
  popover#set_transitions_enabled check_transitions#active;
  popover#set_modal check_modal#active;
  (* popover#misc#set_size_request ~width:400  (); *)
  let content = GMisc.label ~xpad:10 ~ypad:10 ~text:"This is a popover" ~packing:popover#add () in
  (* let content = GEdit.entry ~text:"This is an editable entry inside the popover" ~packing:popover#add () in *)
  popover#misc#modify_bg [`NORMAL, `NAME "yellow"];
  popover#misc#modify_fg [`NORMAL, `NAME "black"];
  content#misc#modify_fg [`NORMAL, `NAME "black"];
  button_popup#connect#clicked ~callback:begin fun () -> 
    let iter = buffer#get_iter `INSERT in
    let loc = view#get_iter_location iter in
    let x, y = view#buffer_to_window_coords ~tag:`TEXT ~x:(Gdk.Rectangle.x loc) ~y:(Gdk.Rectangle.y loc) in
    let width = Gdk.Rectangle.width loc in
    let height = Gdk.Rectangle.height loc in
    let rect = Gdk.Rectangle.create ~x ~y ~width ~height in
    popover#set_pointing_to rect;
    popover#pointing_to |> (function
      | Some r -> Printf.printf "Popover pointing to: x=%d, y=%d, w=%d, h=%d\n%!" 
        (Gdk.Rectangle.x r) (Gdk.Rectangle.y r) (Gdk.Rectangle.width r) (Gdk.Rectangle.height r)
      | None -> Printf.printf "Popover pointing to: None\n%!");
    popover#popup();
  end;
  button_popdown#connect#clicked ~callback:popover#popdown;
  popover#connect#closed ~callback:begin fun () ->
    Printf.printf "Popover closed\n%!";
  end;
  popover#connect#notify_transitions_enabled ~callback:begin fun pos ->
    Printf.printf "Popover transitions enabled: %b\n%!" pos;
  end;
  check_transitions#connect#toggled ~callback:begin fun () ->
    popover#set_transitions_enabled check_transitions#active;
  end;
  check_modal#connect#toggled ~callback:begin fun () ->
    popover#set_modal check_modal#active;
  end;
  view#misc#grab_focus ();
  window#connect#destroy ~callback:GMain.quit;
  GMain.main ()

let () = main ()

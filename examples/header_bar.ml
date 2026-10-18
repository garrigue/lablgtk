(**************************************************************************)
(*    Lablgtk - Examples                                                  *)
(*                                                                        *)
(*    This code is in the public domain.                                  *)
(*    You may freely copy parts of it in your application.                *)
(*                                                                        *)
(**************************************************************************)

let main () =
  GMain.init ();
  let window = GWindow.window ~width:800 ~decorated:true ~show:false () in
  let vbox = GPack.vbox ~border_width:10 ~spacing:10 ~packing:window#add () in

  let header = GPack.header_bar ~show_close_button:true ~title:"Header Bar" () in
  let button_start_1 = GButton.button ~label:"B1" ~packing:header#pack_start () in
  let button_start_2 = GButton.button ~label:"B2" ~packing:header#pack_start () in
  let button_end_1 = GButton.button ~label:"B3" ~packing:header#pack_end () in
  let button_end_2 = GButton.button ~label:"B4" ~packing:header#pack_end () in

  let custom_title = GPack.hbox ~spacing:10 () in
  let button_1 = GButton.button ~label:"Button 1" ~packing:custom_title#add () in
  let button_2 = GButton.button ~label:"Button 2" ~packing:custom_title#add () in
  let header_2 = GPack.header_bar ~custom_title:custom_title#coerce ~show_close_button:true ~show:false () in

  let entry_deco_layout = GEdit.entry ~placeholder_text:"decoration_layout" ~text:"minimize:maximize,close" ~packing:(vbox#pack ~expand:false) () in
  entry_deco_layout#misc#set_tooltip_text "Set the decoration layout of the header bar. Press Enter to apply.";
  entry_deco_layout#connect#activate ~callback:begin fun () ->
    let layout = entry_deco_layout#text in
    header#set_decoration_layout layout;
    header_2#set_decoration_layout layout
  end;

  let check_has_subtitle = GButton.check_button ~label:"Subtitle" ~active:false ~packing:(vbox#pack ~expand:false) () in
  let check_show_close_button = GButton.check_button ~label:"Show close button" ~active:true ~packing:(vbox#pack ~expand:false) () in
  let hbox = GPack.hbox ~border_width:0 ~spacing:10 ~packing:vbox#add () in
  let check_show = GButton.check_button ~label:"Show Header Bar 1" ~active:true ~packing:hbox#add () in
  let check_show_2 = GButton.check_button ~label:"Show Header Bar 2" ~active:false ~packing:hbox#add () in
  let check_hide_titlebar = GButton.check_button ~label:"hide-titlebar-when-maximized does not work with header bar" ~active:false ~packing:(vbox#pack ~expand:false) () in
  let button_switch_headers = GButton.button ~label:"Switch header bars" ~packing:(vbox#pack ~expand:false) () in
  let button_dialog = GButton.button ~label:"Show dialog with header bar" ~packing:(vbox#pack ~expand:false) () in
  button_dialog#connect#clicked ~callback:begin fun () ->
    let dialog = GWindow.dialog ~title:"Dialog with header bar" ~width:400 ~modal:true ~show:true ~parent:window () in
    let header = GPack.header_bar ~show_close_button:true ~title:"Dialog box with header bar" ~subtitle:"This is a subtitle" () in
    dialog#set_titlebar header#coerce;
    let vbox = dialog#vbox in
    let label = GMisc.label ~text:"This is a dialog with a header bar" ~packing:vbox#add () in
    let button = GButton.button ~label:"Close" ~packing:vbox#add () in
    button#connect#clicked ~callback:(fun () -> dialog#destroy ());
    dialog#present ();
  end;
  button_switch_headers#connect#clicked ~callback:begin fun () ->
    let current_header = window#titlebar in
    if current_header#misc#get_oid = header#misc#get_oid then begin
      check_show#misc#set_sensitive false;
      check_show_2#misc#set_sensitive true;
      window#set_titlebar header_2#coerce
    end else begin
      check_show#misc#set_sensitive true;
      check_show_2#misc#set_sensitive false;
      window#set_titlebar header#coerce
    end
  end;
  check_show#misc#set_sensitive true;
  check_show_2#misc#set_sensitive false;
  check_show_close_button#connect#toggled ~callback:(fun () ->
    header#set_show_close_button check_show_close_button#active;
    header_2#set_show_close_button check_show_close_button#active);

  check_has_subtitle#connect#toggled ~callback:begin fun () ->
    header#set_has_subtitle check_has_subtitle#active;
    header_2#set_has_subtitle check_has_subtitle#active;
    header#set_subtitle (if header#has_subtitle then "This is a subtitle" else "");
  end;
  check_show#connect#toggled ~callback:begin fun () ->
    if check_show#active then header#misc#show()
    else header#misc#hide();
  end;

  check_show_2#connect#toggled ~callback:begin fun () ->
    if check_show_2#active then header_2#misc#show()
    else header_2#misc#hide();
  end;
  window#misc#set_property "hide-titlebar-when-maximized" (`BOOL check_hide_titlebar#active);
  check_hide_titlebar#connect#toggled ~callback:(fun () ->
    window#misc#set_property "hide-titlebar-when-maximized" (`BOOL check_hide_titlebar#active));
  check_hide_titlebar#misc#set_sensitive false; 

  window#set_titlebar header#coerce;
  window#connect#destroy ~callback:GMain.quit;
  window#present ();
  GMain.main ()

let () = main ()

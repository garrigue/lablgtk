(* $Id$ *)

open GMain

class editor ?:packing ?:show =
  let text = new GEdit.text editable:true ?:packing ?:show in
object (self)
  inherit GObj.widget text#as_widget

  val mutable filename = None

  method text = text

  method load_file name =
    try
      let ic = open_in file:name in
      filename <- Some name;
      text#freeze ();
      text#delete_text start:0 end:text#length;
      let buffer = String.create len:1024 and len = ref 0 in
      while len := input ic :buffer pos:0 len:1024; !len > 0 do
	if !len = 1024 then text#insert buffer
	else text#insert (String.sub buffer pos:0 len:!len)
      done;
      text#set_point 0;
      text#thaw ();
      close_in ic
    with _ -> ()

  method open_file () = File.dialog title:"Open" callback:self#load_file

  method save_file () =
    File.dialog title:"Save" ?:filename callback:
      begin fun name ->
	try
	  if Sys.file_exists name then Sys.rename old:name new:(name ^ "~");
	  let oc = open_out file:name in
	  output_string (text#get_chars start:0 end:text#length) to:oc;
	  close_out oc
	with _ -> prerr_endline "Save failed"
      end
end

open GdkKeysyms

class editor_window ?:show [< false >] =
  let window = new GWindow.window width:500 height:300 title:"editor" in
  let vbox = new GPack.box `VERTICAL packing:window#add in

  let menubar = new GMenu.menu_bar packing:(vbox#pack expand:false) in
  let factory = new GMenu.factory menubar in
  let accel_group = factory#accel_group
  and file_menu = factory#add_submenu label:"File"
  and edit_menu = factory#add_submenu label:"Edit"
  and comp_menu = factory#add_submenu label:"Compiler" in

  let hbox = new GPack.box `HORIZONTAL packing:vbox#add in
  let scrollbar =
    new GRange.scrollbar `VERTICAL packing:(hbox#pack from:`END expand:false)
  and editor = new editor packing:hbox#add in
object (self)
  inherit GObj.widget window#as_widget

  method window = window
  method editor = editor
  method show = window#show

  initializer
    window#connect#destroy callback:Main.quit;
    let factory = new GMenu.factory file_menu :accel_group in
    factory#add_item label:"Open..." key:_O callback:editor#open_file;
    factory#add_item label:"Save..." key:_S callback:editor#save_file;
    factory#add_item label:"Shell"
      callback:(fun () -> Shell.f prog:"olabl" title:"Objective Label Shell");
    factory#add_separator ();
    factory#add_item label:"Quit" key:_Q callback:window#destroy;
    let factory = new GMenu.factory edit_menu :accel_group in
    factory#add_item label:"Copy" key:_C callback:editor#text#copy_clipboard;
    factory#add_item label:"Cut" key:_X callback:editor#text#cut_clipboard;
    factory#add_item label:"Paste" key:_V callback:editor#text#paste_clipboard;
    factory#add_separator ();
    factory#add_check_item label:"Word wrap" active:false
      callback:editor#text#set_word_wrap;
    factory#add_check_item label:"Read only" active:false
      callback:(fun b -> editor#text#set_editable (not b));
    let factory = new GMenu.factory comp_menu :accel_group in
    factory#add_item label:"Lex" key:_L
      callback:(fun () -> Lexical.tag editor#text);
    window#add_accel_group accel_group;
    editor#text#set_vadjustment scrollbar#adjustment;
    if show then self#show ()
end

let _ =
  new editor_window show:true;
  Main.main ()

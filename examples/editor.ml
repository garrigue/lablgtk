(* $Id$ *)

open GMain

let file_dialog :title :callback ?:filename =
  let sel =
    new GWindow.file_selection :title modal:true ?:filename in
  sel#cancel_button#connect#clicked callback:sel#destroy;
  sel#ok_button#connect#clicked callback:
    begin fun () ->
      let name = sel#get_filename in
      sel#destroy ();
      callback name
    end;
  sel#show ()

class editor () = object (self)
  val text = new GEdit.text editable:true
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

  method open_file () = file_dialog title:"Open" callback:self#load_file

  method save_dialog () =
    file_dialog title:"Save" ?:filename
      callback:(fun file -> self#output :file)

  method save_file () =
    match filename with
      Some file -> self#output :file
    | None -> self#save_dialog ()

  method output :file =
    try
      if Sys.file_exists file then Sys.rename old:file new:(file ^ "~");
      let oc = open_out :file in
      output_string (text#get_chars start:0 end:text#length) to:oc;
      close_out oc;
      filename <- Some file
    with _ -> prerr_endline "Save failed"
end

let editor = new editor ()

let window = new GWindow.window width:500 height:300 title:"editor"
let vbox = new GPack.box `VERTICAL packing:window#add

let menubar = new GMenu.menu_bar packing:(vbox#pack expand:false)
let factory = new GMenu.factory menubar
let accel_group = factory#accel_group
let file_menu = factory#add_submenu label:"File"
let edit_menu = factory#add_submenu label:"Edit"

let hbox = new GPack.box `HORIZONTAL packing:vbox#add
let scrollbar =
  new GRange.scrollbar `VERTICAL packing:(hbox#pack from:`END expand:false)

open GdkKeysyms

let _ =
  window#connect#destroy callback:Main.quit;
  let factory = new GMenu.factory file_menu :accel_group in
  factory#add_item label:"Open..." key:_O callback:editor#open_file;
  factory#add_item label:"Save" key:_S callback:editor#save_file;
  factory#add_item label:"Save as..." callback:editor#save_dialog;
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
  window#add_accel_group accel_group;
  hbox#add editor#text;
  editor#text#connect#event#button_press
    callback:(fun ev ->
      let button = GdkEvent.Button.button ev in
      if button = 3 then begin
	file_menu#popup :button time:(GdkEvent.Button.time ev); true
      end else false);
  editor#text#set_vadjustment scrollbar#adjustment;
  window#show ();
  Main.main ()

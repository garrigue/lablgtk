(* $Id$ *)

open Gtk
open GtkObj

let window = new_window `TOPLEVEL width:500 height:300

let vbox = new_box `VERTICAL packing:window#add

let menubar = new_menu_bar packing:(vbox#pack expand:false)

let file_item = new_menu_item label:"File" packing:menubar#append

let file_menu = new_menu packing:file_item#set_submenu

let open_item = new_menu_item label:"Open..." packing:file_menu#append

let save_item = new_menu_item label:"Save..." packing:file_menu#append

let quit_item = new_menu_item label:"Quit" packing:file_menu#append

let file_dialog :title :callback ?:filename =
  let sel = new_file_selection :title fileop_buttons:false ?:filename in
  sel#cancel_button#connect#clicked callback:sel#destroy;
  sel#ok_button#connect#clicked callback:
    begin fun () ->
      let name = sel#get_filename in
      sel#destroy ();
      callback name
    end;
  sel#show ();
  Grab.add sel#frame

class editor () = object (self)
  val text = new_text editable:true
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

  method save_file () =
    file_dialog title:"Save" ?:filename callback:
      begin fun name ->
	try
	  if Sys.file_exists name then Sys.rename old:name new:(name ^ "~");
	  let oc = open_out file:name in
	  output_string (text#get_chars start:0 end:text#length) to:oc;
	  close_out oc
	with _ -> prerr_endline "Save failed"
      end
end

let editor = new editor ()

let table = AcceleratorTable.create ()

let _ =
  window#connect#destroy callback:Main.quit;
  open_item#connect#activate callback:editor#open_file;
  save_item#connect#activate callback:editor#save_file;
  quit_item#connect#activate callback:window#destroy;
  List.iter [ open_item, 'O'; save_item, 'S'; quit_item, 'Q' ] fun:
    (fun ((item : menu_item), key) ->
      Widget.install_accelerator (MenuItem.cast item#frame) table
	sig:MenuItem.Signals.activate :key mod:[`CONTROL]);
  window#add_accelerator_table table;
  vbox#add editor#text;
  editor#text#connect#event#button_press
    callback:(fun ev ->
      let button = Gdk.Event.Button.button ev in
      if button = 3 then begin
	file_menu#popup :button time:(Gdk.Event.Button.time ev); true
      end else false);
  window#show_all ();
  Main.main ()

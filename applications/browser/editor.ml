(* $Id$ *)

open GMain

class editor ?packing ?show () =
  let text = GEdit.text ~editable:true ?packing ?show () in
object (self)
  inherit GObj.widget text#as_widget

  val mutable filename = None

  method text = text

  method load_file name =
    try
      let ic = open_in name in
      filename <- Some name;
      text#freeze ();
      text#delete_text ~start:0 ~stop:text#length;
      let buf = String.create 1024 and len = ref 0 in
      while len := input ic ~buf ~pos:0 ~len:1024; !len > 0 do
	if !len = 1024 then text#insert buf
	else text#insert (String.sub buf ~pos:0 ~len:!len)
      done;
      text#set_point 0;
      text#thaw ();
      close_in ic
    with _ -> ()

  method open_file () = File.dialog ~title:"Open" ~callback:self#load_file ()

  method save_file () =
    File.dialog ~title:"Save" ?filename () ~callback:
      begin fun name ->
	try
	  if Sys.file_exists name then Sys.rename ~src:name ~dst:(name ^ "~");
	  let oc = open_out name in
	  output_string oc (text#get_chars ~start:0 ~stop:text#length);
	  close_out oc
	with _ -> prerr_endline "Save failed"
      end
end

open GdkKeysyms

class editor_window ?(show=false) () =
  let window = GWindow.window ~width:500 ~height:300
      ~title:"Program Editor" () in
  let vbox = GPack.vbox ~packing:window#add () in

  let menubar = GMenu.menu_bar ~packing:vbox#pack () in
  let factory = new GMenu.factory menubar in
  let accel_group = factory#accel_group
  and file_menu = factory#add_submenu "File"
  and edit_menu = factory#add_submenu "Edit"
  and comp_menu = factory#add_submenu "Compiler" in

  let hbox = GPack.hbox ~packing:vbox#add () in
  let scrollbar =
    GRange.scrollbar `VERTICAL ~packing:(hbox#pack ~from:`END) ()
  and editor = new editor ~packing:hbox#add () in
object (self)
  inherit GObj.widget window#as_widget

  method window = window
  method editor = editor
  method show = window#show

  initializer
    window#connect#destroy ~callback:Main.quit;
    let factory = new GMenu.factory file_menu ~accel_group in
    factory#add_item "Open..." ~key:_O ~callback:editor#open_file;
    factory#add_item "Save..." ~key:_S ~callback:editor#save_file;
    factory#add_item "Shell"
      ~callback:(fun () -> Shell.f ~prog:"ocaml" ~title:"Objective Caml Shell");
    factory#add_separator ();
    factory#add_item "Quit" ~key:_Q ~callback:window#destroy;
    let factory = new GMenu.factory edit_menu ~accel_group in
    factory#add_item "Copy" ~key:_C ~callback:editor#text#copy_clipboard;
    factory#add_item "Cut" ~key:_X ~callback:editor#text#cut_clipboard;
    factory#add_item "Paste" ~key:_V ~callback:editor#text#paste_clipboard;
    factory#add_separator ();
    factory#add_check_item "Word wrap" ~active:false
      ~callback:editor#text#set_word_wrap;
    factory#add_check_item "Read only" ~active:false
      ~callback:(fun b -> editor#text#set_editable (not b));
    let factory = new GMenu.factory comp_menu ~accel_group in
    factory#add_item "Lex" ~key:_L
      ~callback:(fun () -> Lexical.tag editor#text);
    window#add_accel_group accel_group;
    editor#text#set_vadjustment scrollbar#adjustment;
    if show then self#show ()
end

let _ =
  Main.init ();
  if Array.length Sys.argv >= 2 && Sys.argv.(1) = "-shell" then
    Shell.f ~prog:"ocaml" ~title:"Objective Caml Shell"
  else
    ignore (new editor_window ~show:true ());
  Main.main ()

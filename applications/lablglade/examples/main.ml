open GMain
open GladeMisc

(*  ./lablglade -I ../.. examples/main.ml *)

let _      = GladeMisc.init ()
let window = new GWindow.window border_width: 0
let vbox = new GPack.box `VERTICAL packing:window#add
let menubar = new GMenu.menu_bar packing:(vbox#pack expand:false)
let factory = new GMenu.factory menubar
let accel_group = factory#accel_group
let file_menu = factory#add_submenu label:"File"
let edit_menu = factory#add_submenu label:"Edit"
let view_menu = factory#add_submenu label:"View"
let help_menu = factory#add_submenu label:"Help"

let projwin = new GProjectWindow.project_window packing: vbox#add

let cb_hash = Hashtbl.create size:57

let edit = LglEditor.sig_edit
let editcb () = let oldStr = edit#get_name () in 
                let newStr = GladeProperty.Property.get_combo () in
                if (newStr != "gtk_widget_destroy" && newStr <> oldStr) then
                begin
                  let txt = edit#get_text () in
                  Hashtbl.remove cb_hash key:oldStr;
                  Hashtbl.add cb_hash key:oldStr data:txt;
                  edit#set_name newStr;
                  let newTxt = try
                                  Hashtbl.find cb_hash key:newStr
                               with Not_found -> newStr ^ " = \n" in
                  edit#load_text newTxt
                end

let main () =
  window#connect#event#delete 
    callback:(fun _ -> prerr_endline "Delete event occured"; Main.quit (); true);
  window#connect#destroy callback:Main.quit;
  
  let factory = new GMenu.factory file_menu :accel_group in
  factory#add_item label:"New" callback:projwin#new_project;
  factory#add_item label:"Open..." key:'O' callback:projwin#on_open_project;
  factory#add_item label:"Save" key:'S' callback:projwin#save_project;
  factory#add_item label:"Save As..." key:'A' callback:projwin#on_save_project_as;
  factory#add_separator ();
  factory#add_item label:"Write Source Code..." key:'W' callback:projwin#write_source;
  factory#add_item label:"Project Options..." callback:projwin#edit_options;
  factory#add_separator ();
  factory#add_item label:"Quit" key:'Q' callback:window#destroy;
  
  let factory = new GMenu.factory edit_menu :accel_group in
  factory#add_item label:"Cut" key:'X' callback:projwin#cut;
  factory#add_item label:"Copy" key:'C' callback:projwin#copy;
  factory#add_item label:"Paste" key:'V' callback:projwin#paste;
  factory#add_item label:"Delete" callback:projwin#delete;
  factory#add_separator ();
  factory#add_item label:"Edit Callbacks" callback:editcb;
  
  let factory = new GMenu.factory view_menu :accel_group in
  factory#add_item label:"Show Palette" callback:projwin#show_palette;
  factory#add_item label:"Show Properties" callback:projwin#show_property_editor;
  factory#add_item label:"Show Widget Tree" callback:projwin#show_widget_tree;
  factory#add_item label:"Show Clipboard" callback:projwin#show_clipboard;
  factory#add_check_item label:"Show Widget Tooltips" active:true
    callback:(fun _ -> projwin#toggle_tooltips ());
  let grid_menu = factory#add_submenu label:"Grid" in
  
  let factory = new GMenu.factory grid_menu :accel_group in
  factory#add_check_item label:"Show Grid" active:true
    callback:(fun _ -> projwin#toggle_grid ());
  factory#add_item label:"Set Grid Options..." callback:projwin#edit_grid_settings;
  factory#add_check_item label:"Show Snap to Grid" active:true
    callback:(fun _ -> projwin#toggle_snap ());
  factory#add_item label:"Set Snap Options..." callback:projwin#edit_snap_settings;

  let factory = new GMenu.factory help_menu :accel_group in
  factory#add_item label:"About..." callback:projwin#about;
  window#add_accel_group accel_group;
  projwin#show_palette ();
  projwin#show_property_editor ();
  projwin#show_widget_tree ();
(*  projwin#show_clipboard (); *)
  let proj = GladeProject.Project.create() in
(*  GladeProject.Project.set_source_files proj "gladesrc.ml" "gladesrc.mli"
                                             "gladesig.ml" "gladesig.mli"; *)
  projwin#set_project proj;
  window#show ();
  edit#show ();
  Main.main ()

let _ = Printexc.print main ()


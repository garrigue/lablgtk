open Glib
open GtkBase
open GtkMisc
open GtkButton
open GtkEdit
open Gtk
open GladeGbWidget

let write_fun_hash
    : (string,
       string -> widget Gtk.obj -> parent:string option -> string) Hashtbl.t
    = Hashtbl.create size:17

let source_write_component comp :parent =
    let tyn = Type.name (Object.get_type comp) in
    let default_f txt wid :parent =
        "   (* " ^ txt ^ 
        (match parent with
	   None -> ""
         | Some p -> "(" ^ p ^ ")") ^   
       ": Not (yet) implemented *)\n"  in
    let f   = try Hashtbl.find write_fun_hash key:tyn
              with Not_found -> default_f in
    f tyn comp :parent

let container_subtext wid txt =
    let cont = Container.cast wid in
    let children = List.filter (Container.children cont)
                   pred: (fun c -> not (GbWidget.gb_is_placeholder c)) in
    let subc =  List.map children
                fun:(source_write_component parent:(Some txt))  in
    let subtxt = List.fold_left acc:"" subc
                 fun:(fun :acc str -> (acc ^ str)) in
    subtxt

let pack_text parent = match parent with
                         None -> ""
                       | Some p -> " packing:" ^ p 

let window_source_write txt wid :parent =
    let name = Widget.get_name wid in
    "   let " ^ name ^ " = new GWindow.window in\n"
    ^ (container_subtext wid (name^"#add")) 

let box_source_write dir txt wid :parent =
    let name = Widget.get_name wid in
    "   let " ^ name ^ " = new GPack.box " ^ dir ^ pack_text parent ^ " in\n"
    ^ (container_subtext wid (name^"#add")) 

let wh_text wid =
    let wdata = GbWidget.gb_widget_widget_data wid in
    let flags = GbWidget.gb_widget_data_flags wdata in 
      (if GbWidget.is_flag_set flags GbWidget.gb_width_set then
     	 let width = GbWidget.gb_widget_data_width wdata in
     	 " width:" ^ string_of_int width
       else "")
    ^ (if GbWidget.is_flag_set flags GbWidget.gb_width_set then
         let height = GbWidget.gb_widget_data_height wdata in
         " height:" ^ string_of_int height
       else "")

let xy_text name wid =
    let wdata = GbWidget.gb_widget_widget_data wid in
    let flags = GbWidget.gb_widget_data_flags wdata in
    let txt =
      (if GbWidget.is_flag_set flags GbWidget.gb_x_set then
     	 let x = GbWidget.gb_widget_data_x wdata in
     	 " x:" ^ string_of_int x
       else "")
    ^ (if GbWidget.is_flag_set flags GbWidget.gb_y_set then
         let y = GbWidget.gb_widget_data_y wdata in
         " y:" ^ string_of_int y
       else "") in
    if txt <> "" then    
      "   " ^ name ^ "#misc#set" ^ txt ^ ";\n"
    else ""

let label_source_write txt wid :parent = 
    let name = Widget.get_name wid in
    let lbl  = Label.cast wid in
    let txt = Label.get_text lbl in
    "   let " ^ name ^ " = new GMisc.label text:\"" ^ txt ^ "\""
    ^ wh_text wid 
    ^ pack_text parent ^ " in\n" 
    ^ xy_text name wid

let button_source_write txt wid :parent =
    let name = Widget.get_name wid in
    let btn  = Button.cast wid in
    let chd  = List.hd (Container.children btn) in
    let label_text =  
    	if Type.name (Object.get_type chd) = "GtkLabel"
    	then let lbl = Label.cast chd in
    	     let txt = Label.get_text lbl in
    	     " label:\"" ^ txt ^ "\""
	else "" in
    let subc_text = if label_text = ""
                    then container_subtext wid (name^"#add")
                    else "" in		
    "   let " ^ name ^ " = new GButton.button" ^ label_text 
    ^ wh_text wid 
    ^ pack_text parent ^ " in\n"
    ^ xy_text name wid
    ^ subc_text

let entry_source_write txt wid :parent =     
    let name = Widget.get_name wid in
    let etr = Entry.cast wid in
    let txt = Entry.get_text etr in
    "   let " ^ name ^ " = new GEdit.entry text:\"" ^ txt ^ "\"" 
    ^ wh_text wid 
    ^ pack_text parent ^ " in\n"
    ^ xy_text name wid

let fixed_source_write txt wid :parent =
    let name = Widget.get_name wid in
    "   let " ^ name ^ " = new GPack.fixed" 
    ^ wh_text wid ^ pack_text parent  ^ " in\n"
    ^ xy_text name wid
    ^ (container_subtext wid (name^"#add"))
    
let drawing_area_source_write txt wid :parent =
    let name = Widget.get_name wid in
    "   let " ^ name ^ " = new GMisc.drawing_area" 
    ^ wh_text wid 
    ^ pack_text parent ^ " in\n"
    ^ xy_text name wid
    

let glade_callback_init () =
    Hashtbl.add write_fun_hash key:"GtkWindow"
                data:window_source_write;
    Hashtbl.add write_fun_hash key:"GtkVBox"
                data:(box_source_write "`VERTICAL");
    Hashtbl.add write_fun_hash key:"GtkHBox"
                data:(box_source_write "`HORIZONTAL");
    Hashtbl.add write_fun_hash key:"GtkLabel"
                data:(label_source_write);
    Hashtbl.add write_fun_hash key:"GtkButton"
                data:(button_source_write);
    Hashtbl.add write_fun_hash key:"GtkEntry"
                data:(entry_source_write);
    Hashtbl.add write_fun_hash key:"GtkFixed"
                data:(fixed_source_write);
    Hashtbl.add write_fun_hash key:"GtkDrawingArea"
                data:(drawing_area_source_write)

let rec source_write_rec proj =
   match proj with
       []           -> ""
     | comp :: rest -> source_write_component comp parent:None 
                       ^ source_write_rec rest

let component_show proj =
   let names = List.map proj fun:(fun p -> "   " ^ Widget.get_name p ^ "#show ();\n") in
   List.fold_left names acc:"" fun:(fun :acc b -> acc^b)
   

let source_write proj =
    "open GMain\n\n"
  ^ "(* This program is generated by lablglade *)\n\n"
  ^ "let main () =\n"
  ^ source_write_rec proj
  ^ component_show proj
  ^ "   Main.main () \n\n"
  ^ "let _ = main ()"

 
let _ = Callback.register "source_write" source_write
let _ = glade_callback_init ()
open Misc
open Gtk

class editor = 
   let defs = Hashtbl.create size:57 in
   let window = new GWindow.window title:"Signal Handler" border_width:0 in    
   let vbox = new GPack.box `VERTICAL border_width:5 packing:window#add in
   let hbox = new GPack.box `HORIZONTAL border_width:5 packing:vbox#add in
   let funnm = new GMisc.label justify:`LEFT width:160 text:""
                   packing:vbox#add in
   let textarea = new GEdit.text width:400 editable:true packing:vbox#add in
   let savebtn = new GButton.button label:"Save" packing:hbox#add in
   object (self)
   val window = window
   val name = funnm
   val textarea = textarea
   val savebtn = savebtn
   method get_hash = defs
   method set_name str = name#set_text str
   method get_name () = name#text
   method save_text () =  let b  = self#get_text () in
                          let nm = self#get_name () in
                          Hashtbl.add defs key:nm data:b
   method load_text str = textarea#freeze ();
                          textarea#delete_text start:0 end:textarea#length;
                          textarea#insert str;
			  textarea#set_point 0;
       			  textarea#thaw ()
   method get_text () = textarea#get_chars start:0 end:textarea#length
   method show () = window#show ()
   initializer
     savebtn#connect#clicked callback:(fun () -> self#save_text ()); ()
end

let sig_edit = new editor

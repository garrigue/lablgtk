GtkMain.Main.init ();;

let f_to_string n = 
  let ic = open_in_bin n in 
  let s = ref "" in
    try while true do
      s:= !s ^ (input_line ic) ^ "\n"
    done;
      !s
    with End_of_file -> close_in ic ; !s
    
let t_1 () = 
  let w  = GWindow.window ~title:"1)view" () in
  let t = GText.view ~packing:(w#add) () in
    w#show ();;

let t_2 () = 
  let w = GWindow.window  ~title:"2)view_with_buffer"  () in
  let sw = GBin.scrolled_window ~packing:(w#add) () in
  let b = GText.buffer () in
  let s = f_to_string "test.txt" in
    b#set_text s;
    GText.view ~buffer:b ~packing:(sw#add) ();
    w#show ();;


let t_3 () = 
  let w = GWindow.window  ~title:"3)view_with_buffer"  () in
  let b = GText.buffer () in
    b#set_text  "Bout de mon texte";
    GText.view ~buffer:b ~packing:(w#add) ();
    w#show ();;

let t_4 () = 
  let w = GWindow.window  ~title:"4)set_buffer"  () in
  let b = GText.buffer () in
    b#set_text "Un buffer a priori" ;
    let tv = GText.view ~packing:(w#add) () in
      tv#set_buffer b;
      w#show ();;


let t_5 () = 
  let w = GWindow.window  ~title:"5)get_buffer"  () in
  let tv = GText.view ~packing:(w#add) () in
      tv#get_buffer#set_text "Un nouveau texte";
      w#show ();;

let t_6 () = 
  let w = GWindow.window  ~title:"6)tagtable"  () in
  let tt = GText.tagtable () in
  let tb = GText.buffer ~tagtable:tt ~text:"un certain exemple...." () in
  let tv = GText.view ~buffer:tb ~packing:(w#add) () in
    Printf.printf "Size = %d \n" (tt#size ());
    flush stdout;
    w#show ();;

let t_7 () = 
  let w = GWindow.window  ~title:"7)tag"  () in
  let tt = GText.tag "mon tag one" in
    Printf.printf "Priority = %d \n" (tt#get_priority ());
(*
Not able to set it because not in a tagtable: this is normal
  tt#set_priority 10;
  Printf.printf "Priority = %d \n" (tt#get_priority ());
*)
    flush stdout;
    w#show ();;

let t_8 () = 
  let w = GWindow.window  ~title:"8)tags"  () in
  let t = GText.view ~packing:(w#add) () in
  let tb = t#get_buffer in
  let tt = tb#create_tag ~properties:[ `BACKGROUND "red";
				       `FOREGROUND "blue";
				       `EDITABLE false] () 
  in
    tb#set_text "Un nouveau texte";    
    let start = tb#get_start_iter in
    let stop = tb#get_end_iter in
      tb#apply_tag tt start stop;
      Printf.printf "Je vois :\"%s\"\n"
	(tb#get_text ~include_hidden_chars:true ~start ~stop ());
      flush stdout;
      w#show ();;

let t_9 () = 
  let w = GWindow.window  ~title:"8)tags"  () in
  let t = GText.view ~packing:(w#add) () in
  let tb = t#get_buffer in
    tb#set_text "Un nouveau texte" ;    
    let start = tb#get_start_iter in
    let stop = tb#get_end_iter in
      tb#insert ~text:"1en plus1" ~iter:start ();
      tb#insert ~text:"2en plus2" ~iter:start ();
      tb#insert ~text:"3en plus3" ~iter:tb#get_end_iter ();
      let start = tb#get_start_iter in
      let stop = tb#get_end_iter in
	Printf.printf "Je vois :\"%s\"\n"
 	  (tb#get_text ~include_hidden_chars:true ~start ~stop ());
	flush stdout;
	w#show ();;


let t_10 () = 
  let w = GWindow.window  ~title:"8)tags"  () in
  let t = GText.view ~packing:(w#add) () in
  let tb = t#get_buffer in
    tb#set_text "Un nouveau texte" ;    
    let start = tb#get_start_iter in
    let stop = tb#get_end_iter in
      tb#insert ~text:"1en plus1" ~iter:start ();
      tb#insert ~text:"2en plus2" ~iter:start ();
      tb#insert ~text:"3en plus3" ~iter:tb#get_end_iter ();
      let _ = tb#connect#begin_user_action 
		~callback:(fun () ->   
			     let start = tb#get_start_iter in
			     let stop = tb#get_end_iter  in
			       Printf.printf "Dan cette action je vois :\"%s\"\n"
 				 (tb#get_text ~include_hidden_chars:true ~start ~stop ());
			  flush stdout) 
      in 
	tb#begin_user_action ();
	tb#end_user_action ();
	tb#begin_user_action ();
	tb#end_user_action ();
	tb#begin_user_action ();
	tb#end_user_action ();
	tb#begin_user_action ();
	tb#end_user_action ();
	w#show ();;

let t_11 () = 
  let w = GWindow.window  ~title:"testing fonts"  () in
  let t = GText.view ~packing:(w#add) () in
  let tb = t#get_buffer in
  let font  = Pango.Font.from_string "Fixed 15" in
  let font2  = Pango.Font.from_string "Sans 25" in
  let f  = `FONT_DESC font in
  let f2 = `FONT_DESC font2 in
  let font_tag = tb#create_tag ~properties:[f] () in
  let font_tag2 = tb#create_tag ~properties:[f2] () in
  tb#insert ~tags:[font_tag] ~text:"Un nouveau texte" ();
  t#connect#toggle_overwrite ~callback:
    (fun _ -> tb#insert ~tags:[font_tag] ~text:"Un nouveau texte" () );
  t#connect#toggle_overwrite ~callback:
    (fun _ -> tb#insert ~tags:[font_tag2] ~text:"OH OH" () );
  w#show ();;
    
let t_12 () = 
  let w = GWindow.window  ~title:"testing properties"  () in
  let t = GText.view ~packing:w#add () in
  let tb = t#get_buffer in
  let font  = Pango.Font.from_string "Fixed 15" in
  let font2  = Pango.Font.from_string "Sans 25" in
  let f  = `FONT_DESC font in
  let f2 = `FONT_DESC font2 in

  let f' = `STYLE `ITALIC in
  let f2' = `STYLE `OBLIQUE in
  let tag = tb#create_tag ~properties:[f';f] () in
  let tag2 = tb#create_tag ~properties:[f2';f2] () in
  tb#insert ~tags:[] ~text:"Un nouveau texte" ();
  t#connect#toggle_overwrite ~callback:
    (fun _ -> tb#insert ~tags:[tag] ~text:"<Italic>" () );
  t#connect#toggle_overwrite ~callback:
    (fun _ -> tb#insert ~tags:[tag2] ~text:"<Oblique>" () );
  w#show ();;

(* t_1();t_2 ();t_3();t_4();t_5();t_6();t_7() ; t_8 ; t_9 ; t_10 ;; *)

t_12();;

GMain.Main.main ();;

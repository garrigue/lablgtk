open StdLabels;;

(* GtkMain.Main.init ();; *)

class input_buffer n = object
  val mutable s = String.create n
  val mutable pos = 0
  method clear = pos <- 0
  method input f =
    if String.length s < pos + n then begin
      let s' = String.create (String.length s * 2) in
      String.blit ~src:s ~dst:s' ~src_pos:0 ~dst_pos:0 ~len:pos;
      s <- s'
    end;
    let len = f s pos (String.length s - pos) in
    pos <- pos + len;
    len
  method get =
    String.sub s ~pos:0 ~len:pos
end
      

let f_to_string n = 
  let ic = open_in_bin n in 
  let ib = new input_buffer 1024 in
  begin try
    while ib#input (input ic) > 0 do () done;
  with _ -> ()
  end;
  close_in ic; ib#get
    
let t_1 () = 
  let w  = GWindow.window ~title:"1)view" () in
  let t = GText.view ~packing:(w#add) () in
    w#show ();;

let t_2 () = 
  let w = GWindow.window 
	    ~width:640 ~height:480 ~title:"2)view_with_buffer" ()
  in
  let sw = GBin.scrolled_window ~packing:(w#add) () in
  let b = GText.buffer () in
  let s = f_to_string "test.txt" in
  b#set_text s;
  GText.view ~buffer:b ~packing:(sw#add) ();
  w#show ();;



let t_3 () = 
  let w = GWindow.window  ~title:"3)view_with_buffer"  () in
  let b = GText.buffer () in
  b#set_text "Bout de mon texte";
  GText.view ~buffer:b ~packing:(w#add) ();
  w#show ();;

let t_4 () = 
  let w = GWindow.window  ~title:"4)set_buffer"  () in
  let b = GText.buffer () in
  b#set_text "Un buffer a priori";
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
  let _ = tb#connect#apply_tag 
	    ~callback:(fun tag ~start ~stop ->   
			 Printf.printf "Apply_tag has :\"%s\"\n"
 			 (tb#get_text ~include_hidden:true ~start ~stop ());
			 flush stdout
		      ) 
  in
  let _ = tb#connect#delete_range 
	    ~callback:(fun ~start ~stop ->   
			 Printf.printf "delete_range_tag has :\"%s\"\n"
 			 (tb#get_text ~include_hidden:true ~start ~stop ());
			 flush stdout
		      ) 
  in

  let _ = tb#connect#insert_child_anchor  ~callback:
      (fun ti tca ->
        Printf.printf "insert_child_anchor is there :\"%c\"\n" ti#get_char;
	flush stdout) 
  in
  let _ = tb#connect#insert_text ~callback:
      (fun ti s ->   
	Printf.printf "insert_text is there :'%c' \"%s\"\n" ti#get_char s;
	flush stdout)
  in  
  tb#set_text "Un nouveau texte";
  let start = tb#get_start_iter in
  let stop = tb#get_end_iter in
  let tt =
    tb#create_tag [`BACKGROUND "red"; `FOREGROUND "blue"; `EDITABLE false] in

  Printf.printf "Je vois :\"%s\"\n"
    (tb#get_text ~include_hidden:true ~start ~stop ());
  flush stdout;
  w#show ();;

let t_9 () = 
  let w = GWindow.window  ~title:"8)tags"  () in
  let t = GText.view ~packing:(w#add) () in
  let tb = t#get_buffer in
    tb#set_text "Un nouveau texte";
    let start = tb#get_start_iter in
    let stop = tb#get_end_iter in
      tb#insert ~iter:start "1en plus1";
      tb#insert ~iter:start "2en plus2" ;
      tb#insert ~iter:tb#get_end_iter "3en plus3";
      let start = tb#get_start_iter in
      let stop = tb#get_end_iter in
	Printf.printf "Je vois :\"%s\"\n"
 	  (tb#get_text ~include_hidden:true ~start ~stop ());
	flush stdout;
	w#show ();;


let t_10 () = 
  let w = GWindow.window  ~title:"10)Buffer signals"  () in
  let t = GText.view ~packing:(w#add) () in
  let tb = t#get_buffer in
    tb#set_text "Un nouveau texte";    
    let start = tb#get_start_iter in
    let stop = tb#get_end_iter in
      tb#insert ~iter:start "1en plus1";
      tb#insert ~iter:start "2en plus2";
      tb#insert ~iter:tb#get_end_iter "3en plus3";
      let _ = tb#connect#begin_user_action 
		~callback:(fun () ->   
			     let start = tb#get_start_iter in
			     let stop = tb#get_end_iter in
			       Printf.printf "Dans cette action je vois :\"%s\"\n"
 				 (tb#get_text ~include_hidden:true ~start ~stop ());
			  flush stdout) in 
	tb#begin_user_action ();
	tb#end_user_action ();
	tb#begin_user_action ();
	tb#end_user_action ();
	tb#begin_user_action ();
	tb#end_user_action ();
	tb#begin_user_action ();
	tb#end_user_action ();
	w#show ();;

    
(* t_1();t_2 ();t_3();t_4();t_5();t_6();t_7();t_8;t_9;t_10 ();; *)
t_2 () ;; 

GMain.Main.main ();;

(* $Id$ *)

(* reverse polish calculator *)

open GMain

let wow _ = prerr_endline "Wow!"; ()
let main () =
  let stack = Stack.create () in	

  (* toplevel window *)
  let window =
    new GWindow.window `TOPLEVEL border_width: 10
      title:"Reverse Polish Calculator" in
  window#connect#event#delete
     callback:(fun _ -> prerr_endline "Delete event occured"; false);
  window#connect#destroy callback:Main.quit;


  (* vbox *)
  let vbx = new GPack.box `VERTICAL packing:window#add in

  (* entry *)
  let entry = new GEdit.entry max_length: 20 packing: vbx#add in
  entry#set_text "0";
  entry#set_editable false;

  (* BackSpace, Clear, All Clear, Quit *) 
  let table0 = new GPack.table rows:1 columns:4 packing:vbx#add in
  let bs_clicked _ = begin
    let txt = entry#text in
    let len = String.length txt in 
    if len <= 1 then
      entry#set_text "0"
    else entry#set_text (String.sub txt pos:0 len:(len-1))
  end in
  let c_clicked _ = entry#set_text("0") in
  let ac_clicked _ = Stack.clear stack; entry#set_text("0") in
  let labels0 = [("BS", bs_clicked) ; ("C", c_clicked);
		 ("AC", ac_clicked); ("Quit", window#destroy)] in
  let rec loop0 labels n =
    match labels 
    with  [] -> ()
        | (lbl, cb) :: t  ->
    let button =
      new GButton.button label:lbl packing:(table0#attach left:n top:1) in
    button#connect#clicked callback:cb;
    loop0 t (n+1) in
  loop0 labels0 1;

  (* Numerals *)
  let table1 = new GPack.table rows:4 columns:5 packing:vbx#add in
  let labels1 = ["7"; "8"; "9"; "4"; "5"; "6"; "1"; "2"; "3"; "0"] in
  let numClicked n _ =
     let txt = entry#text in
     if (txt = "0") then
       entry#set_text n
     else begin
       entry#append_text n
     end in
  let rec loop1 labels n =
  	match labels
	with [] -> ()
	   | lbl :: lbls ->
        let button = new GButton.button label:(" "^lbl^" ")
		     packing:(table1#attach left:(n mod 3) top:(n/3)) in
        button#connect#clicked callback:(numClicked lbl);
        loop1 lbls (n+1) in
  loop1 labels1 0; 

  (* Period *)
  let periodClicked _ = 
     let txt = entry#text in
     if (String.contains txt '.') then begin
      	Printf.printf "\a";
        flush stdout;
     end
     else
       entry#append_text "." in
  (new GButton.button label:" . " packing:(table1#attach left:1 top:3))
      #connect#clicked callback:periodClicked;

  (* Enter (Push) *)
  let enterClicked _ =
     let txt = entry#text in
     let n = float_of_string txt in begin
       Stack.push n on:stack;
       entry#set_text "0"
     end in
  (new GButton.button label:"Ent"  packing:(table1#attach left:2 top:3))
     #connect#clicked callback:enterClicked;

  (* Operators *)
  let op2Clicked op _ =
    let n1 = float_of_string (entry#text) in
    let n2 = Stack.pop stack in
    entry#set_text (string_of_float (op n2 n1)) 
  in
  let op1Clicked op _ =
    let n1 = float_of_string (entry#text) in
    entry#set_text (string_of_float (op n1)) 
  in
  let modClicked _ =
    let n1 = int_of_string (entry#text) in
    let n2 = truncate (Stack.pop stack) in
    entry#set_text (string_of_int (n2 mod n1))
  in
  let labels2 = [(" / ", op2Clicked (/.)); (" * ", op2Clicked ( *. ));
		 (" - ", op2Clicked (-.)); (" + ", op2Clicked (+.));
		 ("mod", modClicked); (" ^ ", op2Clicked ( ** ));
		 ("+/-", op1Clicked (~-.));
                 ("1/x", op1Clicked (fun x -> 1.0/.x))] in
  let rec loop2 labels n =
    match labels
    with [] -> ()
       | (lbl, cb) :: t ->
    let button = new GButton.button label:lbl
                 packing:(table1#attach left:(3 + n/4) top: (n mod 4)) in
    button#connect#clicked callback:cb;
    loop2 t (n+1) in
  loop2 labels2 0;

  (* show all and enter event loop *)
  window#show_all ();
  Main.main ()

let _ = Printexc.print main()

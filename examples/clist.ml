(* $Id$ *)

open GMain

let main () =
  let window =
    new GWindow.window title:"CList example" width:300 height:150 in
  window#connect#destroy callback:Main.quit;

  let vbox =
    new GPack.box `VERTICAL border_width:5 packing:window#add in

  let clist =
    new GList.clist titles:["Ingredients";"Amount"] shadow_type:`OUT
      packing:vbox#add in
  clist#connect#select_row callback:
    begin fun :row :column :event ->
      let text = clist#cell_text row column in
      Printf.printf "You selected row %d. More specifically you clicked in column %d, and the text in this cell is %s\n\n" row column text;
      flush stdout
    end;

  let hbox = new GPack.box `HORIZONTAL packing:(vbox#pack expand:false) in

  let button_add = new GButton.button label:"Add List" packing:hbox#add in
  button_add#connect#clicked callback:
    begin fun () ->
      List.iter fun:(fun t -> ignore (clist#append t))
	[ ["Milk"; "3 Oz"];
	  ["Water"; "6 l"];
	  ["Carrots"; "2"];
	  ["Snakes"; "55"] ]
    end;

  let button_clear = new GButton.button label:"Clear List" packing:hbox#add in
  button_clear#connect#clicked callback:clist#clear;

  let button_hide_show =
    new GButton.button label:"Hide/Show titles" packing:hbox#add in
  let flag = ref false in
  button_hide_show#connect#clicked callback:
    begin fun () ->
      clist#set_titles show:!flag;
      flag := not !flag
    end;

  window#show ();
  Main.main ()

let _ = main ()

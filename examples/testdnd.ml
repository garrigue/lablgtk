(* this is a translation in Caml of the gtk+ example testdnd.c  *)


open Misc
open Gtk
open GdkObj
open GPix
open GWindow
open GObj
open GPack
open GButton
open GMisc

(* GtkThread.start() *)

let drag_icon_xpm = [|
"36 48 9 1";
" 	c None";
".	c #020204";
"+	c #8F8F90";
"@	c #D3D3D2";
"#	c #AEAEAC";
"$	c #ECECEC";
"%	c #A2A2A4";
"&	c #FEFEFC";
"*	c #BEBEBC";
"               .....................";
"              ..&&&&&&&&&&&&&&&&&&&.";
"             ...&&&&&&&&&&&&&&&&&&&.";
"            ..&.&&&&&&&&&&&&&&&&&&&.";
"           ..&&.&&&&&&&&&&&&&&&&&&&.";
"          ..&&&.&&&&&&&&&&&&&&&&&&&.";
"         ..&&&&.&&&&&&&&&&&&&&&&&&&.";
"        ..&&&&&.&&&@&&&&&&&&&&&&&&&.";
"       ..&&&&&&.*$%$+$&&&&&&&&&&&&&.";
"      ..&&&&&&&.%$%$+&&&&&&&&&&&&&&.";
"     ..&&&&&&&&.#&#@$&&&&&&&&&&&&&&.";
"    ..&&&&&&&&&.#$**#$&&&&&&&&&&&&&.";
"   ..&&&&&&&&&&.&@%&%$&&&&&&&&&&&&&.";
"  ..&&&&&&&&&&&.&&&&&&&&&&&&&&&&&&&.";
" ..&&&&&&&&&&&&.&&&&&&&&&&&&&&&&&&&.";
"................&$@&&&@&&&&&&&&&&&&.";
".&&&&&&&+&&#@%#+@#@*$%$+$&&&&&&&&&&.";
".&&&&&&&+&&#@#@&&@*%$%$+&&&&&&&&&&&.";
".&&&&&&&+&$%&#@&#@@#&#@$&&&&&&&&&&&.";
".&&&&&&@#@@$&*@&@#@#$**#$&&&&&&&&&&.";
".&&&&&&&&&&&&&&&&&&&@%&%$&&&&&&&&&&.";
".&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&.";
".&&&&&&&&$#@@$&&&&&&&&&&&&&&&&&&&&&.";
".&&&&&&&&&+&$+&$&@&$@&&$@&&&&&&&&&&.";
".&&&&&&&&&+&&#@%#+@#@*$%&+$&&&&&&&&.";
".&&&&&&&&&+&&#@#@&&@*%$%$+&&&&&&&&&.";
".&&&&&&&&&+&$%&#@&#@@#&#@$&&&&&&&&&.";
".&&&&&&&&@#@@$&*@&@#@#$#*#$&&&&&&&&.";
".&&&&&&&&&&&&&&&&&&&&&$%&%$&&&&&&&&.";
".&&&&&&&&&&$#@@$&&&&&&&&&&&&&&&&&&&.";
".&&&&&&&&&&&+&$%&$$@&$@&&$@&&&&&&&&.";
".&&&&&&&&&&&+&&#@%#+@#@*$%$+$&&&&&&.";
".&&&&&&&&&&&+&&#@#@&&@*#$%$+&&&&&&&.";
".&&&&&&&&&&&+&$+&*@&#@@#&#@$&&&&&&&.";
".&&&&&&&&&&$%@@&&*@&@#@#$#*#&&&&&&&.";
".&&&&&&&&&&&&&&&&&&&&&&&$%&%$&&&&&&.";
".&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&.";
".&&&&&&&&&&&&&&$#@@$&&&&&&&&&&&&&&&.";
".&&&&&&&&&&&&&&&+&$%&$$@&$@&&$@&&&&.";
".&&&&&&&&&&&&&&&+&&#@%#+@#@*$%$+$&&.";
".&&&&&&&&&&&&&&&+&&#@#@&&@*#$%$+&&&.";
".&&&&&&&&&&&&&&&+&$+&*@&#@@#&#@$&&&.";
".&&&&&&&&&&&&&&$%@@&&*@&@#@#$#*#&&&.";
".&&&&&&&&&&&&&&&&&&&&&&&&&&&$%&%$&&.";
".&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&.";
".&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&.";
".&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&.";
"...................................." |]



let trashcan_closed_xpm = [|
"64 80 17 1";
" 	c None";
".	c #030304";
"+	c #5A5A5C";
"@	c #323231";
"#	c #888888";
"$	c #1E1E1F";
"%	c #767677";
"&	c #494949";
"*	c #9E9E9C";
"=	c #111111";
"-	c #3C3C3D";
";	c #6B6B6B";
">	c #949494";
",	c #282828";
"'	c #808080";
")	c #545454";
"!	c #AEAEAC";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                       ==......=$$...===                        ";
"                 ..$------)+++++++++++++@$$...                  ";
"             ..=@@-------&+++++++++++++++++++-....              ";
"          =.$$@@@-&&)++++)-,$$$$=@@&+++++++++++++,..$           ";
"         .$$$$@@&+++++++&$$$@@@@-&,$,-++++++++++;;;&..          ";
"        $$$$,@--&++++++&$$)++++++++-,$&++++++;%%'%%;;$@         ";
"       .-@@-@-&++++++++-@++++++++++++,-++++++;''%;;;%*-$        ";
"       +------++++++++++++++++++++++++++++++;;%%%;;##*!.        ";
"        =+----+++++++++++++++++++++++;;;;;;;;;;;;%'>>).         ";
"         .=)&+++++++++++++++++;;;;;;;;;;;;;;%''>>#>#@.          ";
"          =..=&++++++++++++;;;;;;;;;;;;;%###>>###+%==           ";
"           .&....=-+++++%;;####''''''''''##'%%%)..#.            ";
"           .+-++@....=,+%#####'%%%%%%%%%;@$-@-@*++!.            ";
"           .+-++-+++-&-@$$=$=......$,,,@;&)+!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           =+-++-+++-+++++++++!++++!++++!+++!++!+++=            ";
"            $.++-+++-+++++++++!++++!++++!+++!++!+.$             ";
"              =.++++++++++++++!++++!++++!+++!++.=               ";
"                 $..+++++++++++++++!++++++...$                  ";
"                      $$=.............=$$                       ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                "  |]

let trashcan_open_xpm = [|
"64 80 17 1";
" 	c None";
".	c #030304";
"+	c #5A5A5C";
"@	c #323231";
"#	c #888888";
"$	c #1E1E1F";
"%	c #767677";
"&	c #494949";
"*	c #9E9E9C";
"=	c #111111";
"-	c #3C3C3D";
";	c #6B6B6B";
">	c #949494";
",	c #282828";
"'	c #808080";
")	c #545454";
"!	c #AEAEAC";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                      .=.==.,@                  ";
"                                   ==.,@-&&&)-=                 ";
"                                 .$@,&++;;;%>*-                 ";
"                               $,-+)+++%%;;'#+.                 ";
"                            =---+++++;%%%;%##@.                 ";
"                           @)++++++++;%%%%'#%$                  ";
"                         $&++++++++++;%%;%##@=                  ";
"                       ,-++++)+++++++;;;'#%)                    ";
"                      @+++&&--&)++++;;%'#'-.                    ";
"                    ,&++-@@,,,,-)++;;;'>'+,                     ";
"                  =-++&@$@&&&&-&+;;;%##%+@                      ";
"                =,)+)-,@@&+++++;;;;%##%&@                       ";
"               @--&&,,@&)++++++;;;;'#)@                         ";
"              ---&)-,@)+++++++;;;%''+,                          ";
"            $--&)+&$-+++++++;;;%%'';-                           ";
"           .,-&+++-$&++++++;;;%''%&=                            ";
"          $,-&)++)-@++++++;;%''%),                              ";
"         =,@&)++++&&+++++;%'''+$@&++++++                        ";
"        .$@-++++++++++++;'#';,........=$@&++++                  ";
"       =$@@&)+++++++++++'##-.................=&++               ";
"      .$$@-&)+++++++++;%#+$.....................=)+             ";
"      $$,@-)+++++++++;%;@=........................,+            ";
"     .$$@@-++++++++)-)@=............................            ";
"     $,@---)++++&)@===............................,.            ";
"    $-@---&)))-$$=..............................=)!.            ";
"     --&-&&,,$=,==...........................=&+++!.            ";
"      =,=$..=$+)+++++&@$=.............=$@&+++++!++!.            ";
"           .)-++-+++++++++++++++++++++++++++!++!++!.            ";
"           .+-++-+++++++++++++++++++++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!+++!!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           .+-++-+++-+++++++++!++++!++++!+++!++!++!.            ";
"           =+-++-+++-+++++++++!++++!++++!+++!++!+++=            ";
"            $.++-+++-+++++++++!++++!++++!+++!++!+.$             ";
"              =.++++++++++++++!++++!++++!+++!++.=               ";
"                 $..+++++++++++++++!++++++...$                  ";
"                      $$==...........==$$                       ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                ";
"                                                                "  |]

let window = new window show:true

let drag_icon = new pixmap_from_xpm_d data:drag_icon_xpm
    window:window#misc#window

let trashcan_open = new pixmap_from_xpm_d data:trashcan_open_xpm
    window:window#misc#window

let trashcan_closed = new pixmap_from_xpm_d data:trashcan_closed_xpm
    window:window#misc#window

let target_table = [|
  { target = "STRING"; flags = []; info = 0};
  { target = "text/plain"; flags = []; info = 0};
  { target = "text/uri-list"; flags = []; info = 2};
  { target = "application/x-rootwin-drop"; flags = []; info = 1}  |]


let have_drag = ref false

let target_drag_leave (pixmap : pixmap) _ _ =
  print_string "leave\n"; flush stdout;
  have_drag := false;
  pixmap#set_pixmap trashcan_closed

let target_drag_motion (pixmap : pixmap) (context : drag_context) x y time =
  if not !have_drag then begin
    have_drag := true;
    pixmap#set_pixmap trashcan_open
  end;
  let source_typename =
    try
      let source_widget =  context#get_source_widget in
      GtkBase.Type.name source_widget#get_type
    with Null_pointer -> "unknown"
  in
  Printf.printf "motion, source %s\n" source_typename; flush stdout;
  context#status [context#suggested_action] time;
  true

let target_drag_drop (pixmap : pixmap) (context : drag_context) x y time =
  Printf.printf "drop\n"; flush stdout;
  have_drag := false;
  pixmap#set_pixmap trashcan_closed;
  match context#targets with
  | [] -> false
  | d :: _ -> pixmap#misc#drag#get_data context#context target:d :time; true

let target_drag_data_received _ (context : drag_context) _ _ (data : selection_data) _ time =
  if (data#length >= 0) && (data#format = 8) then begin
    Printf.printf "Received \"%s\" in trashcan\n" data#data;
    flush stdout;
    context#finish success:true del:false :time
  end
  else context#finish success:false del:false :time

let label_drag_data_received _ (context : drag_context) _ _ (data : selection_data) _ time =
    if (data#length >= 0) && (data#format = 8) then  begin
    Printf.printf "Received \"%s\" in label\n" data#data;
    flush stdout;
    context#finish success:true del:false :time
  end
  else context#finish success:false del:false :time

let source_drag_data_get _ (data : selection_data) info _ =
  if (info = 1) then begin
    Printf.printf "I was dropped on the rootwin\n";
    flush stdout
  end
  else if info = 2 then
    data#set type:data#target format:8 "file:///home/otaylor/images/weave.png" length:37
  else
    data#set type:data#target format:8 "I'm Data!" length:9

let source_drag_data_delete _ =
  Printf.printf "Delete the data!\n"; flush stdout

let popup_window = ref (None : window option)
let popped_up = ref false
let in_popup = ref false
let popdown_timer = ref None
let popup_timer = ref None

let popdown_cb _ =
  popdown_timer := None;
  begin match !popup_window with
  | None -> failwith "bug: popdown_cb"
  | Some w -> w#misc#hide () end;
  popped_up := false;
  false

let popup_motion _ _ _ _ =
  if not !in_popup then begin
    in_popup := true;
    match !popdown_timer with
    | Some pdt ->
      Printf.printf "removed popdown\n"; flush stdout;
      GtkMain.Timeout.remove pdt;
      popdown_timer := None
    | None -> ()
  end;
  true

let popup_leave _ _ =
  if !in_popup then begin
    in_popup := false;
    match !popdown_timer with
    | None -> Printf.printf "added popdown\n"; flush stdout;
	popdown_timer := Some (GtkMain.Timeout.add 500 callback:popdown_cb)
    | Some _ -> ()
  end

let popup_cb _ =
  if not !popped_up then begin
    begin match !popup_window with
    | None ->
	let w = new window type:`POPUP position:`MOUSE in
	popup_window := Some w;
	let table = new table rows:3 columns:3 packing:w#add in
	for i = 0 to 2 do
	  for j = 0 to 2 do
	    let button = new button label:((string_of_int i) ^ "," ^
					   (string_of_int j)) in
	    table#attach button left:i top:j;
	    button#misc#drag#dest_set [`ALL] target_table 3 [`COPY; `MOVE ];
	    button#connect#drag#motion callback:popup_motion;
	    button#connect#drag#leave callback:popup_leave;
	  done
	done;
    | Some _ -> ()
    end;
    begin match !popup_window with
    | None -> failwith "bug popup_cb"
    | Some w -> w#show() end;
    popped_up := true
  end;
  popdown_timer := Some (GtkMain.Timeout.add 500 callback:popdown_cb);
  Printf.printf "added popdown\n"; flush stdout;
  popup_timer := None;
  false

let popsite_motion _ _ _ _ =
  begin match !popup_timer with
  | None -> Printf.printf "added popdown\n"; flush stdout;
      popup_timer := Some (GtkMain.Timeout.add 500 callback:popup_cb)
  | Some _ -> ()
  end;
  true

let popsite_leave _ _ =
  match !popup_timer with
  | Some pdt -> GtkMain.Timeout.remove pdt;
      popup_timer := None
  | None -> ()


let main () =
  window # connect # destroy callback: GMain.Main.quit;;
  let table = new table rows:2 columns:2 packing:window#add in
  let label = new label text:"Drop Here\n" in
  label#misc#drag#dest_set [`ALL] target_table 3 [`COPY; `MOVE ];
  label#connect#drag#data_received callback:(label_drag_data_received ());
  table#attach label left:0 top:0;
  let label = new label text:"Popup\n" in
  label#misc#drag#dest_set [`ALL] target_table 3 [`COPY; `MOVE ];
  table#attach label left:1 top:1;
  label#connect#drag#motion callback:popsite_motion;
  label#connect#drag#leave callback:popsite_leave;
 
  let pixmap = new pixmap trashcan_closed in
  pixmap#misc#drag#dest_set [] [| |] 0 [];
  table#attach pixmap left:1 top:0;
  pixmap#connect#drag#leave callback:(target_drag_leave pixmap);
  pixmap#connect#drag#motion callback:(target_drag_motion pixmap);
  pixmap#connect#drag#drop callback:(target_drag_drop pixmap);
  pixmap#connect#drag#data_received callback:(target_drag_data_received pixmap);

  let button = new button label:"Drag Here\n" in
  button#misc#drag#source_set mod:[`BUTTON1; `BUTTON3 ] target_table 4 [`COPY; `MOVE ];
  button#misc#drag#source_set_icon drag_icon
    colormap:window#misc#style#colormap;
  table#attach button left:0 top:1;
  button#connect#drag#data_get callback:source_drag_data_get;
  button#connect#drag#data_delete callback:source_drag_data_delete;
;;


main ();;

GMain.Main.main ()



	    

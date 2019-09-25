(**************************************************************************)
(*    Lablgtk - Examples                                                  *)
(*                                                                        *)
(*    This code is in the public domain.                                  *)
(*    You may freely copy parts of it in your application.                *)
(*                                                                        *)
(**************************************************************************)

(* $Id$ *)

(* これを実行する前にLC_ALL=ja_JP.EUCなどと指定しなければならない *)

let _ = GMain.init ()
let window = GWindow.window ()
let box = GPack.vbox ~packing: window#add ()
let text = GText.view ~packing: box#add ()
let button = GButton.button ~label: "終了" ~packing: box#add ()
let label = GMisc.label ~text:"これには影響しない" ~packing: box#add ()

let _ =
  window#connect#destroy ~callback:GMain.quit;
  text#buffer#insert "こんにちは";
  text#misc#set_size_chars ~width:20 ~height:5 ();
  let style = button#misc#style#copy in
  button#misc#set_style style;
  style#set_bg [`NORMAL,`NAME "green"; `PRELIGHT,`NAME "red"];
  button#connect#clicked ~callback:GMain.quit

let _ =
  window#show ();
  GMain.main ()

(* $Id$ *)

(* これを実行する前にLANG=ja_JP.EUCなどと指定しなければならない *)

(* cut-and-paste も対応していますが、editはうまくいきません *)

open Gtk
open GtkObj

let window = new_window `TOPLEVEL
let box = new_box `VERTICAL
let text = new_text ()
let font = Gdk.Font.load_fontset
    "-misc-fixed-medium-r-normal--14-*-c-70-iso8859-1, \
     -misc-fixed-medium-r-normal--14-*-jisx0208.1983-0, \
     -misc-fixed-medium-r-normal--14-*-jisx0201.1976-0"

let _ =
  window#connect#destroy callback:Main.quit;
  window#add box;
  box#add text;
  text#misc#realize ();
  text#insert "こんにちは" :font;
  text#set editable:true;
  let button = new_button label:"終了" in
  let style = button#misc#style in
  Style.set style :font;
  Style.set_bg style color:(Gdk.Color.alloc (`Name "green"));
  box#add button;
  button#connect#clicked callback:Main.quit;
  let l = new_label label:"これにも影響する" in
  box#add l

let _ =
  window#show_all ();
  Main.main ()

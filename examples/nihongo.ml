(* $Id$ *)

(* これを実行する前にLANG=ja_JP.EUCなどと指定しなければならない *)

(* cut-and-paste も対応していますが、editはうまくいきません *)

open GtkObj

let window = new_window `TOPLEVEL
let box = new_box `VERTICAL packing: window#add
let text = new_text () editable: true packing: box#add
let font = Gdk.Font.load_fontset
    "-misc-fixed-medium-r-normal--14-*-c-70-iso8859-1, \
     -misc-fixed-medium-r-normal--14-*-jisx0208.1983-0, \
     -misc-fixed-medium-r-normal--14-*-jisx0201.1976-0"
let button = new_button label: "終了" packing: box#add
let label = new_label label:"これにも影響する" packing: box#add

let _ =
  window#connect#destroy callback:Main.quit;
  text#misc#realize ();
  text#insert "こんにちは" :font;
  let style = button#misc#style in
  Gtk.Style.set style :font;
  Gtk.Style.set_bg style color:(Gdk.Color.alloc (`NAME "green"));
  button#connect#clicked callback:Main.quit

let _ =
  window#show_all ();
  Main.main ()

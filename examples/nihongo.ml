(* $Id$ *)

(* これを実行する前にLANG=ja_JP.EUCなどと指定しなければならない *)

(* cut-and-paste も対応していますが、editはうまくいきません *)

open Gtk

let window = Window.create `TOPLEVEL
let text = Text.create ()
let font = Gdk.Font.load_fontset
    "-misc-fixed-medium-r-normal--14-*-c-70-iso8859-1, \
     -misc-fixed-medium-r-normal--14-*-jisx0208.1983-0, \
     -misc-fixed-medium-r-normal--14-*-jisx0201.1976-0"

let _ =
  Signal.connect window sig:Object.Sig.destroy cb:Main.quit;
  Container.add window text;
  Widget.realize text;
  Text.insert text "こんにちは" :font;
  Text.set_editable text true

let _ =
  Widget.show_all window;
  Main.main ()

(* $Id$ *)

(* これを実行する前にLANG=ja_JP.EUCなどと指定しなければならない *)

(* cut-and-paste も対応していますが、editはうまくいきません *)

open Gtk

let window = Window.create `TOPLEVEL
let box = Box.create `VERTICAL
let text = Text.create ()
let font = Gdk.Font.load_fontset
    "-misc-fixed-medium-r-normal--14-*-c-70-iso8859-1, \
     -misc-fixed-medium-r-normal--14-*-jisx0208.1983-0, \
     -misc-fixed-medium-r-normal--14-*-jisx0201.1976-0"

let _ =
  Signal.connect window sig:Object.Sig.destroy cb:Main.quit;
  Container.add window box;
  Container.add box text;
  Widget.realize text;
  Text.insert text "こんにちは" :font;
  Text.set_editable text true;
  let button = Button.create label:"終了" in
  let style = Widget.get_style button in
  Style.set style :font;
  Container.add box button;
  Signal.connect button sig:Button.Sig.clicked cb:Main.quit

let _ =
  Widget.show_all window;
  Main.main ()

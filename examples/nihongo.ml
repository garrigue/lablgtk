(* $Id$ *)

(* これを実行する前にLANG=ja_JP.EUCなどと指定しなければならない *)

(* cut-and-paste も対応していますが、editはうまくいきません *)

open Gtk

let window = Window.create `TOPLEVEL
let text = Text.create ()
let font = Gdk.Font.load_fontset "*-fixed-*--14-*"

let _ =
  Signal.connect window sig:Signal.delete_event
    cb:(fun _ -> Main.quit (); false);
  Container.add window text;
  Widget.realize text;
  Text.insert text "こんにちは" :font

let _ =
  Widget.show_all window;
  Main.main ()

(* $Id$ *)

open Gtk;;

let hello l = print_endline "Hello World"; Arg.Unit ;;

let args = ref [] ;;
let delete_event l =
  args := l;;
  print_endline "Delete event occured";
  Arg.Bool true
;;

let destroy l = Main.quit (); Arg.Unit ;;

Main.init Sys.argv;;

let window = Window.create `TOPLEVEL;;

Signal.connect window name:"delete_event" cb:delete_event ;;
Signal.connect window name:"destroy" cb:destroy ;;

Container.border_width window 10 ;;

let button = Button.create_with_label "Hello World" ;;

Signal.connect button name:"clicked" cb:hello ;;
Signal.connect button name:"clicked"
    cb:(fun _ -> Widget.destroy window; Arg.Unit) ;;

Container.add window button ;;

Widget.show_all window ;;

Main.main () ;;

(* $Id$ *)

open Gtk

let main () =

  let window = Window.create `TOPLEVEL in
  Window.Connect.destroy window cb:Main.quit;
  Window.set_title window "radio buttons";
  Window.border_width window 0;

  let box1 = Box.create `VERTICAL in
  Box.add window box1;

  let box2 = Box.create `VERTICAL spacing:10 in
  Box.border_width box2 10;
  Box.pack box1 box2;

  let button1 = RadioButton.create `none label:"button1" in
  Box.pack box2 button1;

  let button2 = RadioButton.create (`widget button1) label:"button2" in
  RadioButton.set button2 state:true;
  Box.pack box2 button2;

  let button3 = RadioButton.create (`widget button1) label:"button3" in
  Box.pack box2 button3;

  let separator = Separator.create `HORIZONTAL in
  Box.pack box1 separator expand:false;
  
  let box3 = Box.create `VERTICAL spacing:10 in
  Box.border_width box3 10;
  Box.pack box1 box3 expand:false;

  let button = Button.create_with_label "close" in
  Button.Connect.clicked button cb:Main.quit;
  Box.pack box3 button;
  Widget.set button can_default:true;
  Widget.grab_default button;

  Widget.show_all window;

  Main.main ()

let _ = main ()

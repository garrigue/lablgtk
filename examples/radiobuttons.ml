(* $Id$ *)

open Gtk

let main () =

  let window = Window.create `TOPLEVEL in
  Signal.connect window sig:Object.Sig.destroy cb:Main.quit;
  Window.set_title window "radio buttons";
  Container.border_width window 0;

  let box1 = Box.create `VERTICAL in
  Container.add window box1;
  Widget.show box1;

  let box2 = Box.create `VERTICAL spacing:10 in
  Container.border_width box2 10;
  Box.pack box1 box2;
  Widget.show box2;

  let button1 = RadioButton.create `none label:"button1" in
  Box.pack box2 button1;
  Widget.show button1;

  let button2 = RadioButton.create (`widget button1) label:"button2" in
  ToggleButton.set_state button2 true;
  Box.pack box2 button2;
  Widget.show button2;

  let button3 = RadioButton.create (`widget button1) label:"button3" in
  Box.pack box2 button3;
  Widget.show button3;

  let separator = Separator.create `HORIZONTAL in
  Box.pack box1 separator expand:false;
  Widget.show separator;
  
  let box3 = Box.create `VERTICAL spacing:10 in
  Container.border_width box3 10;
  Box.pack box1 box3 expand:false;
  Widget.show box3;

  let button = Button.create_with_label "close" in
  Signal.connect button sig:Button.Sig.clicked cb:Main.quit;
  Box.pack box3 button;
  Widget.set button can_default:true;
  Widget.grab_default button;
  Widget.show button;
  Widget.show window;

  Main.main ()

let _ = main ()

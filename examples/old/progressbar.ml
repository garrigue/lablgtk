(* $Id$ *)

open Gtk

class bar bar = object
  val bar : ProgressBar.t obj= bar
  val mutable pstat = true
  method progress =
    let pvalue = ProgressBar.percent bar in
    let pvalue =
      if pvalue >= 1.0 || not pstat then (pstat <- true; 0.0)
      else pvalue +. 0.01
    in
    ProgressBar.update bar percent:pvalue;
    true
  method progress_r =
    pstat <- false
end

let main () =

  let window = Window.create `TOPLEVEL in
  Signal.connect window sig:Object.Sig.destroy cb:Main.quit;
  Container.border_width window 10;

  let table = Table.create 3 2 in
  Container.add window table;
  
  let label = Label.create "Progress Bar Example" in
  Table.attach table label left:0 right:2 top:0 expand:`x shrink:`both;
  Widget.show label;
  
  let pbar = ProgressBar.create () in
  Table.attach table pbar left:0 right:2 top:1 fill:`x shrink:`both;
  Widget.show pbar;

  let bar = new bar pbar in
  let ptimer = Timeout.add 100 cb:(fun () -> bar#progress) in

  let button = Button.create_with_label "Reset" in
  Signal.connect button sig:Button.Sig.clicked cb:(fun () -> bar#progress_r);
  Table.attach table button left:0 top:2 expand:`none fill:`x shrink:`both;
  Widget.show button;

  let button = Button.create_with_label "Cancel" in
  Signal.connect button sig:Button.Sig.clicked cb:Main.quit;
  Table.attach table button left:1 top:2 expand:`none fill:`x shrink:`both;
  Widget.show button;

  Widget.show table;
  Widget.show window


let _ =
  main ();
  Main.main ()
